//! Robust variogram fitting using L¹ and Huber loss functions
//!
//! Uses Iteratively Reweighted Least Squares (IRLS) to handle outliers.
//! Each outer IRLS iteration recomputes per-lag robust weights from current
//! residuals, then runs one Gauss-Newton (Marquardt-Levenberg) step on the
//! resulting weighted least-squares problem — identical to the standard fitter
//! but with an extra robustness weight applied to each observation.
//!
//! Weight scheme (matching gstat fit.method=7 base weights):
//!   L1:    w_i = (nₕ/h) × 1/|rᵢ|   (floor at ε to avoid division by zero)
//!   Huber: w_i = (nₕ/h) × {1           if |rᵢ| ≤ δ
//!                           {δ/|rᵢ|      if |rᵢ| > δ

use super::model::VariogramFitter;
use super::{LagBin, VariogramModel, VariogramModelFamily};
use crate::{GeostatError, GeostatResult};
use nalgebra::{Matrix3, Vector3};

/// Loss function type for robust fitting
#[derive(Debug, Clone, Copy, PartialEq)]
pub enum RobustLossFunction {
    /// Least absolute deviations (L¹): sum of |residuals|
    /// Most resistant to outliers but less smooth
    L1,
    /// Huber loss: hybrid L¹/L² with smooth transition at threshold
    /// Combines robustness of L¹ with smoothness of L² for better convergence
    Huber(f64), // threshold parameter δ
}

/// Robust variogram fitter using L¹ or Huber loss via IRLS
pub struct RobustVariogramFitter;

impl RobustVariogramFitter {
    /// Fit variogram model using robust loss function.
    ///
    /// Uses IRLS (Iteratively Reweighted Least Squares) with Gauss-Newton
    /// inner steps. Initialization follows gstat's `vgm_fill_na()` heuristic.
    pub fn fit(
        lags: &[LagBin],
        family: VariogramModelFamily,
        loss: RobustLossFunction,
    ) -> GeostatResult<VariogramModel> {
        if lags.len() < 3 {
            return Err(GeostatError::InsufficientData(
                "at least 3 lag bins required for fitting".to_string(),
            ));
        }

        if let RobustLossFunction::Huber(delta) = loss {
            if delta <= 0.0 {
                return Err(GeostatError::InvalidParameter(
                    "Huber threshold must be positive".to_string(),
                ));
            }
        }

        let n = lags.len();

        // Initialization following gstat's vgm_fill_na()
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
            Self::optimize_parameters(lags, family, nugget_init, psill_init, range_init, loss)?;

        // Report loss value in the wrss field for diagnostic purposes
        let loss_value = Self::compute_loss(lags, family, nugget, partial_sill, range, loss);

        let total_sill = nugget + partial_sill;
        let condition_number = if total_sill > 0.0 {
            range / total_sill.max(1e-10)
        } else {
            1e10
        };

        Ok(VariogramModel {
            family,
            nugget: nugget.max(0.0),
            partial_sill: partial_sill.max(0.0),
            range: range.max(0.1),
            wrss: loss_value,
            condition_number,
        })
    }

