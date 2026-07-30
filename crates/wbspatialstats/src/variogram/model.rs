//! Variogram model fitting (Spherical, Exponential, Gaussian)

use crate::{GeostatError, GeostatResult};
use nalgebra::{Matrix3, Vector3};
use serde::{Deserialize, Serialize};

use super::robust::{RobustLossFunction, RobustVariogramFitter};
use super::LagBin;

/// Supported variogram model families
#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq)]
pub enum VariogramModelFamily {
    Spherical,
    Exponential,
    Gaussian,
}

impl std::fmt::Display for VariogramModelFamily {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            VariogramModelFamily::Spherical => write!(f, "Spherical"),
            VariogramModelFamily::Exponential => write!(f, "Exponential"),
            VariogramModelFamily::Gaussian => write!(f, "Gaussian"),
        }
    }
}

/// Fitted variogram model with nugget, sill, range
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct VariogramModel {
    pub family: VariogramModelFamily,
    /// Nugget effect (variance at distance 0)
    pub nugget: f64,
    /// Partial sill (total sill - nugget)
    pub partial_sill: f64,
    /// Range parameter (practical range)
    pub range: f64,
    /// Model fit quality (weighted residual sum of squares)
    pub wrss: f64,
    /// Condition number of fit system
    pub condition_number: f64,
}

impl VariogramModel {
    /// Evaluate variogram at distance h
    pub fn evaluate(&self, h: f64) -> f64 {
        if h == 0.0 {
            return self.nugget;
        }

        let gamma_part = match self.family {
            VariogramModelFamily::Spherical => {
                if h >= self.range {
                    self.partial_sill
                } else {
                    let ratio = h / self.range;
                    self.partial_sill * (1.5 * ratio - 0.5 * ratio.powi(3))
                }
            }
            VariogramModelFamily::Exponential => {
                self.partial_sill * (1.0 - (-3.0 * h / self.range).exp())
            }
            VariogramModelFamily::Gaussian => {
                self.partial_sill * (1.0 - (-3.0 * (h / self.range).powi(2)).exp())
            }
        };

        self.nugget + gamma_part
    }

    /// Total sill (nugget + partial sill)
    pub fn total_sill(&self) -> f64 {
        self.nugget + self.partial_sill
    }

    pub fn summary(&self) -> String {
        format!(
            "{} model: nugget={:.4}, sill={:.4}, range={:.2}, wrss={:.6}, κ={:.2e}",
            self.family,
            self.nugget,
            self.total_sill(),
            self.range,
            self.wrss,
            self.condition_number
        )
    }
}

/// Variogram model fitter
pub struct VariogramFitter;

impl VariogramFitter {
    /// Fit variogram model to empirical lags using weighted least-squares.
    ///
    /// Uses a Marquardt-Levenberg (iterative Gauss-Newton) algorithm with
    /// analytic Jacobians, matching gstat's default fit.method=7 weighting
    /// scheme: `wᵢ = nₕ(i) / hᵢ`.
    ///
    /// Initialization follows gstat's `vgm_fill_na()`:
    /// - nugget  = mean of first 3 empirical semivariances
    /// - sill    = mean of last 5 empirical semivariances
    /// - range   = max_lag_distance / 3
    pub fn fit(lags: &[LagBin], family: VariogramModelFamily) -> GeostatResult<VariogramModel> {
        if lags.len() < 3 {
            return Err(GeostatError::InsufficientData(
                "at least 3 lag bins required for fitting".to_string(),
            ));
        }

        let n = lags.len();

        // Initialization following gstat's vgm_fill_na():
        // nugget  = mean of first 3 empirical semivariances
        // sill    = mean of last 5 empirical semivariances
        // range   = max_lag / 3
        let first3 =
            lags[..3.min(n)].iter().map(|l| l.semivariance).sum::<f64>() / (3.min(n) as f64);
        let last5 = lags[n.saturating_sub(5)..]
            .iter()
            .map(|l| l.semivariance)
            .sum::<f64>()
            / (5.min(n) as f64);
        let max_dist = lags
            .iter()
            .map(|l| l.distance)
            .fold(f64::NEG_INFINITY, f64::max);

        let nugget_init = first3.max(0.0);
        let psill_init = (last5 - nugget_init).max(1.0);
        let range_init = max_dist / 3.0;

        let (nugget, partial_sill, range) =
            Self::optimize_parameters(lags, family, nugget_init, psill_init, range_init)?;

        let (wrss, condition_number) =
            Self::compute_fit_metrics(lags, family, nugget, partial_sill, range);

        Ok(VariogramModel {
            family,
            nugget: nugget.max(0.0),
            partial_sill: partial_sill.max(0.0),
            range: range.max(0.1),
            wrss,
            condition_number,
        })
    }

