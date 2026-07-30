//! # wbraster
//!
//! A pure-Rust library for reading and writing common raster GIS formats.
//!
//! ## Supported Formats
//!
//! | Format | Read | Write | Extension(s) |
//! |---|---|---|---|
//! | DTED | ✓ | ✓ | `.dt0`, `.dt1`, `.dt2` |
//! | Esri ASCII Grid | ✓ | ✓ | `.asc`, `.grd` |
//! | Esri Binary Grid | ✓ | ✓ | `.adf` (workspace) |
//! | Esri Float Grid | ✓ | ✓ | `.flt` + `.hdr` |
//! | GRASS ASCII Raster | ✓ | ✓ | `.asc`, `.txt` |
//! | Surfer GRD | ✓ | ✓ | `.grd` |
//! | PCRaster | ✓ | ✓ | `.map` |
//! | SAGA Binary Grid | ✓ | ✓ | `.sdat` / `.sgrd` |
//! | Idrisi/TerrSet Raster | ✓ | ✓ | `.rst` / `.rdc` |
//! | ER Mapper | ✓ | ✓ | `.ers` / `.ers` data |
//! | ERDAS IMAGINE HFA | ✓ | — | `.img` |
//! | ENVI HDR Labelled Raster | ✓ | ✓ | `.hdr` + `.img/.dat/.bin/.raw/.bil/.bsq/.bip` |
//! | GeoTIFF / BigTIFF / COG | ✓ | ✓ | `.tif` / `.tiff` |
//! | GeoPackage Raster (Phase 4) | ✓ | ✓ | `.gpkg` |
//! | JPEG 2000 / GeoJP2 | ✓ | ✓ | `.jp2` |
//! | PNG + World File | ✓ | ✓ | `.png` + `.pgw/.pngw/.wld` |
//! | JPEG + World File | ✓ | ✓ | `.jpg/.jpeg` + `.jgw/.jpgw/.jpegw/.wld` |
//! | XYZ ASCII Grid | ✓ | ✓ | `.xyz` |
//! | Zarr v2/v3 (MVP) | ✓ | ✓ | `.zarr` |
//!
//! ## Quick Start
//!
//! ```rust
//! use wbraster::{Raster, RasterFormat, RasterConfig};
//!
//! // Create a new raster in memory
//! let mut r = Raster::new(RasterConfig {
//!     cols: 100,
//!     rows: 100,
//!     bands: 1,
//!     x_min: 0.0,
//!     y_min: 0.0,
//!     cell_size: 1.0,
//!     nodata: -9999.0,
//!     ..Default::default()
//! });
//!
//! // Set some values
//! r.set(0, 50isize, 50isize, 42.0).unwrap();
//! assert_eq!(r.get(0, 50isize, 50isize), 42.0);
//!
//! // Write to disk
//! r.write("output.asc", RasterFormat::EsriAscii).unwrap();
//!
//! // Read back
//! let r2 = Raster::read("output.asc").unwrap();
//! assert_eq!(r2.get(0, 50isize, 50isize), 42.0);
//! ```
//!
//! ## COG-first write API
//!
//! ```rust,no_run
//! use wbraster::{CogWriteOptions, GeoTiffCompression, Raster};
//!
//! let raster = Raster::read("input.tif").unwrap();
//!
//! // Fast convenience defaults (deflate, tile=512, bigtiff=false)
//! raster.write_cog("output_default.cog.tif").unwrap();
//!
//! // Convenience defaults with custom tile size
//! raster
//!     .write_cog_with_tile_size("output_tile256.cog.tif", 256)
//!     .unwrap();
//!
//! // COG-focused typed options (compression + bigtiff + tile size)
//! let opts = CogWriteOptions {
//!     compression: Some(GeoTiffCompression::Deflate),
//!     bigtiff: Some(false),
//!     tile_size: Some(256),
//! };
//! raster
//!     .write_cog_with_options("output_opts.cog.tif", &opts)
//!     .unwrap();
//! ```
//!
//! ## JPEG2000 default lossy quality
//!
//! ```rust,no_run
//! use wbraster::{
//!     Jpeg2000Compression,
//!     Jpeg2000WriteOptions,
//!     JPEG2000_DEFAULT_LOSSY_QUALITY_DB,
//!     Raster,
//!     RasterFormat,
//! };
//!
//! let raster = Raster::read("input.tif").unwrap();
//! let opts = Jpeg2000WriteOptions {
//!     compression: Some(Jpeg2000Compression::Lossy {
//!         quality_db: JPEG2000_DEFAULT_LOSSY_QUALITY_DB,
//!     }),
//!     decomp_levels: Some(5),
//!     color_space: None,
//! };
//! raster.write_jpeg2000_with_options("output.jp2", &opts).unwrap();
//! raster.write("output_default.jp2", RasterFormat::Jpeg2000).unwrap();
//! ```