    /// IRLS optimizer: outer loop updates robust weights, inner step is Gauss-Newton.
    ///
    /// Convergence criterion: relative change in loss < 1e-5 (gstat DEF_fit_limit).
    fn optimize_parameters(
        lags: &[LagBin],
        family: VariogramModelFamily,
        nugget_init: f64,
        partial_sill_init: f64,
        range_init: f64,
        loss: RobustLossFunction,
    ) -> GeostatResult<(f64, f64, f64)> {
        const MAX_ITER: usize = 200;
        const CONV_TOL: f64 = 1e-5;
        const MAX_STEP_FRAC: f64 = 0.20;
        // Floor for robust weight denominator — prevents w → ∞ near zero residuals
        const IRLS_EPS: f64 = 1e-6;

        // Bump zero sills to 1.0 (same as gstat src/fit.c:44-46)
        let mut c0 = if nugget_init == 0.0 { 1.0 } else { nugget_init };
        let mut c1 = if partial_sill_init == 0.0 {
            1.0
        } else {
            partial_sill_init
        };
        let mut a = range_init.max(0.1);

        let mut prev_loss = f64::INFINITY;

        for _ in 0..MAX_ITER {
            // --- Compute IRLS weights from current residuals ---
            let irls_weights: Vec<f64> = lags
                .iter()
                .map(|lag| {
                    if lag.distance == 0.0 {
                        return 0.0;
                    }
                    let gamma_model =
                        VariogramFitter::evaluate_model(lag.distance, family, c0, c1, a);
                    let r = (lag.semivariance - gamma_model).abs().max(IRLS_EPS);
                    match loss {
                        RobustLossFunction::L1 => 1.0 / r,
                        RobustLossFunction::Huber(delta) => {
                            if r <= delta {
                                1.0
                            } else {
                                delta / r
                            }
                        }
                    }
                })
                .collect();

            // --- Gauss-Newton step with combined (nₕ/h × irls) weights ---
            let mut jtj = Matrix3::<f64>::zeros();
            let mut jtr = Vector3::<f64>::zeros();
            let mut current_loss = 0.0;

            for (lag, &w_irls) in lags.iter().zip(&irls_weights) {
                let h = lag.distance;
                if h == 0.0 {
                    continue;
                }

                // Base weight: nₕ/h (gstat fit.method=7); combined with IRLS weight
                let w = (lag.pair_count as f64 / h) * w_irls;

                let gamma_model = VariogramFitter::evaluate_model(h, family, c0, c1, a);
                let residual = lag.semivariance - gamma_model;

                // Accumulate robust loss for convergence check
                let abs_r = residual.abs();
                current_loss += match loss {
                    RobustLossFunction::L1 => abs_r * (lag.pair_count as f64 / h),
                    RobustLossFunction::Huber(delta) => {
                        let base = lag.pair_count as f64 / h;
                        if abs_r <= delta {
                            base * 0.5 * residual * residual
                        } else {
                            base * delta * (abs_r - 0.5 * delta)
                        }
                    }
                };

                let j_c0 = 1.0;
                let (j_c1, j_a) = VariogramFitter::model_derivatives(h, family, c1, a);
                let j = Vector3::new(j_c0, j_c1, j_a);

                jtj += w * j * j.transpose();
                jtr += w * residual * j;
            }

            // Convergence check on loss
            let rel_change = (prev_loss - current_loss) / current_loss.max(f64::EPSILON);
            if rel_change.abs() < CONV_TOL && prev_loss.is_finite() {
                break;
            }
            prev_loss = current_loss;

            // Solve J'WJ Δβ = J'Wr
            let delta = match jtj.qr().solve(&jtr) {
                Some(d) => d,
                None => break,
            };

            // Marquardt 20% step-size bound
            let param_norm = (c0 * c0 + c1 * c1 + a * a).sqrt().max(f64::EPSILON);
            let step_norm = delta.norm();
            let scale = if step_norm > MAX_STEP_FRAC * param_norm {
                MAX_STEP_FRAC * param_norm / step_norm
            } else {
                1.0
            };

            c0 = (c0 + scale * delta[0]).max(0.0);
            c1 = (c1 + scale * delta[1]).max(0.0);
            a = (a + scale * delta[2]).max(0.1);
        }

        Ok((c0, c1, a))
    }

    /// Compute total robust loss for final reporting
    fn compute_loss(
        lags: &[LagBin],
        family: VariogramModelFamily,
        nugget: f64,
        partial_sill: f64,
        range: f64,
        loss: RobustLossFunction,
    ) -> f64 {
        lags.iter()
            .filter(|l| l.distance > 0.0)
            .map(|lag| {
                let w_base = lag.pair_count as f64 / lag.distance;
                let gamma_model = VariogramFitter::evaluate_model(
                    lag.distance,
                    family,
                    nugget,
                    partial_sill,
                    range,
                );
                let r = (lag.semivariance - gamma_model).abs();
                w_base
                    * match loss {
                        RobustLossFunction::L1 => r,
                        RobustLossFunction::Huber(delta) => {
                            if r <= delta {
                                0.5 * r * r
                            } else {
                                delta * (r - 0.5 * delta)
                            }
                        }
                    }
            })
            .sum()
    }