    /// Fit variogram model using L¹ loss (robust to outliers)
    ///
    /// Minimizes: Σ w_i * |model(h_i) - empirical(h_i)|
    /// where w_i = sqrt(pair_count_i)
    pub fn fit_l1(lags: &[LagBin], family: VariogramModelFamily) -> GeostatResult<VariogramModel> {
        RobustVariogramFitter::fit(lags, family, RobustLossFunction::L1)
    }

    /// Fit variogram model using Huber loss (smooth robust alternative)
    ///
    /// Combines L² for small residuals and L¹ for large residuals with smooth transition.
    /// Delta parameter controls the transition threshold (default 0.5).
    ///
    /// # Arguments
    /// * `delta` - Huber loss transition threshold (must be > 0)
    pub fn fit_huber(
        lags: &[LagBin],
        family: VariogramModelFamily,
        delta: f64,
    ) -> GeostatResult<VariogramModel> {
        RobustVariogramFitter::fit(lags, family, RobustLossFunction::Huber(delta))
    }

    /// Marquardt-Levenberg (iterative Gauss-Newton) optimizer for variogram parameters.
    ///
    /// Matches gstat's `wls_fit()` / `fit_GaussNewton()` algorithm:
    /// - Analytic Jacobian w.r.t. nugget, partial_sill, range
    /// - Weight scheme: `nₕ(i) / hᵢ`  (gstat fit.method = 7)
    /// - 20% step-size bound per iteration (Marquardt damping)
    /// - If any parameter is 0 at start, bump to avoid degenerate Jacobian
    /// - Convergence: relative change in SSErr < 1e-5 (gstat DEF_fit_limit)
    fn optimize_parameters(
        lags: &[LagBin],
        family: VariogramModelFamily,
        nugget_init: f64,
        partial_sill_init: f64,
        range_init: f64,
    ) -> GeostatResult<(f64, f64, f64)> {
        const MAX_ITER: usize = 200;
        const CONV_TOL: f64 = 1e-5;
        const MAX_STEP_FRAC: f64 = 0.20;

        // Bump any zero sill to 1.0 to avoid degenerate Jacobian (gstat src/fit.c:44-46)
        let mut c0 = if nugget_init == 0.0 { 1.0 } else { nugget_init };
        let mut c1 = if partial_sill_init == 0.0 {
            1.0
        } else {
            partial_sill_init
        };
        let mut a = range_init.max(0.1);

        let mut prev_sse = f64::INFINITY;

        for _ in 0..MAX_ITER {
            let mut jtj = Matrix3::<f64>::zeros();
            let mut jtr = Vector3::<f64>::zeros();
            let mut sse = 0.0;

            for lag in lags {
                let h = lag.distance;
                if h == 0.0 {
                    continue;
                }

                // Weight: nₕ / h  (gstat fit.method=7, WLS_NHH)
                let w = lag.pair_count as f64 / h;

                let gamma_model = Self::evaluate_model(h, family, c0, c1, a);
                let residual = lag.semivariance - gamma_model;
                sse += w * residual * residual;

                // Jacobian columns: d(gamma)/d(c0), d(gamma)/d(c1), d(gamma)/d(a)
                let j_c0 = 1.0; // nugget contributes +1 to all h > 0
                let (j_c1, j_a) = Self::model_derivatives(h, family, c1, a);
                let j = Vector3::new(j_c0, j_c1, j_a);

                jtj += w * j * j.transpose();
                jtr += w * residual * j;
            }

            // Convergence: relative change in SSErr (gstat criterion)
            let rel_step = (prev_sse - sse) / sse.max(f64::EPSILON);
            if rel_step.abs() < CONV_TOL && prev_sse.is_finite() {
                break;
            }
            prev_sse = sse;

            // Solve J'WJ Δβ = J'Wr via QR
            let delta = match jtj.qr().solve(&jtr) {
                Some(d) => d,
                None => break, // singular system; keep current params
            };

            // Marquardt step-size bound: clamp to 20% of current parameter norm
            let param_norm = (c0 * c0 + c1 * c1 + a * a).sqrt().max(f64::EPSILON);
            let step_norm = delta.norm();
            let scale = if step_norm > MAX_STEP_FRAC * param_norm {
                MAX_STEP_FRAC * param_norm / step_norm
            } else {
                1.0
            };

            // Update with positivity constraints
            c0 = (c0 + scale * delta[0]).max(0.0);
            c1 = (c1 + scale * delta[1]).max(0.0);
            a = (a + scale * delta[2]).max(0.1);
        }

        Ok((c0, c1, a))
    }

