//! Geographic lon/lat degree pass-through projection.

use super::{ProjectionImpl, ProjectionParams};
use crate::error::Result;

pub(super) struct GeographicProj;

impl GeographicProj {
    pub fn new(_p: &ProjectionParams) -> Result<Self> {
        Ok(Self)
    }
}

impl ProjectionImpl for GeographicProj {
    fn forward(&self, lon_deg: f64, lat_deg: f64) -> Result<(f64, f64)> {
        Ok((lon_deg, lat_deg))
    }

    fn inverse(&self, x: f64, y: f64) -> Result<(f64, f64)> {
        Ok((x, y))
    }
}
