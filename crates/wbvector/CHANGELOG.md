# Changelog

All notable changes to this project will be documented in this file.

The format is based on Keep a Changelog, and this project follows Semantic Versioning while in pre-1.0 development.

## [Unreleased]

### Fixed
- **Shapefile writer: streaming I/O and file-size guard.** The previous writer
  assembled the entire `.shp` and `.shx` content as in-memory `Vec<u8>` before
  writing to disk. For large outputs (e.g. state-wide contour layers) this
  imposed a peak RAM cost roughly equal to the final file size, and the
  `(shp.len() / 2) as u32` file-length cast would silently overflow for files
  larger than ~8.6 GB, producing a corrupt header. Changed to stream records
  directly to disk via `BufWriter<File>`, seeking back to patch the 100-byte
  header's file-length field after all records are written. Added a per-record
  u64 byte counter with a pre-write guard against `i32::MAX × 2` bytes (the
  Shapefile spec maximum); if the limit would be exceeded the partially-written
  files are deleted and `GeoError::FileTooLarge` is returned with a message
  directing the caller to use GeoPackage. Added `GeoError::FileTooLarge(String)`
  variant to the error enum.

### Added
- **`GpkgStreamWriter`** — a new streaming GeoPackage feature writer that lets
  callers append features one at a time without pre-building a complete `Layer`.
  `create()` initialises the SQLite B-tree and feature-table DDL; `push_feature()`
  accepts individual features while tracking the bounding box incrementally;
  `finish()` inserts the `gpkg_contents` row with the accumulated bbox and writes
  the final file to disk.
- **`GeoJsonStreamWriter`** — streams GeoJSON directly to a `BufWriter<File>`,
  writing the `FeatureCollection` header on `create()`, one feature per
  `push_feature()`, and the closing delimiter in `finish()`.  No intermediate
  `Layer` or in-memory string accumulation.
- **`FgbStreamWriter`** — streams FlatGeobuf directly to a `BufWriter<File>`.
  The header is written with `features_count = 0` (streaming/unknown) and
  `index_node_size = 0` (no spatial index) so features can be appended one at a
  time.  The output is valid FlatGeobuf v3 readable by any compliant reader;
  the packed R-tree is omitted as a known streaming trade-off.
- **`VectorStreamWriter`** — a format-agnostic routing enum that selects
  `GpkgStreamWriter`, `GeoJsonStreamWriter`, or `FgbStreamWriter` for the three
  natively-streaming formats and falls back to `Layer` accumulation for all
  others (Shapefile, GML, KML, etc.).  `open(path, schema)` detects the output
  format from the extension; `push_feature` and `finish` are the same for all
  variants.  `GpkgStreamWriter`, `GeoJsonStreamWriter`, and `FgbStreamWriter` are
  also re-exported at the crate root for direct use.
- Interoperability-focused datum handling is now the sole vector reprojection
	mode, routed through `CrsTransformPolicy::Auto`.
- `VectorReprojectOptions::epoch_transform` plus
	`VectorReprojectOptions::with_epoch_transform_options(...)` for optional
	epoch-aware routing controls (coordinate epoch, reference epochs,
	operation-code override, preferred-operation flag, and epoch policy).
- `VectorReprojectOptions::warn_on_area_of_use_mismatch` (default `false`) and
	`VectorReprojectOptions::with_area_of_use_warning(bool)` to emit non-fatal
	warnings when sampled layer extent points appear outside source/destination
	CRS area of use definitions during vector reprojection.
- Initial TopoJSON (`.topojson`) reader and writer module (`wbvector::topojson`) with dependency-light parsing and serialization.
- TopoJSON routing in `VectorFormat` detection and crate-level sniffed read/write dispatch.
- TopoJSON baseline unit coverage for parse and read/write roundtrip behavior.
- `TopoJsonWriteOptions` with optional quantization (`transform` + delta-encoded arcs) and optional root `bbox` emission via `topojson::write_with_options` and `topojson::to_string_with_options`.
- Expanded TopoJSON interop fixtures and tests covering object-map variants, foreign members, reversed arcs, and quantized writer roundtrip tolerance.
- Added TopoJSON fixture provenance manifest (`tests/fixtures/topojson_io/provenance_manifest.json`) and a test guard that enforces manifest/fixture-set parity.

### Changed
- Vector coordinate reprojection now routes through
	`Crs::transform_to_with_policy(..., CrsTransformPolicy::Auto)` by default,
	eliminating the temporary legacy datum-mode branch.
- Vector coordinate reprojection can now route through `wbprojection`
	epoch-aware APIs when epoch transform options are supplied, with explicit
	static fallback behavior controlled by `EpochPolicy`.

