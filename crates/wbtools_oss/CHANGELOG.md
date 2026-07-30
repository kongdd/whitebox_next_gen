# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project follows Semantic Versioning while in pre-1.0 development.

## [Unreleased]

### Added
- **Completed `ToolParamSchema` coverage to 100% of open-source tool parameters.**
  Previously 16 tools (32 parameters, 0.7% of 4,448 total) relied on heuristic
  inference for widget-type detection rather than explicit typed schemas. All gaps
  are now resolved:
  - `hillshade` and `multidirectional_hillshade`: filled previously empty schema
    stubs with typed entries for `dem` (`Input(Raster)`), `azimuth`, `altitude`,
    `z_factor` (`Scalar(Float)`), `full_360_mode` (`Bool`), and `output`
    (`Output(Raster)`).
  - `openness`: added missing `output` (`Output(Raster)`) entry alongside the
    existing `pos_output`/`neg_output` entries.
  - `image_correlation`, `image_autocorrelation`: added `output_html_file`
    (`Output(File)`) to complete the parameter set.
  - `two_sample_ks_test`, `wilcoxon_signed_rank_test`: added `output_html_file`
    (`Output(File)`).
  - `change_vector_analysis`, `ihs_to_rgb`, `rgb_to_ihs`, `split_colour_composite`:
    added missing `output` (`Output(Raster)`) alongside the existing named channel
    outputs.
  - `assign_projection_raster`, `reproject_raster`: added full schema entries
    (`Input(Raster)`, `Scalar(Integer)` for `epsg`, `Enum` for `resample`,
    `Output(Raster)`).
  - `assign_projection_lidar`, `reproject_lidar`: added full schema entries
    (`Input(Lidar)`, `Scalar(Integer)` for `epsg`, `Output(Lidar)`).
  - `assign_projection_vector`: added full schema entry (`Input(Vector)`,
    `Scalar(Integer)` for `epsg`).
- **Promoted `String` field parameters to `Field(parent)` across all tools where
  a parent vector layer is present, enabling QGIS field-selector dropdowns.**
  Coverage expanded from 62 tools to 102 tools using `Field(parent)`. Changes
  cover three groups:
  - *Category 1 — multiple vector inputs (genuine ambiguity resolved)*: `join_tables`
    (`primary_key_field` → `primary_vector`, `foreign_key_field`/`import_field` →
    `foreign_vector`); `shortest_path_network`, `k_shortest_paths_network`
    (`node_cost_field` → `node_cost_points`, `temporal_edge_id_field` → `input`);
    `closest_facility_network`, `location_allocation_network` (all edge/facility/
    demand field params linked to their respective vector inputs); `network_od_cost_matrix`,
    `od_sensitivity_analysis`, `multimodal_od_cost_matrix` (all field params linked
    to `input` or `node_cost_points`); `vehicle_routing_cvrp`, `vehicle_routing_vrptw`
    (all `max_route_*`, `break_*`, stop and depot field params linked to `stop_points`
    or `depot_points`). Also fixes `merge_table_with_csv` partial promotion:
    `primary_key_field` → `primary_vector` (CSV-sourced fields remain `String`).
  - *Category 2 — single vector input (UX improvement)*: all kriging tools
    (`ordinary_kriging`, `simple_kriging`, `local_kriging`, `universal_kriging`,
    `spacetime_kriging`, `ordinary_cokriging`) — `field` and `time_field`
    parameters linked to their training-points input; all spatial regression tools
    (`geographically_weighted_regression`, `spatial_lag_regression`,
    `spatial_error_regression`, and their `_raster` output variants) — `response_field`
    linked to `input`; point-process tools (`hotspot_vs_process`,
    `point_process_residuals`, `point_process_residuals_comparison`) — `intensity_field`,
    `observed_field`, `predicted_field` linked to `input`; spatial statistics raster
    variants (`getis_ord_gi_star_raster`, `local_morans_i_lisa_raster`) — `field`
    linked to `input`; `block_maximum`, `block_minimum` — `field_name` linked to
    `points`; classification tools (`classify_objects_random_forest`,
    `classify_objects_svm`, `classify_objects_ensemble_pro`) — `segment_id_field`
    and `class_field` linked to `features`; `evaluate_training_sites` — `class_field`
    linked to `training_data`.
  - *New schema map entries added* to `raster_tool_param_schemas` and
    `gis_tool_param_schemas` for geostatistics tools (`estimate_variogram`,
    `kriging_cross_validation`) and regression/point-process tools that previously
    had no explicit schema map entry and fell through to heuristic inference.

