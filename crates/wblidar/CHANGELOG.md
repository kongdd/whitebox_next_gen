# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project follows Semantic Versioning while in pre-1.0 development.

## [Unreleased]

## [0.1.3] - 2026-07-30
### Changed
- **`parallel` is now on by default.** The `parallel` feature (which enables `copc-parallel` and
  `laz-parallel`) is included in the crate's `default` feature set. Parallel COPC decompression
  and parallel LAZ decode are active without any explicit `features = ["parallel"]` declaration
  by dependents. Consumers that need a serial build can opt out with `default-features = false`.
- `LidarReprojectOptions` now carries shared epoch-aware routing parameters from `wbprojection`,
  and point reprojection helpers route through the epoch-aware CRS APIs when those options are
  supplied.
### Added
- **CopcReader VLR access:** `CopcReader` now stores and exposes VLRs via a new `vlrs()` method,
  matching the API of `LasReader`. This allows downstream code to access VLRs without reopening
  the file, reducing I/O overhead and improving CRS extraction efficiency in COPC readers.
- **Parallel COPC decompression** (`copc-parallel` / `parallel` feature): `CopcReader::read_all_nodes`
  now has two execution paths. When the `copc-parallel` feature is enabled (which it is when
  `wbtools_oss` depends on `wblidar` with `features = ["parallel"]`), the reader:
  1. Sorts all hierarchy entries by file offset and performs a single sequential forward-read
     pass to collect all compressed chunk bytes (minimising seek overhead on buffered/rotational
     storage).
  2. Decompresses all chunks in parallel using rayon, fully exploiting available CPU cores for
     the LASzip decompression step.
  The sequential fallback (`not(copc-parallel)`) is unchanged. The internal free function
  `decode_chunk` was extracted from `decode_node_points` to enable thread-safe decode without
  holding a mutable reference to the reader.
### Fixed
- **GeoKeyDirectory EPSG extraction:** The `find_epsg` function now prioritizes ProjectedCSTypeGeoKey
  (ID 3072) over GeographicTypeGeoKey (ID 2048) when both are present in a GeoKeyDirectory VLR.
  This ensures that LAS files with both geographic and projected coordinate system definitions
  (which is common when the file contains NAD83 geographic + UTM projected) correctly extract the
  projected EPSG code (e.g. EPSG:32145 for NAD83/Vermont) instead of the geographic code
  (e.g. EPSG:4269 for NAD83). This fix resolves missing CRS information on TIN gridding outputs
  when the source LAS file uses GeoKeyDirectory for CRS storage.
- **COPC CRS propagation:** `PointCloud::read` on COPC (LAS 1.4) files now correctly extracts
  the CRS from Extended VLRs (EVLRs) in addition to standard VLRs. LAS 1.4 files commonly store
  the WKT CRS record (record_id 2112) as an EVLR after the point data, which the previous
  implementation never read. All tools that grid COPC point clouds (e.g. `lidar_tin_gridding`)
  were silently producing rasters with no projection assigned; they now correctly inherit the
  source CRS (e.g. EPSG:32145).
- `default_las_config` (used by all `PointCloud::write` / `write_las` / `write_laz` paths) now
  auto-computes `x_offset`, `y_offset`, `z_offset` from `floor(min)` of the point cloud's
  bounding box instead of leaving them at `0.0`. The previous default caused silent i32 overflow
  when storing UTM northings (or other large coordinates) with `scale = 0.001`, because values
  such as 4 800 000 m exceeded the i32 range (~±2 147 483). The overflow saturated all affected
  coordinates to `i32::MAX`, collapsing every point to the same Y value and breaking all
  downstream triangulation-based tools (e.g. `improved_ground_point_filter`).
### Added
- Added in-process LiDAR memory-store foundation (`memory://lidar/<id>`) via new
  `memory_store` module with APIs for put/get/replace/remove/clear/count and
  memory-path helpers.
- Added initial `hdf_adapter` module with a minimal provider trait (`HdfDatasetProvider`) and
  `WbhdfDatasetProvider` implementation for bounded i16 dataset-window reads delegated to
  `wbhdf::hdf4::decode_hdf4_sds_i16_window_at_in_file(...)`.