    /// Huber pseudo-weight: derivative of Huber loss / residual
    ///
    /// For |x| ≤ δ: returns 1.0  (acts like L²)
    /// For |x| > δ: returns δ/|x|  (shrinks large residuals toward L¹)
    #[cfg(test)]
    fn huber_loss(residual: f64, delta: f64) -> f64 {
        let abs_residual = residual.abs();
        if abs_residual <= delta {
            0.5 * residual * residual
        } else {
            delta * (abs_residual - 0.5 * delta)
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_robust_fit_l1_simple() {
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

        let model = RobustVariogramFitter::fit(
            &lags,
            VariogramModelFamily::Spherical,
            RobustLossFunction::L1,
        );
        assert!(model.is_ok());
        let m = model.unwrap();
        assert!(m.nugget >= 0.0);
        assert!(m.partial_sill >= 0.0);
        assert!(m.range > 0.0);
    }

    #[test]
    fn test_robust_fit_huber_simple() {
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

        let model = RobustVariogramFitter::fit(
            &lags,
            VariogramModelFamily::Spherical,
            RobustLossFunction::Huber(0.5),
        );
        assert!(model.is_ok());
        let m = model.unwrap();
        assert!(m.nugget >= 0.0);
        assert!(m.partial_sill >= 0.0);
        assert!(m.range > 0.0);
    }

    #[test]
    fn test_robust_fit_with_outliers() {
        let mut lags = vec![
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
        lags.push(LagBin {
            distance: 75.0,
            semivariance: 2.0,
            pair_count: 5,
        }); // outlier

        let l1_model = RobustVariogramFitter::fit(
            &lags,
            VariogramModelFamily::Spherical,
            RobustLossFunction::L1,
        );
        let huber_model = RobustVariogramFitter::fit(
            &lags,
            VariogramModelFamily::Spherical,
            RobustLossFunction::Huber(0.5),
        );

        assert!(l1_model.is_ok());
        assert!(huber_model.is_ok());

        let l1 = l1_model.unwrap();
        let huber = huber_model.unwrap();
        assert!(l1.range > 0.0);
        assert!(huber.range > 0.0);
    }

    #[test]
    fn test_robust_fit_all_families() {
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

        for family in &[
            VariogramModelFamily::Spherical,
            VariogramModelFamily::Exponential,
            VariogramModelFamily::Gaussian,
        ] {
            let l1_result = RobustVariogramFitter::fit(&lags, *family, RobustLossFunction::L1);
            let huber_result =
                RobustVariogramFitter::fit(&lags, *family, RobustLossFunction::Huber(0.3));
            assert!(l1_result.is_ok());
            assert!(huber_result.is_ok());
        }
    }

    #[test]
    fn test_robust_fit_insufficient_lags() {
        let lags = vec![LagBin {
            distance: 100.0,
            semivariance: 0.5,
            pair_count: 20,
        }];
        let result = RobustVariogramFitter::fit(
            &lags,
            VariogramModelFamily::Spherical,
            RobustLossFunction::L1,
        );
        assert!(result.is_err());
    }

    #[test]
    fn test_robust_fit_invalid_huber_threshold() {
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

        assert!(RobustVariogramFitter::fit(
            &lags,
            VariogramModelFamily::Spherical,
            RobustLossFunction::Huber(-0.5)
        )
        .is_err());
        assert!(RobustVariogramFitter::fit(
            &lags,
            VariogramModelFamily::Spherical,
            RobustLossFunction::Huber(0.0)
        )
        .is_err());
    }

    #[test]
    fn test_l1_vs_huber_convergence() {
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
            LagBin {
                distance: 75.0,
                semivariance: 1.5,
                pair_count: 10,
            }, // outlier
        ];

        let l1_model = RobustVariogramFitter::fit(
            &lags,
            VariogramModelFamily::Spherical,
            RobustLossFunction::L1,
        )
        .unwrap();
        let huber_model = RobustVariogramFitter::fit(
            &lags,
            VariogramModelFamily::Spherical,
            RobustLossFunction::Huber(0.7),
        )
        .unwrap();

        assert!(l1_model.wrss > 0.0);
        assert!(huber_model.wrss > 0.0);
        assert!((l1_model.range - huber_model.range).abs() < l1_model.range * 0.5);
    }

    #[test]
    fn test_huber_loss_function() {
        let delta = 1.0;
        let huber_small = RobustVariogramFitter::huber_loss(0.5, delta);
        assert!((huber_small - 0.125).abs() < 1e-10); // 0.5 * 0.5²

        let huber_large = RobustVariogramFitter::huber_loss(2.0, delta);
        let expected = delta * (2.0 - 0.5 * delta);
        assert!((huber_large - expected).abs() < 1e-10);
    }
}