- **Streaming `contours_from_raster` for GeoPackage, GeoJSON, and FlatGeobuf
  output.** The raster contour tool now routes all file-based output through
  `wbvector::VectorStreamWriter`, which selects the best streaming back-end for
  the output format automatically (GeoPackage → `GpkgStreamWriter`, GeoJSON →
  `GeoJsonStreamWriter`, FlatGeobuf → `FgbStreamWriter`, all others → `Layer`
  accumulation fallback).  Internally, the tool uses a level-by-level chaining
  strategy (`raster_contour_stream`) so the per-level `endpoint_map` and
  `visited` HashMap are freed after each contour level is processed.  Combined
  with the streaming writers, chains are written directly to the output file
  without an intermediate `all_lines` or `Layer` accumulation, removing the peak
  memory spike that previously occurred when the full segment Vec coexisted with
  all chained lines and the Layer before writing.  Non-streaming formats and
  in-memory outputs fall back to the existing Layer-based path.  New helpers:
  `raster_contour_stream` (core level-by-level streaming), `extend_chain`
  (standalone chain step), `raster_contour_layer` (thin wrapper for in-memory
  use).
- Added range syntax support for `excluded_classes` parameter in all LiDAR interpolation/gridding tools. Users can now specify class ranges using hyphen notation (e.g., `excluded_classes="0,1,3-18"`) which expands to individual classes. Supports mixed syntax: `"0,1,3-18,20-25"` expands to classes 0, 1, 3–18, 20–25. Applies to ~20 tools including:
  - `lidar_tin_gridding`, `lidar_nearest_neighbour_gridding`, `lidar_idw_interpolation`
  - `lidar_radial_basis_function_interpolation`, `lidar_sibson_interpolation`
  - `lidar_block_maximum`, `lidar_block_minimum`, `lidar_point_density`
  - `filter_lidar_classes` and others
- Implementation in `parse_excluded_classes()` validates range syntax (start ≤ end), handles whitespace around hyphens, and maintains backward compatibility with single-value and array input formats.

### Changed
- Removed explicit `features = ["parallel"]` from `wbprojection`, `wblidar`, and `wbtopology`
  dependencies now that all three crates include `parallel` in their `default` feature set.
  Parallelism is now guaranteed by those crates' defaults rather than by caller-side declarations.

### Fixed
- **Bug fix: sign error in the Y-component of surface normal vectors** in `terrain_window_tools.rs`, affecting `feature_preserving_smoothing` and all Poisson-based smoothing tools (`feature_preserving_smoothing_poisson`, `feature_preserving_smoothing_multiscale`). The `b` component of the Sobel normal vector was computed with all Y-direction terms negated — `−((SW−NW) + 2(S−N) + (SE−NE))` instead of the correct `−((NW−SW) + 2(N−S) + (NE−SE))` — equivalent to using `−b` throughout. In `feature_preserving_smoothing` (Sun et al. algorithm) this directly inverted the Y-slope direction in the elevation extrapolation step, producing a visually wrong "inverted-Y relief" artifact in the smoothed DEM. In Poisson-based tools the same sign error also corrupted the divergence term (`∂a/∂x − ∂b/∂y` instead of `∂a/∂x + ∂b/∂y`) used to drive the screened Poisson reconstruction, though the data-fidelity anchor partially masked the effect. The edge-preservation threshold test (cosine between pairs of normals) was unaffected since both normals in each comparison carried the same sign error, leaving the dot product unchanged. Fixed at both locations where normals are computed: Stage 1 of `run_feature_preserving_smoothing` (line 1116) and the outer-iteration normal recompute inside `run_poisson_smoothing_core` (line 4690).
- **Bug fix: `feature_preserving_smoothing_multiscale` `scale_levels` parameter had no visible effect** under normal parameter settings. Root causes identified and fixed in sequence:
  1. `build_dem_pyramid` hard-stopped at 64×64 minimum level size, so for typical DEMs `scale_levels` = 5, 6, 7, 8 all produced the same pyramid and identical outputs. Minimum reduced to 8×8.
  2. The upsampled coarser result was passed as `initial_surface` (warm-start only); the Jacobi solve's data-fidelity term anchored every level back to the original DEM, exponentially diluting the coarse signal. Fixed by adding a `coarse_guide` parameter to `run_poisson_smoothing_core` (separate from `initial_surface`) and using it as an explicit second anchor in the Jacobi update: `new_z = (λ·dem_orig + λ_coarse·coarse_guide + Σ_nbr + div) / (λ + λ_coarse + n_nbr)`.
  3. `lambda_coarse` was derived from `fidelity` via `smoothing_amount * lambda_at_level`, making `scale_levels` effects invisible at default/high fidelity. Decoupled `lambda_coarse = smoothing_amount` (independent of fidelity).
  4. Coarse guide was injected by a single large-factor bilinear upsample (e.g. 32×32 → 1000×1000), producing visible slope-discontinuity grid artifacts in the hillshade. Changed to progressive upsampling: the running coarse guide is stepped up one pyramid level (~2×) at each iteration, avoiding bilinear patch boundaries accumulating into visible patterns.
  5. At the coarsest pyramid level, user `fidelity` was applied to a box-filter-downsampled DEM, allowing downsampling aliasing to propagate into the guide. The coarsest-level solve now uses `lambda * 0.05` (near-zero fidelity), converging toward a smooth Laplacian solution free of aliasing artifacts.
