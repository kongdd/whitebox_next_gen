use std::collections::BTreeMap;
use std::collections::BTreeSet;
use wbcore::ToolParamSchema;

#[cfg(feature = "raster")]
mod raster;
#[cfg(feature = "raster")]
pub use raster::*;
#[cfg(feature = "data_tools")]
mod data_tools;
#[cfg(feature = "data_tools")]
pub use data_tools::*;
#[cfg(feature = "gis")]
mod gis;
#[cfg(feature = "gis")]
pub use gis::*;
#[cfg(feature = "geostats")]
mod geostats;
#[cfg(feature = "geostats")]
pub use geostats::*;
#[cfg(feature = "geomorphometry")]
mod geomorphometry;
#[cfg(feature = "geomorphometry")]
pub use geomorphometry::*;
#[cfg(feature = "remote_sensing")]
mod remote_sensing;
#[cfg(feature = "remote_sensing")]
pub use remote_sensing::*;
#[cfg(feature = "stream_network_analysis")]
mod stream_network_analysis;
#[cfg(feature = "stream_network_analysis")]
pub use stream_network_analysis::*;
#[cfg(feature = "hydrology")]
mod hydrology;
#[cfg(feature = "hydrology")]
pub use hydrology::*;
#[cfg(feature = "flow_algorithms")]
mod flow_algorithms;
#[cfg(feature = "flow_algorithms")]
pub use flow_algorithms::*;
#[cfg(feature = "lidar")]
mod lidar_processing;
#[cfg(feature = "lidar")]
pub use lidar_processing::*;
mod param_docs;
pub mod raster_stack_validator;

pub use param_docs::{doc_tool_param_descriptions, doc_tool_param_required, doc_tool_param_schemas};

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

// Experimental Phase D tools (advanced point-pattern diagnostics)

// Geostatistics/Kriging Tools
// Note: Kriging tools are now in gis::spatial_stats_phase_b (OrdinaryKriging, LocalOrdinaryKriging, SimpleKriging, UniversalKriging, SpaceTimeKriging)
// Legacy geostats tools removed in favor of unified wbtools_oss/gis implementation