    /// Analytic partial derivatives of γ(h) w.r.t. partial_sill (c₁) and range (a).
    ///
    /// Returns (∂γ/∂c₁, ∂γ/∂a). The nugget derivative ∂γ/∂c₀ = 1 everywhere.
    pub(super) fn model_derivatives(
        h: f64,
        family: VariogramModelFamily,
        partial_sill: f64,
        range: f64,
    ) -> (f64, f64) {
        if h == 0.0 {
            return (0.0, 0.0);
        }
        match family {
            VariogramModelFamily::Spherical => {
                if h >= range {
                    // γ = c₀ + c₁ (constant beyond range, no range derivative)
                    (1.0, 0.0)
                } else {
                    let ratio = h / range;
                    // γ = c₀ + c₁*(1.5*(h/a) - 0.5*(h/a)³)
                    let j_c1 = 1.5 * ratio - 0.5 * ratio.powi(3);
                    // ∂γ/∂a = c₁ * (-1.5*h/a² + 1.5*h³/a⁴)
                    //       = c₁ * 1.5 * (h/a²) * ((h/a)² - 1)
                    let j_a = partial_sill * 1.5 * (h / range.powi(2)) * (ratio.powi(2) - 1.0);
                    (j_c1, j_a)
                }
            }
            VariogramModelFamily::Exponential => {
                // γ = c₀ + c₁*(1 - exp(-3h/a))
                let exp_val = (-3.0 * h / range).exp();
                let j_c1 = 1.0 - exp_val;
                // ∂γ/∂a = c₁ * (3h/a²) * (-exp(-3h/a))
                let j_a = -partial_sill * (3.0 * h / range.powi(2)) * exp_val;
                (j_c1, j_a)
            }
            VariogramModelFamily::Gaussian => {
                // γ = c₀ + c₁*(1 - exp(-3*(h/a)²))
                let ratio_sq = (h / range).powi(2);
                let exp_val = (-3.0 * ratio_sq).exp();
                let j_c1 = 1.0 - exp_val;
                // ∂γ/∂a = c₁ * (6h²/a³) * (-exp(-3*(h/a)²))
                let j_a = -partial_sill * (6.0 * h.powi(2) / range.powi(3)) * exp_val;
                (j_c1, j_a)
            }
        }
    }

    /// Evaluate model at distance h
    pub(super) fn evaluate_model(
        h: f64,
        family: VariogramModelFamily,
        nugget: f64,
        partial_sill: f64,
        range: f64,
    ) -> f64 {
        if h == 0.0 {
            return nugget;
        }

        let gamma_part = match family {
            VariogramModelFamily::Spherical => {
                if h >= range {
                    partial_sill
                } else {
                    let ratio = h / range;
                    partial_sill * (1.5 * ratio - 0.5 * ratio.powi(3))
                }
            }
            VariogramModelFamily::Exponential => partial_sill * (1.0 - (-3.0 * h / range).exp()),
            VariogramModelFamily::Gaussian => {
                partial_sill * (1.0 - (-3.0 * (h / range).powi(2)).exp())
            }
        };

        nugget + gamma_part
    }