- **Metadata text fix**: corrected `feature_preserving_smoothing_multiscale` manifest and metadata summary strings from "adaptive robust normal-field diffusion" (incorrect — the code uses RMS-based conductance scaling, not a robust estimator) to "adaptive edge-aware normal-field diffusion". Updated `scale_levels` parameter description to document its role as a broad-scale generalization control.
  and `wbtopology` have been updated to include `parallel` in their `default` features. Previously
  any crate that depended on them without `features = ["parallel"]` silently compiled without
  parallel support. This affected `wbprojection` in `wbtools_oss` (and `wblidar`/`wbtopology` in
  `wbw_python` and `wbw_r`). The root fix is in those crates' Cargo.toml files.
- Fixed vertical axis inversion in `ordinary_kriging` and `ordinary_cokriging` geostats tools. The `generate_raster_grid()` function in `ordinary_kriging.rs` was computing cell-centre Y coordinates as `y_min + (row + 0.5) * cell_size_y`, which (since wbw stores `cell_size_y` as a positive magnitude) assigns the southernmost coordinate to row 0 — a vertical flip. The correct formula, consistent with `Raster::cell_y()`, is `y_max - (row + 0.5) * cell_size_y`. `ordinary_cokriging.rs` had the same row→Y assignment but was also incorrectly negating `cell_size_y` (double-negative since wbw already stores it as positive). Both are now corrected.

## [0.1.3] - 2026-06-30

### Added
- Added explicit field parameter schemas across 40+ GIS tools for QGIS field dropdown widget support:
  - **Interpolation Tools**: `idw_interpolation`, `modified_shepard_interpolation`, `natural_neighbour_interpolation` — field_name parameter with parent reference to points layer.
  - **Spatial Statistics**: `morans_i`, `local_morans_i`, `bivariable_correlation` — field parameter with parent reference to input layer.
  - **Vector Analysis**: `buffer_vector`, `explode_features`, `near`, `select_by_location`, `spatial_join` — field parameters (dissolve_field, search_field, etc.) with parent references.
  - **Linear Referencing**: `route_calibrate`, `locate_along_route`, `locate_point_on_route` — route_id_field and measure_field parameters with parent references to route/event layers.
  - **Network Analysis**: `network_routes_from_od`, `network_accessibility_metrics` — node_cost_field parameter with parent reference to node_cost_points layer.
  - **Classification**: `training_sample_filter`, `knn_classification` — class_field parameter with parent reference to training_data layer.
  - **Field Operations**: `add_field`, `delete_field`, `rename_field` — field parameters with appropriate parent vector layer references.
- Field schemas enable QGIS front-end to render field parameters as dropdown selectors (instead of text input) with automatic parent layer resolution.

### Fixed
- Fixed `longest_flowpath` tool metadata schema incorrectly specifying output as raster instead of vector. The tool was grouped with flowpath-length tools (which produce rasters) in the schema registry, causing QGIS plugin to render it as a raster output parameter. Extracted into separate schema entry with correct specification: `basins` as input raster, `output` as `output_vector_any()`. QGIS will now correctly display output parameter as vector layer sink once published binary is updated.
- Fixed `polygons_to_lines` tool producing open polylines with missing closing segments. Ring internal representation intentionally omits the closing duplicate vertex for efficiency. The tool was cloning ring coordinates directly into output line strings, losing the closing segment. Added `close_ring()` step that appends the first coordinate to each ring if not already closed, with guard against double-closing rings from formats that include closing vertex on read. Applies to both `Polygon` and `MultiPolygon` inputs (resolves issue #19).

## [0.1.2] - 2026-06-14

### Added
- Added pilot explicit parameter schemas for `extract_streams` and `vector_stream_network_analysis` via `stream_tool_param_schemas(...)`.
- Added explicit `Tool` metadata/manifests for the two pilot stream tools so emitted metadata includes canonical parameter names/descriptions and defaults.

### Changed
- Re-exported stream tool schema mapping helper from `tools` module for binding/front-end metadata integration.

### Fixed
- Fixed `quantiles` tool catastrophic failure on rasters with extreme positive skewness. The fixed-bin histogram approach (10,000 bins over full [min, max] range) produced bin widths so coarse that quantile boundaries fell within a single bin, causing all valid pixels to be assigned the highest class. Replaced with an adaptive-bin histogram that scales bin count proportionally to valid cell count (capped at 32 MB), ensuring quantile boundaries map to distinct bins regardless of distribution shape. The tool now correctly computes equal-count quantile classes on highly skewed data while maintaining O(n) time complexity and cache-friendly memory usage.