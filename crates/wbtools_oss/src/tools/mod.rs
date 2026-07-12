use std::collections::BTreeMap;
use std::collections::BTreeSet;
use wbcore::ToolParamSchema;

#[cfg(feature = "data_tools")]
mod data_tools;
#[cfg(feature = "data_tools")]
pub use data_tools::*;
#[cfg(feature = "flow_algorithms")]
mod flow_algorithms;
#[cfg(feature = "flow_algorithms")]
pub use flow_algorithms::*;
#[cfg(feature = "geomorphometry")]
mod geomorphometry;
#[cfg(feature = "geomorphometry")]
pub use geomorphometry::*;
#[cfg(feature = "geostats")]
mod geostats;
#[cfg(feature = "geostats")]
pub use geostats::*;
#[cfg(feature = "gis")]
mod gis;
#[cfg(feature = "gis")]
pub use gis::*;
#[cfg(feature = "hydrology")]
mod hydrology;
#[cfg(feature = "hydrology")]
pub use hydrology::*;
#[cfg(feature = "lidar")]
mod lidar_processing;
#[cfg(feature = "lidar")]
pub use lidar_processing::*;
mod param_docs;
pub use param_docs::{
    doc_tool_param_descriptions, doc_tool_param_required, doc_tool_param_schemas,
};
#[cfg(feature = "raster")]
mod raster;
#[cfg(feature = "raster")]
pub use raster::*;
pub mod raster_stack_validator;
#[cfg(feature = "remote_sensing")]
mod remote_sensing;
#[cfg(feature = "remote_sensing")]
pub use remote_sensing::*;
#[cfg(feature = "stream_network_analysis")]
mod stream_network_analysis;
#[cfg(feature = "stream_network_analysis")]
pub use stream_network_analysis::*;

pub fn tool_param_schemas(tool_id: &str) -> Option<BTreeMap<String, ToolParamSchema>> {
    #[allow(unused_mut)]
    let mut result = None;

    macro_rules! lookup {
        ($feature:literal, $function:ident) => {
            #[cfg(feature = $feature)]
            {
                result = result.or_else(|| $function(tool_id));
            }
        };
    }

    lookup!("stream_network_analysis", stream_tool_param_schemas);
    lookup!("flow_algorithms", flow_tool_param_schemas);
    lookup!("gis", gis_tool_param_schemas);
    lookup!("geomorphometry", geomorphometry_tool_param_schemas);
    lookup!("hydrology", hydrology_tool_param_schemas);
    lookup!("data_tools", data_tools_param_schemas);
    lookup!("lidar", lidar_tool_param_schemas);
    lookup!("raster", raster_tool_param_schemas);
    lookup!("remote_sensing", remote_sensing_tool_param_schemas);

    result.or_else(|| doc_tool_param_schemas(tool_id))
}

/// Returns conditional visibility conditions for tool parameters.
///
/// The returned map keys are parameter names. Each value is a JSON object where
/// each key is another parameter name and the value is the required setting for
/// the keyed parameter to be relevant.
///
/// Example: `{"output_intervals": true}` on `confidence_level` means that
/// `confidence_level` is only active when `output_intervals` is `true`.
///
/// Consumers that cannot implement dynamic show/hide (e.g. QGIS Processing)
/// should treat any parameter with a `visible_when` entry as advanced/collapsed.
pub fn tool_param_visibility(
    tool_id: &str,
) -> Option<BTreeMap<String, serde_json::Value>> {
    match tool_id {
        // Kriging tools: anisotropy sub-parameters and interval sub-parameters
        // are only meaningful when their controlling boolean is enabled.
        "ordinary_kriging"
        | "simple_kriging"
        | "local_kriging"
        | "universal_kriging"
        | "ordinary_cokriging" => Some(BTreeMap::from([
            (
                "confidence_level".to_string(),
                serde_json::json!({"output_intervals": true}),
            ),
            (
                "interval_method".to_string(),
                serde_json::json!({"output_intervals": true}),
            ),
            (
                "major_azimuth".to_string(),
                serde_json::json!({"anisotropy": true}),
            ),
            (
                "anisotropy_ratio".to_string(),
                serde_json::json!({"anisotropy": true}),
            ),
        ])),
        "spacetime_kriging" => Some(BTreeMap::from([
            (
                "major_azimuth".to_string(),
                serde_json::json!({"anisotropy": true}),
            ),
            (
                "anisotropy_ratio".to_string(),
                serde_json::json!({"anisotropy": true}),
            ),
        ])),
        // Hillshade: z_factor is only meaningful when processing 3D terrain.
        // (Always shown — no conditional visibility needed here.)
        _ => None,
    }
}

pub fn tool_param_descriptions(tool_id: &str) -> Option<BTreeMap<String, String>> {
    let known_keys: BTreeSet<String> = tool_param_schemas(tool_id)
        .unwrap_or_default()
        .into_keys()
        .collect();
    doc_tool_param_descriptions(tool_id, &known_keys)
}

pub fn tool_param_required(tool_id: &str) -> Option<BTreeMap<String, bool>> {
    let known_keys: BTreeSet<String> = tool_param_schemas(tool_id)
        .unwrap_or_default()
        .into_keys()
        .collect();
    doc_tool_param_required(tool_id, &known_keys)
}