    /// Compute weighted residual sum of squares using nₕ/h weights (gstat fit.method=7)
    fn compute_wrss(
        lags: &[LagBin],
        family: VariogramModelFamily,
        nugget: f64,
        partial_sill: f64,
        range: f64,
    ) -> f64 {
        lags.iter()
            .filter(|lag| lag.distance > 0.0)
            .map(|lag| {
                let w = lag.pair_count as f64 / lag.distance;
                let gamma_model =
                    Self::evaluate_model(lag.distance, family, nugget, partial_sill, range);
                let residual = gamma_model - lag.semivariance;
                residual * residual * w
            })
            .sum()
    }

    /// Compute weighted residual sum of squares and condition number estimate
    fn compute_fit_metrics(
        lags: &[LagBin],
        family: VariogramModelFamily,
        nugget: f64,
        partial_sill: f64,
        range: f64,
    ) -> (f64, f64) {
        let wrss = Self::compute_wrss(lags, family, nugget, partial_sill, range);

        // Rough condition number estimate (range/nugget+partial_sill)
        let total_sill = nugget + partial_sill;
        let condition_number = if total_sill > 0.0 {
            range / total_sill.max(1e-10)
        } else {
            1e10
        };

        (wrss, condition_number)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_variogram_model_spherical() {
        let model = VariogramModel {
            family: VariogramModelFamily::Spherical,
            nugget: 0.1,
            partial_sill: 0.8,
            range: 100.0,
            wrss: 0.01,
            condition_number: 10.0,
        };

        assert_eq!(model.evaluate(0.0), 0.1); // At origin = nugget
        assert!(model.evaluate(100.0) > 0.8); // At range ≈ sill
        assert_eq!(model.evaluate(200.0), model.total_sill()); // Beyond range = sill
    }

    #[test]
    fn test_variogram_model_exponential() {
        let model = VariogramModel {
            family: VariogramModelFamily::Exponential,
            nugget: 0.05,
            partial_sill: 0.9,
            range: 100.0,
            wrss: 0.01,
            condition_number: 20.0,
        };

        assert_eq!(model.evaluate(0.0), 0.05);
        assert!(model.evaluate(100.0) < model.total_sill());
        assert!(model.evaluate(300.0) > model.evaluate(100.0)); // Monotonic
    }

    #[test]
    fn test_variogram_model_gaussian() {
        let model = VariogramModel {
            family: VariogramModelFamily::Gaussian,
            nugget: 0.0,
            partial_sill: 1.0,
            range: 100.0,
            wrss: 0.005,
            condition_number: 15.0,
        };

        assert_eq!(model.evaluate(0.0), 0.0);
        assert!(model.evaluate(50.0) < model.evaluate(100.0)); // Monotonic
    }

    #[test]
    fn test_variogram_fit_insufficient_lags() {
        let lags = vec![LagBin {
            distance: 100.0,
            semivariance: 0.5,
            pair_count: 20,
        }];

        let result = VariogramFitter::fit(&lags, VariogramModelFamily::Spherical);
        assert!(result.is_err());
    }

    #[test]
    fn test_variogram_fit_simple() {
        let lags = vec![
            LagBin {
                distance: 50.0,
                semivariance: 0.3,
                pair_count: 50,
            },
            LagBin {
                distance: 100.0,
                semivariance: 0.6,
                pair_count: 45,
            },
            LagBin {
                distance: 150.0,
                semivariance: 0.85,
                pair_count: 40,
            },
        ];

        let model = VariogramFitter::fit(&lags, VariogramModelFamily::Spherical);
        assert!(model.is_ok());
        let m = model.unwrap();
        assert!(m.nugget >= 0.0);
        assert!(m.partial_sill >= 0.0);
        assert!(m.range > 0.0);
    }
}
