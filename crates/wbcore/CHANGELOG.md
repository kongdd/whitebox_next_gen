# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project follows Semantic Versioning while in pre-1.0 development.

## [Unreleased]

### Added
- **Numeric range bounds for `ToolParamSchema::Scalar`.** The `Scalar` variant now
  carries optional `min: Option<f64>` and `max: Option<f64>` fields. New helpers:
  `scalar_integer_min`, `scalar_integer_range`, `scalar_float_min`, `scalar_float_max`,
  `scalar_float_range`. The `Eq` derive was removed because `f64` bounds are not `Eq`.
- **Exclusive bounds for `Scalar`: `exclusive_min: bool`, `exclusive_max: bool`.**
  New helpers: `scalar_float_gt`, `scalar_float_lt`, `scalar_float_open`,
  `scalar_float_half_open_right`, `scalar_float_half_open_left`.
- **Units annotation for `Scalar`: `units: Option<String>`.** Semantic helpers:
  `scalar_azimuth()` [0°,360°], `scalar_altitude()` [0°,90°], `scalar_degrees_180()`,
  `scalar_degrees_360()`, `scalar_map_units()`.
- **Step for `Scalar`: `step: Option<f64>`.** Recommended spin-box increment.
  `scalar_odd_integer_min(min)` encodes odd-integer filter-size constraint (step=2).
- **Multi-input minimum count: `ToolInputSchema::min_count: Option<usize>`.** Expresses
  minimum required inputs for `Multiple` cardinality. `input_multiple_min(dataset, n)`
  constructor added.
- **`enum_labeled(options: &[(&str, &str)])` constructor.** Accepts `(value, label)`
  pairs; labels shown in QGIS dropdowns, values sent to the backend.

## [0.2.0] - 2026-06-30

### Added
- Added canonical typed tool-parameter schema model types in `wbcore` (input/output/dataset/cardinality/scalar/vector-geometry/field/enum).
- Added `ToolFieldSchema` with parent layer reference and optional vector geometry constraints for field-parameter type-safety.
- Added ergonomic schema builder helpers (`ToolParamSchema::input_raster`, `input_vector`, `output_raster`, `field(parent, geometry)`, scalar and enum helpers) to reduce tool-authoring boilerplate.
- Added `manifest_with_param_schema_json(...)` for schema-aware metadata emission with compatibility fields.

### Changed
- Kept `manifest_with_io_schema_json(...)` backward-compatible by routing through the new schema-aware serializer with an empty schema map.

### Testing
- Schema model types and builders enable 40+ tools across wbtools_oss and wbspatialstats to define field parameter metadata for QGIS dropdown integration.