#![deny(missing_docs)]
#![warn(clippy::all)]
#![allow(clippy::cast_possible_truncation)]
#![allow(clippy::cast_precision_loss)]
#![allow(clippy::cast_sign_loss)]

pub mod color_math;
pub mod crs_info;
pub mod error;
pub mod formats;
pub mod io_utils;
/// In-process raster memory store for passing rasters between tools without disk I/O.
pub mod memory_store;
pub mod packages;
pub mod raster;

pub use color_math::{hsi2value, hsi_to_rgb_norm, rgb_to_hsi_norm, value2hsi, value2i};
pub use crs_info::CrsInfo;
pub use error::{RasterError, Result};
pub use formats::geotiff::{
    CogWriteOptions, GeoTiffCompression, GeoTiffLayout, GeoTiffWriteOptions,
};
pub use formats::jpeg2000::{
    Jpeg2000ColorSpace, Jpeg2000Compression, Jpeg2000WriteOptions,
    JPEG2000_DEFAULT_LOSSY_QUALITY_DB,
};
pub use formats::RasterFormat;
pub use packages::dimap_bundle::DimapBundle;
pub use packages::iceye_bundle::IceyeBundle;
pub use packages::landsat_bundle::{
    LandsatBundle, LandsatMission, LandsatProcessingLevel, LandsatReflectanceCoefficients,
    LandsatThermalConstants,
};
pub use packages::maxar_worldview_bundle::MaxarWorldViewBundle;
pub use packages::optical::{
    DimapBundleProvider, LandsatBundleProvider, ResolvedOpticalBundle, SensorBundleProvider,
    SensorBundleRegistry, Sentinel2SafeBundleProvider,
};
pub use packages::planetscope_bundle::PlanetScopeBundle;
pub use packages::radarsat2_bundle::Radarsat2Bundle;
pub use packages::rcm_bundle::RcmBundle;
pub use packages::safe_bundle::{detect_safe_mission, open_safe_bundle, SafeBundle, SafeMission};
pub use packages::sensor_bundle::{
    detect_sensor_bundle_family, detect_sensor_bundle_family_path, open_sensor_bundle,
    open_sensor_bundle_path, OpenedSensorBundle, SensorBundle, SensorBundleFamily,
};
pub use packages::sentinel1_safe::{
    Sentinel1Burst, Sentinel1BurstList, Sentinel1CalibrationLut, Sentinel1CalibrationTarget,
    Sentinel1CalibrationVector, Sentinel1GeolocationGrid, Sentinel1GeolocationGridPoint,
    Sentinel1NoiseLut, Sentinel1NoiseVector, Sentinel1OrbitVector, Sentinel1SafePackage,
};
pub use packages::sentinel2_safe::{Sentinel2ProductLevel, Sentinel2SafePackage};
pub use raster::{
    AntimeridianPolicy, BandView, DataType, DestinationFootprint, Extent, GridSizePolicy, NoData,
    NodataPolicy, Raster, RasterConfig, ReprojectOptions, ResampleMethod, Statistics,
    StatisticsComputationMode,
};