- Added first concrete Tier 1 GEDI mapping helper in `hdf_adapter`:
  `read_gedi_l2b_canopy_style_f32_window_in_file(...)`, which currently targets
  `/BEAM0000/elev_lowestmode` using the validated contiguous offset path while generalized
  object-header-driven offset resolution is still in progress.
- Added fixture-backed `wblidar` adapter test coverage for the GEDI Tier 1 mapping helper,
  validating the first reference window against known expected values when `WBHDF_FIXTURE_DIR`
  provides the GEDI sample fixture.
- Added second Tier 1 ingestion path in `hdf_adapter` for ICESat-2 ATL08 canopy data:
  `read_icesat2_atl08_h_canopy_f32_window_in_file(...)`, including deterministic fill-to-nodata
  mapping and bounded window extraction for the first validated chunk path.
- Added dynamic ATL08 beam-group path discovery helper
  `resolve_icesat2_atl08_h_canopy_path_in_file(...)` with candidate enumeration across
  `gt1l/gt1r/gt2l/gt2r/gt3l/gt3r` and deterministic missing-path error semantics.
- Added fixture-backed ATL08 adapter tests validating first-chunk decode counts
  (`valid=3640`, `nodata=6360`) plus explicit missing-path behavior coverage.
- Added `hdf_products` provider-registry layer for HDF LiDAR family dispatch:
  - `HdfLidarProductProvider` trait + `HdfLidarProductRegistry::with_defaults()`
    (ATL08 + GEDI providers),
  - canonical family resolution APIs (`detect_hdf_lidar_product_family`,
    `resolve_hdf_lidar_product`),
  - unified canopy-window dispatch entrypoint
    (`read_hdf_lidar_canopy_f32_window_in_file(...)`) that routes to product-specific
    adapter reads.
- Replaced fixed ATL08 `h_canopy` object-header offset dependency with bounded dynamic
  v1 object-header discovery + ranking (`resolve_icesat2_atl08_h_canopy_object_header_in_file(...)`),
  so canopy reads no longer require a hardcoded fixture-specific header address.
- Tightened ATL08 dynamic header ranking to incorporate resolved beam-path affinity
  (marker proximity from the selected `/<gt*>/land_segments/canopy/h_canopy` path), reducing
  ambiguity when multiple chunked v1 object-header candidates are present.
- Added runtime diagnostics counters for bounded HDF canopy reads via
  `read_hdf_lidar_canopy_f32_window_with_diagnostics(...)` and
  `HdfLidarReadDiagnostics` (`chunks_visited`, `chunks_decoded`, `filter_failures`,
  `unsupported_layout_failures`, `invalid_chunk_failures`, `dataset_resolution_failures`).
- Added bounded-memory safeguards for ATL08 canopy chunk decode flow with explicit
  compressed/decompressed size caps (`ICESAT2_ATL08_MAX_COMPRESSED_CHUNK_BYTES`,
  `ICESAT2_ATL08_MAX_DECOMPRESSED_CHUNK_BYTES`) and deterministic `UnsupportedLayout`
  diagnostics when limits are exceeded.
- Added malformed/partial-corruption regression coverage for ATL08-like HDF inputs in
  unified dispatch diagnostics tests, asserting deterministic unsupported-layout failure
  classification and counters.

## [0.1.1] – 2026-05-09 (Reaffirmed)

### Testing
- Interop Phase B LiDAR cases: L01 (LAS 1.4), L02 (LAZ compressed), L03 (COPC) all passing.
- Python binding architecture decoupled from WbW-R; native wblidar write path now fully backend-native.

*Note: Version 0.1.1 is being published as-is as part of the interop release milestone (2026-05-09) to affirm Phase B validation.*

### Changed
- Added `PointCloud::apply_columns_range(...)` to support in-place updates over
	bounded point-index ranges, enabling chunk-by-chunk edit pipelines.
- Public exports in `lib.rs` now include chunked read/rewrite frontend types and
	helper functions for downstream crate reuse.
- LAZ output now applies optional `chunk_size` and `compression_level` controls
	when provided through the frontend write options.
- COPC output now applies optional `max_points_per_node`, `max_depth`, and
	`node_point_ordering` controls when provided through the frontend write
	options.
- Export surface in `lib.rs` now re-exports write-option types and functions
	so downstream crates can consume the new API directly.

## [0.1.0] - 2026-03-31
### Added
- Initial published release.
