use std::collections::BTreeMap;

use rayon::prelude::*;
use serde_json::{json, Value};
use wbcore::{
    LicenseTier, Tool, ToolArgs, ToolCategory, ToolContext, ToolError, ToolExample, ToolManifest,
    ToolMetadata, ToolParamDescriptor, ToolParamSpec, ToolRunResult, ToolStability,
};
use wbraster::{Raster, RasterFormat};
use wbspatialstats::{
    cv::LeaveOneOutCV,
    kriging::{
        LocalOrdinaryKriging, OrdinaryKriging, SimpleKriging, SpaceTimeKriging, UniversalKriging,
    },
    variogram::{EmpiricalVariogramBuilder, VariogramFitter, VariogramModelFamily},
};
use wbvector;

mod variogram_estimation;
pub use variogram_estimation::EstimateVariogramTool;

mod variogram_fitting;
pub use variogram_fitting::FitVariogramTool;

mod ordinary_kriging;
pub use ordinary_kriging::OrdinaryKrigingTool;

mod local_kriging;
pub use local_kriging::LocalOrdinaryKrigingTool;

mod simple_kriging;
pub use simple_kriging::SimpleKrigingTool;

mod universal_kriging;
pub use universal_kriging::UniversalKrigingTool;

mod spacetime_kriging;
pub use spacetime_kriging::SpaceTimeKrigingTool;

mod cross_validation;
pub use cross_validation::KrigingCrossValidationTool;

mod directional_variogram;
pub use directional_variogram::DirectionalVariogramTool;

mod ordinary_cokriging;
pub use ordinary_cokriging::OrdinaryCoKrigingTool;

fn load_vector_arg(args: &ToolArgs, key: &str) -> Result<wbvector::Layer, ToolError> {
    let path = args
        .get(key)
        .and_then(|v| v.as_str())
        .ok_or_else(|| ToolError::Validation(format!("parameter '{}' is required", key)))?;
    load_vector(path.trim(), key)
}

fn load_vector(path: &str, key: &str) -> Result<wbvector::Layer, ToolError> {
    if wbvector::memory_store::vector_is_memory_path(path) {
        let id = wbvector::memory_store::vector_path_to_id(path).ok_or_else(|| {
            ToolError::Validation(format!(
                "parameter '{}' has malformed in-memory vector path",
                key
            ))
        })?;
        return wbvector::memory_store::get_vector_arc_by_id(id)
            .map(|layer| layer.as_ref().clone())
            .ok_or_else(|| {
                ToolError::Validation(format!(
                    "parameter '{}' references unknown in-memory vector id '{}': store entry is missing",
                    key, id
                ))
            });
    }

    wbvector::read(path)
        .map_err(|e| ToolError::Execution(format!("failed reading {} vector: {}", key, e)))
}

fn parse_optional_f64_arg(args: &ToolArgs, key: &str) -> Option<f64> {
    args.get(key).and_then(|v| v.as_f64())
}

fn parse_optional_i64_arg(args: &ToolArgs, key: &str) -> Option<i64> {
    args.get(key).and_then(|v| v.as_i64())
}

fn parse_bool_arg(args: &ToolArgs, key: &str, default: bool) -> bool {
    args.get(key).and_then(|v| v.as_bool()).unwrap_or(default)
}

fn parse_string_arg<'a>(args: &'a ToolArgs, key: &str) -> Result<&'a str, ToolError> {
    args.get(key)
        .and_then(|v| v.as_str())
        .map(str::trim)
        .filter(|s| !s.is_empty())
        .ok_or_else(|| ToolError::Validation(format!("parameter '{}' is required", key)))
}

fn parse_optional_string_arg(args: &ToolArgs, key: &str) -> Result<Option<String>, ToolError> {
    Ok(args
        .get(key)
        .and_then(|v| v.as_str())
        .map(str::trim)
        .filter(|s| !s.is_empty())
        .map(|s| s.to_string()))
}

/// Parse a variogram JSON string (as produced by fit_variogram) into a VariogramModel.
fn parse_variogram_json(
    json_str: &str,
) -> Result<wbspatialstats::variogram::VariogramModel, ToolError> {
    let obj: Value = serde_json::from_str(json_str)
        .map_err(|e| ToolError::Execution(format!("Variogram JSON parse error: {}", e)))?;

    let family_str = obj
        .get("family")
        .and_then(|v| v.as_str())
        .unwrap_or("exponential");
    let family = match family_str {
        "spherical" => VariogramModelFamily::Spherical,
        "exponential" => VariogramModelFamily::Exponential,
        "gaussian" => VariogramModelFamily::Gaussian,
        _ => {
            return Err(ToolError::Execution(format!(
                "Unknown variogram family '{}'",
                family_str
            )))
        }
    };
    Ok(wbspatialstats::variogram::VariogramModel {
        family,
        nugget: obj.get("nugget").and_then(|v| v.as_f64()).unwrap_or(0.0),
        partial_sill: obj
            .get("partial_sill")
            .and_then(|v| v.as_f64())
            .unwrap_or(1.0),
        range: obj.get("range").and_then(|v| v.as_f64()).unwrap_or(100.0),
        wrss: obj.get("wrss").and_then(|v| v.as_f64()).unwrap_or(0.0),
        condition_number: obj
            .get("condition_number")
            .and_then(|v| v.as_f64())
            .unwrap_or(1.0),
    })
}

/// Extract (coords, values) from a vector layer field, matching ordinary_kriging.
fn extract_training_points(
    training: &wbvector::Layer,
    field_name: &str,
) -> Result<(Vec<(f64, f64)>, Vec<f64>), ToolError> {
    let field_idx = training
        .schema
        .field_index(field_name)
        .ok_or_else(|| ToolError::Validation(format!("field '{}' does not exist", field_name)))?;
    let mut coords = Vec::new();
    let mut values = Vec::new();
    for feature in &training.features {
        if let Some(fv) = feature.attributes.get(field_idx) {
            if let Some(value) = fv.as_f64() {
                if value.is_finite() {
                    if let Some(geom) = &feature.geometry {
                        if let wbvector::Geometry::Point(p) = geom {
                            coords.push((p.x, p.y));
                            values.push(value);
                        }
                    }
                }
            }
        }
    }
    if coords.len() < 3 {
        return Err(ToolError::Execution(
            "At least 3 training points required for kriging".to_string(),
        ));
    }
    Ok((coords, values))
}

/// Generate (x, y) cell-centre coordinates for every cell in a raster, in row-major order.
/// Row 0 is northernmost; uses rayon for parallel generation.
fn generate_raster_grid(raster: &Raster) -> Vec<(f64, f64)> {
    let rows = raster.rows;
    let cols = raster.cols;
    let x_min = raster.x_min;
    let y_min = raster.y_min;
    let cell_size_x = raster.cell_size_x;
    let cell_size_y = raster.cell_size_y;
    let y_max = y_min + (rows as f64) * cell_size_y;
    (0..rows)
        .into_par_iter()
        .flat_map(move |row| {
            (0..cols).into_par_iter().map(move |col| {
                let x = x_min + (col as f64 + 0.5) * cell_size_x;
                let y = y_max - (row as f64 + 0.5) * cell_size_y;
                (x, y)
            })
        })
        .collect()
}

/// Derive a variance output path by inserting `_variance` before the file extension.
fn derive_variance_path(output_path: &str) -> String {
    if let Some(dot) = output_path.rfind('.') {
        format!("{}_variance{}", &output_path[..dot], &output_path[dot..])
    } else {
        format!("{}_variance", output_path)
    }
}