### Fixed
- `Schema` now supports replacing an existing field definition by name, allowing tools to upsert Float metadata over stale Integer fields instead of silently ignoring duplicate names.
- Add Geometry Attributes now overwrites existing geometry-measure fields in place, preserving floating-point precision on reruns so AREA/LENGTH/PERIM values do not collapse to integer zeros.
- Shapefile polygon parsing now preserves exteriors even when rings use uniform CCW winding, preventing valid polygons from being decoded as empty geometries on real-world datasets.
- FlatGeobuf `from_bytes` now avoids false-negative expected-count enforcement
	for direct native parsing and no longer fails valid in-memory roundtrips when
	header/index scan candidates differ across producer layouts.
- FlatGeobuf legacy geometry decode now includes explicit overflow/truncation
	bounds checks for coordinate and ends buffers, preventing slice overrun
	panics on malformed/truncated geometry payloads.

## [0.1.5] – 2026-06-30

### Fixed
- GeoPackage writer now properly quotes table and column names in SQL CREATE TABLE statements, enabling support for columns with special characters (e.g., "dist.m" from CSV imports). Fixes crash when writing GeoPackages with field names containing dots, hyphens, or other non-alphanumeric characters. Added regression test `columns_with_special_characters_are_quoted`.
- GeoPackage writer now writes the correct SQLite `application_id` (`0x47504B47` = "GPKG") and `user_version` (`0x000027D8` = GPKG 1.2.0) in the file header. Previously `0x47503130` ("GP10") was written, causing GDAL and QGIS to refuse to open the file as a GeoPackage. This fix enables GDAL-based applications (including QGIS) to correctly recognize and load GeoPackage files generated by wbvector.

### Testing
- All 17 existing GeoPackage tests pass with the new quoted-identifier behavior.
- New test verifies roundtrip for columns with special characters: dots (dist.m), hyphens (name-en), and normal names.

## [0.1.3] – 2026-05-09

### Changed
- FlatGeobuf indexed interoperability restored via internal native reader/writer enhancements (no external flatgeobuf crate dependency).
- Lean dependency compliance enforced: FlatGeobuf indexed operations use internal packed-index logic.

### Fixed
- V04 FlatGeobuf indexed read/write now deterministic and reliable under all interop test conditions.
- Telemetry for indexed parse decisions remains env-gated for operational insight.

### Testing
- Interop Phase B V04 case passes; full Phase B 15/15 passing; Phase C.1 vector cases (V05–V07) all passing.

## [0.1.2] - 2026-05-07

### Added
- Introduced a new in-process vector memory store module at `wbvector::memory_store` for zero-disk vector handoff between components.
- Added memory-path API for vectors with `memory://vector/<id>` handles, including:
	`VECTOR_MEMORY_PREFIX`, `vector_is_memory_path`, `vector_path_to_id`, and `make_vector_memory_path`.
- Added vector store lifecycle API:
	`put_vector`, `put_vector_arc`, `get_vector_arc_by_id`, `get_vector_arc_by_path`, `get_vector_by_id`,
	`replace_vector_by_id`, `replace_vector_by_path`, `remove_vector_by_id`, `remove_vector_by_path`,
	`clear_vectors`, and `vector_count`.
- Added unit tests covering vector memory-store put/get/remove/clear behavior.

### Fixed
- GeoPackage writer now treats `fid`/`FID` as reserved and ignores user-added schema fields with that name when creating table columns.
- Prevents malformed GeoPackage outputs caused by duplicate `fid` columns, so tools that auto-add a `FID` attribute can write valid `.gpkg` layers without per-tool changes.
- Fixed a severe GeoPackage write-time performance issue in the pure-Rust SQLite engine where each `INSERT` re-scanned the full table to compute the next rowid.
- GeoPackage writes now use a cached per-table next-rowid value, removing quadratic insert growth for large layers (e.g., dense dissolved polygon outputs).

## [0.1.1] - 2026-04-14

### Fixed
- Read GeoPackage layers correctly when table schemas use bracket-quoted identifiers and uppercase `FID` column names.
- Preserve GeoPackage feature IDs by falling back to SQLite rowids when `INTEGER PRIMARY KEY` payload values are stored as `NULL` aliases.
- Resolves false geometry-loss symptoms in real parcel fixtures where valid multipolygon GeoPackage layers were previously read with missing geometries and synthetic fallback feature IDs.
- Populate `Layer.geom_type` when reading Shapefiles by mapping the `.shp` header shape type to `GeometryType`.
- Infer and set `Layer.geom_type` when reading GeoJSON `FeatureCollection` layers from the first feature with geometry.
- Set `Layer.geom_type` for GeoJSON single `Feature` and bare-geometry inputs.
- Infer and set `Layer.geom_type` when reading GeoParquet layers from the first feature geometry.
- Resolves downstream false validation failures in tools that require line geometries (e.g., network readiness workflows) when inputs are valid line-based datasets.

### Tests
- Extended `real_mississauga_parcel_fixture_decodes_when_enabled` GeoPackage smoke test to assert that decoded multipolygon ring coordinates produce non-zero shoelace areas (100/100 sample), confirming end-to-end geometry fidelity for downstream calibration workflows.

## [0.1.0] - 2026-03-31
### Added
- Initial published release.
