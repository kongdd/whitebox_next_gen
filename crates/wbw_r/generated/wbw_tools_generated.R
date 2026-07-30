# Auto-generated wbw_r wrappers
# Regenerate via generate_r_wrapper_module_with_options(include_pro, tier).

wbw_make_session <- function(floating_license_id = NULL, include_pro = NULL, tier = "open", provider_url = NULL, machine_id = NULL, customer_id = NULL) {
  resolved_include_pro <- if (is.null(include_pro)) !is.null(floating_license_id) else include_pro

  run_tool <- function(tool_id, args = list()) {
    args_json <- jsonlite::toJSON(args, auto_unbox = TRUE, null = "null")
    if (!is.null(floating_license_id)) {
      out_json <- run_tool_json_with_floating_license_id_options(
        tool_id,
        args_json,
        floating_license_id,
        resolved_include_pro,
        tier,
        provider_url,
        machine_id,
        customer_id
      )
    } else {
      out_json <- run_tool_json_with_options(tool_id, args_json, resolved_include_pro, tier)
    }
    out <- jsonlite::fromJSON(out_json, simplifyVector = FALSE)
    wbw_coerce_tool_output(out, session = session)
  }

  list_tools <- function() {
    if (!is.null(floating_license_id)) {
      out_json <- list_tools_json_with_floating_license_id_options(
        floating_license_id,
        resolved_include_pro,
        tier,
        provider_url,
        machine_id,
        customer_id
      )
    } else {
      out_json <- list_tools_json_with_options(resolved_include_pro, tier)
    }
    jsonlite::fromJSON(out_json, simplifyVector = FALSE)
  }

  session <- new.env(parent = emptyenv())
  session$run_tool <- run_tool
  session$list_tools <- list_tools
  session$abs <- function(...) {
    # Calculates the absolute value of each raster cell.
    run_tool("abs", list(...))
  }
  session$accumulation_curvature <- function(...) {
    # Calculates accumulation curvature from a DEM.
    run_tool("accumulation_curvature", list(...))
  }
  session$adaptive_filter <- function(...) {
    # The Adaptive Filter adjusts filtering strength dynamically based on local image statistics (mean, variance, kurtosis), enabling context-aware smoothing that responds to scene characteristics. Implementation partitions images into moving windows, computes local statistics (detecting noise-dominated versus feature-dominated regions), and selects filter parameters accordingly. Flat regions smooth aggressively; complex regions filter gently. Mathematical basis uses statistical tests to identify local character: regions with variance below threshold smooth heavily; regions exceeding threshold preserve detail. Key features include automatic parameter adaptation (user specifies ranges; algorithm selects locally), applicability to any filter kernel (Gaussian, median, morphological), and effectiveness on optical and radar imagery. Adaptive filtering excels in preprocessing heterogeneous satellite mosaics (different sensors, acquisition conditions), LiDAR point-cloud smoothing (preserves vegetation edges in forests; smooths ground in open areas), selective SAR speckle reduction respecting both targets and background, and multi-temporal image stacking. Output interpretation reveals that homogeneous regions undergo intensive filtering (low local variance → strong smoothing); complex regions filter conservatively (high variance → minimal processing). Smoothing radius dynamically adjusts per-region: flat areas receive large-radius filtering; textured areas receive small-radius or no filtering. Output ranges remain within input; examine spatial filtering-strength map to validate adaptation. Statistics shift toward local means in smooth regions; complex regions remain largely unchanged. Common artifacts include potential over-smoothing at region boundaries (smooth transition typically applied) and sensitivity to noise-variance relationships. Verify adaptation by analyzing local variance maps. Apply in automated preprocessing pipelines handling multi-source data where uniform filtering insufficient.
    run_tool("adaptive_filter", list(...))
  }
  session$add <- function(...) {
    # Adds two rasters on a cell-by-cell basis.
    run_tool("add", list(...))
  }
  session$add_field <- function(...) {
    # Adds a new attribute field with an optional default value.
    run_tool("add_field", list(...))
  }
  session$add_geometry_attributes <- function(...) {
    # Automatically calculates geometric properties (area, length, perimeter, centroid) and adds them as new fields, supporting both planar and geodesic measurements.
    run_tool("add_geometry_attributes", list(...))
  }
  session$add_point_coordinates_to_table <- function(...) {
    # Copies a point layer and appends XCOORD and YCOORD attribute fields.
    run_tool("add_point_coordinates_to_table", list(...))
  }
  session$aggregate_raster <- function(...) {
    # Reduces raster resolution by aggregating blocks using mean, sum, min, max, or range.
    run_tool("aggregate_raster", list(...))
  }
  session$anisotropic_diffusion_filter <- function(...) {
    # Anisotropic diffusion filtering implements iterative edge-preserving smoothing via directional diffusion processes that distinguish between edges and flat regions. The algorithm iteratively updates each pixel based on weighted differences with neighbors, using a conductance function that reduces diffusion across high-gradient boundaries while permitting smoothing within homogeneous regions. Implementation solves the partial differential equation ∂I/∂t = div(c(|∇I|)∇I), where conductance c(·) adapts to local gradient magnitude. This data-driven approach preserves sharp transitions while progressively reducing noise in uniform areas. Key features include true edge preservation without explicit edge masks, automatic scale selection via iteration count, effective noise reduction maintaining feature sharpness, and applicability to single and multispectral data. Anisotropic diffusion excels in LiDAR point cloud smoothing preserving terrain breaks, satellite image denoising for subtle geological feature detection, SAR speckle reduction maintaining radar-target edges, and medical/scientific imagery where edge fidelity is critical. Output interpretation requires understanding that smooth regions progressively homogenize (values converge toward local mean), while edges steepen until stabilizing. Early iterations (t<5) yield mild noise reduction; intermediate iterations (t=5-20) provide substantial smoothing; excessive iterations (t>50) risk boundary over-enhancement or false features. Output values remain in source data ranges; statistics shift toward regional means as processing proceeds. Monitor output variance to assess smoothing completeness. Common metrics include signal-to-noise ratio improvement and edge sharpness indices. Apply carefully in multi-scale workflows where edge preservation precision directly impacts downstream classification or change detection accuracy.
    run_tool("anisotropic_diffusion_filter", list(...))
  }
  session$anova <- function(...) {
    # Performs one-way ANOVA on raster values grouped by class raster categories.
    run_tool("anova", list(...))
  }
  session$arccos <- function(...) {
    # Computes the inverse cosine (arccos) of each raster cell.
    run_tool("arccos", list(...))
  }
  session$arcosh <- function(...) {
    # Computes the inverse hyperbolic cosine of each raster cell.
    run_tool("arcosh", list(...))
  }
  session$arcsin <- function(...) {
    # Computes the inverse sine (arcsin) of each raster cell.
    run_tool("arcsin", list(...))
  }
  session$arctan <- function(...) {
    # Computes the inverse tangent (arctan) of each raster cell.
    run_tool("arctan", list(...))
  }
  session$arsinh <- function(...) {
    # Computes the inverse hyperbolic sine of each raster cell.
    run_tool("arsinh", list(...))
  }
  session$artanh <- function(...) {
    # Computes the inverse hyperbolic tangent of each raster cell.
    run_tool("artanh", list(...))
  }
  session$ascii_to_las <- function(...) {
    # Format conversion: CSV→LAS batch processing. Parses space/comma/tab-delimited text files (x,y,z,intensity,class,returns,angle,time) to LAS with EPSG metadata.
    run_tool("ascii_to_las", list(...))
  }
  session$aspect <- function(...) {
    # Direction of maximum slope (0°=N, 90°=E, 180°=S, 270°=W). Critical for solar radiation, vegetation patterns, microclimate, and exposure analysis.
    run_tool("aspect", list(...))
  }
  session$assess_route <- function(...) {
    # Segments route lines and evaluates per-segment terrain metrics from a DEM.
    run_tool("assess_route", list(...))
  }
  session$atan2 <- function(...) {
    # Computes the four-quadrant inverse tangent using two rasters on a cell-by-cell basis.
    run_tool("atan2", list(...))
  }
  session$attribute_correlation <- function(...) {
    # Performs Pearson correlation analysis on numeric vector attribute fields.
    run_tool("attribute_correlation", list(...))
  }
  session$attribute_histogram <- function(...) {
    # Creates a histogram for numeric field values in a vector attribute table.
    run_tool("attribute_histogram", list(...))
  }
  session$attribute_scattergram <- function(...) {
    # Computes scatterplot summary statistics between two numeric vector fields.
    run_tool("attribute_scattergram", list(...))
  }
  session$average_flowpath_slope <- function(...) {
    # Calculates average slope gradient of flowpaths passing through each DEM cell.
    run_tool("average_flowpath_slope", list(...))
  }
  session$average_horizon_distance <- function(...) {
    # Calculates average distance to horizon across azimuth directions.
    run_tool("average_horizon_distance", list(...))
  }
  session$average_normal_vector_angular_deviation <- function(...) {
    # Calculates local mean angular deviation between original and smoothed surface normals.
    run_tool("average_normal_vector_angular_deviation", list(...))
  }
  session$average_overlay <- function(...) {
    # Computes the per-cell average across a raster stack, ignoring NoData unless all inputs are NoData.
    run_tool("average_overlay", list(...))
  }
  session$average_upslope_flowpath_length <- function(...) {
    # Computes the average upslope flowpath length passing through each DEM cell.
    run_tool("average_upslope_flowpath_length", list(...))
  }
  session$balance_contrast_enhancement <- function(...) {
    # Reduces colour bias in a packed RGB image using per-channel parabolic stretches.
    run_tool("balance_contrast_enhancement", list(...))
  }
  session$basins <- function(...) {
    # Delineates all D8 drainage basins that drain to valid-data edges.
    run_tool("basins", list(...))
  }
  session$bilateral_filter <- function(...) {
    # Edge-preserving bilateral smoothing via spatial + intensity kernels. Superior to Gaussian for detail preservation. Sigma_dist=radius, sigma_int=edge-preservation threshold. RGB-aware.
    run_tool("bilateral_filter", list(...))
  }
  session$block_maximum <- function(...) {
    # Rasterizes point features by assigning the maximum value observed within each output cell.
    run_tool("block_maximum", list(...))
  }
  session$block_minimum <- function(...) {
    # Rasterizes point features by assigning the minimum value observed within each output cell.
    run_tool("block_minimum", list(...))
  }
  session$bool_and <- function(...) {
    # Computes a logical AND of two rasters on a cell-by-cell basis.
    run_tool("bool_and", list(...))
  }
  session$bool_not <- function(...) {
    # Computes a logical NOT of each raster cell, outputting 1 for zero-valued cells and 0 otherwise.
    run_tool("bool_not", list(...))
  }
  session$bool_or <- function(...) {
    # Computes a logical OR of two rasters on a cell-by-cell basis.
    run_tool("bool_or", list(...))
  }
  session$bool_xor <- function(...) {
    # Computes a logical XOR of two rasters on a cell-by-cell basis.
    run_tool("bool_xor", list(...))
  }
  session$boundary_shape_complexity <- function(...) {
    # Calculates raster patch boundary-shape complexity using a line-thinned skeleton branch metric.
    run_tool("boundary_shape_complexity", list(...))
  }
  session$brdf_normalization <- function(...) {
    # Single-scene BRDF normalization using C-correction or Minnaert approach with DEM slope/aspect geometry.
    run_tool("brdf_normalization", list(...))
  }
  session$breach_depressions_least_cost <- function(...) {
    # Breaches depressions in a DEM using a constrained least-cost pathway search.
    run_tool("breach_depressions_least_cost", list(...))
  }
  session$breach_single_cell_pits <- function(...) {
    # Breaches single-cell pits in a DEM by carving one-cell channels.
    run_tool("breach_single_cell_pits", list(...))
  }
  session$breakline_mapping <- function(...) {
    # Maps breaklines by thresholding log-transformed curvedness and vectorizing thinned linear features.
    run_tool("breakline_mapping", list(...))
  }
  session$buffer_raster <- function(...) {
    # Creates a binary buffer zone around non-zero, non-NoData raster cells within a specified distance.
    run_tool("buffer_raster", list(...))
  }
  session$buffer_vector <- function(...) {
    # Extends geometries by a specified distance, creating polygon buffers with customizable cap/join styles. Optional dissolve merges overlapping buffers into unified polygons.
    run_tool("buffer_vector", list(...))
  }
  session$build_network_topology <- function(...) {
    # Builds a noded topological line network with stable edge and node outputs.
    run_tool("build_network_topology", list(...))
  }
  session$build_object_hierarchy_multiscale <- function(...) {
    # Hierarchical object network constructed through iterative aggregation across multiple segmentation scales, progressively merging finer segments based on spectral similarity and spatial adjacency. Builds tree structure where leaf nodes represent fine-scale segments and root represents entire image. Containment relationships encode parent-child (part-whole) object hierarchies enabling multi-resolution analysis and scale-adaptive object queries across hierarchy levels. Key Features: Multiscale segmentation hierarchy; tracks part-whole relationships; supports nested object queries; enables scale-adaptive analysis; memory-efficient hierarchical representation; facilitates cascaded classification. Use Cases: Hierarchical landcover mapping; building complex extraction from components; agricultural field detection; vegetation strata analysis; urban district delineation; wetland mapping with subcomponent classification. Output Interpretation: Output is hierarchical object database encoding scale-dependent structure. Query objects at specific scales; intermediate scales reveal transitional object scales balancing detail/generalization. Parent-child relationships reveal compositional structure. Scale-level statistical distributions characterize object size/shape properties at each hierarchy level, enabling scale-optimal classification strategy selection.
    run_tool("build_object_hierarchy_multiscale", list(...))
  }
  session$burn_streams <- function(...) {
    # Burns a stream network into a DEM by decreasing stream-cell elevations.
    run_tool("burn_streams", list(...))
  }
  session$burn_streams_at_roads <- function(...) {
    # Lowers stream elevations near stream-road crossings to breach road embankments in a DEM.
    run_tool("burn_streams_at_roads", list(...))
  }
  session$canny_edge_detection <- function(...) {
    # Applies Canny multi-stage edge detection (Gaussian blur → Sobel gradient → non-maximum suppression → double threshold → hysteresis).
    run_tool("canny_edge_detection", list(...))
  }
  session$casorati_curvature <- function(...) {
    # Calculates Casorati curvature from a DEM.
    run_tool("casorati_curvature", list(...))
  }
  session$ceil <- function(...) {
    # Rounds each raster cell upward to the nearest integer.
    run_tool("ceil", list(...))
  }
  session$centroid_raster <- function(...) {
    # Calculates the centroid cell for each positive-valued patch ID in a raster.
    run_tool("centroid_raster", list(...))
  }
  session$centroid_vector <- function(...) {
    # Computes the geographic center (mean coordinate of mass) for each vector feature, producing a point layer for label placement, clustering, and spatial analysis.
    run_tool("centroid_vector", list(...))
  }
  session$change_vector_analysis <- function(...) {
    # Performs change vector analysis on two-date multispectral datasets and returns magnitude and direction rasters.
    run_tool("change_vector_analysis", list(...))
  }
  session$circular_variance_of_aspect <- function(...) {
    # Calculates local circular variance of aspect within a moving neighbourhood.
    run_tool("circular_variance_of_aspect", list(...))
  }
  session$classify_buildings_in_lidar <- function(...) {
    # Marks points inside building footprints: assigns class 6 to all points spatially within polygon boundaries. Vector-based building extraction.
    run_tool("classify_buildings_in_lidar", list(...))
  }
  session$classify_lidar <- function(...) {
    # Automated point classification: ground, vegetation, buildings via local geometry (linearity, planarity) and RANSAC plane fitting. Geometry-based segmentation.
    run_tool("classify_lidar", list(...))
  }
  session$classify_objects_ensemble_pro <- function(...) {
    # Runs an ensemble-style object classification configuration tuned for higher stability across heterogeneous scenes.
    run_tool("classify_objects_ensemble_pro", list(...))
  }
  session$classify_objects_random_forest <- function(...) {
    # Trains ensemble Random Forest classifier on labeled segment training samples using spectral, morphological, and texture features as predictors. Constructs multiple decision trees through bootstrap sampling and feature randomization, then aggregates predictions through majority voting. Classification operates on per-segment feature vectors, assigning object class labels probabilistically based on ensemble consensus, enabling robust multi-class object categorization from OBIA features. Key features include ensemble learning combining multiple decision trees for robust classification, handling high-dimensional feature spaces typical of multispectral OBIA, classification confidence and probability estimates, feature importance ranking identifying discriminative properties, natural handling of non-linear feature interactions, and robustness to feature noise and redundancy. Use cases span multi-class land-cover classification from OBIA segments (urban, agricultural, forest, water), object-level supervised classification refined through training sample selection, change detection classification across temporal segmentation sequences, hierarchical classification (coarse habitat types refined to fine categories), and integration with manual training samples from visual interpretation. Output predicted class label identifies primary object type; confidence probability indicates classification certainty; low confidence suggests ambiguous intermediate objects; feature importance identifies which spectral/morphological properties drive classification decisions; classification map directly represents object type distribution; confusion between similar classes informs training refinement; probabilistic output enables uncertainty quantification.
    run_tool("classify_objects_random_forest", list(...))
  }
  session$classify_objects_rules_basic <- function(...) {
    # Applies transparent rule-based object classification from feature-operator-threshold rules CSV. Fully interpretable decision logic for domain expert workflows and regulatory compliance.
    run_tool("classify_objects_rules_basic", list(...))
  }
  session$classify_objects_rules_hierarchical <- function(...) {
    # Applies hierarchical rule-based object classification; currently uses ordered rules with deterministic fallback.
    run_tool("classify_objects_rules_hierarchical", list(...))
  }
  session$classify_objects_svm <- function(...) {
    # Classifies objects using an SVM-style workflow (implemented via robust object-classification backend defaults).
    run_tool("classify_objects_svm", list(...))
  }
  session$classify_overlap_points <- function(...) {
    # Identifies flight-line overlaps: detects grid cells with multiple point-source IDs, flags or removes overlap points. Quality control for acquisition validation.
    run_tool("classify_overlap_points", list(...))
  }
  session$clean_vector <- function(...) {
    # Removes null and invalid vector geometries (e.g., undersized lines/polygons) while preserving valid features and attributes.
    run_tool("clean_vector", list(...))
  }
  session$clip <- function(...) {
    # Clips input polygons to overlay polygon boundaries using topology-based intersection.
    run_tool("clip", list(...))
  }
  session$clip_lidar_to_polygon <- function(...) {
    # Spatial subset of point cloud: retains points inside polygon boundaries. Vector-based point selection for study-area extraction.
    run_tool("clip_lidar_to_polygon", list(...))
  }
  session$clip_raster_to_polygon <- function(...) {
    # Clips a raster to polygon extents; outside polygon cells are set to NoData.
    run_tool("clip_raster_to_polygon", list(...))
  }
  session$closest_facility_network <- function(...) {
    # Finds the minimum-cost network route from each incident point to its nearest reachable facility point.
    run_tool("closest_facility_network", list(...))
  }
  session$closing <- function(...) {
    # Performs a morphological closing operation using a rectangular structuring element.
    run_tool("closing", list(...))
  }
  session$cloude_pottier_decomposition <- function(...) {
    # Cloude-Pottier decomposition diagonalizes the coherency matrix from quad-polarimetric SAR data, extracting eigenvalues and eigenvectors characterizing scattering mechanisms. Entropy, anisotropy, and average alpha angle computed from eigenvectors characterize scattering disorder, mechanism dominance, and scattering type respectively. H-alpha parameter space enables physical scattering mechanism classification independent of amplitude variations, exploiting polarimetric phase information. Key Features: Quad-polarimetric SAR decomposition; phase information exploitation; physically meaningful scattering parameters; separates scattering mechanisms; robust to amplitude speckle; enables target classification and interpretation. Use Cases: SAR target recognition; forest biomass estimation; wetland characterization; ship/vehicle detection; landcover classification; polarimetric SAR data interpretation. Output Interpretation: Output includes entropy (disorder degree; 0=ordered scattering, 1=random), anisotropy (mechanism dominance 0-1), and alpha angle (scattering type: ~45°=dipole, ~30°=surface, ~60°=volume). H-alpha scatter plots reveal clustering patterns indicating scattering types. Double-bounce (urban) exhibits high alpha; surface scattering (water) exhibits low alpha; volume scattering (forest) exhibits intermediate values.
    run_tool("cloude_pottier_decomposition", list(...))
  }
  session$clump <- function(...) {
    # Groups contiguous equal-valued raster cells into unique patch identifiers.
    run_tool("clump", list(...))
  }
  session$colourize_based_on_class <- function(...) {
    # Colors points by class: ASPRS standard colors (green=veg, brown=ground, gray=building, etc). Blends with intensity for contrast. Classification visualization.
    run_tool("colourize_based_on_class", list(...))
  }
  session$colourize_based_on_point_returns <- function(...) {
    # Colors points by return order: first/intermediate/last returns use distinct colors. Multi-return pulse structure visualization for processing validation.
    run_tool("colourize_based_on_point_returns", list(...))
  }
  session$compactness_ratio <- function(...) {
    # Computes compactness ratio (area / perimeter) for polygon features.
    run_tool("compactness_ratio", list(...))
  }
  session$concave_hull <- function(...) {
    # Creates concave hull polygons around input feature coordinates using the concaveman algorithm.
    run_tool("concave_hull", list(...))
  }
  session$conditional_evaluation <- function(...) {
    # Performs if-then-else conditional evaluation on raster cells.
    run_tool("conditional_evaluation", list(...))
  }
  session$conservative_smoothing_filter <- function(...) {
    # Conservative Smoothing implements non-linear filtering by replacing each pixel with the average of similar neighbors (within a defined intensity range), preserving edges while reducing noise. Implementation examines neighborhoods, identifies pixels within intensity threshold of central pixel, and averages these similar-value pixels. Mathematical formulation: F = (1/N) Σ(I_j : |I_j - I_center| < T), where T is similarity threshold and N is count of similar pixels. Key features include simple threshold-based similarity definition, effectiveness on optical and radar imagery, parameter interpretability (threshold controls edge-sharpness), and minimal computational overhead. Conservative Smoothing excels in multispectral satellite image preprocessing (reduces noise while preserving spectral boundaries), thermal image enhancement (smooths radiometric noise while maintaining temperature discontinuities), LiDAR classification smoothing (preserves vegetation/ground boundaries), and noisy survey data preprocessing. Output interpretation shows that homogeneous regions average completely (all neighbors similar); edges filter minimally (similar pixels only on same side). Threshold parameter controls edge preservation: small threshold (strict similarity) produces mild smoothing; large threshold (loose similarity) produces aggressive smoothing potentially losing edges. Output values exactly match input neighbor values (no interpolation; output is average of existing values). Statistics shift toward local clusters; heterogeneous regions show minimal change. Verify threshold effectiveness via visual inspection and local histogram analysis. Common artifacts include insufficient smoothing if thresholds are too strict and edge blurring if thresholds are too loose. Iteration count enables progressive filtering: single pass provides gentle smoothing; multiple passes intensify effect. Apply before classification where noise-driven category confusion must be reduced while class boundaries remain sharp.
    run_tool("conservative_smoothing_filter", list(...))
  }
  session$construct_vector_tin <- function(...) {
    # Constructs a triangular irregular network (TIN) from an input point set using Delaunay triangulation.
    run_tool("construct_vector_tin", list(...))
  }
  session$continuum_removal <- function(...) {
    # Continuum removal normalizes multispectral spectra by estimating upper convex hull (continuum) enveloping spectrum and dividing each band by corresponding continuum value. Removes overall spectral slope and brightness variations enabling enhanced visualization of absorption features (bands, depths). Absorption depths and positions standardized enabling mineral/material identification via spectral libraries. Continuum line computed via convex hull algorithm connecting local maxima across spectral range. Key Features: Removes spectral continuum; enhances absorption features; normalizes for brightness variations; enables spectral library matching; standardizes spectral shape. Use Cases: Mineral identification; material classification; vegetation spectral analysis; spectral anomaly detection; absorption feature mapping. Output Interpretation: Continuum-removed spectra exhibit absorption features (values <1.0) indicating material-specific bands. Absorption depths indicate feature strength; shallow features (<0.2) indicate minor components; deep features (>0.5) indicate dominant absorptions. Feature positions in wavelength space enable material identification via reference libraries. Flat continuum-removed spectra (near 1.0) indicate spectrally neutral materials.
    run_tool("continuum_removal", list(...))
  }
  session$contours_from_points <- function(...) {
    # Creates contour polylines from point elevations using a Delaunay TIN.
    run_tool("contours_from_points", list(...))
  }
  session$contours_from_raster <- function(...) {
    # Creates contour polylines from a raster surface model.
    run_tool("contours_from_raster", list(...))
  }
  session$convergence_index <- function(...) {
    # Flow convergence/divergence from local aspect alignment. Identifies valleys (convergent) and ridges (divergent) without full flow routing. Efficient alternative to flow direction algorithms.
    run_tool("convergence_index", list(...))
  }
  session$convert_nodata_to_zero <- function(...) {
    # Replaces raster nodata cells with 0 while leaving valid cells unchanged.
    run_tool("convert_nodata_to_zero", list(...))
  }
  session$corner_detection <- function(...) {
    # Identifies corner patterns in binary rasters using hit-and-miss templates.
    run_tool("corner_detection", list(...))
  }
  session$correct_vignetting <- function(...) {
    # Lens vignetting correction removes radiometric artifacts caused by off-axis lens optical properties where image edges receive less light than image centers, creating artificial brightness gradients independent of surface reflectance variation. Vignetting correction applies spatially varying multiplicative factors computed from vignetting profile models (Gaussian or cosine-fourth-law formulations) calibrated to sensor characteristics, restoring uniform radiometric response across the image field of view. This preprocessing step is critical for multispectral and hyperspectral remote sensing where vignetting would corrupt spectral analysis and introduce systematic errors in classification and change detection workflows. Key features include automatic vignetting profile estimation from image statistics or user-specified calibration parameters, spatially varying correction factors applied per-pixel without interpolation artifacts, optional masking of overcorrected peripheral pixels preventing amplification of noisy edges, and band-specific correction handling variable vignetting across spectral bands. Applications include preprocessing for spectral classification algorithms sensitive to radiometric consistency, mosaic preparation where vignetting boundaries cause visible discontinuities, accurate radiometric comparison across image frame, and hyperspectral analysis requiring uniform illumination response. Vignetting-corrected imagery shows uniform brightness across field of view. Output exhibits removed edge darkening with uniform radiometric response from image center to edges; peripheral pixels may show elevated noise if heavily corrected; corrected imagery integrates seamlessly into multispectral analysis workflows without radiometric artifacts.
    run_tool("correct_vignetting", list(...))
  }
  session$cos <- function(...) {
    # Computes the cosine of each raster cell value.
    run_tool("cos", list(...))
  }
  session$cosh <- function(...) {
    # Computes the hyperbolic cosine of each raster cell.
    run_tool("cosh", list(...))
  }
  session$cost_allocation <- function(...) {
    # Assigns each cell to a source region using a backlink raster from cost distance analysis.
    run_tool("cost_allocation", list(...))
  }
  session$cost_distance <- function(...) {
    # Computes accumulated travel cost and backlink rasters from source and cost surfaces.
    run_tool("cost_distance", list(...))
  }
  session$cost_pathway <- function(...) {
    # Traces least-cost pathways from destination cells using a backlink raster.
    run_tool("cost_pathway", list(...))
  }
  session$count_if <- function(...) {
    # Counts the number of input rasters whose cell equals a comparison value.
    run_tool("count_if", list(...))
  }
  session$create_colour_composite <- function(...) {
    # Creates a packed RGB colour composite from red, green, blue, and optional opacity rasters.
    run_tool("create_colour_composite", list(...))
  }
  session$create_plane <- function(...) {
    # Creates a raster from a planar equation using a base raster geometry.
    run_tool("create_plane", list(...))
  }
  session$crispness_index <- function(...) {
    # Calculates the crispness index for a membership probability raster.
    run_tool("crispness_index", list(...))
  }
  session$cross_tabulation <- function(...) {
    # Performs cross-tabulation on two categorical rasters.
    run_tool("cross_tabulation", list(...))
  }
  session$csv_points_to_vector <- function(...) {
    # Imports point records from a CSV file into a point vector layer.
    run_tool("csv_points_to_vector", list(...))
  }
  session$cumulative_distribution <- function(...) {
    # Converts raster values to cumulative distribution probabilities.
    run_tool("cumulative_distribution", list(...))
  }
  session$curvedness <- function(...) {
    # Calculates the curvedness surface form descriptor from a DEM.
    run_tool("curvedness", list(...))
  }
  session$d8_flow_accum <- function(...) {
    # Calculates D8 flow accumulation from a DEM or D8 pointer raster.
    run_tool("d8_flow_accum", list(...))
  }
  session$d8_mass_flux <- function(...) {
    # Performs a D8-based mass-flux accumulation using loading, efficiency, and absorption rasters.
    run_tool("d8_mass_flux", list(...))
  }
  session$d8_pointer <- function(...) {
    # Steepest-descent flow direction over 8 neighbors (N/NE/E/SE/S/SW/W/NW). Foundation for D8 hydrologic analysis and watershed delineation.
    run_tool("d8_pointer", list(...))
  }
  session$dark_object_subtraction <- function(...) {
    # Dark Object Subtraction (DOS) is a simple yet effective heuristic for atmospheric haze removal without requiring ancillary meteorological data or complex radiative transfer models. The technique exploits the principle that zero reflectance should produce zero reflectance signal (neglecting Rayleigh scattering); any signal observed from optically black surfaces (deep water, dense forest shadow, urban asphalt) is attributed to atmospheric path radiance caused by aerosol scattering. This tool identifies the minimum digital number in each band across the image, interprets this as atmospheric haze, and subtracts it from all pixels as a per-band constant offset; more sophisticated variants (DOS2, DOS3, DOS4) account for Rayleigh scattering and variable aerosol optical depth using vegetation indices or dark pixel clustering. Key capabilities include histogram analysis to isolate dark objects and distinguish scene-dependent haze from true zero reflectance, optional masking of known high-reflectance features (urban, snow, clouds) that would bias dark-object identification, band-specific haze correction, and fast computation suitable for real-time or large-scale processing. Use cases include quick-look reflectance estimates, vegetation and water quality monitoring where absolute calibration is less critical than relative changes, rapid disaster response mapping, and legacy archived data where precise aerosol information is unavailable. Input comprises top-of-atmosphere reflectance or calibrated radiance, optional land cover masks to exclude bright features, and scene metadata. Output is haze-corrected reflectance, per-band atmospheric path radiance estimates, and quality flags indicating confidence in dark-object identification (e.g., limited dark pixels, urban-dominated scene). While crude compared to radiative transfer models, DOS remains practical for multi-temporal analysis and global coverage mapping when sophisticated atmospheric data are in [truncated]
    run_tool("dark_object_subtraction", list(...))
  }
  session$dbscan <- function(...) {
    # Performs unsupervised DBSCAN density-based clustering on a stack of input rasters.
    run_tool("dbscan", list(...))
  }
  session$decrement <- function(...) {
    # Subtracts a value (default 1.0) from each non-nodata raster cell.
    run_tool("decrement", list(...))
  }
  session$delete_field <- function(...) {
    # Deletes one or more attribute fields from a vector layer.
    run_tool("delete_field", list(...))
  }
  session$dem_void_filling <- function(...) {
    # Fills DEM voids using a secondary surface and interpolated elevation offsets for seamless fusion.
    run_tool("dem_void_filling", list(...))
  }
  session$densify_features <- function(...) {
    # Adds vertices along line and polygon boundaries at a specified spacing.
    run_tool("densify_features", list(...))
  }
  session$depth_in_sink <- function(...) {
    # Measures the depth each DEM cell lies below a depression-filled surface.
    run_tool("depth_in_sink", list(...))
  }
  session$depth_to_water <- function(...) {
    # Computes cartographic depth-to-water using least-cost accumulation from stream/lake source features.
    run_tool("depth_to_water", list(...))
  }
  session$deviation_from_mean_elevation <- function(...) {
    # Calculates the local topographic z-score using local mean and standard deviation.
    run_tool("deviation_from_mean_elevation", list(...))
  }
  session$deviation_from_regional_direction <- function(...) {
    # Calculates polygon directional deviation from weighted regional mean orientation and appends DEV_DIR.
    run_tool("deviation_from_regional_direction", list(...))
  }
  session$diff_of_gaussians_filter <- function(...) {
    # Difference of Gaussians (DoG) filtering detects edges and fine features via subtraction of two Gaussian-blurred versions with different radii, creating a bandpass filter emphasizing intermediate spatial frequencies. Implementation computes two Gaussian blurs (small radius σ₁ and large radius σ₂), then subtracts: DoG = G(σ₁) - G(σ₂). This non-linear combination enhances edges and ridges while suppressing both fine noise and broad illumination trends. Key features include tunable frequency response (ratio σ₂/σ₁ controls bandpass characteristics), zero-centered output (bipolar: positive and negative values), applicability to edge detection and feature extraction, and computational efficiency via Gaussian reuse. Difference of Gaussians excels in geological structure detection (faults, lineaments appear as high DoG response), building extraction from orthophotos, fine-texture enhancement in remote sensing mosaics, and neuroscience-inspired processing models. Output interpretation shows that edges produce peak responses (positive on bright side, negative on dark side) with zero-crossing precisely at transitions. Zero-crossing detection reveals true edges independent of edge direction. DoG magnitude indicates edge strength; typical range spans -1000 to +1000 for 8-bit input depending on local contrast. Ratio σ₂/σ₁ determines bandpass center: ratio~2 emphasizes very fine features; ratio~5 emphasizes intermediate features; ratio~10 emphasizes coarser features. Bimodal output distributions (peaks at positive and negative extremes) indicate good edge separation. Common artifacts include halos around strong edges and potential under-response if frequency band doesn't match feature scale. Combine with magnitude thresholding for edge extraction. Apply before morphological post-processing for robust feature extraction from noisy satellite imagery.
    run_tool("diff_of_gaussians_filter", list(...))
  }
  session$difference <- function(...) {
    # Removes overlay polygon areas from input polygons using topology-based difference.
    run_tool("difference", list(...))
  }
  session$difference_curvature <- function(...) {
    # Calculates difference curvature from a DEM.
    run_tool("difference_curvature", list(...))
  }
  session$difference_from_mean_elevation <- function(...) {
    # Calculates the difference between each elevation and the local mean elevation.
    run_tool("difference_from_mean_elevation", list(...))
  }
  session$dinf_flow_accum <- function(...) {
    # Calculates D-Infinity flow accumulation from a DEM or D-Infinity pointer raster.
    run_tool("dinf_flow_accum", list(...))
  }
  session$dinf_mass_flux <- function(...) {
    # Performs a D-Infinity mass-flux accumulation using loading, efficiency, and absorption rasters.
    run_tool("dinf_mass_flux", list(...))
  }
  session$dinf_pointer <- function(...) {
    # Continuous flow directions (0-2π radians) eliminating D8 diagonal bias. Better for sediment transport and divergent flow modeling.
    run_tool("dinf_pointer", list(...))
  }
  session$direct_decorrelation_stretch <- function(...) {
    # Improves packed RGB colour saturation by reducing the achromatic component and linearly stretching channels.
    run_tool("direct_decorrelation_stretch", list(...))
  }
  session$directional_relief <- function(...) {
    # Calculates directional relief by ray-tracing elevation in a specified azimuth.
    run_tool("directional_relief", list(...))
  }
  session$directional_variogram <- function(...) {
    # Computes variograms in multiple directions to detect spatial anisotropy. Reveals directional continuity patterns essential for realistic kriging.
    run_tool("directional_variogram", list(...))
  }
  session$dissolve <- function(...) {
    # Removes shared polygon boundaries globally or by a dissolve attribute field.
    run_tool("dissolve", list(...))
  }
  session$distance_to_outlet <- function(...) {
    # Calculates downstream distance to outlet for each stream cell.
    run_tool("distance_to_outlet", list(...))
  }
  session$diversity_filter <- function(...) {
    # Computes moving-window diversity as count of unique values/classes within neighborhood. Measures local heterogeneity: high diversity = varied terrain/classes, low diversity = homogeneous. Reveals texture, fragmentation, and pattern diversity. Often applied to classified or categorical imagery to identify transition/edge zones.  Diversity filter creates a metric of local variation independent of specific values. Useful for landscape ecology (habitat diversity, fragmentation metrics), classification quality assessment (high diversity = mixed/uncertain areas), and texture analysis. Applied to elevation data, diversity indicates roughness at neighborhood scale. Applied to classification, it identifies mixed/ecotone/boundary zones.  Applications: (1) Landscape fragmentation mapping (high diversity = diverse mosaic, low diversity = uniform patches), (2) Classification confidence/uncertainty assessment (high diversity = uncertain area), (3) Texture analysis (heterogeneity mapping), (4) Edge/boundary detection via diversity peaks, (5) Habitat diversity for ecological analysis (suitability depends on local diversity).
    run_tool("diversity_filter", list(...))
  }
  session$divide <- function(...) {
    # Divides the first raster by the second on a cell-by-cell basis.
    run_tool("divide", list(...))
  }
  session$dn_to_toa_reflectance <- function(...) {
    # Digital number to top-of-atmosphere reflectance conversion transforms raw sensor digital numbers into physically meaningful spectral reflectance values by applying per-band radiometric calibration coefficients derived from satellite metadata. The conversion applies radiometric rescaling, solar exoatmospheric spectral irradiance correction, solar zenith angle compensation, and optional Earth-Sun distance normalization to produce reflectance values directly comparable across sensors, acquisition times, and geographic locations. Top-of-atmosphere reflectance represents the proportion of incident solar energy reflected by earth surface targets at the sensor before atmospheric effects, serving as the baseline for quantitative remote sensing analysis. Key features include per-band calibration coefficient application with full metadata parsing from standard satellite products, automatic solar geometry computation from acquisition timestamp and location, optional Earth-Sun distance correction for seasonal variability, and flexible handling of multiple sensor types with standardized coefficient formats. Applications span quantitative change detection using consistent physical units, absolute radiometric comparison across multitemporal acquisitions and different sensors, spectral vegetation indices calculation requiring precise reflectance, and cross-sensor validation in satellite constellation work. TOA reflectance enables rigorous analysis workflows and scientifically defensible results. Output reflectance values range 0-1 (sometimes expressed as 0-10000 for integer precision) representing dimensionless proportions; metadata embeds calibration coefficients used and sensor geometry parameters; negative values indicate data quality issues requiring masking before analysis.
    run_tool("dn_to_toa_reflectance", list(...))
  }
  session$download_osm_vector <- function(...) {
    # Downloads OpenStreetMap features from the Overpass API for a bounding box and writes the result as a vector layer.
    run_tool("download_osm_vector", list(...))
  }
  session$downslope_distance_to_stream <- function(...) {
    # Computes downslope distance from each DEM cell to nearest stream along flow paths.
    run_tool("downslope_distance_to_stream", list(...))
  }
  session$downslope_flowpath_length <- function(...) {
    # Computes downslope flowpath length from each cell to an outlet in a D8 pointer raster.
    run_tool("downslope_flowpath_length", list(...))
  }
  session$downslope_index <- function(...) {
    # Calculates Hjerdt et al. (2004) downslope index using D8 flow directions.
    run_tool("downslope_index", list(...))
  }
  session$edge_contamination <- function(...) {
    # Identifies DEM cells whose upslope area extends beyond the DEM edge for common flow-routing schemes.
    run_tool("edge_contamination", list(...))
  }
  session$edge_density <- function(...) {
    # Calculates local density of breaks-in-slope using angular normal-vector differences.
    run_tool("edge_density", list(...))
  }
  session$edge_preserving_mean_filter <- function(...) {
    # The Edge-Preserving Mean filter performs selective pixel averaging by computing local means while excluding outlier pixels that likely represent edges or noise. Implementation sorts pixel neighborhoods, removes extreme values (lowest and highest, or values exceeding statistical threshold), and averages remaining values. This robust approach balances smoothing against sharpness preservation. Variants include weighted averaging emphasizing center pixels and adaptive threshold selection based on local statistics. Key features include simple parameter control (exclusion count or threshold), computational efficiency via sorting small neighborhoods, effective noise reduction without detail blurring, and applicability to optical, radar, and thermal data. Edge-Preserving Mean filtering excels in optical satellite preprocessing for vegetation index calculation (removes shadows and clouds without blurring features), DEM smoothing preserving slope breaks, thermal image denoising maintaining boundary sharpness, and orthophoto preparation for manual digitization. Output interpretation reveals that removed outliers concentrate at edges and noise regions; remaining values average creating local smoothing. Exclusion parameters control edge sharpness: excluding single extreme removes salt-pepper noise; excluding multiple extremes produces smoother results with gentler edge transition. Output ranges remain within input; statistics shift toward inlier means. Monitor output difference from input to identify filtered regions (typically high-variance areas). Edge preservation quality depends on outlier identification accuracy; verify visually that features remain sharp. Common artifacts include inadequate smoothing if thresholds are too strict and excessive filtering if exclusion counts are too high. Iteration count enables progressive filtering; single pass provides gentle smoothing. Apply before threshold-based classification to reduce noise-driven category misclassification while maintaining feature boundaries.
    run_tool("edge_preserving_mean_filter", list(...))
  }
  session$edge_proportion <- function(...) {
    # Calculates the proportion of each patch's cells that are edge cells and maps it back to patch cells.
    run_tool("edge_proportion", list(...))
  }
  session$elev_above_pit <- function(...) {
    # Calculates elevation above the nearest downslope pit cell (or edge sink).
    run_tool("elev_above_pit", list(...))
  }
  session$elev_above_pit_dist <- function(...) {
    # Compatibility alias for elev_above_pit.
    run_tool("elev_above_pit_dist", list(...))
  }
  session$elev_relative_to_min_max <- function(...) {
    # Expresses each elevation as a percentage (0–100) of the raster's elevation range.
    run_tool("elev_relative_to_min_max", list(...))
  }
  session$elev_relative_to_watershed_min_max <- function(...) {
    # Calculates a DEM cell's relative elevation position within each watershed as a percentage.
    run_tool("elev_relative_to_watershed_min_max", list(...))
  }
  session$elevation_above_stream <- function(...) {
    # Computes elevation above nearest stream measured along downslope flow paths.
    run_tool("elevation_above_stream", list(...))
  }
  session$elevation_above_stream_euclidean <- function(...) {
    # Computes elevation above nearest stream using straight-line (Euclidean) proximity.
    run_tool("elevation_above_stream_euclidean", list(...))
  }
  session$elevation_percentile <- function(...) {
    # Local elevation percentile rank within neighborhood (0-100). Identifies valleys (low %), ridges (high %), and slopes (mid %). Landform classification metric independent of absolute elevation.
    run_tool("elevation_percentile", list(...))
  }
  session$eliminate_coincident_points <- function(...) {
    # Removes coincident or near-coincident points within a tolerance distance.
    run_tool("eliminate_coincident_points", list(...))
  }
  session$elongation_ratio <- function(...) {
    # Computes elongation ratio (short axis / long axis of bounding rectangle) for polygon features.
    run_tool("elongation_ratio", list(...))
  }
  session$embankment_mapping <- function(...) {
    # Maps transportation embankments from a DEM and road network, with optional embankment-surface removal via interpolation. Authored by John Lindsay and Nigel VanNieuwenhuizen.
    run_tool("embankment_mapping", list(...))
  }
  session$emboss_filter <- function(...) {
    # The emboss filter enhances edge features through directional shading, creating a distinctive three-dimensional relief appearance where edges appear as raised or depressed surfaces depending on directional lighting simulation. This filter applies a 3×3 kernel that combines edge detection with unidirectional illumination, typically simulating light from the upper-left quadrant, creating dramatic visual contrast at boundaries while preserving smooth regions. The emboss transformation subtracts weighted neighbor values in specific directions, producing output where highlights and shadows accentuate topographic and feature discontinuities. Key features include intuitive directional control allowing simulated light direction adjustment (eight-directional variants), natural incorporation of 3D perception enhancing visual interpretation, and robust performance across varied lighting conditions in source imagery. The emboss filter serves quality assurance, interpretative visualization, and feature boundary emphasis applications. Use cases include visual enhancement for geological interpretation where mineral boundaries become visible as relief patterns, aerial photograph interpretation improving subtle boundary visibility, cartographic production where embossed digital elevation models generate compelling relief maps, and archaeological feature detection where buried structures appear as subtle topographic variations. Output interpretation treats high values as illuminated surfaces and low values as shadows, creating perceptual depth that the human eye naturally interprets as relief. Embossed output typically requires scaling to 0-255 visualization range; raw output often contains negative values representing shadow areas. The effect is purely visual—emboss does not compute true illumination or create elevation derivatives. For multi-spectral imagery, apply to principal components or selected bands based on analytical objectives. Post-processing often includes contrast enhancement or tone mapping optimizing visual impact.
    run_tool("emboss_filter", list(...))
  }
  session$enhanced_lee_filter <- function(...) {
    # The Enhanced Lee filter combines Lee's multiplicative model with refined variance estimation and multi-scale processing, achieving superior speckle reduction while preserving fine details and edges in SAR imagery. Implementation employs local statistics computed via windows of adaptive size, incorporates Laplacian-based edge detection, and applies spatially-varying filter parameters. The enhanced formulation applies: F = μ + w·(I - μ) where w adapts to edge proximity: w→0 near edges (minimal filtering), w→1 in homogeneous regions (aggressive filtering). Key features include edge-adaptive processing (preserving boundaries), multi-scale parameter adaptation, improved target preservation versus standard Lee, and effectiveness on high-noise SAR. Enhanced Lee filtering excels in complex SAR scenes with numerous features, flood-mapping applications where edge localization is critical, building detection from urban SAR, and multi-temporal change analysis. Output interpretation reveals edge preservation via reduced filtering near transitions: boundary pixels retain greater variance than distant pixels. Multi-scale adaptation becomes apparent via histogram analysis showing pronounced peaks corresponding to scene classes. Output ranges match input; comparison with standard Lee shows reduced edge blur and maintained target sharpness. Edge detection quality directly impacts output: strong edges enable good boundary preservation; weak edges may induce over-smoothing. Statistics show controlled variance reduction balancing noise suppression against detail preservation. Common artifacts include potential blocky appearance if multi-scale transitions become visible and over-preservation if edge detection is too aggressive. Monitor edge map quality to validate filtering behavior. Apply in comprehensive SAR analysis pipelines where multiple features must be preserved and edges must remain sharp, particularly important for machine learning preprocessing requiring training data with clear feature boundaries.
    run_tool("enhanced_lee_filter", list(...))
  }
  session$envelope_test <- function(...) {
    # Performs Monte Carlo envelope testing comparing observed pattern to CSR null distribution. Determines significance of clustering/dispersion.
    run_tool("envelope_test", list(...))
  }
  session$equal_to <- function(...) {
    # Tests whether two rasters are equal on a cell-by-cell basis.
    run_tool("equal_to", list(...))
  }
  session$erase <- function(...) {
    # Erases overlay polygon areas from input polygons and preserves input attributes.
    run_tool("erase", list(...))
  }
  session$erase_polygon_from_lidar <- function(...) {
    # Removes LiDAR points that fall within polygon geometry.
    run_tool("erase_polygon_from_lidar", list(...))
  }
  session$erase_polygon_from_raster <- function(...) {
    # Sets raster cells inside polygons to NoData while preserving cells in polygon holes.
    run_tool("erase_polygon_from_raster", list(...))
  }
  session$estimate_variogram <- function(...) {
    # Computes an empirical semivariogram from point observations to characterize spatial correlation structure. Essential first step in geostatistical workflow.
    run_tool("estimate_variogram", list(...))
  }
  session$euclidean_allocation <- function(...) {
    # Assigns each valid cell the value of its nearest non-zero target cell.
    run_tool("euclidean_allocation", list(...))
  }
  session$euclidean_distance <- function(...) {
    # Computes Euclidean distance to nearest non-zero target cell in a raster.
    run_tool("euclidean_distance", list(...))
  }
  session$evaluate_object_classification_accuracy <- function(...) {
    # Computes classification accuracy metrics comparing predicted object labels against reference ground-truth or validation labels. Generates confusion matrix documenting classification agreement/disagreement patterns per class, calculates overall accuracy (total correct predictions), per-class producer's accuracy (detection rate), user's accuracy (reliability), F1-score (harmonic mean), kappa statistic (chance-corrected agreement), and class-specific error analysis identifying systematic misclassification patterns. Key features include comprehensive accuracy assessment across all classes, per-class performance metrics enabling class-specific diagnostics, confusion matrix revealing systematic misclassification patterns, statistical significance testing through kappa coefficient, natural handling of imbalanced class distributions, and identification of training data adequacy issues. Use cases include classification model validation and performance quantification, comparison of competing classification approaches and parameters, identification of problematic object classes requiring additional training, assessment of classification suitability for operational applications, accuracy-based model selection and hyperparameter tuning, quality assurance in automated mapping workflows, and reporting standardized accuracy metrics for peer review. Output overall accuracy represents classification reliability across all objects; producer's accuracy indicates detection completeness per class; user's accuracy indicates prediction reliability; high kappa (>0.8) indicates strong beyond-chance agreement; confusion matrix reveals which classes are confused with each other; diagonal dominance indicates strong class separation; off-diagonal entries pinpoint misclassification sources; class-specific metrics guide targeted training improvement.
    run_tool("evaluate_object_classification_accuracy", list(...))
  }
  session$evaluate_segmentation_quality_pro <- function(...) {
    # Computes segmentation quality diagnostics including object-count and dominant-label overlap statistics.
    run_tool("evaluate_segmentation_quality_pro", list(...))
  }
  session$evaluate_training_sites <- function(...) {
    # Evaluates class separability in multi-band training polygons and writes an HTML report with per-band distribution statistics.
    run_tool("evaluate_training_sites", list(...))
  }
  session$exp <- function(...) {
    # Computes e raised to the power of each raster cell.
    run_tool("exp", list(...))
  }
  session$exp2 <- function(...) {
    # Computes 2 raised to the power of each raster cell.
    run_tool("exp2", list(...))
  }
  session$export_table_to_csv <- function(...) {
    # Exports a vector attribute table to a CSV file.
    run_tool("export_table_to_csv", list(...))
  }
  session$exposure_towards_wind_flux <- function(...) {
    # Calculates terrain exposure relative to dominant wind direction and upwind horizon shielding.
    run_tool("exposure_towards_wind_flux", list(...))
  }
  session$extend_vector_lines <- function(...) {
    # Extends polyline endpoints by a specified distance at the start, end, or both.
    run_tool("extend_vector_lines", list(...))
  }
  session$extract_by_attribute <- function(...) {
    # Extracts vector features that satisfy an attribute expression.
    run_tool("extract_by_attribute", list(...))
  }
  session$extract_nodes <- function(...) {
    # Converts polyline and polygon vertices into point features.
    run_tool("extract_nodes", list(...))
  }
  session$extract_raster_values_at_points <- function(...) {
    # Samples one or more rasters at point locations and writes the values to point attributes.
    run_tool("extract_raster_values_at_points", list(...))
  }
  session$extract_streams <- function(...) {
    # Extracts streams based on flow accumulation threshold.
    run_tool("extract_streams", list(...))
  }
  session$extract_valleys <- function(...) {
    # Extracts valleys from DEM.
    run_tool("extract_valleys", list(...))
  }
  session$farthest_channel_head <- function(...) {
    # Calculates distance to most distant channel head.
    run_tool("farthest_channel_head", list(...))
  }
  session$fast_almost_gaussian_filter <- function(...) {
    # The Fast Almost Gaussian filter provides rapid Gaussian-approximation smoothing via iterative separable box (averaging) filtering, achieving near-Gaussian blur response with O(N) computational complexity regardless of blur radius. Implementation applies successive box convolutions (each computing local pixel averages) to approximate cumulative Gaussian distribution; N iterations approximate increasingly larger Gaussian kernels. The mathematical basis uses the central limit theorem: repeated convolution of box functions approaches Gaussian distribution asymptotically. Key features include computational speed enabling large-kernel smoothing on big imagery, separable implementation reducing memory requirements, parameter control via iteration count (controls blur radius), and effectiveness on any data type. Fast Almost Gaussian filtering excels in rapid image pyramids for multi-scale analysis, real-time satellite imagery browsing, preprocessing enormous remote sensing datasets before classification, and interactive image viewers requiring responsive smoothing. Output interpretation shows that iteration count directly relates to blur radius: N=1 produces minimal smoothing; N=3-5 provides moderate blur; N>10 creates strong smoothing approximating large-kernel Gaussians. Output values progressively shift toward local mean as iterations increase; variance reduction follows predictable patterns. Remaining values stay within input data ranges. Comparison with true Gaussian filtering shows acceptable approximation within 2-5% error for most applications. Speed improvement over true Gaussian filtering increases dramatically at large radii: 5-20× faster for radius >20 pixels. Minor artifacts include subtle waviness along edges (box artifacts accumulating across iterations) and slightly different boundary handling than Gaussian. Monitor output histograms for multimodal distributions indicating sufficient smoothing. Apply in image preprocessing pipelines where speed justifies minor approximation errors.
    run_tool("fast_almost_gaussian_filter", list(...))
  }
  session$fd8_flow_accum <- function(...) {
    # Calculates FD8 flow accumulation from a DEM.
    run_tool("fd8_flow_accum", list(...))
  }
  session$fd8_pointer <- function(...) {
    # Fractional flow to multiple downslope neighbors weighted by gradient. Better than D8 for dispersive, diffusive processes and mass conservation.
    run_tool("fd8_pointer", list(...))
  }
  session$feature_preserving_smoothing <- function(...) {
    # Smooths DEM roughness while preserving breaks-in-slope using normal-vector filtering.
    run_tool("feature_preserving_smoothing", list(...))
  }
  session$feature_preserving_smoothing_multiscale <- function(...) {
    # Smooths DEM roughness with a multiscale coarse-to-fine continuation. Each scale re-derives normals, applies adaptive robust normal-field diffusion, and reconstructs elevations with a screened Poisson solve.
    run_tool("feature_preserving_smoothing_multiscale", list(...))
  }
  session$fetch_analysis <- function(...) {
    # Computes upwind distance to the first topographic obstacle along a specified azimuth.
    run_tool("fetch_analysis", list(...))
  }
  session$fft_random_field <- function(...) {
    # Creates a spatially-autocorrelated random field using FFT spectral synthesis.
    run_tool("fft_random_field", list(...))
  }
  session$field_calculator <- function(...) {
    # Calculates a field value from an expression using feature attributes and geometry variables; supports SQL-style CASE, CAST, null checks, and UPDATE ... SET ... [WHERE ...] wrappers.
    run_tool("field_calculator", list(...))
  }
  session$fill_burn <- function(...) {
    # Hydro-enforces a DEM by burning streams and then filling depressions.
    run_tool("fill_burn", list(...))
  }
  session$fill_depressions <- function(...) {
    # Fills depressions in a DEM using a priority-flood strategy with Garbrecht-Martz flat resolution by default and optional legacy natural-path flat resolution.
    run_tool("fill_depressions", list(...))
  }
  session$fill_depressions_planchon_and_darboux <- function(...) {
    # Fills depressions in a DEM with a Planchon-and-Darboux-compatible interface.
    run_tool("fill_depressions_planchon_and_darboux", list(...))
  }
  session$fill_depressions_wang_and_liu <- function(...) {
    # Fills depressions in a DEM with a Wang-and-Liu-compatible interface.
    run_tool("fill_depressions_wang_and_liu", list(...))
  }
  session$fill_missing_data <- function(...) {
    # Fills NoData gaps using inverse-distance weighting from valid gap-edge cells.
    run_tool("fill_missing_data", list(...))
  }
  session$fill_pits <- function(...) {
    # Fills single-cell pits in a DEM.
    run_tool("fill_pits", list(...))
  }
  session$filter_lidar <- function(...) {
    # Removes points via expression: boolean logic on attributes (class, elevation, return_number, scan_angle, noise_flag, etc). Flexible point selection.
    run_tool("filter_lidar", list(...))
  }
  session$filter_lidar_by_percentile <- function(...) {
    # Selects percentile-rank point per cell: retains one point per grid block at specified elevation percentile. Representative-sample decimation.
    run_tool("filter_lidar_by_percentile", list(...))
  }
  session$filter_lidar_by_reference_surface <- function(...) {
    # Extracts points relative to reference surface: z<surface, z>surface, or within threshold. Identifies vegetation above DTM or subsurface points.
    run_tool("filter_lidar_by_reference_surface", list(...))
  }
  session$filter_lidar_classes <- function(...) {
    # Removes points by classification: filters out unwanted LAS classes (noise, water, buildings, etc). Essential pre-processing for terrain conditioning workflows.
    run_tool("filter_lidar_classes", list(...))
  }
  session$filter_lidar_noise <- function(...) {
    # Removes ASPRS noise classes: filters class 7 (low noise) and class 18 (high noise). Standard point-cloud cleaning for LAS 1.4 compliant data.
    run_tool("filter_lidar_noise", list(...))
  }
  session$filter_lidar_scan_angles <- function(...) {
    # Removes oblique LiDAR returns: filters points by scan-angle threshold. Improves vertical accuracy by removing grazing-angle returns with positional error.
    run_tool("filter_lidar_scan_angles", list(...))
  }
  session$filter_raster_features_by_area <- function(...) {
    # Removes integer-labelled raster features smaller than a cell-count threshold.
    run_tool("filter_raster_features_by_area", list(...))
  }
  session$filter_vector_features_by_area <- function(...) {
    # Filters polygon features below a minimum area threshold.
    run_tool("filter_vector_features_by_area", list(...))
  }
  session$find_flightline_edge_points <- function(...) {
    # Filters flight-edge points: extracts only points at acquisition swath boundaries. QA for strip overlap and edge effects.
    run_tool("find_flightline_edge_points", list(...))
  }
  session$find_lowest_or_highest_points <- function(...) {
    # Locates lowest and/or highest raster cells and outputs their locations as points.
    run_tool("find_lowest_or_highest_points", list(...))
  }
  session$find_main_stem <- function(...) {
    # Identifies main stem of stream network.
    run_tool("find_main_stem", list(...))
  }
  session$find_noflow_cells <- function(...) {
    # Finds DEM cells that have no lower D8 neighbour.
    run_tool("find_noflow_cells", list(...))
  }
  session$find_parallel_flow <- function(...) {
    # Identifies stream cells that possess parallel D8 flow directions.
    run_tool("find_parallel_flow", list(...))
  }
  session$find_patch_edge_cells <- function(...) {
    # Identifies edge cells for each positive raster patch ID; non-edge patch cells are set to zero.
    run_tool("find_patch_edge_cells", list(...))
  }
  session$find_ridges <- function(...) {
    # Identifies potential ridge and peak cells in a DEM, with optional line thinning.
    run_tool("find_ridges", list(...))
  }
  session$fit_variogram <- function(...) {
    # Fits theoretical variogram model (Spherical, Exponential, Gaussian) to empirical semivariogram data for use in kriging.
    run_tool("fit_variogram", list(...))
  }
  session$fix_dangling_arcs <- function(...) {
    # Fixes undershot and overshot dangling arcs in a line network by snapping line endpoints within a threshold distance.
    run_tool("fix_dangling_arcs", list(...))
  }
  session$flatten_lakes <- function(...) {
    # Flattens lake elevations using minimum perimeter elevation for each polygon.
    run_tool("flatten_lakes", list(...))
  }
  session$flightline_overlap <- function(...) {
    # Detects acquisition overlaps: counts distinct point-source IDs per cell. Grid-based overlap visualization for flight-line coverage assessment.
    run_tool("flightline_overlap", list(...))
  }
  session$flip_image <- function(...) {
    # Flips an image vertically, horizontally, or both.
    run_tool("flip_image", list(...))
  }
  session$flood_order <- function(...) {
    # Outputs the sequential priority-flood order for each DEM cell.
    run_tool("flood_order", list(...))
  }
  session$floor <- function(...) {
    # Rounds each raster cell downward to the nearest integer.
    run_tool("floor", list(...))
  }
  session$flow_accum_full_workflow <- function(...) {
    # Runs a full non-divergent flow-accumulation workflow and returns breached DEM, flow-direction pointer, and accumulation.
    run_tool("flow_accum_full_workflow", list(...))
  }
  session$flow_length_diff <- function(...) {
    # Computes local maximum absolute differences in downslope path length from a D8 pointer raster.
    run_tool("flow_length_diff", list(...))
  }
  session$frangi_filter <- function(...) {
    # Performs multiscale Frangi vesselness enhancement for detecting vessel-like (tubular) structures at multiple scales. Based on Hessian matrix eigenvalue analysis. Responds strongly to line-like features (vessels, roads, rivers) and weakly to blob-like structures. Multiscale analysis (try multiple sigma values) automatically detects vessels at different widths. Widely used in medical imaging and remote sensing for linear feature detection. Frangi vesselness uses principal curvatures (Hessian eigenvalues) to classify local structure: high vesselness for linear features, low for plateaus or blobs. Multiscale implementation applies at multiple sigma (width) values, combines responses. Excellent for detecting roads, rivers, vessel networks. Computationally moderate for multiple scales. Highly interpretable output—responds to recognizable features. Applications: (1) Road detection in satellite imagery, (2) River/stream network extraction, (3) Linear feature detection generally, (4) Vessel detection (medical imaging), (5) Multi-scale structure detection.
    run_tool("frangi_filter", list(...))
  }
  session$freeman_durden_decomposition <- function(...) {
    # Freeman-Durden decomposition quantifies scattering mechanism contributions from quad-polarimetric SAR via orthogonal basis decomposition into surface reflection, double-bounce (urban/dihedral), and volume (vegetation/random media) components. Non-negative least-squares optimization constrains power fractions ensuring physical realizability and interpretability. Output power maps directly linked to terrain properties: high surface dominance indicates bare soil/water, high double-bounce indicates urban structures, high volume indicates forest/vegetation. Key Features: Physically interpretable scattering components; terrain-specific signatures; constrained optimization; supports quad-polarimetric SAR; robust to speckle; enables target-specific classification. Use Cases: Urban-rural classification; forest biomass estimation; soil moisture detection; flooding detection; crop phenology monitoring; landcover mapping. Output Interpretation: Surface power indicates specular reflection from dry terrain/water; double-bounce power indicates man-made structures/urban areas; volume power indicates vegetation/forest. Component combinations enable landcover discrimination: high volume + low double-bounce indicates forest; high double-bounce + low volume indicates urban; balanced surface/volume indicates mixed terrain.
    run_tool("freeman_durden_decomposition", list(...))
  }
  session$frost_filter <- function(...) {
    # The Frost filter implements SAR speckle reduction using multiplicative noise model and adaptive local statistics, designed specifically for radar imagery where speckle follows Gamma distribution rather than Gaussian noise. Implementation computes local mean and variance, then applies adaptive multiplicative weighting: F = I · exp(-variance/(2·mean²)·distance²), where distance measures pixel deviation from local mean. This formulation reduces speckle intensity inversely to estimated coherence. Key features include SAR-specific adaptation (multiplicative rather than additive noise model), preservation of point targets and edges (coherent features), local variance-driven adaptation enabling strength adjustment, and proven effectiveness on single-pol and multi-pol SAR data. Frost filtering excels in SAR image preprocessing for classification (agricultural monitoring, land-use mapping), coherence-weighted SAR-optical fusion, flood mapping from radar during cloud cover, and synthetic aperture radar change detection workflows. Output interpretation shows that high-variance (potentially coherent target) regions filter minimally; low-variance (speckle-dominated) regions filter aggressively. Typical output ranges match input; logarithmic scaling (decibels) often applied pre- or post-filtering for visualization. Variance-to-mean ratio directly controls filter strength: ratio > 0.5 indicates probable speckle; ratio < 0.1 suggests coherent targets. Output artifacts include potential detail loss if variance estimation is unreliable and directional bias in oriented features. Verification via coherence maps confirms edge preservation in high-coherence zones. Monitor output statistics: mean should stabilize across filtering iterations; variance should decrease substantially. Apply before classification to improve categorical accuracy. Combine with morphological post-processing to refine object boundaries and remove residual speckle chips.
    run_tool("frost_filter", list(...))
  }
  session$fuzzy_knn_classification <- function(...) {
    # Performs fuzzy k-nearest-neighbor classification and outputs class membership confidence.
    run_tool("fuzzy_knn_classification", list(...))
  }
  session$gabor_filter_bank <- function(...) {
    # Performs multi-orientation Gabor response filtering—directional texture analysis. Applies bank of Gabor filters at multiple orientations (typically 0°, 45°, 90°, 135°) to extract directional texture features. Gabor responses indicate texture strength and orientation. Useful for directional feature detection, texture characterization, and oriented pattern analysis. Each orientation is output separately. Gabor filtering extracts directional texture by convolving with orientation-specific wavelets. Each orientation reveals features aligned with that direction. Outputs multiple bands (one per orientation) revealing local texture direction and strength. Gabor responses are foundational for texture feature extraction and object detection in computer vision. Bank of filters enables comprehensive directional analysis. Applications: (1) Directional texture analysis, (2) Oriented feature detection (ridges, valleys, linear structures), (3) Directional erosion/deposition mapping, (4) Road/stream detection (linear features), (5) Texture-based classification.
    run_tool("gabor_filter_bank", list(...))
  }
  session$gamma_correction <- function(...) {
    # Gamma correction applies non-linear brightness adjustment via power-law transformation to optimize image contrast, display fidelity, and perceptual luminance distribution. The mathematical transformation is I_corrected = I^(1/γ), where γ (gamma) is a user-specified exponent controlling brightness adjustment direction and magnitude. Values γ > 1 darken images (brightening display compensation), while γ < 1 brighten images (darkening display compensation). Implementation operates independently on each pixel or spectral band, preserving spatial relationships while adjusting intensity scaling. Key features include preserving image structure while redistributing tonal values, computational efficiency requiring only lookup tables, applicability to any radiometric data including 16/32-bit imagery, and reversibility enabling inverse correction. Gamma correction finds essential application in preparing satellite imagery for visual interpretation by compensating sensor characteristics, normalizing orthophoto brightness across flight lines or sensor types, enhancing thermal imagery for feature visibility, and pre-processing multispectral data for machine-learning pipelines where input normalization improves convergence. Output interpretation shows that corrected values follow power-law scaling: mid-tones undergo greatest relative adjustment, while extremes compress less. For 8-bit input (0-255), typical gamma 0.4-0.6 brightens images significantly; gamma 1.4-1.6 darkens substantially. Histogram shapes transform predictably: left-skewed histograms (dark images) benefit from γ < 1, while right-skewed histograms (bright images) benefit from γ > 1. Verify corrected output using histogram visualization and visual inspection. Apply consistency across image collections requiring uniform preprocessing. Common workflow chains gamma correction before threshold selection or classification to ensure balanced feature visibility.
    run_tool("gamma_correction", list(...))
  }
  session$gamma_map_filter <- function(...) {
    # The Gamma Map filter performs SAR speckle reduction using Gamma distribution statistical model, explicitly accounting for radar signal's multiplicative speckle characteristics through parametric adaptation. Implementation estimates local Gamma distribution parameters (shape α and scale β) from image statistics, then filters via a weighting function respecting the distribution: F = I · [1 - (1-L/N)/(1 + L/N)·√(1 + N/L²)], where L is equivalent looks (coherence measure) and N is estimated parameter. Key features include theoretically rigorous SAR statistics (Gamma distribution standard for radar), automatic look-number estimation requiring minimal user input, superior edge preservation compared to uniform filters, and applicability to single- and multi-look SAR. Gamma Map filtering excels in multi-temporal SAR stack denoising for time-series change detection, interferometric SAR (InSAR) phase coherence enhancement, polarimetric SAR decomposition pre-processing, and forestry SAR backscatter normalization. Output interpretation reveals that filter strength adapts to scene coherence: high-coherence regions (large α) filter gently, preserving targets; low-coherence regions (small α) filter aggressively, suppressing speckle. Equivalent look-number L indicates filtering effectiveness: L=1 (minimal filtering) preserves all detail; L>5 produces substantial smoothing. Output scaling remains in input units; logarithmic conversion facilitates visualization. Typical output variance reductions range 50-80% depending on scene character and look-number selection. Monitor output histograms for remaining speckle signature; bi-modal distributions suggest good separation of scene components. Artifacts include potential striping in oriented features or slight texture degradation if L is overestimated. Validate filtering against ground truth in training areas. Apply strategically in polarimetric SAR classification or InSAR phase filtering requiring coherence-weighted enhancement.
    run_tool("gamma_map_filter", list(...))
  }
  session$gaussian_contrast_stretch <- function(...) {
    # Stretches contrast by matching to a Gaussian reference distribution.
    run_tool("gaussian_contrast_stretch", list(...))
  }
  session$gaussian_curvature <- function(...) {
    # Calculates Gaussian (intrinsic) curvature (product of principal curvatures). Indicates local surface topology: positive (bowl/dome), negative (saddle), zero (cylindrical). Classifies terrain into landform categories: convex features (ridges), concave features (valleys), saddle features (passes/gaps). Used in advanced landform classification.
    run_tool("gaussian_curvature", list(...))
  }
  session$gaussian_filter <- function(...) {
    # Mathematically-optimal Gaussian smoothing with distance-weighted kernel. Foundational for multi-scale analysis, edge detection, band-pass filtering. Sigma parameter controls smoothing intensity; RGB-aware.
    run_tool("gaussian_filter", list(...))
  }
  session$generalize_classified_raster <- function(...) {
    # Generalize Classified Raster simplifies classification maps by removing small isolated patches through iterative mode filtering, merging fragmented single-pixel or multi-pixel components into spatially dominant neighboring classes. Algorithm: applies morphological mode filter preserving dominant class within moving windows, removes or consolidates pixels isolated from spatial context, iteratively refines classification through connected-component analysis, absorbs minor classes into neighboring dominant classes. Configurable window size and minimum patch size control generalization intensity. Key features: reduces classification fragmentation, improves spatial coherence, eliminates noise-induced isolated patches, maintains class boundaries through selective filtering, computationally efficient connected-component processing. Capabilities: variable generalization intensity, preservation of large contiguous patches, application to indexed or category data. Use cases: post-classification refinement removing salt-and-pepper effects, consolidating fragmented classification results, preparation of final classification products, generalization to specific minimum mapping unit. Applications: land cover map finalization, eliminating spurious single-pixel classifications, improving classification spatial continuity. Output interpretation: reduced class fragmentation indicates effective despeckling; preserved boundaries reveal appropriate generalization parameters; excessive generalization indicates oversized window parameters; spatial coherence improvement suggests classification noise was primarily single-pixel artifacts.
    run_tool("generalize_classified_raster", list(...))
  }
  session$generalize_with_similarity <- function(...) {
    # Generalizes small patches in a classified raster by merging them into the most spectrally similar neighboring patch.
    run_tool("generalize_with_similarity", list(...))
  }
  session$generate_network_nodes <- function(...) {
    # Generates network nodes and node diagnostics from linework topology.
    run_tool("generate_network_nodes", list(...))
  }
  session$generating_function <- function(...) {
    # Calculates generating function from a DEM.
    run_tool("generating_function", list(...))
  }
  session$geographically_weighted_regression <- function(...) {
    # Estimates location-specific regression coefficients revealing spatially-varying relationships. Detects spatial heterogeneity in predictor-response patterns.
    run_tool("geographically_weighted_regression", list(...))
  }
  session$geographically_weighted_regression_raster <- function(...) {
    # Estimates GWR and outputs local coefficient raster surfaces.
    run_tool("geographically_weighted_regression_raster", list(...))
  }
  session$geomorphons <- function(...) {
    # Classifies landforms using 8-direction line-of-sight ternary patterns derived from zenith and nadir angle comparisons, or 10 common geomorphon forms.
    run_tool("geomorphons", list(...))
  }
  session$georeference_raster_from_control_points <- function(...) {
    # Fits a transform from GCPs and warps a raster into georeferenced output.
    run_tool("georeference_raster_from_control_points", list(...))
  }
  session$getis_ord_gi_star <- function(...) {
    # Computes Getis-Ord Gi/Gi* z-scores for local hotspot/coldspot identification. Direct measure of high/low value concentration.
    run_tool("getis_ord_gi_star", list(...))
  }
  session$getis_ord_gi_star_raster <- function(...) {
    # Computes Gi* hotspot/coldspot classifications from points and outputs raster (-1=cold, 0=NS, 1=hot). For hotspot-based analysis.\
    run_tool("getis_ord_gi_star_raster", list(...))
  }
  session$glcm_texture <- function(...) {
    # The Gray-Level Co-occurrence Matrix (GLCM) texture analyzer extracts second-order statistical texture measures quantifying spatial relationships between pixel gray-level values at specified displacement distances and directions, enabling sophisticated texture classification distinguishing agricultural vegetation patterns, built-environment structures, and geological formations. GLCM computes probability matrices capturing how frequently gray-level pairs occur at fixed offsets, computing four canonical Haralick statistics: contrast (measuring local variation), correlation (measuring linear dependency), homogeneity (measuring closeness to diagonal), and energy (measuring uniformity). The tool supports eight directional offsets (0°, 45°, 90°, 135°, and their opposites) allowing directional texture sensitivity—detecting oriented patterns like field rows, building alignments, or geological structures. Key features include multi-directional analysis revealing anisotropic texture properties, displacement parameter tuning optimizing scale sensitivity, simultaneous computation of multiple texture measures reducing processing overhead, and inherent capability distinguishing visually subtle surface properties. Use cases span precision agriculture (crop type classification, field boundary detection, crop stress assessment), urban analysis (building density mapping, impervious surface extraction), and geological remote sensing (rock type discrimination, structural pattern recognition). Applications include land-cover classification combining spectral and textural features, object-based image analysis improving classification accuracy, quality control detecting instrumental artifacts in satellite imagery, and change detection isolating meaningful alterations from sensor noise. Output interpretation requires understanding each statistic's meaning: high contrast indicates rough/varied textures; high correlation indicates linear patterns; high homogeneity indicates uniform textures; high energy indicates orderly repetitive patterns. Output bands can be combined into texture indices (e.g., GLCM Homogeneity divided by Contrast enhances homogeneous areas). Directional aggregation modes (mean/min/max/separate) affect output dimensionality and interpretation. Typical texture analysis uses multiple GLCM measures simultaneously for robust classification.
    run_tool("glcm_texture", list(...))
  }
  session$global_morans_i <- function(...) {
    # Computes Global Moran's I to test spatial autocorrelation: whether similar values cluster spatially. Essential foundation for geostatistical analysis.
    run_tool("global_morans_i", list(...))
  }
  session$greater_than <- function(...) {
    # Tests whether the first raster is greater than the second on a cell-by-cell basis.
    run_tool("greater_than", list(...))
  }
  session$greater_than_or_equal_to <- function(...) {
    # Tests whether the first raster is greater than or equal to the second on a cell-by-cell basis.
    run_tool("greater_than_or_equal_to", list(...))
  }
  session$guided_filter <- function(...) {
    # The guided filter implements edge-preserving smoothing by constraining filter outputs to locally linear relationships with a guide image, typically the original or a related reference layer. Implementation divides the image into overlapping rectangular regions, computing linear regression parameters within each region to enforce output smoothness while respecting guide-image structure. The mathematical formulation minimizes ||Fᵢ - a·Gᵢ - b||² + ε||a||², where Fᵢ is filtered output, Gᵢ is guide image, and (a, b) are locally linear parameters. Key features include flexibility (guide image may be independent of filtered image), computational efficiency via O(N) separable implementation, parameter control enabling edge-preservation strength adjustment, and effectiveness on single or multispectral guidance. Guided filtering excels in multi-sensor fusion workflows where optical data guides SAR denoising, refining LiDAR classifications using coincident orthophotos, shadow/cloud removal in satellite mosaics using temporal reference images, and detail enhancement in map regularization tasks. Output interpretation reveals that filtered regions remain locally similar to guide-image structure while intensity averaging proceeds within homogeneous regions. Smoothing radius controls spatial extent (larger radius = greater smoothing); regularization parameter ε balances smoothness versus structure fidelity (larger ε = smoother, smaller ε = more detail). Output ranges match input; visual comparison with guide image validates edge preservation fidelity. Common artifacts include over-smoothing at strong discontinuities (select appropriate parameters) and insufficient smoothing in guide-poor regions (verify guide-image quality). Monitor cross-correlation between filtered output and guide image to assess alignment quality. Apply strategically in image fusion, sharpening, and reconstruction workflows where edge information from one source guides filtering of another.
    run_tool("guided_filter", list(...))
  }
  session$h_alpha_wisart_classification <- function(...) {
    # H/α/A-Wisart classification combines unsupervised zoning via H/α/A parameter space partitioning with Wishart statistical clustering to automatically classify SAR polarimetric data into 9 physically meaningful zones corresponding to scattering mechanism classes. The algorithm receives entropy (H), anisotropy (A), and alpha (α) parameters from Cloude-Pottier decomposition and partitions the 3D (H,A,α) feature space into 9 regions using fixed thresholds: Zone 1 (low H, α~20°) represents Bragg reflection on dry surfaces; Zone 5 (H~0.7, α~45°) indicates isotropic volume scattering in forests; Zone 9 (high H, α~80°) represents dihedral (double-bounce) scattering from urban structures. Within each zone, Wishart clustering optionally refines classification by computing statistical distances in multivariate polarimetric space, improving discrimination of similar mechanisms. Key features include automatic, unsupervised classification requiring no training samples; 9 physically interpretable classes with standardized definitions enabling global comparability; optional dual-mode operation (threshold-only for speed, threshold+Wishart for accuracy); and built-in confidence metrics based on distance to zone boundaries and Wishart likelihood. The tool accepts pre-computed (H,A,α) images or automatically calls Cloude-Pottier decomposition if raw matrices provided. Primary use cases encompass SAR image segmentation and map generation from polarimetric data, unsupervised classification of land cover types (water, agriculture, forest, urban) directly from SAR coherency matrices, rapid assessment of polarimetric data quality through zone occupancy distributions, and change detection revealing scattering mechanism transitions indicating land cover alteration. Output interpretation: 9-class map directly corresponds to terrain types; zones can be aggregated into broader categories (water/specular = zones 1-2, vegetation/volume = zones 4-6, urban/dihedral = zones 7-9). Unclassified pixels (class 0) indicate unusual polarimetric signatures requiring investigation.
    run_tool("h_alpha_wisart_classification", list(...))
  }
  session$hack_stream_order <- function(...) {
    # Assigns Hack stream order to stream cells.
    run_tool("hack_stream_order", list(...))
  }
  session$heat_map <- function(...) {
    # Generates a kernel-density heat map raster from point occurrences.
    run_tool("heat_map", list(...))
  }
  session$height_above_ground <- function(...) {
    # Normalizes via point-cloud geometry: computes height of each point above nearest lower ground-class neighbor. Local terrain surface without raster reference.
    run_tool("height_above_ground", list(...))
  }
  session$hexagonal_grid_from_raster_base <- function(...) {
    # Creates a hexagonal polygon grid with configurable width and orientation, providing unbiased tessellation for heatmaps and aggregation.
    run_tool("hexagonal_grid_from_raster_base", list(...))
  }
  session$hexagonal_grid_from_vector_base <- function(...) {
    # Creates a hexagonal polygon grid aligned to vector layer extent, enabling unbiased spatial aggregation and density visualization.
    run_tool("hexagonal_grid_from_vector_base", list(...))
  }
  session$high_pass_bilateral_filter <- function(...) {
    # Computes a high-pass residual by subtracting bilateral smoothing from the input raster.
    run_tool("high_pass_bilateral_filter", list(...))
  }
  session$high_pass_filter <- function(...) {
    # The high-pass filter isolates high-frequency spatial components in imagery by subtracting a low-frequency (smoothed) version from the original image. Mathematically, this is achieved by convolving the image with a kernel designed to emphasize gradients and suppress broad tonal variations. The implementation uses either direct convolution or frequency-domain processing depending on kernel size and image dimensions. The filter enhances edges, fine texture details, and small-scale variations while removing large-scale illumination trends. Key distinguishing features include preservation of edge contrast without boundary artifacts, selective frequency attenuation based on kernel radius, and direct applicability to both grayscale and multispectral imagery. High-pass filtering is invaluable for terrain analysis where subtle topographic features need enhancement, sharpening satellite imagery for visual interpretation, detecting small-scale geological structures, and preprocessing data for machine learning classification. It's also essential for preparing orthophotos for change detection and enhancing LiDAR-derived products. Output interpretation requires understanding that positive values indicate local maxima (bright edges) and negative values indicate local minima (dark edges). Typical range is ±100 for 8-bit imagery; zero-mean output indicates successful high-frequency extraction. Common artifacts include ringing at strong discontinuities and amplified noise if source imagery is noisy. Scale interpretation depends on kernel radius: smaller kernels enhance fine texture (individual pixels), while larger kernels emphasize moderate-scale features (terrain variations across tens of pixels). Monitor output statistics; excessive zero-centering indicates potential over-processing. Apply with complementary low-pass results to reconstruct original or for multi-scale decomposition workflows.
    run_tool("high_pass_filter", list(...))
  }
  session$high_pass_median_filter <- function(...) {
    # Performs high-pass filtering by subtracting local median from center values: output = pixel - median_neighborhood. Combines high-pass filtering (enhances detail) with median robustness (removes noise). Center-around-zero output (negative = darker than surroundings, positive = brighter). Robust to outliers compared to Gaussian-based high-pass. High-pass residual reveals local deviations from median trend. Particularly robust for noisy data—median is more stable than mean for outliers. Output emphasizes fine-scale variation. Often applied to Gaussian-smoothed versions (creates band-pass filter). Useful for texture enhancement and feature extraction from noisy imagery. Applications: (1) Texture enhancement from noisy data, (2) Detail extraction before classification, (3) Robust feature detection, (4) Preprocessing for texture-based segmentation, (5) SAR preprocessing.
    run_tool("high_pass_median_filter", list(...))
  }
  session$highest_position <- function(...) {
    # Returns the zero-based raster-stack index containing the highest value at each cell.
    run_tool("highest_position", list(...))
  }
  session$hillshade <- function(...) {
    # Single-source directional hillshade visualization (grayscale 0-255). Azimuth & altitude parameters control light direction. Fast terrain visualization for DEM inspection and map display.
    run_tool("hillshade", list(...))
  }
  session$hillslopes <- function(...) {
    # Identifies hillslope regions draining to each stream link, separating left- and right-bank areas.
    run_tool("hillslopes", list(...))
  }
  session$histogram_equalization <- function(...) {
    # Applies histogram equalization to improve image contrast.
    run_tool("histogram_equalization", list(...))
  }
  session$histogram_matching <- function(...) {
    # Matches an image histogram to a supplied reference histogram.
    run_tool("histogram_matching", list(...))
  }
  session$histogram_matching_two_images <- function(...) {
    # Matches an input image histogram to a reference image histogram.
    run_tool("histogram_matching_two_images", list(...))
  }
  session$hole_proportion <- function(...) {
    # Calculates polygon hole area divided by hull area and appends HOLE_PROP.
    run_tool("hole_proportion", list(...))
  }
  session$horizon_angle <- function(...) {
    # Calculates horizon angle (maximum slope) along a specified azimuth direction.
    run_tool("horizon_angle", list(...))
  }
  session$horizon_area <- function(...) {
    # Calculates area of the horizon polygon (hectares).
    run_tool("horizon_area", list(...))
  }
  session$horizontal_excess_curvature <- function(...) {
    # Calculates horizontal excess curvature from a DEM.
    run_tool("horizontal_excess_curvature", list(...))
  }
  session$horton_ratios <- function(...) {
    # Calculates Horton bifurcation, length, drainage-area, and slope ratios.
    run_tool("horton_ratios", list(...))
  }
  session$horton_stream_order <- function(...) {
    # Assigns Horton stream order to stream cells.
    run_tool("horton_stream_order", list(...))
  }
  session$hotspot_vs_process <- function(...) {
    # Compare hotspot patterns with underlying point-process intensity.
    run_tool("hotspot_vs_process", list(...))
  }
  session$hydrologic_connectivity <- function(...) {
    # Computes DUL and UDSA connectivity indices from a DEM.
    run_tool("hydrologic_connectivity", list(...))
  }
  session$hypsometric_analysis <- function(...) {
    # Creates a hypsometric (area-elevation) curve HTML report for one or more DEMs.
    run_tool("hypsometric_analysis", list(...))
  }
  session$hypsometrically_tinted_hillshade <- function(...) {
    # Creates a Swiss-style terrain rendering by blending multi-azimuth hillshade with hypsometric tinting and optional atmospheric haze.
    run_tool("hypsometrically_tinted_hillshade", list(...))
  }
  session$identity <- function(...) {
    # Preserves all input features; portions overlapping the identity layer also acquire identity attributes.
    run_tool("identity", list(...))
  }
  session$idw_interpolation <- function(...) {
    # Interpolates a raster from point samples using inverse-distance weighting.
    run_tool("idw_interpolation", list(...))
  }
  session$ihs_to_rgb <- function(...) {
    # IHS to RGB inverse transformation converts Intensity-Hue-Saturation components back to red-green-blue color space, enabling recovery of natural color from decomposed remote sensing data. The inverse formulas operate on cylindrical polar coordinates, converting hue angle and saturation magnitude plus intensity back into Cartesian RGB coordinates while maintaining numerical stability and minimizing quantization artifacts. This transformation is the critical complement to RGB-to-IHS operations, particularly in pan-sharpening workflows where intensity has been replaced with high-resolution panchromatic data. Key features include exact mathematical inversion of forward transformation ensuring consistency in round-trip operations, automatic handling of hue-undefined achromatic pixels preventing propagation of numerical artifacts, numerical stability across extreme saturation values near zero, and computational efficiency enabling seamless integration into rapid processing pipelines. The inverse transformation completes pan-sharpening workflows by recovering natural color imagery after intensity replacement with panchromatic data, enabling color visualization of enhanced resolution data, supporting spectral reconstruction from decomposed components, and validating transformation consistency in quality control workflows. IHS-to-RGB output produces three-band natural color imagery with spatial resolution inherited from the input intensity band, suitable for direct visualization and further analysis. Output bands represent red, green, and blue channels in standard order; colors exhibit enhanced spatial detail if intensity was replaced with higher-resolution panchromatic data, preserving spectral characteristics from original hue and saturation components.
    run_tool("ihs_to_rgb", list(...))
  }
  session$image_autocorrelation <- function(...) {
    # Computes Moran's I for one or more raster images.
    run_tool("image_autocorrelation", list(...))
  }
  session$image_correlation <- function(...) {
    # Computes Pearson correlation matrix for two or more raster images.
    run_tool("image_correlation", list(...))
  }
  session$image_correlation_neighbourhood_analysis <- function(...) {
    # Performs moving-window correlation analysis between two rasters and returns correlation and p-value rasters.
    run_tool("image_correlation_neighbourhood_analysis", list(...))
  }
  session$image_difference_change_detection <- function(...) {
    # Image difference change detection identifies land cover changes by computing multispectral pixel-wise differences between coregistered multitemporal satellite acquisitions, highlighting areas where spectral signatures changed sufficiently to exceed statistical background variation. The algorithm coregisters images to common pixel grids, computes differences in selected bands or vegetation indices (e.g., NDVI difference), applies statistical thresholding using mean absolute difference and confidence intervals to distinguish change from noise, and outputs binary change masks or continuous difference magnitude rasters. Image differencing is computationally simple, interpretable, and effective for detecting major changes in vegetation, urban development, or water bodies. Key features include flexible band selection enabling targeted change detection in specific spectral domains, statistical thresholding with automatic or manual confidence levels, optional preprocessing (normalization, index computation) improving change signal-to-noise, and rapid processing enabling large-scale change detection. Applications include deforestation mapping and forest loss monitoring, urban expansion tracking from multispectral satellite time series, flood mapping pre/post-event from SAR or optical data, and agricultural change detection tracking crop transitions. Image difference output highlights change areas. Output comprises change mask raster (binary change/no-change) with configurable thresholds, continuous difference magnitude raster quantifying change intensity, and optional change class raster disambiguating change type (increase, decrease); temporal aggregation enables change tracking across multi-year periods.
    run_tool("image_difference_change_detection", list(...))
  }
  session$image_regression <- function(...) {
    # Performs bivariate linear regression between two rasters and outputs a residual raster and report.
    run_tool("image_regression", list(...))
  }
  session$image_segmentation <- function(...) {
    # Segments multi-band raster stacks into contiguous homogeneous regions using seeded region growing.
    run_tool("image_segmentation", list(...))
  }
  session$image_slider <- function(...) {
    # Image Slider is an interactive visualization tool enabling direct pixel-level comparison between co-registered raster datasets through draggable horizontal or vertical overlay dividers. Algorithm: maintains two aligned raster datasets in memory, renders combined view with adjustable divider position controlling layer visibility, user interaction dynamically adjusts divider creating split-screen effect. Supports both horizontal and vertical division orientations. Key features: interactive real-time comparison, maintains full-resolution visualization, intuitive user interface requiring no analytical skills, works with multispectral and indexed rasters, supports large datasets through efficient rendering. Capabilities: change detection visualization, before/after comparison, multitemporal analysis, radiometric normalization assessment, classification accuracy visual inspection. Use cases: detecting imagery changes between dates, comparing classification results against reference data, evaluating preprocessing effectiveness, visual change detection in time-series analysis. Applications: disaster response damage assessment, urban sprawl monitoring, forest disturbance detection, agricultural change monitoring, quality control of image processing outputs. Output interpretation: visual differences reveal change magnitude and location; sharp edges indicate significant changes; gradual transitions suggest registration inaccuracy or temporal gradation; systematic differences across image reveal systematic processing artifacts.
    run_tool("image_slider", list(...))
  }
  session$image_stack_profile <- function(...) {
    # Extracts per-point profiles across an ordered raster stack and optionally writes an HTML report.
    run_tool("image_stack_profile", list(...))
  }
  session$impoundment_size_index <- function(...) {
    # Computes mean/max depth, volume, area, and dam-height impoundment metrics.
    run_tool("impoundment_size_index", list(...))
  }
  session$improved_ground_point_filter <- function(...) {
    # Multi-stage ground point filtering pipeline.
    run_tool("improved_ground_point_filter", list(...))
  }
  session$increment <- function(...) {
    # Adds a value (default 1.0) to each non-nodata raster cell.
    run_tool("increment", list(...))
  }
  session$individual_tree_detection <- function(...) {
    # Identifies tree tops: local maxima in height-filtered point cloud with adaptive search radius. Returns vector point shapefile of potential stem locations.
    run_tool("individual_tree_detection", list(...))
  }
  session$individual_tree_segmentation <- function(...) {
    # Segments vegetation points into tree crowns: mean-shift clustering with adaptive bandwidth from local canopy geometry. Inventory-level tree delineation.
    run_tool("individual_tree_segmentation", list(...))
  }
  session$inhomogeneous_baseline <- function(...) {
    # Estimate intensity surface and compute intensity-corrected K function.
    run_tool("inhomogeneous_baseline", list(...))
  }
  session$inhomogeneous_intensity_raster <- function(...) {
    # Computes kernel density estimation (KDE) surface visualizing spatial point intensity. Reveals hotspots and coldspots beyond simple density.
    run_tool("inhomogeneous_intensity_raster", list(...))
  }
  session$inplace_add <- function(...) {
    # Performs an in-place addition operation (input1 += input2).
    run_tool("inplace_add", list(...))
  }
  session$inplace_divide <- function(...) {
    # Performs an in-place division operation (input1 /= input2).
    run_tool("inplace_divide", list(...))
  }
  session$inplace_multiply <- function(...) {
    # Performs an in-place multiplication operation (input1 *= input2).
    run_tool("inplace_multiply", list(...))
  }
  session$inplace_subtract <- function(...) {
    # Performs an in-place subtraction operation (input1 -= input2).
    run_tool("inplace_subtract", list(...))
  }
  session$insert_dams <- function(...) {
    # Adds local dam embankments at specified points using profile-based crest selection.
    run_tool("insert_dams", list(...))
  }
  session$integer_division <- function(...) {
    # Divides two rasters and truncates each result toward zero.
    run_tool("integer_division", list(...))
  }
  session$integral_image_transform <- function(...) {
    # Computes a summed-area (integral image) transform for each band.
    run_tool("integral_image_transform", list(...))
  }
  session$intersect <- function(...) {
    # Intersects input and overlay polygons using topology-based overlay and tracks source feature IDs.
    run_tool("intersect", list(...))
  }
  session$inverse_pca <- function(...) {
    # Reconstructs original band images from PCA component rasters using stored eigenvectors.
    run_tool("inverse_pca", list(...))
  }
  session$is_nodata <- function(...) {
    # Outputs 1 for nodata cells and 0 for all valid cells.
    run_tool("is_nodata", list(...))
  }
  session$isobasins <- function(...) {
    # Divides a landscape into approximately equal-sized watersheds (isobasins) based on a target area threshold.
    run_tool("isobasins", list(...))
  }
  session$jenson_snap_pour_points <- function(...) {
    # Snaps each pour point to the nearest stream cell within a search distance, preserving all input attributes.
    run_tool("jenson_snap_pour_points", list(...))
  }
  session$join_tables <- function(...) {
    # Joins attributes from a foreign vector table to a primary vector table using key fields.
    run_tool("join_tables", list(...))
  }
  session$k_means_clustering <- function(...) {
    # K-means clustering performs unsupervised spectral classification by iteratively partitioning pixels into K spectral clusters, minimizing within-cluster variance and discovering natural spectral groupings in multispectral imagery without training samples or a priori class definitions. The algorithm initializes K random cluster centers, iteratively assigns pixels to nearest centers and recomputes centers as cluster means until convergence, outputting final cluster assignments and centers. K-means is computationally efficient, scalable to large multispectral stacks, and discovers data-driven spectral patterns useful for exploratory analysis and natural class identification. Key features include user-specified cluster count K enabling flexible trade-offs between spectral detail and output interpretability, convergence criteria with configurable iteration limits and center displacement thresholds, optional random seed control ensuring reproducible clustering for testing and validation, and efficient parallelization handling large imagery. Applications span unsupervised land cover classification discovering natural spectral classes, anomaly detection identifying spectrally unusual pixels, image segmentation for subsequent supervised classification, and exploratory spectral analysis revealing dominant spectral patterns. K-means output identifies natural spectral groupings. Output produces cluster membership raster with integers 0 to K-1, cluster centers file with mean spectrum per cluster, and optional within-cluster variance quantifying compactness; visualization overlays cluster classes on true-color composites revealing spatial patterns and cluster continuity.
    run_tool("k_means_clustering", list(...))
  }
  session$k_nearest_mean_filter <- function(...) {
    # Performs edge-preserving k-nearest neighbor mean smoothing: sorts neighborhood by distance to center value, averages k closest values. Hybrid approach preserving edges via similarity weighting. Center pixel and k-1 most similar neighbors are averaged. More sophisticated than simple k-NN (considers both spatial and intensity similarity). Computationally efficient relative to bilateral. K-nearest approach adaptively selects neighbors: pixel values close to center are averaged, dissimilar pixels ignored. K parameter controls smoothing: k=1 (no smoothing), k=n (all neighbors = mean filter). Typically k=n/2 (half the neighborhood). Efficient alternative to bilateral filter—similar edge preservation at lower computational cost. Particularly useful for images with strong intensity discontinuities. Applications: (1) Edge-preserving smoothing (alternative to bilateral), (2) Fast preprocessing for classification, (3) Efficiency-critical preprocessing, (4) Multi-band image filtering. Typical parameters: k=neighborhood_size/2 to 3/4.
    run_tool("k_nearest_mean_filter", list(...))
  }
  session$k_shortest_paths_network <- function(...) {
    # Finds the k shortest simple paths between start and end coordinates over a line network.
    run_tool("k_shortest_paths_network", list(...))
  }
  session$kappa_index <- function(...) {
    # Computes Cohen's kappa and agreement metrics between two categorical rasters.
    run_tool("kappa_index", list(...))
  }
  session$knn_classification <- function(...) {
    # K-nearest neighbors classification assigns pixels to classes based on majority voting among K nearest training samples in spectral space, enabling flexible nonlinear classification without explicit model training. KNN computes distances (Euclidean, spectral angle, or Mahalanobis) from each image pixel to all training samples, identifies K nearest training samples, applies weighted or unweighted majority voting to determine class, and returns class label and optionally confidence score. KNN excels with limited training data, highly nonlinear class boundaries, and heterogeneous class spectral distributions where parametric models struggle. Key features include selectable distance metrics (Euclidean, spectral angle, Mahalanobis) accommodating different spectral characteristics and correlation structures, user-specified K values enabling accuracy-complexity trade-offs, weighted voting options emphasizing nearby samples, and optional confidence thresholds enabling rejection of ambiguous classifications. Applications include high-accuracy remote sensing classification with field-collected training samples, small-sample classification where limited ground truth exists, difficult terrain classification with highly variable spectral signatures, and confidence-aware classification rejecting borderline decisions. KNN classification enables high-accuracy results with flexible training data. Output comprises class label raster with integer class IDs matching training sample labels, optional confidence raster recording voting percentages or distance-weighted confidence scores, and classification accuracy potentially exceeding other methods with optimal K selection and sufficient training samples.
    run_tool("knn_classification", list(...))
  }
  session$knn_regression <- function(...) {
    # Performs supervised k-nearest-neighbor regression on multi-band input rasters.
    run_tool("knn_regression", list(...))
  }
  session$kriging_cross_validation <- function(...) {
    # Assesses kriging model performance using Leave-One-Out Cross-Validation, computing diagnostic statistics to validate variogram fit and kriging appropriateness.
    run_tool("kriging_cross_validation", list(...))
  }
  session$ks_normality_test <- function(...) {
    # Evaluates whether raster values are drawn from a normal distribution.
    run_tool("ks_normality_test", list(...))
  }
  session$kuan_filter <- function(...) {
    # Performs Kuan speckle filtering for SAR/radar imagery using parametric approach estimating local means and variance. Adaptive weighting based on noise variance and local image variance. Similar to Lee but with different statistical assumptions. Widely used operational SAR processing method. Balance of computational efficiency and good results across varied SAR data. Kuan filtering assumes Gaussian statistics with multiplicative speckle model. Adapts to local variance—distinguishes between signal variation and speckle. Particularly effective for heterogeneous SAR imagery (mixed bright and dark features). Computationally reasonable. Represents practical compromise between sophistication and computational cost. Standard in many SAR processing systems. Applications: (1) Operational SAR despeckling, (2) Mixed-backscatter SAR preprocessing, (3) RadarSat/Sentinel-1 preprocessing, (4) Routine SAR processing. Typical parameters: filter_size=5×7 to 7×7.
    run_tool("kuan_filter", list(...))
  }
  session$kuwahara_filter <- function(...) {
    # The Kuwahara filter implements non-linear edge-preserving smoothing by dividing each pixel's neighborhood into four quadrants, computing statistics within each quadrant, and selecting the quadrant with lowest variance as the output value. Implementation partitions a (2k+1)×(2k+1) window into four overlapping k×k sub-windows, calculates mean and variance of each quadrant, and outputs the mean from the quadrant with minimum variance. This rank-based approach simultaneously smooths homogeneous regions and sharpens edges. Key features include true edge preservation via quadrant selection (edges between quadrants suppress output blurring), computational simplicity requiring only mean/variance calculations, parameter control via quadrant size k, and effectiveness on optical, radar, and thermal imagery. Kuwahara filtering excels in LiDAR-derived DEM smoothing preserving scarps and terraces, road network extraction from high-resolution imagery maintaining centerline sharpness, building footprint delineation from aerial photos, and oil-spill boundary detection in SAR imagery. Output interpretation reveals that homogeneous regions output the naturally averaging quadrant (lowest variance); edges output the quadrant containing uniform structure nearest the edge, effectively anchoring output to the cleaner side. Quadrant size k controls detail preservation: k=1 (minimal smoothing) preserves fine edges; k=3-4 provides balanced smoothing and edge preservation; k>5 risks detail loss. Output values exactly match input pixel values from selected quadrants (no interpolation). Monitor output histograms for bimodal distributions (edges and homogeneous regions clearly separated); unimodal distributions suggest edge blurring. Apply complementary sharpening if over-smoothing occurs. Common artifacts include directional bias depending on quadrant alignment and blockiness near weak edges. Use in pre-processing for segmentation where edge preservation ensures accurate boundary extraction.
    run_tool("kuwahara_filter", list(...))
  }
  session$land_surface_temperature_single_channel <- function(...) {
    # Land surface temperature retrieval from single thermal infrared channel estimates radiative skin temperature via radiative transfer equation inversion. Sensor digital numbers converted to spectral radiance using sensor-specific calibration coefficients; radiance inverted to brightness temperature via Planck function using band-specific thermal constants; brightness temperature converted to physical LST via empirical emissivity corrections. Emissivity derived from vegetation indices or provided directly, correcting for material-dependent thermal emissivity variations. Key Features: Requires single thermal band; simple radiometric processing; fast computation; no multi-channel requirement; vegetation-index emissivity estimation; direct physical temperature output. Use Cases: Urban heat island mapping; drought stress monitoring; geothermal feature detection; wildfire thermal signature tracking; agricultural water management. Output Interpretation: Output is skin radiative temperature in Kelvin (or Celsius if converted). Single-channel retrieval cannot fully remove atmospheric water vapor effects; residual atmospheric bias typically 2-5 K. Emissivity errors propagate directly: ±0.05 emissivity error ≈ ±1-2 K temperature error. Vegetation-based emissivity varies with NDVI; bare soil exhibits lower emissivity than vegetation. Time-series LST reveals heating/cooling trends; LST anomalies > background ± 5K indicate thermal features.
    run_tool("land_surface_temperature_single_channel", list(...))
  }
  session$land_surface_temperature_split_window <- function(...) {
    # Split-window LST retrieval uses dual thermal infrared bands to simultaneously estimate surface temperature and emissivity via radiative transfer equation inversion. Differential atmospheric absorption between two bands (typically 10-12 μm region) enables atmospheric water vapor correction improving accuracy over single-channel methods. Brightness temperatures from both bands inverted with vegetation-fraction based emissivity parameterization or user-supplied emissivity grids. Key Features: Dual thermal band requirement; atmospheric correction via differential absorption; simultaneous temperature/emissivity retrieval; published algorithms for standard sensors; superior atmospheric compensation compared to single-channel. Use Cases: Urban heat island mapping; agricultural drought detection; geothermal feature detection; land-atmosphere interaction studies; volcanic/thermal anomaly detection. Output Interpretation: Output is surface radiative temperature with improved atmospheric correction. Split-window retrieval reduces atmospheric water vapor bias to <1-2 K compared to single-channel 2-5 K errors. Temperature/emissivity trade-off remains: high vegetation index areas exhibit low emissivity requiring careful interpretation. Heterogeneous surfaces (mixed vegetation/soil) show intermediate values. Temporal consistency improves change detection reliability; LST trends > ±3K indicate significant thermal changes.
    run_tool("land_surface_temperature_split_window", list(...))
  }
  session$laplacian_filter <- function(...) {
    # The Laplacian filter computes the second spatial derivative of image intensity, providing powerful edge detection via isotropic (all-direction) gradient measurement. The implementation applies a fixed kernel approximating the Laplacian operator (sum of second derivatives in x and y directions), capturing intensity changes regardless of edge orientation. Unlike directional filters, this approach treats all edge directions equally, making it ideal for feature detection requiring orientation-independence. The mathematical foundation rests on the discrete approximation: ∇²I ≈ I(x+1,y) + I(x-1,y) + I(x,y+1) + I(x,y-1) - 4·I(x,y). Key features include zero-crossing detection capability (true edges occur where output crosses zero), insensitivity to edge direction, and ability to detect both light-to-dark and dark-to-light transitions identically. Laplacian filtering excels in geological mapping where structure boundaries appear as zero-crossings, vegetation boundary delineation, road network extraction from high-resolution imagery, and building footprint detection. Output interpretation centers on understanding sign transitions: strong positive values indicate local dark minima, negative values indicate local bright maxima, and zero crossings mark true edges. Typical output ranges from -1000 to +1000 for 8-bit source imagery depending on local contrast. High output magnitude indicates sharp, well-defined edges; low magnitude suggests gradual transitions. Zero-crossing detection requires careful threshold selection. Note that Laplacian is noise-sensitive (amplifies high-frequency noise), so pre-filtering with Gaussian smoothing is commonly recommended before application.
    run_tool("laplacian_filter", list(...))
  }
  session$laplacian_of_gaussians_filter <- function(...) {
    # Performs Laplacian-of-Gaussians (LoG) edge enhancement combining Gaussian smoothing with Laplacian edge detection. Computationally approximated via difference-of-Gaussians (DoG). First smooths image (reduces noise), then applies Laplacian (detects edges). Classical multi-scale edge detection technique. Zero-crossing detection on LoG output identifies precise edge locations. LoG is standard for scale-space edge detection: Gaussian removes noise, Laplacian amplifies edges. Sigma parameter controls scale of edges detected: small sigma detects fine edges, large sigma detects broad edges. LoG approximated via DoG for efficiency. Multiple sigma values enable multi-scale edge detection (identify features at different scales). Applications: (1) Robust edge detection (noise-resistant), (2) Multi-scale edge detection (use multiple sigma), (3) Zero-crossing edge localization, (4) Preprocessing for segmentation, (5) Blob detection via LoG zero-crossings. Workflow: apply LoG→identify zero-crossings→trace edges→vectorization or further processing.
    run_tool("laplacian_of_gaussians_filter", list(...))
  }
  session$las_to_ascii <- function(...) {
    # Format conversion: LAS→CSV output. Exports all point attributes to delimited text for spreadsheet/database import or scripting.
    run_tool("las_to_ascii", list(...))
  }
  session$las_to_shapefile <- function(...) {
    # Converts LAS/LAZ point clouds into vector point shapefiles.
    run_tool("las_to_shapefile", list(...))
  }
  session$layer_footprint_raster <- function(...) {
    # Creates a polygon footprint representing the full extent of an input raster.
    run_tool("layer_footprint_raster", list(...))
  }
  session$layer_footprint_vector <- function(...) {
    # Creates a polygon footprint representing the full bounding extent of an input vector layer.
    run_tool("layer_footprint_vector", list(...))
  }
  session$lee_filter <- function(...) {
    # The Lee filter performs SAR speckle reduction using Lee's multiplicative model, assuming radar returns follow multiplicative noise: I = S·N, where S is signal and N is multiplicative noise. Implementation computes local means and variances, estimating speckle variance, then filters via: F = μ + (1 - σₙ²/σ_I²)·(I - μ), where σₙ² is speckle variance and σ_I² is total variance. This model-based approach preserves high-coherence features while suppressing speckle. Key features include SAR-specific noise model (multiplicative rather than Gaussian), preservation of point targets and edges, straightforward parameter interpretation (window size controls coherence measurement), and proven effectiveness on single-pol and multi-pol SAR. Lee filtering excels in SAR preprocessing for agricultural monitoring, forest classification, ocean-surface monitoring, and flood-mapping workflows. Output interpretation shows that high-coherence regions (point targets, strong edges) filter minimally; low-coherence regions (speckle noise, weak boundaries) filter aggressively. Speckle variance estimation affects output: accurate estimation requires sufficient homogeneous pixels; underestimated variance yields under-smoothing; overestimated variance causes over-smoothing. Window size controls coherence measurement resolution: small windows (3×3) preserve fine detail; large windows (7×7) improve variance estimation but risk detail loss. Output scaling matches input; logarithmic visualization enhances visibility. Typical noise reduction achieves 5-10 dB variance decrease depending on look number. Monitor output histogram for remaining speckle signature; smooth distributions suggest adequate filtering. Artifacts include potential edge blurring in weak-coherence regions and directional bias in linear features. Apply strategically in SAR classification requiring speckle suppression while maintaining classification feature integrity.
    run_tool("lee_filter", list(...))
  }
  session$length_of_upstream_channels <- function(...) {
    # Calculates total upstream channel length.
    run_tool("length_of_upstream_channels", list(...))
  }
  session$less_than <- function(...) {
    # Tests whether the first raster is less than the second on a cell-by-cell basis.
    run_tool("less_than", list(...))
  }
  session$less_than_or_equal_to <- function(...) {
    # Tests whether the first raster is less than or equal to the second on a cell-by-cell basis.
    run_tool("less_than_or_equal_to", list(...))
  }
  session$lidar_block_maximum <- function(...) {
    # Raster from max LiDAR attribute: cell value = highest point return (elevation, intensity, class, etc.). DSM generation, canopy top extraction, pulse statistics.
    run_tool("lidar_block_maximum", list(...))
  }
  session$lidar_block_minimum <- function(...) {
    # Raster from min LiDAR attribute: cell value = lowest point return (elevation, intensity, class). DEM generation, ground surface extraction, terrain baselining.
    run_tool("lidar_block_minimum", list(...))
  }
  session$lidar_classify_subset <- function(...) {
    # Transfers classification: marks base points matching subset cloud locations. Allows spatial reclassification based on auxiliary point sets.
    run_tool("lidar_classify_subset", list(...))
  }
  session$lidar_colourize <- function(...) {
    # Assigns point colors from image: samples overlapping orthophoto/georeferenced image at each point location, stores as RGB. Photorealistic point-cloud rendering.
    run_tool("lidar_colourize", list(...))
  }
  session$lidar_construct_vector_tin <- function(...) {
    # Builds 3D mesh: Delaunay triangulation from filtered points outputs as vector polygon layer. Surface representation and topographic analysis.
    run_tool("lidar_construct_vector_tin", list(...))
  }
  session$lidar_contour <- function(...) {
    # Extracts contour vector lines: TIN-based contouring with interpolation for elevation, intensity, time. Configurable intervals and edge-length filtering.
    run_tool("lidar_contour", list(...))
  }
  session$lidar_digital_surface_model <- function(...) {
    # Generates DSM from LiDAR top-surface returns via TIN: uses local highest-point candidates within radius, then triangulation. Vegetation canopy and feature-top representation.
    run_tool("lidar_digital_surface_model", list(...))
  }
  session$lidar_eigenvalue_features <- function(...) {
    # Derives PCA features: eigenvalues/vectors from neighborhoods. Shape descriptors (planarity, linearity, height-variance) for point cloud analysis.
    run_tool("lidar_eigenvalue_features", list(...))
  }
  session$lidar_elevation_slice <- function(...) {
    # Extracts elevation-band points: filters or reclassifies points within z-range. Isolates specific layers (ground, understory, canopy) or elevation zones.
    run_tool("lidar_elevation_slice", list(...))
  }
  session$lidar_ground_point_filter <- function(...) {
    # Separates terrain from off-ground points: slope-based classification/filtering using local plane geometry and height thresholds. Efficient ground segmentation.
    run_tool("lidar_ground_point_filter", list(...))
  }
  session$lidar_hex_bin <- function(...) {
    # Aggregates points to hexagons: binning grid with per-cell summaries (count, mean-z, intensity). Uniform sampling and statistical binning.
    run_tool("lidar_hex_bin", list(...))
  }
  session$lidar_hillshade <- function(...) {
    # Renders LiDAR surface via hillshade: computes per-point surface normals from local plane-fit, then shades by illumination angle. Stores as RGB for 3D visualization.
    run_tool("lidar_hillshade", list(...))
  }
  session$lidar_histogram <- function(...) {
    # Computes attribute distribution: frequency histogram for elevation, intensity, scan-angle, class. Clipped percentiles for outlier suppression. HTML visualization.
    run_tool("lidar_histogram", list(...))
  }
  session$lidar_idw_interpolation <- function(...) {
    # Distance-weighted LiDAR gridding: assigns cell value from weighted mean of surrounding points (inverse distance power). Smooth surfaces, control via exponent parameter.
    run_tool("lidar_idw_interpolation", list(...))
  }
  session$lidar_info <- function(...) {
    # Generates metadata summary report: point count, extent, intensity range, class histogram, return distribution. HTML/text output for data documentation.
    run_tool("lidar_info", list(...))
  }
  session$lidar_join <- function(...) {
    # Merges multiple LiDAR files: concatenates point clouds while preserving attributes and header consistency. Batch processing across tile collections.
    run_tool("lidar_join", list(...))
  }
  session$lidar_kappa <- function(...) {
    # Computes a kappa agreement report between two classified LiDAR clouds and writes a class-agreement raster.
    run_tool("lidar_kappa", list(...))
  }
  session$lidar_nearest_neighbour_gridding <- function(...) {
    # Fast LiDAR gridding: assigns cell value from nearest point within search radius. Minimal interpolation bias, efficient for high-density point clouds. Quick DSM/DEM generation.
    run_tool("lidar_nearest_neighbour_gridding", list(...))
  }
  session$lidar_point_density <- function(...) {
    # Maps LiDAR sampling intensity: point count per unit area (counts within radius per cell). Data-quality assessment, coverage analysis, acquisition-pattern visualization.
    run_tool("lidar_point_density", list(...))
  }
  session$lidar_point_return_analysis <- function(...) {
    # QA tool: audits return sequence validity (multi/first/last consistency). Generates report + classified output marking return anomalies. Data integrity check.
    run_tool("lidar_point_return_analysis", list(...))
  }
  session$lidar_point_stats <- function(...) {
    # Creates raster statistics grids: point count, pulse count, avg-points/pulse, z/intensity range, predominant-class per cell. Multi-output analysis.
    run_tool("lidar_point_stats", list(...))
  }
  session$lidar_radial_basis_function_interpolation <- function(...) {
    # Smooth LiDAR surface via RBF: radial basis functions capture local curvature and micro-topography. High-quality gridding with continuous derivatives across boundaries.
    run_tool("lidar_radial_basis_function_interpolation", list(...))
  }
  session$lidar_ransac_planes <- function(...) {
    # Identifies locally planar LiDAR points using neighbourhood RANSAC plane fitting.
    run_tool("lidar_ransac_planes", list(...))
  }
  session$lidar_remove_outliers <- function(...) {
    # Detects outlier points via local elevation residuals: compares point to neighborhood mean/median, flags anomalies. Removes erratic blunders and noise.
    run_tool("lidar_remove_outliers", list(...))
  }
  session$lidar_rooftop_analysis <- function(...) {
    # Identifies planar rooftop segments within building footprints and outputs segment polygons with roof attributes.
    run_tool("lidar_rooftop_analysis", list(...))
  }
  session$lidar_segmentation <- function(...) {
    # Partitions point cloud: RANSAC plane fitting + region-growing creates connected components. Assigns segment IDs stored in RGB. Shape-based point clustering.
    run_tool("lidar_segmentation", list(...))
  }
  session$lidar_segmentation_based_filter <- function(...) {
    # Ground filtering via low-relief segmentation: grows connected components from locally flat regions, separates terrain from vegetation. Robust ground separation.
    run_tool("lidar_segmentation_based_filter", list(...))
  }
  session$lidar_shift <- function(...) {
    # Translates point cloud coordinates: x/y/z offsets for datum shifts, registration corrections, or coordinate system transformations. Bulk coordinate adjustment.
    run_tool("lidar_shift", list(...))
  }
  session$lidar_sibson_interpolation <- function(...) {
    # Natural-neighbour LiDAR gridding: Voronoi-based interpolation using natural-neighbour weights. Smooth, natural-looking surfaces without slope artifacts at point locations.
    run_tool("lidar_sibson_interpolation", list(...))
  }
  session$lidar_thin <- function(...) {
    # Decimates point cloud density: retains ≤1 point per grid cell using first/last/lowest/highest/nearest strategy. Reduces storage while preserving coverage and topographic complexity.
    run_tool("lidar_thin", list(...))
  }
  session$lidar_thin_high_density <- function(...) {
    # Adaptive density decimation: reduces point count in over-dense zones while preserving sparse regions. Equalizes sampling across variable flight-line overlap patterns.
    run_tool("lidar_thin_high_density", list(...))
  }
  session$lidar_tile <- function(...) {
    # Splits point cloud into regular grid tiles: partitions by x/y extent with configurable dimensions and minimum point threshold. Standard data distribution and processing.
    run_tool("lidar_tile", list(...))
  }
  session$lidar_tile_footprint <- function(...) {
    # Generates footprints: axis-aligned bounding boxes or convex hulls per point cloud. Vector polygon output for spatial indexing and data catalog.
    run_tool("lidar_tile_footprint", list(...))
  }
  session$lidar_tin_gridding <- function(...) {
    # Exact LiDAR interpolation via TIN: builds Delaunay triangulation from points, interpolates cell values from triangle planes. Respects point heights, excellent for irregular coverage.
    run_tool("lidar_tin_gridding", list(...))
  }
  session$lidar_tophat_transform <- function(...) {
    # Extracts height above ground via morphological white top-hat: erosion + dilation approximates local ground, residual = height. Ground-free normalization.
    run_tool("lidar_tophat_transform", list(...))
  }
  session$line_detection_filter <- function(...) {
    # The line detection filter is a specialized edge detector designed to enhance linear features—roads, rivers, powerlines, and geological lineaments—across four cardinal directions (horizontal, vertical, and both diagonals) by applying directional convolution kernels optimized for line connectivity and continuity. This filter employs 3×3 kernels that emphasize linear structures aligned with each cardinal direction while suppressing perpendicular noise and random feature variations. The directional approach separates detections by orientation, enabling downstream applications to distinguish horizontal infrastructure (pipelines, field boundaries) from vertical structures (tree rows, utility corridors). Key features include multi-directional decomposition generating separate magnitude and direction bands, adaptive sensitivity tuning for line width and contrast variations, and exceptional performance on subtle linear features embedded in complex terrain. Use cases span infrastructure mapping (roads, railways, powerlines), natural feature extraction (streams, ridges, faults), and land-use boundary delineation. Applications include vector conversion preprocessing for cadastral digitization, transportation network extraction from orthophotography, geological structure mapping from satellite imagery, and pattern recognition in remote sensing analysis. Output interpretation requires understanding that each directional component reveals line strength in that specific orientation—examine all four cardinal outputs to identify predominant feature directions. Higher magnitude values indicate stronger line continuity; low values suggest noise or breaks. The output is naturally sparse, highlighting only pixels representing linear features; background areas remain near-zero. Multi-directional output enables post-classification where roads (typically horizontal/vertical in built areas) are distinguished from natural lineaments (arbitrary orientation). Combine directional components to generate unified line map or analyze each direction separately for oriented structure mapping.
    run_tool("line_detection_filter", list(...))
  }
  session$line_intersections <- function(...) {
    # Finds line intersection points between input and overlay layers and appends parent IDs with merged attributes.
    run_tool("line_intersections", list(...))
  }
  session$line_polygon_clip <- function(...) {
    # Clips line features to polygon interiors and outputs clipped line segments.
    run_tool("line_polygon_clip", list(...))
  }
  session$line_thinning <- function(...) {
    # Reduces connected binary raster features to one-cell-wide skeleton lines.
    run_tool("line_thinning", list(...))
  }
  session$linear_spectral_unmixing <- function(...) {
    # Linear spectral unmixing decomposes each pixel's multispectral vector as non-negative linear combination of endmember spectra representing pure material signatures. Non-negative least-squares optimization solves min ||y - Ax||² subject to x ≥ 0, where y is pixel spectrum, A contains endmember signatures, and x represents abundance fractions. Sum-to-one constraint enforced ensuring abundance values represent physical proportions. Endmembers derived from training data, library databases, or extracted via endmember extraction algorithms. Key Features: Sub-pixel material estimation; abundance fractions physical interpretation; supports multiple endmembers; output constrained to valid ranges [0,1]; enables material change detection. Use Cases: Landcover abundance mapping; mineral composition estimation; urban material inventory; vegetation/soil/impervious surface fractions; spectral library-based classification. Output Interpretation: Output abundance maps show per-pixel material fractions summing to 1.0. Abundances <0.1 indicate minor components; abundances >0.7 indicate dominant materials. Residual error indicates unmixing quality; low residuals indicate good spectral fit; high residuals indicate endmember mismatch or pixel complexity.
    run_tool("linear_spectral_unmixing", list(...))
  }
  session$linearity_index <- function(...) {
    # Computes linearity index (regression r-squared) for polygon features.
    run_tool("linearity_index", list(...))
  }
  session$lines_to_polygons <- function(...) {
    # Converts polyline features into polygon features, treating the first part as the exterior ring and later parts as holes.
    run_tool("lines_to_polygons", list(...))
  }
  session$list_unique_values <- function(...) {
    # Lists unique values and frequencies in a vector attribute field.
    run_tool("list_unique_values", list(...))
  }
  session$list_unique_values_raster <- function(...) {
    # Lists unique valid raster categories and their frequencies.
    run_tool("list_unique_values_raster", list(...))
  }
  session$ln <- function(...) {
    # Computes the natural logarithm of each raster cell.
    run_tool("ln", list(...))
  }
  session$local_hypsometric_analysis <- function(...) {
    # Computes the minimum local hypsometric integral across a nonlinearly sampled range of neighbourhood scales.
    run_tool("local_hypsometric_analysis", list(...))
  }
  session$local_kriging <- function(...) {
    # Performs local ordinary kriging using k-nearest neighbors. Efficient for large datasets. Requires a pre-fitted variogram model (from fit_variogram).
    run_tool("local_kriging", list(...))
  }
  session$local_morans_i_lisa <- function(...) {
    # Computes Local Moran's I for each feature to identify local spatial clusters and outliers with statistical significance testing.
    run_tool("local_morans_i_lisa", list(...))
  }
  session$local_morans_i_lisa_raster <- function(...) {
    # Computes LISA cluster analysis from points and outputs categorical raster (HH/LL/HL/LH/NS). Enables raster-based integration.
    run_tool("local_morans_i_lisa_raster", list(...))
  }
  session$locate_points_along_routes <- function(...) {
    # Locates point features along route lines and writes route-measure attributes.
    run_tool("locate_points_along_routes", list(...))
  }
  session$location_allocation_network <- function(...) {
    # Selects k facilities and allocates demand points by network cost with greedy or exact solving, optional capacities, and required/forbidden candidate constraints.
    run_tool("location_allocation_network", list(...))
  }
  session$log10 <- function(...) {
    # Computes the base-10 logarithm of each raster cell.
    run_tool("log10", list(...))
  }
  session$log2 <- function(...) {
    # Computes the base-2 logarithm of each raster cell.
    run_tool("log2", list(...))
  }
  session$logistic_regression <- function(...) {
    # Performs supervised logistic regression classification on multi-band input rasters.
    run_tool("logistic_regression", list(...))
  }
  session$long_profile <- function(...) {
    # Creates longitudinal stream profile.
    run_tool("long_profile", list(...))
  }
  session$long_profile_from_points <- function(...) {
    # Creates long profile from vector points.
    run_tool("long_profile_from_points", list(...))
  }
  session$longest_flowpath <- function(...) {
    # Delineates longest flowpath lines for each basin in a basin raster.
    run_tool("longest_flowpath", list(...))
  }
  session$low_points_on_headwater_divides <- function(...) {
    # Locates low pass points along divides between neighboring headwater subbasins.
    run_tool("low_points_on_headwater_divides", list(...))
  }
  session$lowest_position <- function(...) {
    # Returns the zero-based raster-stack index containing the lowest value at each cell.
    run_tool("lowest_position", list(...))
  }
  session$majority_filter <- function(...) {
    # Computes moving-window mode (most frequent value/class) for each pixel. Non-linear filter preserving categorical boundaries and dominant patterns. Particularly useful for classified imagery where output must remain within original class set (unlike mean filter which creates interpolated values). Essential for morphological cleaning of classification outputs.  Majority filtering is the mode-based equivalent of median filtering. For categorical data (classified imagery, land cover), majority preserves class definitions while smoothing noise. For continuous data, majority can reveal local peaks in value distribution. Often followed by minority class elimination (post-classification cleanup) to remove "salt-and-pepper" classification artifacts.  Applications: (1) Post-classification smoothing (removes small spurious class patches), (2) Majority class map from multi-classified outputs, (3) Vector data cleaning (class disaggregation), (4) Noise suppression in thresholded imagery, (5) Attribute smoothing in segmentation outputs. Typical workflow: classify→majority filter→minority elimination→final cleaned map.
    run_tool("majority_filter", list(...))
  }
  session$map_features <- function(...) {
    # Maps discrete elevated terrain features from a raster using descending-priority region growth.
    run_tool("map_features", list(...))
  }
  session$map_matching_v1 <- function(...) {
    # Snaps trajectory points onto a line network and reconstructs an inferred route with diagnostics.
    run_tool("map_matching_v1", list(...))
  }
  session$map_off_terrain_objects <- function(...) {
    # Maps off-terrain object segments in DSMs using slope-constrained region growing and optional minimum feature-size filtering.
    run_tool("map_off_terrain_objects", list(...))
  }
  session$max <- function(...) {
    # Performs a MAX operation on two rasters or a raster and a constant value.
    run_tool("max", list(...))
  }
  session$max_absolute_overlay <- function(...) {
    # Computes the per-cell maximum absolute value across a raster stack, propagating NoData if any input cell is NoData.
    run_tool("max_absolute_overlay", list(...))
  }
  session$max_anisotropy_dev <- function(...) {
    # Calculates maximum anisotropy in elevation deviation over a range of neighbourhood scales. Written by Dan Newman.
    run_tool("max_anisotropy_dev", list(...))
  }
  session$max_anisotropy_dev_signature <- function(...) {
    # Calculates multiscale anisotropy signatures for input point sites and writes an HTML report. Written by Dan Newman.
    run_tool("max_anisotropy_dev_signature", list(...))
  }
  session$max_branch_length <- function(...) {
    # Calculates maximum branch length between neighbouring D8 flowpaths, useful for highlighting divides.
    run_tool("max_branch_length", list(...))
  }
  session$max_difference_from_mean <- function(...) {
    # Calculates maximum absolute difference-from-mean over a range of neighbourhood scales.
    run_tool("max_difference_from_mean", list(...))
  }
  session$max_downslope_elev_change <- function(...) {
    # Calculates the maximum elevation drop to lower neighbouring cells.
    run_tool("max_downslope_elev_change", list(...))
  }
  session$max_elev_dev_signature <- function(...) {
    # Calculates multiscale elevation-deviation signatures for input point sites and writes an HTML report.
    run_tool("max_elev_dev_signature", list(...))
  }
  session$max_elevation_deviation <- function(...) {
    # Calculates maximum standardized elevation deviation (DEVmax) over a range of neighbourhood scales.
    run_tool("max_elevation_deviation", list(...))
  }
  session$max_overlay <- function(...) {
    # Computes the per-cell maximum across a raster stack, propagating NoData if any input cell is NoData.
    run_tool("max_overlay", list(...))
  }
  session$max_upslope_elev_change <- function(...) {
    # Calculates the maximum elevation gain to higher neighbouring cells.
    run_tool("max_upslope_elev_change", list(...))
  }
  session$max_upslope_flowpath_length <- function(...) {
    # Computes the maximum upslope flowpath length passing through each DEM cell.
    run_tool("max_upslope_flowpath_length", list(...))
  }
  session$max_upslope_value <- function(...) {
    # Propagates maximum upslope value along D8 flowpaths over a DEM.
    run_tool("max_upslope_value", list(...))
  }
  session$maximal_curvature <- function(...) {
    # Calculates maximal (maximum principal) curvature from a DEM.
    run_tool("maximal_curvature", list(...))
  }
  session$maximum_filter <- function(...) {
    # Computes moving-window maximum value, revealing local peaks and ridges. Dilation operator in morphological image processing. Useful for detecting peaks, ridgelines, and maximum-amplitude features. Sensitive to single outlier (one high value in window produces high output).  Maximum filter is the morphological "dilation" operator—expands light regions and shrinks dark regions. When applied repeatedly (multi-pass dilation), creates smoothed peaks and isolated features grow to fill their neighborhoods. Combined with minimum filter enables closing (dilation then erosion) and opening (erosion then dilation). Essential for morphological feature detection and multi-scale analysis.  Applications: (1) Morphological dilation for size-based filtering, (2) Closing via dilation→erosion to fill small holes, (3) Peak/ridge identification in terrain and imagery, (4) Local ceiling level in bathymetry/DEM, (5) Multi-scale feature analysis (compare dilation across scales). Typical workflow: maximum→comparison with minimum→closing or opening depending on feature type.
    run_tool("maximum_filter", list(...))
  }
  session$mdinf_flow_accum <- function(...) {
    # Multiple-flow accumulation with slope-gradient weighting (exponent 1.1). Balances dispersal realism with concentrated main-flow identification. Outputs: cells, CA, or SCA.
    run_tool("mdinf_flow_accum", list(...))
  }
  session$mean_curvature <- function(...) {
    # Calculates mean curvature (average of principal curvatures). Related to total curvature but emphasizes surface smoothness. Values close to 0 indicate smooth terrain; high values indicate abrupt curvature changes. Useful for surface characterization and breakline detection.
    run_tool("mean_curvature", list(...))
  }
  session$mean_filter <- function(...) {
    # Computes moving-window mean (average) for each pixel. Fundamental smoothing operation reducing local noise while blurring sharp transitions. Output represents local central tendency. Widely used for preprocessing, noise reduction, and multi-scale analysis.  Mean filtering is the most common low-pass smoothing operation. Highly sensitive to outliers (extreme values can distort results), making median filter preferable for noisy data. Computationally efficient. Filter size controls smoothing extent: small (3×3) preserves detail, large (31×31+) creates heavily smoothed surface. Often applied iteratively or at multiple scales for multi-resolution analysis.  Applications: (1) Basic noise reduction, (2) Preprocessing before feature detection (smooths false positives), (3) Multi-scale analysis (apply at 3×3, 11×11, 31×31), (4) Temporal smoothing (combining scenes), (5) Baseline for other statistical operations. Compare with median (non-linear, preserves edges) for improved edge preservation.
    run_tool("mean_filter", list(...))
  }
  session$median_filter <- function(...) {
    # Computes moving-window median value for each pixel, replacing with 50th percentile of neighborhood. Robust noise filter preserving edges (non-linear). Particularly effective for impulse noise (salt-and-pepper) removal while maintaining sharp boundaries. Output values are actual pixel values from neighborhood (not interpolated).  Median filtering is non-linear—critical advantage over mean filtering for noise reduction because it doesn't create new values or blur edges. Large filter sizes heavily smooth while preserving sharp transitions. Widely used in remote sensing, medical imaging, and SAR image processing. Computational cost increases with filter size but generally faster than bilateral or guided filters.  Applications: (1) SAR image speckle reduction (especially effective for phase coherence), (2) Salt-and-pepper noise removal, (3) Preprocessing before edge detection (reduces false edges), (4) Boundary preservation in classification preprocessing, (5) Radiometric correction for outlier values. Typical workflow: apply median→edge-enhanced output→threshold for feature extraction.
    run_tool("median_filter", list(...))
  }
  session$medoid <- function(...) {
    # Calculates medoid points from vector geometries.
    run_tool("medoid", list(...))
  }
  session$merge_line_segments <- function(...) {
    # Merges connected line segments that meet at non-branching endpoints.
    run_tool("merge_line_segments", list(...))
  }
  session$merge_table_with_csv <- function(...) {
    # Merges attributes from a CSV table into a vector attribute table by key fields.
    run_tool("merge_table_with_csv", list(...))
  }
  session$merge_vectors <- function(...) {
    # Combines two or more input vectors of the same geometry type into a single output vector.
    run_tool("merge_vectors", list(...))
  }
  session$min <- function(...) {
    # Performs a MIN operation on two rasters or a raster and a constant value.
    run_tool("min", list(...))
  }
  session$min_absolute_overlay <- function(...) {
    # Computes the per-cell minimum absolute value across a raster stack, propagating NoData if any input cell is NoData.
    run_tool("min_absolute_overlay", list(...))
  }
  session$min_dist_classification <- function(...) {
    # Performs a supervised minimum-distance classification on multi-spectral rasters using polygon training data.
    run_tool("min_dist_classification", list(...))
  }
  session$min_downslope_elev_change <- function(...) {
    # Calculates the minimum non-negative elevation drop to neighbouring cells.
    run_tool("min_downslope_elev_change", list(...))
  }
  session$min_max_contrast_stretch <- function(...) {
    # Linearly stretches values between user-specified minimum and maximum.
    run_tool("min_max_contrast_stretch", list(...))
  }
  session$min_overlay <- function(...) {
    # Computes the per-cell minimum across a raster stack, propagating NoData if any input cell is NoData.
    run_tool("min_overlay", list(...))
  }
  session$minimal_curvature <- function(...) {
    # Calculates minimal (minimum principal) curvature from a DEM.
    run_tool("minimal_curvature", list(...))
  }
  session$minimal_dispersion_flow_algorithm <- function(...) {
    # Generates MDFA flow-direction and flow-accumulation rasters from a DEM.
    run_tool("minimal_dispersion_flow_algorithm", list(...))
  }
  session$minimum_bounding_box <- function(...) {
    # Calculates oriented minimum bounding boxes around individual features or the entire layer.
    run_tool("minimum_bounding_box", list(...))
  }
  session$minimum_bounding_circle <- function(...) {
    # Calculates minimum enclosing circles around individual features or the entire layer.
    run_tool("minimum_bounding_circle", list(...))
  }
  session$minimum_bounding_envelope <- function(...) {
    # Calculates axis-aligned minimum bounding envelopes around individual features or the entire layer.
    run_tool("minimum_bounding_envelope", list(...))
  }
  session$minimum_convex_hull <- function(...) {
    # Creates convex hull polygons around individual features or the full input layer.
    run_tool("minimum_convex_hull", list(...))
  }
  session$minimum_filter <- function(...) {
    # Computes moving-window minimum value, revealing local lows and troughs. Erosion operator in morphological image processing. Useful for detecting valley floors, depressions, and minimum-altitude features. Sensitive to single outlier (one low value in window produces low output).  Minimum filter is the morphological "erosion" operator—shrinks light regions and expands dark regions. When applied repeatedly (multi-pass erosion), creates smoothed valleys and isolated features disappear. Combined with maximum filter (dilation) enables opening (erosion then dilation) and closing (dilation then erosion) operations. Often used in multi-scale decomposition: compare min at 3×3, 11×11, 31×31 to identify feature scales.  Applications: (1) Morphological erosion for size-based filtering, (2) Opening via erosion→dilation to remove small noise objects, (3) Depression/valley identification in terrain, (4) Local floor level in bathymetry/DEM, (5) Multi-scale feature analysis (compare erosion across scales). Typical workflow: minimum→comparison with maximum→opening or closing depending on feature type.
    run_tool("minimum_filter", list(...))
  }
  session$minimum_noise_fraction <- function(...) {
    # Minimum noise fraction transforms hyperspectral data via two-step process: noise covariance estimation followed by noise whitening and principal component analysis. Noise whitening decorrelates noise across bands; PCA in whitened space identifies signal-dominated directions. Output components ordered by signal-to-noise ratio with early components representing signal, later components noise. Enables noise reduction via component truncation without conventional smoothing artifacts. Key Features: Separates signal from noise; noise concentration in late components; component selection enables noise filtering; preserves spectral fidelity; enables dimensionality reduction. Use Cases: Hyperspectral image denoising; dimension reduction for classification; signal enhancement; noise characterization; image quality assessment. Output Interpretation: First 1-3 MNF components typically contain 70-90% of signal; later components progressively noisier. Component truncation (retaining first N components) removes noise while preserving essential spectral information. MNF component images enable visual noise assessment; standard deviation of late components indicates noise level.
    run_tool("minimum_noise_fraction", list(...))
  }
  session$modified_k_means_clustering <- function(...) {
    # Modified K-means clustering enhances standard K-means with spectral preprocessing, automated adaptive K selection, and enhanced convergence criteria for more robust and accurate unsupervised multispectral classification. The algorithm applies optional preprocessing including spectral standardization removing scale effects, principal component transformation emphasizing dominant variance directions, and noise filtering removing spurious spectral variations. Adaptive K selection uses elbow methods or silhouette analysis discovering optimal cluster count automatically rather than requiring manual specification. Key features include spectral preprocessing reducing scale sensitivity and emphasizing dominant spectral variation directions, automated K selection discovering optimal cluster counts objectively, enhanced convergence criteria including relative center displacement thresholds and spectral angle similarity metrics, and optional postprocessing merging similar clusters or splitting diffuse clusters. Applications include improved exploratory land cover classification handling spectral scales automatically, robust anomaly detection separating signal from noise through preprocessing, adaptive image segmentation discovering appropriate detail levels automatically, and multisensor integration normalizing different sensor spectral scales. Modified K-means output reveals robust natural spectral classes. Output produces optimized cluster membership raster with automatically-determined class count, cluster centers with preprocessing transformations documented, and diagnostic statistics quantifying cluster quality, separation, and convergence; adaptive K selection recommendations guide interpretability versus detail trade-offs.
    run_tool("modified_k_means_clustering", list(...))
  }
  session$modified_shepard_interpolation <- function(...) {
    # Interpolates a raster from point samples using locally weighted modified-Shepard blending.
    run_tool("modified_shepard_interpolation", list(...))
  }
  session$modify_lidar <- function(...) {
    # Updates point attributes via assignments: z=z+offset, class=reclassify_expr, intensity=scale_factor. Flexible point-level transformations.
    run_tool("modify_lidar", list(...))
  }
  session$modify_nodata_value <- function(...) {
    # Changes the raster nodata value and rewrites existing nodata cells to the new value.
    run_tool("modify_nodata_value", list(...))
  }
  session$modulo <- function(...) {
    # Computes the remainder of dividing the first raster by the second on a cell-by-cell basis.
    run_tool("modulo", list(...))
  }
  session$mosaic <- function(...) {
    # Mosaicking combines multiple overlapping rasters into seamless output through geometric registration, resampling to common projection and pixel grid, and edge blending to minimize discontinuities. The algorithm registers rasters using geographic coordinates or ground control points, resamples to target resolution and extent, and applies weighted blending (Feather blending or exponential weighting) across overlap regions. Overlapping pixels are blended using distance-weighted averaging from raster edges, creating smooth transitions while preserving interior pixel accuracy. This produces seamless continental or global raster mosaics eliminating edge artefacts and radiometric discontinuities. Key features include multi-raster geometric alignment to common projection, resampling method selection (bilinear, cubic, nearest-neighbour), edge blending eliminating seams, radiometric normalization compensating for sensor or illumination differences, and support for thousands of input rasters. The tool automatically manages raster priority, avoiding gaps through intelligent fill strategies. Applications include producing continental satellite image mosaics from scene collections, generating seamless digital elevation models from multiple flight lines, creating composite optical mosaics from multi-temporal imagery, building orthomosaic from unmanned aerial vehicle (UAV) surveys, and producing base maps for large areas from overlapping satellite scenes. Mosaicking is essential for continental and global analysis workflows. Output interpretation: Output rasters inherit input projection and resolution; blend regions show interpolated values balancing input rasters. Edge artefacts indicate insufficient overlap or poor radiometric normalization; assessment examines seams and colour consistency across mosaic boundaries. Nodata handling at mosaic edges requires attention to fill values and extent definition. Quality assessment includes geometric verification through ground control points and radiometric assessment comparing mosaic values to input rasters.
    run_tool("mosaic", list(...))
  }
  session$mosaic_with_feathering <- function(...) {
    # Mosaics two rasters and feather-blends overlapping cells using edge-distance weights.
    run_tool("mosaic_with_feathering", list(...))
  }
  session$multidirectional_hillshade <- function(...) {
    # Multi-directional hillshade (8+ light sources) eliminating single-light shadowing artifacts. Balanced feature visibility for complex terrain; preferred for publications and detailed analysis.
    run_tool("multidirectional_hillshade", list(...))
  }
  session$multimodal_od_cost_matrix <- function(...) {
    # Computes batched multimodal OD costs and mode summaries between origin and destination point sets.
    run_tool("multimodal_od_cost_matrix", list(...))
  }
  session$multimodal_routes_from_od <- function(...) {
    # Builds route geometries for multimodal origin-destination point pairs with per-route mode summaries.
    run_tool("multimodal_routes_from_od", list(...))
  }
  session$multimodal_shortest_path <- function(...) {
    # Finds a mode-aware shortest path over a line network with configurable transfer penalties.
    run_tool("multimodal_shortest_path", list(...))
  }
  session$multipart_to_singlepart <- function(...) {
    # Converts a vector containing multi-part features into one with only single-part features.
    run_tool("multipart_to_singlepart", list(...))
  }
  session$multiply <- function(...) {
    # Multiplies two rasters on a cell-by-cell basis.
    run_tool("multiply", list(...))
  }
  session$multiply_overlay <- function(...) {
    # Computes the per-cell product across a raster stack, propagating NoData if any input cell is NoData.
    run_tool("multiply_overlay", list(...))
  }
  session$multiscale_curvatures <- function(...) {
    # Calculates multiscale curvatures and curvature-based indices from a DEM.
    run_tool("multiscale_curvatures", list(...))
  }
  session$multiscale_elevated_index <- function(...) {
    # Calculates multiscale elevated-index (MsEI) and key-scale rasters using Gaussian scale-space residuals.
    run_tool("multiscale_elevated_index", list(...))
  }
  session$multiscale_elevation_percentile <- function(...) {
    # Calculates the most extreme local elevation percentile across a range of neighbourhood scales.
    run_tool("multiscale_elevation_percentile", list(...))
  }
  session$multiscale_low_lying_index <- function(...) {
    # Calculates multiscale low-lying-index (MsLLI) and key-scale rasters using Gaussian scale-space residuals.
    run_tool("multiscale_low_lying_index", list(...))
  }
  session$multiscale_roughness <- function(...) {
    # Calculates surface roughness over a range of neighbourhood scales.
    run_tool("multiscale_roughness", list(...))
  }
  session$multiscale_roughness_signature <- function(...) {
    # Calculates multiscale roughness signatures for input point sites and writes an HTML report.
    run_tool("multiscale_roughness_signature", list(...))
  }
  session$multiscale_std_dev_normals <- function(...) {
    # Calculates maximum spherical standard deviation of surface normals over a nonlinearly sampled range of scales.
    run_tool("multiscale_std_dev_normals", list(...))
  }
  session$multiscale_std_dev_normals_signature <- function(...) {
    # Calculates spherical-standard-deviation scale signatures for input point sites and writes an HTML report.
    run_tool("multiscale_std_dev_normals_signature", list(...))
  }
  session$multiscale_topographic_position_class <- function(...) {
    # Classifies each DEM cell into a nine-class broad/local relative topographic position system using two DEVmax scale mosaics.
    run_tool("multiscale_topographic_position_class", list(...))
  }
  session$multiscale_topographic_position_image <- function(...) {
    # Creates a packed RGB multiscale topographic-position image from local, meso, and broad DEVmax rasters.
    run_tool("multiscale_topographic_position_image", list(...))
  }
  session$narrowness_index <- function(...) {
    # Calculates raster patch narrowness index as area divided by area of the largest contained circle based on maximum distance-to-edge.
    run_tool("narrowness_index", list(...))
  }
  session$narrowness_index_vector <- function(...) {
    # Computes narrowness index (perimeter / sqrt(area)) for polygon features.
    run_tool("narrowness_index_vector", list(...))
  }
  session$natural_neighbour_interpolation <- function(...) {
    # Interpolates a raster from point samples using true Sibson natural-neighbour area weighting.
    run_tool("natural_neighbour_interpolation", list(...))
  }
  session$ndvi_based_emissivity <- function(...) {
    # NDVI-based land surface emissivity estimation derives broadband thermal emissivity from vegetation fraction computed from NDVI, enabling thermal radiative transfer corrections for land surface temperature retrieval from thermal infrared satellite data. The algorithm computes NDVI from red and near-infrared reflectance, transforms NDVI to vegetation fraction, then applies empirical relationships between vegetation fraction and emissivity validated through field measurements and simulated radiative transfer. Vegetation significantly affects thermal emissivity; more vegetation increases emissivity toward ~0.99, while bare soil emissivity ranges ~0.90-0.98 depending on soil composition and surface roughness. Key features include automatic vegetation fraction computation from NDVI without field calibration, standard empirical relationships grounded in physical radiative transfer theory, optional sensitivity analysis exploring emissivity variations, and direct compatibility with thermal infrared satellite data. Applications include land surface temperature retrieval from thermal satellite data requiring accurate emissivity corrections (Landsat, MODIS, Sentinel-3), urban heat island analysis correcting for variable vegetation, thermal modeling in water resource and agricultural applications, and climate applications requiring consistent global thermal datasets. NDVI-based emissivity enables accurate thermal correction. Output produces emissivity raster (0-1) suitable for thermal radiative transfer correction, vegetation fraction intermediate product enabling interpretation, and metadata documenting empirical relationships and assumed soil/surface properties; emissivity values guide thermal correction uncertainty and suitability for specific applications.
    run_tool("ndvi_based_emissivity", list(...))
  }
  session$near <- function(...) {
    # Adds NEAR_FID and NEAR_DIST attributes identifying nearest features and their distances using spatial indexing.
    run_tool("near", list(...))
  }
  session$nearest_neighbour_index <- function(...) {
    # Computes the Clark-Evans nearest-neighbour index testing for complete spatial randomness. Detects clustering vs. dispersion.
    run_tool("nearest_neighbour_index", list(...))
  }
  session$nearest_neighbour_interpolation <- function(...) {
    # Interpolates a raster from point samples by assigning each cell the nearest sample value.
    run_tool("nearest_neighbour_interpolation", list(...))
  }
  session$negate <- function(...) {
    # Negates each non-nodata raster cell value.
    run_tool("negate", list(...))
  }
  session$network_accessibility_metrics <- function(...) {
    # Computes accessibility indices for origin points based on reachability to destinations with optional impedance cutoffs and decay functions.
    run_tool("network_accessibility_metrics", list(...))
  }
  session$network_centrality_metrics <- function(...) {
    # Computes baseline degree, closeness, and betweenness centrality metrics for network nodes.
    run_tool("network_centrality_metrics", list(...))
  }
  session$network_connected_components <- function(...) {
    # Assigns a connected-component ID to each line feature in a network.
    run_tool("network_connected_components", list(...))
  }
  session$network_node_degree <- function(...) {
    # Extracts network nodes from line features and computes node degree and node type.
    run_tool("network_node_degree", list(...))
  }
  session$network_od_cost_matrix <- function(...) {
    # Computes origin-destination shortest-path costs over a line network and writes a CSV matrix.
    run_tool("network_od_cost_matrix", list(...))
  }
  session$network_routes_from_od <- function(...) {
    # Builds route geometries for origin-destination point pairs over a line network.
    run_tool("network_routes_from_od", list(...))
  }
  session$network_service_area <- function(...) {
    # Computes reachable network nodes from origin points within a maximum network cost.
    run_tool("network_service_area", list(...))
  }
  session$network_topology_audit <- function(...) {
    # Audits a line network for topology anomalies—disconnected components, dead ends, and degree anomalies—that cause routing failures.
    run_tool("network_topology_audit", list(...))
  }
  session$new_raster_from_base_raster <- function(...) {
    # Creates a new raster using the extent, dimensions, and CRS of a base raster.
    run_tool("new_raster_from_base_raster", list(...))
  }
  session$new_raster_from_base_vector <- function(...) {
    # Creates a new raster from a base vector extent and cell size, filled with an optional value.
    run_tool("new_raster_from_base_vector", list(...))
  }
  session$nibble <- function(...) {
    # Fills background regions using nearest-neighbour allocation.
    run_tool("nibble", list(...))
  }
  session$nnd_classification <- function(...) {
    # Performs nearest-normalized-distance classification with optional outlier rejection.
    run_tool("nnd_classification", list(...))
  }
  session$non_local_means_filter <- function(...) {
    # Non-local means filtering performs powerful denoising by averaging similar patches identified across the entire image rather than neighboring pixels, exploiting image self-similarity to suppress noise while preserving structures. Implementation identifies patches similar to each target patch via Euclidean distance in patch-space, weights similar patches exponentially by similarity, and averages weighted patches. The algorithm computes: Fᵢ = (1/Z) Σⱼ exp(-d(Pᵢ, Pⱼ)²/h²) · Iⱼ, where d measures patch distance, h controls bandwidth, Z normalizes. Key features include superior denoising via similarity search rather than spatial proximity alone, effectiveness on complex textures and fine details, applicability to any data type, and proven performance on medical, satellite, and photographic imagery. Non-local means filtering excels in detailed satellite image restoration preserving fine texture and structure, multi-temporal stack averaging for change detection preparation, very noisy survey data denoising (ultrasonic, hyperspectral), and archaeological/aerial survey imagery enhancement. Output interpretation requires understanding that similar regions throughout the image contribute to each output pixel; locally dissimilar regions contribute negligibly. Patch size controls feature preservation (larger patches = smoother results, finer patches = more detail); bandwidth h controls similarity weighting (larger h = more patches included, smaller h = stricter similarity requirements). Output ranges match input; statistics shift toward regional means while fine structures remain. Computational cost scales with image size and patch radius; typical execution requires substantial processing time for large imagery. Monitor filtering progression via PSNR or visual inspection. Common artifacts include over-smoothing fine textures (increase patch size carefully) and under-smoothing in high-noise regions (increase bandwidth). Apply strategically in workflows requiring maximum noise reduction while preserving fine-scale features.
    run_tool("non_local_means_filter", list(...))
  }
  session$normal_vectors <- function(...) {
    # Computes per-point surface normals: PCA on local neighborhood estimates plane orientation. Normals stored in point records and RGB visualization.
    run_tool("normal_vectors", list(...))
  }
  session$normalize_lidar <- function(...) {
    # Converts absolute LiDAR elevations to height above ground: subtracts DTM (raster DEM) from point z values. Creates normalized point cloud for structure analysis.
    run_tool("normalize_lidar", list(...))
  }
  session$normalized_difference_index <- function(...) {
    # Computes (band1 - band2) / (band1 + band2) from a multiband raster.
    run_tool("normalized_difference_index", list(...))
  }
  session$not_equal_to <- function(...) {
    # Tests whether two rasters are not equal on a cell-by-cell basis.
    run_tool("not_equal_to", list(...))
  }
  session$num_downslope_neighbours <- function(...) {
    # Counts the number of 8-neighbour cells lower than each DEM cell.
    run_tool("num_downslope_neighbours", list(...))
  }
  session$num_inflowing_neighbours <- function(...) {
    # Counts the number of inflowing D8 neighbours for each DEM cell.
    run_tool("num_inflowing_neighbours", list(...))
  }
  session$num_upslope_neighbours <- function(...) {
    # Counts the number of 8-neighbour cells higher than each DEM cell.
    run_tool("num_upslope_neighbours", list(...))
  }
  session$obia_audit_report_pro <- function(...) {
    # Builds an audit report for OBIA workflow artifacts including file existence, size, and timestamp metadata.
    run_tool("obia_audit_report_pro", list(...))
  }
  session$obia_batch_orchestrator_pro <- function(...) {
    # Runs multiple OBIA pipeline jobs in one request and returns a consolidated job report.
    run_tool("obia_batch_orchestrator_pro", list(...))
  }
  session$obia_pipeline_basic <- function(...) {
    # Executes complete end-to-end OBIA workflow: segmentation (SLIC/Graph), small-region merge, spectral/shape feature extraction, and random-forest classification in single operation.
    run_tool("obia_pipeline_basic", list(...))
  }
  session$object_class_probability_maps <- function(...) {
    # Converts predictions to per-class probability maps enabling raster-based uncertainty visualization and confidence-based filtering. Supports downstream confidence thresholding and multi-label scenarios.
    run_tool("object_class_probability_maps", list(...))
  }
  session$object_features_context_neighbors <- function(...) {
    # Computes spatial context features: adjacent-object counts, shared-boundary lengths, and isolation metrics. Enables neighbor-aware classification capturing object relationships in landscape.
    run_tool("object_features_context_neighbors", list(...))
  }
  session$object_features_shape_basic <- function(...) {
    # Computes geometric and morphological shape descriptors for each segment including area (pixel count), perimeter (boundary length), compactness (perimeter-normalized circularity), elongation (length-to-width ratio), form factor (normalized shape regularity), and solidity (convex hull efficiency). Shape descriptors capture structural characteristics independent of spectral content, enabling object geometry classification and morphological pattern recognition. Key features include comprehensive shape metric suites covering area, perimeter, regularity, and elongation, computationally efficient boundary-tracing algorithms, metrics invariant to rotation and translation, applicability across scale ranges, and morphological object classification capability (e.g., elongated roads versus compact buildings). Use cases encompass building footprint classification and urban structure analysis, linear feature extraction (roads, rivers, boundaries), vegetation patch characterization and fragmentation analysis, quality control through shape-based filtering, hierarchical object recognition combining shape and spectral properties, and landscape structure quantification in ecological monitoring. Output area quantifies segment size in pixels; perimeter defines boundary complexity; compactness near 1.0 indicates circular/regular shapes, lower values indicate irregular/elongated features; elongation >1 indicates linear features, near 1 indicates compact objects; form factor combines multiple shape properties for integrated shape classification; shape metrics enable morphological filtering to isolate target object types.
    run_tool("object_features_shape_basic", list(...))
  }
  session$object_features_spectral_basic <- function(...) {
    # Computes comprehensive univariate statistical summaries of spectral reflectance values within each segment across all image bands. Per-segment calculations include mean reflectance, standard deviation (homogeneity), minimum and maximum reflectance bounds, quantile values for robust estimation, and band-wise statistics enabling multispectral texture quantification and spectral profile characterization fundamental to OBIA classification workflows. Key features include band-wise spectral statistics generation for multispectral and hyperspectral imagery, robust statistical measures capturing central tendency and dispersion, identification of spectral anomalies and outliers within segments, efficient raster-to-vector summarization, and output directly feeding machine-learning classification pipelines. Use cases span feature extraction for object-based classification using spectral metrics, land-cover type identification through spectral signature analysis, change detection through spectral statistic comparison across temporal sequences, data quality assessment and outlier detection, environmental monitoring through spectral time-series analysis, and precision agriculture applications requiring normalized spectral response characterization. Output mean values represent typical spectral response of segment material; standard deviation quantifies internal heterogeneity (low = homogeneous surface, high = mixed materials or shadows); min/max bounds identify spectral extremes within segments; spectral profiles enable comparison against reference signatures; statistics form basis for classification feature vectors; band-wise analysis reveals spectral indices and material discrimination capability.
    run_tool("object_features_spectral_basic", list(...))
  }
  session$object_features_texture_glcm_basic <- function(...) {
    # Extracts texture characteristics using Gray-Level Co-occurrence Matrix (GLCM) analysis computed from per-band intensity distributions within each segment. GLCM quantifies spatial co-occurrence of tone levels, generating descriptors including contrast (local variation), homogeneity (spatial regularity), energy (orderliness), entropy (disorder), and dissimilarity metrics capturing texture patterns independent of overall spectral brightness. Key features include GLCM-based texture metrics capturing local spatial patterns within segments, multi-directional analysis (horizontal, vertical, diagonal) for orientation-independent texture characterization, applicability to all image bands enabling texture fingerprinting, discrimination of textured versus smooth surfaces, and computationally tractable analysis at segment level. Use cases include surface roughness and texture-based material classification (asphalt versus concrete, crop type distinction), forest structure and density characterization through canopy texture, SAR image interpretation and urban fabric texture analysis, quality surface versus degraded surface discrimination, crop health assessment through canopy texture metrics, and cloud and shadow detection via texture anomalies. Output contrast high indicates rough/variable texture, low indicates smooth surfaces; homogeneity high indicates regular spatial patterns, low indicates chaotic texture; energy high indicates organized texture, low indicates random noise; entropy quantifies texture disorder; dissimilarity captures spatial pattern irregularity; texture profiles enable material-specific classification; combination with spectral features improves object type discrimination.
    run_tool("object_features_texture_glcm_basic", list(...))
  }
  session$object_features_topology_relations <- function(...) {
    # Computes graph-topology features: object degree (neighbor count), dominant-neighbor strength, and articulation flags. Captures structural position in object network for hierarchical classification.
    run_tool("object_features_topology_relations", list(...))
  }
  session$object_uncertainty_diagnostics_pro <- function(...) {
    # Computes aggregate uncertainty diagnostics from object probability outputs.
    run_tool("object_uncertainty_diagnostics_pro", list(...))
  }
  session$objects_boundary_refinement_pro <- function(...) {
    # Refines object boundaries using iterative small-region cleanup with neighbor-aware merging.
    run_tool("objects_boundary_refinement_pro", list(...))
  }
  session$objects_enforce_min_mapping_unit <- function(...) {
    # Enforces a minimum mapping unit by merging undersized object segments.
    run_tool("objects_enforce_min_mapping_unit", list(...))
  }
  session$od_sensitivity_analysis <- function(...) {
    # Computes OD shortest-path costs with impedance perturbations and outputs sensitivity statistics via Monte Carlo sampling.
    run_tool("od_sensitivity_analysis", list(...))
  }
  session$olympic_filter <- function(...) {
    # The Olympic Filter implements rank-based smoothing by removing the single highest and single lowest values from each pixel neighborhood, then averaging the remaining pixels. This robust filtering approach eliminates extreme outliers (likely noise or spurious values) while preserving the central tendency. Mathematical formulation: F = (1/(N-2)) Σ(I_sorted[2:N-1]), where sorted neighborhood values exclude highest and lowest. Implementation requires sorting small neighborhoods (computationally efficient) but produces effective noise reduction. Key features include simple outlier removal strategy, effective salt-pepper noise reduction, edge-aware filtering (edges often appear as extremes), and applicability to any data type. Olympic filtering excels in optical satellite imagery preprocessing (removes isolated bright cloud pixels and dark shadows), DEM smoothing reducing survey noise artifacts, thermal image denoising (removes sensor outliers), and radar image preprocessing. Output interpretation reveals that symmetric noise distributions (equal numbers of high/low outliers) filter symmetrically; skewed distributions (more highs or lows) produce directional filtering. Neighborhood size controls smoothing extent: 3×3 window removes 2 extremes from 9 pixels (mild filtering); larger windows filter more aggressively. Output values remain within input range (output is average of actual neighborhood values). Statistics show controlled variance reduction targeting outliers specifically. Difference images (original - filtered) highlight removed outliers; concentrated high-value regions indicate effective noise isolation. Common artifacts include insufficient smoothing if outlier frequency is low and edge blurring if edge pixels consistently rank as extremes. Multiple iterations enable progressive smoothing: single pass provides noise reduction; repeated passes intensify smoothing. Apply in rapid noise-reduction workflows requiring simple, interpretable filtering, particularly effective for salt-pepper noise in multisensor mosaics.
    run_tool("olympic_filter", list(...))
  }
  session$opening <- function(...) {
    # Performs a morphological opening operation using a rectangular structuring element.
    run_tool("opening", list(...))
  }
  session$openness <- function(...) {
    # Yokoyama topographic openness: positive (exposed ridges/peaks) and negative (enclosed valleys) exposure metrics. Landform classification and visibility/microclimate analysis.
    run_tool("openness", list(...))
  }
  session$ordinary_cokriging <- function(...) {
    # Performs multivariate spatial interpolation using auxiliary variables to improve primary variable predictions. Ideal when primary data are sparse but correlated secondary data are abundant.
    run_tool("ordinary_cokriging", list(...))
  }
  session$ordinary_kriging <- function(...) {
    # Performs kriging-based spatial interpolation from point observations to a regular grid: estimates values at unsampled locations using weighted linear combination of nearby observed values. Ordinary kriging assumes an unknown constant mean and automatically determines weights from empirical variogram structure, producing both predictions and kriging variance (prediction uncertainty).
    run_tool("ordinary_kriging", list(...))
  }
  session$orthorectification <- function(...) {
    # DEM-based geometric correction of raw imagery using RPC camera model. Removes terrain relief displacement for georeferenced orthoimage output.
    run_tool("orthorectification", list(...))
  }
  session$otsu_thresholding <- function(...) {
    # Otsu Thresholding is an automatic image segmentation method that determines the optimal global threshold value by maximizing inter-class variance in pixel intensity histograms. Algorithm: examines histogram of grayscale or single-band image, iteratively tests all possible threshold values, calculates between-class variance for each threshold, selects value maximizing variance separation between foreground and background classes. Non-parametric, requires no manual threshold specification. Key features: fully automatic threshold determination, robust to illumination variations, histogram-based approach permits fast computation, no external parameters, provides single global threshold. Capabilities: binary segmentation, unimodal and bimodal histogram optimization, handles narrow dynamic range or high-contrast images. Use cases: automatic image segmentation without user intervention, document binarization, water body extraction, cloud detection in satellite imagery, ice/snow mapping. Applications: change detection preprocessing, simple landcover classification, water mask generation, preliminary segmentation before advanced classification. Output interpretation: pixels below threshold classified as one class, above as another; histogram bimodality indicates quality of separation; poorly separated histograms indicate unsuitability for binary classification; statistical measures like between-class variance and uniformity indicate segmentation quality.
    run_tool("otsu_thresholding", list(...))
  }
  session$paired_sample_t_test <- function(...) {
    # Performs a paired-sample t-test on two rasters using paired valid cells.
    run_tool("paired_sample_t_test", list(...))
  }
  session$panchromatic_sharpening <- function(...) {
    # Panchromatic sharpening fuses high-resolution panchromatic imagery with lower-resolution multispectral data using the Brovey method, a spectral multiplication technique that enhances spatial detail while preserving spectral information. The method works by first resampling multispectral bands to match panchromatic resolution, then computing the intensity ratio between the panchromatic image and the computed multispectral intensity to scale each band accordingly. This approach maintains spectral fidelity while dramatically improving spatial resolution. Key features include preservation of original spectral characteristics, linear algebraic efficiency enabling fast processing of large images, automatic resampling compatibility with band-registered inputs, and automatic normalization for radiometric consistency across heterogeneous sensors. The technique is widely used in satellite image enhancement for mapping applications including urban planning, agricultural monitoring, and resource exploration where both spectral and spatial detail are critical. Panchromatic sharpening creates enhanced multispectral output with superior spatial definition suitable for visual interpretation and detailed mapping. Output bands maintain the original multispectral band order but with panchromatic-level resolution, allowing seamless integration into standard image analysis workflows and GIS systems. Spatial resolution increases match the input panchromatic resolution, enabling feature extraction at finer scales than the original multispectral data.
    run_tool("panchromatic_sharpening", list(...))
  }
  session$parallelepiped_classification <- function(...) {
    # Performs a supervised parallelepiped classification on multi-spectral rasters using polygon training data.
    run_tool("parallelepiped_classification", list(...))
  }
  session$patch_orientation <- function(...) {
    # Calculates polygon orientation (degrees from north) using reduced major axis regression and appends ORIENT.
    run_tool("patch_orientation", list(...))
  }
  session$pca_based_change_detection <- function(...) {
    # Principal component analysis change detection identifies land cover changes by computing principal components from multitemporal stacked spectral data, where early components capture common patterns across time and later components isolate temporal changes. The algorithm stacks multitemporal multispectral data (coregistered to common grid), computes PCA transforming into uncorrelated orthogonal spectral-temporal components, interprets later PCs as change-sensitive, and applies statistical thresholding to PC loadings/scores for change detection. PCA-based detection excels when change signals are spectrally subtle because PCA maximizes variance and separates temporally consistent spectral patterns (early PCs) from temporal variation (later PCs). Key features include multidate data fusion handling variable image counts and coregistration requirements, automatic variance maximization emphasizing important spectral-temporal patterns, multivariate statistics improving change discrimination versus univariate differencing, and optional spatial filtering reducing pixel noise. Applications include subtle vegetation stress detection preceding visual recognition, multispectral urban change detection tracking development over decades, natural disaster impact assessment through rapid damage mapping, and environmental monitoring detecting ecosystem state transitions. PCA-based detection output distinguishes temporal patterns. Output comprises principal component imagery with interpretable spectral-temporal loadings, change probability raster derived from later component scores, and optional change classification disambiguating change types; PC spatial patterns enable visual pattern recognition complementing statistical detection.
    run_tool("pca_based_change_detection", list(...))
  }
  session$pennock_landform_classification <- function(...) {
    # Classifies landform elements into seven Pennock et al. (1987) terrain classes.
    run_tool("pennock_landform_classification", list(...))
  }
  session$percent_elev_range <- function(...) {
    # Calculates local topographic position as percent of neighbourhood elevation range.
    run_tool("percent_elev_range", list(...))
  }
  session$percent_equal_to <- function(...) {
    # Computes the fraction of rasters in a stack whose values equal the comparison raster at each cell.
    run_tool("percent_equal_to", list(...))
  }
  session$percent_greater_than <- function(...) {
    # Computes the fraction of rasters in a stack whose values are greater than the comparison raster at each cell.
    run_tool("percent_greater_than", list(...))
  }
  session$percent_less_than <- function(...) {
    # Computes the fraction of rasters in a stack whose values are less than the comparison raster at each cell.
    run_tool("percent_less_than", list(...))
  }
  session$percentage_contrast_stretch <- function(...) {
    # Percentage Contrast Stretch performs linear contrast enhancement by removing specified percentages of extreme values (tails) from the histogram before stretching to full dynamic range. Algorithm: removes lower and upper percentile values from each band independently, linearly maps remaining range to output range (typically 0-255 or full bit-depth), eliminates radiometric extremes causing poor contrast. Percentile selection (commonly 2-3%) balances contrast enhancement against preservation of data integrity. Key features: removes radiometric outliers automatically, prevents contrast compression from anomalous values, applicable per-band or globally, computationally efficient linear transformation, invertible operation. Capabilities: handles radiometric artifacts, enhances visibility of subtle features, accommodates variable input ranges. Use cases: preprocessing before classification or fusion, enhancement of underutilized dynamic range, preparation for multispectral display, radiometric normalization across scenes. Applications: satellite imagery enhancement for visual interpretation, preprocessing satellite-based landslide detection, pre-classification normalization, archived imagery remediation. Output interpretation: enhanced imagery displays improved contrast; extreme values become clipped; subtle features previously hidden become visible; band-specific clipping values reveal radiometric distribution quality.
    run_tool("percentage_contrast_stretch", list(...))
  }
  session$percentile_filter <- function(...) {
    # Computes local percentile rank of center cell elevation/value within moving window (0-100%). Analogous to Elevation Percentile for generic raster data. Measures relative position: output=0 indicates local minimum, output=100 indicates local maximum, output=50 indicates median. Reveals local position-in-distribution independently of absolute values.  Percentile filtering enables position-relative analysis. Useful for layering analysis: cells ranking high percentile (>80) in all bands indicate "bright" features; low percentile (<20) indicate "dark" features. Particularly useful for classification preprocessing—separates terrain/texture position rather than just magnitude. Often combined with statistical filters for multi-metric characterization.  Applications: (1) Relative brightness/darkness classification, (2) Texture characterization (high percentile variance = rough, low variance = smooth), (3) Local contrast enhancement (percentile-based normalization), (4) Landform identification similar to elevation percentile, (5) Multi-band texture analysis (apply percentile to each band, compare patterns).
    run_tool("percentile_filter", list(...))
  }
  session$perimeter_area_ratio <- function(...) {
    # Calculates polygon perimeter/area ratio and appends P_A_RATIO.
    run_tool("perimeter_area_ratio", list(...))
  }
  session$phi_coefficient <- function(...) {
    # Performs binary classification agreement assessment using the phi coefficient.
    run_tool("phi_coefficient", list(...))
  }
  session$pick_from_list <- function(...) {
    # Selects per-cell values from a raster stack using a zero-based position raster.
    run_tool("pick_from_list", list(...))
  }
  session$piecewise_contrast_stretch <- function(...) {
    # Performs piecewise linear contrast stretching using user-specified breakpoints.
    run_tool("piecewise_contrast_stretch", list(...))
  }
  session$plan_curvature <- function(...) {
    # Calculates plan (contour) curvature measuring convergence/divergence of flow across contour lines. Positive values (convergent) indicate flow concentration toward center (concave); negative values (divergent) indicate flow dispersal away from center (convex). Identifies lateral flow concentration zones (valleys) vs. dispersal zones (ridges). Essential for predicting soil moisture distribution and landslide susceptibility.
    run_tool("plan_curvature", list(...))
  }
  session$point_pattern_envelope <- function(...) {
    # Generate critical-band envelopes for hypothesis testing against CSR.
    run_tool("point_pattern_envelope", list(...))
  }
  session$point_process_residuals <- function(...) {
    # Computes residuals from fitted Poisson point process model for diagnostics. Detects unmodeled spatial structure.
    run_tool("point_process_residuals", list(...))
  }
  session$point_process_residuals_comparison <- function(...) {
    # Compute residual diagnostics for model adequacy checking.
    run_tool("point_process_residuals_comparison", list(...))
  }
  session$points_along_lines <- function(...) {
    # Generates regular-spaced point features along input polylines for infrastructure monitoring, environmental sampling, and spatial analysis.
    run_tool("points_along_lines", list(...))
  }
  session$polygon_area <- function(...) {
    # Calculates polygon area and appends an AREA attribute field.
    run_tool("polygon_area", list(...))
  }
  session$polygon_long_axis <- function(...) {
    # Maps the long axis of each polygon feature's minimum bounding box as line output.
    run_tool("polygon_long_axis", list(...))
  }
  session$polygon_perimeter <- function(...) {
    # Calculates polygon perimeter and appends a PERIMETER attribute field.
    run_tool("polygon_perimeter", list(...))
  }
  session$polygon_short_axis <- function(...) {
    # Maps the short axis of each polygon feature's minimum bounding box as line output.
    run_tool("polygon_short_axis", list(...))
  }
  session$polygonize <- function(...) {
    # Creates polygons from input linework, including intersecting/open segments where enclosed faces can be formed.
    run_tool("polygonize", list(...))
  }
  session$polygons_to_lines <- function(...) {
    # Converts polygon and multipolygon features into linework tracing their boundaries.
    run_tool("polygons_to_lines", list(...))
  }
  session$polygons_to_segments <- function(...) {
    # Rasterizes edited polygons back to segment-label raster preserving object IDs or attribute values. Enables iterative OBIA workflows combining automated segmentation with manual refinement.
    run_tool("polygons_to_segments", list(...))
  }
  session$post_classification_change <- function(...) {
    # Post-classification change detection quantifies land-cover/land-use (LULC) transitions by directly comparing independently classified maps from different time periods. Pixel-by-pixel class comparisons identify transitions showing "from" and "to" classes. Cross-tabulation matrices (confusion matrices) quantify transition frequencies revealing dominant change pathways. Method requires consistent classification schemes across dates; accuracy depends on classification quality at each time step. Key Features: Direct class-to-class transition mapping; independence of individual classifications; enables heterogeneous sensor combinations; quantifies transition frequencies; identifies change hotspots. Use Cases: Deforestation monitoring; urban growth mapping; agricultural land-use tracking; wetland loss detection; habitat fragmentation assessment. Output Interpretation: Transition matrices show diagonal no-change values and off-diagonal transition frequencies. Change maps highlight altered pixels; transition-coded output encodes both source and target classes enabling interpretation. High accuracy requires quality classifications; classification errors at either date propagate to change detection errors. Transition aggregation reveals dominant patterns (e.g., forest→agriculture, grassland→urban). Sub-pixel transitions cannot be detected via post-classification method; fine-scale changes may be missed.
    run_tool("post_classification_change", list(...))
  }
  session$power <- function(...) {
    # Raises the first raster to the power of the second on a cell-by-cell basis.
    run_tool("power", list(...))
  }
  session$prewitt_filter <- function(...) {
    # The Prewitt operator performs gradient-based edge detection similar to Sobel, using alternative kernel weights optimized for different noise characteristics. Implementation employs two 3×3 convolution kernels computing x and y directional derivatives with uniform weighting on center and adjacent rows/columns, differing from Sobel's center-biasing approach. The gradient magnitude combines directional components via √(Gx² + Gy²), providing uniform directionality response. Mathematical foundation rests on discrete differentiation approximations equally weighting all contributing pixels rather than emphasizing centers. Key features include slightly different noise response compared to Sobel (sometimes superior in extremely noisy imagery), true magnitude/direction decomposition enabling sophisticated edge analysis, computational efficiency requiring only standard convolution operations, and proven effectiveness on radar, optical, and thermal imagery. Prewitt filtering excels in SAR image analysis where uniform weighting reduces speckle artifacts better than Sobel, thermal anomaly detection emphasizing linear features, and multi-spectral edge extraction requiring direction-independent processing. Output interpretation parallels Sobel: magnitude indicates edge strength (higher = sharper), direction computed via atan2(Gy, Gx) provides edge orientation in radians. Typical magnitude ranges 0-256 for 8-bit input; magnitudes exceeding 80 generally indicate significant edges. Direction values range -π to +π; 0 radians indicates pure horizontal edges, ±π/2 indicates pure vertical edges. The uniform kernel weighting typically produces slightly smoother gradient responses than Sobel, potentially better for sparse or fine imagery features. Apply complementary median filtering to reduce noise-induced false positives. Combine directional output with threshold selection for edge linking and boundary extraction workflows critical to segmentation pipelines.
    run_tool("prewitt_filter", list(...))
  }
  session$principal_component_analysis <- function(...) {
    # Performs PCA on a stack of rasters, returning component images and a JSON report.
    run_tool("principal_component_analysis", list(...))
  }
  session$principal_curvature_direction <- function(...) {
    # Calculates the principal curvature direction angle (degrees).
    run_tool("principal_curvature_direction", list(...))
  }
  session$print_geotiff_tags <- function(...) {
    # Produces a text report describing TIFF/GeoTIFF tags and key metadata for an input GeoTIFF-family raster.
    run_tool("print_geotiff_tags", list(...))
  }
  session$profile <- function(...) {
    # Creates an HTML elevation profile plot for one or more input polyline features sampled from a surface raster.
    run_tool("profile", list(...))
  }
  session$profile_curvature <- function(...) {
    # Calculates profile (downslope) curvature measuring flow acceleration/deceleration along slope direction. Positive values (concave) indicate flow acceleration zones (erosional); negative values (convex) indicate flow deceleration zones (depositional). Reveals slope form: concave (valley bottoms, erosion), convex (ridges, material removal), linear (transitional).
    run_tool("profile_curvature", list(...))
  }
  session$propagate_labels_across_hierarchy <- function(...) {
    # Propagates coarse-level class labels to fine-level child objects via hierarchy mappings. Enables efficient labeling of nested hierarchies and inheritance-based refinement workflows.
    run_tool("propagate_labels_across_hierarchy", list(...))
  }
  session$prune_vector_streams <- function(...) {
    # Prunes vector stream network based on Shreve magnitude.
    run_tool("prune_vector_streams", list(...))
  }
  session$qin_flow_accumulation <- function(...) {
    # Calculates Qin MFD flow accumulation from a DEM.
    run_tool("qin_flow_accumulation", list(...))
  }
  session$quadrat_count_test <- function(...) {
    # Performs chi-square test of point-pattern randomness using quadrat counts. Tests for clustering vs. dispersion.
    run_tool("quadrat_count_test", list(...))
  }
  session$quantiles <- function(...) {
    # Transforms raster values into quantile classes.
    run_tool("quantiles", list(...))
  }
  session$quinn_flow_accumulation <- function(...) {
    # Calculates Quinn MFD flow accumulation from a DEM.
    run_tool("quinn_flow_accumulation", list(...))
  }
  session$radial_basis_function_interpolation <- function(...) {
    # Interpolates a raster from point samples using local radial-basis similarity weighting.
    run_tool("radial_basis_function_interpolation", list(...))
  }
  session$radius_of_gyration <- function(...) {
    # Computes per-patch radius of gyration and maps values back to patch cells.
    run_tool("radius_of_gyration", list(...))
  }
  session$raise_walls <- function(...) {
    # Raises DEM elevations along wall vectors and optionally breaches selected crossings.
    run_tool("raise_walls", list(...))
  }
  session$random_field <- function(...) {
    # Creates a raster containing standard normal random values.
    run_tool("random_field", list(...))
  }
  session$random_forest_classification <- function(...) {
    # Random Forest classification assigns labels through ensemble decision trees trained on bootstrap samples with randomized feature subsets. Each tree grows independently without pruning, capturing complex non-linear relationships and interactions among features. Classification aggregates votes across typically 100-1000 trees; final class is majority vote. Bootstrap training and random feature selection reduce overfitting while capturing high-dimensional patterns. Feature importance can be computed from out-of-bag error changes, identifying diagnostic spectral bands or derived features most relevant to classification. Key features include variable importance ranking identifying key classification features, per-pixel classification confidence from vote consensus across ensemble trees, automatic handling of high-dimensional hyperspectral data, robustness to spectral outliers and noise, and parallelizable training and prediction. The tool efficiently processes multiclass problems with imbalanced training sets. Applications include land cover classification from multispectral and hyperspectral data, change detection identifying spectral transitions between maps, crop type classification from multi-temporal satellite imagery, urban material classification distinguishing building types and surfaces, and anomaly detection identifying spectral outliers. Random forests consistently achieve high accuracy in remote sensing applications with relatively modest training data. Output interpretation: Vote counts provide classification confidence; unanimous or strong majority votes (>80%) indicate confident classifications while narrow margins suggest mixed-pixel ambiguity. Feature importance rankings identify spectral bands or derived indices most diagnostic for classification. Out-of-bag error estimates generalization performance without hold-out validation. Feature interactions are implicit; high accuracy from particular band combinations suggests non-linear spectral relationships.
    run_tool("random_forest_classification", list(...))
  }
  session$random_forest_classification_fit <- function(...) {
    # Fits a random forest classification model and returns serialized model bytes.
    run_tool("random_forest_classification_fit", list(...))
  }
  session$random_forest_classification_predict <- function(...) {
    # Applies a serialized random forest classification model to multi-band predictors.
    run_tool("random_forest_classification_predict", list(...))
  }
  session$random_forest_regression <- function(...) {
    # Performs supervised random forest regression on multi-band input rasters.
    run_tool("random_forest_regression", list(...))
  }
  session$random_forest_regression_fit <- function(...) {
    # Fits a random forest regression model and returns serialized model bytes.
    run_tool("random_forest_regression_fit", list(...))
  }
  session$random_forest_regression_predict <- function(...) {
    # Applies a serialized random forest regression model to multi-band predictors.
    run_tool("random_forest_regression_predict", list(...))
  }
  session$random_points_in_polygon <- function(...) {
    # Generates random points uniformly within input polygon geometries.
    run_tool("random_points_in_polygon", list(...))
  }
  session$random_sample <- function(...) {
    # Creates a raster containing randomly located sample cells with unique IDs.
    run_tool("random_sample", list(...))
  }
  session$range_filter <- function(...) {
    # Computes moving-window range (maximum - minimum), revealing local value spread independent of mean level. Simple heterogeneity metric: high range = diverse values, low range = uniform values. Simpler than standard deviation but equally informative for many applications, and more robust to distribution shape.  Range is computationally efficient (requires only two comparisons). Particularly useful for detecting transitions/boundaries where range spikes indicate contrast zones. Less sensitive to distribution shape than stdev (stdev emphasizes outliers, range only uses extremes). Normalized range (range/mean) enables cross-band comparison like coefficient of variation enables cross-scale comparison.  Applications: (1) Texture/contrast mapping (easy interpretation: high range = rough/contrasted), (2) Boundary detection via range peaks, (3) Computational efficiency alternative to stdev, (4) Quality control (uniform background low range, feature areas high range), (5) Roughness/variability in generic data. Typical workflow: compute range→threshold to identify transition zones→vectorize high-range boundaries.
    run_tool("range_filter", list(...))
  }
  session$raster_area <- function(...) {
    # Estimates per-class raster polygon area in grid-cell or map units and writes class totals to each class cell.
    run_tool("raster_area", list(...))
  }
  session$raster_calculator <- function(...) {
    # Evaluates a mathematical expression on a list of input rasters cell-by-cell.
    run_tool("raster_calculator", list(...))
  }
  session$raster_cell_assignment <- function(...) {
    # Creates a raster derived from a base raster assigning row, column, x, or y values to each cell.
    run_tool("raster_cell_assignment", list(...))
  }
  session$raster_histogram <- function(...) {
    # Builds a fixed-bin histogram for valid raster cells.
    run_tool("raster_histogram", list(...))
  }
  session$raster_perimeter <- function(...) {
    # Estimates per-class raster polygon perimeter using an anti-aliasing lookup table and writes class totals to each class cell.
    run_tool("raster_perimeter", list(...))
  }
  session$raster_streams_to_vector <- function(...) {
    # Converts raster stream network to vector.
    run_tool("raster_streams_to_vector", list(...))
  }
  session$raster_summary_stats <- function(...) {
    # Computes basic summary statistics for valid raster cells.
    run_tool("raster_summary_stats", list(...))
  }
  session$raster_to_vector_lines <- function(...) {
    # Converts non-zero, non-nodata raster line cells into polyline vector features.
    run_tool("raster_to_vector_lines", list(...))
  }
  session$raster_to_vector_points <- function(...) {
    # Converts non-zero, non-nodata cells in a raster into point features located at cell centres.
    run_tool("raster_to_vector_points", list(...))
  }
  session$raster_to_vector_polygons <- function(...) {
    # Converts non-zero, non-nodata raster regions into polygon vector features with FID and VALUE attributes.
    run_tool("raster_to_vector_polygons", list(...))
  }
  session$rasterize_streams <- function(...) {
    # Rasterizes vector stream network.
    run_tool("rasterize_streams", list(...))
  }
  session$reciprocal <- function(...) {
    # Computes the reciprocal (1/x) of each raster cell.
    run_tool("reciprocal", list(...))
  }
  session$reclass <- function(...) {
    # Reclassifies raster values using either ranges or exact assignment pairs.
    run_tool("reclass", list(...))
  }
  session$reclass_equal_interval <- function(...) {
    # Reclassifies raster values into equal-width intervals over an optional value range.
    run_tool("reclass_equal_interval", list(...))
  }
  session$recover_flightline_info <- function(...) {
    # Reconstructs flightline IDs from GPS time gaps: infers flight-line boundaries, marks in point-source-ID/user-data/RGB. Flight-path recovery.
    run_tool("recover_flightline_info", list(...))
  }
  session$rectangular_grid_from_raster_base <- function(...) {
    # Creates a rectangular polygon grid covering a raster extent.
    run_tool("rectangular_grid_from_raster_base", list(...))
  }
  session$rectangular_grid_from_vector_base <- function(...) {
    # Creates a rectangular polygon grid covering a vector-layer bounding extent.
    run_tool("rectangular_grid_from_vector_base", list(...))
  }
  session$refined_lee_filter <- function(...) {
    # The Refined Lee filter improves upon standard Lee filtering through enhanced coherence estimation and edge-preserving adaptations, using refined local statistics and directional analysis for superior speckle reduction. Implementation extends Lee's model by detecting edge orientation, applying directional windows aligned with boundaries, and computing refined coherence estimates. Mathematically: F = μ + √(σ_p²/(σ_I²))·(I - μ) with directionally-aligned variance computation. This refinement improves edge preservation while maintaining speckle suppression. Key features include directional sensitivity (adapts filtering direction to image structures), improved coherence estimation (uses anisotropic windows), superior edge preservation versus standard Lee, and effectiveness on complex SAR scenes. Refined Lee filtering excels in change detection requiring sharp boundaries, InSAR coherence map preparation, polarimetric SAR processing where target preservation is critical, and forestry SAR analysis distinguishing trees from background. Output interpretation reveals that filtering respects edge orientation: horizontal edges filter horizontally; vertical edges filter vertically; diagonal edges filter diagonally. This directional adaptation minimizes filtering across true boundaries. Coherence estimates typically more accurate than standard Lee, reducing filtering artifacts. Output ranges match input; directional adaptation becomes apparent via visual inspection (edges remain sharper than standard Lee). Statistics show greater preservation of high-contrast regions. Directional components reveal scene structure orientation; strong directional bias indicates predominant feature orientation. Common artifacts reduce relative to standard Lee, particularly near edges and complex features. Artifacts include potential over-adaptation if directional estimation fails and directional window artifacts at weak boundaries. Monitor coherence maps to validate edge detection accuracy. Apply strategically in SAR classification where directional structures (e.g., forests, aligned agricultural fields) must be preserved.
    run_tool("refined_lee_filter", list(...))
  }
  session$reinitialize_attribute_table <- function(...) {
    # Creates a copy of a vector layer with only a regenerated FID attribute.
    run_tool("reinitialize_attribute_table", list(...))
  }
  session$related_circumscribing_circle <- function(...) {
    # Calculates 1 - (polygon area / smallest circumscribing circle area) and appends RC_CIRCLE.
    run_tool("related_circumscribing_circle", list(...))
  }
  session$relative_aspect <- function(...) {
    # Calculates terrain aspect relative to a user-specified azimuth (0 to 180 degrees).
    run_tool("relative_aspect", list(...))
  }
  session$relative_stream_power_index <- function(...) {
    # Calculates the relative stream power index from specific catchment area and slope.
    run_tool("relative_stream_power_index", list(...))
  }
  session$relative_topographic_position <- function(...) {
    # Calculates RTP using neighbourhood min, mean, and max elevation values.
    run_tool("relative_topographic_position", list(...))
  }
  session$remove_duplicates <- function(...) {
    # Deduplicates point cloud: removes points with identical x/y (optionally z). Handles multiple-scan overlaps and improves processing efficiency.
    run_tool("remove_duplicates", list(...))
  }
  session$remove_off_terrain_objects <- function(...) {
    # Removes steep off-terrain objects from DEMs using white top-hat normalization, slope-constrained region growing, and local interpolation.
    run_tool("remove_off_terrain_objects", list(...))
  }
  session$remove_polygon_holes <- function(...) {
    # Removes interior rings from polygon features while preserving attributes.
    run_tool("remove_polygon_holes", list(...))
  }
  session$remove_raster_polygon_holes <- function(...) {
    # Removes interior background holes (0 or nodata regions enclosed by foreground) from raster polygons.
    run_tool("remove_raster_polygon_holes", list(...))
  }
  session$remove_short_streams <- function(...) {
    # Removes stream links shorter than minimum length.
    run_tool("remove_short_streams", list(...))
  }
  session$remove_spurs <- function(...) {
    # Removes short spur artifacts from binary raster features by iterative pruning.
    run_tool("remove_spurs", list(...))
  }
  session$rename_field <- function(...) {
    # Renames an attribute field in a vector layer.
    run_tool("rename_field", list(...))
  }
  session$repair_stream_vector_topology <- function(...) {
    # Repairs topology of vector stream network.
    run_tool("repair_stream_vector_topology", list(...))
  }
  session$representative_point_vector <- function(...) {
    # Generates an interior point guaranteed to lie within or on each geometry using pole-of-inaccessibility, ideal for label placement in concave polygons.
    run_tool("representative_point_vector", list(...))
  }
  session$reproject_vector <- function(...) {
    # Reprojects vector geometries to destination EPSG projection while preserving topology and attributes, enabling multi-source integration.
    run_tool("reproject_vector", list(...))
  }
  session$resample <- function(...) {
    # Image resampling changes pixel resolution using interpolation methods including nearest neighbor (fastest, least smoothing), bilinear (linear interpolation between adjacent pixels), bicubic (cubic polynomial fitting), and cubic spline (smooth continuous interpolation) techniques. Resampling is essential for geometric registration, creating uniform resolution multispectral stacks from mixed-resolution sensors, and integrating auxiliary data at different scales. Each method involves fitting local interpolation kernels to original pixel values, evaluating kernels at new pixel locations, and returning interpolated values. Nearest neighbor preserves radiometric values (suitable for categorical data); higher-order methods smooth edges and reduce aliasing but blur sharp boundaries. Key features include selectable interpolation methods optimizing speed-accuracy trade-offs, output resolution specification via target pixel size or dimensions, automatic background value handling for areas outside input extent, and optional antialiasing filtering reducing resampling artifacts. Applications include image registration aligning data to common grids, resolution harmonization unifying multispectral stacks with varying native resolutions, downsampling reducing data volume while preserving spatial patterns, and upsampling improving visual detail for visualization. Resampling output integrates imagery at consistent resolution. Output resolution matches user specification; interpolation method affects edge definition (nearest neighbor preserves edges; higher-order methods smooth); background areas (outside input extent) receive configurable fill values; output integrates seamlessly into multispectral analysis workflows.
    run_tool("resample", list(...))
  }
  session$rescale_value_range <- function(...) {
    # Linearly rescales raster values into a target range.
    run_tool("rescale_value_range", list(...))
  }
  session$rgb_to_ihs <- function(...) {
    # RGB to Intensity-Hue-Saturation transformation decomposes red-green-blue color space into perceptually relevant components: intensity (brightness), hue (color), and saturation (color purity). The decomposition uses standard mathematical formulas converting RGB tristimulus values into cylindrical polar coordinates where intensity represents luminance, hue encodes color angle, and saturation measures color concentration. This color space is particularly useful for remote sensing because intensity can be replaced with high-resolution data while preserving original color characteristics through inverse transformation. Key features include numerically stable formulation handling edge cases (achromatic pixels) robustly, retention of full dynamic range without clipping or loss of information, automatic band scaling for consistent results across different input ranges, and computational efficiency suitable for large multispectral stacks. The technique serves multiple applications: pan-sharpening workflows where intensity is replaced with panchromatic data, color visualization enhancement, spectral preprocessing for classification algorithms, and color-to-grayscale conversions retaining perceptual information. RGB-to-IHS transformation is essential for fusion techniques combining panchromatic resolution with multispectral color information. Output comprises three single-band files representing intensity, hue, and saturation components independently usable in analysis workflows. The intensity band approximates luminance; hue ranges 0-360 degrees encoding color information; saturation ranges 0-100 percent indicating color purity.
    run_tool("rgb_to_ihs", list(...))
  }
  session$rho8_flow_accum <- function(...) {
    # Calculates Rho8 flow accumulation from a DEM or Rho8 pointer raster.
    run_tool("rho8_flow_accum", list(...))
  }
  session$rho8_pointer <- function(...) {
    # Stochastic single-flow direction weighted by slope gradient. Run multiple times for ensemble analysis reducing D8 channelization artifacts.
    run_tool("rho8_pointer", list(...))
  }
  session$ridge_and_valley_vectors <- function(...) {
    # Extracts ridge and valley centreline vectors from a DEM.
    run_tool("ridge_and_valley_vectors", list(...))
  }
  session$ring_curvature <- function(...) {
    # Calculates ring curvature (squared flow-line twisting) from a DEM.
    run_tool("ring_curvature", list(...))
  }
  session$ripleys_k_function <- function(...) {
    # Compute K(t) and L(t) for characterizing spatial clustering patterns.
    run_tool("ripleys_k_function", list(...))
  }
  session$ripleys_k_test <- function(...) {
    # Computes Ripley's K multi-scale clustering statistic. Reveals scale-dependent clustering/dispersion across distance ranges.
    run_tool("ripleys_k_test", list(...))
  }
  session$river_centerlines <- function(...) {
    # Extracts river centerlines from water raster using medial axis.
    run_tool("river_centerlines", list(...))
  }
  session$roberts_cross_filter <- function(...) {
    # The Roberts Cross filter is one of the earliest edge detection operators, employing a simple yet effective 2×2 diagonal cross-kernel pattern to compute image gradients with minimal computational overhead. This operator uses two orthogonal 2×2 matrices rotated 45° from horizontal-vertical alignment, creating cross-shaped convolution masks that detect edges emphasizing corners and diagonal transitions. The filter applies separate kernels for X and Y gradients, computing magnitude through the sum of absolute values or Euclidean norm. Key features include exceptional computational efficiency due to small 2×2 kernel size, minimal memory requirements, and fast processing on large raster datasets. The Roberts Cross is particularly effective for detecting fine-scale features and sharp transitions in high-resolution imagery. Primary use cases include rapid edge detection in time-critical applications, real-time video stream processing, preliminary boundary detection before advanced algorithms, and resource-constrained environments. Applications span aerial survey preprocessing, satellite imagery quality assessment, feature extraction for machine learning pipelines, and mobile GIS implementations. Output interpretation shows edge locations as high-magnitude pixels where spectral changes occur across the 2×2 neighborhood. Background regions typically display near-zero values; edges appear as bright linear features indicating boundaries between distinct land cover classes. The output is inherently sparse, containing edges only where gradients exceed computational precision thresholds. For multi-spectral images, apply independently to each band or compute a normalized difference index first. Edge thinning post-processing often follows Roberts application to refine output for vector conversion workflows.
    run_tool("roberts_cross_filter", list(...))
  }
  session$root_mean_square_error <- function(...) {
    # Calculates RMSE and related accuracy statistics between two rasters.
    run_tool("root_mean_square_error", list(...))
  }
  session$rotor <- function(...) {
    # Calculates the rotor (flow-line twisting) from a DEM.
    run_tool("rotor", list(...))
  }
  session$round <- function(...) {
    # Rounds each raster cell to the nearest integer.
    run_tool("round", list(...))
  }
  session$route_calibrate <- function(...) {
    # Calibrates route start/end measures from control points with known measures.
    run_tool("route_calibrate", list(...))
  }
  session$route_event_lines_from_layer <- function(...) {
    # Creates routed line events from an event vector layer using from/to measures.
    run_tool("route_event_lines_from_layer", list(...))
  }
  session$route_event_lines_from_table <- function(...) {
    # Creates routed line events from a CSV event table and a route layer using from/to measures.
    run_tool("route_event_lines_from_table", list(...))
  }
  session$route_event_merge <- function(...) {
    # Merges adjacent compatible route events.
    run_tool("route_event_merge", list(...))
  }
  session$route_event_overlay <- function(...) {
    # Overlays two route event layers by interval overlap.
    run_tool("route_event_overlay", list(...))
  }
  session$route_event_points_from_layer <- function(...) {
    # Creates routed point events from an event vector layer and a route layer.
    run_tool("route_event_points_from_layer", list(...))
  }
  session$route_event_points_from_table <- function(...) {
    # Creates routed point events from a CSV event table and a route layer.
    run_tool("route_event_points_from_table", list(...))
  }
  session$route_event_split <- function(...) {
    # Splits route events by per-route boundary measures.
    run_tool("route_event_split", list(...))
  }
  session$route_measure_qa <- function(...) {
    # Diagnoses route-event measure gaps, overlaps, non-monotonic sequences, and duplicate measures.
    run_tool("route_measure_qa", list(...))
  }
  session$route_recalibrate <- function(...) {
    # Recalibrates edited route measures from a reference route layer while preserving route measure continuity.
    run_tool("route_recalibrate", list(...))
  }
  session$ruggedness_index <- function(...) {
    # Terrain roughness via Riley TRI (sum of squared elevation differences). Scale-independent terrain classification metric: low=smooth plains, high=rough mountains. Ecological and geomorphological landform mapping.
    run_tool("ruggedness_index", list(...))
  }
  session$saga_wetness_index <- function(...) {
    # Computes a SAGA-style wetness index using an optional suction offset on the catchment area and a minimum slope threshold.
    run_tool("saga_wetness_index", list(...))
  }
  session$savitzky_golay_2d_filter <- function(...) {
    # Performs 2D Savitzky-Golay smoothing—polynomial fitting-based filter preserving local polynomial features. Fits local polynomial to neighborhood, replaces center with fitted value. Preserves peaks/valleys better than Gaussian. Useful for noisy data where feature preservation important. Less blurring than Gaussian for low-order polynomials; smoothing increases with polynomial order. Savitzky-Golay filtering fits local polynomial (typically quadratic/cubic) by least-squares to neighborhood. Center value replaced with polynomial value. Different from median/Gaussian—preserves features that appear as polynomial structures (peaks, valleys, ridges). Computationally straightforward but slower than simple convolution. Polynomial order controls smoothing/preservation trade-off. Applications: (1) Smooth noisy data while preserving peak structures, (2) Elevation grid processing (preserves ridge/valley topography), (3) Spectral data smoothing (preserves absorption features), (4) Feature-preserving preprocessing.
    run_tool("savitzky_golay_2d_filter", list(...))
  }
  session$scharr_filter <- function(...) {
    # The Scharr filter is an edge detection operator that improves upon the Sobel filter by using optimized kernel coefficients specifically designed to reduce directional bias and provide superior rotation invariance. The Scharr operator employs 3×3 convolution kernels with integer coefficients (3, 10, 3) that are empirically optimized for 0°, 45°, 90°, and 135° edge directions, delivering more accurate gradient estimation than traditional Sobel filters especially for circular features and rotated edges. The filter computes both horizontal and gradient magnitude simultaneously, enabling robust edge localization. Key advantages include superior accuracy for directional gradients, reduced rotational bias compared to Sobel, and efficient 3×3 kernel computation requiring minimal memory overhead. Output includes both magnitude and optional directional components. The Scharr filter excels in feature extraction, boundary detection, and quality assurance workflows requiring high directional accuracy. Use cases include extracting building footprints from aerial imagery, detecting road networks, delineating water boundaries with minimal distortion, and identifying geological lineaments in satellite data. The filter performs exceptionally well in urban mapping, agricultural boundary detection, and autonomous navigation applications. Output interpretation requires understanding that magnitude values represent edge strength—higher values indicate sharper transitions between distinct spectral classes. Directional components reveal predominant edge orientation (horizontal, diagonal, or vertical), useful for lineament analysis. For multi-band rasters, apply separately to each band or use a computed index. Background values appear dark in output; strong edges appear bright. RMSE comparison with reference edges validates filter performance. Scale the output to 0-255 for standard visualization or preserve floating-point for quantitative analysis.
    run_tool("scharr_filter", list(...))
  }
  session$sediment_transport_index <- function(...) {
    # Calculates the sediment transport index (LS factor) from specific catchment area and slope.
    run_tool("sediment_transport_index", list(...))
  }
  session$segment_graph_felzenszwalb <- function(...) {
    # Felzenswalb's graph-based segmentation treats the image as weighted undirected graph where pixels are nodes and edges connect adjacent pixels with weights representing spectral dissimilarity. Segments merge iteratively by comparing edge weights within components against dynamic thresholds; edges with weights below threshold merge, producing segments of locally homogeneous spectral characteristics. This hierarchical approach produces perceptually meaningful segmentations sensitive to local contrast variations and natural color/texture discontinuities. Key Features: Graph-based hierarchical segmentation; efficient O(n log n) computational complexity; sensitive to local contrast variations; produces perceptually meaningful segments; supports multispectral/hyperspectral data; generates variable-sized regions preserving natural boundaries. Use Cases: Multispectral image segmentation; natural habitat mapping; urban feature extraction; forest canopy delineation; change detection preprocessing; hyperspectral data segmentation. Output Interpretation: Output is labeled raster; each pixel assigned segment ID. Segment size varies inversely with local spectral contrast; high-contrast boundaries produce smaller, numerous segments; uniform regions merge into larger segments. Sensitivity to k-parameter (threshold scale) allows producing coarser or finer segmentations. Segment boundaries correspond to natural spectral discontinuities.
    run_tool("segment_graph_felzenszwalb", list(...))
  }
  session$segment_multiresolution_hierarchical <- function(...) {
    # Generates multi-scale hierarchical segmentations (coarse and fine) with explicit parent-child mappings. Enables scale-dependent feature extraction and multi-level classification workflows.
    run_tool("segment_multiresolution_hierarchical", list(...))
  }
  session$segment_scale_parameter_optimizer <- function(...) {
    # Searches candidate segmentation scale parameters to identify optimal scale matching target object count. Automated scale selection eliminates manual tuning for consistent segmentation quality.
    run_tool("segment_scale_parameter_optimizer", list(...))
  }
  session$segment_slic_superpixels <- function(...) {
    # SLIC (Simple Linear Iterative Clustering) performs iterative pixel clustering in the 5D feature space combining spatial coordinates and color/spectral values, converging superpixels toward local homogeneity. The algorithm initializes a regular grid of cluster centers and assigns pixels to nearest centers, iteratively updating centers and reducing search regions. This produces compact, regularly-shaped superpixels with minimal boundary violation compared to watershed or mean-shift alternatives, offering superior boundary adherence to natural edges. Key Features: Produces uniform, compact superpixels; computationally efficient with linear time complexity; user-configurable compactness parameter balances spatial regularity with spectral coherence; minimal boundary overshooting; supports multispectral imagery. Use Cases: Object-based classification preprocessing; hierarchical region analysis; SAR and optical image segmentation; urban mapping; vegetation delineation; land-use boundary identification. Output Interpretation: Output is labeled raster where pixel values represent assigned superpixel IDs. Superpixel boundaries align with dominant edges and color transitions. Smaller superpixels (higher granularity) capture finer details but increase computational load; larger superpixels (lower granularity) merge similar regions, improving efficiency. Boundary accuracy depends on compactness parameter tuning and multispectral band separation.
    run_tool("segment_slic_superpixels", list(...))
  }
  session$segment_watershed_markers <- function(...) {
    # Marker-driven watershed-like segmentation separating objects around identified marker seed regions. Emphasizes boundary preservation while controlling segment size for hierarchical OBIA workflows.
    run_tool("segment_watershed_markers", list(...))
  }
  session$segments_merge_small_regions <- function(...) {
    # Segment merging implements hierarchical consolidation through spatial adjacency analysis and user-defined merge criteria. Evaluates each undersized segment against neighboring regions using size thresholds, spectral similarity measures, or custom morphological criteria; progressively merges candidate segments into absorbing neighbors following priority queues based on merge cost, preserving segment connectivity and avoiding topology violations. Key features include post-processing regularization of over-segmented imagery, user-configurable merge criteria (minimum size, spectral similarity threshold, morphological properties), preservation of segment boundary integrity during merging, production of compact simplified segment maps, and hierarchical refinement without full resegmentation. Use cases include cleanup of over-segmented OBIA results reducing fragmentation and noise, simplification of segments for improved classification stability, elimination of spurious small segments from initial segmentation, standardization of segment properties for uniform downstream feature extraction, and quality assurance refinement of multi-scale segmentation hierarchies. Output exhibits decreased segment count reflecting consolidation; merged segments inherit spectral statistics from absorbed components; boundaries become smoother with reduced complexity; merged regions maintain spatial integrity but exhibit slightly increased internal spectral heterogeneity; output is optimized for downstream classification and feature stability.
    run_tool("segments_merge_small_regions", list(...))
  }
  session$segments_split_low_cohesion <- function(...) {
    # Re-segments existing low-cohesion objects using finer scale settings to improve spectral homogeneity. Adaptive refinement for problematic zones without affecting well-formed objects.
    run_tool("segments_split_low_cohesion", list(...))
  }
  session$segments_to_polygons <- function(...) {
    # Converts raster segment labels to vector polygons for interactive editing, quality control, and GIS integration. Enables seamless transition between raster and vector OBIA representations.
    run_tool("segments_to_polygons", list(...))
  }
  session$select_by_location <- function(...) {
    # Filters target features by spatial predicates (intersects, within, contains, touches, overlaps, etc.) relative to query features.
    run_tool("select_by_location", list(...))
  }
  session$select_tiles_by_polygon <- function(...) {
    # Batch tile selection: copies LAS/LAZ tiles from directory to output when tile sample points intersect polygon boundaries. AOI-based data extraction.
    run_tool("select_tiles_by_polygon", list(...))
  }
  session$set_nodata_value <- function(...) {
    # Sets a raster nodata value and maps existing nodata cells to the specified background value.
    run_tool("set_nodata_value", list(...))
  }
  session$shadow_animation <- function(...) {
    # Creates an interactive HTML viewer and animated GIF showing terrain shadows throughout a day.
    run_tool("shadow_animation", list(...))
  }
  session$shadow_image <- function(...) {
    # Generates a terrain shadow intensity raster for a specified date, time, and location.
    run_tool("shadow_image", list(...))
  }
  session$shape_complexity_index_raster <- function(...) {
    # Computes raster patch shape complexity from horizontal/vertical transition frequency normalized by patch span.
    run_tool("shape_complexity_index_raster", list(...))
  }
  session$shape_complexity_index_vector <- function(...) {
    # Computes shape complexity index for vector polygon features using normalized form factor.
    run_tool("shape_complexity_index_vector", list(...))
  }
  session$shape_index <- function(...) {
    # Calculates the shape index surface form descriptor from a DEM.
    run_tool("shape_index", list(...))
  }
  session$shortest_path_network <- function(...) {
    # Finds the shortest path between start and end coordinates over a line network.
    run_tool("shortest_path_network", list(...))
  }
  session$shreve_stream_magnitude <- function(...) {
    # Calculates Shreve stream magnitude.
    run_tool("shreve_stream_magnitude", list(...))
  }
  session$sieve <- function(...) {
    # Removes small isolated patches below a cell-count threshold.
    run_tool("sieve", list(...))
  }
  session$sigmoidal_contrast_stretch <- function(...) {
    # Performs sigmoidal contrast stretching using gain and cutoff.
    run_tool("sigmoidal_contrast_stretch", list(...))
  }
  session$simple_kriging <- function(...) {
    # Performs simple kriging with a known constant mean. Requires a pre-fitted variogram model (from fit_variogram). Produces lower variance than ordinary kriging when the mean is reliably known.
    run_tool("simple_kriging", list(...))
  }
  session$simplify_features <- function(...) {
    # Reduces geometry complexity using Douglas-Peucker algorithm to minimize file size, remove GPS noise, and optimize rendering performance while preserving shape.
    run_tool("simplify_features", list(...))
  }
  session$sin <- function(...) {
    # Computes the sine of each raster cell value.
    run_tool("sin", list(...))
  }
  session$singlepart_to_multipart <- function(...) {
    # Merges single-part features into multi-part features, grouped by an optional categorical field.
    run_tool("singlepart_to_multipart", list(...))
  }
  session$sinh <- function(...) {
    # Computes the hyperbolic sine of each raster cell.
    run_tool("sinh", list(...))
  }
  session$sink <- function(...) {
    # Identifies cells that belong to topographic depressions in a DEM.
    run_tool("sink", list(...))
  }
  session$sky_view_factor <- function(...) {
    # Calculates the proportion of visible sky from a DEM/DSM.
    run_tool("sky_view_factor", list(...))
  }
  session$skyline_analysis <- function(...) {
    # Performs skyline analysis for one or more observation points and writes a vector horizon trace plus HTML report.
    run_tool("skyline_analysis", list(...))
  }
  session$slope <- function(...) {
    # Zevenbergen-Thorne slope gradient (degrees/radians/percent). Fundamental geomorphometric metric; downstream input to curvature, flow direction, shading, visibility.
    run_tool("slope", list(...))
  }
  session$slope_vs_aspect_plot <- function(...) {
    # Creates an HTML radial slope-vs-aspect analysis plot for an input DEM.
    run_tool("slope_vs_aspect_plot", list(...))
  }
  session$slope_vs_elev_plot <- function(...) {
    # Creates an HTML slope-vs-elevation analysis chart for one or more DEMs.
    run_tool("slope_vs_elev_plot", list(...))
  }
  session$smooth_vectors <- function(...) {
    # Smooths polyline or polygon geometries using moving-average filtering to reduce digitization noise and GPS track jitter.
    run_tool("smooth_vectors", list(...))
  }
  session$smooth_vegetation_residual <- function(...) {
    # Reduces canopy residual roughness by masking high local DEV responses at small scales and re-interpolating masked elevations.
    run_tool("smooth_vegetation_residual", list(...))
  }
  session$snap_endnodes <- function(...) {
    # Snaps nearby polyline endpoints to a shared location within a tolerance.
    run_tool("snap_endnodes", list(...))
  }
  session$snap_events_to_routes <- function(...) {
    # Snaps event points to route lines and reports route measure/offset diagnostics.
    run_tool("snap_events_to_routes", list(...))
  }
  session$snap_points_to_network <- function(...) {
    # Snaps input point features to the nearest location along a network line layer.
    run_tool("snap_points_to_network", list(...))
  }
  session$snap_pour_points <- function(...) {
    # Snaps pour points to the highest flow-accumulation cell within a search distance.
    run_tool("snap_pour_points", list(...))
  }
  session$sobel_filter <- function(...) {
    # The Sobel operator detects edges via directional gradient estimation in both x (horizontal) and y (vertical) directions, combining orthogonal derivative kernels into a unified magnitude representation. Implementation applies two 3×3 convolution kernels independently (one emphasizing horizontal edges, one emphasizing vertical), then combines results via the Euclidean norm: magnitude = √(Gx² + Gy²). This separable approach reduces computational cost while maintaining edge detection accuracy. The mathematical basis derives from discrete approximations of image gradients, with kernel weights biasing toward center pixels to improve noise robustness. Key features include directional gradient measurement enabling edge orientation determination, relatively low computational overhead, proven effectiveness across satellite and aerial imagery, and minimal parameter tuning requirements. Sobel filtering finds extensive application in terrain slope and aspect calculation, feature boundary extraction for object detection workflows, river network delineation from DEM data, and infrastructure (roads, buildings, power lines) mapping from high-resolution imagery. Output interpretation reveals magnitude indicates edge strength (higher values = sharper transitions), while directional components (Gx, Gy) enable orientation analysis. Typical gradient magnitudes range 0-256 for 8-bit imagery; values exceeding 100 generally indicate significant edges. The ratio Gx/Gy provides edge orientation information: ratio approaching 1 indicates 45-degree edges, ratio >>1 indicates horizontal features, ratio <<1 indicates vertical features. False positives commonly occur in noisy regions; median filtering or morphological operations effectively reduce spurious detections. Combine with thresholding for binary edge masks suitable for segmentation pipelines.
    run_tool("sobel_filter", list(...))
  }
  session$sort_lidar <- function(...) {
    # Orders points by multiple criteria: x/y/z with bin sizes, plus derived attributes. Optimizes spatial coherence for compression and tile processing.
    run_tool("sort_lidar", list(...))
  }
  session$spacetime_kriging <- function(...) {
    # Performs space-time kriging for spatially-distributed time series data. Requires separate fitted spatial and temporal variogram models.
    run_tool("spacetime_kriging", list(...))
  }
  session$spatial_error_regression <- function(...) {
    # Estimates spatial error model addressing exogenous spatial dependence in residuals from omitted variables or measurement error.
    run_tool("spatial_error_regression", list(...))
  }
  session$spatial_error_regression_raster <- function(...) {
    # Estimates SEM model and outputs fitted value surface.
    run_tool("spatial_error_regression_raster", list(...))
  }
  session$spatial_join <- function(...) {
    # Transfers attributes from join-layer features to targets using spatial predicates; supports aggregation strategies (count, sum, mean, min, max) for multiple matches.
    run_tool("spatial_join", list(...))
  }
  session$spatial_lag_regression <- function(...) {
    # Estimates spatial autoregressive model capturing endogenous spillover effects where dependent variable is influenced by spatial neighbors.
    run_tool("spatial_lag_regression", list(...))
  }
  session$spatial_lag_regression_raster <- function(...) {
    # Estimates SAR model and outputs fitted value surface.
    run_tool("spatial_lag_regression_raster", list(...))
  }
  session$spectral_angle_mapper <- function(...) {
    # Spectral Angle Mapping classifies pixels by computing spectral angles between each pixel spectrum and reference library spectra, assigning pixels to the library spectrum with minimum angle, representing maximum spectral similarity independent of illumination intensity. SAM treats each pixel and reference spectrum as vectors in N-dimensional spectral space, computing angles between vectors using dot product operations and inverse cosine transformations. This spectral-angle-based classification is invariant to illumination and topographic effects that scale overall brightness but preserve spectral shape, making it robust for complex terrain and varying acquisition conditions. Key features include automatic spectral angle threshold definition enabling probabilistic classification confidence, reference library import supporting user-provided spectral signatures from field samples or spectral libraries, illumination invariance handling variable lighting while preserving spectral discrimination, and rapid computation enabling real-time classification of large images. Common applications include material identification and geological mapping using USGS spectral libraries, vegetation species classification combining multispectral satellite data with field-collected spectra, mineral prospecting in hyperspectral airborne surveys, and accuracy assessment comparing image spectra against ground-collected reference signatures. SAM output enables confident material identification leveraging spectral shape signatures. Classification output produces single-band imagery with integer class labels corresponding to library entries; confidence raster optionally records minimum spectral angles for each pixel enabling threshold-based filtering; output enables direct material identification and confidence-based filtering.
    run_tool("spectral_angle_mapper", list(...))
  }
  session$spectral_library_matching <- function(...) {
    # Spectral library matching performs classification by comparing image pixel spectra to reference library spectra using multiple similarity metrics including spectral angle (angle between spectra vectors), Euclidean distance (magnitude difference), and spectral information divergence. The algorithm accepts user-provided reference spectral library with known material/class spectra, computes similarity metrics between each image pixel and library entries, identifies the library spectrum with best match (minimum angle, minimum distance, or minimum divergence), and outputs class labels with optional confidence/similarity scores. Library matching enables material identification without field training samples by leveraging reference spectra from USGS, field surveys, or laboratory spectroscopy. Key features include multiple similarity metrics enabling metric selection for specific spectral characteristics and class distributions, library import flexibility supporting various spectral library formats, optional confidence/uncertainty quantification, and direct identifiable material output. Applications include geological mapping using USGS spectral library for mineralogy, vegetation classification using plant spectral reference libraries, building material identification in urban areas, and airborne hyperspectral survey analysis. Spectral library matching enables automated material identification. Output comprises classified map with library entry IDs as class labels, similarity/confidence raster quantifying match quality, and optional full spectral angle/distance stack for each library entry enabling threshold-based filtering; metadata documents reference library source and similarity metric used.
    run_tool("spectral_library_matching", list(...))
  }
  session$spherical_std_dev_of_normals <- function(...) {
    # Calculates spherical standard deviation of local surface normals.
    run_tool("spherical_std_dev_of_normals", list(...))
  }
  session$split_colour_composite <- function(...) {
    # Splits a packed RGB colour composite raster into three separate single-band rasters representing red, green, and blue channels. Algorithm: This tool extracts individual colour bands from a composite image where R, G, and B values are packed into a single raster (often using standard 24-bit RGB or 32-bit RGBA encoding). The separation is performed through bitwise operations to isolate each 8-bit channel component. Key features: Preserves original radiometric values (0–255), handles standard RGB composites and extended formats, outputs three independent georeferenced rasters. Use cases: Spectral analysis where individual bands must be processed separately; creating input datasets for vegetation indices (NDVI, EVI) calculations; preparing data for band algebra operations; enabling advanced color transformations like RGB-to-IHS conversion; extracting specific bands for supervised or unsupervised classification workflows. Applications: Remote sensing image analysis, satellite data preprocessing, multispectral analysis preparation, image enhancement pipelines. Output interpretation: Three single-band rasters are produced with identical spatial extent, projection, and georeference as the input composite. Each output band contains 8-bit radiometric values (0–255) representing the intensity of that colour component across the scene. Band statistics (min, max, mean) reflect the spectral characteristics of that colour channel; dominant values indicate colour dominance across the image. Output rasters are immediately suitable for band calculations, spectral indices, or further multi-band processing workflows.
    run_tool("split_colour_composite", list(...))
  }
  session$split_lidar <- function(...) {
    # Partitions points into separate files by attribute: groups by class, source-id, time window, spatial bin, or point count. Data stratification and distribution.
    run_tool("split_lidar", list(...))
  }
  session$split_lines_at_intersections <- function(...) {
    # Splits a line network wherever line segments intersect, including self-intersections.
    run_tool("split_lines_at_intersections", list(...))
  }
  session$split_vector_lines <- function(...) {
    # Splits each polyline feature into segments of a maximum specified length.
    run_tool("split_vector_lines", list(...))
  }
  session$split_with_lines <- function(...) {
    # Splits input polylines using intersection points from a split line layer.
    run_tool("split_with_lines", list(...))
  }
  session$sqrt <- function(...) {
    # Computes the square-root of each raster cell.
    run_tool("sqrt", list(...))
  }
  session$square <- function(...) {
    # Squares each raster cell value.
    run_tool("square", list(...))
  }
  session$standard_deviation_contrast_stretch <- function(...) {
    # Performs linear contrast stretch using mean plus/minus a standard deviation multiplier.
    run_tool("standard_deviation_contrast_stretch", list(...))
  }
  session$standard_deviation_filter <- function(...) {
    # Computes moving-window standard deviation, measuring local value variation/dispersion. High stdev = diverse values (rough/heterogeneous), low stdev = uniform values (smooth/homogeneous). Reveals texture, roughness, and variability patterns. Critical for uncertainty quantification and quality assessment.  Standard deviation is more robust than range for characterizing local variation (not biased by single outlier). Enables classification of areas by texture: steep slopes (high stdev), gentle slopes (low stdev); forests (high stdev), grasslands (low stdev). Often normalized (coefficient of variation = stdev/mean) to enable comparison across data with different value ranges. Can be computed from histogram (variance = mean_of_squares - square_of_mean).  Applications: (1) Texture mapping (roughness/heterogeneity analysis), (2) Uncertainty quantification in noisy data, (3) Quality assessment (uniform background = low stdev, feature-rich areas = high), (4) Classification confidence (high stdev = mixed/uncertain classes), (5) Multi-band heterogeneity (stack stdevs from each band). Typical workflow: compute stdev at multiple scales→compare pattern changes across scales→identify characteristic scales.
    run_tool("standard_deviation_filter", list(...))
  }
  session$standard_deviation_of_slope <- function(...) {
    # Calculates local standard deviation of slope as a terrain roughness metric.
    run_tool("standard_deviation_of_slope", list(...))
  }
  session$standard_deviation_overlay <- function(...) {
    # Computes the per-cell standard deviation across a raster stack, propagating NoData if any input cell is NoData.
    run_tool("standard_deviation_overlay", list(...))
  }
  session$stochastic_depression_analysis <- function(...) {
    # Runs Monte Carlo DEM perturbations and estimates depression-membership probability.
    run_tool("stochastic_depression_analysis", list(...))
  }
  session$strahler_order_basins <- function(...) {
    # Delineates watershed basins labelled by the Horton-Strahler order of their draining stream link.
    run_tool("strahler_order_basins", list(...))
  }
  session$strahler_stream_order <- function(...) {
    # Assigns Strahler stream order to stream cells.
    run_tool("strahler_stream_order", list(...))
  }
  session$stream_link_class <- function(...) {
    # Classifies stream links as interior, exterior, or source.
    run_tool("stream_link_class", list(...))
  }
  session$stream_link_identifier <- function(...) {
    # Assigns unique ID to each stream link.
    run_tool("stream_link_identifier", list(...))
  }
  session$stream_link_length <- function(...) {
    # Calculates total length for each stream link.
    run_tool("stream_link_length", list(...))
  }
  session$stream_link_slope <- function(...) {
    # Calculates average slope for each stream link.
    run_tool("stream_link_slope", list(...))
  }
  session$stream_slope_continuous <- function(...) {
    # Calculates slope value for each stream cell.
    run_tool("stream_slope_continuous", list(...))
  }
  session$subbasins <- function(...) {
    # Identifies the catchment area of each stream link (sub-basins) in a D8 stream network.
    run_tool("subbasins", list(...))
  }
  session$subtract <- function(...) {
    # Subtracts the second raster from the first on a cell-by-cell basis.
    run_tool("subtract", list(...))
  }
  session$sum_overlay <- function(...) {
    # Computes the per-cell sum across a raster stack, propagating NoData if any input cell is NoData.
    run_tool("sum_overlay", list(...))
  }
  session$surface_area_ratio <- function(...) {
    # 3D surface area / planimetric area ratio (Jenness method). >1.0=rough terrain, ≈1.0=flat. Dimensionless rugosity metric enabling cross-region terrain comparison.
    run_tool("surface_area_ratio", list(...))
  }
  session$svm_classification <- function(...) {
    # Support Vector Machine (SVM) Classification applies machine learning Support Vector Machine algorithms to multispectral remote sensing data, separating training classes through optimal hyperplane placement in high-dimensional spectral feature space. Algorithm: transforms spectral feature vectors into high-dimensional space via kernel functions (linear, RBF, polynomial), identifies maximum-margin hyperplane separating training classes, classifies new pixels according to hyperplane position; tolerance parameters and kernel selection control generalization. Handles nonlinear class separation effectively. Key features: robust to high-dimensional spectral data, excellent generalization with limited training samples, kernel flexibility accommodates diverse spectral distributions, provides probability/confidence estimates. Capabilities: multiclass classification, soft-margin tolerance, automatic class weight balancing. Use cases: detailed land classification with sparse training data, spectral-spatial feature integration, change detection, precision agriculture, urban mapping. Applications: hyperspectral image classification, complex ecosystem mapping, crop-type delineation, infrastructure classification. Output interpretation: class membership indicates predicted category with spatial coherence revealing classification quality; probability estimates quantify pixel-level confidence; misclassification patterns indicate training data deficiencies or spectral overlap problems.
    run_tool("svm_classification", list(...))
  }
  session$svm_regression <- function(...) {
    # Performs supervised support-vector-machine regression on multi-band input rasters.
    run_tool("svm_regression", list(...))
  }
  session$symmetrical_difference <- function(...) {
    # Computes non-overlapping polygon regions from input and overlay layers.
    run_tool("symmetrical_difference", list(...))
  }
  session$tan <- function(...) {
    # Computes the tangent of each raster cell value.
    run_tool("tan", list(...))
  }
  session$tangential_curvature <- function(...) {
    # Calculates tangential curvature (E-W direction component), similar to plan curvature but directional. Used for comprehensive curvature characterization capturing lateral flow divergence perpendicular to slope direction. Often combined with profile for full 3D curvature understanding.
    run_tool("tangential_curvature", list(...))
  }
  session$tanh <- function(...) {
    # Computes the hyperbolic tangent of each raster cell.
    run_tool("tanh", list(...))
  }
  session$terrain_corrected_optical_analytics <- function(...) {
    # Topographic C-correction of multispectral optical bands using a co-registered DEM. Outputs surface reflectance stack, correction factor, cloud/shadow mask, and quality confidence.
    run_tool("terrain_corrected_optical_analytics", list(...))
  }
  session$thicken_raster_line <- function(...) {
    # Thickens diagonal raster line segments to prevent diagonal leak-through.
    run_tool("thicken_raster_line", list(...))
  }
  session$time_in_daylight <- function(...) {
    # Calculates the proportion of daytime each cell is illuminated (not in terrain/object shadow).
    run_tool("time_in_daylight", list(...))
  }
  session$tin_interpolation <- function(...) {
    # Interpolates a raster from point samples using Delaunay triangulation and planar interpolation within each triangle.
    run_tool("tin_interpolation", list(...))
  }
  session$to_degrees <- function(...) {
    # Converts each raster cell from radians to degrees.
    run_tool("to_degrees", list(...))
  }
  session$to_radians <- function(...) {
    # Converts each raster cell from degrees to radians.
    run_tool("to_radians", list(...))
  }
  session$tophat_transform <- function(...) {
    # Performs a white or black morphological top-hat transform.
    run_tool("tophat_transform", list(...))
  }
  session$topo_render <- function(...) {
    # Creates a pseudo-3D topographic rendering using palette tinting, hillshade, shadows, and attenuation.
    run_tool("topo_render", list(...))
  }
  session$topographic_hachures <- function(...) {
    # Creates topographic hachure polylines from a DEM using contour-seeded downslope and upslope flowlines. Legacy authorship attribution is intentionally preserved for this tool.
    run_tool("topographic_hachures", list(...))
  }
  session$topographic_position_animation <- function(...) {
    # Creates an interactive HTML viewer and animated GIF of DEV or DEVmax across nonlinearly sampled scales.
    run_tool("topographic_position_animation", list(...))
  }
  session$topological_breach_burn <- function(...) {
    # Burns streams into a DEM, conditions the surface, and returns stream, DEM, pointer, and accumulation rasters.
    run_tool("topological_breach_burn", list(...))
  }
  session$topological_stream_order <- function(...) {
    # Assigns topological stream order based on link count.
    run_tool("topological_stream_order", list(...))
  }
  session$topology_rule_autofix <- function(...) {
    # Automatically applies safe, auditable fixes to topology violations detected by topology_rule_validate.
    run_tool("topology_rule_autofix", list(...))
  }
  session$topology_rule_validate <- function(...) {
    # Validates vector topology against rule-set checks (self-intersection, overlap, gaps, dangles, point coverage, endpoint snapping) and emits feature-level violations.
    run_tool("topology_rule_validate", list(...))
  }
  session$topology_validation_report <- function(...) {
    # Audits a vector layer for topology issues and writes a per-feature CSV report.
    run_tool("topology_validation_report", list(...))
  }
  session$total_curvature <- function(...) {
    # Calculates total curvature (quadratic mean of principal curvatures). Scalar metric independent of direction. High values indicate highly curved terrain (peaks, pits); low values indicate planar terrain. Useful as dimensionless roughness metric for terrain classification and anomaly detection.
    run_tool("total_curvature", list(...))
  }
  session$total_filter <- function(...) {
    # Computes moving-window sum (total) of pixel values in neighborhood. Integrates local signal strength. Applications depend on data semantics: for counts/densities, total reveals local density patterns; for precipitation, total reveals basin-scale accumulation; for reflectance, total is proportional to local target size.  Total filtering has different interpretations by domain. In count/population data, total reveals clustering and hotspots. In elevation data, total is rarely used (sum has no geomorphological meaning). In spectral analysis, total can reveal multi-band signal strength. Often used as intermediate step (e.g., divide by neighborhood cell count to compute mean, or compare with neighboring totals for local heterogeneity detection).  Applications: (1) Hotspot detection in count data (high total = clusters), (2) Basin/watershed accumulation models, (3) Integration of distributed measurements, (4) Intermediate calculation (total/N = mean), (5) Signal strength aggregation in multi-sensor mosaics.
    run_tool("total_filter", list(...))
  }
  session$trace_downslope_flowpaths <- function(...) {
    # Marks D8 flowpaths initiated from seed points until no-flow or grid edge.
    run_tool("trace_downslope_flowpaths", list(...))
  }
  session$transfer_attributes <- function(...) {
    # Transfers source attributes onto target features using a spatial predicate.
    run_tool("transfer_attributes", list(...))
  }
  session$travelling_salesman_problem <- function(...) {
    # Finds approximate solutions to the travelling salesman problem (TSP) using 2-opt heuristics. Given a set of point locations, identifies the shortest route connecting all points.
    run_tool("travelling_salesman_problem", list(...))
  }
  session$trend_surface <- function(...) {
    # Fits a polynomial trend surface to a raster using least-squares regression.
    run_tool("trend_surface", list(...))
  }
  session$trend_surface_vector_points <- function(...) {
    # Fits a polynomial trend surface to vector point data using least-squares regression.
    run_tool("trend_surface_vector_points", list(...))
  }
  session$tributary_identifier <- function(...) {
    # Assigns unique ID to each tributary.
    run_tool("tributary_identifier", list(...))
  }
  session$truncate <- function(...) {
    # Truncates each raster cell value to its integer part.
    run_tool("truncate", list(...))
  }
  session$turning_bands_simulation <- function(...) {
    # Creates a spatially-autocorrelated random field using the turning bands algorithm.
    run_tool("turning_bands_simulation", list(...))
  }
  session$two_sample_ks_test <- function(...) {
    # Performs a two-sample Kolmogorov-Smirnov test on two raster value distributions.
    run_tool("two_sample_ks_test", list(...))
  }
  session$union <- function(...) {
    # Dissolves combined input and overlay polygons into a unified polygon coverage.
    run_tool("union", list(...))
  }
  session$universal_kriging <- function(...) {
    # Performs universal kriging (kriging with a polynomial trend). Requires a pre-fitted variogram model (from fit_variogram). Use when spatial data has a systematic trend.
    run_tool("universal_kriging", list(...))
  }
  session$unnest_basins <- function(...) {
    # Creates one basin raster per pour-point nesting level from a D8 pointer grid.
    run_tool("unnest_basins", list(...))
  }
  session$unsharp_masking <- function(...) {
    # Unsharp masking performs image sharpening by subtracting a smoothed (low-pass) version from the original image, enhancing edges and fine details. The mathematical transformation is I_sharp = I_original + w·(I_original - I_smooth), where w is sharpening weight controlling enhancement strength. The process isolates high-frequency components and amplifies them, effectively separating detail from broad tonal variation. Key features include flexible parameter control (blur radius and weight enabling detail control), computational efficiency via Gaussian smoothing reuse, interpretable enhancement (weight=0 gives original; weight=1 gives true high-pass; weight>1 provides aggressive sharpening), and effectiveness on multispectral data. Unsharp masking excels in satellite image preparation for manual interpretation (enhances subtle terrain, vegetation, infrastructure), LiDAR-derived product enhancement (sharpens DEMs, vegetation metrics), orthophoto quality improvement for feature visibility, and archaeological/survey imagery enhancement. Output interpretation requires understanding that sharpened values concentrate on edges; homogeneous regions remain unchanged. Weight parameter controls enhancement magnitude: w=0.5-1.0 provides subtle enhancement; w=1.0-2.0 provides moderate sharpening; w>2.0 produces aggressive, potentially artifact-laden results. Blur radius controls feature scale: smaller radius (3-5 pixels) enhances fine texture; larger radius (10-20 pixels) enhances moderate features. Output values may exceed input range; clipping typically necessary. Artifacts include halos around strong edges (larger weight or radius = more pronounced), amplified noise if source is noisy, and potential false colors in multispectral sharpening. Verify enhancement via difference images. Apply selectively in visualization workflows; avoid before automated analysis that's sensitive to output range changes.
    run_tool("unsharp_masking", list(...))
  }
  session$unsphericity <- function(...) {
    # Calculates the unsphericity curvature (half the difference of principal curvatures) from a DEM.
    run_tool("unsphericity", list(...))
  }
  session$update <- function(...) {
    # Replaces input features with update features where they overlap; input features outside the update layer are preserved.
    run_tool("update", list(...))
  }
  session$update_nodata_cells <- function(...) {
    # Assigns NoData cells in input1 from corresponding valid cells in input2.
    run_tool("update_nodata_cells", list(...))
  }
  session$upslope_depression_storage <- function(...) {
    # Maps mean upslope depression-storage depth by routing depression depth over a conditioned DEM.
    run_tool("upslope_depression_storage", list(...))
  }
  session$user_defined_weights_filter <- function(...) {
    # The user-defined weights filter provides maximum flexibility for custom convolution analysis by accepting arbitrary weighted coefficients for neighborhood pixels, enabling implementation of specialized operators, domain-specific kernels, and research-grade algorithms without requiring tool modifications or specialized software. Users specify kernel dimensions (typically 3×3 or 5×5), assign floating-point weights to each position, and optionally designate edge-handling methods (reflection, wrapping, constant-fill). This filter applies the custom kernel across the entire raster through standard convolution mathematics: each output pixel equals the sum of weighted neighbors, enabling both traditional image processing filters and custom analytical kernels. Key features include complete customization for research applications, support for both enhancement and analysis operations, compatibility with normalized and unnormalized kernels, and preservation of floating-point precision throughout computation. Use cases span advanced spatial filtering for specialized spectral indices, implementation of experimental operators for algorithm validation, custom texture analysis kernels, weighted neighborhood aggregations for multi-criteria analysis, and standardized kernel application across diverse datasets. Applications include academic research prototyping, industry algorithm evaluation, regional customization of processing pipelines, and performance comparison studies. Output interpretation depends entirely on user-defined coefficients; different kernels produce fundamentally different results. Normalized kernels (sum of weights equals 1.0) preserve value ranges useful for smoothing; unnormalized kernels (typically summing to zero) emphasize differences useful for edge/derivative detection. Users must validate kernel properties—coefficient sign, magnitude, and sum—before production application. Documentation of kernel specifications is essential for reproducible workflows. Output value ranges depend on kernel design; documentation should specify expected output characteristics and scaling requirements.
    run_tool("user_defined_weights_filter", list(...))
  }
  session$vector_hex_binning <- function(...) {
    # Aggregates point features into hexagonal bins, counting points per hex cell.
    run_tool("vector_hex_binning", list(...))
  }
  session$vector_lines_to_raster <- function(...) {
    # Rasterizes line and polygon boundary geometries to a raster grid.
    run_tool("vector_lines_to_raster", list(...))
  }
  session$vector_points_to_raster <- function(...) {
    # Rasterizes point or multipoint vectors to a grid using a selected assignment operation.
    run_tool("vector_points_to_raster", list(...))
  }
  session$vector_polygons_to_raster <- function(...) {
    # Rasterizes polygon vectors to a grid, supporting attribute-driven burn values.
    run_tool("vector_polygons_to_raster", list(...))
  }
  session$vector_stream_network_analysis <- function(...) {
    # Comprehensive vector stream network analysis.
    run_tool("vector_stream_network_analysis", list(...))
  }
  session$vector_summary_statistics <- function(...) {
    # Computes count, sum, mean, min, max, and standard deviation by categorical group and exports to CSV.
    run_tool("vector_summary_statistics", list(...))
  }
  session$vehicle_routing_cvrp <- function(...) {
    # Builds capacity-constrained multi-depot delivery routes with heterogeneous fleet controls, objective modes, and optional local optimization.
    run_tool("vehicle_routing_cvrp", list(...))
  }
  session$vehicle_routing_pickup_delivery <- function(...) {
    # Builds paired pickup-delivery routes with precedence and capacity constraints using a deterministic nearest-neighbour baseline.
    run_tool("vehicle_routing_pickup_delivery", list(...))
  }
  session$vehicle_routing_vrptw <- function(...) {
    # Builds capacity-constrained multi-depot VRPTW routes with heterogeneous fleet settings, break windows, and objective-mode controls.
    run_tool("vehicle_routing_vrptw", list(...))
  }
  session$vertical_excess_curvature <- function(...) {
    # Calculates vertical excess curvature from a DEM.
    run_tool("vertical_excess_curvature", list(...))
  }
  session$viewshed <- function(...) {
    # Computes station visibility counts from point stations over a DEM.
    run_tool("viewshed", list(...))
  }
  session$visibility_index <- function(...) {
    # Calculates a topography-based visibility index from sampled viewsheds.
    run_tool("visibility_index", list(...))
  }
  session$voronoi_diagram <- function(...) {
    # Creates Voronoi (Thiessen) polygons from input point locations.
    run_tool("voronoi_diagram", list(...))
  }
  session$watershed <- function(...) {
    # Delineates watersheds from a D8 pointer and vector pour points.
    run_tool("watershed", list(...))
  }
  session$watershed_from_raster_pour_points <- function(...) {
    # Delineates watersheds from a D8 pointer and a raster of pour-point outlet IDs.
    run_tool("watershed_from_raster_pour_points", list(...))
  }
  session$weighted_overlay <- function(...) {
    # Combines factor rasters using normalized weights, optional cost flags, and optional binary constraints.
    run_tool("weighted_overlay", list(...))
  }
  session$weighted_sum <- function(...) {
    # Computes a weighted sum across a raster stack after normalizing weights to sum to one.
    run_tool("weighted_sum", list(...))
  }
  session$wetness_index <- function(...) {
    # Calculates the topographic wetness index ln(SCA / tan(slope)).
    run_tool("wetness_index", list(...))
  }
  session$wiener_filter <- function(...) {
    # The Wiener filter performs adaptive noise reduction by minimizing mean-squared error between filtered output and true signal, assuming knowledge of signal and noise statistical properties. Implementation estimates local signal and noise variances within moving windows, computing filter coefficients that balance noise suppression against detail preservation: F = μ + (σ² - σₙ²)/σ² · (I - μ), where μ is local mean, σ² is signal variance, σₙ² is noise variance. This data-driven adaptation ensures filtering strength responds to local image characteristics. Key features include automatic adaptation to local statistics (flat regions smooth aggressively; detailed regions preserve structure), proven effectiveness on optical and SAR imagery, interpretable parameters based on noise model assumptions, and computational feasibility via separable approximations. Wiener filtering excels in satellite image preprocessing where noise varies spatially, SAR speckle reduction while preserving point targets, despeckled multispectral data for vegetation mapping, and radar-optical fusion denoising. Output interpretation shows that high-variance (detailed) regions filter minimally, while low-variance (noisy) regions filter aggressively. Noise variance estimation affects output: underestimated noise variance yields under-smoothing; overestimated variance causes over-smoothing and detail loss. Output ranges approach input ranges; examine difference images (original - filtered) to verify noise reduction. Peak Signal-to-Noise Ratio (PSNR) and Structural Similarity Index (SSIM) quantify filtering effectiveness. Local variance thresholds indicate processing impact: regions with detected variance ratio > 5 filter substantially; ratios < 1 filter minimally. Common pitfalls include inaccurate noise variance estimation (conduct dark-frame or homogeneous-region analysis for estimation) and window-size selection affecting localization. Apply before classification or feature extraction to reduce noise-driven category misclassification.
    run_tool("wiener_filter", list(...))
  }
  session$wilcoxon_signed_rank_test <- function(...) {
    # Performs a Wilcoxon signed-rank test on paired raster differences.
    run_tool("wilcoxon_signed_rank_test", list(...))
  }
  session$wisart_iterative_clustering <- function(...) {
    # Wishart iterative clustering performs unsupervised classification of SAR polarimetric data by iteratively refining cluster centers using the complex Wishart statistical distance metric, which measures similarity in multivariate polarimetric probability distributions. The algorithm initializes from H/α decomposition zones (providing 9 seed clusters with known physical interpretation), then enters an expectation-maximization-like loop: (1) compute Wishart distance from each pixel's estimated coherency matrix to each cluster prototype; (2) reassign pixels to closest cluster; (3) update cluster prototypes by averaging assigned pixel matrices; (4) iterate until convergence (pixel reassignment rate <convergence_threshold) or max_iterations reached. Key features include complex-valued statistical framework properly handling polarimetric data structure unlike Euclidean distance; automatic initialization from interpretable H/α zones reducing dependency on random seeds; per-pixel convergence monitoring enabling adaptive iteration targeting; optional input of pre-computed (H,α) or automatic matrix computation from raw coherency inputs; and built-in robustness to single-look speckle through multi-look processing compatibility. The tool supports both conventional and compact matrix formats. Primary use cases encompass SAR polarimetric image classification producing refined land cover maps beyond H/α 9-zone partition, iterative refinement of initial unsupervised classification for cartography, automated polarimetric data quality assessment through cluster stability metrics, and time-series SAR classification enabling temporal change detection via cluster transition analysis. Output interpretation: Refined cluster map (typically 3-9 classes depending on convergence) showing well-separated scattering mechanism groups. Convergence history provides confidence metric—rapid early convergence indicates stable class separation; slow convergence suggests ambiguous pixels benefiting from multi-view or change detection analysis. Integration with H/α zones enables legend development: maintain H/α zone correspondence where possible to preserve interpretability.
    run_tool("wisart_iterative_clustering", list(...))
  }
  session$write_function_memory_insertion <- function(...) {
    # Creates a packed RGB change-visualization composite from two or three single-band dates.
    run_tool("write_function_memory_insertion", list(...))
  }
  session$yamaguchi_4component_decomposition <- function(...) {
    # Yamaguchi 4-component SAR decomposition decomposes dual-polarization synthetic aperture radar data into physically interpretable components representing surface scattering, double-bounce (volume) scattering, helix scattering, and volume scattering using model-based polarimetric analysis with optional DEM incorporation. The decomposition separates different backscattering mechanisms through eigenvalue analysis of polarimetric covariance matrices, interpreting components as surface reflection (Bragg scattering), double-bounce reflection from corner reflectors, helical polarization rotation (uncommon), and diffuse volume scattering from vegetation or rough surface. Incorporation of external DEM estimates topographic scattering contribution enabling improved discrimination of true volume scattering from topographic effects. Key features include model-based physical interpretation enabling meaningful geophysical parameter extraction, optional DEM-based topographic correction improving component accuracy over terrain, non-negative component constraints preventing unphysical decomposition results, and automatic handling of data gaps and layover regions. Applications include forest biomass estimation from volume scattering component, urban mapping exploiting double-bounce dominance in built areas, soil moisture estimation from surface scattering behavior, and landslide/change detection through component ratio changes. Yamaguchi decomposition output enables geophysical interpretation. Output comprises four-component imagery (surface, double-bounce, helix, volume scattering power), decomposition quality metrics quantifying fit accuracy, mean scattering type indices facilitating land cover characterization, and optional coherency/entropy diagnostics guiding data quality assessment.
    run_tool("yamaguchi_4component_decomposition", list(...))
  }
  session$z_scores <- function(...) {
    # Standardizes raster values to z-scores using global mean and standard deviation.
    run_tool("z_scores", list(...))
  }
  session$zonal_statistics <- function(...) {
    # Summarises the values of a data raster within zones defined by a feature raster.
    run_tool("zonal_statistics", list(...))
  }

  session
}

wbw_run_tool <- function(tool_id, args = list()) {
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$run_tool(tool_id, args)
}

abs <- function(...) {
  # Calculates the absolute value of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$abs(...)
}

wbw_abs <- function(...) {
  # Calculates the absolute value of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$abs(...)
}

accumulation_curvature <- function(...) {
  # Calculates accumulation curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$accumulation_curvature(...)
}

wbw_accumulation_curvature <- function(...) {
  # Calculates accumulation curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$accumulation_curvature(...)
}

adaptive_filter <- function(...) {
  # The Adaptive Filter adjusts filtering strength dynamically based on local image statistics (mean, variance, kurtosis), enabling context-aware smoothing that responds to scene characteristics. Implementation partitions images into moving windows, computes local statistics (detecting noise-dominated versus feature-dominated regions), and selects filter parameters accordingly. Flat regions smooth aggressively; complex regions filter gently. Mathematical basis uses statistical tests to identify local character: regions with variance below threshold smooth heavily; regions exceeding threshold preserve detail. Key features include automatic parameter adaptation (user specifies ranges; algorithm selects locally), applicability to any filter kernel (Gaussian, median, morphological), and effectiveness on optical and radar imagery. Adaptive filtering excels in preprocessing heterogeneous satellite mosaics (different sensors, acquisition conditions), LiDAR point-cloud smoothing (preserves vegetation edges in forests; smooths ground in open areas), selective SAR speckle reduction respecting both targets and background, and multi-temporal image stacking. Output interpretation reveals that homogeneous regions undergo intensive filtering (low local variance → strong smoothing); complex regions filter conservatively (high variance → minimal processing). Smoothing radius dynamically adjusts per-region: flat areas receive large-radius filtering; textured areas receive small-radius or no filtering. Output ranges remain within input; examine spatial filtering-strength map to validate adaptation. Statistics shift toward local means in smooth regions; complex regions remain largely unchanged. Common artifacts include potential over-smoothing at region boundaries (smooth transition typically applied) and sensitivity to noise-variance relationships. Verify adaptation by analyzing local variance maps. Apply in automated preprocessing pipelines handling multi-source data where uniform filtering insufficient.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$adaptive_filter(...)
}

wbw_adaptive_filter <- function(...) {
  # The Adaptive Filter adjusts filtering strength dynamically based on local image statistics (mean, variance, kurtosis), enabling context-aware smoothing that responds to scene characteristics. Implementation partitions images into moving windows, computes local statistics (detecting noise-dominated versus feature-dominated regions), and selects filter parameters accordingly. Flat regions smooth aggressively; complex regions filter gently. Mathematical basis uses statistical tests to identify local character: regions with variance below threshold smooth heavily; regions exceeding threshold preserve detail. Key features include automatic parameter adaptation (user specifies ranges; algorithm selects locally), applicability to any filter kernel (Gaussian, median, morphological), and effectiveness on optical and radar imagery. Adaptive filtering excels in preprocessing heterogeneous satellite mosaics (different sensors, acquisition conditions), LiDAR point-cloud smoothing (preserves vegetation edges in forests; smooths ground in open areas), selective SAR speckle reduction respecting both targets and background, and multi-temporal image stacking. Output interpretation reveals that homogeneous regions undergo intensive filtering (low local variance → strong smoothing); complex regions filter conservatively (high variance → minimal processing). Smoothing radius dynamically adjusts per-region: flat areas receive large-radius filtering; textured areas receive small-radius or no filtering. Output ranges remain within input; examine spatial filtering-strength map to validate adaptation. Statistics shift toward local means in smooth regions; complex regions remain largely unchanged. Common artifacts include potential over-smoothing at region boundaries (smooth transition typically applied) and sensitivity to noise-variance relationships. Verify adaptation by analyzing local variance maps. Apply in automated preprocessing pipelines handling multi-source data where uniform filtering insufficient.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$adaptive_filter(...)
}

add <- function(...) {
  # Adds two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$add(...)
}

wbw_add <- function(...) {
  # Adds two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$add(...)
}

add_field <- function(...) {
  # Adds a new attribute field with an optional default value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$add_field(...)
}

wbw_add_field <- function(...) {
  # Adds a new attribute field with an optional default value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$add_field(...)
}

add_geometry_attributes <- function(...) {
  # Automatically calculates geometric properties (area, length, perimeter, centroid) and adds them as new fields, supporting both planar and geodesic measurements.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$add_geometry_attributes(...)
}

wbw_add_geometry_attributes <- function(...) {
  # Automatically calculates geometric properties (area, length, perimeter, centroid) and adds them as new fields, supporting both planar and geodesic measurements.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$add_geometry_attributes(...)
}

add_point_coordinates_to_table <- function(...) {
  # Copies a point layer and appends XCOORD and YCOORD attribute fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$add_point_coordinates_to_table(...)
}

wbw_add_point_coordinates_to_table <- function(...) {
  # Copies a point layer and appends XCOORD and YCOORD attribute fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$add_point_coordinates_to_table(...)
}

aggregate_raster <- function(...) {
  # Reduces raster resolution by aggregating blocks using mean, sum, min, max, or range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$aggregate_raster(...)
}

wbw_aggregate_raster <- function(...) {
  # Reduces raster resolution by aggregating blocks using mean, sum, min, max, or range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$aggregate_raster(...)
}

anisotropic_diffusion_filter <- function(...) {
  # Anisotropic diffusion filtering implements iterative edge-preserving smoothing via directional diffusion processes that distinguish between edges and flat regions. The algorithm iteratively updates each pixel based on weighted differences with neighbors, using a conductance function that reduces diffusion across high-gradient boundaries while permitting smoothing within homogeneous regions. Implementation solves the partial differential equation ∂I/∂t = div(c(|∇I|)∇I), where conductance c(·) adapts to local gradient magnitude. This data-driven approach preserves sharp transitions while progressively reducing noise in uniform areas. Key features include true edge preservation without explicit edge masks, automatic scale selection via iteration count, effective noise reduction maintaining feature sharpness, and applicability to single and multispectral data. Anisotropic diffusion excels in LiDAR point cloud smoothing preserving terrain breaks, satellite image denoising for subtle geological feature detection, SAR speckle reduction maintaining radar-target edges, and medical/scientific imagery where edge fidelity is critical. Output interpretation requires understanding that smooth regions progressively homogenize (values converge toward local mean), while edges steepen until stabilizing. Early iterations (t<5) yield mild noise reduction; intermediate iterations (t=5-20) provide substantial smoothing; excessive iterations (t>50) risk boundary over-enhancement or false features. Output values remain in source data ranges; statistics shift toward regional means as processing proceeds. Monitor output variance to assess smoothing completeness. Common metrics include signal-to-noise ratio improvement and edge sharpness indices. Apply carefully in multi-scale workflows where edge preservation precision directly impacts downstream classification or change detection accuracy.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$anisotropic_diffusion_filter(...)
}

wbw_anisotropic_diffusion_filter <- function(...) {
  # Anisotropic diffusion filtering implements iterative edge-preserving smoothing via directional diffusion processes that distinguish between edges and flat regions. The algorithm iteratively updates each pixel based on weighted differences with neighbors, using a conductance function that reduces diffusion across high-gradient boundaries while permitting smoothing within homogeneous regions. Implementation solves the partial differential equation ∂I/∂t = div(c(|∇I|)∇I), where conductance c(·) adapts to local gradient magnitude. This data-driven approach preserves sharp transitions while progressively reducing noise in uniform areas. Key features include true edge preservation without explicit edge masks, automatic scale selection via iteration count, effective noise reduction maintaining feature sharpness, and applicability to single and multispectral data. Anisotropic diffusion excels in LiDAR point cloud smoothing preserving terrain breaks, satellite image denoising for subtle geological feature detection, SAR speckle reduction maintaining radar-target edges, and medical/scientific imagery where edge fidelity is critical. Output interpretation requires understanding that smooth regions progressively homogenize (values converge toward local mean), while edges steepen until stabilizing. Early iterations (t<5) yield mild noise reduction; intermediate iterations (t=5-20) provide substantial smoothing; excessive iterations (t>50) risk boundary over-enhancement or false features. Output values remain in source data ranges; statistics shift toward regional means as processing proceeds. Monitor output variance to assess smoothing completeness. Common metrics include signal-to-noise ratio improvement and edge sharpness indices. Apply carefully in multi-scale workflows where edge preservation precision directly impacts downstream classification or change detection accuracy.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$anisotropic_diffusion_filter(...)
}

anova <- function(...) {
  # Performs one-way ANOVA on raster values grouped by class raster categories.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$anova(...)
}

wbw_anova <- function(...) {
  # Performs one-way ANOVA on raster values grouped by class raster categories.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$anova(...)
}

arccos <- function(...) {
  # Computes the inverse cosine (arccos) of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arccos(...)
}

wbw_arccos <- function(...) {
  # Computes the inverse cosine (arccos) of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arccos(...)
}

arcosh <- function(...) {
  # Computes the inverse hyperbolic cosine of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arcosh(...)
}

wbw_arcosh <- function(...) {
  # Computes the inverse hyperbolic cosine of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arcosh(...)
}

arcsin <- function(...) {
  # Computes the inverse sine (arcsin) of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arcsin(...)
}

wbw_arcsin <- function(...) {
  # Computes the inverse sine (arcsin) of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arcsin(...)
}

arctan <- function(...) {
  # Computes the inverse tangent (arctan) of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arctan(...)
}

wbw_arctan <- function(...) {
  # Computes the inverse tangent (arctan) of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arctan(...)
}

arsinh <- function(...) {
  # Computes the inverse hyperbolic sine of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arsinh(...)
}

wbw_arsinh <- function(...) {
  # Computes the inverse hyperbolic sine of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$arsinh(...)
}

artanh <- function(...) {
  # Computes the inverse hyperbolic tangent of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$artanh(...)
}

wbw_artanh <- function(...) {
  # Computes the inverse hyperbolic tangent of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$artanh(...)
}

ascii_to_las <- function(...) {
  # Format conversion: CSV→LAS batch processing. Parses space/comma/tab-delimited text files (x,y,z,intensity,class,returns,angle,time) to LAS with EPSG metadata.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ascii_to_las(...)
}

wbw_ascii_to_las <- function(...) {
  # Format conversion: CSV→LAS batch processing. Parses space/comma/tab-delimited text files (x,y,z,intensity,class,returns,angle,time) to LAS with EPSG metadata.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ascii_to_las(...)
}

aspect <- function(...) {
  # Direction of maximum slope (0°=N, 90°=E, 180°=S, 270°=W). Critical for solar radiation, vegetation patterns, microclimate, and exposure analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$aspect(...)
}

wbw_aspect <- function(...) {
  # Direction of maximum slope (0°=N, 90°=E, 180°=S, 270°=W). Critical for solar radiation, vegetation patterns, microclimate, and exposure analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$aspect(...)
}

assess_route <- function(...) {
  # Segments route lines and evaluates per-segment terrain metrics from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$assess_route(...)
}

wbw_assess_route <- function(...) {
  # Segments route lines and evaluates per-segment terrain metrics from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$assess_route(...)
}

atan2 <- function(...) {
  # Computes the four-quadrant inverse tangent using two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$atan2(...)
}

wbw_atan2 <- function(...) {
  # Computes the four-quadrant inverse tangent using two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$atan2(...)
}

attribute_correlation <- function(...) {
  # Performs Pearson correlation analysis on numeric vector attribute fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$attribute_correlation(...)
}

wbw_attribute_correlation <- function(...) {
  # Performs Pearson correlation analysis on numeric vector attribute fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$attribute_correlation(...)
}

attribute_histogram <- function(...) {
  # Creates a histogram for numeric field values in a vector attribute table.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$attribute_histogram(...)
}

wbw_attribute_histogram <- function(...) {
  # Creates a histogram for numeric field values in a vector attribute table.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$attribute_histogram(...)
}

attribute_scattergram <- function(...) {
  # Computes scatterplot summary statistics between two numeric vector fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$attribute_scattergram(...)
}

wbw_attribute_scattergram <- function(...) {
  # Computes scatterplot summary statistics between two numeric vector fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$attribute_scattergram(...)
}

average_flowpath_slope <- function(...) {
  # Calculates average slope gradient of flowpaths passing through each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_flowpath_slope(...)
}

wbw_average_flowpath_slope <- function(...) {
  # Calculates average slope gradient of flowpaths passing through each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_flowpath_slope(...)
}

average_horizon_distance <- function(...) {
  # Calculates average distance to horizon across azimuth directions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_horizon_distance(...)
}

wbw_average_horizon_distance <- function(...) {
  # Calculates average distance to horizon across azimuth directions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_horizon_distance(...)
}

average_normal_vector_angular_deviation <- function(...) {
  # Calculates local mean angular deviation between original and smoothed surface normals.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_normal_vector_angular_deviation(...)
}

wbw_average_normal_vector_angular_deviation <- function(...) {
  # Calculates local mean angular deviation between original and smoothed surface normals.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_normal_vector_angular_deviation(...)
}

average_overlay <- function(...) {
  # Computes the per-cell average across a raster stack, ignoring NoData unless all inputs are NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_overlay(...)
}

wbw_average_overlay <- function(...) {
  # Computes the per-cell average across a raster stack, ignoring NoData unless all inputs are NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_overlay(...)
}

average_upslope_flowpath_length <- function(...) {
  # Computes the average upslope flowpath length passing through each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_upslope_flowpath_length(...)
}

wbw_average_upslope_flowpath_length <- function(...) {
  # Computes the average upslope flowpath length passing through each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$average_upslope_flowpath_length(...)
}

balance_contrast_enhancement <- function(...) {
  # Reduces colour bias in a packed RGB image using per-channel parabolic stretches.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$balance_contrast_enhancement(...)
}

wbw_balance_contrast_enhancement <- function(...) {
  # Reduces colour bias in a packed RGB image using per-channel parabolic stretches.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$balance_contrast_enhancement(...)
}

basins <- function(...) {
  # Delineates all D8 drainage basins that drain to valid-data edges.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$basins(...)
}

wbw_basins <- function(...) {
  # Delineates all D8 drainage basins that drain to valid-data edges.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$basins(...)
}

bilateral_filter <- function(...) {
  # Edge-preserving bilateral smoothing via spatial + intensity kernels. Superior to Gaussian for detail preservation. Sigma_dist=radius, sigma_int=edge-preservation threshold. RGB-aware.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bilateral_filter(...)
}

wbw_bilateral_filter <- function(...) {
  # Edge-preserving bilateral smoothing via spatial + intensity kernels. Superior to Gaussian for detail preservation. Sigma_dist=radius, sigma_int=edge-preservation threshold. RGB-aware.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bilateral_filter(...)
}

block_maximum <- function(...) {
  # Rasterizes point features by assigning the maximum value observed within each output cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$block_maximum(...)
}

wbw_block_maximum <- function(...) {
  # Rasterizes point features by assigning the maximum value observed within each output cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$block_maximum(...)
}

block_minimum <- function(...) {
  # Rasterizes point features by assigning the minimum value observed within each output cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$block_minimum(...)
}

wbw_block_minimum <- function(...) {
  # Rasterizes point features by assigning the minimum value observed within each output cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$block_minimum(...)
}

bool_and <- function(...) {
  # Computes a logical AND of two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bool_and(...)
}

wbw_bool_and <- function(...) {
  # Computes a logical AND of two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bool_and(...)
}

bool_not <- function(...) {
  # Computes a logical NOT of each raster cell, outputting 1 for zero-valued cells and 0 otherwise.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bool_not(...)
}

wbw_bool_not <- function(...) {
  # Computes a logical NOT of each raster cell, outputting 1 for zero-valued cells and 0 otherwise.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bool_not(...)
}

bool_or <- function(...) {
  # Computes a logical OR of two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bool_or(...)
}

wbw_bool_or <- function(...) {
  # Computes a logical OR of two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bool_or(...)
}

bool_xor <- function(...) {
  # Computes a logical XOR of two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bool_xor(...)
}

wbw_bool_xor <- function(...) {
  # Computes a logical XOR of two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$bool_xor(...)
}

boundary_shape_complexity <- function(...) {
  # Calculates raster patch boundary-shape complexity using a line-thinned skeleton branch metric.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$boundary_shape_complexity(...)
}

wbw_boundary_shape_complexity <- function(...) {
  # Calculates raster patch boundary-shape complexity using a line-thinned skeleton branch metric.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$boundary_shape_complexity(...)
}

brdf_normalization <- function(...) {
  # Single-scene BRDF normalization using C-correction or Minnaert approach with DEM slope/aspect geometry.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$brdf_normalization(...)
}

wbw_brdf_normalization <- function(...) {
  # Single-scene BRDF normalization using C-correction or Minnaert approach with DEM slope/aspect geometry.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$brdf_normalization(...)
}

breach_depressions_least_cost <- function(...) {
  # Breaches depressions in a DEM using a constrained least-cost pathway search.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$breach_depressions_least_cost(...)
}

wbw_breach_depressions_least_cost <- function(...) {
  # Breaches depressions in a DEM using a constrained least-cost pathway search.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$breach_depressions_least_cost(...)
}

breach_single_cell_pits <- function(...) {
  # Breaches single-cell pits in a DEM by carving one-cell channels.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$breach_single_cell_pits(...)
}

wbw_breach_single_cell_pits <- function(...) {
  # Breaches single-cell pits in a DEM by carving one-cell channels.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$breach_single_cell_pits(...)
}

breakline_mapping <- function(...) {
  # Maps breaklines by thresholding log-transformed curvedness and vectorizing thinned linear features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$breakline_mapping(...)
}

wbw_breakline_mapping <- function(...) {
  # Maps breaklines by thresholding log-transformed curvedness and vectorizing thinned linear features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$breakline_mapping(...)
}

buffer_raster <- function(...) {
  # Creates a binary buffer zone around non-zero, non-NoData raster cells within a specified distance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$buffer_raster(...)
}

wbw_buffer_raster <- function(...) {
  # Creates a binary buffer zone around non-zero, non-NoData raster cells within a specified distance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$buffer_raster(...)
}

buffer_vector <- function(...) {
  # Extends geometries by a specified distance, creating polygon buffers with customizable cap/join styles. Optional dissolve merges overlapping buffers into unified polygons.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$buffer_vector(...)
}

wbw_buffer_vector <- function(...) {
  # Extends geometries by a specified distance, creating polygon buffers with customizable cap/join styles. Optional dissolve merges overlapping buffers into unified polygons.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$buffer_vector(...)
}

build_network_topology <- function(...) {
  # Builds a noded topological line network with stable edge and node outputs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$build_network_topology(...)
}

wbw_build_network_topology <- function(...) {
  # Builds a noded topological line network with stable edge and node outputs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$build_network_topology(...)
}

build_object_hierarchy_multiscale <- function(...) {
  # Hierarchical object network constructed through iterative aggregation across multiple segmentation scales, progressively merging finer segments based on spectral similarity and spatial adjacency. Builds tree structure where leaf nodes represent fine-scale segments and root represents entire image. Containment relationships encode parent-child (part-whole) object hierarchies enabling multi-resolution analysis and scale-adaptive object queries across hierarchy levels. Key Features: Multiscale segmentation hierarchy; tracks part-whole relationships; supports nested object queries; enables scale-adaptive analysis; memory-efficient hierarchical representation; facilitates cascaded classification. Use Cases: Hierarchical landcover mapping; building complex extraction from components; agricultural field detection; vegetation strata analysis; urban district delineation; wetland mapping with subcomponent classification. Output Interpretation: Output is hierarchical object database encoding scale-dependent structure. Query objects at specific scales; intermediate scales reveal transitional object scales balancing detail/generalization. Parent-child relationships reveal compositional structure. Scale-level statistical distributions characterize object size/shape properties at each hierarchy level, enabling scale-optimal classification strategy selection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$build_object_hierarchy_multiscale(...)
}

wbw_build_object_hierarchy_multiscale <- function(...) {
  # Hierarchical object network constructed through iterative aggregation across multiple segmentation scales, progressively merging finer segments based on spectral similarity and spatial adjacency. Builds tree structure where leaf nodes represent fine-scale segments and root represents entire image. Containment relationships encode parent-child (part-whole) object hierarchies enabling multi-resolution analysis and scale-adaptive object queries across hierarchy levels. Key Features: Multiscale segmentation hierarchy; tracks part-whole relationships; supports nested object queries; enables scale-adaptive analysis; memory-efficient hierarchical representation; facilitates cascaded classification. Use Cases: Hierarchical landcover mapping; building complex extraction from components; agricultural field detection; vegetation strata analysis; urban district delineation; wetland mapping with subcomponent classification. Output Interpretation: Output is hierarchical object database encoding scale-dependent structure. Query objects at specific scales; intermediate scales reveal transitional object scales balancing detail/generalization. Parent-child relationships reveal compositional structure. Scale-level statistical distributions characterize object size/shape properties at each hierarchy level, enabling scale-optimal classification strategy selection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$build_object_hierarchy_multiscale(...)
}

burn_streams <- function(...) {
  # Burns a stream network into a DEM by decreasing stream-cell elevations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$burn_streams(...)
}

wbw_burn_streams <- function(...) {
  # Burns a stream network into a DEM by decreasing stream-cell elevations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$burn_streams(...)
}

burn_streams_at_roads <- function(...) {
  # Lowers stream elevations near stream-road crossings to breach road embankments in a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$burn_streams_at_roads(...)
}

wbw_burn_streams_at_roads <- function(...) {
  # Lowers stream elevations near stream-road crossings to breach road embankments in a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$burn_streams_at_roads(...)
}

canny_edge_detection <- function(...) {
  # Applies Canny multi-stage edge detection (Gaussian blur → Sobel gradient → non-maximum suppression → double threshold → hysteresis).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$canny_edge_detection(...)
}

wbw_canny_edge_detection <- function(...) {
  # Applies Canny multi-stage edge detection (Gaussian blur → Sobel gradient → non-maximum suppression → double threshold → hysteresis).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$canny_edge_detection(...)
}

casorati_curvature <- function(...) {
  # Calculates Casorati curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$casorati_curvature(...)
}

wbw_casorati_curvature <- function(...) {
  # Calculates Casorati curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$casorati_curvature(...)
}

ceil <- function(...) {
  # Rounds each raster cell upward to the nearest integer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ceil(...)
}

wbw_ceil <- function(...) {
  # Rounds each raster cell upward to the nearest integer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ceil(...)
}

centroid_raster <- function(...) {
  # Calculates the centroid cell for each positive-valued patch ID in a raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$centroid_raster(...)
}

wbw_centroid_raster <- function(...) {
  # Calculates the centroid cell for each positive-valued patch ID in a raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$centroid_raster(...)
}

centroid_vector <- function(...) {
  # Computes the geographic center (mean coordinate of mass) for each vector feature, producing a point layer for label placement, clustering, and spatial analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$centroid_vector(...)
}

wbw_centroid_vector <- function(...) {
  # Computes the geographic center (mean coordinate of mass) for each vector feature, producing a point layer for label placement, clustering, and spatial analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$centroid_vector(...)
}

change_vector_analysis <- function(...) {
  # Performs change vector analysis on two-date multispectral datasets and returns magnitude and direction rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$change_vector_analysis(...)
}

wbw_change_vector_analysis <- function(...) {
  # Performs change vector analysis on two-date multispectral datasets and returns magnitude and direction rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$change_vector_analysis(...)
}

circular_variance_of_aspect <- function(...) {
  # Calculates local circular variance of aspect within a moving neighbourhood.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$circular_variance_of_aspect(...)
}

wbw_circular_variance_of_aspect <- function(...) {
  # Calculates local circular variance of aspect within a moving neighbourhood.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$circular_variance_of_aspect(...)
}

classify_buildings_in_lidar <- function(...) {
  # Marks points inside building footprints: assigns class 6 to all points spatially within polygon boundaries. Vector-based building extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_buildings_in_lidar(...)
}

wbw_classify_buildings_in_lidar <- function(...) {
  # Marks points inside building footprints: assigns class 6 to all points spatially within polygon boundaries. Vector-based building extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_buildings_in_lidar(...)
}

classify_lidar <- function(...) {
  # Automated point classification: ground, vegetation, buildings via local geometry (linearity, planarity) and RANSAC plane fitting. Geometry-based segmentation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_lidar(...)
}

wbw_classify_lidar <- function(...) {
  # Automated point classification: ground, vegetation, buildings via local geometry (linearity, planarity) and RANSAC plane fitting. Geometry-based segmentation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_lidar(...)
}

classify_objects_ensemble_pro <- function(...) {
  # Runs an ensemble-style object classification configuration tuned for higher stability across heterogeneous scenes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_ensemble_pro(...)
}

wbw_classify_objects_ensemble_pro <- function(...) {
  # Runs an ensemble-style object classification configuration tuned for higher stability across heterogeneous scenes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_ensemble_pro(...)
}

classify_objects_random_forest <- function(...) {
  # Trains ensemble Random Forest classifier on labeled segment training samples using spectral, morphological, and texture features as predictors. Constructs multiple decision trees through bootstrap sampling and feature randomization, then aggregates predictions through majority voting. Classification operates on per-segment feature vectors, assigning object class labels probabilistically based on ensemble consensus, enabling robust multi-class object categorization from OBIA features. Key features include ensemble learning combining multiple decision trees for robust classification, handling high-dimensional feature spaces typical of multispectral OBIA, classification confidence and probability estimates, feature importance ranking identifying discriminative properties, natural handling of non-linear feature interactions, and robustness to feature noise and redundancy. Use cases span multi-class land-cover classification from OBIA segments (urban, agricultural, forest, water), object-level supervised classification refined through training sample selection, change detection classification across temporal segmentation sequences, hierarchical classification (coarse habitat types refined to fine categories), and integration with manual training samples from visual interpretation. Output predicted class label identifies primary object type; confidence probability indicates classification certainty; low confidence suggests ambiguous intermediate objects; feature importance identifies which spectral/morphological properties drive classification decisions; classification map directly represents object type distribution; confusion between similar classes informs training refinement; probabilistic output enables uncertainty quantification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_random_forest(...)
}

wbw_classify_objects_random_forest <- function(...) {
  # Trains ensemble Random Forest classifier on labeled segment training samples using spectral, morphological, and texture features as predictors. Constructs multiple decision trees through bootstrap sampling and feature randomization, then aggregates predictions through majority voting. Classification operates on per-segment feature vectors, assigning object class labels probabilistically based on ensemble consensus, enabling robust multi-class object categorization from OBIA features. Key features include ensemble learning combining multiple decision trees for robust classification, handling high-dimensional feature spaces typical of multispectral OBIA, classification confidence and probability estimates, feature importance ranking identifying discriminative properties, natural handling of non-linear feature interactions, and robustness to feature noise and redundancy. Use cases span multi-class land-cover classification from OBIA segments (urban, agricultural, forest, water), object-level supervised classification refined through training sample selection, change detection classification across temporal segmentation sequences, hierarchical classification (coarse habitat types refined to fine categories), and integration with manual training samples from visual interpretation. Output predicted class label identifies primary object type; confidence probability indicates classification certainty; low confidence suggests ambiguous intermediate objects; feature importance identifies which spectral/morphological properties drive classification decisions; classification map directly represents object type distribution; confusion between similar classes informs training refinement; probabilistic output enables uncertainty quantification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_random_forest(...)
}

classify_objects_rules_basic <- function(...) {
  # Applies transparent rule-based object classification from feature-operator-threshold rules CSV. Fully interpretable decision logic for domain expert workflows and regulatory compliance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_rules_basic(...)
}

wbw_classify_objects_rules_basic <- function(...) {
  # Applies transparent rule-based object classification from feature-operator-threshold rules CSV. Fully interpretable decision logic for domain expert workflows and regulatory compliance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_rules_basic(...)
}

classify_objects_rules_hierarchical <- function(...) {
  # Applies hierarchical rule-based object classification; currently uses ordered rules with deterministic fallback.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_rules_hierarchical(...)
}

wbw_classify_objects_rules_hierarchical <- function(...) {
  # Applies hierarchical rule-based object classification; currently uses ordered rules with deterministic fallback.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_rules_hierarchical(...)
}

classify_objects_svm <- function(...) {
  # Classifies objects using an SVM-style workflow (implemented via robust object-classification backend defaults).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_svm(...)
}

wbw_classify_objects_svm <- function(...) {
  # Classifies objects using an SVM-style workflow (implemented via robust object-classification backend defaults).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_objects_svm(...)
}

classify_overlap_points <- function(...) {
  # Identifies flight-line overlaps: detects grid cells with multiple point-source IDs, flags or removes overlap points. Quality control for acquisition validation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_overlap_points(...)
}

wbw_classify_overlap_points <- function(...) {
  # Identifies flight-line overlaps: detects grid cells with multiple point-source IDs, flags or removes overlap points. Quality control for acquisition validation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$classify_overlap_points(...)
}

clean_vector <- function(...) {
  # Removes null and invalid vector geometries (e.g., undersized lines/polygons) while preserving valid features and attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clean_vector(...)
}

wbw_clean_vector <- function(...) {
  # Removes null and invalid vector geometries (e.g., undersized lines/polygons) while preserving valid features and attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clean_vector(...)
}

clip <- function(...) {
  # Clips input polygons to overlay polygon boundaries using topology-based intersection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clip(...)
}

wbw_clip <- function(...) {
  # Clips input polygons to overlay polygon boundaries using topology-based intersection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clip(...)
}

clip_lidar_to_polygon <- function(...) {
  # Spatial subset of point cloud: retains points inside polygon boundaries. Vector-based point selection for study-area extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clip_lidar_to_polygon(...)
}

wbw_clip_lidar_to_polygon <- function(...) {
  # Spatial subset of point cloud: retains points inside polygon boundaries. Vector-based point selection for study-area extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clip_lidar_to_polygon(...)
}

clip_raster_to_polygon <- function(...) {
  # Clips a raster to polygon extents; outside polygon cells are set to NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clip_raster_to_polygon(...)
}

wbw_clip_raster_to_polygon <- function(...) {
  # Clips a raster to polygon extents; outside polygon cells are set to NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clip_raster_to_polygon(...)
}

closest_facility_network <- function(...) {
  # Finds the minimum-cost network route from each incident point to its nearest reachable facility point.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$closest_facility_network(...)
}

wbw_closest_facility_network <- function(...) {
  # Finds the minimum-cost network route from each incident point to its nearest reachable facility point.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$closest_facility_network(...)
}

closing <- function(...) {
  # Performs a morphological closing operation using a rectangular structuring element.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$closing(...)
}

wbw_closing <- function(...) {
  # Performs a morphological closing operation using a rectangular structuring element.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$closing(...)
}

cloude_pottier_decomposition <- function(...) {
  # Cloude-Pottier decomposition diagonalizes the coherency matrix from quad-polarimetric SAR data, extracting eigenvalues and eigenvectors characterizing scattering mechanisms. Entropy, anisotropy, and average alpha angle computed from eigenvectors characterize scattering disorder, mechanism dominance, and scattering type respectively. H-alpha parameter space enables physical scattering mechanism classification independent of amplitude variations, exploiting polarimetric phase information. Key Features: Quad-polarimetric SAR decomposition; phase information exploitation; physically meaningful scattering parameters; separates scattering mechanisms; robust to amplitude speckle; enables target classification and interpretation. Use Cases: SAR target recognition; forest biomass estimation; wetland characterization; ship/vehicle detection; landcover classification; polarimetric SAR data interpretation. Output Interpretation: Output includes entropy (disorder degree; 0=ordered scattering, 1=random), anisotropy (mechanism dominance 0-1), and alpha angle (scattering type: ~45°=dipole, ~30°=surface, ~60°=volume). H-alpha scatter plots reveal clustering patterns indicating scattering types. Double-bounce (urban) exhibits high alpha; surface scattering (water) exhibits low alpha; volume scattering (forest) exhibits intermediate values.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cloude_pottier_decomposition(...)
}

wbw_cloude_pottier_decomposition <- function(...) {
  # Cloude-Pottier decomposition diagonalizes the coherency matrix from quad-polarimetric SAR data, extracting eigenvalues and eigenvectors characterizing scattering mechanisms. Entropy, anisotropy, and average alpha angle computed from eigenvectors characterize scattering disorder, mechanism dominance, and scattering type respectively. H-alpha parameter space enables physical scattering mechanism classification independent of amplitude variations, exploiting polarimetric phase information. Key Features: Quad-polarimetric SAR decomposition; phase information exploitation; physically meaningful scattering parameters; separates scattering mechanisms; robust to amplitude speckle; enables target classification and interpretation. Use Cases: SAR target recognition; forest biomass estimation; wetland characterization; ship/vehicle detection; landcover classification; polarimetric SAR data interpretation. Output Interpretation: Output includes entropy (disorder degree; 0=ordered scattering, 1=random), anisotropy (mechanism dominance 0-1), and alpha angle (scattering type: ~45°=dipole, ~30°=surface, ~60°=volume). H-alpha scatter plots reveal clustering patterns indicating scattering types. Double-bounce (urban) exhibits high alpha; surface scattering (water) exhibits low alpha; volume scattering (forest) exhibits intermediate values.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cloude_pottier_decomposition(...)
}

clump <- function(...) {
  # Groups contiguous equal-valued raster cells into unique patch identifiers.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clump(...)
}

wbw_clump <- function(...) {
  # Groups contiguous equal-valued raster cells into unique patch identifiers.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$clump(...)
}

colourize_based_on_class <- function(...) {
  # Colors points by class: ASPRS standard colors (green=veg, brown=ground, gray=building, etc). Blends with intensity for contrast. Classification visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$colourize_based_on_class(...)
}

wbw_colourize_based_on_class <- function(...) {
  # Colors points by class: ASPRS standard colors (green=veg, brown=ground, gray=building, etc). Blends with intensity for contrast. Classification visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$colourize_based_on_class(...)
}

colourize_based_on_point_returns <- function(...) {
  # Colors points by return order: first/intermediate/last returns use distinct colors. Multi-return pulse structure visualization for processing validation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$colourize_based_on_point_returns(...)
}

wbw_colourize_based_on_point_returns <- function(...) {
  # Colors points by return order: first/intermediate/last returns use distinct colors. Multi-return pulse structure visualization for processing validation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$colourize_based_on_point_returns(...)
}

compactness_ratio <- function(...) {
  # Computes compactness ratio (area / perimeter) for polygon features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$compactness_ratio(...)
}

wbw_compactness_ratio <- function(...) {
  # Computes compactness ratio (area / perimeter) for polygon features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$compactness_ratio(...)
}

concave_hull <- function(...) {
  # Creates concave hull polygons around input feature coordinates using the concaveman algorithm.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$concave_hull(...)
}

wbw_concave_hull <- function(...) {
  # Creates concave hull polygons around input feature coordinates using the concaveman algorithm.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$concave_hull(...)
}

conditional_evaluation <- function(...) {
  # Performs if-then-else conditional evaluation on raster cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$conditional_evaluation(...)
}

wbw_conditional_evaluation <- function(...) {
  # Performs if-then-else conditional evaluation on raster cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$conditional_evaluation(...)
}

conservative_smoothing_filter <- function(...) {
  # Conservative Smoothing implements non-linear filtering by replacing each pixel with the average of similar neighbors (within a defined intensity range), preserving edges while reducing noise. Implementation examines neighborhoods, identifies pixels within intensity threshold of central pixel, and averages these similar-value pixels. Mathematical formulation: F = (1/N) Σ(I_j : |I_j - I_center| < T), where T is similarity threshold and N is count of similar pixels. Key features include simple threshold-based similarity definition, effectiveness on optical and radar imagery, parameter interpretability (threshold controls edge-sharpness), and minimal computational overhead. Conservative Smoothing excels in multispectral satellite image preprocessing (reduces noise while preserving spectral boundaries), thermal image enhancement (smooths radiometric noise while maintaining temperature discontinuities), LiDAR classification smoothing (preserves vegetation/ground boundaries), and noisy survey data preprocessing. Output interpretation shows that homogeneous regions average completely (all neighbors similar); edges filter minimally (similar pixels only on same side). Threshold parameter controls edge preservation: small threshold (strict similarity) produces mild smoothing; large threshold (loose similarity) produces aggressive smoothing potentially losing edges. Output values exactly match input neighbor values (no interpolation; output is average of existing values). Statistics shift toward local clusters; heterogeneous regions show minimal change. Verify threshold effectiveness via visual inspection and local histogram analysis. Common artifacts include insufficient smoothing if thresholds are too strict and edge blurring if thresholds are too loose. Iteration count enables progressive filtering: single pass provides gentle smoothing; multiple passes intensify effect. Apply before classification where noise-driven category confusion must be reduced while class boundaries remain sharp.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$conservative_smoothing_filter(...)
}

wbw_conservative_smoothing_filter <- function(...) {
  # Conservative Smoothing implements non-linear filtering by replacing each pixel with the average of similar neighbors (within a defined intensity range), preserving edges while reducing noise. Implementation examines neighborhoods, identifies pixels within intensity threshold of central pixel, and averages these similar-value pixels. Mathematical formulation: F = (1/N) Σ(I_j : |I_j - I_center| < T), where T is similarity threshold and N is count of similar pixels. Key features include simple threshold-based similarity definition, effectiveness on optical and radar imagery, parameter interpretability (threshold controls edge-sharpness), and minimal computational overhead. Conservative Smoothing excels in multispectral satellite image preprocessing (reduces noise while preserving spectral boundaries), thermal image enhancement (smooths radiometric noise while maintaining temperature discontinuities), LiDAR classification smoothing (preserves vegetation/ground boundaries), and noisy survey data preprocessing. Output interpretation shows that homogeneous regions average completely (all neighbors similar); edges filter minimally (similar pixels only on same side). Threshold parameter controls edge preservation: small threshold (strict similarity) produces mild smoothing; large threshold (loose similarity) produces aggressive smoothing potentially losing edges. Output values exactly match input neighbor values (no interpolation; output is average of existing values). Statistics shift toward local clusters; heterogeneous regions show minimal change. Verify threshold effectiveness via visual inspection and local histogram analysis. Common artifacts include insufficient smoothing if thresholds are too strict and edge blurring if thresholds are too loose. Iteration count enables progressive filtering: single pass provides gentle smoothing; multiple passes intensify effect. Apply before classification where noise-driven category confusion must be reduced while class boundaries remain sharp.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$conservative_smoothing_filter(...)
}

construct_vector_tin <- function(...) {
  # Constructs a triangular irregular network (TIN) from an input point set using Delaunay triangulation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$construct_vector_tin(...)
}

wbw_construct_vector_tin <- function(...) {
  # Constructs a triangular irregular network (TIN) from an input point set using Delaunay triangulation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$construct_vector_tin(...)
}

continuum_removal <- function(...) {
  # Continuum removal normalizes multispectral spectra by estimating upper convex hull (continuum) enveloping spectrum and dividing each band by corresponding continuum value. Removes overall spectral slope and brightness variations enabling enhanced visualization of absorption features (bands, depths). Absorption depths and positions standardized enabling mineral/material identification via spectral libraries. Continuum line computed via convex hull algorithm connecting local maxima across spectral range. Key Features: Removes spectral continuum; enhances absorption features; normalizes for brightness variations; enables spectral library matching; standardizes spectral shape. Use Cases: Mineral identification; material classification; vegetation spectral analysis; spectral anomaly detection; absorption feature mapping. Output Interpretation: Continuum-removed spectra exhibit absorption features (values <1.0) indicating material-specific bands. Absorption depths indicate feature strength; shallow features (<0.2) indicate minor components; deep features (>0.5) indicate dominant absorptions. Feature positions in wavelength space enable material identification via reference libraries. Flat continuum-removed spectra (near 1.0) indicate spectrally neutral materials.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$continuum_removal(...)
}

wbw_continuum_removal <- function(...) {
  # Continuum removal normalizes multispectral spectra by estimating upper convex hull (continuum) enveloping spectrum and dividing each band by corresponding continuum value. Removes overall spectral slope and brightness variations enabling enhanced visualization of absorption features (bands, depths). Absorption depths and positions standardized enabling mineral/material identification via spectral libraries. Continuum line computed via convex hull algorithm connecting local maxima across spectral range. Key Features: Removes spectral continuum; enhances absorption features; normalizes for brightness variations; enables spectral library matching; standardizes spectral shape. Use Cases: Mineral identification; material classification; vegetation spectral analysis; spectral anomaly detection; absorption feature mapping. Output Interpretation: Continuum-removed spectra exhibit absorption features (values <1.0) indicating material-specific bands. Absorption depths indicate feature strength; shallow features (<0.2) indicate minor components; deep features (>0.5) indicate dominant absorptions. Feature positions in wavelength space enable material identification via reference libraries. Flat continuum-removed spectra (near 1.0) indicate spectrally neutral materials.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$continuum_removal(...)
}

contours_from_points <- function(...) {
  # Creates contour polylines from point elevations using a Delaunay TIN.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$contours_from_points(...)
}

wbw_contours_from_points <- function(...) {
  # Creates contour polylines from point elevations using a Delaunay TIN.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$contours_from_points(...)
}

contours_from_raster <- function(...) {
  # Creates contour polylines from a raster surface model.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$contours_from_raster(...)
}

wbw_contours_from_raster <- function(...) {
  # Creates contour polylines from a raster surface model.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$contours_from_raster(...)
}

convergence_index <- function(...) {
  # Flow convergence/divergence from local aspect alignment. Identifies valleys (convergent) and ridges (divergent) without full flow routing. Efficient alternative to flow direction algorithms.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$convergence_index(...)
}

wbw_convergence_index <- function(...) {
  # Flow convergence/divergence from local aspect alignment. Identifies valleys (convergent) and ridges (divergent) without full flow routing. Efficient alternative to flow direction algorithms.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$convergence_index(...)
}

convert_nodata_to_zero <- function(...) {
  # Replaces raster nodata cells with 0 while leaving valid cells unchanged.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$convert_nodata_to_zero(...)
}

wbw_convert_nodata_to_zero <- function(...) {
  # Replaces raster nodata cells with 0 while leaving valid cells unchanged.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$convert_nodata_to_zero(...)
}

corner_detection <- function(...) {
  # Identifies corner patterns in binary rasters using hit-and-miss templates.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$corner_detection(...)
}

wbw_corner_detection <- function(...) {
  # Identifies corner patterns in binary rasters using hit-and-miss templates.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$corner_detection(...)
}

correct_vignetting <- function(...) {
  # Lens vignetting correction removes radiometric artifacts caused by off-axis lens optical properties where image edges receive less light than image centers, creating artificial brightness gradients independent of surface reflectance variation. Vignetting correction applies spatially varying multiplicative factors computed from vignetting profile models (Gaussian or cosine-fourth-law formulations) calibrated to sensor characteristics, restoring uniform radiometric response across the image field of view. This preprocessing step is critical for multispectral and hyperspectral remote sensing where vignetting would corrupt spectral analysis and introduce systematic errors in classification and change detection workflows. Key features include automatic vignetting profile estimation from image statistics or user-specified calibration parameters, spatially varying correction factors applied per-pixel without interpolation artifacts, optional masking of overcorrected peripheral pixels preventing amplification of noisy edges, and band-specific correction handling variable vignetting across spectral bands. Applications include preprocessing for spectral classification algorithms sensitive to radiometric consistency, mosaic preparation where vignetting boundaries cause visible discontinuities, accurate radiometric comparison across image frame, and hyperspectral analysis requiring uniform illumination response. Vignetting-corrected imagery shows uniform brightness across field of view. Output exhibits removed edge darkening with uniform radiometric response from image center to edges; peripheral pixels may show elevated noise if heavily corrected; corrected imagery integrates seamlessly into multispectral analysis workflows without radiometric artifacts.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$correct_vignetting(...)
}

wbw_correct_vignetting <- function(...) {
  # Lens vignetting correction removes radiometric artifacts caused by off-axis lens optical properties where image edges receive less light than image centers, creating artificial brightness gradients independent of surface reflectance variation. Vignetting correction applies spatially varying multiplicative factors computed from vignetting profile models (Gaussian or cosine-fourth-law formulations) calibrated to sensor characteristics, restoring uniform radiometric response across the image field of view. This preprocessing step is critical for multispectral and hyperspectral remote sensing where vignetting would corrupt spectral analysis and introduce systematic errors in classification and change detection workflows. Key features include automatic vignetting profile estimation from image statistics or user-specified calibration parameters, spatially varying correction factors applied per-pixel without interpolation artifacts, optional masking of overcorrected peripheral pixels preventing amplification of noisy edges, and band-specific correction handling variable vignetting across spectral bands. Applications include preprocessing for spectral classification algorithms sensitive to radiometric consistency, mosaic preparation where vignetting boundaries cause visible discontinuities, accurate radiometric comparison across image frame, and hyperspectral analysis requiring uniform illumination response. Vignetting-corrected imagery shows uniform brightness across field of view. Output exhibits removed edge darkening with uniform radiometric response from image center to edges; peripheral pixels may show elevated noise if heavily corrected; corrected imagery integrates seamlessly into multispectral analysis workflows without radiometric artifacts.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$correct_vignetting(...)
}

cos <- function(...) {
  # Computes the cosine of each raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cos(...)
}

wbw_cos <- function(...) {
  # Computes the cosine of each raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cos(...)
}

cosh <- function(...) {
  # Computes the hyperbolic cosine of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cosh(...)
}

wbw_cosh <- function(...) {
  # Computes the hyperbolic cosine of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cosh(...)
}

cost_allocation <- function(...) {
  # Assigns each cell to a source region using a backlink raster from cost distance analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cost_allocation(...)
}

wbw_cost_allocation <- function(...) {
  # Assigns each cell to a source region using a backlink raster from cost distance analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cost_allocation(...)
}

cost_distance <- function(...) {
  # Computes accumulated travel cost and backlink rasters from source and cost surfaces.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cost_distance(...)
}

wbw_cost_distance <- function(...) {
  # Computes accumulated travel cost and backlink rasters from source and cost surfaces.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cost_distance(...)
}

cost_pathway <- function(...) {
  # Traces least-cost pathways from destination cells using a backlink raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cost_pathway(...)
}

wbw_cost_pathway <- function(...) {
  # Traces least-cost pathways from destination cells using a backlink raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cost_pathway(...)
}

count_if <- function(...) {
  # Counts the number of input rasters whose cell equals a comparison value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$count_if(...)
}

wbw_count_if <- function(...) {
  # Counts the number of input rasters whose cell equals a comparison value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$count_if(...)
}

create_colour_composite <- function(...) {
  # Creates a packed RGB colour composite from red, green, blue, and optional opacity rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$create_colour_composite(...)
}

wbw_create_colour_composite <- function(...) {
  # Creates a packed RGB colour composite from red, green, blue, and optional opacity rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$create_colour_composite(...)
}

create_plane <- function(...) {
  # Creates a raster from a planar equation using a base raster geometry.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$create_plane(...)
}

wbw_create_plane <- function(...) {
  # Creates a raster from a planar equation using a base raster geometry.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$create_plane(...)
}

crispness_index <- function(...) {
  # Calculates the crispness index for a membership probability raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$crispness_index(...)
}

wbw_crispness_index <- function(...) {
  # Calculates the crispness index for a membership probability raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$crispness_index(...)
}

cross_tabulation <- function(...) {
  # Performs cross-tabulation on two categorical rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cross_tabulation(...)
}

wbw_cross_tabulation <- function(...) {
  # Performs cross-tabulation on two categorical rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cross_tabulation(...)
}

csv_points_to_vector <- function(...) {
  # Imports point records from a CSV file into a point vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$csv_points_to_vector(...)
}

wbw_csv_points_to_vector <- function(...) {
  # Imports point records from a CSV file into a point vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$csv_points_to_vector(...)
}

cumulative_distribution <- function(...) {
  # Converts raster values to cumulative distribution probabilities.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cumulative_distribution(...)
}

wbw_cumulative_distribution <- function(...) {
  # Converts raster values to cumulative distribution probabilities.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$cumulative_distribution(...)
}

curvedness <- function(...) {
  # Calculates the curvedness surface form descriptor from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$curvedness(...)
}

wbw_curvedness <- function(...) {
  # Calculates the curvedness surface form descriptor from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$curvedness(...)
}

d8_flow_accum <- function(...) {
  # Calculates D8 flow accumulation from a DEM or D8 pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$d8_flow_accum(...)
}

wbw_d8_flow_accum <- function(...) {
  # Calculates D8 flow accumulation from a DEM or D8 pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$d8_flow_accum(...)
}

d8_mass_flux <- function(...) {
  # Performs a D8-based mass-flux accumulation using loading, efficiency, and absorption rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$d8_mass_flux(...)
}

wbw_d8_mass_flux <- function(...) {
  # Performs a D8-based mass-flux accumulation using loading, efficiency, and absorption rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$d8_mass_flux(...)
}

d8_pointer <- function(...) {
  # Steepest-descent flow direction over 8 neighbors (N/NE/E/SE/S/SW/W/NW). Foundation for D8 hydrologic analysis and watershed delineation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$d8_pointer(...)
}

wbw_d8_pointer <- function(...) {
  # Steepest-descent flow direction over 8 neighbors (N/NE/E/SE/S/SW/W/NW). Foundation for D8 hydrologic analysis and watershed delineation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$d8_pointer(...)
}

dark_object_subtraction <- function(...) {
  # Dark Object Subtraction (DOS) is a simple yet effective heuristic for atmospheric haze removal without requiring ancillary meteorological data or complex radiative transfer models. The technique exploits the principle that zero reflectance should produce zero reflectance signal (neglecting Rayleigh scattering); any signal observed from optically black surfaces (deep water, dense forest shadow, urban asphalt) is attributed to atmospheric path radiance caused by aerosol scattering. This tool identifies the minimum digital number in each band across the image, interprets this as atmospheric haze, and subtracts it from all pixels as a per-band constant offset; more sophisticated variants (DOS2, DOS3, DOS4) account for Rayleigh scattering and variable aerosol optical depth using vegetation indices or dark pixel clustering. Key capabilities include histogram analysis to isolate dark objects and distinguish scene-dependent haze from true zero reflectance, optional masking of known high-reflectance features (urban, snow, clouds) that would bias dark-object identification, band-specific haze correction, and fast computation suitable for real-time or large-scale processing. Use cases include quick-look reflectance estimates, vegetation and water quality monitoring where absolute calibration is less critical than relative changes, rapid disaster response mapping, and legacy archived data where precise aerosol information is unavailable. Input comprises top-of-atmosphere reflectance or calibrated radiance, optional land cover masks to exclude bright features, and scene metadata. Output is haze-corrected reflectance, per-band atmospheric path radiance estimates, and quality flags indicating confidence in dark-object identification (e.g., limited dark pixels, urban-dominated scene). While crude compared to radiative transfer models, DOS remains practical for multi-temporal analysis and global coverage mapping when sophisticated atmospheric data are in [truncated]
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dark_object_subtraction(...)
}

wbw_dark_object_subtraction <- function(...) {
  # Dark Object Subtraction (DOS) is a simple yet effective heuristic for atmospheric haze removal without requiring ancillary meteorological data or complex radiative transfer models. The technique exploits the principle that zero reflectance should produce zero reflectance signal (neglecting Rayleigh scattering); any signal observed from optically black surfaces (deep water, dense forest shadow, urban asphalt) is attributed to atmospheric path radiance caused by aerosol scattering. This tool identifies the minimum digital number in each band across the image, interprets this as atmospheric haze, and subtracts it from all pixels as a per-band constant offset; more sophisticated variants (DOS2, DOS3, DOS4) account for Rayleigh scattering and variable aerosol optical depth using vegetation indices or dark pixel clustering. Key capabilities include histogram analysis to isolate dark objects and distinguish scene-dependent haze from true zero reflectance, optional masking of known high-reflectance features (urban, snow, clouds) that would bias dark-object identification, band-specific haze correction, and fast computation suitable for real-time or large-scale processing. Use cases include quick-look reflectance estimates, vegetation and water quality monitoring where absolute calibration is less critical than relative changes, rapid disaster response mapping, and legacy archived data where precise aerosol information is unavailable. Input comprises top-of-atmosphere reflectance or calibrated radiance, optional land cover masks to exclude bright features, and scene metadata. Output is haze-corrected reflectance, per-band atmospheric path radiance estimates, and quality flags indicating confidence in dark-object identification (e.g., limited dark pixels, urban-dominated scene). While crude compared to radiative transfer models, DOS remains practical for multi-temporal analysis and global coverage mapping when sophisticated atmospheric data are in [truncated]
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dark_object_subtraction(...)
}

dbscan <- function(...) {
  # Performs unsupervised DBSCAN density-based clustering on a stack of input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dbscan(...)
}

wbw_dbscan <- function(...) {
  # Performs unsupervised DBSCAN density-based clustering on a stack of input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dbscan(...)
}

decrement <- function(...) {
  # Subtracts a value (default 1.0) from each non-nodata raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$decrement(...)
}

wbw_decrement <- function(...) {
  # Subtracts a value (default 1.0) from each non-nodata raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$decrement(...)
}

delete_field <- function(...) {
  # Deletes one or more attribute fields from a vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$delete_field(...)
}

wbw_delete_field <- function(...) {
  # Deletes one or more attribute fields from a vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$delete_field(...)
}

dem_void_filling <- function(...) {
  # Fills DEM voids using a secondary surface and interpolated elevation offsets for seamless fusion.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dem_void_filling(...)
}

wbw_dem_void_filling <- function(...) {
  # Fills DEM voids using a secondary surface and interpolated elevation offsets for seamless fusion.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dem_void_filling(...)
}

densify_features <- function(...) {
  # Adds vertices along line and polygon boundaries at a specified spacing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$densify_features(...)
}

wbw_densify_features <- function(...) {
  # Adds vertices along line and polygon boundaries at a specified spacing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$densify_features(...)
}

depth_in_sink <- function(...) {
  # Measures the depth each DEM cell lies below a depression-filled surface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$depth_in_sink(...)
}

wbw_depth_in_sink <- function(...) {
  # Measures the depth each DEM cell lies below a depression-filled surface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$depth_in_sink(...)
}

depth_to_water <- function(...) {
  # Computes cartographic depth-to-water using least-cost accumulation from stream/lake source features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$depth_to_water(...)
}

wbw_depth_to_water <- function(...) {
  # Computes cartographic depth-to-water using least-cost accumulation from stream/lake source features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$depth_to_water(...)
}

deviation_from_mean_elevation <- function(...) {
  # Calculates the local topographic z-score using local mean and standard deviation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$deviation_from_mean_elevation(...)
}

wbw_deviation_from_mean_elevation <- function(...) {
  # Calculates the local topographic z-score using local mean and standard deviation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$deviation_from_mean_elevation(...)
}

deviation_from_regional_direction <- function(...) {
  # Calculates polygon directional deviation from weighted regional mean orientation and appends DEV_DIR.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$deviation_from_regional_direction(...)
}

wbw_deviation_from_regional_direction <- function(...) {
  # Calculates polygon directional deviation from weighted regional mean orientation and appends DEV_DIR.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$deviation_from_regional_direction(...)
}

diff_of_gaussians_filter <- function(...) {
  # Difference of Gaussians (DoG) filtering detects edges and fine features via subtraction of two Gaussian-blurred versions with different radii, creating a bandpass filter emphasizing intermediate spatial frequencies. Implementation computes two Gaussian blurs (small radius σ₁ and large radius σ₂), then subtracts: DoG = G(σ₁) - G(σ₂). This non-linear combination enhances edges and ridges while suppressing both fine noise and broad illumination trends. Key features include tunable frequency response (ratio σ₂/σ₁ controls bandpass characteristics), zero-centered output (bipolar: positive and negative values), applicability to edge detection and feature extraction, and computational efficiency via Gaussian reuse. Difference of Gaussians excels in geological structure detection (faults, lineaments appear as high DoG response), building extraction from orthophotos, fine-texture enhancement in remote sensing mosaics, and neuroscience-inspired processing models. Output interpretation shows that edges produce peak responses (positive on bright side, negative on dark side) with zero-crossing precisely at transitions. Zero-crossing detection reveals true edges independent of edge direction. DoG magnitude indicates edge strength; typical range spans -1000 to +1000 for 8-bit input depending on local contrast. Ratio σ₂/σ₁ determines bandpass center: ratio~2 emphasizes very fine features; ratio~5 emphasizes intermediate features; ratio~10 emphasizes coarser features. Bimodal output distributions (peaks at positive and negative extremes) indicate good edge separation. Common artifacts include halos around strong edges and potential under-response if frequency band doesn't match feature scale. Combine with magnitude thresholding for edge extraction. Apply before morphological post-processing for robust feature extraction from noisy satellite imagery.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$diff_of_gaussians_filter(...)
}

wbw_diff_of_gaussians_filter <- function(...) {
  # Difference of Gaussians (DoG) filtering detects edges and fine features via subtraction of two Gaussian-blurred versions with different radii, creating a bandpass filter emphasizing intermediate spatial frequencies. Implementation computes two Gaussian blurs (small radius σ₁ and large radius σ₂), then subtracts: DoG = G(σ₁) - G(σ₂). This non-linear combination enhances edges and ridges while suppressing both fine noise and broad illumination trends. Key features include tunable frequency response (ratio σ₂/σ₁ controls bandpass characteristics), zero-centered output (bipolar: positive and negative values), applicability to edge detection and feature extraction, and computational efficiency via Gaussian reuse. Difference of Gaussians excels in geological structure detection (faults, lineaments appear as high DoG response), building extraction from orthophotos, fine-texture enhancement in remote sensing mosaics, and neuroscience-inspired processing models. Output interpretation shows that edges produce peak responses (positive on bright side, negative on dark side) with zero-crossing precisely at transitions. Zero-crossing detection reveals true edges independent of edge direction. DoG magnitude indicates edge strength; typical range spans -1000 to +1000 for 8-bit input depending on local contrast. Ratio σ₂/σ₁ determines bandpass center: ratio~2 emphasizes very fine features; ratio~5 emphasizes intermediate features; ratio~10 emphasizes coarser features. Bimodal output distributions (peaks at positive and negative extremes) indicate good edge separation. Common artifacts include halos around strong edges and potential under-response if frequency band doesn't match feature scale. Combine with magnitude thresholding for edge extraction. Apply before morphological post-processing for robust feature extraction from noisy satellite imagery.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$diff_of_gaussians_filter(...)
}

difference <- function(...) {
  # Removes overlay polygon areas from input polygons using topology-based difference.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$difference(...)
}

wbw_difference <- function(...) {
  # Removes overlay polygon areas from input polygons using topology-based difference.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$difference(...)
}

difference_curvature <- function(...) {
  # Calculates difference curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$difference_curvature(...)
}

wbw_difference_curvature <- function(...) {
  # Calculates difference curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$difference_curvature(...)
}

difference_from_mean_elevation <- function(...) {
  # Calculates the difference between each elevation and the local mean elevation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$difference_from_mean_elevation(...)
}

wbw_difference_from_mean_elevation <- function(...) {
  # Calculates the difference between each elevation and the local mean elevation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$difference_from_mean_elevation(...)
}

dinf_flow_accum <- function(...) {
  # Calculates D-Infinity flow accumulation from a DEM or D-Infinity pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dinf_flow_accum(...)
}

wbw_dinf_flow_accum <- function(...) {
  # Calculates D-Infinity flow accumulation from a DEM or D-Infinity pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dinf_flow_accum(...)
}

dinf_mass_flux <- function(...) {
  # Performs a D-Infinity mass-flux accumulation using loading, efficiency, and absorption rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dinf_mass_flux(...)
}

wbw_dinf_mass_flux <- function(...) {
  # Performs a D-Infinity mass-flux accumulation using loading, efficiency, and absorption rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dinf_mass_flux(...)
}

dinf_pointer <- function(...) {
  # Continuous flow directions (0-2π radians) eliminating D8 diagonal bias. Better for sediment transport and divergent flow modeling.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dinf_pointer(...)
}

wbw_dinf_pointer <- function(...) {
  # Continuous flow directions (0-2π radians) eliminating D8 diagonal bias. Better for sediment transport and divergent flow modeling.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dinf_pointer(...)
}

direct_decorrelation_stretch <- function(...) {
  # Improves packed RGB colour saturation by reducing the achromatic component and linearly stretching channels.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$direct_decorrelation_stretch(...)
}

wbw_direct_decorrelation_stretch <- function(...) {
  # Improves packed RGB colour saturation by reducing the achromatic component and linearly stretching channels.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$direct_decorrelation_stretch(...)
}

directional_relief <- function(...) {
  # Calculates directional relief by ray-tracing elevation in a specified azimuth.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$directional_relief(...)
}

wbw_directional_relief <- function(...) {
  # Calculates directional relief by ray-tracing elevation in a specified azimuth.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$directional_relief(...)
}

directional_variogram <- function(...) {
  # Computes variograms in multiple directions to detect spatial anisotropy. Reveals directional continuity patterns essential for realistic kriging.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$directional_variogram(...)
}

wbw_directional_variogram <- function(...) {
  # Computes variograms in multiple directions to detect spatial anisotropy. Reveals directional continuity patterns essential for realistic kriging.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$directional_variogram(...)
}

dissolve <- function(...) {
  # Removes shared polygon boundaries globally or by a dissolve attribute field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dissolve(...)
}

wbw_dissolve <- function(...) {
  # Removes shared polygon boundaries globally or by a dissolve attribute field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dissolve(...)
}

distance_to_outlet <- function(...) {
  # Calculates downstream distance to outlet for each stream cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$distance_to_outlet(...)
}

wbw_distance_to_outlet <- function(...) {
  # Calculates downstream distance to outlet for each stream cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$distance_to_outlet(...)
}

diversity_filter <- function(...) {
  # Computes moving-window diversity as count of unique values/classes within neighborhood. Measures local heterogeneity: high diversity = varied terrain/classes, low diversity = homogeneous. Reveals texture, fragmentation, and pattern diversity. Often applied to classified or categorical imagery to identify transition/edge zones.  Diversity filter creates a metric of local variation independent of specific values. Useful for landscape ecology (habitat diversity, fragmentation metrics), classification quality assessment (high diversity = mixed/uncertain areas), and texture analysis. Applied to elevation data, diversity indicates roughness at neighborhood scale. Applied to classification, it identifies mixed/ecotone/boundary zones.  Applications: (1) Landscape fragmentation mapping (high diversity = diverse mosaic, low diversity = uniform patches), (2) Classification confidence/uncertainty assessment (high diversity = uncertain area), (3) Texture analysis (heterogeneity mapping), (4) Edge/boundary detection via diversity peaks, (5) Habitat diversity for ecological analysis (suitability depends on local diversity).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$diversity_filter(...)
}

wbw_diversity_filter <- function(...) {
  # Computes moving-window diversity as count of unique values/classes within neighborhood. Measures local heterogeneity: high diversity = varied terrain/classes, low diversity = homogeneous. Reveals texture, fragmentation, and pattern diversity. Often applied to classified or categorical imagery to identify transition/edge zones.  Diversity filter creates a metric of local variation independent of specific values. Useful for landscape ecology (habitat diversity, fragmentation metrics), classification quality assessment (high diversity = mixed/uncertain areas), and texture analysis. Applied to elevation data, diversity indicates roughness at neighborhood scale. Applied to classification, it identifies mixed/ecotone/boundary zones.  Applications: (1) Landscape fragmentation mapping (high diversity = diverse mosaic, low diversity = uniform patches), (2) Classification confidence/uncertainty assessment (high diversity = uncertain area), (3) Texture analysis (heterogeneity mapping), (4) Edge/boundary detection via diversity peaks, (5) Habitat diversity for ecological analysis (suitability depends on local diversity).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$diversity_filter(...)
}

divide <- function(...) {
  # Divides the first raster by the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$divide(...)
}

wbw_divide <- function(...) {
  # Divides the first raster by the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$divide(...)
}

dn_to_toa_reflectance <- function(...) {
  # Digital number to top-of-atmosphere reflectance conversion transforms raw sensor digital numbers into physically meaningful spectral reflectance values by applying per-band radiometric calibration coefficients derived from satellite metadata. The conversion applies radiometric rescaling, solar exoatmospheric spectral irradiance correction, solar zenith angle compensation, and optional Earth-Sun distance normalization to produce reflectance values directly comparable across sensors, acquisition times, and geographic locations. Top-of-atmosphere reflectance represents the proportion of incident solar energy reflected by earth surface targets at the sensor before atmospheric effects, serving as the baseline for quantitative remote sensing analysis. Key features include per-band calibration coefficient application with full metadata parsing from standard satellite products, automatic solar geometry computation from acquisition timestamp and location, optional Earth-Sun distance correction for seasonal variability, and flexible handling of multiple sensor types with standardized coefficient formats. Applications span quantitative change detection using consistent physical units, absolute radiometric comparison across multitemporal acquisitions and different sensors, spectral vegetation indices calculation requiring precise reflectance, and cross-sensor validation in satellite constellation work. TOA reflectance enables rigorous analysis workflows and scientifically defensible results. Output reflectance values range 0-1 (sometimes expressed as 0-10000 for integer precision) representing dimensionless proportions; metadata embeds calibration coefficients used and sensor geometry parameters; negative values indicate data quality issues requiring masking before analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dn_to_toa_reflectance(...)
}

wbw_dn_to_toa_reflectance <- function(...) {
  # Digital number to top-of-atmosphere reflectance conversion transforms raw sensor digital numbers into physically meaningful spectral reflectance values by applying per-band radiometric calibration coefficients derived from satellite metadata. The conversion applies radiometric rescaling, solar exoatmospheric spectral irradiance correction, solar zenith angle compensation, and optional Earth-Sun distance normalization to produce reflectance values directly comparable across sensors, acquisition times, and geographic locations. Top-of-atmosphere reflectance represents the proportion of incident solar energy reflected by earth surface targets at the sensor before atmospheric effects, serving as the baseline for quantitative remote sensing analysis. Key features include per-band calibration coefficient application with full metadata parsing from standard satellite products, automatic solar geometry computation from acquisition timestamp and location, optional Earth-Sun distance correction for seasonal variability, and flexible handling of multiple sensor types with standardized coefficient formats. Applications span quantitative change detection using consistent physical units, absolute radiometric comparison across multitemporal acquisitions and different sensors, spectral vegetation indices calculation requiring precise reflectance, and cross-sensor validation in satellite constellation work. TOA reflectance enables rigorous analysis workflows and scientifically defensible results. Output reflectance values range 0-1 (sometimes expressed as 0-10000 for integer precision) representing dimensionless proportions; metadata embeds calibration coefficients used and sensor geometry parameters; negative values indicate data quality issues requiring masking before analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$dn_to_toa_reflectance(...)
}

download_osm_vector <- function(...) {
  # Downloads OpenStreetMap features from the Overpass API for a bounding box and writes the result as a vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$download_osm_vector(...)
}

wbw_download_osm_vector <- function(...) {
  # Downloads OpenStreetMap features from the Overpass API for a bounding box and writes the result as a vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$download_osm_vector(...)
}

downslope_distance_to_stream <- function(...) {
  # Computes downslope distance from each DEM cell to nearest stream along flow paths.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$downslope_distance_to_stream(...)
}

wbw_downslope_distance_to_stream <- function(...) {
  # Computes downslope distance from each DEM cell to nearest stream along flow paths.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$downslope_distance_to_stream(...)
}

downslope_flowpath_length <- function(...) {
  # Computes downslope flowpath length from each cell to an outlet in a D8 pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$downslope_flowpath_length(...)
}

wbw_downslope_flowpath_length <- function(...) {
  # Computes downslope flowpath length from each cell to an outlet in a D8 pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$downslope_flowpath_length(...)
}

downslope_index <- function(...) {
  # Calculates Hjerdt et al. (2004) downslope index using D8 flow directions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$downslope_index(...)
}

wbw_downslope_index <- function(...) {
  # Calculates Hjerdt et al. (2004) downslope index using D8 flow directions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$downslope_index(...)
}

edge_contamination <- function(...) {
  # Identifies DEM cells whose upslope area extends beyond the DEM edge for common flow-routing schemes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$edge_contamination(...)
}

wbw_edge_contamination <- function(...) {
  # Identifies DEM cells whose upslope area extends beyond the DEM edge for common flow-routing schemes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$edge_contamination(...)
}

edge_density <- function(...) {
  # Calculates local density of breaks-in-slope using angular normal-vector differences.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$edge_density(...)
}

wbw_edge_density <- function(...) {
  # Calculates local density of breaks-in-slope using angular normal-vector differences.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$edge_density(...)
}

edge_preserving_mean_filter <- function(...) {
  # The Edge-Preserving Mean filter performs selective pixel averaging by computing local means while excluding outlier pixels that likely represent edges or noise. Implementation sorts pixel neighborhoods, removes extreme values (lowest and highest, or values exceeding statistical threshold), and averages remaining values. This robust approach balances smoothing against sharpness preservation. Variants include weighted averaging emphasizing center pixels and adaptive threshold selection based on local statistics. Key features include simple parameter control (exclusion count or threshold), computational efficiency via sorting small neighborhoods, effective noise reduction without detail blurring, and applicability to optical, radar, and thermal data. Edge-Preserving Mean filtering excels in optical satellite preprocessing for vegetation index calculation (removes shadows and clouds without blurring features), DEM smoothing preserving slope breaks, thermal image denoising maintaining boundary sharpness, and orthophoto preparation for manual digitization. Output interpretation reveals that removed outliers concentrate at edges and noise regions; remaining values average creating local smoothing. Exclusion parameters control edge sharpness: excluding single extreme removes salt-pepper noise; excluding multiple extremes produces smoother results with gentler edge transition. Output ranges remain within input; statistics shift toward inlier means. Monitor output difference from input to identify filtered regions (typically high-variance areas). Edge preservation quality depends on outlier identification accuracy; verify visually that features remain sharp. Common artifacts include inadequate smoothing if thresholds are too strict and excessive filtering if exclusion counts are too high. Iteration count enables progressive filtering; single pass provides gentle smoothing. Apply before threshold-based classification to reduce noise-driven category misclassification while maintaining feature boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$edge_preserving_mean_filter(...)
}

wbw_edge_preserving_mean_filter <- function(...) {
  # The Edge-Preserving Mean filter performs selective pixel averaging by computing local means while excluding outlier pixels that likely represent edges or noise. Implementation sorts pixel neighborhoods, removes extreme values (lowest and highest, or values exceeding statistical threshold), and averages remaining values. This robust approach balances smoothing against sharpness preservation. Variants include weighted averaging emphasizing center pixels and adaptive threshold selection based on local statistics. Key features include simple parameter control (exclusion count or threshold), computational efficiency via sorting small neighborhoods, effective noise reduction without detail blurring, and applicability to optical, radar, and thermal data. Edge-Preserving Mean filtering excels in optical satellite preprocessing for vegetation index calculation (removes shadows and clouds without blurring features), DEM smoothing preserving slope breaks, thermal image denoising maintaining boundary sharpness, and orthophoto preparation for manual digitization. Output interpretation reveals that removed outliers concentrate at edges and noise regions; remaining values average creating local smoothing. Exclusion parameters control edge sharpness: excluding single extreme removes salt-pepper noise; excluding multiple extremes produces smoother results with gentler edge transition. Output ranges remain within input; statistics shift toward inlier means. Monitor output difference from input to identify filtered regions (typically high-variance areas). Edge preservation quality depends on outlier identification accuracy; verify visually that features remain sharp. Common artifacts include inadequate smoothing if thresholds are too strict and excessive filtering if exclusion counts are too high. Iteration count enables progressive filtering; single pass provides gentle smoothing. Apply before threshold-based classification to reduce noise-driven category misclassification while maintaining feature boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$edge_preserving_mean_filter(...)
}

edge_proportion <- function(...) {
  # Calculates the proportion of each patch's cells that are edge cells and maps it back to patch cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$edge_proportion(...)
}

wbw_edge_proportion <- function(...) {
  # Calculates the proportion of each patch's cells that are edge cells and maps it back to patch cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$edge_proportion(...)
}

elev_above_pit <- function(...) {
  # Calculates elevation above the nearest downslope pit cell (or edge sink).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elev_above_pit(...)
}

wbw_elev_above_pit <- function(...) {
  # Calculates elevation above the nearest downslope pit cell (or edge sink).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elev_above_pit(...)
}

elev_above_pit_dist <- function(...) {
  # Compatibility alias for elev_above_pit.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elev_above_pit_dist(...)
}

wbw_elev_above_pit_dist <- function(...) {
  # Compatibility alias for elev_above_pit.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elev_above_pit_dist(...)
}

elev_relative_to_min_max <- function(...) {
  # Expresses each elevation as a percentage (0–100) of the raster's elevation range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elev_relative_to_min_max(...)
}

wbw_elev_relative_to_min_max <- function(...) {
  # Expresses each elevation as a percentage (0–100) of the raster's elevation range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elev_relative_to_min_max(...)
}

elev_relative_to_watershed_min_max <- function(...) {
  # Calculates a DEM cell's relative elevation position within each watershed as a percentage.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elev_relative_to_watershed_min_max(...)
}

wbw_elev_relative_to_watershed_min_max <- function(...) {
  # Calculates a DEM cell's relative elevation position within each watershed as a percentage.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elev_relative_to_watershed_min_max(...)
}

elevation_above_stream <- function(...) {
  # Computes elevation above nearest stream measured along downslope flow paths.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elevation_above_stream(...)
}

wbw_elevation_above_stream <- function(...) {
  # Computes elevation above nearest stream measured along downslope flow paths.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elevation_above_stream(...)
}

elevation_above_stream_euclidean <- function(...) {
  # Computes elevation above nearest stream using straight-line (Euclidean) proximity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elevation_above_stream_euclidean(...)
}

wbw_elevation_above_stream_euclidean <- function(...) {
  # Computes elevation above nearest stream using straight-line (Euclidean) proximity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elevation_above_stream_euclidean(...)
}

elevation_percentile <- function(...) {
  # Local elevation percentile rank within neighborhood (0-100). Identifies valleys (low %), ridges (high %), and slopes (mid %). Landform classification metric independent of absolute elevation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elevation_percentile(...)
}

wbw_elevation_percentile <- function(...) {
  # Local elevation percentile rank within neighborhood (0-100). Identifies valleys (low %), ridges (high %), and slopes (mid %). Landform classification metric independent of absolute elevation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elevation_percentile(...)
}

eliminate_coincident_points <- function(...) {
  # Removes coincident or near-coincident points within a tolerance distance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$eliminate_coincident_points(...)
}

wbw_eliminate_coincident_points <- function(...) {
  # Removes coincident or near-coincident points within a tolerance distance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$eliminate_coincident_points(...)
}

elongation_ratio <- function(...) {
  # Computes elongation ratio (short axis / long axis of bounding rectangle) for polygon features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elongation_ratio(...)
}

wbw_elongation_ratio <- function(...) {
  # Computes elongation ratio (short axis / long axis of bounding rectangle) for polygon features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$elongation_ratio(...)
}

embankment_mapping <- function(...) {
  # Maps transportation embankments from a DEM and road network, with optional embankment-surface removal via interpolation. Authored by John Lindsay and Nigel VanNieuwenhuizen.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$embankment_mapping(...)
}

wbw_embankment_mapping <- function(...) {
  # Maps transportation embankments from a DEM and road network, with optional embankment-surface removal via interpolation. Authored by John Lindsay and Nigel VanNieuwenhuizen.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$embankment_mapping(...)
}

emboss_filter <- function(...) {
  # The emboss filter enhances edge features through directional shading, creating a distinctive three-dimensional relief appearance where edges appear as raised or depressed surfaces depending on directional lighting simulation. This filter applies a 3×3 kernel that combines edge detection with unidirectional illumination, typically simulating light from the upper-left quadrant, creating dramatic visual contrast at boundaries while preserving smooth regions. The emboss transformation subtracts weighted neighbor values in specific directions, producing output where highlights and shadows accentuate topographic and feature discontinuities. Key features include intuitive directional control allowing simulated light direction adjustment (eight-directional variants), natural incorporation of 3D perception enhancing visual interpretation, and robust performance across varied lighting conditions in source imagery. The emboss filter serves quality assurance, interpretative visualization, and feature boundary emphasis applications. Use cases include visual enhancement for geological interpretation where mineral boundaries become visible as relief patterns, aerial photograph interpretation improving subtle boundary visibility, cartographic production where embossed digital elevation models generate compelling relief maps, and archaeological feature detection where buried structures appear as subtle topographic variations. Output interpretation treats high values as illuminated surfaces and low values as shadows, creating perceptual depth that the human eye naturally interprets as relief. Embossed output typically requires scaling to 0-255 visualization range; raw output often contains negative values representing shadow areas. The effect is purely visual—emboss does not compute true illumination or create elevation derivatives. For multi-spectral imagery, apply to principal components or selected bands based on analytical objectives. Post-processing often includes contrast enhancement or tone mapping optimizing visual impact.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$emboss_filter(...)
}

wbw_emboss_filter <- function(...) {
  # The emboss filter enhances edge features through directional shading, creating a distinctive three-dimensional relief appearance where edges appear as raised or depressed surfaces depending on directional lighting simulation. This filter applies a 3×3 kernel that combines edge detection with unidirectional illumination, typically simulating light from the upper-left quadrant, creating dramatic visual contrast at boundaries while preserving smooth regions. The emboss transformation subtracts weighted neighbor values in specific directions, producing output where highlights and shadows accentuate topographic and feature discontinuities. Key features include intuitive directional control allowing simulated light direction adjustment (eight-directional variants), natural incorporation of 3D perception enhancing visual interpretation, and robust performance across varied lighting conditions in source imagery. The emboss filter serves quality assurance, interpretative visualization, and feature boundary emphasis applications. Use cases include visual enhancement for geological interpretation where mineral boundaries become visible as relief patterns, aerial photograph interpretation improving subtle boundary visibility, cartographic production where embossed digital elevation models generate compelling relief maps, and archaeological feature detection where buried structures appear as subtle topographic variations. Output interpretation treats high values as illuminated surfaces and low values as shadows, creating perceptual depth that the human eye naturally interprets as relief. Embossed output typically requires scaling to 0-255 visualization range; raw output often contains negative values representing shadow areas. The effect is purely visual—emboss does not compute true illumination or create elevation derivatives. For multi-spectral imagery, apply to principal components or selected bands based on analytical objectives. Post-processing often includes contrast enhancement or tone mapping optimizing visual impact.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$emboss_filter(...)
}

enhanced_lee_filter <- function(...) {
  # The Enhanced Lee filter combines Lee's multiplicative model with refined variance estimation and multi-scale processing, achieving superior speckle reduction while preserving fine details and edges in SAR imagery. Implementation employs local statistics computed via windows of adaptive size, incorporates Laplacian-based edge detection, and applies spatially-varying filter parameters. The enhanced formulation applies: F = μ + w·(I - μ) where w adapts to edge proximity: w→0 near edges (minimal filtering), w→1 in homogeneous regions (aggressive filtering). Key features include edge-adaptive processing (preserving boundaries), multi-scale parameter adaptation, improved target preservation versus standard Lee, and effectiveness on high-noise SAR. Enhanced Lee filtering excels in complex SAR scenes with numerous features, flood-mapping applications where edge localization is critical, building detection from urban SAR, and multi-temporal change analysis. Output interpretation reveals edge preservation via reduced filtering near transitions: boundary pixels retain greater variance than distant pixels. Multi-scale adaptation becomes apparent via histogram analysis showing pronounced peaks corresponding to scene classes. Output ranges match input; comparison with standard Lee shows reduced edge blur and maintained target sharpness. Edge detection quality directly impacts output: strong edges enable good boundary preservation; weak edges may induce over-smoothing. Statistics show controlled variance reduction balancing noise suppression against detail preservation. Common artifacts include potential blocky appearance if multi-scale transitions become visible and over-preservation if edge detection is too aggressive. Monitor edge map quality to validate filtering behavior. Apply in comprehensive SAR analysis pipelines where multiple features must be preserved and edges must remain sharp, particularly important for machine learning preprocessing requiring training data with clear feature boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$enhanced_lee_filter(...)
}

wbw_enhanced_lee_filter <- function(...) {
  # The Enhanced Lee filter combines Lee's multiplicative model with refined variance estimation and multi-scale processing, achieving superior speckle reduction while preserving fine details and edges in SAR imagery. Implementation employs local statistics computed via windows of adaptive size, incorporates Laplacian-based edge detection, and applies spatially-varying filter parameters. The enhanced formulation applies: F = μ + w·(I - μ) where w adapts to edge proximity: w→0 near edges (minimal filtering), w→1 in homogeneous regions (aggressive filtering). Key features include edge-adaptive processing (preserving boundaries), multi-scale parameter adaptation, improved target preservation versus standard Lee, and effectiveness on high-noise SAR. Enhanced Lee filtering excels in complex SAR scenes with numerous features, flood-mapping applications where edge localization is critical, building detection from urban SAR, and multi-temporal change analysis. Output interpretation reveals edge preservation via reduced filtering near transitions: boundary pixels retain greater variance than distant pixels. Multi-scale adaptation becomes apparent via histogram analysis showing pronounced peaks corresponding to scene classes. Output ranges match input; comparison with standard Lee shows reduced edge blur and maintained target sharpness. Edge detection quality directly impacts output: strong edges enable good boundary preservation; weak edges may induce over-smoothing. Statistics show controlled variance reduction balancing noise suppression against detail preservation. Common artifacts include potential blocky appearance if multi-scale transitions become visible and over-preservation if edge detection is too aggressive. Monitor edge map quality to validate filtering behavior. Apply in comprehensive SAR analysis pipelines where multiple features must be preserved and edges must remain sharp, particularly important for machine learning preprocessing requiring training data with clear feature boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$enhanced_lee_filter(...)
}

envelope_test <- function(...) {
  # Performs Monte Carlo envelope testing comparing observed pattern to CSR null distribution. Determines significance of clustering/dispersion.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$envelope_test(...)
}

wbw_envelope_test <- function(...) {
  # Performs Monte Carlo envelope testing comparing observed pattern to CSR null distribution. Determines significance of clustering/dispersion.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$envelope_test(...)
}

equal_to <- function(...) {
  # Tests whether two rasters are equal on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$equal_to(...)
}

wbw_equal_to <- function(...) {
  # Tests whether two rasters are equal on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$equal_to(...)
}

erase <- function(...) {
  # Erases overlay polygon areas from input polygons and preserves input attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$erase(...)
}

wbw_erase <- function(...) {
  # Erases overlay polygon areas from input polygons and preserves input attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$erase(...)
}

erase_polygon_from_lidar <- function(...) {
  # Removes LiDAR points that fall within polygon geometry.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$erase_polygon_from_lidar(...)
}

wbw_erase_polygon_from_lidar <- function(...) {
  # Removes LiDAR points that fall within polygon geometry.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$erase_polygon_from_lidar(...)
}

erase_polygon_from_raster <- function(...) {
  # Sets raster cells inside polygons to NoData while preserving cells in polygon holes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$erase_polygon_from_raster(...)
}

wbw_erase_polygon_from_raster <- function(...) {
  # Sets raster cells inside polygons to NoData while preserving cells in polygon holes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$erase_polygon_from_raster(...)
}

estimate_variogram <- function(...) {
  # Computes an empirical semivariogram from point observations to characterize spatial correlation structure. Essential first step in geostatistical workflow.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$estimate_variogram(...)
}

wbw_estimate_variogram <- function(...) {
  # Computes an empirical semivariogram from point observations to characterize spatial correlation structure. Essential first step in geostatistical workflow.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$estimate_variogram(...)
}

euclidean_allocation <- function(...) {
  # Assigns each valid cell the value of its nearest non-zero target cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$euclidean_allocation(...)
}

wbw_euclidean_allocation <- function(...) {
  # Assigns each valid cell the value of its nearest non-zero target cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$euclidean_allocation(...)
}

euclidean_distance <- function(...) {
  # Computes Euclidean distance to nearest non-zero target cell in a raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$euclidean_distance(...)
}

wbw_euclidean_distance <- function(...) {
  # Computes Euclidean distance to nearest non-zero target cell in a raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$euclidean_distance(...)
}

evaluate_object_classification_accuracy <- function(...) {
  # Computes classification accuracy metrics comparing predicted object labels against reference ground-truth or validation labels. Generates confusion matrix documenting classification agreement/disagreement patterns per class, calculates overall accuracy (total correct predictions), per-class producer's accuracy (detection rate), user's accuracy (reliability), F1-score (harmonic mean), kappa statistic (chance-corrected agreement), and class-specific error analysis identifying systematic misclassification patterns. Key features include comprehensive accuracy assessment across all classes, per-class performance metrics enabling class-specific diagnostics, confusion matrix revealing systematic misclassification patterns, statistical significance testing through kappa coefficient, natural handling of imbalanced class distributions, and identification of training data adequacy issues. Use cases include classification model validation and performance quantification, comparison of competing classification approaches and parameters, identification of problematic object classes requiring additional training, assessment of classification suitability for operational applications, accuracy-based model selection and hyperparameter tuning, quality assurance in automated mapping workflows, and reporting standardized accuracy metrics for peer review. Output overall accuracy represents classification reliability across all objects; producer's accuracy indicates detection completeness per class; user's accuracy indicates prediction reliability; high kappa (>0.8) indicates strong beyond-chance agreement; confusion matrix reveals which classes are confused with each other; diagonal dominance indicates strong class separation; off-diagonal entries pinpoint misclassification sources; class-specific metrics guide targeted training improvement.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$evaluate_object_classification_accuracy(...)
}

wbw_evaluate_object_classification_accuracy <- function(...) {
  # Computes classification accuracy metrics comparing predicted object labels against reference ground-truth or validation labels. Generates confusion matrix documenting classification agreement/disagreement patterns per class, calculates overall accuracy (total correct predictions), per-class producer's accuracy (detection rate), user's accuracy (reliability), F1-score (harmonic mean), kappa statistic (chance-corrected agreement), and class-specific error analysis identifying systematic misclassification patterns. Key features include comprehensive accuracy assessment across all classes, per-class performance metrics enabling class-specific diagnostics, confusion matrix revealing systematic misclassification patterns, statistical significance testing through kappa coefficient, natural handling of imbalanced class distributions, and identification of training data adequacy issues. Use cases include classification model validation and performance quantification, comparison of competing classification approaches and parameters, identification of problematic object classes requiring additional training, assessment of classification suitability for operational applications, accuracy-based model selection and hyperparameter tuning, quality assurance in automated mapping workflows, and reporting standardized accuracy metrics for peer review. Output overall accuracy represents classification reliability across all objects; producer's accuracy indicates detection completeness per class; user's accuracy indicates prediction reliability; high kappa (>0.8) indicates strong beyond-chance agreement; confusion matrix reveals which classes are confused with each other; diagonal dominance indicates strong class separation; off-diagonal entries pinpoint misclassification sources; class-specific metrics guide targeted training improvement.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$evaluate_object_classification_accuracy(...)
}

evaluate_segmentation_quality_pro <- function(...) {
  # Computes segmentation quality diagnostics including object-count and dominant-label overlap statistics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$evaluate_segmentation_quality_pro(...)
}

wbw_evaluate_segmentation_quality_pro <- function(...) {
  # Computes segmentation quality diagnostics including object-count and dominant-label overlap statistics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$evaluate_segmentation_quality_pro(...)
}

evaluate_training_sites <- function(...) {
  # Evaluates class separability in multi-band training polygons and writes an HTML report with per-band distribution statistics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$evaluate_training_sites(...)
}

wbw_evaluate_training_sites <- function(...) {
  # Evaluates class separability in multi-band training polygons and writes an HTML report with per-band distribution statistics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$evaluate_training_sites(...)
}

exp <- function(...) {
  # Computes e raised to the power of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$exp(...)
}

wbw_exp <- function(...) {
  # Computes e raised to the power of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$exp(...)
}

exp2 <- function(...) {
  # Computes 2 raised to the power of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$exp2(...)
}

wbw_exp2 <- function(...) {
  # Computes 2 raised to the power of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$exp2(...)
}

export_table_to_csv <- function(...) {
  # Exports a vector attribute table to a CSV file.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$export_table_to_csv(...)
}

wbw_export_table_to_csv <- function(...) {
  # Exports a vector attribute table to a CSV file.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$export_table_to_csv(...)
}

exposure_towards_wind_flux <- function(...) {
  # Calculates terrain exposure relative to dominant wind direction and upwind horizon shielding.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$exposure_towards_wind_flux(...)
}

wbw_exposure_towards_wind_flux <- function(...) {
  # Calculates terrain exposure relative to dominant wind direction and upwind horizon shielding.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$exposure_towards_wind_flux(...)
}

extend_vector_lines <- function(...) {
  # Extends polyline endpoints by a specified distance at the start, end, or both.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extend_vector_lines(...)
}

wbw_extend_vector_lines <- function(...) {
  # Extends polyline endpoints by a specified distance at the start, end, or both.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extend_vector_lines(...)
}

extract_by_attribute <- function(...) {
  # Extracts vector features that satisfy an attribute expression.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_by_attribute(...)
}

wbw_extract_by_attribute <- function(...) {
  # Extracts vector features that satisfy an attribute expression.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_by_attribute(...)
}

extract_nodes <- function(...) {
  # Converts polyline and polygon vertices into point features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_nodes(...)
}

wbw_extract_nodes <- function(...) {
  # Converts polyline and polygon vertices into point features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_nodes(...)
}

extract_raster_values_at_points <- function(...) {
  # Samples one or more rasters at point locations and writes the values to point attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_raster_values_at_points(...)
}

wbw_extract_raster_values_at_points <- function(...) {
  # Samples one or more rasters at point locations and writes the values to point attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_raster_values_at_points(...)
}

extract_streams <- function(...) {
  # Extracts streams based on flow accumulation threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_streams(...)
}

wbw_extract_streams <- function(...) {
  # Extracts streams based on flow accumulation threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_streams(...)
}

extract_valleys <- function(...) {
  # Extracts valleys from DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_valleys(...)
}

wbw_extract_valleys <- function(...) {
  # Extracts valleys from DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$extract_valleys(...)
}

farthest_channel_head <- function(...) {
  # Calculates distance to most distant channel head.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$farthest_channel_head(...)
}

wbw_farthest_channel_head <- function(...) {
  # Calculates distance to most distant channel head.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$farthest_channel_head(...)
}

fast_almost_gaussian_filter <- function(...) {
  # The Fast Almost Gaussian filter provides rapid Gaussian-approximation smoothing via iterative separable box (averaging) filtering, achieving near-Gaussian blur response with O(N) computational complexity regardless of blur radius. Implementation applies successive box convolutions (each computing local pixel averages) to approximate cumulative Gaussian distribution; N iterations approximate increasingly larger Gaussian kernels. The mathematical basis uses the central limit theorem: repeated convolution of box functions approaches Gaussian distribution asymptotically. Key features include computational speed enabling large-kernel smoothing on big imagery, separable implementation reducing memory requirements, parameter control via iteration count (controls blur radius), and effectiveness on any data type. Fast Almost Gaussian filtering excels in rapid image pyramids for multi-scale analysis, real-time satellite imagery browsing, preprocessing enormous remote sensing datasets before classification, and interactive image viewers requiring responsive smoothing. Output interpretation shows that iteration count directly relates to blur radius: N=1 produces minimal smoothing; N=3-5 provides moderate blur; N>10 creates strong smoothing approximating large-kernel Gaussians. Output values progressively shift toward local mean as iterations increase; variance reduction follows predictable patterns. Remaining values stay within input data ranges. Comparison with true Gaussian filtering shows acceptable approximation within 2-5% error for most applications. Speed improvement over true Gaussian filtering increases dramatically at large radii: 5-20× faster for radius >20 pixels. Minor artifacts include subtle waviness along edges (box artifacts accumulating across iterations) and slightly different boundary handling than Gaussian. Monitor output histograms for multimodal distributions indicating sufficient smoothing. Apply in image preprocessing pipelines where speed justifies minor approximation errors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fast_almost_gaussian_filter(...)
}

wbw_fast_almost_gaussian_filter <- function(...) {
  # The Fast Almost Gaussian filter provides rapid Gaussian-approximation smoothing via iterative separable box (averaging) filtering, achieving near-Gaussian blur response with O(N) computational complexity regardless of blur radius. Implementation applies successive box convolutions (each computing local pixel averages) to approximate cumulative Gaussian distribution; N iterations approximate increasingly larger Gaussian kernels. The mathematical basis uses the central limit theorem: repeated convolution of box functions approaches Gaussian distribution asymptotically. Key features include computational speed enabling large-kernel smoothing on big imagery, separable implementation reducing memory requirements, parameter control via iteration count (controls blur radius), and effectiveness on any data type. Fast Almost Gaussian filtering excels in rapid image pyramids for multi-scale analysis, real-time satellite imagery browsing, preprocessing enormous remote sensing datasets before classification, and interactive image viewers requiring responsive smoothing. Output interpretation shows that iteration count directly relates to blur radius: N=1 produces minimal smoothing; N=3-5 provides moderate blur; N>10 creates strong smoothing approximating large-kernel Gaussians. Output values progressively shift toward local mean as iterations increase; variance reduction follows predictable patterns. Remaining values stay within input data ranges. Comparison with true Gaussian filtering shows acceptable approximation within 2-5% error for most applications. Speed improvement over true Gaussian filtering increases dramatically at large radii: 5-20× faster for radius >20 pixels. Minor artifacts include subtle waviness along edges (box artifacts accumulating across iterations) and slightly different boundary handling than Gaussian. Monitor output histograms for multimodal distributions indicating sufficient smoothing. Apply in image preprocessing pipelines where speed justifies minor approximation errors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fast_almost_gaussian_filter(...)
}

fd8_flow_accum <- function(...) {
  # Calculates FD8 flow accumulation from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fd8_flow_accum(...)
}

wbw_fd8_flow_accum <- function(...) {
  # Calculates FD8 flow accumulation from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fd8_flow_accum(...)
}

fd8_pointer <- function(...) {
  # Fractional flow to multiple downslope neighbors weighted by gradient. Better than D8 for dispersive, diffusive processes and mass conservation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fd8_pointer(...)
}

wbw_fd8_pointer <- function(...) {
  # Fractional flow to multiple downslope neighbors weighted by gradient. Better than D8 for dispersive, diffusive processes and mass conservation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fd8_pointer(...)
}

feature_preserving_smoothing <- function(...) {
  # Smooths DEM roughness while preserving breaks-in-slope using normal-vector filtering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$feature_preserving_smoothing(...)
}

wbw_feature_preserving_smoothing <- function(...) {
  # Smooths DEM roughness while preserving breaks-in-slope using normal-vector filtering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$feature_preserving_smoothing(...)
}

feature_preserving_smoothing_multiscale <- function(...) {
  # Smooths DEM roughness with a multiscale coarse-to-fine continuation. Each scale re-derives normals, applies adaptive robust normal-field diffusion, and reconstructs elevations with a screened Poisson solve.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$feature_preserving_smoothing_multiscale(...)
}

wbw_feature_preserving_smoothing_multiscale <- function(...) {
  # Smooths DEM roughness with a multiscale coarse-to-fine continuation. Each scale re-derives normals, applies adaptive robust normal-field diffusion, and reconstructs elevations with a screened Poisson solve.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$feature_preserving_smoothing_multiscale(...)
}

fetch_analysis <- function(...) {
  # Computes upwind distance to the first topographic obstacle along a specified azimuth.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fetch_analysis(...)
}

wbw_fetch_analysis <- function(...) {
  # Computes upwind distance to the first topographic obstacle along a specified azimuth.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fetch_analysis(...)
}

fft_random_field <- function(...) {
  # Creates a spatially-autocorrelated random field using FFT spectral synthesis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fft_random_field(...)
}

wbw_fft_random_field <- function(...) {
  # Creates a spatially-autocorrelated random field using FFT spectral synthesis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fft_random_field(...)
}

field_calculator <- function(...) {
  # Calculates a field value from an expression using feature attributes and geometry variables; supports SQL-style CASE, CAST, null checks, and UPDATE ... SET ... [WHERE ...] wrappers.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$field_calculator(...)
}

wbw_field_calculator <- function(...) {
  # Calculates a field value from an expression using feature attributes and geometry variables; supports SQL-style CASE, CAST, null checks, and UPDATE ... SET ... [WHERE ...] wrappers.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$field_calculator(...)
}

fill_burn <- function(...) {
  # Hydro-enforces a DEM by burning streams and then filling depressions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_burn(...)
}

wbw_fill_burn <- function(...) {
  # Hydro-enforces a DEM by burning streams and then filling depressions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_burn(...)
}

fill_depressions <- function(...) {
  # Fills depressions in a DEM using a priority-flood strategy with Garbrecht-Martz flat resolution by default and optional legacy natural-path flat resolution.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_depressions(...)
}

wbw_fill_depressions <- function(...) {
  # Fills depressions in a DEM using a priority-flood strategy with Garbrecht-Martz flat resolution by default and optional legacy natural-path flat resolution.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_depressions(...)
}

fill_depressions_planchon_and_darboux <- function(...) {
  # Fills depressions in a DEM with a Planchon-and-Darboux-compatible interface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_depressions_planchon_and_darboux(...)
}

wbw_fill_depressions_planchon_and_darboux <- function(...) {
  # Fills depressions in a DEM with a Planchon-and-Darboux-compatible interface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_depressions_planchon_and_darboux(...)
}

fill_depressions_wang_and_liu <- function(...) {
  # Fills depressions in a DEM with a Wang-and-Liu-compatible interface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_depressions_wang_and_liu(...)
}

wbw_fill_depressions_wang_and_liu <- function(...) {
  # Fills depressions in a DEM with a Wang-and-Liu-compatible interface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_depressions_wang_and_liu(...)
}

fill_missing_data <- function(...) {
  # Fills NoData gaps using inverse-distance weighting from valid gap-edge cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_missing_data(...)
}

wbw_fill_missing_data <- function(...) {
  # Fills NoData gaps using inverse-distance weighting from valid gap-edge cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_missing_data(...)
}

fill_pits <- function(...) {
  # Fills single-cell pits in a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_pits(...)
}

wbw_fill_pits <- function(...) {
  # Fills single-cell pits in a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fill_pits(...)
}

filter_lidar <- function(...) {
  # Removes points via expression: boolean logic on attributes (class, elevation, return_number, scan_angle, noise_flag, etc). Flexible point selection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar(...)
}

wbw_filter_lidar <- function(...) {
  # Removes points via expression: boolean logic on attributes (class, elevation, return_number, scan_angle, noise_flag, etc). Flexible point selection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar(...)
}

filter_lidar_by_percentile <- function(...) {
  # Selects percentile-rank point per cell: retains one point per grid block at specified elevation percentile. Representative-sample decimation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_by_percentile(...)
}

wbw_filter_lidar_by_percentile <- function(...) {
  # Selects percentile-rank point per cell: retains one point per grid block at specified elevation percentile. Representative-sample decimation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_by_percentile(...)
}

filter_lidar_by_reference_surface <- function(...) {
  # Extracts points relative to reference surface: z<surface, z>surface, or within threshold. Identifies vegetation above DTM or subsurface points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_by_reference_surface(...)
}

wbw_filter_lidar_by_reference_surface <- function(...) {
  # Extracts points relative to reference surface: z<surface, z>surface, or within threshold. Identifies vegetation above DTM or subsurface points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_by_reference_surface(...)
}

filter_lidar_classes <- function(...) {
  # Removes points by classification: filters out unwanted LAS classes (noise, water, buildings, etc). Essential pre-processing for terrain conditioning workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_classes(...)
}

wbw_filter_lidar_classes <- function(...) {
  # Removes points by classification: filters out unwanted LAS classes (noise, water, buildings, etc). Essential pre-processing for terrain conditioning workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_classes(...)
}

filter_lidar_noise <- function(...) {
  # Removes ASPRS noise classes: filters class 7 (low noise) and class 18 (high noise). Standard point-cloud cleaning for LAS 1.4 compliant data.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_noise(...)
}

wbw_filter_lidar_noise <- function(...) {
  # Removes ASPRS noise classes: filters class 7 (low noise) and class 18 (high noise). Standard point-cloud cleaning for LAS 1.4 compliant data.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_noise(...)
}

filter_lidar_scan_angles <- function(...) {
  # Removes oblique LiDAR returns: filters points by scan-angle threshold. Improves vertical accuracy by removing grazing-angle returns with positional error.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_scan_angles(...)
}

wbw_filter_lidar_scan_angles <- function(...) {
  # Removes oblique LiDAR returns: filters points by scan-angle threshold. Improves vertical accuracy by removing grazing-angle returns with positional error.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_lidar_scan_angles(...)
}

filter_raster_features_by_area <- function(...) {
  # Removes integer-labelled raster features smaller than a cell-count threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_raster_features_by_area(...)
}

wbw_filter_raster_features_by_area <- function(...) {
  # Removes integer-labelled raster features smaller than a cell-count threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_raster_features_by_area(...)
}

filter_vector_features_by_area <- function(...) {
  # Filters polygon features below a minimum area threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_vector_features_by_area(...)
}

wbw_filter_vector_features_by_area <- function(...) {
  # Filters polygon features below a minimum area threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$filter_vector_features_by_area(...)
}

find_flightline_edge_points <- function(...) {
  # Filters flight-edge points: extracts only points at acquisition swath boundaries. QA for strip overlap and edge effects.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_flightline_edge_points(...)
}

wbw_find_flightline_edge_points <- function(...) {
  # Filters flight-edge points: extracts only points at acquisition swath boundaries. QA for strip overlap and edge effects.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_flightline_edge_points(...)
}

find_lowest_or_highest_points <- function(...) {
  # Locates lowest and/or highest raster cells and outputs their locations as points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_lowest_or_highest_points(...)
}

wbw_find_lowest_or_highest_points <- function(...) {
  # Locates lowest and/or highest raster cells and outputs their locations as points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_lowest_or_highest_points(...)
}

find_main_stem <- function(...) {
  # Identifies main stem of stream network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_main_stem(...)
}

wbw_find_main_stem <- function(...) {
  # Identifies main stem of stream network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_main_stem(...)
}

find_noflow_cells <- function(...) {
  # Finds DEM cells that have no lower D8 neighbour.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_noflow_cells(...)
}

wbw_find_noflow_cells <- function(...) {
  # Finds DEM cells that have no lower D8 neighbour.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_noflow_cells(...)
}

find_parallel_flow <- function(...) {
  # Identifies stream cells that possess parallel D8 flow directions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_parallel_flow(...)
}

wbw_find_parallel_flow <- function(...) {
  # Identifies stream cells that possess parallel D8 flow directions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_parallel_flow(...)
}

find_patch_edge_cells <- function(...) {
  # Identifies edge cells for each positive raster patch ID; non-edge patch cells are set to zero.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_patch_edge_cells(...)
}

wbw_find_patch_edge_cells <- function(...) {
  # Identifies edge cells for each positive raster patch ID; non-edge patch cells are set to zero.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_patch_edge_cells(...)
}

find_ridges <- function(...) {
  # Identifies potential ridge and peak cells in a DEM, with optional line thinning.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_ridges(...)
}

wbw_find_ridges <- function(...) {
  # Identifies potential ridge and peak cells in a DEM, with optional line thinning.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$find_ridges(...)
}

fit_variogram <- function(...) {
  # Fits theoretical variogram model (Spherical, Exponential, Gaussian) to empirical semivariogram data for use in kriging.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fit_variogram(...)
}

wbw_fit_variogram <- function(...) {
  # Fits theoretical variogram model (Spherical, Exponential, Gaussian) to empirical semivariogram data for use in kriging.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fit_variogram(...)
}

fix_dangling_arcs <- function(...) {
  # Fixes undershot and overshot dangling arcs in a line network by snapping line endpoints within a threshold distance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fix_dangling_arcs(...)
}

wbw_fix_dangling_arcs <- function(...) {
  # Fixes undershot and overshot dangling arcs in a line network by snapping line endpoints within a threshold distance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fix_dangling_arcs(...)
}

flatten_lakes <- function(...) {
  # Flattens lake elevations using minimum perimeter elevation for each polygon.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flatten_lakes(...)
}

wbw_flatten_lakes <- function(...) {
  # Flattens lake elevations using minimum perimeter elevation for each polygon.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flatten_lakes(...)
}

flightline_overlap <- function(...) {
  # Detects acquisition overlaps: counts distinct point-source IDs per cell. Grid-based overlap visualization for flight-line coverage assessment.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flightline_overlap(...)
}

wbw_flightline_overlap <- function(...) {
  # Detects acquisition overlaps: counts distinct point-source IDs per cell. Grid-based overlap visualization for flight-line coverage assessment.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flightline_overlap(...)
}

flip_image <- function(...) {
  # Flips an image vertically, horizontally, or both.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flip_image(...)
}

wbw_flip_image <- function(...) {
  # Flips an image vertically, horizontally, or both.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flip_image(...)
}

flood_order <- function(...) {
  # Outputs the sequential priority-flood order for each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flood_order(...)
}

wbw_flood_order <- function(...) {
  # Outputs the sequential priority-flood order for each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flood_order(...)
}

floor <- function(...) {
  # Rounds each raster cell downward to the nearest integer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$floor(...)
}

wbw_floor <- function(...) {
  # Rounds each raster cell downward to the nearest integer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$floor(...)
}

flow_accum_full_workflow <- function(...) {
  # Runs a full non-divergent flow-accumulation workflow and returns breached DEM, flow-direction pointer, and accumulation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flow_accum_full_workflow(...)
}

wbw_flow_accum_full_workflow <- function(...) {
  # Runs a full non-divergent flow-accumulation workflow and returns breached DEM, flow-direction pointer, and accumulation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flow_accum_full_workflow(...)
}

flow_length_diff <- function(...) {
  # Computes local maximum absolute differences in downslope path length from a D8 pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flow_length_diff(...)
}

wbw_flow_length_diff <- function(...) {
  # Computes local maximum absolute differences in downslope path length from a D8 pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$flow_length_diff(...)
}

frangi_filter <- function(...) {
  # Performs multiscale Frangi vesselness enhancement for detecting vessel-like (tubular) structures at multiple scales. Based on Hessian matrix eigenvalue analysis. Responds strongly to line-like features (vessels, roads, rivers) and weakly to blob-like structures. Multiscale analysis (try multiple sigma values) automatically detects vessels at different widths. Widely used in medical imaging and remote sensing for linear feature detection. Frangi vesselness uses principal curvatures (Hessian eigenvalues) to classify local structure: high vesselness for linear features, low for plateaus or blobs. Multiscale implementation applies at multiple sigma (width) values, combines responses. Excellent for detecting roads, rivers, vessel networks. Computationally moderate for multiple scales. Highly interpretable output—responds to recognizable features. Applications: (1) Road detection in satellite imagery, (2) River/stream network extraction, (3) Linear feature detection generally, (4) Vessel detection (medical imaging), (5) Multi-scale structure detection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$frangi_filter(...)
}

wbw_frangi_filter <- function(...) {
  # Performs multiscale Frangi vesselness enhancement for detecting vessel-like (tubular) structures at multiple scales. Based on Hessian matrix eigenvalue analysis. Responds strongly to line-like features (vessels, roads, rivers) and weakly to blob-like structures. Multiscale analysis (try multiple sigma values) automatically detects vessels at different widths. Widely used in medical imaging and remote sensing for linear feature detection. Frangi vesselness uses principal curvatures (Hessian eigenvalues) to classify local structure: high vesselness for linear features, low for plateaus or blobs. Multiscale implementation applies at multiple sigma (width) values, combines responses. Excellent for detecting roads, rivers, vessel networks. Computationally moderate for multiple scales. Highly interpretable output—responds to recognizable features. Applications: (1) Road detection in satellite imagery, (2) River/stream network extraction, (3) Linear feature detection generally, (4) Vessel detection (medical imaging), (5) Multi-scale structure detection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$frangi_filter(...)
}

freeman_durden_decomposition <- function(...) {
  # Freeman-Durden decomposition quantifies scattering mechanism contributions from quad-polarimetric SAR via orthogonal basis decomposition into surface reflection, double-bounce (urban/dihedral), and volume (vegetation/random media) components. Non-negative least-squares optimization constrains power fractions ensuring physical realizability and interpretability. Output power maps directly linked to terrain properties: high surface dominance indicates bare soil/water, high double-bounce indicates urban structures, high volume indicates forest/vegetation. Key Features: Physically interpretable scattering components; terrain-specific signatures; constrained optimization; supports quad-polarimetric SAR; robust to speckle; enables target-specific classification. Use Cases: Urban-rural classification; forest biomass estimation; soil moisture detection; flooding detection; crop phenology monitoring; landcover mapping. Output Interpretation: Surface power indicates specular reflection from dry terrain/water; double-bounce power indicates man-made structures/urban areas; volume power indicates vegetation/forest. Component combinations enable landcover discrimination: high volume + low double-bounce indicates forest; high double-bounce + low volume indicates urban; balanced surface/volume indicates mixed terrain.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$freeman_durden_decomposition(...)
}

wbw_freeman_durden_decomposition <- function(...) {
  # Freeman-Durden decomposition quantifies scattering mechanism contributions from quad-polarimetric SAR via orthogonal basis decomposition into surface reflection, double-bounce (urban/dihedral), and volume (vegetation/random media) components. Non-negative least-squares optimization constrains power fractions ensuring physical realizability and interpretability. Output power maps directly linked to terrain properties: high surface dominance indicates bare soil/water, high double-bounce indicates urban structures, high volume indicates forest/vegetation. Key Features: Physically interpretable scattering components; terrain-specific signatures; constrained optimization; supports quad-polarimetric SAR; robust to speckle; enables target-specific classification. Use Cases: Urban-rural classification; forest biomass estimation; soil moisture detection; flooding detection; crop phenology monitoring; landcover mapping. Output Interpretation: Surface power indicates specular reflection from dry terrain/water; double-bounce power indicates man-made structures/urban areas; volume power indicates vegetation/forest. Component combinations enable landcover discrimination: high volume + low double-bounce indicates forest; high double-bounce + low volume indicates urban; balanced surface/volume indicates mixed terrain.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$freeman_durden_decomposition(...)
}

frost_filter <- function(...) {
  # The Frost filter implements SAR speckle reduction using multiplicative noise model and adaptive local statistics, designed specifically for radar imagery where speckle follows Gamma distribution rather than Gaussian noise. Implementation computes local mean and variance, then applies adaptive multiplicative weighting: F = I · exp(-variance/(2·mean²)·distance²), where distance measures pixel deviation from local mean. This formulation reduces speckle intensity inversely to estimated coherence. Key features include SAR-specific adaptation (multiplicative rather than additive noise model), preservation of point targets and edges (coherent features), local variance-driven adaptation enabling strength adjustment, and proven effectiveness on single-pol and multi-pol SAR data. Frost filtering excels in SAR image preprocessing for classification (agricultural monitoring, land-use mapping), coherence-weighted SAR-optical fusion, flood mapping from radar during cloud cover, and synthetic aperture radar change detection workflows. Output interpretation shows that high-variance (potentially coherent target) regions filter minimally; low-variance (speckle-dominated) regions filter aggressively. Typical output ranges match input; logarithmic scaling (decibels) often applied pre- or post-filtering for visualization. Variance-to-mean ratio directly controls filter strength: ratio > 0.5 indicates probable speckle; ratio < 0.1 suggests coherent targets. Output artifacts include potential detail loss if variance estimation is unreliable and directional bias in oriented features. Verification via coherence maps confirms edge preservation in high-coherence zones. Monitor output statistics: mean should stabilize across filtering iterations; variance should decrease substantially. Apply before classification to improve categorical accuracy. Combine with morphological post-processing to refine object boundaries and remove residual speckle chips.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$frost_filter(...)
}

wbw_frost_filter <- function(...) {
  # The Frost filter implements SAR speckle reduction using multiplicative noise model and adaptive local statistics, designed specifically for radar imagery where speckle follows Gamma distribution rather than Gaussian noise. Implementation computes local mean and variance, then applies adaptive multiplicative weighting: F = I · exp(-variance/(2·mean²)·distance²), where distance measures pixel deviation from local mean. This formulation reduces speckle intensity inversely to estimated coherence. Key features include SAR-specific adaptation (multiplicative rather than additive noise model), preservation of point targets and edges (coherent features), local variance-driven adaptation enabling strength adjustment, and proven effectiveness on single-pol and multi-pol SAR data. Frost filtering excels in SAR image preprocessing for classification (agricultural monitoring, land-use mapping), coherence-weighted SAR-optical fusion, flood mapping from radar during cloud cover, and synthetic aperture radar change detection workflows. Output interpretation shows that high-variance (potentially coherent target) regions filter minimally; low-variance (speckle-dominated) regions filter aggressively. Typical output ranges match input; logarithmic scaling (decibels) often applied pre- or post-filtering for visualization. Variance-to-mean ratio directly controls filter strength: ratio > 0.5 indicates probable speckle; ratio < 0.1 suggests coherent targets. Output artifacts include potential detail loss if variance estimation is unreliable and directional bias in oriented features. Verification via coherence maps confirms edge preservation in high-coherence zones. Monitor output statistics: mean should stabilize across filtering iterations; variance should decrease substantially. Apply before classification to improve categorical accuracy. Combine with morphological post-processing to refine object boundaries and remove residual speckle chips.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$frost_filter(...)
}

fuzzy_knn_classification <- function(...) {
  # Performs fuzzy k-nearest-neighbor classification and outputs class membership confidence.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fuzzy_knn_classification(...)
}

wbw_fuzzy_knn_classification <- function(...) {
  # Performs fuzzy k-nearest-neighbor classification and outputs class membership confidence.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$fuzzy_knn_classification(...)
}

gabor_filter_bank <- function(...) {
  # Performs multi-orientation Gabor response filtering—directional texture analysis. Applies bank of Gabor filters at multiple orientations (typically 0°, 45°, 90°, 135°) to extract directional texture features. Gabor responses indicate texture strength and orientation. Useful for directional feature detection, texture characterization, and oriented pattern analysis. Each orientation is output separately. Gabor filtering extracts directional texture by convolving with orientation-specific wavelets. Each orientation reveals features aligned with that direction. Outputs multiple bands (one per orientation) revealing local texture direction and strength. Gabor responses are foundational for texture feature extraction and object detection in computer vision. Bank of filters enables comprehensive directional analysis. Applications: (1) Directional texture analysis, (2) Oriented feature detection (ridges, valleys, linear structures), (3) Directional erosion/deposition mapping, (4) Road/stream detection (linear features), (5) Texture-based classification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gabor_filter_bank(...)
}

wbw_gabor_filter_bank <- function(...) {
  # Performs multi-orientation Gabor response filtering—directional texture analysis. Applies bank of Gabor filters at multiple orientations (typically 0°, 45°, 90°, 135°) to extract directional texture features. Gabor responses indicate texture strength and orientation. Useful for directional feature detection, texture characterization, and oriented pattern analysis. Each orientation is output separately. Gabor filtering extracts directional texture by convolving with orientation-specific wavelets. Each orientation reveals features aligned with that direction. Outputs multiple bands (one per orientation) revealing local texture direction and strength. Gabor responses are foundational for texture feature extraction and object detection in computer vision. Bank of filters enables comprehensive directional analysis. Applications: (1) Directional texture analysis, (2) Oriented feature detection (ridges, valleys, linear structures), (3) Directional erosion/deposition mapping, (4) Road/stream detection (linear features), (5) Texture-based classification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gabor_filter_bank(...)
}

gamma_correction <- function(...) {
  # Gamma correction applies non-linear brightness adjustment via power-law transformation to optimize image contrast, display fidelity, and perceptual luminance distribution. The mathematical transformation is I_corrected = I^(1/γ), where γ (gamma) is a user-specified exponent controlling brightness adjustment direction and magnitude. Values γ > 1 darken images (brightening display compensation), while γ < 1 brighten images (darkening display compensation). Implementation operates independently on each pixel or spectral band, preserving spatial relationships while adjusting intensity scaling. Key features include preserving image structure while redistributing tonal values, computational efficiency requiring only lookup tables, applicability to any radiometric data including 16/32-bit imagery, and reversibility enabling inverse correction. Gamma correction finds essential application in preparing satellite imagery for visual interpretation by compensating sensor characteristics, normalizing orthophoto brightness across flight lines or sensor types, enhancing thermal imagery for feature visibility, and pre-processing multispectral data for machine-learning pipelines where input normalization improves convergence. Output interpretation shows that corrected values follow power-law scaling: mid-tones undergo greatest relative adjustment, while extremes compress less. For 8-bit input (0-255), typical gamma 0.4-0.6 brightens images significantly; gamma 1.4-1.6 darkens substantially. Histogram shapes transform predictably: left-skewed histograms (dark images) benefit from γ < 1, while right-skewed histograms (bright images) benefit from γ > 1. Verify corrected output using histogram visualization and visual inspection. Apply consistency across image collections requiring uniform preprocessing. Common workflow chains gamma correction before threshold selection or classification to ensure balanced feature visibility.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gamma_correction(...)
}

wbw_gamma_correction <- function(...) {
  # Gamma correction applies non-linear brightness adjustment via power-law transformation to optimize image contrast, display fidelity, and perceptual luminance distribution. The mathematical transformation is I_corrected = I^(1/γ), where γ (gamma) is a user-specified exponent controlling brightness adjustment direction and magnitude. Values γ > 1 darken images (brightening display compensation), while γ < 1 brighten images (darkening display compensation). Implementation operates independently on each pixel or spectral band, preserving spatial relationships while adjusting intensity scaling. Key features include preserving image structure while redistributing tonal values, computational efficiency requiring only lookup tables, applicability to any radiometric data including 16/32-bit imagery, and reversibility enabling inverse correction. Gamma correction finds essential application in preparing satellite imagery for visual interpretation by compensating sensor characteristics, normalizing orthophoto brightness across flight lines or sensor types, enhancing thermal imagery for feature visibility, and pre-processing multispectral data for machine-learning pipelines where input normalization improves convergence. Output interpretation shows that corrected values follow power-law scaling: mid-tones undergo greatest relative adjustment, while extremes compress less. For 8-bit input (0-255), typical gamma 0.4-0.6 brightens images significantly; gamma 1.4-1.6 darkens substantially. Histogram shapes transform predictably: left-skewed histograms (dark images) benefit from γ < 1, while right-skewed histograms (bright images) benefit from γ > 1. Verify corrected output using histogram visualization and visual inspection. Apply consistency across image collections requiring uniform preprocessing. Common workflow chains gamma correction before threshold selection or classification to ensure balanced feature visibility.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gamma_correction(...)
}

gamma_map_filter <- function(...) {
  # The Gamma Map filter performs SAR speckle reduction using Gamma distribution statistical model, explicitly accounting for radar signal's multiplicative speckle characteristics through parametric adaptation. Implementation estimates local Gamma distribution parameters (shape α and scale β) from image statistics, then filters via a weighting function respecting the distribution: F = I · [1 - (1-L/N)/(1 + L/N)·√(1 + N/L²)], where L is equivalent looks (coherence measure) and N is estimated parameter. Key features include theoretically rigorous SAR statistics (Gamma distribution standard for radar), automatic look-number estimation requiring minimal user input, superior edge preservation compared to uniform filters, and applicability to single- and multi-look SAR. Gamma Map filtering excels in multi-temporal SAR stack denoising for time-series change detection, interferometric SAR (InSAR) phase coherence enhancement, polarimetric SAR decomposition pre-processing, and forestry SAR backscatter normalization. Output interpretation reveals that filter strength adapts to scene coherence: high-coherence regions (large α) filter gently, preserving targets; low-coherence regions (small α) filter aggressively, suppressing speckle. Equivalent look-number L indicates filtering effectiveness: L=1 (minimal filtering) preserves all detail; L>5 produces substantial smoothing. Output scaling remains in input units; logarithmic conversion facilitates visualization. Typical output variance reductions range 50-80% depending on scene character and look-number selection. Monitor output histograms for remaining speckle signature; bi-modal distributions suggest good separation of scene components. Artifacts include potential striping in oriented features or slight texture degradation if L is overestimated. Validate filtering against ground truth in training areas. Apply strategically in polarimetric SAR classification or InSAR phase filtering requiring coherence-weighted enhancement.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gamma_map_filter(...)
}

wbw_gamma_map_filter <- function(...) {
  # The Gamma Map filter performs SAR speckle reduction using Gamma distribution statistical model, explicitly accounting for radar signal's multiplicative speckle characteristics through parametric adaptation. Implementation estimates local Gamma distribution parameters (shape α and scale β) from image statistics, then filters via a weighting function respecting the distribution: F = I · [1 - (1-L/N)/(1 + L/N)·√(1 + N/L²)], where L is equivalent looks (coherence measure) and N is estimated parameter. Key features include theoretically rigorous SAR statistics (Gamma distribution standard for radar), automatic look-number estimation requiring minimal user input, superior edge preservation compared to uniform filters, and applicability to single- and multi-look SAR. Gamma Map filtering excels in multi-temporal SAR stack denoising for time-series change detection, interferometric SAR (InSAR) phase coherence enhancement, polarimetric SAR decomposition pre-processing, and forestry SAR backscatter normalization. Output interpretation reveals that filter strength adapts to scene coherence: high-coherence regions (large α) filter gently, preserving targets; low-coherence regions (small α) filter aggressively, suppressing speckle. Equivalent look-number L indicates filtering effectiveness: L=1 (minimal filtering) preserves all detail; L>5 produces substantial smoothing. Output scaling remains in input units; logarithmic conversion facilitates visualization. Typical output variance reductions range 50-80% depending on scene character and look-number selection. Monitor output histograms for remaining speckle signature; bi-modal distributions suggest good separation of scene components. Artifacts include potential striping in oriented features or slight texture degradation if L is overestimated. Validate filtering against ground truth in training areas. Apply strategically in polarimetric SAR classification or InSAR phase filtering requiring coherence-weighted enhancement.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gamma_map_filter(...)
}

gaussian_contrast_stretch <- function(...) {
  # Stretches contrast by matching to a Gaussian reference distribution.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gaussian_contrast_stretch(...)
}

wbw_gaussian_contrast_stretch <- function(...) {
  # Stretches contrast by matching to a Gaussian reference distribution.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gaussian_contrast_stretch(...)
}

gaussian_curvature <- function(...) {
  # Calculates Gaussian (intrinsic) curvature (product of principal curvatures). Indicates local surface topology: positive (bowl/dome), negative (saddle), zero (cylindrical). Classifies terrain into landform categories: convex features (ridges), concave features (valleys), saddle features (passes/gaps). Used in advanced landform classification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gaussian_curvature(...)
}

wbw_gaussian_curvature <- function(...) {
  # Calculates Gaussian (intrinsic) curvature (product of principal curvatures). Indicates local surface topology: positive (bowl/dome), negative (saddle), zero (cylindrical). Classifies terrain into landform categories: convex features (ridges), concave features (valleys), saddle features (passes/gaps). Used in advanced landform classification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gaussian_curvature(...)
}

gaussian_filter <- function(...) {
  # Mathematically-optimal Gaussian smoothing with distance-weighted kernel. Foundational for multi-scale analysis, edge detection, band-pass filtering. Sigma parameter controls smoothing intensity; RGB-aware.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gaussian_filter(...)
}

wbw_gaussian_filter <- function(...) {
  # Mathematically-optimal Gaussian smoothing with distance-weighted kernel. Foundational for multi-scale analysis, edge detection, band-pass filtering. Sigma parameter controls smoothing intensity; RGB-aware.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$gaussian_filter(...)
}

generalize_classified_raster <- function(...) {
  # Generalize Classified Raster simplifies classification maps by removing small isolated patches through iterative mode filtering, merging fragmented single-pixel or multi-pixel components into spatially dominant neighboring classes. Algorithm: applies morphological mode filter preserving dominant class within moving windows, removes or consolidates pixels isolated from spatial context, iteratively refines classification through connected-component analysis, absorbs minor classes into neighboring dominant classes. Configurable window size and minimum patch size control generalization intensity. Key features: reduces classification fragmentation, improves spatial coherence, eliminates noise-induced isolated patches, maintains class boundaries through selective filtering, computationally efficient connected-component processing. Capabilities: variable generalization intensity, preservation of large contiguous patches, application to indexed or category data. Use cases: post-classification refinement removing salt-and-pepper effects, consolidating fragmented classification results, preparation of final classification products, generalization to specific minimum mapping unit. Applications: land cover map finalization, eliminating spurious single-pixel classifications, improving classification spatial continuity. Output interpretation: reduced class fragmentation indicates effective despeckling; preserved boundaries reveal appropriate generalization parameters; excessive generalization indicates oversized window parameters; spatial coherence improvement suggests classification noise was primarily single-pixel artifacts.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$generalize_classified_raster(...)
}

wbw_generalize_classified_raster <- function(...) {
  # Generalize Classified Raster simplifies classification maps by removing small isolated patches through iterative mode filtering, merging fragmented single-pixel or multi-pixel components into spatially dominant neighboring classes. Algorithm: applies morphological mode filter preserving dominant class within moving windows, removes or consolidates pixels isolated from spatial context, iteratively refines classification through connected-component analysis, absorbs minor classes into neighboring dominant classes. Configurable window size and minimum patch size control generalization intensity. Key features: reduces classification fragmentation, improves spatial coherence, eliminates noise-induced isolated patches, maintains class boundaries through selective filtering, computationally efficient connected-component processing. Capabilities: variable generalization intensity, preservation of large contiguous patches, application to indexed or category data. Use cases: post-classification refinement removing salt-and-pepper effects, consolidating fragmented classification results, preparation of final classification products, generalization to specific minimum mapping unit. Applications: land cover map finalization, eliminating spurious single-pixel classifications, improving classification spatial continuity. Output interpretation: reduced class fragmentation indicates effective despeckling; preserved boundaries reveal appropriate generalization parameters; excessive generalization indicates oversized window parameters; spatial coherence improvement suggests classification noise was primarily single-pixel artifacts.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$generalize_classified_raster(...)
}

generalize_with_similarity <- function(...) {
  # Generalizes small patches in a classified raster by merging them into the most spectrally similar neighboring patch.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$generalize_with_similarity(...)
}

wbw_generalize_with_similarity <- function(...) {
  # Generalizes small patches in a classified raster by merging them into the most spectrally similar neighboring patch.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$generalize_with_similarity(...)
}

generate_network_nodes <- function(...) {
  # Generates network nodes and node diagnostics from linework topology.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$generate_network_nodes(...)
}

wbw_generate_network_nodes <- function(...) {
  # Generates network nodes and node diagnostics from linework topology.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$generate_network_nodes(...)
}

generating_function <- function(...) {
  # Calculates generating function from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$generating_function(...)
}

wbw_generating_function <- function(...) {
  # Calculates generating function from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$generating_function(...)
}

geographically_weighted_regression <- function(...) {
  # Estimates location-specific regression coefficients revealing spatially-varying relationships. Detects spatial heterogeneity in predictor-response patterns.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$geographically_weighted_regression(...)
}

wbw_geographically_weighted_regression <- function(...) {
  # Estimates location-specific regression coefficients revealing spatially-varying relationships. Detects spatial heterogeneity in predictor-response patterns.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$geographically_weighted_regression(...)
}

geographically_weighted_regression_raster <- function(...) {
  # Estimates GWR and outputs local coefficient raster surfaces.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$geographically_weighted_regression_raster(...)
}

wbw_geographically_weighted_regression_raster <- function(...) {
  # Estimates GWR and outputs local coefficient raster surfaces.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$geographically_weighted_regression_raster(...)
}

geomorphons <- function(...) {
  # Classifies landforms using 8-direction line-of-sight ternary patterns derived from zenith and nadir angle comparisons, or 10 common geomorphon forms.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$geomorphons(...)
}

wbw_geomorphons <- function(...) {
  # Classifies landforms using 8-direction line-of-sight ternary patterns derived from zenith and nadir angle comparisons, or 10 common geomorphon forms.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$geomorphons(...)
}

georeference_raster_from_control_points <- function(...) {
  # Fits a transform from GCPs and warps a raster into georeferenced output.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$georeference_raster_from_control_points(...)
}

wbw_georeference_raster_from_control_points <- function(...) {
  # Fits a transform from GCPs and warps a raster into georeferenced output.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$georeference_raster_from_control_points(...)
}

getis_ord_gi_star <- function(...) {
  # Computes Getis-Ord Gi/Gi* z-scores for local hotspot/coldspot identification. Direct measure of high/low value concentration.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$getis_ord_gi_star(...)
}

wbw_getis_ord_gi_star <- function(...) {
  # Computes Getis-Ord Gi/Gi* z-scores for local hotspot/coldspot identification. Direct measure of high/low value concentration.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$getis_ord_gi_star(...)
}

getis_ord_gi_star_raster <- function(...) {
  # Computes Gi* hotspot/coldspot classifications from points and outputs raster (-1=cold, 0=NS, 1=hot). For hotspot-based analysis.\
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$getis_ord_gi_star_raster(...)
}

wbw_getis_ord_gi_star_raster <- function(...) {
  # Computes Gi* hotspot/coldspot classifications from points and outputs raster (-1=cold, 0=NS, 1=hot). For hotspot-based analysis.\
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$getis_ord_gi_star_raster(...)
}

glcm_texture <- function(...) {
  # The Gray-Level Co-occurrence Matrix (GLCM) texture analyzer extracts second-order statistical texture measures quantifying spatial relationships between pixel gray-level values at specified displacement distances and directions, enabling sophisticated texture classification distinguishing agricultural vegetation patterns, built-environment structures, and geological formations. GLCM computes probability matrices capturing how frequently gray-level pairs occur at fixed offsets, computing four canonical Haralick statistics: contrast (measuring local variation), correlation (measuring linear dependency), homogeneity (measuring closeness to diagonal), and energy (measuring uniformity). The tool supports eight directional offsets (0°, 45°, 90°, 135°, and their opposites) allowing directional texture sensitivity—detecting oriented patterns like field rows, building alignments, or geological structures. Key features include multi-directional analysis revealing anisotropic texture properties, displacement parameter tuning optimizing scale sensitivity, simultaneous computation of multiple texture measures reducing processing overhead, and inherent capability distinguishing visually subtle surface properties. Use cases span precision agriculture (crop type classification, field boundary detection, crop stress assessment), urban analysis (building density mapping, impervious surface extraction), and geological remote sensing (rock type discrimination, structural pattern recognition). Applications include land-cover classification combining spectral and textural features, object-based image analysis improving classification accuracy, quality control detecting instrumental artifacts in satellite imagery, and change detection isolating meaningful alterations from sensor noise. Output interpretation requires understanding each statistic's meaning: high contrast indicates rough/varied textures; high correlation indicates linear patterns; high homogeneity indicates uniform textures; high energy indicates orderly repetitive patterns. Output bands can be combined into texture indices (e.g., GLCM Homogeneity divided by Contrast enhances homogeneous areas). Directional aggregation modes (mean/min/max/separate) affect output dimensionality and interpretation. Typical texture analysis uses multiple GLCM measures simultaneously for robust classification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$glcm_texture(...)
}

wbw_glcm_texture <- function(...) {
  # The Gray-Level Co-occurrence Matrix (GLCM) texture analyzer extracts second-order statistical texture measures quantifying spatial relationships between pixel gray-level values at specified displacement distances and directions, enabling sophisticated texture classification distinguishing agricultural vegetation patterns, built-environment structures, and geological formations. GLCM computes probability matrices capturing how frequently gray-level pairs occur at fixed offsets, computing four canonical Haralick statistics: contrast (measuring local variation), correlation (measuring linear dependency), homogeneity (measuring closeness to diagonal), and energy (measuring uniformity). The tool supports eight directional offsets (0°, 45°, 90°, 135°, and their opposites) allowing directional texture sensitivity—detecting oriented patterns like field rows, building alignments, or geological structures. Key features include multi-directional analysis revealing anisotropic texture properties, displacement parameter tuning optimizing scale sensitivity, simultaneous computation of multiple texture measures reducing processing overhead, and inherent capability distinguishing visually subtle surface properties. Use cases span precision agriculture (crop type classification, field boundary detection, crop stress assessment), urban analysis (building density mapping, impervious surface extraction), and geological remote sensing (rock type discrimination, structural pattern recognition). Applications include land-cover classification combining spectral and textural features, object-based image analysis improving classification accuracy, quality control detecting instrumental artifacts in satellite imagery, and change detection isolating meaningful alterations from sensor noise. Output interpretation requires understanding each statistic's meaning: high contrast indicates rough/varied textures; high correlation indicates linear patterns; high homogeneity indicates uniform textures; high energy indicates orderly repetitive patterns. Output bands can be combined into texture indices (e.g., GLCM Homogeneity divided by Contrast enhances homogeneous areas). Directional aggregation modes (mean/min/max/separate) affect output dimensionality and interpretation. Typical texture analysis uses multiple GLCM measures simultaneously for robust classification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$glcm_texture(...)
}

global_morans_i <- function(...) {
  # Computes Global Moran's I to test spatial autocorrelation: whether similar values cluster spatially. Essential foundation for geostatistical analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$global_morans_i(...)
}

wbw_global_morans_i <- function(...) {
  # Computes Global Moran's I to test spatial autocorrelation: whether similar values cluster spatially. Essential foundation for geostatistical analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$global_morans_i(...)
}

greater_than <- function(...) {
  # Tests whether the first raster is greater than the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$greater_than(...)
}

wbw_greater_than <- function(...) {
  # Tests whether the first raster is greater than the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$greater_than(...)
}

greater_than_or_equal_to <- function(...) {
  # Tests whether the first raster is greater than or equal to the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$greater_than_or_equal_to(...)
}

wbw_greater_than_or_equal_to <- function(...) {
  # Tests whether the first raster is greater than or equal to the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$greater_than_or_equal_to(...)
}

guided_filter <- function(...) {
  # The guided filter implements edge-preserving smoothing by constraining filter outputs to locally linear relationships with a guide image, typically the original or a related reference layer. Implementation divides the image into overlapping rectangular regions, computing linear regression parameters within each region to enforce output smoothness while respecting guide-image structure. The mathematical formulation minimizes ||Fᵢ - a·Gᵢ - b||² + ε||a||², where Fᵢ is filtered output, Gᵢ is guide image, and (a, b) are locally linear parameters. Key features include flexibility (guide image may be independent of filtered image), computational efficiency via O(N) separable implementation, parameter control enabling edge-preservation strength adjustment, and effectiveness on single or multispectral guidance. Guided filtering excels in multi-sensor fusion workflows where optical data guides SAR denoising, refining LiDAR classifications using coincident orthophotos, shadow/cloud removal in satellite mosaics using temporal reference images, and detail enhancement in map regularization tasks. Output interpretation reveals that filtered regions remain locally similar to guide-image structure while intensity averaging proceeds within homogeneous regions. Smoothing radius controls spatial extent (larger radius = greater smoothing); regularization parameter ε balances smoothness versus structure fidelity (larger ε = smoother, smaller ε = more detail). Output ranges match input; visual comparison with guide image validates edge preservation fidelity. Common artifacts include over-smoothing at strong discontinuities (select appropriate parameters) and insufficient smoothing in guide-poor regions (verify guide-image quality). Monitor cross-correlation between filtered output and guide image to assess alignment quality. Apply strategically in image fusion, sharpening, and reconstruction workflows where edge information from one source guides filtering of another.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$guided_filter(...)
}

wbw_guided_filter <- function(...) {
  # The guided filter implements edge-preserving smoothing by constraining filter outputs to locally linear relationships with a guide image, typically the original or a related reference layer. Implementation divides the image into overlapping rectangular regions, computing linear regression parameters within each region to enforce output smoothness while respecting guide-image structure. The mathematical formulation minimizes ||Fᵢ - a·Gᵢ - b||² + ε||a||², where Fᵢ is filtered output, Gᵢ is guide image, and (a, b) are locally linear parameters. Key features include flexibility (guide image may be independent of filtered image), computational efficiency via O(N) separable implementation, parameter control enabling edge-preservation strength adjustment, and effectiveness on single or multispectral guidance. Guided filtering excels in multi-sensor fusion workflows where optical data guides SAR denoising, refining LiDAR classifications using coincident orthophotos, shadow/cloud removal in satellite mosaics using temporal reference images, and detail enhancement in map regularization tasks. Output interpretation reveals that filtered regions remain locally similar to guide-image structure while intensity averaging proceeds within homogeneous regions. Smoothing radius controls spatial extent (larger radius = greater smoothing); regularization parameter ε balances smoothness versus structure fidelity (larger ε = smoother, smaller ε = more detail). Output ranges match input; visual comparison with guide image validates edge preservation fidelity. Common artifacts include over-smoothing at strong discontinuities (select appropriate parameters) and insufficient smoothing in guide-poor regions (verify guide-image quality). Monitor cross-correlation between filtered output and guide image to assess alignment quality. Apply strategically in image fusion, sharpening, and reconstruction workflows where edge information from one source guides filtering of another.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$guided_filter(...)
}

h_alpha_wisart_classification <- function(...) {
  # H/α/A-Wisart classification combines unsupervised zoning via H/α/A parameter space partitioning with Wishart statistical clustering to automatically classify SAR polarimetric data into 9 physically meaningful zones corresponding to scattering mechanism classes. The algorithm receives entropy (H), anisotropy (A), and alpha (α) parameters from Cloude-Pottier decomposition and partitions the 3D (H,A,α) feature space into 9 regions using fixed thresholds: Zone 1 (low H, α~20°) represents Bragg reflection on dry surfaces; Zone 5 (H~0.7, α~45°) indicates isotropic volume scattering in forests; Zone 9 (high H, α~80°) represents dihedral (double-bounce) scattering from urban structures. Within each zone, Wishart clustering optionally refines classification by computing statistical distances in multivariate polarimetric space, improving discrimination of similar mechanisms. Key features include automatic, unsupervised classification requiring no training samples; 9 physically interpretable classes with standardized definitions enabling global comparability; optional dual-mode operation (threshold-only for speed, threshold+Wishart for accuracy); and built-in confidence metrics based on distance to zone boundaries and Wishart likelihood. The tool accepts pre-computed (H,A,α) images or automatically calls Cloude-Pottier decomposition if raw matrices provided. Primary use cases encompass SAR image segmentation and map generation from polarimetric data, unsupervised classification of land cover types (water, agriculture, forest, urban) directly from SAR coherency matrices, rapid assessment of polarimetric data quality through zone occupancy distributions, and change detection revealing scattering mechanism transitions indicating land cover alteration. Output interpretation: 9-class map directly corresponds to terrain types; zones can be aggregated into broader categories (water/specular = zones 1-2, vegetation/volume = zones 4-6, urban/dihedral = zones 7-9). Unclassified pixels (class 0) indicate unusual polarimetric signatures requiring investigation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$h_alpha_wisart_classification(...)
}

wbw_h_alpha_wisart_classification <- function(...) {
  # H/α/A-Wisart classification combines unsupervised zoning via H/α/A parameter space partitioning with Wishart statistical clustering to automatically classify SAR polarimetric data into 9 physically meaningful zones corresponding to scattering mechanism classes. The algorithm receives entropy (H), anisotropy (A), and alpha (α) parameters from Cloude-Pottier decomposition and partitions the 3D (H,A,α) feature space into 9 regions using fixed thresholds: Zone 1 (low H, α~20°) represents Bragg reflection on dry surfaces; Zone 5 (H~0.7, α~45°) indicates isotropic volume scattering in forests; Zone 9 (high H, α~80°) represents dihedral (double-bounce) scattering from urban structures. Within each zone, Wishart clustering optionally refines classification by computing statistical distances in multivariate polarimetric space, improving discrimination of similar mechanisms. Key features include automatic, unsupervised classification requiring no training samples; 9 physically interpretable classes with standardized definitions enabling global comparability; optional dual-mode operation (threshold-only for speed, threshold+Wishart for accuracy); and built-in confidence metrics based on distance to zone boundaries and Wishart likelihood. The tool accepts pre-computed (H,A,α) images or automatically calls Cloude-Pottier decomposition if raw matrices provided. Primary use cases encompass SAR image segmentation and map generation from polarimetric data, unsupervised classification of land cover types (water, agriculture, forest, urban) directly from SAR coherency matrices, rapid assessment of polarimetric data quality through zone occupancy distributions, and change detection revealing scattering mechanism transitions indicating land cover alteration. Output interpretation: 9-class map directly corresponds to terrain types; zones can be aggregated into broader categories (water/specular = zones 1-2, vegetation/volume = zones 4-6, urban/dihedral = zones 7-9). Unclassified pixels (class 0) indicate unusual polarimetric signatures requiring investigation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$h_alpha_wisart_classification(...)
}

hack_stream_order <- function(...) {
  # Assigns Hack stream order to stream cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hack_stream_order(...)
}

wbw_hack_stream_order <- function(...) {
  # Assigns Hack stream order to stream cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hack_stream_order(...)
}

heat_map <- function(...) {
  # Generates a kernel-density heat map raster from point occurrences.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$heat_map(...)
}

wbw_heat_map <- function(...) {
  # Generates a kernel-density heat map raster from point occurrences.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$heat_map(...)
}

height_above_ground <- function(...) {
  # Normalizes via point-cloud geometry: computes height of each point above nearest lower ground-class neighbor. Local terrain surface without raster reference.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$height_above_ground(...)
}

wbw_height_above_ground <- function(...) {
  # Normalizes via point-cloud geometry: computes height of each point above nearest lower ground-class neighbor. Local terrain surface without raster reference.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$height_above_ground(...)
}

hexagonal_grid_from_raster_base <- function(...) {
  # Creates a hexagonal polygon grid with configurable width and orientation, providing unbiased tessellation for heatmaps and aggregation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hexagonal_grid_from_raster_base(...)
}

wbw_hexagonal_grid_from_raster_base <- function(...) {
  # Creates a hexagonal polygon grid with configurable width and orientation, providing unbiased tessellation for heatmaps and aggregation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hexagonal_grid_from_raster_base(...)
}

hexagonal_grid_from_vector_base <- function(...) {
  # Creates a hexagonal polygon grid aligned to vector layer extent, enabling unbiased spatial aggregation and density visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hexagonal_grid_from_vector_base(...)
}

wbw_hexagonal_grid_from_vector_base <- function(...) {
  # Creates a hexagonal polygon grid aligned to vector layer extent, enabling unbiased spatial aggregation and density visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hexagonal_grid_from_vector_base(...)
}

high_pass_bilateral_filter <- function(...) {
  # Computes a high-pass residual by subtracting bilateral smoothing from the input raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$high_pass_bilateral_filter(...)
}

wbw_high_pass_bilateral_filter <- function(...) {
  # Computes a high-pass residual by subtracting bilateral smoothing from the input raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$high_pass_bilateral_filter(...)
}

high_pass_filter <- function(...) {
  # The high-pass filter isolates high-frequency spatial components in imagery by subtracting a low-frequency (smoothed) version from the original image. Mathematically, this is achieved by convolving the image with a kernel designed to emphasize gradients and suppress broad tonal variations. The implementation uses either direct convolution or frequency-domain processing depending on kernel size and image dimensions. The filter enhances edges, fine texture details, and small-scale variations while removing large-scale illumination trends. Key distinguishing features include preservation of edge contrast without boundary artifacts, selective frequency attenuation based on kernel radius, and direct applicability to both grayscale and multispectral imagery. High-pass filtering is invaluable for terrain analysis where subtle topographic features need enhancement, sharpening satellite imagery for visual interpretation, detecting small-scale geological structures, and preprocessing data for machine learning classification. It's also essential for preparing orthophotos for change detection and enhancing LiDAR-derived products. Output interpretation requires understanding that positive values indicate local maxima (bright edges) and negative values indicate local minima (dark edges). Typical range is ±100 for 8-bit imagery; zero-mean output indicates successful high-frequency extraction. Common artifacts include ringing at strong discontinuities and amplified noise if source imagery is noisy. Scale interpretation depends on kernel radius: smaller kernels enhance fine texture (individual pixels), while larger kernels emphasize moderate-scale features (terrain variations across tens of pixels). Monitor output statistics; excessive zero-centering indicates potential over-processing. Apply with complementary low-pass results to reconstruct original or for multi-scale decomposition workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$high_pass_filter(...)
}

wbw_high_pass_filter <- function(...) {
  # The high-pass filter isolates high-frequency spatial components in imagery by subtracting a low-frequency (smoothed) version from the original image. Mathematically, this is achieved by convolving the image with a kernel designed to emphasize gradients and suppress broad tonal variations. The implementation uses either direct convolution or frequency-domain processing depending on kernel size and image dimensions. The filter enhances edges, fine texture details, and small-scale variations while removing large-scale illumination trends. Key distinguishing features include preservation of edge contrast without boundary artifacts, selective frequency attenuation based on kernel radius, and direct applicability to both grayscale and multispectral imagery. High-pass filtering is invaluable for terrain analysis where subtle topographic features need enhancement, sharpening satellite imagery for visual interpretation, detecting small-scale geological structures, and preprocessing data for machine learning classification. It's also essential for preparing orthophotos for change detection and enhancing LiDAR-derived products. Output interpretation requires understanding that positive values indicate local maxima (bright edges) and negative values indicate local minima (dark edges). Typical range is ±100 for 8-bit imagery; zero-mean output indicates successful high-frequency extraction. Common artifacts include ringing at strong discontinuities and amplified noise if source imagery is noisy. Scale interpretation depends on kernel radius: smaller kernels enhance fine texture (individual pixels), while larger kernels emphasize moderate-scale features (terrain variations across tens of pixels). Monitor output statistics; excessive zero-centering indicates potential over-processing. Apply with complementary low-pass results to reconstruct original or for multi-scale decomposition workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$high_pass_filter(...)
}

high_pass_median_filter <- function(...) {
  # Performs high-pass filtering by subtracting local median from center values: output = pixel - median_neighborhood. Combines high-pass filtering (enhances detail) with median robustness (removes noise). Center-around-zero output (negative = darker than surroundings, positive = brighter). Robust to outliers compared to Gaussian-based high-pass. High-pass residual reveals local deviations from median trend. Particularly robust for noisy data—median is more stable than mean for outliers. Output emphasizes fine-scale variation. Often applied to Gaussian-smoothed versions (creates band-pass filter). Useful for texture enhancement and feature extraction from noisy imagery. Applications: (1) Texture enhancement from noisy data, (2) Detail extraction before classification, (3) Robust feature detection, (4) Preprocessing for texture-based segmentation, (5) SAR preprocessing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$high_pass_median_filter(...)
}

wbw_high_pass_median_filter <- function(...) {
  # Performs high-pass filtering by subtracting local median from center values: output = pixel - median_neighborhood. Combines high-pass filtering (enhances detail) with median robustness (removes noise). Center-around-zero output (negative = darker than surroundings, positive = brighter). Robust to outliers compared to Gaussian-based high-pass. High-pass residual reveals local deviations from median trend. Particularly robust for noisy data—median is more stable than mean for outliers. Output emphasizes fine-scale variation. Often applied to Gaussian-smoothed versions (creates band-pass filter). Useful for texture enhancement and feature extraction from noisy imagery. Applications: (1) Texture enhancement from noisy data, (2) Detail extraction before classification, (3) Robust feature detection, (4) Preprocessing for texture-based segmentation, (5) SAR preprocessing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$high_pass_median_filter(...)
}

highest_position <- function(...) {
  # Returns the zero-based raster-stack index containing the highest value at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$highest_position(...)
}

wbw_highest_position <- function(...) {
  # Returns the zero-based raster-stack index containing the highest value at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$highest_position(...)
}

hillshade <- function(...) {
  # Single-source directional hillshade visualization (grayscale 0-255). Azimuth & altitude parameters control light direction. Fast terrain visualization for DEM inspection and map display.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hillshade(...)
}

wbw_hillshade <- function(...) {
  # Single-source directional hillshade visualization (grayscale 0-255). Azimuth & altitude parameters control light direction. Fast terrain visualization for DEM inspection and map display.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hillshade(...)
}

hillslopes <- function(...) {
  # Identifies hillslope regions draining to each stream link, separating left- and right-bank areas.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hillslopes(...)
}

wbw_hillslopes <- function(...) {
  # Identifies hillslope regions draining to each stream link, separating left- and right-bank areas.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hillslopes(...)
}

histogram_equalization <- function(...) {
  # Applies histogram equalization to improve image contrast.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$histogram_equalization(...)
}

wbw_histogram_equalization <- function(...) {
  # Applies histogram equalization to improve image contrast.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$histogram_equalization(...)
}

histogram_matching <- function(...) {
  # Matches an image histogram to a supplied reference histogram.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$histogram_matching(...)
}

wbw_histogram_matching <- function(...) {
  # Matches an image histogram to a supplied reference histogram.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$histogram_matching(...)
}

histogram_matching_two_images <- function(...) {
  # Matches an input image histogram to a reference image histogram.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$histogram_matching_two_images(...)
}

wbw_histogram_matching_two_images <- function(...) {
  # Matches an input image histogram to a reference image histogram.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$histogram_matching_two_images(...)
}

hole_proportion <- function(...) {
  # Calculates polygon hole area divided by hull area and appends HOLE_PROP.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hole_proportion(...)
}

wbw_hole_proportion <- function(...) {
  # Calculates polygon hole area divided by hull area and appends HOLE_PROP.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hole_proportion(...)
}

horizon_angle <- function(...) {
  # Calculates horizon angle (maximum slope) along a specified azimuth direction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horizon_angle(...)
}

wbw_horizon_angle <- function(...) {
  # Calculates horizon angle (maximum slope) along a specified azimuth direction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horizon_angle(...)
}

horizon_area <- function(...) {
  # Calculates area of the horizon polygon (hectares).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horizon_area(...)
}

wbw_horizon_area <- function(...) {
  # Calculates area of the horizon polygon (hectares).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horizon_area(...)
}

horizontal_excess_curvature <- function(...) {
  # Calculates horizontal excess curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horizontal_excess_curvature(...)
}

wbw_horizontal_excess_curvature <- function(...) {
  # Calculates horizontal excess curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horizontal_excess_curvature(...)
}

horton_ratios <- function(...) {
  # Calculates Horton bifurcation, length, drainage-area, and slope ratios.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horton_ratios(...)
}

wbw_horton_ratios <- function(...) {
  # Calculates Horton bifurcation, length, drainage-area, and slope ratios.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horton_ratios(...)
}

horton_stream_order <- function(...) {
  # Assigns Horton stream order to stream cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horton_stream_order(...)
}

wbw_horton_stream_order <- function(...) {
  # Assigns Horton stream order to stream cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$horton_stream_order(...)
}

hotspot_vs_process <- function(...) {
  # Compare hotspot patterns with underlying point-process intensity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hotspot_vs_process(...)
}

wbw_hotspot_vs_process <- function(...) {
  # Compare hotspot patterns with underlying point-process intensity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hotspot_vs_process(...)
}

hydrologic_connectivity <- function(...) {
  # Computes DUL and UDSA connectivity indices from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hydrologic_connectivity(...)
}

wbw_hydrologic_connectivity <- function(...) {
  # Computes DUL and UDSA connectivity indices from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hydrologic_connectivity(...)
}

hypsometric_analysis <- function(...) {
  # Creates a hypsometric (area-elevation) curve HTML report for one or more DEMs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hypsometric_analysis(...)
}

wbw_hypsometric_analysis <- function(...) {
  # Creates a hypsometric (area-elevation) curve HTML report for one or more DEMs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hypsometric_analysis(...)
}

hypsometrically_tinted_hillshade <- function(...) {
  # Creates a Swiss-style terrain rendering by blending multi-azimuth hillshade with hypsometric tinting and optional atmospheric haze.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hypsometrically_tinted_hillshade(...)
}

wbw_hypsometrically_tinted_hillshade <- function(...) {
  # Creates a Swiss-style terrain rendering by blending multi-azimuth hillshade with hypsometric tinting and optional atmospheric haze.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$hypsometrically_tinted_hillshade(...)
}

identity <- function(...) {
  # Preserves all input features; portions overlapping the identity layer also acquire identity attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$identity(...)
}

wbw_identity <- function(...) {
  # Preserves all input features; portions overlapping the identity layer also acquire identity attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$identity(...)
}

idw_interpolation <- function(...) {
  # Interpolates a raster from point samples using inverse-distance weighting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$idw_interpolation(...)
}

wbw_idw_interpolation <- function(...) {
  # Interpolates a raster from point samples using inverse-distance weighting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$idw_interpolation(...)
}

ihs_to_rgb <- function(...) {
  # IHS to RGB inverse transformation converts Intensity-Hue-Saturation components back to red-green-blue color space, enabling recovery of natural color from decomposed remote sensing data. The inverse formulas operate on cylindrical polar coordinates, converting hue angle and saturation magnitude plus intensity back into Cartesian RGB coordinates while maintaining numerical stability and minimizing quantization artifacts. This transformation is the critical complement to RGB-to-IHS operations, particularly in pan-sharpening workflows where intensity has been replaced with high-resolution panchromatic data. Key features include exact mathematical inversion of forward transformation ensuring consistency in round-trip operations, automatic handling of hue-undefined achromatic pixels preventing propagation of numerical artifacts, numerical stability across extreme saturation values near zero, and computational efficiency enabling seamless integration into rapid processing pipelines. The inverse transformation completes pan-sharpening workflows by recovering natural color imagery after intensity replacement with panchromatic data, enabling color visualization of enhanced resolution data, supporting spectral reconstruction from decomposed components, and validating transformation consistency in quality control workflows. IHS-to-RGB output produces three-band natural color imagery with spatial resolution inherited from the input intensity band, suitable for direct visualization and further analysis. Output bands represent red, green, and blue channels in standard order; colors exhibit enhanced spatial detail if intensity was replaced with higher-resolution panchromatic data, preserving spectral characteristics from original hue and saturation components.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ihs_to_rgb(...)
}

wbw_ihs_to_rgb <- function(...) {
  # IHS to RGB inverse transformation converts Intensity-Hue-Saturation components back to red-green-blue color space, enabling recovery of natural color from decomposed remote sensing data. The inverse formulas operate on cylindrical polar coordinates, converting hue angle and saturation magnitude plus intensity back into Cartesian RGB coordinates while maintaining numerical stability and minimizing quantization artifacts. This transformation is the critical complement to RGB-to-IHS operations, particularly in pan-sharpening workflows where intensity has been replaced with high-resolution panchromatic data. Key features include exact mathematical inversion of forward transformation ensuring consistency in round-trip operations, automatic handling of hue-undefined achromatic pixels preventing propagation of numerical artifacts, numerical stability across extreme saturation values near zero, and computational efficiency enabling seamless integration into rapid processing pipelines. The inverse transformation completes pan-sharpening workflows by recovering natural color imagery after intensity replacement with panchromatic data, enabling color visualization of enhanced resolution data, supporting spectral reconstruction from decomposed components, and validating transformation consistency in quality control workflows. IHS-to-RGB output produces three-band natural color imagery with spatial resolution inherited from the input intensity band, suitable for direct visualization and further analysis. Output bands represent red, green, and blue channels in standard order; colors exhibit enhanced spatial detail if intensity was replaced with higher-resolution panchromatic data, preserving spectral characteristics from original hue and saturation components.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ihs_to_rgb(...)
}

image_autocorrelation <- function(...) {
  # Computes Moran's I for one or more raster images.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_autocorrelation(...)
}

wbw_image_autocorrelation <- function(...) {
  # Computes Moran's I for one or more raster images.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_autocorrelation(...)
}

image_correlation <- function(...) {
  # Computes Pearson correlation matrix for two or more raster images.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_correlation(...)
}

wbw_image_correlation <- function(...) {
  # Computes Pearson correlation matrix for two or more raster images.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_correlation(...)
}

image_correlation_neighbourhood_analysis <- function(...) {
  # Performs moving-window correlation analysis between two rasters and returns correlation and p-value rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_correlation_neighbourhood_analysis(...)
}

wbw_image_correlation_neighbourhood_analysis <- function(...) {
  # Performs moving-window correlation analysis between two rasters and returns correlation and p-value rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_correlation_neighbourhood_analysis(...)
}

image_difference_change_detection <- function(...) {
  # Image difference change detection identifies land cover changes by computing multispectral pixel-wise differences between coregistered multitemporal satellite acquisitions, highlighting areas where spectral signatures changed sufficiently to exceed statistical background variation. The algorithm coregisters images to common pixel grids, computes differences in selected bands or vegetation indices (e.g., NDVI difference), applies statistical thresholding using mean absolute difference and confidence intervals to distinguish change from noise, and outputs binary change masks or continuous difference magnitude rasters. Image differencing is computationally simple, interpretable, and effective for detecting major changes in vegetation, urban development, or water bodies. Key features include flexible band selection enabling targeted change detection in specific spectral domains, statistical thresholding with automatic or manual confidence levels, optional preprocessing (normalization, index computation) improving change signal-to-noise, and rapid processing enabling large-scale change detection. Applications include deforestation mapping and forest loss monitoring, urban expansion tracking from multispectral satellite time series, flood mapping pre/post-event from SAR or optical data, and agricultural change detection tracking crop transitions. Image difference output highlights change areas. Output comprises change mask raster (binary change/no-change) with configurable thresholds, continuous difference magnitude raster quantifying change intensity, and optional change class raster disambiguating change type (increase, decrease); temporal aggregation enables change tracking across multi-year periods.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_difference_change_detection(...)
}

wbw_image_difference_change_detection <- function(...) {
  # Image difference change detection identifies land cover changes by computing multispectral pixel-wise differences between coregistered multitemporal satellite acquisitions, highlighting areas where spectral signatures changed sufficiently to exceed statistical background variation. The algorithm coregisters images to common pixel grids, computes differences in selected bands or vegetation indices (e.g., NDVI difference), applies statistical thresholding using mean absolute difference and confidence intervals to distinguish change from noise, and outputs binary change masks or continuous difference magnitude rasters. Image differencing is computationally simple, interpretable, and effective for detecting major changes in vegetation, urban development, or water bodies. Key features include flexible band selection enabling targeted change detection in specific spectral domains, statistical thresholding with automatic or manual confidence levels, optional preprocessing (normalization, index computation) improving change signal-to-noise, and rapid processing enabling large-scale change detection. Applications include deforestation mapping and forest loss monitoring, urban expansion tracking from multispectral satellite time series, flood mapping pre/post-event from SAR or optical data, and agricultural change detection tracking crop transitions. Image difference output highlights change areas. Output comprises change mask raster (binary change/no-change) with configurable thresholds, continuous difference magnitude raster quantifying change intensity, and optional change class raster disambiguating change type (increase, decrease); temporal aggregation enables change tracking across multi-year periods.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_difference_change_detection(...)
}

image_regression <- function(...) {
  # Performs bivariate linear regression between two rasters and outputs a residual raster and report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_regression(...)
}

wbw_image_regression <- function(...) {
  # Performs bivariate linear regression between two rasters and outputs a residual raster and report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_regression(...)
}

image_segmentation <- function(...) {
  # Segments multi-band raster stacks into contiguous homogeneous regions using seeded region growing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_segmentation(...)
}

wbw_image_segmentation <- function(...) {
  # Segments multi-band raster stacks into contiguous homogeneous regions using seeded region growing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_segmentation(...)
}

image_slider <- function(...) {
  # Image Slider is an interactive visualization tool enabling direct pixel-level comparison between co-registered raster datasets through draggable horizontal or vertical overlay dividers. Algorithm: maintains two aligned raster datasets in memory, renders combined view with adjustable divider position controlling layer visibility, user interaction dynamically adjusts divider creating split-screen effect. Supports both horizontal and vertical division orientations. Key features: interactive real-time comparison, maintains full-resolution visualization, intuitive user interface requiring no analytical skills, works with multispectral and indexed rasters, supports large datasets through efficient rendering. Capabilities: change detection visualization, before/after comparison, multitemporal analysis, radiometric normalization assessment, classification accuracy visual inspection. Use cases: detecting imagery changes between dates, comparing classification results against reference data, evaluating preprocessing effectiveness, visual change detection in time-series analysis. Applications: disaster response damage assessment, urban sprawl monitoring, forest disturbance detection, agricultural change monitoring, quality control of image processing outputs. Output interpretation: visual differences reveal change magnitude and location; sharp edges indicate significant changes; gradual transitions suggest registration inaccuracy or temporal gradation; systematic differences across image reveal systematic processing artifacts.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_slider(...)
}

wbw_image_slider <- function(...) {
  # Image Slider is an interactive visualization tool enabling direct pixel-level comparison between co-registered raster datasets through draggable horizontal or vertical overlay dividers. Algorithm: maintains two aligned raster datasets in memory, renders combined view with adjustable divider position controlling layer visibility, user interaction dynamically adjusts divider creating split-screen effect. Supports both horizontal and vertical division orientations. Key features: interactive real-time comparison, maintains full-resolution visualization, intuitive user interface requiring no analytical skills, works with multispectral and indexed rasters, supports large datasets through efficient rendering. Capabilities: change detection visualization, before/after comparison, multitemporal analysis, radiometric normalization assessment, classification accuracy visual inspection. Use cases: detecting imagery changes between dates, comparing classification results against reference data, evaluating preprocessing effectiveness, visual change detection in time-series analysis. Applications: disaster response damage assessment, urban sprawl monitoring, forest disturbance detection, agricultural change monitoring, quality control of image processing outputs. Output interpretation: visual differences reveal change magnitude and location; sharp edges indicate significant changes; gradual transitions suggest registration inaccuracy or temporal gradation; systematic differences across image reveal systematic processing artifacts.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_slider(...)
}

image_stack_profile <- function(...) {
  # Extracts per-point profiles across an ordered raster stack and optionally writes an HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_stack_profile(...)
}

wbw_image_stack_profile <- function(...) {
  # Extracts per-point profiles across an ordered raster stack and optionally writes an HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$image_stack_profile(...)
}

impoundment_size_index <- function(...) {
  # Computes mean/max depth, volume, area, and dam-height impoundment metrics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$impoundment_size_index(...)
}

wbw_impoundment_size_index <- function(...) {
  # Computes mean/max depth, volume, area, and dam-height impoundment metrics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$impoundment_size_index(...)
}

improved_ground_point_filter <- function(...) {
  # Multi-stage ground point filtering pipeline.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$improved_ground_point_filter(...)
}

wbw_improved_ground_point_filter <- function(...) {
  # Multi-stage ground point filtering pipeline.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$improved_ground_point_filter(...)
}

increment <- function(...) {
  # Adds a value (default 1.0) to each non-nodata raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$increment(...)
}

wbw_increment <- function(...) {
  # Adds a value (default 1.0) to each non-nodata raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$increment(...)
}

individual_tree_detection <- function(...) {
  # Identifies tree tops: local maxima in height-filtered point cloud with adaptive search radius. Returns vector point shapefile of potential stem locations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$individual_tree_detection(...)
}

wbw_individual_tree_detection <- function(...) {
  # Identifies tree tops: local maxima in height-filtered point cloud with adaptive search radius. Returns vector point shapefile of potential stem locations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$individual_tree_detection(...)
}

individual_tree_segmentation <- function(...) {
  # Segments vegetation points into tree crowns: mean-shift clustering with adaptive bandwidth from local canopy geometry. Inventory-level tree delineation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$individual_tree_segmentation(...)
}

wbw_individual_tree_segmentation <- function(...) {
  # Segments vegetation points into tree crowns: mean-shift clustering with adaptive bandwidth from local canopy geometry. Inventory-level tree delineation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$individual_tree_segmentation(...)
}

inhomogeneous_baseline <- function(...) {
  # Estimate intensity surface and compute intensity-corrected K function.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inhomogeneous_baseline(...)
}

wbw_inhomogeneous_baseline <- function(...) {
  # Estimate intensity surface and compute intensity-corrected K function.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inhomogeneous_baseline(...)
}

inhomogeneous_intensity_raster <- function(...) {
  # Computes kernel density estimation (KDE) surface visualizing spatial point intensity. Reveals hotspots and coldspots beyond simple density.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inhomogeneous_intensity_raster(...)
}

wbw_inhomogeneous_intensity_raster <- function(...) {
  # Computes kernel density estimation (KDE) surface visualizing spatial point intensity. Reveals hotspots and coldspots beyond simple density.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inhomogeneous_intensity_raster(...)
}

inplace_add <- function(...) {
  # Performs an in-place addition operation (input1 += input2).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inplace_add(...)
}

wbw_inplace_add <- function(...) {
  # Performs an in-place addition operation (input1 += input2).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inplace_add(...)
}

inplace_divide <- function(...) {
  # Performs an in-place division operation (input1 /= input2).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inplace_divide(...)
}

wbw_inplace_divide <- function(...) {
  # Performs an in-place division operation (input1 /= input2).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inplace_divide(...)
}

inplace_multiply <- function(...) {
  # Performs an in-place multiplication operation (input1 *= input2).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inplace_multiply(...)
}

wbw_inplace_multiply <- function(...) {
  # Performs an in-place multiplication operation (input1 *= input2).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inplace_multiply(...)
}

inplace_subtract <- function(...) {
  # Performs an in-place subtraction operation (input1 -= input2).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inplace_subtract(...)
}

wbw_inplace_subtract <- function(...) {
  # Performs an in-place subtraction operation (input1 -= input2).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inplace_subtract(...)
}

insert_dams <- function(...) {
  # Adds local dam embankments at specified points using profile-based crest selection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$insert_dams(...)
}

wbw_insert_dams <- function(...) {
  # Adds local dam embankments at specified points using profile-based crest selection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$insert_dams(...)
}

integer_division <- function(...) {
  # Divides two rasters and truncates each result toward zero.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$integer_division(...)
}

wbw_integer_division <- function(...) {
  # Divides two rasters and truncates each result toward zero.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$integer_division(...)
}

integral_image_transform <- function(...) {
  # Computes a summed-area (integral image) transform for each band.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$integral_image_transform(...)
}

wbw_integral_image_transform <- function(...) {
  # Computes a summed-area (integral image) transform for each band.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$integral_image_transform(...)
}

intersect <- function(...) {
  # Intersects input and overlay polygons using topology-based overlay and tracks source feature IDs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$intersect(...)
}

wbw_intersect <- function(...) {
  # Intersects input and overlay polygons using topology-based overlay and tracks source feature IDs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$intersect(...)
}

inverse_pca <- function(...) {
  # Reconstructs original band images from PCA component rasters using stored eigenvectors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inverse_pca(...)
}

wbw_inverse_pca <- function(...) {
  # Reconstructs original band images from PCA component rasters using stored eigenvectors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$inverse_pca(...)
}

is_nodata <- function(...) {
  # Outputs 1 for nodata cells and 0 for all valid cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$is_nodata(...)
}

wbw_is_nodata <- function(...) {
  # Outputs 1 for nodata cells and 0 for all valid cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$is_nodata(...)
}

isobasins <- function(...) {
  # Divides a landscape into approximately equal-sized watersheds (isobasins) based on a target area threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$isobasins(...)
}

wbw_isobasins <- function(...) {
  # Divides a landscape into approximately equal-sized watersheds (isobasins) based on a target area threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$isobasins(...)
}

jenson_snap_pour_points <- function(...) {
  # Snaps each pour point to the nearest stream cell within a search distance, preserving all input attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$jenson_snap_pour_points(...)
}

wbw_jenson_snap_pour_points <- function(...) {
  # Snaps each pour point to the nearest stream cell within a search distance, preserving all input attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$jenson_snap_pour_points(...)
}

join_tables <- function(...) {
  # Joins attributes from a foreign vector table to a primary vector table using key fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$join_tables(...)
}

wbw_join_tables <- function(...) {
  # Joins attributes from a foreign vector table to a primary vector table using key fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$join_tables(...)
}

k_means_clustering <- function(...) {
  # K-means clustering performs unsupervised spectral classification by iteratively partitioning pixels into K spectral clusters, minimizing within-cluster variance and discovering natural spectral groupings in multispectral imagery without training samples or a priori class definitions. The algorithm initializes K random cluster centers, iteratively assigns pixels to nearest centers and recomputes centers as cluster means until convergence, outputting final cluster assignments and centers. K-means is computationally efficient, scalable to large multispectral stacks, and discovers data-driven spectral patterns useful for exploratory analysis and natural class identification. Key features include user-specified cluster count K enabling flexible trade-offs between spectral detail and output interpretability, convergence criteria with configurable iteration limits and center displacement thresholds, optional random seed control ensuring reproducible clustering for testing and validation, and efficient parallelization handling large imagery. Applications span unsupervised land cover classification discovering natural spectral classes, anomaly detection identifying spectrally unusual pixels, image segmentation for subsequent supervised classification, and exploratory spectral analysis revealing dominant spectral patterns. K-means output identifies natural spectral groupings. Output produces cluster membership raster with integers 0 to K-1, cluster centers file with mean spectrum per cluster, and optional within-cluster variance quantifying compactness; visualization overlays cluster classes on true-color composites revealing spatial patterns and cluster continuity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$k_means_clustering(...)
}

wbw_k_means_clustering <- function(...) {
  # K-means clustering performs unsupervised spectral classification by iteratively partitioning pixels into K spectral clusters, minimizing within-cluster variance and discovering natural spectral groupings in multispectral imagery without training samples or a priori class definitions. The algorithm initializes K random cluster centers, iteratively assigns pixels to nearest centers and recomputes centers as cluster means until convergence, outputting final cluster assignments and centers. K-means is computationally efficient, scalable to large multispectral stacks, and discovers data-driven spectral patterns useful for exploratory analysis and natural class identification. Key features include user-specified cluster count K enabling flexible trade-offs between spectral detail and output interpretability, convergence criteria with configurable iteration limits and center displacement thresholds, optional random seed control ensuring reproducible clustering for testing and validation, and efficient parallelization handling large imagery. Applications span unsupervised land cover classification discovering natural spectral classes, anomaly detection identifying spectrally unusual pixels, image segmentation for subsequent supervised classification, and exploratory spectral analysis revealing dominant spectral patterns. K-means output identifies natural spectral groupings. Output produces cluster membership raster with integers 0 to K-1, cluster centers file with mean spectrum per cluster, and optional within-cluster variance quantifying compactness; visualization overlays cluster classes on true-color composites revealing spatial patterns and cluster continuity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$k_means_clustering(...)
}

k_nearest_mean_filter <- function(...) {
  # Performs edge-preserving k-nearest neighbor mean smoothing: sorts neighborhood by distance to center value, averages k closest values. Hybrid approach preserving edges via similarity weighting. Center pixel and k-1 most similar neighbors are averaged. More sophisticated than simple k-NN (considers both spatial and intensity similarity). Computationally efficient relative to bilateral. K-nearest approach adaptively selects neighbors: pixel values close to center are averaged, dissimilar pixels ignored. K parameter controls smoothing: k=1 (no smoothing), k=n (all neighbors = mean filter). Typically k=n/2 (half the neighborhood). Efficient alternative to bilateral filter—similar edge preservation at lower computational cost. Particularly useful for images with strong intensity discontinuities. Applications: (1) Edge-preserving smoothing (alternative to bilateral), (2) Fast preprocessing for classification, (3) Efficiency-critical preprocessing, (4) Multi-band image filtering. Typical parameters: k=neighborhood_size/2 to 3/4.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$k_nearest_mean_filter(...)
}

wbw_k_nearest_mean_filter <- function(...) {
  # Performs edge-preserving k-nearest neighbor mean smoothing: sorts neighborhood by distance to center value, averages k closest values. Hybrid approach preserving edges via similarity weighting. Center pixel and k-1 most similar neighbors are averaged. More sophisticated than simple k-NN (considers both spatial and intensity similarity). Computationally efficient relative to bilateral. K-nearest approach adaptively selects neighbors: pixel values close to center are averaged, dissimilar pixels ignored. K parameter controls smoothing: k=1 (no smoothing), k=n (all neighbors = mean filter). Typically k=n/2 (half the neighborhood). Efficient alternative to bilateral filter—similar edge preservation at lower computational cost. Particularly useful for images with strong intensity discontinuities. Applications: (1) Edge-preserving smoothing (alternative to bilateral), (2) Fast preprocessing for classification, (3) Efficiency-critical preprocessing, (4) Multi-band image filtering. Typical parameters: k=neighborhood_size/2 to 3/4.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$k_nearest_mean_filter(...)
}

k_shortest_paths_network <- function(...) {
  # Finds the k shortest simple paths between start and end coordinates over a line network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$k_shortest_paths_network(...)
}

wbw_k_shortest_paths_network <- function(...) {
  # Finds the k shortest simple paths between start and end coordinates over a line network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$k_shortest_paths_network(...)
}

kappa_index <- function(...) {
  # Computes Cohen's kappa and agreement metrics between two categorical rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$kappa_index(...)
}

wbw_kappa_index <- function(...) {
  # Computes Cohen's kappa and agreement metrics between two categorical rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$kappa_index(...)
}

knn_classification <- function(...) {
  # K-nearest neighbors classification assigns pixels to classes based on majority voting among K nearest training samples in spectral space, enabling flexible nonlinear classification without explicit model training. KNN computes distances (Euclidean, spectral angle, or Mahalanobis) from each image pixel to all training samples, identifies K nearest training samples, applies weighted or unweighted majority voting to determine class, and returns class label and optionally confidence score. KNN excels with limited training data, highly nonlinear class boundaries, and heterogeneous class spectral distributions where parametric models struggle. Key features include selectable distance metrics (Euclidean, spectral angle, Mahalanobis) accommodating different spectral characteristics and correlation structures, user-specified K values enabling accuracy-complexity trade-offs, weighted voting options emphasizing nearby samples, and optional confidence thresholds enabling rejection of ambiguous classifications. Applications include high-accuracy remote sensing classification with field-collected training samples, small-sample classification where limited ground truth exists, difficult terrain classification with highly variable spectral signatures, and confidence-aware classification rejecting borderline decisions. KNN classification enables high-accuracy results with flexible training data. Output comprises class label raster with integer class IDs matching training sample labels, optional confidence raster recording voting percentages or distance-weighted confidence scores, and classification accuracy potentially exceeding other methods with optimal K selection and sufficient training samples.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$knn_classification(...)
}

wbw_knn_classification <- function(...) {
  # K-nearest neighbors classification assigns pixels to classes based on majority voting among K nearest training samples in spectral space, enabling flexible nonlinear classification without explicit model training. KNN computes distances (Euclidean, spectral angle, or Mahalanobis) from each image pixel to all training samples, identifies K nearest training samples, applies weighted or unweighted majority voting to determine class, and returns class label and optionally confidence score. KNN excels with limited training data, highly nonlinear class boundaries, and heterogeneous class spectral distributions where parametric models struggle. Key features include selectable distance metrics (Euclidean, spectral angle, Mahalanobis) accommodating different spectral characteristics and correlation structures, user-specified K values enabling accuracy-complexity trade-offs, weighted voting options emphasizing nearby samples, and optional confidence thresholds enabling rejection of ambiguous classifications. Applications include high-accuracy remote sensing classification with field-collected training samples, small-sample classification where limited ground truth exists, difficult terrain classification with highly variable spectral signatures, and confidence-aware classification rejecting borderline decisions. KNN classification enables high-accuracy results with flexible training data. Output comprises class label raster with integer class IDs matching training sample labels, optional confidence raster recording voting percentages or distance-weighted confidence scores, and classification accuracy potentially exceeding other methods with optimal K selection and sufficient training samples.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$knn_classification(...)
}

knn_regression <- function(...) {
  # Performs supervised k-nearest-neighbor regression on multi-band input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$knn_regression(...)
}

wbw_knn_regression <- function(...) {
  # Performs supervised k-nearest-neighbor regression on multi-band input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$knn_regression(...)
}

kriging_cross_validation <- function(...) {
  # Assesses kriging model performance using Leave-One-Out Cross-Validation, computing diagnostic statistics to validate variogram fit and kriging appropriateness.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$kriging_cross_validation(...)
}

wbw_kriging_cross_validation <- function(...) {
  # Assesses kriging model performance using Leave-One-Out Cross-Validation, computing diagnostic statistics to validate variogram fit and kriging appropriateness.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$kriging_cross_validation(...)
}

ks_normality_test <- function(...) {
  # Evaluates whether raster values are drawn from a normal distribution.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ks_normality_test(...)
}

wbw_ks_normality_test <- function(...) {
  # Evaluates whether raster values are drawn from a normal distribution.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ks_normality_test(...)
}

kuan_filter <- function(...) {
  # Performs Kuan speckle filtering for SAR/radar imagery using parametric approach estimating local means and variance. Adaptive weighting based on noise variance and local image variance. Similar to Lee but with different statistical assumptions. Widely used operational SAR processing method. Balance of computational efficiency and good results across varied SAR data. Kuan filtering assumes Gaussian statistics with multiplicative speckle model. Adapts to local variance—distinguishes between signal variation and speckle. Particularly effective for heterogeneous SAR imagery (mixed bright and dark features). Computationally reasonable. Represents practical compromise between sophistication and computational cost. Standard in many SAR processing systems. Applications: (1) Operational SAR despeckling, (2) Mixed-backscatter SAR preprocessing, (3) RadarSat/Sentinel-1 preprocessing, (4) Routine SAR processing. Typical parameters: filter_size=5×7 to 7×7.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$kuan_filter(...)
}

wbw_kuan_filter <- function(...) {
  # Performs Kuan speckle filtering for SAR/radar imagery using parametric approach estimating local means and variance. Adaptive weighting based on noise variance and local image variance. Similar to Lee but with different statistical assumptions. Widely used operational SAR processing method. Balance of computational efficiency and good results across varied SAR data. Kuan filtering assumes Gaussian statistics with multiplicative speckle model. Adapts to local variance—distinguishes between signal variation and speckle. Particularly effective for heterogeneous SAR imagery (mixed bright and dark features). Computationally reasonable. Represents practical compromise between sophistication and computational cost. Standard in many SAR processing systems. Applications: (1) Operational SAR despeckling, (2) Mixed-backscatter SAR preprocessing, (3) RadarSat/Sentinel-1 preprocessing, (4) Routine SAR processing. Typical parameters: filter_size=5×7 to 7×7.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$kuan_filter(...)
}

kuwahara_filter <- function(...) {
  # The Kuwahara filter implements non-linear edge-preserving smoothing by dividing each pixel's neighborhood into four quadrants, computing statistics within each quadrant, and selecting the quadrant with lowest variance as the output value. Implementation partitions a (2k+1)×(2k+1) window into four overlapping k×k sub-windows, calculates mean and variance of each quadrant, and outputs the mean from the quadrant with minimum variance. This rank-based approach simultaneously smooths homogeneous regions and sharpens edges. Key features include true edge preservation via quadrant selection (edges between quadrants suppress output blurring), computational simplicity requiring only mean/variance calculations, parameter control via quadrant size k, and effectiveness on optical, radar, and thermal imagery. Kuwahara filtering excels in LiDAR-derived DEM smoothing preserving scarps and terraces, road network extraction from high-resolution imagery maintaining centerline sharpness, building footprint delineation from aerial photos, and oil-spill boundary detection in SAR imagery. Output interpretation reveals that homogeneous regions output the naturally averaging quadrant (lowest variance); edges output the quadrant containing uniform structure nearest the edge, effectively anchoring output to the cleaner side. Quadrant size k controls detail preservation: k=1 (minimal smoothing) preserves fine edges; k=3-4 provides balanced smoothing and edge preservation; k>5 risks detail loss. Output values exactly match input pixel values from selected quadrants (no interpolation). Monitor output histograms for bimodal distributions (edges and homogeneous regions clearly separated); unimodal distributions suggest edge blurring. Apply complementary sharpening if over-smoothing occurs. Common artifacts include directional bias depending on quadrant alignment and blockiness near weak edges. Use in pre-processing for segmentation where edge preservation ensures accurate boundary extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$kuwahara_filter(...)
}

wbw_kuwahara_filter <- function(...) {
  # The Kuwahara filter implements non-linear edge-preserving smoothing by dividing each pixel's neighborhood into four quadrants, computing statistics within each quadrant, and selecting the quadrant with lowest variance as the output value. Implementation partitions a (2k+1)×(2k+1) window into four overlapping k×k sub-windows, calculates mean and variance of each quadrant, and outputs the mean from the quadrant with minimum variance. This rank-based approach simultaneously smooths homogeneous regions and sharpens edges. Key features include true edge preservation via quadrant selection (edges between quadrants suppress output blurring), computational simplicity requiring only mean/variance calculations, parameter control via quadrant size k, and effectiveness on optical, radar, and thermal imagery. Kuwahara filtering excels in LiDAR-derived DEM smoothing preserving scarps and terraces, road network extraction from high-resolution imagery maintaining centerline sharpness, building footprint delineation from aerial photos, and oil-spill boundary detection in SAR imagery. Output interpretation reveals that homogeneous regions output the naturally averaging quadrant (lowest variance); edges output the quadrant containing uniform structure nearest the edge, effectively anchoring output to the cleaner side. Quadrant size k controls detail preservation: k=1 (minimal smoothing) preserves fine edges; k=3-4 provides balanced smoothing and edge preservation; k>5 risks detail loss. Output values exactly match input pixel values from selected quadrants (no interpolation). Monitor output histograms for bimodal distributions (edges and homogeneous regions clearly separated); unimodal distributions suggest edge blurring. Apply complementary sharpening if over-smoothing occurs. Common artifacts include directional bias depending on quadrant alignment and blockiness near weak edges. Use in pre-processing for segmentation where edge preservation ensures accurate boundary extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$kuwahara_filter(...)
}

land_surface_temperature_single_channel <- function(...) {
  # Land surface temperature retrieval from single thermal infrared channel estimates radiative skin temperature via radiative transfer equation inversion. Sensor digital numbers converted to spectral radiance using sensor-specific calibration coefficients; radiance inverted to brightness temperature via Planck function using band-specific thermal constants; brightness temperature converted to physical LST via empirical emissivity corrections. Emissivity derived from vegetation indices or provided directly, correcting for material-dependent thermal emissivity variations. Key Features: Requires single thermal band; simple radiometric processing; fast computation; no multi-channel requirement; vegetation-index emissivity estimation; direct physical temperature output. Use Cases: Urban heat island mapping; drought stress monitoring; geothermal feature detection; wildfire thermal signature tracking; agricultural water management. Output Interpretation: Output is skin radiative temperature in Kelvin (or Celsius if converted). Single-channel retrieval cannot fully remove atmospheric water vapor effects; residual atmospheric bias typically 2-5 K. Emissivity errors propagate directly: ±0.05 emissivity error ≈ ±1-2 K temperature error. Vegetation-based emissivity varies with NDVI; bare soil exhibits lower emissivity than vegetation. Time-series LST reveals heating/cooling trends; LST anomalies > background ± 5K indicate thermal features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$land_surface_temperature_single_channel(...)
}

wbw_land_surface_temperature_single_channel <- function(...) {
  # Land surface temperature retrieval from single thermal infrared channel estimates radiative skin temperature via radiative transfer equation inversion. Sensor digital numbers converted to spectral radiance using sensor-specific calibration coefficients; radiance inverted to brightness temperature via Planck function using band-specific thermal constants; brightness temperature converted to physical LST via empirical emissivity corrections. Emissivity derived from vegetation indices or provided directly, correcting for material-dependent thermal emissivity variations. Key Features: Requires single thermal band; simple radiometric processing; fast computation; no multi-channel requirement; vegetation-index emissivity estimation; direct physical temperature output. Use Cases: Urban heat island mapping; drought stress monitoring; geothermal feature detection; wildfire thermal signature tracking; agricultural water management. Output Interpretation: Output is skin radiative temperature in Kelvin (or Celsius if converted). Single-channel retrieval cannot fully remove atmospheric water vapor effects; residual atmospheric bias typically 2-5 K. Emissivity errors propagate directly: ±0.05 emissivity error ≈ ±1-2 K temperature error. Vegetation-based emissivity varies with NDVI; bare soil exhibits lower emissivity than vegetation. Time-series LST reveals heating/cooling trends; LST anomalies > background ± 5K indicate thermal features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$land_surface_temperature_single_channel(...)
}

land_surface_temperature_split_window <- function(...) {
  # Split-window LST retrieval uses dual thermal infrared bands to simultaneously estimate surface temperature and emissivity via radiative transfer equation inversion. Differential atmospheric absorption between two bands (typically 10-12 μm region) enables atmospheric water vapor correction improving accuracy over single-channel methods. Brightness temperatures from both bands inverted with vegetation-fraction based emissivity parameterization or user-supplied emissivity grids. Key Features: Dual thermal band requirement; atmospheric correction via differential absorption; simultaneous temperature/emissivity retrieval; published algorithms for standard sensors; superior atmospheric compensation compared to single-channel. Use Cases: Urban heat island mapping; agricultural drought detection; geothermal feature detection; land-atmosphere interaction studies; volcanic/thermal anomaly detection. Output Interpretation: Output is surface radiative temperature with improved atmospheric correction. Split-window retrieval reduces atmospheric water vapor bias to <1-2 K compared to single-channel 2-5 K errors. Temperature/emissivity trade-off remains: high vegetation index areas exhibit low emissivity requiring careful interpretation. Heterogeneous surfaces (mixed vegetation/soil) show intermediate values. Temporal consistency improves change detection reliability; LST trends > ±3K indicate significant thermal changes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$land_surface_temperature_split_window(...)
}

wbw_land_surface_temperature_split_window <- function(...) {
  # Split-window LST retrieval uses dual thermal infrared bands to simultaneously estimate surface temperature and emissivity via radiative transfer equation inversion. Differential atmospheric absorption between two bands (typically 10-12 μm region) enables atmospheric water vapor correction improving accuracy over single-channel methods. Brightness temperatures from both bands inverted with vegetation-fraction based emissivity parameterization or user-supplied emissivity grids. Key Features: Dual thermal band requirement; atmospheric correction via differential absorption; simultaneous temperature/emissivity retrieval; published algorithms for standard sensors; superior atmospheric compensation compared to single-channel. Use Cases: Urban heat island mapping; agricultural drought detection; geothermal feature detection; land-atmosphere interaction studies; volcanic/thermal anomaly detection. Output Interpretation: Output is surface radiative temperature with improved atmospheric correction. Split-window retrieval reduces atmospheric water vapor bias to <1-2 K compared to single-channel 2-5 K errors. Temperature/emissivity trade-off remains: high vegetation index areas exhibit low emissivity requiring careful interpretation. Heterogeneous surfaces (mixed vegetation/soil) show intermediate values. Temporal consistency improves change detection reliability; LST trends > ±3K indicate significant thermal changes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$land_surface_temperature_split_window(...)
}

laplacian_filter <- function(...) {
  # The Laplacian filter computes the second spatial derivative of image intensity, providing powerful edge detection via isotropic (all-direction) gradient measurement. The implementation applies a fixed kernel approximating the Laplacian operator (sum of second derivatives in x and y directions), capturing intensity changes regardless of edge orientation. Unlike directional filters, this approach treats all edge directions equally, making it ideal for feature detection requiring orientation-independence. The mathematical foundation rests on the discrete approximation: ∇²I ≈ I(x+1,y) + I(x-1,y) + I(x,y+1) + I(x,y-1) - 4·I(x,y). Key features include zero-crossing detection capability (true edges occur where output crosses zero), insensitivity to edge direction, and ability to detect both light-to-dark and dark-to-light transitions identically. Laplacian filtering excels in geological mapping where structure boundaries appear as zero-crossings, vegetation boundary delineation, road network extraction from high-resolution imagery, and building footprint detection. Output interpretation centers on understanding sign transitions: strong positive values indicate local dark minima, negative values indicate local bright maxima, and zero crossings mark true edges. Typical output ranges from -1000 to +1000 for 8-bit source imagery depending on local contrast. High output magnitude indicates sharp, well-defined edges; low magnitude suggests gradual transitions. Zero-crossing detection requires careful threshold selection. Note that Laplacian is noise-sensitive (amplifies high-frequency noise), so pre-filtering with Gaussian smoothing is commonly recommended before application.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$laplacian_filter(...)
}

wbw_laplacian_filter <- function(...) {
  # The Laplacian filter computes the second spatial derivative of image intensity, providing powerful edge detection via isotropic (all-direction) gradient measurement. The implementation applies a fixed kernel approximating the Laplacian operator (sum of second derivatives in x and y directions), capturing intensity changes regardless of edge orientation. Unlike directional filters, this approach treats all edge directions equally, making it ideal for feature detection requiring orientation-independence. The mathematical foundation rests on the discrete approximation: ∇²I ≈ I(x+1,y) + I(x-1,y) + I(x,y+1) + I(x,y-1) - 4·I(x,y). Key features include zero-crossing detection capability (true edges occur where output crosses zero), insensitivity to edge direction, and ability to detect both light-to-dark and dark-to-light transitions identically. Laplacian filtering excels in geological mapping where structure boundaries appear as zero-crossings, vegetation boundary delineation, road network extraction from high-resolution imagery, and building footprint detection. Output interpretation centers on understanding sign transitions: strong positive values indicate local dark minima, negative values indicate local bright maxima, and zero crossings mark true edges. Typical output ranges from -1000 to +1000 for 8-bit source imagery depending on local contrast. High output magnitude indicates sharp, well-defined edges; low magnitude suggests gradual transitions. Zero-crossing detection requires careful threshold selection. Note that Laplacian is noise-sensitive (amplifies high-frequency noise), so pre-filtering with Gaussian smoothing is commonly recommended before application.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$laplacian_filter(...)
}

laplacian_of_gaussians_filter <- function(...) {
  # Performs Laplacian-of-Gaussians (LoG) edge enhancement combining Gaussian smoothing with Laplacian edge detection. Computationally approximated via difference-of-Gaussians (DoG). First smooths image (reduces noise), then applies Laplacian (detects edges). Classical multi-scale edge detection technique. Zero-crossing detection on LoG output identifies precise edge locations. LoG is standard for scale-space edge detection: Gaussian removes noise, Laplacian amplifies edges. Sigma parameter controls scale of edges detected: small sigma detects fine edges, large sigma detects broad edges. LoG approximated via DoG for efficiency. Multiple sigma values enable multi-scale edge detection (identify features at different scales). Applications: (1) Robust edge detection (noise-resistant), (2) Multi-scale edge detection (use multiple sigma), (3) Zero-crossing edge localization, (4) Preprocessing for segmentation, (5) Blob detection via LoG zero-crossings. Workflow: apply LoG→identify zero-crossings→trace edges→vectorization or further processing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$laplacian_of_gaussians_filter(...)
}

wbw_laplacian_of_gaussians_filter <- function(...) {
  # Performs Laplacian-of-Gaussians (LoG) edge enhancement combining Gaussian smoothing with Laplacian edge detection. Computationally approximated via difference-of-Gaussians (DoG). First smooths image (reduces noise), then applies Laplacian (detects edges). Classical multi-scale edge detection technique. Zero-crossing detection on LoG output identifies precise edge locations. LoG is standard for scale-space edge detection: Gaussian removes noise, Laplacian amplifies edges. Sigma parameter controls scale of edges detected: small sigma detects fine edges, large sigma detects broad edges. LoG approximated via DoG for efficiency. Multiple sigma values enable multi-scale edge detection (identify features at different scales). Applications: (1) Robust edge detection (noise-resistant), (2) Multi-scale edge detection (use multiple sigma), (3) Zero-crossing edge localization, (4) Preprocessing for segmentation, (5) Blob detection via LoG zero-crossings. Workflow: apply LoG→identify zero-crossings→trace edges→vectorization or further processing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$laplacian_of_gaussians_filter(...)
}

las_to_ascii <- function(...) {
  # Format conversion: LAS→CSV output. Exports all point attributes to delimited text for spreadsheet/database import or scripting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$las_to_ascii(...)
}

wbw_las_to_ascii <- function(...) {
  # Format conversion: LAS→CSV output. Exports all point attributes to delimited text for spreadsheet/database import or scripting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$las_to_ascii(...)
}

las_to_shapefile <- function(...) {
  # Converts LAS/LAZ point clouds into vector point shapefiles.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$las_to_shapefile(...)
}

wbw_las_to_shapefile <- function(...) {
  # Converts LAS/LAZ point clouds into vector point shapefiles.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$las_to_shapefile(...)
}

layer_footprint_raster <- function(...) {
  # Creates a polygon footprint representing the full extent of an input raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$layer_footprint_raster(...)
}

wbw_layer_footprint_raster <- function(...) {
  # Creates a polygon footprint representing the full extent of an input raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$layer_footprint_raster(...)
}

layer_footprint_vector <- function(...) {
  # Creates a polygon footprint representing the full bounding extent of an input vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$layer_footprint_vector(...)
}

wbw_layer_footprint_vector <- function(...) {
  # Creates a polygon footprint representing the full bounding extent of an input vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$layer_footprint_vector(...)
}

lee_filter <- function(...) {
  # The Lee filter performs SAR speckle reduction using Lee's multiplicative model, assuming radar returns follow multiplicative noise: I = S·N, where S is signal and N is multiplicative noise. Implementation computes local means and variances, estimating speckle variance, then filters via: F = μ + (1 - σₙ²/σ_I²)·(I - μ), where σₙ² is speckle variance and σ_I² is total variance. This model-based approach preserves high-coherence features while suppressing speckle. Key features include SAR-specific noise model (multiplicative rather than Gaussian), preservation of point targets and edges, straightforward parameter interpretation (window size controls coherence measurement), and proven effectiveness on single-pol and multi-pol SAR. Lee filtering excels in SAR preprocessing for agricultural monitoring, forest classification, ocean-surface monitoring, and flood-mapping workflows. Output interpretation shows that high-coherence regions (point targets, strong edges) filter minimally; low-coherence regions (speckle noise, weak boundaries) filter aggressively. Speckle variance estimation affects output: accurate estimation requires sufficient homogeneous pixels; underestimated variance yields under-smoothing; overestimated variance causes over-smoothing. Window size controls coherence measurement resolution: small windows (3×3) preserve fine detail; large windows (7×7) improve variance estimation but risk detail loss. Output scaling matches input; logarithmic visualization enhances visibility. Typical noise reduction achieves 5-10 dB variance decrease depending on look number. Monitor output histogram for remaining speckle signature; smooth distributions suggest adequate filtering. Artifacts include potential edge blurring in weak-coherence regions and directional bias in linear features. Apply strategically in SAR classification requiring speckle suppression while maintaining classification feature integrity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lee_filter(...)
}

wbw_lee_filter <- function(...) {
  # The Lee filter performs SAR speckle reduction using Lee's multiplicative model, assuming radar returns follow multiplicative noise: I = S·N, where S is signal and N is multiplicative noise. Implementation computes local means and variances, estimating speckle variance, then filters via: F = μ + (1 - σₙ²/σ_I²)·(I - μ), where σₙ² is speckle variance and σ_I² is total variance. This model-based approach preserves high-coherence features while suppressing speckle. Key features include SAR-specific noise model (multiplicative rather than Gaussian), preservation of point targets and edges, straightforward parameter interpretation (window size controls coherence measurement), and proven effectiveness on single-pol and multi-pol SAR. Lee filtering excels in SAR preprocessing for agricultural monitoring, forest classification, ocean-surface monitoring, and flood-mapping workflows. Output interpretation shows that high-coherence regions (point targets, strong edges) filter minimally; low-coherence regions (speckle noise, weak boundaries) filter aggressively. Speckle variance estimation affects output: accurate estimation requires sufficient homogeneous pixels; underestimated variance yields under-smoothing; overestimated variance causes over-smoothing. Window size controls coherence measurement resolution: small windows (3×3) preserve fine detail; large windows (7×7) improve variance estimation but risk detail loss. Output scaling matches input; logarithmic visualization enhances visibility. Typical noise reduction achieves 5-10 dB variance decrease depending on look number. Monitor output histogram for remaining speckle signature; smooth distributions suggest adequate filtering. Artifacts include potential edge blurring in weak-coherence regions and directional bias in linear features. Apply strategically in SAR classification requiring speckle suppression while maintaining classification feature integrity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lee_filter(...)
}

length_of_upstream_channels <- function(...) {
  # Calculates total upstream channel length.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$length_of_upstream_channels(...)
}

wbw_length_of_upstream_channels <- function(...) {
  # Calculates total upstream channel length.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$length_of_upstream_channels(...)
}

less_than <- function(...) {
  # Tests whether the first raster is less than the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$less_than(...)
}

wbw_less_than <- function(...) {
  # Tests whether the first raster is less than the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$less_than(...)
}

less_than_or_equal_to <- function(...) {
  # Tests whether the first raster is less than or equal to the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$less_than_or_equal_to(...)
}

wbw_less_than_or_equal_to <- function(...) {
  # Tests whether the first raster is less than or equal to the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$less_than_or_equal_to(...)
}

lidar_block_maximum <- function(...) {
  # Raster from max LiDAR attribute: cell value = highest point return (elevation, intensity, class, etc.). DSM generation, canopy top extraction, pulse statistics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_block_maximum(...)
}

wbw_lidar_block_maximum <- function(...) {
  # Raster from max LiDAR attribute: cell value = highest point return (elevation, intensity, class, etc.). DSM generation, canopy top extraction, pulse statistics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_block_maximum(...)
}

lidar_block_minimum <- function(...) {
  # Raster from min LiDAR attribute: cell value = lowest point return (elevation, intensity, class). DEM generation, ground surface extraction, terrain baselining.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_block_minimum(...)
}

wbw_lidar_block_minimum <- function(...) {
  # Raster from min LiDAR attribute: cell value = lowest point return (elevation, intensity, class). DEM generation, ground surface extraction, terrain baselining.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_block_minimum(...)
}

lidar_classify_subset <- function(...) {
  # Transfers classification: marks base points matching subset cloud locations. Allows spatial reclassification based on auxiliary point sets.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_classify_subset(...)
}

wbw_lidar_classify_subset <- function(...) {
  # Transfers classification: marks base points matching subset cloud locations. Allows spatial reclassification based on auxiliary point sets.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_classify_subset(...)
}

lidar_colourize <- function(...) {
  # Assigns point colors from image: samples overlapping orthophoto/georeferenced image at each point location, stores as RGB. Photorealistic point-cloud rendering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_colourize(...)
}

wbw_lidar_colourize <- function(...) {
  # Assigns point colors from image: samples overlapping orthophoto/georeferenced image at each point location, stores as RGB. Photorealistic point-cloud rendering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_colourize(...)
}

lidar_construct_vector_tin <- function(...) {
  # Builds 3D mesh: Delaunay triangulation from filtered points outputs as vector polygon layer. Surface representation and topographic analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_construct_vector_tin(...)
}

wbw_lidar_construct_vector_tin <- function(...) {
  # Builds 3D mesh: Delaunay triangulation from filtered points outputs as vector polygon layer. Surface representation and topographic analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_construct_vector_tin(...)
}

lidar_contour <- function(...) {
  # Extracts contour vector lines: TIN-based contouring with interpolation for elevation, intensity, time. Configurable intervals and edge-length filtering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_contour(...)
}

wbw_lidar_contour <- function(...) {
  # Extracts contour vector lines: TIN-based contouring with interpolation for elevation, intensity, time. Configurable intervals and edge-length filtering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_contour(...)
}

lidar_digital_surface_model <- function(...) {
  # Generates DSM from LiDAR top-surface returns via TIN: uses local highest-point candidates within radius, then triangulation. Vegetation canopy and feature-top representation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_digital_surface_model(...)
}

wbw_lidar_digital_surface_model <- function(...) {
  # Generates DSM from LiDAR top-surface returns via TIN: uses local highest-point candidates within radius, then triangulation. Vegetation canopy and feature-top representation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_digital_surface_model(...)
}

lidar_eigenvalue_features <- function(...) {
  # Derives PCA features: eigenvalues/vectors from neighborhoods. Shape descriptors (planarity, linearity, height-variance) for point cloud analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_eigenvalue_features(...)
}

wbw_lidar_eigenvalue_features <- function(...) {
  # Derives PCA features: eigenvalues/vectors from neighborhoods. Shape descriptors (planarity, linearity, height-variance) for point cloud analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_eigenvalue_features(...)
}

lidar_elevation_slice <- function(...) {
  # Extracts elevation-band points: filters or reclassifies points within z-range. Isolates specific layers (ground, understory, canopy) or elevation zones.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_elevation_slice(...)
}

wbw_lidar_elevation_slice <- function(...) {
  # Extracts elevation-band points: filters or reclassifies points within z-range. Isolates specific layers (ground, understory, canopy) or elevation zones.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_elevation_slice(...)
}

lidar_ground_point_filter <- function(...) {
  # Separates terrain from off-ground points: slope-based classification/filtering using local plane geometry and height thresholds. Efficient ground segmentation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_ground_point_filter(...)
}

wbw_lidar_ground_point_filter <- function(...) {
  # Separates terrain from off-ground points: slope-based classification/filtering using local plane geometry and height thresholds. Efficient ground segmentation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_ground_point_filter(...)
}

lidar_hex_bin <- function(...) {
  # Aggregates points to hexagons: binning grid with per-cell summaries (count, mean-z, intensity). Uniform sampling and statistical binning.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_hex_bin(...)
}

wbw_lidar_hex_bin <- function(...) {
  # Aggregates points to hexagons: binning grid with per-cell summaries (count, mean-z, intensity). Uniform sampling and statistical binning.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_hex_bin(...)
}

lidar_hillshade <- function(...) {
  # Renders LiDAR surface via hillshade: computes per-point surface normals from local plane-fit, then shades by illumination angle. Stores as RGB for 3D visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_hillshade(...)
}

wbw_lidar_hillshade <- function(...) {
  # Renders LiDAR surface via hillshade: computes per-point surface normals from local plane-fit, then shades by illumination angle. Stores as RGB for 3D visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_hillshade(...)
}

lidar_histogram <- function(...) {
  # Computes attribute distribution: frequency histogram for elevation, intensity, scan-angle, class. Clipped percentiles for outlier suppression. HTML visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_histogram(...)
}

wbw_lidar_histogram <- function(...) {
  # Computes attribute distribution: frequency histogram for elevation, intensity, scan-angle, class. Clipped percentiles for outlier suppression. HTML visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_histogram(...)
}

lidar_idw_interpolation <- function(...) {
  # Distance-weighted LiDAR gridding: assigns cell value from weighted mean of surrounding points (inverse distance power). Smooth surfaces, control via exponent parameter.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_idw_interpolation(...)
}

wbw_lidar_idw_interpolation <- function(...) {
  # Distance-weighted LiDAR gridding: assigns cell value from weighted mean of surrounding points (inverse distance power). Smooth surfaces, control via exponent parameter.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_idw_interpolation(...)
}

lidar_info <- function(...) {
  # Generates metadata summary report: point count, extent, intensity range, class histogram, return distribution. HTML/text output for data documentation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_info(...)
}

wbw_lidar_info <- function(...) {
  # Generates metadata summary report: point count, extent, intensity range, class histogram, return distribution. HTML/text output for data documentation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_info(...)
}

lidar_join <- function(...) {
  # Merges multiple LiDAR files: concatenates point clouds while preserving attributes and header consistency. Batch processing across tile collections.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_join(...)
}

wbw_lidar_join <- function(...) {
  # Merges multiple LiDAR files: concatenates point clouds while preserving attributes and header consistency. Batch processing across tile collections.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_join(...)
}

lidar_kappa <- function(...) {
  # Computes a kappa agreement report between two classified LiDAR clouds and writes a class-agreement raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_kappa(...)
}

wbw_lidar_kappa <- function(...) {
  # Computes a kappa agreement report between two classified LiDAR clouds and writes a class-agreement raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_kappa(...)
}

lidar_nearest_neighbour_gridding <- function(...) {
  # Fast LiDAR gridding: assigns cell value from nearest point within search radius. Minimal interpolation bias, efficient for high-density point clouds. Quick DSM/DEM generation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_nearest_neighbour_gridding(...)
}

wbw_lidar_nearest_neighbour_gridding <- function(...) {
  # Fast LiDAR gridding: assigns cell value from nearest point within search radius. Minimal interpolation bias, efficient for high-density point clouds. Quick DSM/DEM generation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_nearest_neighbour_gridding(...)
}

lidar_point_density <- function(...) {
  # Maps LiDAR sampling intensity: point count per unit area (counts within radius per cell). Data-quality assessment, coverage analysis, acquisition-pattern visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_point_density(...)
}

wbw_lidar_point_density <- function(...) {
  # Maps LiDAR sampling intensity: point count per unit area (counts within radius per cell). Data-quality assessment, coverage analysis, acquisition-pattern visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_point_density(...)
}

lidar_point_return_analysis <- function(...) {
  # QA tool: audits return sequence validity (multi/first/last consistency). Generates report + classified output marking return anomalies. Data integrity check.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_point_return_analysis(...)
}

wbw_lidar_point_return_analysis <- function(...) {
  # QA tool: audits return sequence validity (multi/first/last consistency). Generates report + classified output marking return anomalies. Data integrity check.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_point_return_analysis(...)
}

lidar_point_stats <- function(...) {
  # Creates raster statistics grids: point count, pulse count, avg-points/pulse, z/intensity range, predominant-class per cell. Multi-output analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_point_stats(...)
}

wbw_lidar_point_stats <- function(...) {
  # Creates raster statistics grids: point count, pulse count, avg-points/pulse, z/intensity range, predominant-class per cell. Multi-output analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_point_stats(...)
}

lidar_radial_basis_function_interpolation <- function(...) {
  # Smooth LiDAR surface via RBF: radial basis functions capture local curvature and micro-topography. High-quality gridding with continuous derivatives across boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_radial_basis_function_interpolation(...)
}

wbw_lidar_radial_basis_function_interpolation <- function(...) {
  # Smooth LiDAR surface via RBF: radial basis functions capture local curvature and micro-topography. High-quality gridding with continuous derivatives across boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_radial_basis_function_interpolation(...)
}

lidar_ransac_planes <- function(...) {
  # Identifies locally planar LiDAR points using neighbourhood RANSAC plane fitting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_ransac_planes(...)
}

wbw_lidar_ransac_planes <- function(...) {
  # Identifies locally planar LiDAR points using neighbourhood RANSAC plane fitting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_ransac_planes(...)
}

lidar_remove_outliers <- function(...) {
  # Detects outlier points via local elevation residuals: compares point to neighborhood mean/median, flags anomalies. Removes erratic blunders and noise.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_remove_outliers(...)
}

wbw_lidar_remove_outliers <- function(...) {
  # Detects outlier points via local elevation residuals: compares point to neighborhood mean/median, flags anomalies. Removes erratic blunders and noise.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_remove_outliers(...)
}

lidar_rooftop_analysis <- function(...) {
  # Identifies planar rooftop segments within building footprints and outputs segment polygons with roof attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_rooftop_analysis(...)
}

wbw_lidar_rooftop_analysis <- function(...) {
  # Identifies planar rooftop segments within building footprints and outputs segment polygons with roof attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_rooftop_analysis(...)
}

lidar_segmentation <- function(...) {
  # Partitions point cloud: RANSAC plane fitting + region-growing creates connected components. Assigns segment IDs stored in RGB. Shape-based point clustering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_segmentation(...)
}

wbw_lidar_segmentation <- function(...) {
  # Partitions point cloud: RANSAC plane fitting + region-growing creates connected components. Assigns segment IDs stored in RGB. Shape-based point clustering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_segmentation(...)
}

lidar_segmentation_based_filter <- function(...) {
  # Ground filtering via low-relief segmentation: grows connected components from locally flat regions, separates terrain from vegetation. Robust ground separation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_segmentation_based_filter(...)
}

wbw_lidar_segmentation_based_filter <- function(...) {
  # Ground filtering via low-relief segmentation: grows connected components from locally flat regions, separates terrain from vegetation. Robust ground separation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_segmentation_based_filter(...)
}

lidar_shift <- function(...) {
  # Translates point cloud coordinates: x/y/z offsets for datum shifts, registration corrections, or coordinate system transformations. Bulk coordinate adjustment.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_shift(...)
}

wbw_lidar_shift <- function(...) {
  # Translates point cloud coordinates: x/y/z offsets for datum shifts, registration corrections, or coordinate system transformations. Bulk coordinate adjustment.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_shift(...)
}

lidar_sibson_interpolation <- function(...) {
  # Natural-neighbour LiDAR gridding: Voronoi-based interpolation using natural-neighbour weights. Smooth, natural-looking surfaces without slope artifacts at point locations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_sibson_interpolation(...)
}

wbw_lidar_sibson_interpolation <- function(...) {
  # Natural-neighbour LiDAR gridding: Voronoi-based interpolation using natural-neighbour weights. Smooth, natural-looking surfaces without slope artifacts at point locations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_sibson_interpolation(...)
}

lidar_thin <- function(...) {
  # Decimates point cloud density: retains ≤1 point per grid cell using first/last/lowest/highest/nearest strategy. Reduces storage while preserving coverage and topographic complexity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_thin(...)
}

wbw_lidar_thin <- function(...) {
  # Decimates point cloud density: retains ≤1 point per grid cell using first/last/lowest/highest/nearest strategy. Reduces storage while preserving coverage and topographic complexity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_thin(...)
}

lidar_thin_high_density <- function(...) {
  # Adaptive density decimation: reduces point count in over-dense zones while preserving sparse regions. Equalizes sampling across variable flight-line overlap patterns.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_thin_high_density(...)
}

wbw_lidar_thin_high_density <- function(...) {
  # Adaptive density decimation: reduces point count in over-dense zones while preserving sparse regions. Equalizes sampling across variable flight-line overlap patterns.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_thin_high_density(...)
}

lidar_tile <- function(...) {
  # Splits point cloud into regular grid tiles: partitions by x/y extent with configurable dimensions and minimum point threshold. Standard data distribution and processing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_tile(...)
}

wbw_lidar_tile <- function(...) {
  # Splits point cloud into regular grid tiles: partitions by x/y extent with configurable dimensions and minimum point threshold. Standard data distribution and processing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_tile(...)
}

lidar_tile_footprint <- function(...) {
  # Generates footprints: axis-aligned bounding boxes or convex hulls per point cloud. Vector polygon output for spatial indexing and data catalog.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_tile_footprint(...)
}

wbw_lidar_tile_footprint <- function(...) {
  # Generates footprints: axis-aligned bounding boxes or convex hulls per point cloud. Vector polygon output for spatial indexing and data catalog.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_tile_footprint(...)
}

lidar_tin_gridding <- function(...) {
  # Exact LiDAR interpolation via TIN: builds Delaunay triangulation from points, interpolates cell values from triangle planes. Respects point heights, excellent for irregular coverage.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_tin_gridding(...)
}

wbw_lidar_tin_gridding <- function(...) {
  # Exact LiDAR interpolation via TIN: builds Delaunay triangulation from points, interpolates cell values from triangle planes. Respects point heights, excellent for irregular coverage.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_tin_gridding(...)
}

lidar_tophat_transform <- function(...) {
  # Extracts height above ground via morphological white top-hat: erosion + dilation approximates local ground, residual = height. Ground-free normalization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_tophat_transform(...)
}

wbw_lidar_tophat_transform <- function(...) {
  # Extracts height above ground via morphological white top-hat: erosion + dilation approximates local ground, residual = height. Ground-free normalization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lidar_tophat_transform(...)
}

line_detection_filter <- function(...) {
  # The line detection filter is a specialized edge detector designed to enhance linear features—roads, rivers, powerlines, and geological lineaments—across four cardinal directions (horizontal, vertical, and both diagonals) by applying directional convolution kernels optimized for line connectivity and continuity. This filter employs 3×3 kernels that emphasize linear structures aligned with each cardinal direction while suppressing perpendicular noise and random feature variations. The directional approach separates detections by orientation, enabling downstream applications to distinguish horizontal infrastructure (pipelines, field boundaries) from vertical structures (tree rows, utility corridors). Key features include multi-directional decomposition generating separate magnitude and direction bands, adaptive sensitivity tuning for line width and contrast variations, and exceptional performance on subtle linear features embedded in complex terrain. Use cases span infrastructure mapping (roads, railways, powerlines), natural feature extraction (streams, ridges, faults), and land-use boundary delineation. Applications include vector conversion preprocessing for cadastral digitization, transportation network extraction from orthophotography, geological structure mapping from satellite imagery, and pattern recognition in remote sensing analysis. Output interpretation requires understanding that each directional component reveals line strength in that specific orientation—examine all four cardinal outputs to identify predominant feature directions. Higher magnitude values indicate stronger line continuity; low values suggest noise or breaks. The output is naturally sparse, highlighting only pixels representing linear features; background areas remain near-zero. Multi-directional output enables post-classification where roads (typically horizontal/vertical in built areas) are distinguished from natural lineaments (arbitrary orientation). Combine directional components to generate unified line map or analyze each direction separately for oriented structure mapping.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$line_detection_filter(...)
}

wbw_line_detection_filter <- function(...) {
  # The line detection filter is a specialized edge detector designed to enhance linear features—roads, rivers, powerlines, and geological lineaments—across four cardinal directions (horizontal, vertical, and both diagonals) by applying directional convolution kernels optimized for line connectivity and continuity. This filter employs 3×3 kernels that emphasize linear structures aligned with each cardinal direction while suppressing perpendicular noise and random feature variations. The directional approach separates detections by orientation, enabling downstream applications to distinguish horizontal infrastructure (pipelines, field boundaries) from vertical structures (tree rows, utility corridors). Key features include multi-directional decomposition generating separate magnitude and direction bands, adaptive sensitivity tuning for line width and contrast variations, and exceptional performance on subtle linear features embedded in complex terrain. Use cases span infrastructure mapping (roads, railways, powerlines), natural feature extraction (streams, ridges, faults), and land-use boundary delineation. Applications include vector conversion preprocessing for cadastral digitization, transportation network extraction from orthophotography, geological structure mapping from satellite imagery, and pattern recognition in remote sensing analysis. Output interpretation requires understanding that each directional component reveals line strength in that specific orientation—examine all four cardinal outputs to identify predominant feature directions. Higher magnitude values indicate stronger line continuity; low values suggest noise or breaks. The output is naturally sparse, highlighting only pixels representing linear features; background areas remain near-zero. Multi-directional output enables post-classification where roads (typically horizontal/vertical in built areas) are distinguished from natural lineaments (arbitrary orientation). Combine directional components to generate unified line map or analyze each direction separately for oriented structure mapping.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$line_detection_filter(...)
}

line_intersections <- function(...) {
  # Finds line intersection points between input and overlay layers and appends parent IDs with merged attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$line_intersections(...)
}

wbw_line_intersections <- function(...) {
  # Finds line intersection points between input and overlay layers and appends parent IDs with merged attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$line_intersections(...)
}

line_polygon_clip <- function(...) {
  # Clips line features to polygon interiors and outputs clipped line segments.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$line_polygon_clip(...)
}

wbw_line_polygon_clip <- function(...) {
  # Clips line features to polygon interiors and outputs clipped line segments.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$line_polygon_clip(...)
}

line_thinning <- function(...) {
  # Reduces connected binary raster features to one-cell-wide skeleton lines.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$line_thinning(...)
}

wbw_line_thinning <- function(...) {
  # Reduces connected binary raster features to one-cell-wide skeleton lines.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$line_thinning(...)
}

linear_spectral_unmixing <- function(...) {
  # Linear spectral unmixing decomposes each pixel's multispectral vector as non-negative linear combination of endmember spectra representing pure material signatures. Non-negative least-squares optimization solves min ||y - Ax||² subject to x ≥ 0, where y is pixel spectrum, A contains endmember signatures, and x represents abundance fractions. Sum-to-one constraint enforced ensuring abundance values represent physical proportions. Endmembers derived from training data, library databases, or extracted via endmember extraction algorithms. Key Features: Sub-pixel material estimation; abundance fractions physical interpretation; supports multiple endmembers; output constrained to valid ranges [0,1]; enables material change detection. Use Cases: Landcover abundance mapping; mineral composition estimation; urban material inventory; vegetation/soil/impervious surface fractions; spectral library-based classification. Output Interpretation: Output abundance maps show per-pixel material fractions summing to 1.0. Abundances <0.1 indicate minor components; abundances >0.7 indicate dominant materials. Residual error indicates unmixing quality; low residuals indicate good spectral fit; high residuals indicate endmember mismatch or pixel complexity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$linear_spectral_unmixing(...)
}

wbw_linear_spectral_unmixing <- function(...) {
  # Linear spectral unmixing decomposes each pixel's multispectral vector as non-negative linear combination of endmember spectra representing pure material signatures. Non-negative least-squares optimization solves min ||y - Ax||² subject to x ≥ 0, where y is pixel spectrum, A contains endmember signatures, and x represents abundance fractions. Sum-to-one constraint enforced ensuring abundance values represent physical proportions. Endmembers derived from training data, library databases, or extracted via endmember extraction algorithms. Key Features: Sub-pixel material estimation; abundance fractions physical interpretation; supports multiple endmembers; output constrained to valid ranges [0,1]; enables material change detection. Use Cases: Landcover abundance mapping; mineral composition estimation; urban material inventory; vegetation/soil/impervious surface fractions; spectral library-based classification. Output Interpretation: Output abundance maps show per-pixel material fractions summing to 1.0. Abundances <0.1 indicate minor components; abundances >0.7 indicate dominant materials. Residual error indicates unmixing quality; low residuals indicate good spectral fit; high residuals indicate endmember mismatch or pixel complexity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$linear_spectral_unmixing(...)
}

linearity_index <- function(...) {
  # Computes linearity index (regression r-squared) for polygon features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$linearity_index(...)
}

wbw_linearity_index <- function(...) {
  # Computes linearity index (regression r-squared) for polygon features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$linearity_index(...)
}

lines_to_polygons <- function(...) {
  # Converts polyline features into polygon features, treating the first part as the exterior ring and later parts as holes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lines_to_polygons(...)
}

wbw_lines_to_polygons <- function(...) {
  # Converts polyline features into polygon features, treating the first part as the exterior ring and later parts as holes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lines_to_polygons(...)
}

list_unique_values <- function(...) {
  # Lists unique values and frequencies in a vector attribute field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$list_unique_values(...)
}

wbw_list_unique_values <- function(...) {
  # Lists unique values and frequencies in a vector attribute field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$list_unique_values(...)
}

list_unique_values_raster <- function(...) {
  # Lists unique valid raster categories and their frequencies.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$list_unique_values_raster(...)
}

wbw_list_unique_values_raster <- function(...) {
  # Lists unique valid raster categories and their frequencies.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$list_unique_values_raster(...)
}

ln <- function(...) {
  # Computes the natural logarithm of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ln(...)
}

wbw_ln <- function(...) {
  # Computes the natural logarithm of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ln(...)
}

local_hypsometric_analysis <- function(...) {
  # Computes the minimum local hypsometric integral across a nonlinearly sampled range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$local_hypsometric_analysis(...)
}

wbw_local_hypsometric_analysis <- function(...) {
  # Computes the minimum local hypsometric integral across a nonlinearly sampled range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$local_hypsometric_analysis(...)
}

local_kriging <- function(...) {
  # Performs local ordinary kriging using k-nearest neighbors. Efficient for large datasets. Requires a pre-fitted variogram model (from fit_variogram).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$local_kriging(...)
}

wbw_local_kriging <- function(...) {
  # Performs local ordinary kriging using k-nearest neighbors. Efficient for large datasets. Requires a pre-fitted variogram model (from fit_variogram).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$local_kriging(...)
}

local_morans_i_lisa <- function(...) {
  # Computes Local Moran's I for each feature to identify local spatial clusters and outliers with statistical significance testing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$local_morans_i_lisa(...)
}

wbw_local_morans_i_lisa <- function(...) {
  # Computes Local Moran's I for each feature to identify local spatial clusters and outliers with statistical significance testing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$local_morans_i_lisa(...)
}

local_morans_i_lisa_raster <- function(...) {
  # Computes LISA cluster analysis from points and outputs categorical raster (HH/LL/HL/LH/NS). Enables raster-based integration.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$local_morans_i_lisa_raster(...)
}

wbw_local_morans_i_lisa_raster <- function(...) {
  # Computes LISA cluster analysis from points and outputs categorical raster (HH/LL/HL/LH/NS). Enables raster-based integration.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$local_morans_i_lisa_raster(...)
}

locate_points_along_routes <- function(...) {
  # Locates point features along route lines and writes route-measure attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$locate_points_along_routes(...)
}

wbw_locate_points_along_routes <- function(...) {
  # Locates point features along route lines and writes route-measure attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$locate_points_along_routes(...)
}

location_allocation_network <- function(...) {
  # Selects k facilities and allocates demand points by network cost with greedy or exact solving, optional capacities, and required/forbidden candidate constraints.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$location_allocation_network(...)
}

wbw_location_allocation_network <- function(...) {
  # Selects k facilities and allocates demand points by network cost with greedy or exact solving, optional capacities, and required/forbidden candidate constraints.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$location_allocation_network(...)
}

log10 <- function(...) {
  # Computes the base-10 logarithm of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$log10(...)
}

wbw_log10 <- function(...) {
  # Computes the base-10 logarithm of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$log10(...)
}

log2 <- function(...) {
  # Computes the base-2 logarithm of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$log2(...)
}

wbw_log2 <- function(...) {
  # Computes the base-2 logarithm of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$log2(...)
}

logistic_regression <- function(...) {
  # Performs supervised logistic regression classification on multi-band input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$logistic_regression(...)
}

wbw_logistic_regression <- function(...) {
  # Performs supervised logistic regression classification on multi-band input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$logistic_regression(...)
}

long_profile <- function(...) {
  # Creates longitudinal stream profile.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$long_profile(...)
}

wbw_long_profile <- function(...) {
  # Creates longitudinal stream profile.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$long_profile(...)
}

long_profile_from_points <- function(...) {
  # Creates long profile from vector points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$long_profile_from_points(...)
}

wbw_long_profile_from_points <- function(...) {
  # Creates long profile from vector points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$long_profile_from_points(...)
}

longest_flowpath <- function(...) {
  # Delineates longest flowpath lines for each basin in a basin raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$longest_flowpath(...)
}

wbw_longest_flowpath <- function(...) {
  # Delineates longest flowpath lines for each basin in a basin raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$longest_flowpath(...)
}

low_points_on_headwater_divides <- function(...) {
  # Locates low pass points along divides between neighboring headwater subbasins.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$low_points_on_headwater_divides(...)
}

wbw_low_points_on_headwater_divides <- function(...) {
  # Locates low pass points along divides between neighboring headwater subbasins.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$low_points_on_headwater_divides(...)
}

lowest_position <- function(...) {
  # Returns the zero-based raster-stack index containing the lowest value at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lowest_position(...)
}

wbw_lowest_position <- function(...) {
  # Returns the zero-based raster-stack index containing the lowest value at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$lowest_position(...)
}

majority_filter <- function(...) {
  # Computes moving-window mode (most frequent value/class) for each pixel. Non-linear filter preserving categorical boundaries and dominant patterns. Particularly useful for classified imagery where output must remain within original class set (unlike mean filter which creates interpolated values). Essential for morphological cleaning of classification outputs.  Majority filtering is the mode-based equivalent of median filtering. For categorical data (classified imagery, land cover), majority preserves class definitions while smoothing noise. For continuous data, majority can reveal local peaks in value distribution. Often followed by minority class elimination (post-classification cleanup) to remove "salt-and-pepper" classification artifacts.  Applications: (1) Post-classification smoothing (removes small spurious class patches), (2) Majority class map from multi-classified outputs, (3) Vector data cleaning (class disaggregation), (4) Noise suppression in thresholded imagery, (5) Attribute smoothing in segmentation outputs. Typical workflow: classify→majority filter→minority elimination→final cleaned map.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$majority_filter(...)
}

wbw_majority_filter <- function(...) {
  # Computes moving-window mode (most frequent value/class) for each pixel. Non-linear filter preserving categorical boundaries and dominant patterns. Particularly useful for classified imagery where output must remain within original class set (unlike mean filter which creates interpolated values). Essential for morphological cleaning of classification outputs.  Majority filtering is the mode-based equivalent of median filtering. For categorical data (classified imagery, land cover), majority preserves class definitions while smoothing noise. For continuous data, majority can reveal local peaks in value distribution. Often followed by minority class elimination (post-classification cleanup) to remove "salt-and-pepper" classification artifacts.  Applications: (1) Post-classification smoothing (removes small spurious class patches), (2) Majority class map from multi-classified outputs, (3) Vector data cleaning (class disaggregation), (4) Noise suppression in thresholded imagery, (5) Attribute smoothing in segmentation outputs. Typical workflow: classify→majority filter→minority elimination→final cleaned map.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$majority_filter(...)
}

map_features <- function(...) {
  # Maps discrete elevated terrain features from a raster using descending-priority region growth.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$map_features(...)
}

wbw_map_features <- function(...) {
  # Maps discrete elevated terrain features from a raster using descending-priority region growth.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$map_features(...)
}

map_matching_v1 <- function(...) {
  # Snaps trajectory points onto a line network and reconstructs an inferred route with diagnostics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$map_matching_v1(...)
}

wbw_map_matching_v1 <- function(...) {
  # Snaps trajectory points onto a line network and reconstructs an inferred route with diagnostics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$map_matching_v1(...)
}

map_off_terrain_objects <- function(...) {
  # Maps off-terrain object segments in DSMs using slope-constrained region growing and optional minimum feature-size filtering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$map_off_terrain_objects(...)
}

wbw_map_off_terrain_objects <- function(...) {
  # Maps off-terrain object segments in DSMs using slope-constrained region growing and optional minimum feature-size filtering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$map_off_terrain_objects(...)
}

max <- function(...) {
  # Performs a MAX operation on two rasters or a raster and a constant value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max(...)
}

wbw_max <- function(...) {
  # Performs a MAX operation on two rasters or a raster and a constant value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max(...)
}

max_absolute_overlay <- function(...) {
  # Computes the per-cell maximum absolute value across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_absolute_overlay(...)
}

wbw_max_absolute_overlay <- function(...) {
  # Computes the per-cell maximum absolute value across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_absolute_overlay(...)
}

max_anisotropy_dev <- function(...) {
  # Calculates maximum anisotropy in elevation deviation over a range of neighbourhood scales. Written by Dan Newman.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_anisotropy_dev(...)
}

wbw_max_anisotropy_dev <- function(...) {
  # Calculates maximum anisotropy in elevation deviation over a range of neighbourhood scales. Written by Dan Newman.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_anisotropy_dev(...)
}

max_anisotropy_dev_signature <- function(...) {
  # Calculates multiscale anisotropy signatures for input point sites and writes an HTML report. Written by Dan Newman.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_anisotropy_dev_signature(...)
}

wbw_max_anisotropy_dev_signature <- function(...) {
  # Calculates multiscale anisotropy signatures for input point sites and writes an HTML report. Written by Dan Newman.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_anisotropy_dev_signature(...)
}

max_branch_length <- function(...) {
  # Calculates maximum branch length between neighbouring D8 flowpaths, useful for highlighting divides.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_branch_length(...)
}

wbw_max_branch_length <- function(...) {
  # Calculates maximum branch length between neighbouring D8 flowpaths, useful for highlighting divides.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_branch_length(...)
}

max_difference_from_mean <- function(...) {
  # Calculates maximum absolute difference-from-mean over a range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_difference_from_mean(...)
}

wbw_max_difference_from_mean <- function(...) {
  # Calculates maximum absolute difference-from-mean over a range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_difference_from_mean(...)
}

max_downslope_elev_change <- function(...) {
  # Calculates the maximum elevation drop to lower neighbouring cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_downslope_elev_change(...)
}

wbw_max_downslope_elev_change <- function(...) {
  # Calculates the maximum elevation drop to lower neighbouring cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_downslope_elev_change(...)
}

max_elev_dev_signature <- function(...) {
  # Calculates multiscale elevation-deviation signatures for input point sites and writes an HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_elev_dev_signature(...)
}

wbw_max_elev_dev_signature <- function(...) {
  # Calculates multiscale elevation-deviation signatures for input point sites and writes an HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_elev_dev_signature(...)
}

max_elevation_deviation <- function(...) {
  # Calculates maximum standardized elevation deviation (DEVmax) over a range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_elevation_deviation(...)
}

wbw_max_elevation_deviation <- function(...) {
  # Calculates maximum standardized elevation deviation (DEVmax) over a range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_elevation_deviation(...)
}

max_overlay <- function(...) {
  # Computes the per-cell maximum across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_overlay(...)
}

wbw_max_overlay <- function(...) {
  # Computes the per-cell maximum across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_overlay(...)
}

max_upslope_elev_change <- function(...) {
  # Calculates the maximum elevation gain to higher neighbouring cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_upslope_elev_change(...)
}

wbw_max_upslope_elev_change <- function(...) {
  # Calculates the maximum elevation gain to higher neighbouring cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_upslope_elev_change(...)
}

max_upslope_flowpath_length <- function(...) {
  # Computes the maximum upslope flowpath length passing through each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_upslope_flowpath_length(...)
}

wbw_max_upslope_flowpath_length <- function(...) {
  # Computes the maximum upslope flowpath length passing through each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_upslope_flowpath_length(...)
}

max_upslope_value <- function(...) {
  # Propagates maximum upslope value along D8 flowpaths over a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_upslope_value(...)
}

wbw_max_upslope_value <- function(...) {
  # Propagates maximum upslope value along D8 flowpaths over a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$max_upslope_value(...)
}

maximal_curvature <- function(...) {
  # Calculates maximal (maximum principal) curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$maximal_curvature(...)
}

wbw_maximal_curvature <- function(...) {
  # Calculates maximal (maximum principal) curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$maximal_curvature(...)
}

maximum_filter <- function(...) {
  # Computes moving-window maximum value, revealing local peaks and ridges. Dilation operator in morphological image processing. Useful for detecting peaks, ridgelines, and maximum-amplitude features. Sensitive to single outlier (one high value in window produces high output).  Maximum filter is the morphological "dilation" operator—expands light regions and shrinks dark regions. When applied repeatedly (multi-pass dilation), creates smoothed peaks and isolated features grow to fill their neighborhoods. Combined with minimum filter enables closing (dilation then erosion) and opening (erosion then dilation). Essential for morphological feature detection and multi-scale analysis.  Applications: (1) Morphological dilation for size-based filtering, (2) Closing via dilation→erosion to fill small holes, (3) Peak/ridge identification in terrain and imagery, (4) Local ceiling level in bathymetry/DEM, (5) Multi-scale feature analysis (compare dilation across scales). Typical workflow: maximum→comparison with minimum→closing or opening depending on feature type.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$maximum_filter(...)
}

wbw_maximum_filter <- function(...) {
  # Computes moving-window maximum value, revealing local peaks and ridges. Dilation operator in morphological image processing. Useful for detecting peaks, ridgelines, and maximum-amplitude features. Sensitive to single outlier (one high value in window produces high output).  Maximum filter is the morphological "dilation" operator—expands light regions and shrinks dark regions. When applied repeatedly (multi-pass dilation), creates smoothed peaks and isolated features grow to fill their neighborhoods. Combined with minimum filter enables closing (dilation then erosion) and opening (erosion then dilation). Essential for morphological feature detection and multi-scale analysis.  Applications: (1) Morphological dilation for size-based filtering, (2) Closing via dilation→erosion to fill small holes, (3) Peak/ridge identification in terrain and imagery, (4) Local ceiling level in bathymetry/DEM, (5) Multi-scale feature analysis (compare dilation across scales). Typical workflow: maximum→comparison with minimum→closing or opening depending on feature type.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$maximum_filter(...)
}

mdinf_flow_accum <- function(...) {
  # Multiple-flow accumulation with slope-gradient weighting (exponent 1.1). Balances dispersal realism with concentrated main-flow identification. Outputs: cells, CA, or SCA.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mdinf_flow_accum(...)
}

wbw_mdinf_flow_accum <- function(...) {
  # Multiple-flow accumulation with slope-gradient weighting (exponent 1.1). Balances dispersal realism with concentrated main-flow identification. Outputs: cells, CA, or SCA.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mdinf_flow_accum(...)
}

mean_curvature <- function(...) {
  # Calculates mean curvature (average of principal curvatures). Related to total curvature but emphasizes surface smoothness. Values close to 0 indicate smooth terrain; high values indicate abrupt curvature changes. Useful for surface characterization and breakline detection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mean_curvature(...)
}

wbw_mean_curvature <- function(...) {
  # Calculates mean curvature (average of principal curvatures). Related to total curvature but emphasizes surface smoothness. Values close to 0 indicate smooth terrain; high values indicate abrupt curvature changes. Useful for surface characterization and breakline detection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mean_curvature(...)
}

mean_filter <- function(...) {
  # Computes moving-window mean (average) for each pixel. Fundamental smoothing operation reducing local noise while blurring sharp transitions. Output represents local central tendency. Widely used for preprocessing, noise reduction, and multi-scale analysis.  Mean filtering is the most common low-pass smoothing operation. Highly sensitive to outliers (extreme values can distort results), making median filter preferable for noisy data. Computationally efficient. Filter size controls smoothing extent: small (3×3) preserves detail, large (31×31+) creates heavily smoothed surface. Often applied iteratively or at multiple scales for multi-resolution analysis.  Applications: (1) Basic noise reduction, (2) Preprocessing before feature detection (smooths false positives), (3) Multi-scale analysis (apply at 3×3, 11×11, 31×31), (4) Temporal smoothing (combining scenes), (5) Baseline for other statistical operations. Compare with median (non-linear, preserves edges) for improved edge preservation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mean_filter(...)
}

wbw_mean_filter <- function(...) {
  # Computes moving-window mean (average) for each pixel. Fundamental smoothing operation reducing local noise while blurring sharp transitions. Output represents local central tendency. Widely used for preprocessing, noise reduction, and multi-scale analysis.  Mean filtering is the most common low-pass smoothing operation. Highly sensitive to outliers (extreme values can distort results), making median filter preferable for noisy data. Computationally efficient. Filter size controls smoothing extent: small (3×3) preserves detail, large (31×31+) creates heavily smoothed surface. Often applied iteratively or at multiple scales for multi-resolution analysis.  Applications: (1) Basic noise reduction, (2) Preprocessing before feature detection (smooths false positives), (3) Multi-scale analysis (apply at 3×3, 11×11, 31×31), (4) Temporal smoothing (combining scenes), (5) Baseline for other statistical operations. Compare with median (non-linear, preserves edges) for improved edge preservation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mean_filter(...)
}

median_filter <- function(...) {
  # Computes moving-window median value for each pixel, replacing with 50th percentile of neighborhood. Robust noise filter preserving edges (non-linear). Particularly effective for impulse noise (salt-and-pepper) removal while maintaining sharp boundaries. Output values are actual pixel values from neighborhood (not interpolated).  Median filtering is non-linear—critical advantage over mean filtering for noise reduction because it doesn't create new values or blur edges. Large filter sizes heavily smooth while preserving sharp transitions. Widely used in remote sensing, medical imaging, and SAR image processing. Computational cost increases with filter size but generally faster than bilateral or guided filters.  Applications: (1) SAR image speckle reduction (especially effective for phase coherence), (2) Salt-and-pepper noise removal, (3) Preprocessing before edge detection (reduces false edges), (4) Boundary preservation in classification preprocessing, (5) Radiometric correction for outlier values. Typical workflow: apply median→edge-enhanced output→threshold for feature extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$median_filter(...)
}

wbw_median_filter <- function(...) {
  # Computes moving-window median value for each pixel, replacing with 50th percentile of neighborhood. Robust noise filter preserving edges (non-linear). Particularly effective for impulse noise (salt-and-pepper) removal while maintaining sharp boundaries. Output values are actual pixel values from neighborhood (not interpolated).  Median filtering is non-linear—critical advantage over mean filtering for noise reduction because it doesn't create new values or blur edges. Large filter sizes heavily smooth while preserving sharp transitions. Widely used in remote sensing, medical imaging, and SAR image processing. Computational cost increases with filter size but generally faster than bilateral or guided filters.  Applications: (1) SAR image speckle reduction (especially effective for phase coherence), (2) Salt-and-pepper noise removal, (3) Preprocessing before edge detection (reduces false edges), (4) Boundary preservation in classification preprocessing, (5) Radiometric correction for outlier values. Typical workflow: apply median→edge-enhanced output→threshold for feature extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$median_filter(...)
}

medoid <- function(...) {
  # Calculates medoid points from vector geometries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$medoid(...)
}

wbw_medoid <- function(...) {
  # Calculates medoid points from vector geometries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$medoid(...)
}

merge_line_segments <- function(...) {
  # Merges connected line segments that meet at non-branching endpoints.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$merge_line_segments(...)
}

wbw_merge_line_segments <- function(...) {
  # Merges connected line segments that meet at non-branching endpoints.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$merge_line_segments(...)
}

merge_table_with_csv <- function(...) {
  # Merges attributes from a CSV table into a vector attribute table by key fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$merge_table_with_csv(...)
}

wbw_merge_table_with_csv <- function(...) {
  # Merges attributes from a CSV table into a vector attribute table by key fields.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$merge_table_with_csv(...)
}

merge_vectors <- function(...) {
  # Combines two or more input vectors of the same geometry type into a single output vector.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$merge_vectors(...)
}

wbw_merge_vectors <- function(...) {
  # Combines two or more input vectors of the same geometry type into a single output vector.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$merge_vectors(...)
}

min <- function(...) {
  # Performs a MIN operation on two rasters or a raster and a constant value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min(...)
}

wbw_min <- function(...) {
  # Performs a MIN operation on two rasters or a raster and a constant value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min(...)
}

min_absolute_overlay <- function(...) {
  # Computes the per-cell minimum absolute value across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_absolute_overlay(...)
}

wbw_min_absolute_overlay <- function(...) {
  # Computes the per-cell minimum absolute value across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_absolute_overlay(...)
}

min_dist_classification <- function(...) {
  # Performs a supervised minimum-distance classification on multi-spectral rasters using polygon training data.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_dist_classification(...)
}

wbw_min_dist_classification <- function(...) {
  # Performs a supervised minimum-distance classification on multi-spectral rasters using polygon training data.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_dist_classification(...)
}

min_downslope_elev_change <- function(...) {
  # Calculates the minimum non-negative elevation drop to neighbouring cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_downslope_elev_change(...)
}

wbw_min_downslope_elev_change <- function(...) {
  # Calculates the minimum non-negative elevation drop to neighbouring cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_downslope_elev_change(...)
}

min_max_contrast_stretch <- function(...) {
  # Linearly stretches values between user-specified minimum and maximum.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_max_contrast_stretch(...)
}

wbw_min_max_contrast_stretch <- function(...) {
  # Linearly stretches values between user-specified minimum and maximum.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_max_contrast_stretch(...)
}

min_overlay <- function(...) {
  # Computes the per-cell minimum across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_overlay(...)
}

wbw_min_overlay <- function(...) {
  # Computes the per-cell minimum across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$min_overlay(...)
}

minimal_curvature <- function(...) {
  # Calculates minimal (minimum principal) curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimal_curvature(...)
}

wbw_minimal_curvature <- function(...) {
  # Calculates minimal (minimum principal) curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimal_curvature(...)
}

minimal_dispersion_flow_algorithm <- function(...) {
  # Generates MDFA flow-direction and flow-accumulation rasters from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimal_dispersion_flow_algorithm(...)
}

wbw_minimal_dispersion_flow_algorithm <- function(...) {
  # Generates MDFA flow-direction and flow-accumulation rasters from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimal_dispersion_flow_algorithm(...)
}

minimum_bounding_box <- function(...) {
  # Calculates oriented minimum bounding boxes around individual features or the entire layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_bounding_box(...)
}

wbw_minimum_bounding_box <- function(...) {
  # Calculates oriented minimum bounding boxes around individual features or the entire layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_bounding_box(...)
}

minimum_bounding_circle <- function(...) {
  # Calculates minimum enclosing circles around individual features or the entire layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_bounding_circle(...)
}

wbw_minimum_bounding_circle <- function(...) {
  # Calculates minimum enclosing circles around individual features or the entire layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_bounding_circle(...)
}

minimum_bounding_envelope <- function(...) {
  # Calculates axis-aligned minimum bounding envelopes around individual features or the entire layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_bounding_envelope(...)
}

wbw_minimum_bounding_envelope <- function(...) {
  # Calculates axis-aligned minimum bounding envelopes around individual features or the entire layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_bounding_envelope(...)
}

minimum_convex_hull <- function(...) {
  # Creates convex hull polygons around individual features or the full input layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_convex_hull(...)
}

wbw_minimum_convex_hull <- function(...) {
  # Creates convex hull polygons around individual features or the full input layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_convex_hull(...)
}

minimum_filter <- function(...) {
  # Computes moving-window minimum value, revealing local lows and troughs. Erosion operator in morphological image processing. Useful for detecting valley floors, depressions, and minimum-altitude features. Sensitive to single outlier (one low value in window produces low output).  Minimum filter is the morphological "erosion" operator—shrinks light regions and expands dark regions. When applied repeatedly (multi-pass erosion), creates smoothed valleys and isolated features disappear. Combined with maximum filter (dilation) enables opening (erosion then dilation) and closing (dilation then erosion) operations. Often used in multi-scale decomposition: compare min at 3×3, 11×11, 31×31 to identify feature scales.  Applications: (1) Morphological erosion for size-based filtering, (2) Opening via erosion→dilation to remove small noise objects, (3) Depression/valley identification in terrain, (4) Local floor level in bathymetry/DEM, (5) Multi-scale feature analysis (compare erosion across scales). Typical workflow: minimum→comparison with maximum→opening or closing depending on feature type.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_filter(...)
}

wbw_minimum_filter <- function(...) {
  # Computes moving-window minimum value, revealing local lows and troughs. Erosion operator in morphological image processing. Useful for detecting valley floors, depressions, and minimum-altitude features. Sensitive to single outlier (one low value in window produces low output).  Minimum filter is the morphological "erosion" operator—shrinks light regions and expands dark regions. When applied repeatedly (multi-pass erosion), creates smoothed valleys and isolated features disappear. Combined with maximum filter (dilation) enables opening (erosion then dilation) and closing (dilation then erosion) operations. Often used in multi-scale decomposition: compare min at 3×3, 11×11, 31×31 to identify feature scales.  Applications: (1) Morphological erosion for size-based filtering, (2) Opening via erosion→dilation to remove small noise objects, (3) Depression/valley identification in terrain, (4) Local floor level in bathymetry/DEM, (5) Multi-scale feature analysis (compare erosion across scales). Typical workflow: minimum→comparison with maximum→opening or closing depending on feature type.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_filter(...)
}

minimum_noise_fraction <- function(...) {
  # Minimum noise fraction transforms hyperspectral data via two-step process: noise covariance estimation followed by noise whitening and principal component analysis. Noise whitening decorrelates noise across bands; PCA in whitened space identifies signal-dominated directions. Output components ordered by signal-to-noise ratio with early components representing signal, later components noise. Enables noise reduction via component truncation without conventional smoothing artifacts. Key Features: Separates signal from noise; noise concentration in late components; component selection enables noise filtering; preserves spectral fidelity; enables dimensionality reduction. Use Cases: Hyperspectral image denoising; dimension reduction for classification; signal enhancement; noise characterization; image quality assessment. Output Interpretation: First 1-3 MNF components typically contain 70-90% of signal; later components progressively noisier. Component truncation (retaining first N components) removes noise while preserving essential spectral information. MNF component images enable visual noise assessment; standard deviation of late components indicates noise level.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_noise_fraction(...)
}

wbw_minimum_noise_fraction <- function(...) {
  # Minimum noise fraction transforms hyperspectral data via two-step process: noise covariance estimation followed by noise whitening and principal component analysis. Noise whitening decorrelates noise across bands; PCA in whitened space identifies signal-dominated directions. Output components ordered by signal-to-noise ratio with early components representing signal, later components noise. Enables noise reduction via component truncation without conventional smoothing artifacts. Key Features: Separates signal from noise; noise concentration in late components; component selection enables noise filtering; preserves spectral fidelity; enables dimensionality reduction. Use Cases: Hyperspectral image denoising; dimension reduction for classification; signal enhancement; noise characterization; image quality assessment. Output Interpretation: First 1-3 MNF components typically contain 70-90% of signal; later components progressively noisier. Component truncation (retaining first N components) removes noise while preserving essential spectral information. MNF component images enable visual noise assessment; standard deviation of late components indicates noise level.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$minimum_noise_fraction(...)
}

modified_k_means_clustering <- function(...) {
  # Modified K-means clustering enhances standard K-means with spectral preprocessing, automated adaptive K selection, and enhanced convergence criteria for more robust and accurate unsupervised multispectral classification. The algorithm applies optional preprocessing including spectral standardization removing scale effects, principal component transformation emphasizing dominant variance directions, and noise filtering removing spurious spectral variations. Adaptive K selection uses elbow methods or silhouette analysis discovering optimal cluster count automatically rather than requiring manual specification. Key features include spectral preprocessing reducing scale sensitivity and emphasizing dominant spectral variation directions, automated K selection discovering optimal cluster counts objectively, enhanced convergence criteria including relative center displacement thresholds and spectral angle similarity metrics, and optional postprocessing merging similar clusters or splitting diffuse clusters. Applications include improved exploratory land cover classification handling spectral scales automatically, robust anomaly detection separating signal from noise through preprocessing, adaptive image segmentation discovering appropriate detail levels automatically, and multisensor integration normalizing different sensor spectral scales. Modified K-means output reveals robust natural spectral classes. Output produces optimized cluster membership raster with automatically-determined class count, cluster centers with preprocessing transformations documented, and diagnostic statistics quantifying cluster quality, separation, and convergence; adaptive K selection recommendations guide interpretability versus detail trade-offs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modified_k_means_clustering(...)
}

wbw_modified_k_means_clustering <- function(...) {
  # Modified K-means clustering enhances standard K-means with spectral preprocessing, automated adaptive K selection, and enhanced convergence criteria for more robust and accurate unsupervised multispectral classification. The algorithm applies optional preprocessing including spectral standardization removing scale effects, principal component transformation emphasizing dominant variance directions, and noise filtering removing spurious spectral variations. Adaptive K selection uses elbow methods or silhouette analysis discovering optimal cluster count automatically rather than requiring manual specification. Key features include spectral preprocessing reducing scale sensitivity and emphasizing dominant spectral variation directions, automated K selection discovering optimal cluster counts objectively, enhanced convergence criteria including relative center displacement thresholds and spectral angle similarity metrics, and optional postprocessing merging similar clusters or splitting diffuse clusters. Applications include improved exploratory land cover classification handling spectral scales automatically, robust anomaly detection separating signal from noise through preprocessing, adaptive image segmentation discovering appropriate detail levels automatically, and multisensor integration normalizing different sensor spectral scales. Modified K-means output reveals robust natural spectral classes. Output produces optimized cluster membership raster with automatically-determined class count, cluster centers with preprocessing transformations documented, and diagnostic statistics quantifying cluster quality, separation, and convergence; adaptive K selection recommendations guide interpretability versus detail trade-offs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modified_k_means_clustering(...)
}

modified_shepard_interpolation <- function(...) {
  # Interpolates a raster from point samples using locally weighted modified-Shepard blending.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modified_shepard_interpolation(...)
}

wbw_modified_shepard_interpolation <- function(...) {
  # Interpolates a raster from point samples using locally weighted modified-Shepard blending.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modified_shepard_interpolation(...)
}

modify_lidar <- function(...) {
  # Updates point attributes via assignments: z=z+offset, class=reclassify_expr, intensity=scale_factor. Flexible point-level transformations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modify_lidar(...)
}

wbw_modify_lidar <- function(...) {
  # Updates point attributes via assignments: z=z+offset, class=reclassify_expr, intensity=scale_factor. Flexible point-level transformations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modify_lidar(...)
}

modify_nodata_value <- function(...) {
  # Changes the raster nodata value and rewrites existing nodata cells to the new value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modify_nodata_value(...)
}

wbw_modify_nodata_value <- function(...) {
  # Changes the raster nodata value and rewrites existing nodata cells to the new value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modify_nodata_value(...)
}

modulo <- function(...) {
  # Computes the remainder of dividing the first raster by the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modulo(...)
}

wbw_modulo <- function(...) {
  # Computes the remainder of dividing the first raster by the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$modulo(...)
}

mosaic <- function(...) {
  # Mosaicking combines multiple overlapping rasters into seamless output through geometric registration, resampling to common projection and pixel grid, and edge blending to minimize discontinuities. The algorithm registers rasters using geographic coordinates or ground control points, resamples to target resolution and extent, and applies weighted blending (Feather blending or exponential weighting) across overlap regions. Overlapping pixels are blended using distance-weighted averaging from raster edges, creating smooth transitions while preserving interior pixel accuracy. This produces seamless continental or global raster mosaics eliminating edge artefacts and radiometric discontinuities. Key features include multi-raster geometric alignment to common projection, resampling method selection (bilinear, cubic, nearest-neighbour), edge blending eliminating seams, radiometric normalization compensating for sensor or illumination differences, and support for thousands of input rasters. The tool automatically manages raster priority, avoiding gaps through intelligent fill strategies. Applications include producing continental satellite image mosaics from scene collections, generating seamless digital elevation models from multiple flight lines, creating composite optical mosaics from multi-temporal imagery, building orthomosaic from unmanned aerial vehicle (UAV) surveys, and producing base maps for large areas from overlapping satellite scenes. Mosaicking is essential for continental and global analysis workflows. Output interpretation: Output rasters inherit input projection and resolution; blend regions show interpolated values balancing input rasters. Edge artefacts indicate insufficient overlap or poor radiometric normalization; assessment examines seams and colour consistency across mosaic boundaries. Nodata handling at mosaic edges requires attention to fill values and extent definition. Quality assessment includes geometric verification through ground control points and radiometric assessment comparing mosaic values to input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mosaic(...)
}

wbw_mosaic <- function(...) {
  # Mosaicking combines multiple overlapping rasters into seamless output through geometric registration, resampling to common projection and pixel grid, and edge blending to minimize discontinuities. The algorithm registers rasters using geographic coordinates or ground control points, resamples to target resolution and extent, and applies weighted blending (Feather blending or exponential weighting) across overlap regions. Overlapping pixels are blended using distance-weighted averaging from raster edges, creating smooth transitions while preserving interior pixel accuracy. This produces seamless continental or global raster mosaics eliminating edge artefacts and radiometric discontinuities. Key features include multi-raster geometric alignment to common projection, resampling method selection (bilinear, cubic, nearest-neighbour), edge blending eliminating seams, radiometric normalization compensating for sensor or illumination differences, and support for thousands of input rasters. The tool automatically manages raster priority, avoiding gaps through intelligent fill strategies. Applications include producing continental satellite image mosaics from scene collections, generating seamless digital elevation models from multiple flight lines, creating composite optical mosaics from multi-temporal imagery, building orthomosaic from unmanned aerial vehicle (UAV) surveys, and producing base maps for large areas from overlapping satellite scenes. Mosaicking is essential for continental and global analysis workflows. Output interpretation: Output rasters inherit input projection and resolution; blend regions show interpolated values balancing input rasters. Edge artefacts indicate insufficient overlap or poor radiometric normalization; assessment examines seams and colour consistency across mosaic boundaries. Nodata handling at mosaic edges requires attention to fill values and extent definition. Quality assessment includes geometric verification through ground control points and radiometric assessment comparing mosaic values to input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mosaic(...)
}

mosaic_with_feathering <- function(...) {
  # Mosaics two rasters and feather-blends overlapping cells using edge-distance weights.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mosaic_with_feathering(...)
}

wbw_mosaic_with_feathering <- function(...) {
  # Mosaics two rasters and feather-blends overlapping cells using edge-distance weights.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$mosaic_with_feathering(...)
}

multidirectional_hillshade <- function(...) {
  # Multi-directional hillshade (8+ light sources) eliminating single-light shadowing artifacts. Balanced feature visibility for complex terrain; preferred for publications and detailed analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multidirectional_hillshade(...)
}

wbw_multidirectional_hillshade <- function(...) {
  # Multi-directional hillshade (8+ light sources) eliminating single-light shadowing artifacts. Balanced feature visibility for complex terrain; preferred for publications and detailed analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multidirectional_hillshade(...)
}

multimodal_od_cost_matrix <- function(...) {
  # Computes batched multimodal OD costs and mode summaries between origin and destination point sets.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multimodal_od_cost_matrix(...)
}

wbw_multimodal_od_cost_matrix <- function(...) {
  # Computes batched multimodal OD costs and mode summaries between origin and destination point sets.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multimodal_od_cost_matrix(...)
}

multimodal_routes_from_od <- function(...) {
  # Builds route geometries for multimodal origin-destination point pairs with per-route mode summaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multimodal_routes_from_od(...)
}

wbw_multimodal_routes_from_od <- function(...) {
  # Builds route geometries for multimodal origin-destination point pairs with per-route mode summaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multimodal_routes_from_od(...)
}

multimodal_shortest_path <- function(...) {
  # Finds a mode-aware shortest path over a line network with configurable transfer penalties.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multimodal_shortest_path(...)
}

wbw_multimodal_shortest_path <- function(...) {
  # Finds a mode-aware shortest path over a line network with configurable transfer penalties.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multimodal_shortest_path(...)
}

multipart_to_singlepart <- function(...) {
  # Converts a vector containing multi-part features into one with only single-part features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multipart_to_singlepart(...)
}

wbw_multipart_to_singlepart <- function(...) {
  # Converts a vector containing multi-part features into one with only single-part features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multipart_to_singlepart(...)
}

multiply <- function(...) {
  # Multiplies two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiply(...)
}

wbw_multiply <- function(...) {
  # Multiplies two rasters on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiply(...)
}

multiply_overlay <- function(...) {
  # Computes the per-cell product across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiply_overlay(...)
}

wbw_multiply_overlay <- function(...) {
  # Computes the per-cell product across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiply_overlay(...)
}

multiscale_curvatures <- function(...) {
  # Calculates multiscale curvatures and curvature-based indices from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_curvatures(...)
}

wbw_multiscale_curvatures <- function(...) {
  # Calculates multiscale curvatures and curvature-based indices from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_curvatures(...)
}

multiscale_elevated_index <- function(...) {
  # Calculates multiscale elevated-index (MsEI) and key-scale rasters using Gaussian scale-space residuals.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_elevated_index(...)
}

wbw_multiscale_elevated_index <- function(...) {
  # Calculates multiscale elevated-index (MsEI) and key-scale rasters using Gaussian scale-space residuals.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_elevated_index(...)
}

multiscale_elevation_percentile <- function(...) {
  # Calculates the most extreme local elevation percentile across a range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_elevation_percentile(...)
}

wbw_multiscale_elevation_percentile <- function(...) {
  # Calculates the most extreme local elevation percentile across a range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_elevation_percentile(...)
}

multiscale_low_lying_index <- function(...) {
  # Calculates multiscale low-lying-index (MsLLI) and key-scale rasters using Gaussian scale-space residuals.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_low_lying_index(...)
}

wbw_multiscale_low_lying_index <- function(...) {
  # Calculates multiscale low-lying-index (MsLLI) and key-scale rasters using Gaussian scale-space residuals.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_low_lying_index(...)
}

multiscale_roughness <- function(...) {
  # Calculates surface roughness over a range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_roughness(...)
}

wbw_multiscale_roughness <- function(...) {
  # Calculates surface roughness over a range of neighbourhood scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_roughness(...)
}

multiscale_roughness_signature <- function(...) {
  # Calculates multiscale roughness signatures for input point sites and writes an HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_roughness_signature(...)
}

wbw_multiscale_roughness_signature <- function(...) {
  # Calculates multiscale roughness signatures for input point sites and writes an HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_roughness_signature(...)
}

multiscale_std_dev_normals <- function(...) {
  # Calculates maximum spherical standard deviation of surface normals over a nonlinearly sampled range of scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_std_dev_normals(...)
}

wbw_multiscale_std_dev_normals <- function(...) {
  # Calculates maximum spherical standard deviation of surface normals over a nonlinearly sampled range of scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_std_dev_normals(...)
}

multiscale_std_dev_normals_signature <- function(...) {
  # Calculates spherical-standard-deviation scale signatures for input point sites and writes an HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_std_dev_normals_signature(...)
}

wbw_multiscale_std_dev_normals_signature <- function(...) {
  # Calculates spherical-standard-deviation scale signatures for input point sites and writes an HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_std_dev_normals_signature(...)
}

multiscale_topographic_position_class <- function(...) {
  # Classifies each DEM cell into a nine-class broad/local relative topographic position system using two DEVmax scale mosaics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_topographic_position_class(...)
}

wbw_multiscale_topographic_position_class <- function(...) {
  # Classifies each DEM cell into a nine-class broad/local relative topographic position system using two DEVmax scale mosaics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_topographic_position_class(...)
}

multiscale_topographic_position_image <- function(...) {
  # Creates a packed RGB multiscale topographic-position image from local, meso, and broad DEVmax rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_topographic_position_image(...)
}

wbw_multiscale_topographic_position_image <- function(...) {
  # Creates a packed RGB multiscale topographic-position image from local, meso, and broad DEVmax rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$multiscale_topographic_position_image(...)
}

narrowness_index <- function(...) {
  # Calculates raster patch narrowness index as area divided by area of the largest contained circle based on maximum distance-to-edge.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$narrowness_index(...)
}

wbw_narrowness_index <- function(...) {
  # Calculates raster patch narrowness index as area divided by area of the largest contained circle based on maximum distance-to-edge.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$narrowness_index(...)
}

narrowness_index_vector <- function(...) {
  # Computes narrowness index (perimeter / sqrt(area)) for polygon features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$narrowness_index_vector(...)
}

wbw_narrowness_index_vector <- function(...) {
  # Computes narrowness index (perimeter / sqrt(area)) for polygon features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$narrowness_index_vector(...)
}

natural_neighbour_interpolation <- function(...) {
  # Interpolates a raster from point samples using true Sibson natural-neighbour area weighting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$natural_neighbour_interpolation(...)
}

wbw_natural_neighbour_interpolation <- function(...) {
  # Interpolates a raster from point samples using true Sibson natural-neighbour area weighting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$natural_neighbour_interpolation(...)
}

ndvi_based_emissivity <- function(...) {
  # NDVI-based land surface emissivity estimation derives broadband thermal emissivity from vegetation fraction computed from NDVI, enabling thermal radiative transfer corrections for land surface temperature retrieval from thermal infrared satellite data. The algorithm computes NDVI from red and near-infrared reflectance, transforms NDVI to vegetation fraction, then applies empirical relationships between vegetation fraction and emissivity validated through field measurements and simulated radiative transfer. Vegetation significantly affects thermal emissivity; more vegetation increases emissivity toward ~0.99, while bare soil emissivity ranges ~0.90-0.98 depending on soil composition and surface roughness. Key features include automatic vegetation fraction computation from NDVI without field calibration, standard empirical relationships grounded in physical radiative transfer theory, optional sensitivity analysis exploring emissivity variations, and direct compatibility with thermal infrared satellite data. Applications include land surface temperature retrieval from thermal satellite data requiring accurate emissivity corrections (Landsat, MODIS, Sentinel-3), urban heat island analysis correcting for variable vegetation, thermal modeling in water resource and agricultural applications, and climate applications requiring consistent global thermal datasets. NDVI-based emissivity enables accurate thermal correction. Output produces emissivity raster (0-1) suitable for thermal radiative transfer correction, vegetation fraction intermediate product enabling interpretation, and metadata documenting empirical relationships and assumed soil/surface properties; emissivity values guide thermal correction uncertainty and suitability for specific applications.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ndvi_based_emissivity(...)
}

wbw_ndvi_based_emissivity <- function(...) {
  # NDVI-based land surface emissivity estimation derives broadband thermal emissivity from vegetation fraction computed from NDVI, enabling thermal radiative transfer corrections for land surface temperature retrieval from thermal infrared satellite data. The algorithm computes NDVI from red and near-infrared reflectance, transforms NDVI to vegetation fraction, then applies empirical relationships between vegetation fraction and emissivity validated through field measurements and simulated radiative transfer. Vegetation significantly affects thermal emissivity; more vegetation increases emissivity toward ~0.99, while bare soil emissivity ranges ~0.90-0.98 depending on soil composition and surface roughness. Key features include automatic vegetation fraction computation from NDVI without field calibration, standard empirical relationships grounded in physical radiative transfer theory, optional sensitivity analysis exploring emissivity variations, and direct compatibility with thermal infrared satellite data. Applications include land surface temperature retrieval from thermal satellite data requiring accurate emissivity corrections (Landsat, MODIS, Sentinel-3), urban heat island analysis correcting for variable vegetation, thermal modeling in water resource and agricultural applications, and climate applications requiring consistent global thermal datasets. NDVI-based emissivity enables accurate thermal correction. Output produces emissivity raster (0-1) suitable for thermal radiative transfer correction, vegetation fraction intermediate product enabling interpretation, and metadata documenting empirical relationships and assumed soil/surface properties; emissivity values guide thermal correction uncertainty and suitability for specific applications.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ndvi_based_emissivity(...)
}

near <- function(...) {
  # Adds NEAR_FID and NEAR_DIST attributes identifying nearest features and their distances using spatial indexing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$near(...)
}

wbw_near <- function(...) {
  # Adds NEAR_FID and NEAR_DIST attributes identifying nearest features and their distances using spatial indexing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$near(...)
}

nearest_neighbour_index <- function(...) {
  # Computes the Clark-Evans nearest-neighbour index testing for complete spatial randomness. Detects clustering vs. dispersion.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$nearest_neighbour_index(...)
}

wbw_nearest_neighbour_index <- function(...) {
  # Computes the Clark-Evans nearest-neighbour index testing for complete spatial randomness. Detects clustering vs. dispersion.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$nearest_neighbour_index(...)
}

nearest_neighbour_interpolation <- function(...) {
  # Interpolates a raster from point samples by assigning each cell the nearest sample value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$nearest_neighbour_interpolation(...)
}

wbw_nearest_neighbour_interpolation <- function(...) {
  # Interpolates a raster from point samples by assigning each cell the nearest sample value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$nearest_neighbour_interpolation(...)
}

negate <- function(...) {
  # Negates each non-nodata raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$negate(...)
}

wbw_negate <- function(...) {
  # Negates each non-nodata raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$negate(...)
}

network_accessibility_metrics <- function(...) {
  # Computes accessibility indices for origin points based on reachability to destinations with optional impedance cutoffs and decay functions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_accessibility_metrics(...)
}

wbw_network_accessibility_metrics <- function(...) {
  # Computes accessibility indices for origin points based on reachability to destinations with optional impedance cutoffs and decay functions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_accessibility_metrics(...)
}

network_centrality_metrics <- function(...) {
  # Computes baseline degree, closeness, and betweenness centrality metrics for network nodes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_centrality_metrics(...)
}

wbw_network_centrality_metrics <- function(...) {
  # Computes baseline degree, closeness, and betweenness centrality metrics for network nodes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_centrality_metrics(...)
}

network_connected_components <- function(...) {
  # Assigns a connected-component ID to each line feature in a network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_connected_components(...)
}

wbw_network_connected_components <- function(...) {
  # Assigns a connected-component ID to each line feature in a network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_connected_components(...)
}

network_node_degree <- function(...) {
  # Extracts network nodes from line features and computes node degree and node type.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_node_degree(...)
}

wbw_network_node_degree <- function(...) {
  # Extracts network nodes from line features and computes node degree and node type.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_node_degree(...)
}

network_od_cost_matrix <- function(...) {
  # Computes origin-destination shortest-path costs over a line network and writes a CSV matrix.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_od_cost_matrix(...)
}

wbw_network_od_cost_matrix <- function(...) {
  # Computes origin-destination shortest-path costs over a line network and writes a CSV matrix.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_od_cost_matrix(...)
}

network_routes_from_od <- function(...) {
  # Builds route geometries for origin-destination point pairs over a line network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_routes_from_od(...)
}

wbw_network_routes_from_od <- function(...) {
  # Builds route geometries for origin-destination point pairs over a line network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_routes_from_od(...)
}

network_service_area <- function(...) {
  # Computes reachable network nodes from origin points within a maximum network cost.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_service_area(...)
}

wbw_network_service_area <- function(...) {
  # Computes reachable network nodes from origin points within a maximum network cost.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_service_area(...)
}

network_topology_audit <- function(...) {
  # Audits a line network for topology anomalies—disconnected components, dead ends, and degree anomalies—that cause routing failures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_topology_audit(...)
}

wbw_network_topology_audit <- function(...) {
  # Audits a line network for topology anomalies—disconnected components, dead ends, and degree anomalies—that cause routing failures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$network_topology_audit(...)
}

new_raster_from_base_raster <- function(...) {
  # Creates a new raster using the extent, dimensions, and CRS of a base raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$new_raster_from_base_raster(...)
}

wbw_new_raster_from_base_raster <- function(...) {
  # Creates a new raster using the extent, dimensions, and CRS of a base raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$new_raster_from_base_raster(...)
}

new_raster_from_base_vector <- function(...) {
  # Creates a new raster from a base vector extent and cell size, filled with an optional value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$new_raster_from_base_vector(...)
}

wbw_new_raster_from_base_vector <- function(...) {
  # Creates a new raster from a base vector extent and cell size, filled with an optional value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$new_raster_from_base_vector(...)
}

nibble <- function(...) {
  # Fills background regions using nearest-neighbour allocation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$nibble(...)
}

wbw_nibble <- function(...) {
  # Fills background regions using nearest-neighbour allocation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$nibble(...)
}

nnd_classification <- function(...) {
  # Performs nearest-normalized-distance classification with optional outlier rejection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$nnd_classification(...)
}

wbw_nnd_classification <- function(...) {
  # Performs nearest-normalized-distance classification with optional outlier rejection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$nnd_classification(...)
}

non_local_means_filter <- function(...) {
  # Non-local means filtering performs powerful denoising by averaging similar patches identified across the entire image rather than neighboring pixels, exploiting image self-similarity to suppress noise while preserving structures. Implementation identifies patches similar to each target patch via Euclidean distance in patch-space, weights similar patches exponentially by similarity, and averages weighted patches. The algorithm computes: Fᵢ = (1/Z) Σⱼ exp(-d(Pᵢ, Pⱼ)²/h²) · Iⱼ, where d measures patch distance, h controls bandwidth, Z normalizes. Key features include superior denoising via similarity search rather than spatial proximity alone, effectiveness on complex textures and fine details, applicability to any data type, and proven performance on medical, satellite, and photographic imagery. Non-local means filtering excels in detailed satellite image restoration preserving fine texture and structure, multi-temporal stack averaging for change detection preparation, very noisy survey data denoising (ultrasonic, hyperspectral), and archaeological/aerial survey imagery enhancement. Output interpretation requires understanding that similar regions throughout the image contribute to each output pixel; locally dissimilar regions contribute negligibly. Patch size controls feature preservation (larger patches = smoother results, finer patches = more detail); bandwidth h controls similarity weighting (larger h = more patches included, smaller h = stricter similarity requirements). Output ranges match input; statistics shift toward regional means while fine structures remain. Computational cost scales with image size and patch radius; typical execution requires substantial processing time for large imagery. Monitor filtering progression via PSNR or visual inspection. Common artifacts include over-smoothing fine textures (increase patch size carefully) and under-smoothing in high-noise regions (increase bandwidth). Apply strategically in workflows requiring maximum noise reduction while preserving fine-scale features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$non_local_means_filter(...)
}

wbw_non_local_means_filter <- function(...) {
  # Non-local means filtering performs powerful denoising by averaging similar patches identified across the entire image rather than neighboring pixels, exploiting image self-similarity to suppress noise while preserving structures. Implementation identifies patches similar to each target patch via Euclidean distance in patch-space, weights similar patches exponentially by similarity, and averages weighted patches. The algorithm computes: Fᵢ = (1/Z) Σⱼ exp(-d(Pᵢ, Pⱼ)²/h²) · Iⱼ, where d measures patch distance, h controls bandwidth, Z normalizes. Key features include superior denoising via similarity search rather than spatial proximity alone, effectiveness on complex textures and fine details, applicability to any data type, and proven performance on medical, satellite, and photographic imagery. Non-local means filtering excels in detailed satellite image restoration preserving fine texture and structure, multi-temporal stack averaging for change detection preparation, very noisy survey data denoising (ultrasonic, hyperspectral), and archaeological/aerial survey imagery enhancement. Output interpretation requires understanding that similar regions throughout the image contribute to each output pixel; locally dissimilar regions contribute negligibly. Patch size controls feature preservation (larger patches = smoother results, finer patches = more detail); bandwidth h controls similarity weighting (larger h = more patches included, smaller h = stricter similarity requirements). Output ranges match input; statistics shift toward regional means while fine structures remain. Computational cost scales with image size and patch radius; typical execution requires substantial processing time for large imagery. Monitor filtering progression via PSNR or visual inspection. Common artifacts include over-smoothing fine textures (increase patch size carefully) and under-smoothing in high-noise regions (increase bandwidth). Apply strategically in workflows requiring maximum noise reduction while preserving fine-scale features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$non_local_means_filter(...)
}

normal_vectors <- function(...) {
  # Computes per-point surface normals: PCA on local neighborhood estimates plane orientation. Normals stored in point records and RGB visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$normal_vectors(...)
}

wbw_normal_vectors <- function(...) {
  # Computes per-point surface normals: PCA on local neighborhood estimates plane orientation. Normals stored in point records and RGB visualization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$normal_vectors(...)
}

normalize_lidar <- function(...) {
  # Converts absolute LiDAR elevations to height above ground: subtracts DTM (raster DEM) from point z values. Creates normalized point cloud for structure analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$normalize_lidar(...)
}

wbw_normalize_lidar <- function(...) {
  # Converts absolute LiDAR elevations to height above ground: subtracts DTM (raster DEM) from point z values. Creates normalized point cloud for structure analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$normalize_lidar(...)
}

normalized_difference_index <- function(...) {
  # Computes (band1 - band2) / (band1 + band2) from a multiband raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$normalized_difference_index(...)
}

wbw_normalized_difference_index <- function(...) {
  # Computes (band1 - band2) / (band1 + band2) from a multiband raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$normalized_difference_index(...)
}

not_equal_to <- function(...) {
  # Tests whether two rasters are not equal on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$not_equal_to(...)
}

wbw_not_equal_to <- function(...) {
  # Tests whether two rasters are not equal on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$not_equal_to(...)
}

num_downslope_neighbours <- function(...) {
  # Counts the number of 8-neighbour cells lower than each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$num_downslope_neighbours(...)
}

wbw_num_downslope_neighbours <- function(...) {
  # Counts the number of 8-neighbour cells lower than each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$num_downslope_neighbours(...)
}

num_inflowing_neighbours <- function(...) {
  # Counts the number of inflowing D8 neighbours for each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$num_inflowing_neighbours(...)
}

wbw_num_inflowing_neighbours <- function(...) {
  # Counts the number of inflowing D8 neighbours for each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$num_inflowing_neighbours(...)
}

num_upslope_neighbours <- function(...) {
  # Counts the number of 8-neighbour cells higher than each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$num_upslope_neighbours(...)
}

wbw_num_upslope_neighbours <- function(...) {
  # Counts the number of 8-neighbour cells higher than each DEM cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$num_upslope_neighbours(...)
}

obia_audit_report_pro <- function(...) {
  # Builds an audit report for OBIA workflow artifacts including file existence, size, and timestamp metadata.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$obia_audit_report_pro(...)
}

wbw_obia_audit_report_pro <- function(...) {
  # Builds an audit report for OBIA workflow artifacts including file existence, size, and timestamp metadata.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$obia_audit_report_pro(...)
}

obia_batch_orchestrator_pro <- function(...) {
  # Runs multiple OBIA pipeline jobs in one request and returns a consolidated job report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$obia_batch_orchestrator_pro(...)
}

wbw_obia_batch_orchestrator_pro <- function(...) {
  # Runs multiple OBIA pipeline jobs in one request and returns a consolidated job report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$obia_batch_orchestrator_pro(...)
}

obia_pipeline_basic <- function(...) {
  # Executes complete end-to-end OBIA workflow: segmentation (SLIC/Graph), small-region merge, spectral/shape feature extraction, and random-forest classification in single operation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$obia_pipeline_basic(...)
}

wbw_obia_pipeline_basic <- function(...) {
  # Executes complete end-to-end OBIA workflow: segmentation (SLIC/Graph), small-region merge, spectral/shape feature extraction, and random-forest classification in single operation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$obia_pipeline_basic(...)
}

object_class_probability_maps <- function(...) {
  # Converts predictions to per-class probability maps enabling raster-based uncertainty visualization and confidence-based filtering. Supports downstream confidence thresholding and multi-label scenarios.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_class_probability_maps(...)
}

wbw_object_class_probability_maps <- function(...) {
  # Converts predictions to per-class probability maps enabling raster-based uncertainty visualization and confidence-based filtering. Supports downstream confidence thresholding and multi-label scenarios.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_class_probability_maps(...)
}

object_features_context_neighbors <- function(...) {
  # Computes spatial context features: adjacent-object counts, shared-boundary lengths, and isolation metrics. Enables neighbor-aware classification capturing object relationships in landscape.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_context_neighbors(...)
}

wbw_object_features_context_neighbors <- function(...) {
  # Computes spatial context features: adjacent-object counts, shared-boundary lengths, and isolation metrics. Enables neighbor-aware classification capturing object relationships in landscape.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_context_neighbors(...)
}

object_features_shape_basic <- function(...) {
  # Computes geometric and morphological shape descriptors for each segment including area (pixel count), perimeter (boundary length), compactness (perimeter-normalized circularity), elongation (length-to-width ratio), form factor (normalized shape regularity), and solidity (convex hull efficiency). Shape descriptors capture structural characteristics independent of spectral content, enabling object geometry classification and morphological pattern recognition. Key features include comprehensive shape metric suites covering area, perimeter, regularity, and elongation, computationally efficient boundary-tracing algorithms, metrics invariant to rotation and translation, applicability across scale ranges, and morphological object classification capability (e.g., elongated roads versus compact buildings). Use cases encompass building footprint classification and urban structure analysis, linear feature extraction (roads, rivers, boundaries), vegetation patch characterization and fragmentation analysis, quality control through shape-based filtering, hierarchical object recognition combining shape and spectral properties, and landscape structure quantification in ecological monitoring. Output area quantifies segment size in pixels; perimeter defines boundary complexity; compactness near 1.0 indicates circular/regular shapes, lower values indicate irregular/elongated features; elongation >1 indicates linear features, near 1 indicates compact objects; form factor combines multiple shape properties for integrated shape classification; shape metrics enable morphological filtering to isolate target object types.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_shape_basic(...)
}

wbw_object_features_shape_basic <- function(...) {
  # Computes geometric and morphological shape descriptors for each segment including area (pixel count), perimeter (boundary length), compactness (perimeter-normalized circularity), elongation (length-to-width ratio), form factor (normalized shape regularity), and solidity (convex hull efficiency). Shape descriptors capture structural characteristics independent of spectral content, enabling object geometry classification and morphological pattern recognition. Key features include comprehensive shape metric suites covering area, perimeter, regularity, and elongation, computationally efficient boundary-tracing algorithms, metrics invariant to rotation and translation, applicability across scale ranges, and morphological object classification capability (e.g., elongated roads versus compact buildings). Use cases encompass building footprint classification and urban structure analysis, linear feature extraction (roads, rivers, boundaries), vegetation patch characterization and fragmentation analysis, quality control through shape-based filtering, hierarchical object recognition combining shape and spectral properties, and landscape structure quantification in ecological monitoring. Output area quantifies segment size in pixels; perimeter defines boundary complexity; compactness near 1.0 indicates circular/regular shapes, lower values indicate irregular/elongated features; elongation >1 indicates linear features, near 1 indicates compact objects; form factor combines multiple shape properties for integrated shape classification; shape metrics enable morphological filtering to isolate target object types.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_shape_basic(...)
}

object_features_spectral_basic <- function(...) {
  # Computes comprehensive univariate statistical summaries of spectral reflectance values within each segment across all image bands. Per-segment calculations include mean reflectance, standard deviation (homogeneity), minimum and maximum reflectance bounds, quantile values for robust estimation, and band-wise statistics enabling multispectral texture quantification and spectral profile characterization fundamental to OBIA classification workflows. Key features include band-wise spectral statistics generation for multispectral and hyperspectral imagery, robust statistical measures capturing central tendency and dispersion, identification of spectral anomalies and outliers within segments, efficient raster-to-vector summarization, and output directly feeding machine-learning classification pipelines. Use cases span feature extraction for object-based classification using spectral metrics, land-cover type identification through spectral signature analysis, change detection through spectral statistic comparison across temporal sequences, data quality assessment and outlier detection, environmental monitoring through spectral time-series analysis, and precision agriculture applications requiring normalized spectral response characterization. Output mean values represent typical spectral response of segment material; standard deviation quantifies internal heterogeneity (low = homogeneous surface, high = mixed materials or shadows); min/max bounds identify spectral extremes within segments; spectral profiles enable comparison against reference signatures; statistics form basis for classification feature vectors; band-wise analysis reveals spectral indices and material discrimination capability.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_spectral_basic(...)
}

wbw_object_features_spectral_basic <- function(...) {
  # Computes comprehensive univariate statistical summaries of spectral reflectance values within each segment across all image bands. Per-segment calculations include mean reflectance, standard deviation (homogeneity), minimum and maximum reflectance bounds, quantile values for robust estimation, and band-wise statistics enabling multispectral texture quantification and spectral profile characterization fundamental to OBIA classification workflows. Key features include band-wise spectral statistics generation for multispectral and hyperspectral imagery, robust statistical measures capturing central tendency and dispersion, identification of spectral anomalies and outliers within segments, efficient raster-to-vector summarization, and output directly feeding machine-learning classification pipelines. Use cases span feature extraction for object-based classification using spectral metrics, land-cover type identification through spectral signature analysis, change detection through spectral statistic comparison across temporal sequences, data quality assessment and outlier detection, environmental monitoring through spectral time-series analysis, and precision agriculture applications requiring normalized spectral response characterization. Output mean values represent typical spectral response of segment material; standard deviation quantifies internal heterogeneity (low = homogeneous surface, high = mixed materials or shadows); min/max bounds identify spectral extremes within segments; spectral profiles enable comparison against reference signatures; statistics form basis for classification feature vectors; band-wise analysis reveals spectral indices and material discrimination capability.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_spectral_basic(...)
}

object_features_texture_glcm_basic <- function(...) {
  # Extracts texture characteristics using Gray-Level Co-occurrence Matrix (GLCM) analysis computed from per-band intensity distributions within each segment. GLCM quantifies spatial co-occurrence of tone levels, generating descriptors including contrast (local variation), homogeneity (spatial regularity), energy (orderliness), entropy (disorder), and dissimilarity metrics capturing texture patterns independent of overall spectral brightness. Key features include GLCM-based texture metrics capturing local spatial patterns within segments, multi-directional analysis (horizontal, vertical, diagonal) for orientation-independent texture characterization, applicability to all image bands enabling texture fingerprinting, discrimination of textured versus smooth surfaces, and computationally tractable analysis at segment level. Use cases include surface roughness and texture-based material classification (asphalt versus concrete, crop type distinction), forest structure and density characterization through canopy texture, SAR image interpretation and urban fabric texture analysis, quality surface versus degraded surface discrimination, crop health assessment through canopy texture metrics, and cloud and shadow detection via texture anomalies. Output contrast high indicates rough/variable texture, low indicates smooth surfaces; homogeneity high indicates regular spatial patterns, low indicates chaotic texture; energy high indicates organized texture, low indicates random noise; entropy quantifies texture disorder; dissimilarity captures spatial pattern irregularity; texture profiles enable material-specific classification; combination with spectral features improves object type discrimination.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_texture_glcm_basic(...)
}

wbw_object_features_texture_glcm_basic <- function(...) {
  # Extracts texture characteristics using Gray-Level Co-occurrence Matrix (GLCM) analysis computed from per-band intensity distributions within each segment. GLCM quantifies spatial co-occurrence of tone levels, generating descriptors including contrast (local variation), homogeneity (spatial regularity), energy (orderliness), entropy (disorder), and dissimilarity metrics capturing texture patterns independent of overall spectral brightness. Key features include GLCM-based texture metrics capturing local spatial patterns within segments, multi-directional analysis (horizontal, vertical, diagonal) for orientation-independent texture characterization, applicability to all image bands enabling texture fingerprinting, discrimination of textured versus smooth surfaces, and computationally tractable analysis at segment level. Use cases include surface roughness and texture-based material classification (asphalt versus concrete, crop type distinction), forest structure and density characterization through canopy texture, SAR image interpretation and urban fabric texture analysis, quality surface versus degraded surface discrimination, crop health assessment through canopy texture metrics, and cloud and shadow detection via texture anomalies. Output contrast high indicates rough/variable texture, low indicates smooth surfaces; homogeneity high indicates regular spatial patterns, low indicates chaotic texture; energy high indicates organized texture, low indicates random noise; entropy quantifies texture disorder; dissimilarity captures spatial pattern irregularity; texture profiles enable material-specific classification; combination with spectral features improves object type discrimination.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_texture_glcm_basic(...)
}

object_features_topology_relations <- function(...) {
  # Computes graph-topology features: object degree (neighbor count), dominant-neighbor strength, and articulation flags. Captures structural position in object network for hierarchical classification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_topology_relations(...)
}

wbw_object_features_topology_relations <- function(...) {
  # Computes graph-topology features: object degree (neighbor count), dominant-neighbor strength, and articulation flags. Captures structural position in object network for hierarchical classification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_features_topology_relations(...)
}

object_uncertainty_diagnostics_pro <- function(...) {
  # Computes aggregate uncertainty diagnostics from object probability outputs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_uncertainty_diagnostics_pro(...)
}

wbw_object_uncertainty_diagnostics_pro <- function(...) {
  # Computes aggregate uncertainty diagnostics from object probability outputs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$object_uncertainty_diagnostics_pro(...)
}

objects_boundary_refinement_pro <- function(...) {
  # Refines object boundaries using iterative small-region cleanup with neighbor-aware merging.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$objects_boundary_refinement_pro(...)
}

wbw_objects_boundary_refinement_pro <- function(...) {
  # Refines object boundaries using iterative small-region cleanup with neighbor-aware merging.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$objects_boundary_refinement_pro(...)
}

objects_enforce_min_mapping_unit <- function(...) {
  # Enforces a minimum mapping unit by merging undersized object segments.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$objects_enforce_min_mapping_unit(...)
}

wbw_objects_enforce_min_mapping_unit <- function(...) {
  # Enforces a minimum mapping unit by merging undersized object segments.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$objects_enforce_min_mapping_unit(...)
}

od_sensitivity_analysis <- function(...) {
  # Computes OD shortest-path costs with impedance perturbations and outputs sensitivity statistics via Monte Carlo sampling.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$od_sensitivity_analysis(...)
}

wbw_od_sensitivity_analysis <- function(...) {
  # Computes OD shortest-path costs with impedance perturbations and outputs sensitivity statistics via Monte Carlo sampling.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$od_sensitivity_analysis(...)
}

olympic_filter <- function(...) {
  # The Olympic Filter implements rank-based smoothing by removing the single highest and single lowest values from each pixel neighborhood, then averaging the remaining pixels. This robust filtering approach eliminates extreme outliers (likely noise or spurious values) while preserving the central tendency. Mathematical formulation: F = (1/(N-2)) Σ(I_sorted[2:N-1]), where sorted neighborhood values exclude highest and lowest. Implementation requires sorting small neighborhoods (computationally efficient) but produces effective noise reduction. Key features include simple outlier removal strategy, effective salt-pepper noise reduction, edge-aware filtering (edges often appear as extremes), and applicability to any data type. Olympic filtering excels in optical satellite imagery preprocessing (removes isolated bright cloud pixels and dark shadows), DEM smoothing reducing survey noise artifacts, thermal image denoising (removes sensor outliers), and radar image preprocessing. Output interpretation reveals that symmetric noise distributions (equal numbers of high/low outliers) filter symmetrically; skewed distributions (more highs or lows) produce directional filtering. Neighborhood size controls smoothing extent: 3×3 window removes 2 extremes from 9 pixels (mild filtering); larger windows filter more aggressively. Output values remain within input range (output is average of actual neighborhood values). Statistics show controlled variance reduction targeting outliers specifically. Difference images (original - filtered) highlight removed outliers; concentrated high-value regions indicate effective noise isolation. Common artifacts include insufficient smoothing if outlier frequency is low and edge blurring if edge pixels consistently rank as extremes. Multiple iterations enable progressive smoothing: single pass provides noise reduction; repeated passes intensify smoothing. Apply in rapid noise-reduction workflows requiring simple, interpretable filtering, particularly effective for salt-pepper noise in multisensor mosaics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$olympic_filter(...)
}

wbw_olympic_filter <- function(...) {
  # The Olympic Filter implements rank-based smoothing by removing the single highest and single lowest values from each pixel neighborhood, then averaging the remaining pixels. This robust filtering approach eliminates extreme outliers (likely noise or spurious values) while preserving the central tendency. Mathematical formulation: F = (1/(N-2)) Σ(I_sorted[2:N-1]), where sorted neighborhood values exclude highest and lowest. Implementation requires sorting small neighborhoods (computationally efficient) but produces effective noise reduction. Key features include simple outlier removal strategy, effective salt-pepper noise reduction, edge-aware filtering (edges often appear as extremes), and applicability to any data type. Olympic filtering excels in optical satellite imagery preprocessing (removes isolated bright cloud pixels and dark shadows), DEM smoothing reducing survey noise artifacts, thermal image denoising (removes sensor outliers), and radar image preprocessing. Output interpretation reveals that symmetric noise distributions (equal numbers of high/low outliers) filter symmetrically; skewed distributions (more highs or lows) produce directional filtering. Neighborhood size controls smoothing extent: 3×3 window removes 2 extremes from 9 pixels (mild filtering); larger windows filter more aggressively. Output values remain within input range (output is average of actual neighborhood values). Statistics show controlled variance reduction targeting outliers specifically. Difference images (original - filtered) highlight removed outliers; concentrated high-value regions indicate effective noise isolation. Common artifacts include insufficient smoothing if outlier frequency is low and edge blurring if edge pixels consistently rank as extremes. Multiple iterations enable progressive smoothing: single pass provides noise reduction; repeated passes intensify smoothing. Apply in rapid noise-reduction workflows requiring simple, interpretable filtering, particularly effective for salt-pepper noise in multisensor mosaics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$olympic_filter(...)
}

opening <- function(...) {
  # Performs a morphological opening operation using a rectangular structuring element.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$opening(...)
}

wbw_opening <- function(...) {
  # Performs a morphological opening operation using a rectangular structuring element.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$opening(...)
}

openness <- function(...) {
  # Yokoyama topographic openness: positive (exposed ridges/peaks) and negative (enclosed valleys) exposure metrics. Landform classification and visibility/microclimate analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$openness(...)
}

wbw_openness <- function(...) {
  # Yokoyama topographic openness: positive (exposed ridges/peaks) and negative (enclosed valleys) exposure metrics. Landform classification and visibility/microclimate analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$openness(...)
}

ordinary_cokriging <- function(...) {
  # Performs multivariate spatial interpolation using auxiliary variables to improve primary variable predictions. Ideal when primary data are sparse but correlated secondary data are abundant.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ordinary_cokriging(...)
}

wbw_ordinary_cokriging <- function(...) {
  # Performs multivariate spatial interpolation using auxiliary variables to improve primary variable predictions. Ideal when primary data are sparse but correlated secondary data are abundant.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ordinary_cokriging(...)
}

ordinary_kriging <- function(...) {
  # Performs kriging-based spatial interpolation from point observations to a regular grid: estimates values at unsampled locations using weighted linear combination of nearby observed values. Ordinary kriging assumes an unknown constant mean and automatically determines weights from empirical variogram structure, producing both predictions and kriging variance (prediction uncertainty).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ordinary_kriging(...)
}

wbw_ordinary_kriging <- function(...) {
  # Performs kriging-based spatial interpolation from point observations to a regular grid: estimates values at unsampled locations using weighted linear combination of nearby observed values. Ordinary kriging assumes an unknown constant mean and automatically determines weights from empirical variogram structure, producing both predictions and kriging variance (prediction uncertainty).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ordinary_kriging(...)
}

orthorectification <- function(...) {
  # DEM-based geometric correction of raw imagery using RPC camera model. Removes terrain relief displacement for georeferenced orthoimage output.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$orthorectification(...)
}

wbw_orthorectification <- function(...) {
  # DEM-based geometric correction of raw imagery using RPC camera model. Removes terrain relief displacement for georeferenced orthoimage output.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$orthorectification(...)
}

otsu_thresholding <- function(...) {
  # Otsu Thresholding is an automatic image segmentation method that determines the optimal global threshold value by maximizing inter-class variance in pixel intensity histograms. Algorithm: examines histogram of grayscale or single-band image, iteratively tests all possible threshold values, calculates between-class variance for each threshold, selects value maximizing variance separation between foreground and background classes. Non-parametric, requires no manual threshold specification. Key features: fully automatic threshold determination, robust to illumination variations, histogram-based approach permits fast computation, no external parameters, provides single global threshold. Capabilities: binary segmentation, unimodal and bimodal histogram optimization, handles narrow dynamic range or high-contrast images. Use cases: automatic image segmentation without user intervention, document binarization, water body extraction, cloud detection in satellite imagery, ice/snow mapping. Applications: change detection preprocessing, simple landcover classification, water mask generation, preliminary segmentation before advanced classification. Output interpretation: pixels below threshold classified as one class, above as another; histogram bimodality indicates quality of separation; poorly separated histograms indicate unsuitability for binary classification; statistical measures like between-class variance and uniformity indicate segmentation quality.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$otsu_thresholding(...)
}

wbw_otsu_thresholding <- function(...) {
  # Otsu Thresholding is an automatic image segmentation method that determines the optimal global threshold value by maximizing inter-class variance in pixel intensity histograms. Algorithm: examines histogram of grayscale or single-band image, iteratively tests all possible threshold values, calculates between-class variance for each threshold, selects value maximizing variance separation between foreground and background classes. Non-parametric, requires no manual threshold specification. Key features: fully automatic threshold determination, robust to illumination variations, histogram-based approach permits fast computation, no external parameters, provides single global threshold. Capabilities: binary segmentation, unimodal and bimodal histogram optimization, handles narrow dynamic range or high-contrast images. Use cases: automatic image segmentation without user intervention, document binarization, water body extraction, cloud detection in satellite imagery, ice/snow mapping. Applications: change detection preprocessing, simple landcover classification, water mask generation, preliminary segmentation before advanced classification. Output interpretation: pixels below threshold classified as one class, above as another; histogram bimodality indicates quality of separation; poorly separated histograms indicate unsuitability for binary classification; statistical measures like between-class variance and uniformity indicate segmentation quality.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$otsu_thresholding(...)
}

paired_sample_t_test <- function(...) {
  # Performs a paired-sample t-test on two rasters using paired valid cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$paired_sample_t_test(...)
}

wbw_paired_sample_t_test <- function(...) {
  # Performs a paired-sample t-test on two rasters using paired valid cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$paired_sample_t_test(...)
}

panchromatic_sharpening <- function(...) {
  # Panchromatic sharpening fuses high-resolution panchromatic imagery with lower-resolution multispectral data using the Brovey method, a spectral multiplication technique that enhances spatial detail while preserving spectral information. The method works by first resampling multispectral bands to match panchromatic resolution, then computing the intensity ratio between the panchromatic image and the computed multispectral intensity to scale each band accordingly. This approach maintains spectral fidelity while dramatically improving spatial resolution. Key features include preservation of original spectral characteristics, linear algebraic efficiency enabling fast processing of large images, automatic resampling compatibility with band-registered inputs, and automatic normalization for radiometric consistency across heterogeneous sensors. The technique is widely used in satellite image enhancement for mapping applications including urban planning, agricultural monitoring, and resource exploration where both spectral and spatial detail are critical. Panchromatic sharpening creates enhanced multispectral output with superior spatial definition suitable for visual interpretation and detailed mapping. Output bands maintain the original multispectral band order but with panchromatic-level resolution, allowing seamless integration into standard image analysis workflows and GIS systems. Spatial resolution increases match the input panchromatic resolution, enabling feature extraction at finer scales than the original multispectral data.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$panchromatic_sharpening(...)
}

wbw_panchromatic_sharpening <- function(...) {
  # Panchromatic sharpening fuses high-resolution panchromatic imagery with lower-resolution multispectral data using the Brovey method, a spectral multiplication technique that enhances spatial detail while preserving spectral information. The method works by first resampling multispectral bands to match panchromatic resolution, then computing the intensity ratio between the panchromatic image and the computed multispectral intensity to scale each band accordingly. This approach maintains spectral fidelity while dramatically improving spatial resolution. Key features include preservation of original spectral characteristics, linear algebraic efficiency enabling fast processing of large images, automatic resampling compatibility with band-registered inputs, and automatic normalization for radiometric consistency across heterogeneous sensors. The technique is widely used in satellite image enhancement for mapping applications including urban planning, agricultural monitoring, and resource exploration where both spectral and spatial detail are critical. Panchromatic sharpening creates enhanced multispectral output with superior spatial definition suitable for visual interpretation and detailed mapping. Output bands maintain the original multispectral band order but with panchromatic-level resolution, allowing seamless integration into standard image analysis workflows and GIS systems. Spatial resolution increases match the input panchromatic resolution, enabling feature extraction at finer scales than the original multispectral data.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$panchromatic_sharpening(...)
}

parallelepiped_classification <- function(...) {
  # Performs a supervised parallelepiped classification on multi-spectral rasters using polygon training data.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$parallelepiped_classification(...)
}

wbw_parallelepiped_classification <- function(...) {
  # Performs a supervised parallelepiped classification on multi-spectral rasters using polygon training data.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$parallelepiped_classification(...)
}

patch_orientation <- function(...) {
  # Calculates polygon orientation (degrees from north) using reduced major axis regression and appends ORIENT.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$patch_orientation(...)
}

wbw_patch_orientation <- function(...) {
  # Calculates polygon orientation (degrees from north) using reduced major axis regression and appends ORIENT.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$patch_orientation(...)
}

pca_based_change_detection <- function(...) {
  # Principal component analysis change detection identifies land cover changes by computing principal components from multitemporal stacked spectral data, where early components capture common patterns across time and later components isolate temporal changes. The algorithm stacks multitemporal multispectral data (coregistered to common grid), computes PCA transforming into uncorrelated orthogonal spectral-temporal components, interprets later PCs as change-sensitive, and applies statistical thresholding to PC loadings/scores for change detection. PCA-based detection excels when change signals are spectrally subtle because PCA maximizes variance and separates temporally consistent spectral patterns (early PCs) from temporal variation (later PCs). Key features include multidate data fusion handling variable image counts and coregistration requirements, automatic variance maximization emphasizing important spectral-temporal patterns, multivariate statistics improving change discrimination versus univariate differencing, and optional spatial filtering reducing pixel noise. Applications include subtle vegetation stress detection preceding visual recognition, multispectral urban change detection tracking development over decades, natural disaster impact assessment through rapid damage mapping, and environmental monitoring detecting ecosystem state transitions. PCA-based detection output distinguishes temporal patterns. Output comprises principal component imagery with interpretable spectral-temporal loadings, change probability raster derived from later component scores, and optional change classification disambiguating change types; PC spatial patterns enable visual pattern recognition complementing statistical detection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$pca_based_change_detection(...)
}

wbw_pca_based_change_detection <- function(...) {
  # Principal component analysis change detection identifies land cover changes by computing principal components from multitemporal stacked spectral data, where early components capture common patterns across time and later components isolate temporal changes. The algorithm stacks multitemporal multispectral data (coregistered to common grid), computes PCA transforming into uncorrelated orthogonal spectral-temporal components, interprets later PCs as change-sensitive, and applies statistical thresholding to PC loadings/scores for change detection. PCA-based detection excels when change signals are spectrally subtle because PCA maximizes variance and separates temporally consistent spectral patterns (early PCs) from temporal variation (later PCs). Key features include multidate data fusion handling variable image counts and coregistration requirements, automatic variance maximization emphasizing important spectral-temporal patterns, multivariate statistics improving change discrimination versus univariate differencing, and optional spatial filtering reducing pixel noise. Applications include subtle vegetation stress detection preceding visual recognition, multispectral urban change detection tracking development over decades, natural disaster impact assessment through rapid damage mapping, and environmental monitoring detecting ecosystem state transitions. PCA-based detection output distinguishes temporal patterns. Output comprises principal component imagery with interpretable spectral-temporal loadings, change probability raster derived from later component scores, and optional change classification disambiguating change types; PC spatial patterns enable visual pattern recognition complementing statistical detection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$pca_based_change_detection(...)
}

pennock_landform_classification <- function(...) {
  # Classifies landform elements into seven Pennock et al. (1987) terrain classes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$pennock_landform_classification(...)
}

wbw_pennock_landform_classification <- function(...) {
  # Classifies landform elements into seven Pennock et al. (1987) terrain classes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$pennock_landform_classification(...)
}

percent_elev_range <- function(...) {
  # Calculates local topographic position as percent of neighbourhood elevation range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percent_elev_range(...)
}

wbw_percent_elev_range <- function(...) {
  # Calculates local topographic position as percent of neighbourhood elevation range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percent_elev_range(...)
}

percent_equal_to <- function(...) {
  # Computes the fraction of rasters in a stack whose values equal the comparison raster at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percent_equal_to(...)
}

wbw_percent_equal_to <- function(...) {
  # Computes the fraction of rasters in a stack whose values equal the comparison raster at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percent_equal_to(...)
}

percent_greater_than <- function(...) {
  # Computes the fraction of rasters in a stack whose values are greater than the comparison raster at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percent_greater_than(...)
}

wbw_percent_greater_than <- function(...) {
  # Computes the fraction of rasters in a stack whose values are greater than the comparison raster at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percent_greater_than(...)
}

percent_less_than <- function(...) {
  # Computes the fraction of rasters in a stack whose values are less than the comparison raster at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percent_less_than(...)
}

wbw_percent_less_than <- function(...) {
  # Computes the fraction of rasters in a stack whose values are less than the comparison raster at each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percent_less_than(...)
}

percentage_contrast_stretch <- function(...) {
  # Percentage Contrast Stretch performs linear contrast enhancement by removing specified percentages of extreme values (tails) from the histogram before stretching to full dynamic range. Algorithm: removes lower and upper percentile values from each band independently, linearly maps remaining range to output range (typically 0-255 or full bit-depth), eliminates radiometric extremes causing poor contrast. Percentile selection (commonly 2-3%) balances contrast enhancement against preservation of data integrity. Key features: removes radiometric outliers automatically, prevents contrast compression from anomalous values, applicable per-band or globally, computationally efficient linear transformation, invertible operation. Capabilities: handles radiometric artifacts, enhances visibility of subtle features, accommodates variable input ranges. Use cases: preprocessing before classification or fusion, enhancement of underutilized dynamic range, preparation for multispectral display, radiometric normalization across scenes. Applications: satellite imagery enhancement for visual interpretation, preprocessing satellite-based landslide detection, pre-classification normalization, archived imagery remediation. Output interpretation: enhanced imagery displays improved contrast; extreme values become clipped; subtle features previously hidden become visible; band-specific clipping values reveal radiometric distribution quality.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percentage_contrast_stretch(...)
}

wbw_percentage_contrast_stretch <- function(...) {
  # Percentage Contrast Stretch performs linear contrast enhancement by removing specified percentages of extreme values (tails) from the histogram before stretching to full dynamic range. Algorithm: removes lower and upper percentile values from each band independently, linearly maps remaining range to output range (typically 0-255 or full bit-depth), eliminates radiometric extremes causing poor contrast. Percentile selection (commonly 2-3%) balances contrast enhancement against preservation of data integrity. Key features: removes radiometric outliers automatically, prevents contrast compression from anomalous values, applicable per-band or globally, computationally efficient linear transformation, invertible operation. Capabilities: handles radiometric artifacts, enhances visibility of subtle features, accommodates variable input ranges. Use cases: preprocessing before classification or fusion, enhancement of underutilized dynamic range, preparation for multispectral display, radiometric normalization across scenes. Applications: satellite imagery enhancement for visual interpretation, preprocessing satellite-based landslide detection, pre-classification normalization, archived imagery remediation. Output interpretation: enhanced imagery displays improved contrast; extreme values become clipped; subtle features previously hidden become visible; band-specific clipping values reveal radiometric distribution quality.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percentage_contrast_stretch(...)
}

percentile_filter <- function(...) {
  # Computes local percentile rank of center cell elevation/value within moving window (0-100%). Analogous to Elevation Percentile for generic raster data. Measures relative position: output=0 indicates local minimum, output=100 indicates local maximum, output=50 indicates median. Reveals local position-in-distribution independently of absolute values.  Percentile filtering enables position-relative analysis. Useful for layering analysis: cells ranking high percentile (>80) in all bands indicate "bright" features; low percentile (<20) indicate "dark" features. Particularly useful for classification preprocessing—separates terrain/texture position rather than just magnitude. Often combined with statistical filters for multi-metric characterization.  Applications: (1) Relative brightness/darkness classification, (2) Texture characterization (high percentile variance = rough, low variance = smooth), (3) Local contrast enhancement (percentile-based normalization), (4) Landform identification similar to elevation percentile, (5) Multi-band texture analysis (apply percentile to each band, compare patterns).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percentile_filter(...)
}

wbw_percentile_filter <- function(...) {
  # Computes local percentile rank of center cell elevation/value within moving window (0-100%). Analogous to Elevation Percentile for generic raster data. Measures relative position: output=0 indicates local minimum, output=100 indicates local maximum, output=50 indicates median. Reveals local position-in-distribution independently of absolute values.  Percentile filtering enables position-relative analysis. Useful for layering analysis: cells ranking high percentile (>80) in all bands indicate "bright" features; low percentile (<20) indicate "dark" features. Particularly useful for classification preprocessing—separates terrain/texture position rather than just magnitude. Often combined with statistical filters for multi-metric characterization.  Applications: (1) Relative brightness/darkness classification, (2) Texture characterization (high percentile variance = rough, low variance = smooth), (3) Local contrast enhancement (percentile-based normalization), (4) Landform identification similar to elevation percentile, (5) Multi-band texture analysis (apply percentile to each band, compare patterns).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$percentile_filter(...)
}

perimeter_area_ratio <- function(...) {
  # Calculates polygon perimeter/area ratio and appends P_A_RATIO.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$perimeter_area_ratio(...)
}

wbw_perimeter_area_ratio <- function(...) {
  # Calculates polygon perimeter/area ratio and appends P_A_RATIO.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$perimeter_area_ratio(...)
}

phi_coefficient <- function(...) {
  # Performs binary classification agreement assessment using the phi coefficient.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$phi_coefficient(...)
}

wbw_phi_coefficient <- function(...) {
  # Performs binary classification agreement assessment using the phi coefficient.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$phi_coefficient(...)
}

pick_from_list <- function(...) {
  # Selects per-cell values from a raster stack using a zero-based position raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$pick_from_list(...)
}

wbw_pick_from_list <- function(...) {
  # Selects per-cell values from a raster stack using a zero-based position raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$pick_from_list(...)
}

piecewise_contrast_stretch <- function(...) {
  # Performs piecewise linear contrast stretching using user-specified breakpoints.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$piecewise_contrast_stretch(...)
}

wbw_piecewise_contrast_stretch <- function(...) {
  # Performs piecewise linear contrast stretching using user-specified breakpoints.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$piecewise_contrast_stretch(...)
}

plan_curvature <- function(...) {
  # Calculates plan (contour) curvature measuring convergence/divergence of flow across contour lines. Positive values (convergent) indicate flow concentration toward center (concave); negative values (divergent) indicate flow dispersal away from center (convex). Identifies lateral flow concentration zones (valleys) vs. dispersal zones (ridges). Essential for predicting soil moisture distribution and landslide susceptibility.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$plan_curvature(...)
}

wbw_plan_curvature <- function(...) {
  # Calculates plan (contour) curvature measuring convergence/divergence of flow across contour lines. Positive values (convergent) indicate flow concentration toward center (concave); negative values (divergent) indicate flow dispersal away from center (convex). Identifies lateral flow concentration zones (valleys) vs. dispersal zones (ridges). Essential for predicting soil moisture distribution and landslide susceptibility.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$plan_curvature(...)
}

point_pattern_envelope <- function(...) {
  # Generate critical-band envelopes for hypothesis testing against CSR.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$point_pattern_envelope(...)
}

wbw_point_pattern_envelope <- function(...) {
  # Generate critical-band envelopes for hypothesis testing against CSR.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$point_pattern_envelope(...)
}

point_process_residuals <- function(...) {
  # Computes residuals from fitted Poisson point process model for diagnostics. Detects unmodeled spatial structure.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$point_process_residuals(...)
}

wbw_point_process_residuals <- function(...) {
  # Computes residuals from fitted Poisson point process model for diagnostics. Detects unmodeled spatial structure.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$point_process_residuals(...)
}

point_process_residuals_comparison <- function(...) {
  # Compute residual diagnostics for model adequacy checking.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$point_process_residuals_comparison(...)
}

wbw_point_process_residuals_comparison <- function(...) {
  # Compute residual diagnostics for model adequacy checking.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$point_process_residuals_comparison(...)
}

points_along_lines <- function(...) {
  # Generates regular-spaced point features along input polylines for infrastructure monitoring, environmental sampling, and spatial analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$points_along_lines(...)
}

wbw_points_along_lines <- function(...) {
  # Generates regular-spaced point features along input polylines for infrastructure monitoring, environmental sampling, and spatial analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$points_along_lines(...)
}

polygon_area <- function(...) {
  # Calculates polygon area and appends an AREA attribute field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygon_area(...)
}

wbw_polygon_area <- function(...) {
  # Calculates polygon area and appends an AREA attribute field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygon_area(...)
}

polygon_long_axis <- function(...) {
  # Maps the long axis of each polygon feature's minimum bounding box as line output.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygon_long_axis(...)
}

wbw_polygon_long_axis <- function(...) {
  # Maps the long axis of each polygon feature's minimum bounding box as line output.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygon_long_axis(...)
}

polygon_perimeter <- function(...) {
  # Calculates polygon perimeter and appends a PERIMETER attribute field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygon_perimeter(...)
}

wbw_polygon_perimeter <- function(...) {
  # Calculates polygon perimeter and appends a PERIMETER attribute field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygon_perimeter(...)
}

polygon_short_axis <- function(...) {
  # Maps the short axis of each polygon feature's minimum bounding box as line output.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygon_short_axis(...)
}

wbw_polygon_short_axis <- function(...) {
  # Maps the short axis of each polygon feature's minimum bounding box as line output.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygon_short_axis(...)
}

polygonize <- function(...) {
  # Creates polygons from input linework, including intersecting/open segments where enclosed faces can be formed.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygonize(...)
}

wbw_polygonize <- function(...) {
  # Creates polygons from input linework, including intersecting/open segments where enclosed faces can be formed.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygonize(...)
}

polygons_to_lines <- function(...) {
  # Converts polygon and multipolygon features into linework tracing their boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygons_to_lines(...)
}

wbw_polygons_to_lines <- function(...) {
  # Converts polygon and multipolygon features into linework tracing their boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygons_to_lines(...)
}

polygons_to_segments <- function(...) {
  # Rasterizes edited polygons back to segment-label raster preserving object IDs or attribute values. Enables iterative OBIA workflows combining automated segmentation with manual refinement.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygons_to_segments(...)
}

wbw_polygons_to_segments <- function(...) {
  # Rasterizes edited polygons back to segment-label raster preserving object IDs or attribute values. Enables iterative OBIA workflows combining automated segmentation with manual refinement.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$polygons_to_segments(...)
}

post_classification_change <- function(...) {
  # Post-classification change detection quantifies land-cover/land-use (LULC) transitions by directly comparing independently classified maps from different time periods. Pixel-by-pixel class comparisons identify transitions showing "from" and "to" classes. Cross-tabulation matrices (confusion matrices) quantify transition frequencies revealing dominant change pathways. Method requires consistent classification schemes across dates; accuracy depends on classification quality at each time step. Key Features: Direct class-to-class transition mapping; independence of individual classifications; enables heterogeneous sensor combinations; quantifies transition frequencies; identifies change hotspots. Use Cases: Deforestation monitoring; urban growth mapping; agricultural land-use tracking; wetland loss detection; habitat fragmentation assessment. Output Interpretation: Transition matrices show diagonal no-change values and off-diagonal transition frequencies. Change maps highlight altered pixels; transition-coded output encodes both source and target classes enabling interpretation. High accuracy requires quality classifications; classification errors at either date propagate to change detection errors. Transition aggregation reveals dominant patterns (e.g., forest→agriculture, grassland→urban). Sub-pixel transitions cannot be detected via post-classification method; fine-scale changes may be missed.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$post_classification_change(...)
}

wbw_post_classification_change <- function(...) {
  # Post-classification change detection quantifies land-cover/land-use (LULC) transitions by directly comparing independently classified maps from different time periods. Pixel-by-pixel class comparisons identify transitions showing "from" and "to" classes. Cross-tabulation matrices (confusion matrices) quantify transition frequencies revealing dominant change pathways. Method requires consistent classification schemes across dates; accuracy depends on classification quality at each time step. Key Features: Direct class-to-class transition mapping; independence of individual classifications; enables heterogeneous sensor combinations; quantifies transition frequencies; identifies change hotspots. Use Cases: Deforestation monitoring; urban growth mapping; agricultural land-use tracking; wetland loss detection; habitat fragmentation assessment. Output Interpretation: Transition matrices show diagonal no-change values and off-diagonal transition frequencies. Change maps highlight altered pixels; transition-coded output encodes both source and target classes enabling interpretation. High accuracy requires quality classifications; classification errors at either date propagate to change detection errors. Transition aggregation reveals dominant patterns (e.g., forest→agriculture, grassland→urban). Sub-pixel transitions cannot be detected via post-classification method; fine-scale changes may be missed.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$post_classification_change(...)
}

power <- function(...) {
  # Raises the first raster to the power of the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$power(...)
}

wbw_power <- function(...) {
  # Raises the first raster to the power of the second on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$power(...)
}

prewitt_filter <- function(...) {
  # The Prewitt operator performs gradient-based edge detection similar to Sobel, using alternative kernel weights optimized for different noise characteristics. Implementation employs two 3×3 convolution kernels computing x and y directional derivatives with uniform weighting on center and adjacent rows/columns, differing from Sobel's center-biasing approach. The gradient magnitude combines directional components via √(Gx² + Gy²), providing uniform directionality response. Mathematical foundation rests on discrete differentiation approximations equally weighting all contributing pixels rather than emphasizing centers. Key features include slightly different noise response compared to Sobel (sometimes superior in extremely noisy imagery), true magnitude/direction decomposition enabling sophisticated edge analysis, computational efficiency requiring only standard convolution operations, and proven effectiveness on radar, optical, and thermal imagery. Prewitt filtering excels in SAR image analysis where uniform weighting reduces speckle artifacts better than Sobel, thermal anomaly detection emphasizing linear features, and multi-spectral edge extraction requiring direction-independent processing. Output interpretation parallels Sobel: magnitude indicates edge strength (higher = sharper), direction computed via atan2(Gy, Gx) provides edge orientation in radians. Typical magnitude ranges 0-256 for 8-bit input; magnitudes exceeding 80 generally indicate significant edges. Direction values range -π to +π; 0 radians indicates pure horizontal edges, ±π/2 indicates pure vertical edges. The uniform kernel weighting typically produces slightly smoother gradient responses than Sobel, potentially better for sparse or fine imagery features. Apply complementary median filtering to reduce noise-induced false positives. Combine directional output with threshold selection for edge linking and boundary extraction workflows critical to segmentation pipelines.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$prewitt_filter(...)
}

wbw_prewitt_filter <- function(...) {
  # The Prewitt operator performs gradient-based edge detection similar to Sobel, using alternative kernel weights optimized for different noise characteristics. Implementation employs two 3×3 convolution kernels computing x and y directional derivatives with uniform weighting on center and adjacent rows/columns, differing from Sobel's center-biasing approach. The gradient magnitude combines directional components via √(Gx² + Gy²), providing uniform directionality response. Mathematical foundation rests on discrete differentiation approximations equally weighting all contributing pixels rather than emphasizing centers. Key features include slightly different noise response compared to Sobel (sometimes superior in extremely noisy imagery), true magnitude/direction decomposition enabling sophisticated edge analysis, computational efficiency requiring only standard convolution operations, and proven effectiveness on radar, optical, and thermal imagery. Prewitt filtering excels in SAR image analysis where uniform weighting reduces speckle artifacts better than Sobel, thermal anomaly detection emphasizing linear features, and multi-spectral edge extraction requiring direction-independent processing. Output interpretation parallels Sobel: magnitude indicates edge strength (higher = sharper), direction computed via atan2(Gy, Gx) provides edge orientation in radians. Typical magnitude ranges 0-256 for 8-bit input; magnitudes exceeding 80 generally indicate significant edges. Direction values range -π to +π; 0 radians indicates pure horizontal edges, ±π/2 indicates pure vertical edges. The uniform kernel weighting typically produces slightly smoother gradient responses than Sobel, potentially better for sparse or fine imagery features. Apply complementary median filtering to reduce noise-induced false positives. Combine directional output with threshold selection for edge linking and boundary extraction workflows critical to segmentation pipelines.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$prewitt_filter(...)
}

principal_component_analysis <- function(...) {
  # Performs PCA on a stack of rasters, returning component images and a JSON report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$principal_component_analysis(...)
}

wbw_principal_component_analysis <- function(...) {
  # Performs PCA on a stack of rasters, returning component images and a JSON report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$principal_component_analysis(...)
}

principal_curvature_direction <- function(...) {
  # Calculates the principal curvature direction angle (degrees).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$principal_curvature_direction(...)
}

wbw_principal_curvature_direction <- function(...) {
  # Calculates the principal curvature direction angle (degrees).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$principal_curvature_direction(...)
}

print_geotiff_tags <- function(...) {
  # Produces a text report describing TIFF/GeoTIFF tags and key metadata for an input GeoTIFF-family raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$print_geotiff_tags(...)
}

wbw_print_geotiff_tags <- function(...) {
  # Produces a text report describing TIFF/GeoTIFF tags and key metadata for an input GeoTIFF-family raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$print_geotiff_tags(...)
}

profile <- function(...) {
  # Creates an HTML elevation profile plot for one or more input polyline features sampled from a surface raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$profile(...)
}

wbw_profile <- function(...) {
  # Creates an HTML elevation profile plot for one or more input polyline features sampled from a surface raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$profile(...)
}

profile_curvature <- function(...) {
  # Calculates profile (downslope) curvature measuring flow acceleration/deceleration along slope direction. Positive values (concave) indicate flow acceleration zones (erosional); negative values (convex) indicate flow deceleration zones (depositional). Reveals slope form: concave (valley bottoms, erosion), convex (ridges, material removal), linear (transitional).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$profile_curvature(...)
}

wbw_profile_curvature <- function(...) {
  # Calculates profile (downslope) curvature measuring flow acceleration/deceleration along slope direction. Positive values (concave) indicate flow acceleration zones (erosional); negative values (convex) indicate flow deceleration zones (depositional). Reveals slope form: concave (valley bottoms, erosion), convex (ridges, material removal), linear (transitional).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$profile_curvature(...)
}

propagate_labels_across_hierarchy <- function(...) {
  # Propagates coarse-level class labels to fine-level child objects via hierarchy mappings. Enables efficient labeling of nested hierarchies and inheritance-based refinement workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$propagate_labels_across_hierarchy(...)
}

wbw_propagate_labels_across_hierarchy <- function(...) {
  # Propagates coarse-level class labels to fine-level child objects via hierarchy mappings. Enables efficient labeling of nested hierarchies and inheritance-based refinement workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$propagate_labels_across_hierarchy(...)
}

prune_vector_streams <- function(...) {
  # Prunes vector stream network based on Shreve magnitude.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$prune_vector_streams(...)
}

wbw_prune_vector_streams <- function(...) {
  # Prunes vector stream network based on Shreve magnitude.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$prune_vector_streams(...)
}

qin_flow_accumulation <- function(...) {
  # Calculates Qin MFD flow accumulation from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$qin_flow_accumulation(...)
}

wbw_qin_flow_accumulation <- function(...) {
  # Calculates Qin MFD flow accumulation from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$qin_flow_accumulation(...)
}

quadrat_count_test <- function(...) {
  # Performs chi-square test of point-pattern randomness using quadrat counts. Tests for clustering vs. dispersion.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$quadrat_count_test(...)
}

wbw_quadrat_count_test <- function(...) {
  # Performs chi-square test of point-pattern randomness using quadrat counts. Tests for clustering vs. dispersion.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$quadrat_count_test(...)
}

quantiles <- function(...) {
  # Transforms raster values into quantile classes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$quantiles(...)
}

wbw_quantiles <- function(...) {
  # Transforms raster values into quantile classes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$quantiles(...)
}

quinn_flow_accumulation <- function(...) {
  # Calculates Quinn MFD flow accumulation from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$quinn_flow_accumulation(...)
}

wbw_quinn_flow_accumulation <- function(...) {
  # Calculates Quinn MFD flow accumulation from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$quinn_flow_accumulation(...)
}

radial_basis_function_interpolation <- function(...) {
  # Interpolates a raster from point samples using local radial-basis similarity weighting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$radial_basis_function_interpolation(...)
}

wbw_radial_basis_function_interpolation <- function(...) {
  # Interpolates a raster from point samples using local radial-basis similarity weighting.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$radial_basis_function_interpolation(...)
}

radius_of_gyration <- function(...) {
  # Computes per-patch radius of gyration and maps values back to patch cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$radius_of_gyration(...)
}

wbw_radius_of_gyration <- function(...) {
  # Computes per-patch radius of gyration and maps values back to patch cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$radius_of_gyration(...)
}

raise_walls <- function(...) {
  # Raises DEM elevations along wall vectors and optionally breaches selected crossings.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raise_walls(...)
}

wbw_raise_walls <- function(...) {
  # Raises DEM elevations along wall vectors and optionally breaches selected crossings.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raise_walls(...)
}

random_field <- function(...) {
  # Creates a raster containing standard normal random values.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_field(...)
}

wbw_random_field <- function(...) {
  # Creates a raster containing standard normal random values.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_field(...)
}

random_forest_classification <- function(...) {
  # Random Forest classification assigns labels through ensemble decision trees trained on bootstrap samples with randomized feature subsets. Each tree grows independently without pruning, capturing complex non-linear relationships and interactions among features. Classification aggregates votes across typically 100-1000 trees; final class is majority vote. Bootstrap training and random feature selection reduce overfitting while capturing high-dimensional patterns. Feature importance can be computed from out-of-bag error changes, identifying diagnostic spectral bands or derived features most relevant to classification. Key features include variable importance ranking identifying key classification features, per-pixel classification confidence from vote consensus across ensemble trees, automatic handling of high-dimensional hyperspectral data, robustness to spectral outliers and noise, and parallelizable training and prediction. The tool efficiently processes multiclass problems with imbalanced training sets. Applications include land cover classification from multispectral and hyperspectral data, change detection identifying spectral transitions between maps, crop type classification from multi-temporal satellite imagery, urban material classification distinguishing building types and surfaces, and anomaly detection identifying spectral outliers. Random forests consistently achieve high accuracy in remote sensing applications with relatively modest training data. Output interpretation: Vote counts provide classification confidence; unanimous or strong majority votes (>80%) indicate confident classifications while narrow margins suggest mixed-pixel ambiguity. Feature importance rankings identify spectral bands or derived indices most diagnostic for classification. Out-of-bag error estimates generalization performance without hold-out validation. Feature interactions are implicit; high accuracy from particular band combinations suggests non-linear spectral relationships.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_classification(...)
}

wbw_random_forest_classification <- function(...) {
  # Random Forest classification assigns labels through ensemble decision trees trained on bootstrap samples with randomized feature subsets. Each tree grows independently without pruning, capturing complex non-linear relationships and interactions among features. Classification aggregates votes across typically 100-1000 trees; final class is majority vote. Bootstrap training and random feature selection reduce overfitting while capturing high-dimensional patterns. Feature importance can be computed from out-of-bag error changes, identifying diagnostic spectral bands or derived features most relevant to classification. Key features include variable importance ranking identifying key classification features, per-pixel classification confidence from vote consensus across ensemble trees, automatic handling of high-dimensional hyperspectral data, robustness to spectral outliers and noise, and parallelizable training and prediction. The tool efficiently processes multiclass problems with imbalanced training sets. Applications include land cover classification from multispectral and hyperspectral data, change detection identifying spectral transitions between maps, crop type classification from multi-temporal satellite imagery, urban material classification distinguishing building types and surfaces, and anomaly detection identifying spectral outliers. Random forests consistently achieve high accuracy in remote sensing applications with relatively modest training data. Output interpretation: Vote counts provide classification confidence; unanimous or strong majority votes (>80%) indicate confident classifications while narrow margins suggest mixed-pixel ambiguity. Feature importance rankings identify spectral bands or derived indices most diagnostic for classification. Out-of-bag error estimates generalization performance without hold-out validation. Feature interactions are implicit; high accuracy from particular band combinations suggests non-linear spectral relationships.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_classification(...)
}

random_forest_classification_fit <- function(...) {
  # Fits a random forest classification model and returns serialized model bytes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_classification_fit(...)
}

wbw_random_forest_classification_fit <- function(...) {
  # Fits a random forest classification model and returns serialized model bytes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_classification_fit(...)
}

random_forest_classification_predict <- function(...) {
  # Applies a serialized random forest classification model to multi-band predictors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_classification_predict(...)
}

wbw_random_forest_classification_predict <- function(...) {
  # Applies a serialized random forest classification model to multi-band predictors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_classification_predict(...)
}

random_forest_regression <- function(...) {
  # Performs supervised random forest regression on multi-band input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_regression(...)
}

wbw_random_forest_regression <- function(...) {
  # Performs supervised random forest regression on multi-band input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_regression(...)
}

random_forest_regression_fit <- function(...) {
  # Fits a random forest regression model and returns serialized model bytes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_regression_fit(...)
}

wbw_random_forest_regression_fit <- function(...) {
  # Fits a random forest regression model and returns serialized model bytes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_regression_fit(...)
}

random_forest_regression_predict <- function(...) {
  # Applies a serialized random forest regression model to multi-band predictors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_regression_predict(...)
}

wbw_random_forest_regression_predict <- function(...) {
  # Applies a serialized random forest regression model to multi-band predictors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_forest_regression_predict(...)
}

random_points_in_polygon <- function(...) {
  # Generates random points uniformly within input polygon geometries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_points_in_polygon(...)
}

wbw_random_points_in_polygon <- function(...) {
  # Generates random points uniformly within input polygon geometries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_points_in_polygon(...)
}

random_sample <- function(...) {
  # Creates a raster containing randomly located sample cells with unique IDs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_sample(...)
}

wbw_random_sample <- function(...) {
  # Creates a raster containing randomly located sample cells with unique IDs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$random_sample(...)
}

range_filter <- function(...) {
  # Computes moving-window range (maximum - minimum), revealing local value spread independent of mean level. Simple heterogeneity metric: high range = diverse values, low range = uniform values. Simpler than standard deviation but equally informative for many applications, and more robust to distribution shape.  Range is computationally efficient (requires only two comparisons). Particularly useful for detecting transitions/boundaries where range spikes indicate contrast zones. Less sensitive to distribution shape than stdev (stdev emphasizes outliers, range only uses extremes). Normalized range (range/mean) enables cross-band comparison like coefficient of variation enables cross-scale comparison.  Applications: (1) Texture/contrast mapping (easy interpretation: high range = rough/contrasted), (2) Boundary detection via range peaks, (3) Computational efficiency alternative to stdev, (4) Quality control (uniform background low range, feature areas high range), (5) Roughness/variability in generic data. Typical workflow: compute range→threshold to identify transition zones→vectorize high-range boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$range_filter(...)
}

wbw_range_filter <- function(...) {
  # Computes moving-window range (maximum - minimum), revealing local value spread independent of mean level. Simple heterogeneity metric: high range = diverse values, low range = uniform values. Simpler than standard deviation but equally informative for many applications, and more robust to distribution shape.  Range is computationally efficient (requires only two comparisons). Particularly useful for detecting transitions/boundaries where range spikes indicate contrast zones. Less sensitive to distribution shape than stdev (stdev emphasizes outliers, range only uses extremes). Normalized range (range/mean) enables cross-band comparison like coefficient of variation enables cross-scale comparison.  Applications: (1) Texture/contrast mapping (easy interpretation: high range = rough/contrasted), (2) Boundary detection via range peaks, (3) Computational efficiency alternative to stdev, (4) Quality control (uniform background low range, feature areas high range), (5) Roughness/variability in generic data. Typical workflow: compute range→threshold to identify transition zones→vectorize high-range boundaries.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$range_filter(...)
}

raster_area <- function(...) {
  # Estimates per-class raster polygon area in grid-cell or map units and writes class totals to each class cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_area(...)
}

wbw_raster_area <- function(...) {
  # Estimates per-class raster polygon area in grid-cell or map units and writes class totals to each class cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_area(...)
}

raster_calculator <- function(...) {
  # Evaluates a mathematical expression on a list of input rasters cell-by-cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_calculator(...)
}

wbw_raster_calculator <- function(...) {
  # Evaluates a mathematical expression on a list of input rasters cell-by-cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_calculator(...)
}

raster_cell_assignment <- function(...) {
  # Creates a raster derived from a base raster assigning row, column, x, or y values to each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_cell_assignment(...)
}

wbw_raster_cell_assignment <- function(...) {
  # Creates a raster derived from a base raster assigning row, column, x, or y values to each cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_cell_assignment(...)
}

raster_histogram <- function(...) {
  # Builds a fixed-bin histogram for valid raster cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_histogram(...)
}

wbw_raster_histogram <- function(...) {
  # Builds a fixed-bin histogram for valid raster cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_histogram(...)
}

raster_perimeter <- function(...) {
  # Estimates per-class raster polygon perimeter using an anti-aliasing lookup table and writes class totals to each class cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_perimeter(...)
}

wbw_raster_perimeter <- function(...) {
  # Estimates per-class raster polygon perimeter using an anti-aliasing lookup table and writes class totals to each class cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_perimeter(...)
}

raster_streams_to_vector <- function(...) {
  # Converts raster stream network to vector.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_streams_to_vector(...)
}

wbw_raster_streams_to_vector <- function(...) {
  # Converts raster stream network to vector.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_streams_to_vector(...)
}

raster_summary_stats <- function(...) {
  # Computes basic summary statistics for valid raster cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_summary_stats(...)
}

wbw_raster_summary_stats <- function(...) {
  # Computes basic summary statistics for valid raster cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_summary_stats(...)
}

raster_to_vector_lines <- function(...) {
  # Converts non-zero, non-nodata raster line cells into polyline vector features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_to_vector_lines(...)
}

wbw_raster_to_vector_lines <- function(...) {
  # Converts non-zero, non-nodata raster line cells into polyline vector features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_to_vector_lines(...)
}

raster_to_vector_points <- function(...) {
  # Converts non-zero, non-nodata cells in a raster into point features located at cell centres.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_to_vector_points(...)
}

wbw_raster_to_vector_points <- function(...) {
  # Converts non-zero, non-nodata cells in a raster into point features located at cell centres.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_to_vector_points(...)
}

raster_to_vector_polygons <- function(...) {
  # Converts non-zero, non-nodata raster regions into polygon vector features with FID and VALUE attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_to_vector_polygons(...)
}

wbw_raster_to_vector_polygons <- function(...) {
  # Converts non-zero, non-nodata raster regions into polygon vector features with FID and VALUE attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$raster_to_vector_polygons(...)
}

rasterize_streams <- function(...) {
  # Rasterizes vector stream network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rasterize_streams(...)
}

wbw_rasterize_streams <- function(...) {
  # Rasterizes vector stream network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rasterize_streams(...)
}

reciprocal <- function(...) {
  # Computes the reciprocal (1/x) of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reciprocal(...)
}

wbw_reciprocal <- function(...) {
  # Computes the reciprocal (1/x) of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reciprocal(...)
}

reclass <- function(...) {
  # Reclassifies raster values using either ranges or exact assignment pairs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reclass(...)
}

wbw_reclass <- function(...) {
  # Reclassifies raster values using either ranges or exact assignment pairs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reclass(...)
}

reclass_equal_interval <- function(...) {
  # Reclassifies raster values into equal-width intervals over an optional value range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reclass_equal_interval(...)
}

wbw_reclass_equal_interval <- function(...) {
  # Reclassifies raster values into equal-width intervals over an optional value range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reclass_equal_interval(...)
}

recover_flightline_info <- function(...) {
  # Reconstructs flightline IDs from GPS time gaps: infers flight-line boundaries, marks in point-source-ID/user-data/RGB. Flight-path recovery.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$recover_flightline_info(...)
}

wbw_recover_flightline_info <- function(...) {
  # Reconstructs flightline IDs from GPS time gaps: infers flight-line boundaries, marks in point-source-ID/user-data/RGB. Flight-path recovery.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$recover_flightline_info(...)
}

rectangular_grid_from_raster_base <- function(...) {
  # Creates a rectangular polygon grid covering a raster extent.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rectangular_grid_from_raster_base(...)
}

wbw_rectangular_grid_from_raster_base <- function(...) {
  # Creates a rectangular polygon grid covering a raster extent.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rectangular_grid_from_raster_base(...)
}

rectangular_grid_from_vector_base <- function(...) {
  # Creates a rectangular polygon grid covering a vector-layer bounding extent.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rectangular_grid_from_vector_base(...)
}

wbw_rectangular_grid_from_vector_base <- function(...) {
  # Creates a rectangular polygon grid covering a vector-layer bounding extent.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rectangular_grid_from_vector_base(...)
}

refined_lee_filter <- function(...) {
  # The Refined Lee filter improves upon standard Lee filtering through enhanced coherence estimation and edge-preserving adaptations, using refined local statistics and directional analysis for superior speckle reduction. Implementation extends Lee's model by detecting edge orientation, applying directional windows aligned with boundaries, and computing refined coherence estimates. Mathematically: F = μ + √(σ_p²/(σ_I²))·(I - μ) with directionally-aligned variance computation. This refinement improves edge preservation while maintaining speckle suppression. Key features include directional sensitivity (adapts filtering direction to image structures), improved coherence estimation (uses anisotropic windows), superior edge preservation versus standard Lee, and effectiveness on complex SAR scenes. Refined Lee filtering excels in change detection requiring sharp boundaries, InSAR coherence map preparation, polarimetric SAR processing where target preservation is critical, and forestry SAR analysis distinguishing trees from background. Output interpretation reveals that filtering respects edge orientation: horizontal edges filter horizontally; vertical edges filter vertically; diagonal edges filter diagonally. This directional adaptation minimizes filtering across true boundaries. Coherence estimates typically more accurate than standard Lee, reducing filtering artifacts. Output ranges match input; directional adaptation becomes apparent via visual inspection (edges remain sharper than standard Lee). Statistics show greater preservation of high-contrast regions. Directional components reveal scene structure orientation; strong directional bias indicates predominant feature orientation. Common artifacts reduce relative to standard Lee, particularly near edges and complex features. Artifacts include potential over-adaptation if directional estimation fails and directional window artifacts at weak boundaries. Monitor coherence maps to validate edge detection accuracy. Apply strategically in SAR classification where directional structures (e.g., forests, aligned agricultural fields) must be preserved.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$refined_lee_filter(...)
}

wbw_refined_lee_filter <- function(...) {
  # The Refined Lee filter improves upon standard Lee filtering through enhanced coherence estimation and edge-preserving adaptations, using refined local statistics and directional analysis for superior speckle reduction. Implementation extends Lee's model by detecting edge orientation, applying directional windows aligned with boundaries, and computing refined coherence estimates. Mathematically: F = μ + √(σ_p²/(σ_I²))·(I - μ) with directionally-aligned variance computation. This refinement improves edge preservation while maintaining speckle suppression. Key features include directional sensitivity (adapts filtering direction to image structures), improved coherence estimation (uses anisotropic windows), superior edge preservation versus standard Lee, and effectiveness on complex SAR scenes. Refined Lee filtering excels in change detection requiring sharp boundaries, InSAR coherence map preparation, polarimetric SAR processing where target preservation is critical, and forestry SAR analysis distinguishing trees from background. Output interpretation reveals that filtering respects edge orientation: horizontal edges filter horizontally; vertical edges filter vertically; diagonal edges filter diagonally. This directional adaptation minimizes filtering across true boundaries. Coherence estimates typically more accurate than standard Lee, reducing filtering artifacts. Output ranges match input; directional adaptation becomes apparent via visual inspection (edges remain sharper than standard Lee). Statistics show greater preservation of high-contrast regions. Directional components reveal scene structure orientation; strong directional bias indicates predominant feature orientation. Common artifacts reduce relative to standard Lee, particularly near edges and complex features. Artifacts include potential over-adaptation if directional estimation fails and directional window artifacts at weak boundaries. Monitor coherence maps to validate edge detection accuracy. Apply strategically in SAR classification where directional structures (e.g., forests, aligned agricultural fields) must be preserved.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$refined_lee_filter(...)
}

reinitialize_attribute_table <- function(...) {
  # Creates a copy of a vector layer with only a regenerated FID attribute.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reinitialize_attribute_table(...)
}

wbw_reinitialize_attribute_table <- function(...) {
  # Creates a copy of a vector layer with only a regenerated FID attribute.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reinitialize_attribute_table(...)
}

related_circumscribing_circle <- function(...) {
  # Calculates 1 - (polygon area / smallest circumscribing circle area) and appends RC_CIRCLE.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$related_circumscribing_circle(...)
}

wbw_related_circumscribing_circle <- function(...) {
  # Calculates 1 - (polygon area / smallest circumscribing circle area) and appends RC_CIRCLE.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$related_circumscribing_circle(...)
}

relative_aspect <- function(...) {
  # Calculates terrain aspect relative to a user-specified azimuth (0 to 180 degrees).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$relative_aspect(...)
}

wbw_relative_aspect <- function(...) {
  # Calculates terrain aspect relative to a user-specified azimuth (0 to 180 degrees).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$relative_aspect(...)
}

relative_stream_power_index <- function(...) {
  # Calculates the relative stream power index from specific catchment area and slope.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$relative_stream_power_index(...)
}

wbw_relative_stream_power_index <- function(...) {
  # Calculates the relative stream power index from specific catchment area and slope.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$relative_stream_power_index(...)
}

relative_topographic_position <- function(...) {
  # Calculates RTP using neighbourhood min, mean, and max elevation values.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$relative_topographic_position(...)
}

wbw_relative_topographic_position <- function(...) {
  # Calculates RTP using neighbourhood min, mean, and max elevation values.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$relative_topographic_position(...)
}

remove_duplicates <- function(...) {
  # Deduplicates point cloud: removes points with identical x/y (optionally z). Handles multiple-scan overlaps and improves processing efficiency.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_duplicates(...)
}

wbw_remove_duplicates <- function(...) {
  # Deduplicates point cloud: removes points with identical x/y (optionally z). Handles multiple-scan overlaps and improves processing efficiency.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_duplicates(...)
}

remove_off_terrain_objects <- function(...) {
  # Removes steep off-terrain objects from DEMs using white top-hat normalization, slope-constrained region growing, and local interpolation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_off_terrain_objects(...)
}

wbw_remove_off_terrain_objects <- function(...) {
  # Removes steep off-terrain objects from DEMs using white top-hat normalization, slope-constrained region growing, and local interpolation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_off_terrain_objects(...)
}

remove_polygon_holes <- function(...) {
  # Removes interior rings from polygon features while preserving attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_polygon_holes(...)
}

wbw_remove_polygon_holes <- function(...) {
  # Removes interior rings from polygon features while preserving attributes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_polygon_holes(...)
}

remove_raster_polygon_holes <- function(...) {
  # Removes interior background holes (0 or nodata regions enclosed by foreground) from raster polygons.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_raster_polygon_holes(...)
}

wbw_remove_raster_polygon_holes <- function(...) {
  # Removes interior background holes (0 or nodata regions enclosed by foreground) from raster polygons.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_raster_polygon_holes(...)
}

remove_short_streams <- function(...) {
  # Removes stream links shorter than minimum length.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_short_streams(...)
}

wbw_remove_short_streams <- function(...) {
  # Removes stream links shorter than minimum length.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_short_streams(...)
}

remove_spurs <- function(...) {
  # Removes short spur artifacts from binary raster features by iterative pruning.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_spurs(...)
}

wbw_remove_spurs <- function(...) {
  # Removes short spur artifacts from binary raster features by iterative pruning.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$remove_spurs(...)
}

rename_field <- function(...) {
  # Renames an attribute field in a vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rename_field(...)
}

wbw_rename_field <- function(...) {
  # Renames an attribute field in a vector layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rename_field(...)
}

repair_stream_vector_topology <- function(...) {
  # Repairs topology of vector stream network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$repair_stream_vector_topology(...)
}

wbw_repair_stream_vector_topology <- function(...) {
  # Repairs topology of vector stream network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$repair_stream_vector_topology(...)
}

representative_point_vector <- function(...) {
  # Generates an interior point guaranteed to lie within or on each geometry using pole-of-inaccessibility, ideal for label placement in concave polygons.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$representative_point_vector(...)
}

wbw_representative_point_vector <- function(...) {
  # Generates an interior point guaranteed to lie within or on each geometry using pole-of-inaccessibility, ideal for label placement in concave polygons.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$representative_point_vector(...)
}

reproject_vector <- function(...) {
  # Reprojects vector geometries to destination EPSG projection while preserving topology and attributes, enabling multi-source integration.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reproject_vector(...)
}

wbw_reproject_vector <- function(...) {
  # Reprojects vector geometries to destination EPSG projection while preserving topology and attributes, enabling multi-source integration.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$reproject_vector(...)
}

resample <- function(...) {
  # Image resampling changes pixel resolution using interpolation methods including nearest neighbor (fastest, least smoothing), bilinear (linear interpolation between adjacent pixels), bicubic (cubic polynomial fitting), and cubic spline (smooth continuous interpolation) techniques. Resampling is essential for geometric registration, creating uniform resolution multispectral stacks from mixed-resolution sensors, and integrating auxiliary data at different scales. Each method involves fitting local interpolation kernels to original pixel values, evaluating kernels at new pixel locations, and returning interpolated values. Nearest neighbor preserves radiometric values (suitable for categorical data); higher-order methods smooth edges and reduce aliasing but blur sharp boundaries. Key features include selectable interpolation methods optimizing speed-accuracy trade-offs, output resolution specification via target pixel size or dimensions, automatic background value handling for areas outside input extent, and optional antialiasing filtering reducing resampling artifacts. Applications include image registration aligning data to common grids, resolution harmonization unifying multispectral stacks with varying native resolutions, downsampling reducing data volume while preserving spatial patterns, and upsampling improving visual detail for visualization. Resampling output integrates imagery at consistent resolution. Output resolution matches user specification; interpolation method affects edge definition (nearest neighbor preserves edges; higher-order methods smooth); background areas (outside input extent) receive configurable fill values; output integrates seamlessly into multispectral analysis workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$resample(...)
}

wbw_resample <- function(...) {
  # Image resampling changes pixel resolution using interpolation methods including nearest neighbor (fastest, least smoothing), bilinear (linear interpolation between adjacent pixels), bicubic (cubic polynomial fitting), and cubic spline (smooth continuous interpolation) techniques. Resampling is essential for geometric registration, creating uniform resolution multispectral stacks from mixed-resolution sensors, and integrating auxiliary data at different scales. Each method involves fitting local interpolation kernels to original pixel values, evaluating kernels at new pixel locations, and returning interpolated values. Nearest neighbor preserves radiometric values (suitable for categorical data); higher-order methods smooth edges and reduce aliasing but blur sharp boundaries. Key features include selectable interpolation methods optimizing speed-accuracy trade-offs, output resolution specification via target pixel size or dimensions, automatic background value handling for areas outside input extent, and optional antialiasing filtering reducing resampling artifacts. Applications include image registration aligning data to common grids, resolution harmonization unifying multispectral stacks with varying native resolutions, downsampling reducing data volume while preserving spatial patterns, and upsampling improving visual detail for visualization. Resampling output integrates imagery at consistent resolution. Output resolution matches user specification; interpolation method affects edge definition (nearest neighbor preserves edges; higher-order methods smooth); background areas (outside input extent) receive configurable fill values; output integrates seamlessly into multispectral analysis workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$resample(...)
}

rescale_value_range <- function(...) {
  # Linearly rescales raster values into a target range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rescale_value_range(...)
}

wbw_rescale_value_range <- function(...) {
  # Linearly rescales raster values into a target range.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rescale_value_range(...)
}

rgb_to_ihs <- function(...) {
  # RGB to Intensity-Hue-Saturation transformation decomposes red-green-blue color space into perceptually relevant components: intensity (brightness), hue (color), and saturation (color purity). The decomposition uses standard mathematical formulas converting RGB tristimulus values into cylindrical polar coordinates where intensity represents luminance, hue encodes color angle, and saturation measures color concentration. This color space is particularly useful for remote sensing because intensity can be replaced with high-resolution data while preserving original color characteristics through inverse transformation. Key features include numerically stable formulation handling edge cases (achromatic pixels) robustly, retention of full dynamic range without clipping or loss of information, automatic band scaling for consistent results across different input ranges, and computational efficiency suitable for large multispectral stacks. The technique serves multiple applications: pan-sharpening workflows where intensity is replaced with panchromatic data, color visualization enhancement, spectral preprocessing for classification algorithms, and color-to-grayscale conversions retaining perceptual information. RGB-to-IHS transformation is essential for fusion techniques combining panchromatic resolution with multispectral color information. Output comprises three single-band files representing intensity, hue, and saturation components independently usable in analysis workflows. The intensity band approximates luminance; hue ranges 0-360 degrees encoding color information; saturation ranges 0-100 percent indicating color purity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rgb_to_ihs(...)
}

wbw_rgb_to_ihs <- function(...) {
  # RGB to Intensity-Hue-Saturation transformation decomposes red-green-blue color space into perceptually relevant components: intensity (brightness), hue (color), and saturation (color purity). The decomposition uses standard mathematical formulas converting RGB tristimulus values into cylindrical polar coordinates where intensity represents luminance, hue encodes color angle, and saturation measures color concentration. This color space is particularly useful for remote sensing because intensity can be replaced with high-resolution data while preserving original color characteristics through inverse transformation. Key features include numerically stable formulation handling edge cases (achromatic pixels) robustly, retention of full dynamic range without clipping or loss of information, automatic band scaling for consistent results across different input ranges, and computational efficiency suitable for large multispectral stacks. The technique serves multiple applications: pan-sharpening workflows where intensity is replaced with panchromatic data, color visualization enhancement, spectral preprocessing for classification algorithms, and color-to-grayscale conversions retaining perceptual information. RGB-to-IHS transformation is essential for fusion techniques combining panchromatic resolution with multispectral color information. Output comprises three single-band files representing intensity, hue, and saturation components independently usable in analysis workflows. The intensity band approximates luminance; hue ranges 0-360 degrees encoding color information; saturation ranges 0-100 percent indicating color purity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rgb_to_ihs(...)
}

rho8_flow_accum <- function(...) {
  # Calculates Rho8 flow accumulation from a DEM or Rho8 pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rho8_flow_accum(...)
}

wbw_rho8_flow_accum <- function(...) {
  # Calculates Rho8 flow accumulation from a DEM or Rho8 pointer raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rho8_flow_accum(...)
}

rho8_pointer <- function(...) {
  # Stochastic single-flow direction weighted by slope gradient. Run multiple times for ensemble analysis reducing D8 channelization artifacts.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rho8_pointer(...)
}

wbw_rho8_pointer <- function(...) {
  # Stochastic single-flow direction weighted by slope gradient. Run multiple times for ensemble analysis reducing D8 channelization artifacts.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rho8_pointer(...)
}

ridge_and_valley_vectors <- function(...) {
  # Extracts ridge and valley centreline vectors from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ridge_and_valley_vectors(...)
}

wbw_ridge_and_valley_vectors <- function(...) {
  # Extracts ridge and valley centreline vectors from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ridge_and_valley_vectors(...)
}

ring_curvature <- function(...) {
  # Calculates ring curvature (squared flow-line twisting) from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ring_curvature(...)
}

wbw_ring_curvature <- function(...) {
  # Calculates ring curvature (squared flow-line twisting) from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ring_curvature(...)
}

ripleys_k_function <- function(...) {
  # Compute K(t) and L(t) for characterizing spatial clustering patterns.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ripleys_k_function(...)
}

wbw_ripleys_k_function <- function(...) {
  # Compute K(t) and L(t) for characterizing spatial clustering patterns.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ripleys_k_function(...)
}

ripleys_k_test <- function(...) {
  # Computes Ripley's K multi-scale clustering statistic. Reveals scale-dependent clustering/dispersion across distance ranges.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ripleys_k_test(...)
}

wbw_ripleys_k_test <- function(...) {
  # Computes Ripley's K multi-scale clustering statistic. Reveals scale-dependent clustering/dispersion across distance ranges.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ripleys_k_test(...)
}

river_centerlines <- function(...) {
  # Extracts river centerlines from water raster using medial axis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$river_centerlines(...)
}

wbw_river_centerlines <- function(...) {
  # Extracts river centerlines from water raster using medial axis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$river_centerlines(...)
}

roberts_cross_filter <- function(...) {
  # The Roberts Cross filter is one of the earliest edge detection operators, employing a simple yet effective 2×2 diagonal cross-kernel pattern to compute image gradients with minimal computational overhead. This operator uses two orthogonal 2×2 matrices rotated 45° from horizontal-vertical alignment, creating cross-shaped convolution masks that detect edges emphasizing corners and diagonal transitions. The filter applies separate kernels for X and Y gradients, computing magnitude through the sum of absolute values or Euclidean norm. Key features include exceptional computational efficiency due to small 2×2 kernel size, minimal memory requirements, and fast processing on large raster datasets. The Roberts Cross is particularly effective for detecting fine-scale features and sharp transitions in high-resolution imagery. Primary use cases include rapid edge detection in time-critical applications, real-time video stream processing, preliminary boundary detection before advanced algorithms, and resource-constrained environments. Applications span aerial survey preprocessing, satellite imagery quality assessment, feature extraction for machine learning pipelines, and mobile GIS implementations. Output interpretation shows edge locations as high-magnitude pixels where spectral changes occur across the 2×2 neighborhood. Background regions typically display near-zero values; edges appear as bright linear features indicating boundaries between distinct land cover classes. The output is inherently sparse, containing edges only where gradients exceed computational precision thresholds. For multi-spectral images, apply independently to each band or compute a normalized difference index first. Edge thinning post-processing often follows Roberts application to refine output for vector conversion workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$roberts_cross_filter(...)
}

wbw_roberts_cross_filter <- function(...) {
  # The Roberts Cross filter is one of the earliest edge detection operators, employing a simple yet effective 2×2 diagonal cross-kernel pattern to compute image gradients with minimal computational overhead. This operator uses two orthogonal 2×2 matrices rotated 45° from horizontal-vertical alignment, creating cross-shaped convolution masks that detect edges emphasizing corners and diagonal transitions. The filter applies separate kernels for X and Y gradients, computing magnitude through the sum of absolute values or Euclidean norm. Key features include exceptional computational efficiency due to small 2×2 kernel size, minimal memory requirements, and fast processing on large raster datasets. The Roberts Cross is particularly effective for detecting fine-scale features and sharp transitions in high-resolution imagery. Primary use cases include rapid edge detection in time-critical applications, real-time video stream processing, preliminary boundary detection before advanced algorithms, and resource-constrained environments. Applications span aerial survey preprocessing, satellite imagery quality assessment, feature extraction for machine learning pipelines, and mobile GIS implementations. Output interpretation shows edge locations as high-magnitude pixels where spectral changes occur across the 2×2 neighborhood. Background regions typically display near-zero values; edges appear as bright linear features indicating boundaries between distinct land cover classes. The output is inherently sparse, containing edges only where gradients exceed computational precision thresholds. For multi-spectral images, apply independently to each band or compute a normalized difference index first. Edge thinning post-processing often follows Roberts application to refine output for vector conversion workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$roberts_cross_filter(...)
}

root_mean_square_error <- function(...) {
  # Calculates RMSE and related accuracy statistics between two rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$root_mean_square_error(...)
}

wbw_root_mean_square_error <- function(...) {
  # Calculates RMSE and related accuracy statistics between two rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$root_mean_square_error(...)
}

rotor <- function(...) {
  # Calculates the rotor (flow-line twisting) from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rotor(...)
}

wbw_rotor <- function(...) {
  # Calculates the rotor (flow-line twisting) from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$rotor(...)
}

round <- function(...) {
  # Rounds each raster cell to the nearest integer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$round(...)
}

wbw_round <- function(...) {
  # Rounds each raster cell to the nearest integer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$round(...)
}

route_calibrate <- function(...) {
  # Calibrates route start/end measures from control points with known measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_calibrate(...)
}

wbw_route_calibrate <- function(...) {
  # Calibrates route start/end measures from control points with known measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_calibrate(...)
}

route_event_lines_from_layer <- function(...) {
  # Creates routed line events from an event vector layer using from/to measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_lines_from_layer(...)
}

wbw_route_event_lines_from_layer <- function(...) {
  # Creates routed line events from an event vector layer using from/to measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_lines_from_layer(...)
}

route_event_lines_from_table <- function(...) {
  # Creates routed line events from a CSV event table and a route layer using from/to measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_lines_from_table(...)
}

wbw_route_event_lines_from_table <- function(...) {
  # Creates routed line events from a CSV event table and a route layer using from/to measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_lines_from_table(...)
}

route_event_merge <- function(...) {
  # Merges adjacent compatible route events.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_merge(...)
}

wbw_route_event_merge <- function(...) {
  # Merges adjacent compatible route events.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_merge(...)
}

route_event_overlay <- function(...) {
  # Overlays two route event layers by interval overlap.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_overlay(...)
}

wbw_route_event_overlay <- function(...) {
  # Overlays two route event layers by interval overlap.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_overlay(...)
}

route_event_points_from_layer <- function(...) {
  # Creates routed point events from an event vector layer and a route layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_points_from_layer(...)
}

wbw_route_event_points_from_layer <- function(...) {
  # Creates routed point events from an event vector layer and a route layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_points_from_layer(...)
}

route_event_points_from_table <- function(...) {
  # Creates routed point events from a CSV event table and a route layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_points_from_table(...)
}

wbw_route_event_points_from_table <- function(...) {
  # Creates routed point events from a CSV event table and a route layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_points_from_table(...)
}

route_event_split <- function(...) {
  # Splits route events by per-route boundary measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_split(...)
}

wbw_route_event_split <- function(...) {
  # Splits route events by per-route boundary measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_event_split(...)
}

route_measure_qa <- function(...) {
  # Diagnoses route-event measure gaps, overlaps, non-monotonic sequences, and duplicate measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_measure_qa(...)
}

wbw_route_measure_qa <- function(...) {
  # Diagnoses route-event measure gaps, overlaps, non-monotonic sequences, and duplicate measures.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_measure_qa(...)
}

route_recalibrate <- function(...) {
  # Recalibrates edited route measures from a reference route layer while preserving route measure continuity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_recalibrate(...)
}

wbw_route_recalibrate <- function(...) {
  # Recalibrates edited route measures from a reference route layer while preserving route measure continuity.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$route_recalibrate(...)
}

ruggedness_index <- function(...) {
  # Terrain roughness via Riley TRI (sum of squared elevation differences). Scale-independent terrain classification metric: low=smooth plains, high=rough mountains. Ecological and geomorphological landform mapping.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ruggedness_index(...)
}

wbw_ruggedness_index <- function(...) {
  # Terrain roughness via Riley TRI (sum of squared elevation differences). Scale-independent terrain classification metric: low=smooth plains, high=rough mountains. Ecological and geomorphological landform mapping.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$ruggedness_index(...)
}

saga_wetness_index <- function(...) {
  # Computes a SAGA-style wetness index using an optional suction offset on the catchment area and a minimum slope threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$saga_wetness_index(...)
}

wbw_saga_wetness_index <- function(...) {
  # Computes a SAGA-style wetness index using an optional suction offset on the catchment area and a minimum slope threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$saga_wetness_index(...)
}

savitzky_golay_2d_filter <- function(...) {
  # Performs 2D Savitzky-Golay smoothing—polynomial fitting-based filter preserving local polynomial features. Fits local polynomial to neighborhood, replaces center with fitted value. Preserves peaks/valleys better than Gaussian. Useful for noisy data where feature preservation important. Less blurring than Gaussian for low-order polynomials; smoothing increases with polynomial order. Savitzky-Golay filtering fits local polynomial (typically quadratic/cubic) by least-squares to neighborhood. Center value replaced with polynomial value. Different from median/Gaussian—preserves features that appear as polynomial structures (peaks, valleys, ridges). Computationally straightforward but slower than simple convolution. Polynomial order controls smoothing/preservation trade-off. Applications: (1) Smooth noisy data while preserving peak structures, (2) Elevation grid processing (preserves ridge/valley topography), (3) Spectral data smoothing (preserves absorption features), (4) Feature-preserving preprocessing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$savitzky_golay_2d_filter(...)
}

wbw_savitzky_golay_2d_filter <- function(...) {
  # Performs 2D Savitzky-Golay smoothing—polynomial fitting-based filter preserving local polynomial features. Fits local polynomial to neighborhood, replaces center with fitted value. Preserves peaks/valleys better than Gaussian. Useful for noisy data where feature preservation important. Less blurring than Gaussian for low-order polynomials; smoothing increases with polynomial order. Savitzky-Golay filtering fits local polynomial (typically quadratic/cubic) by least-squares to neighborhood. Center value replaced with polynomial value. Different from median/Gaussian—preserves features that appear as polynomial structures (peaks, valleys, ridges). Computationally straightforward but slower than simple convolution. Polynomial order controls smoothing/preservation trade-off. Applications: (1) Smooth noisy data while preserving peak structures, (2) Elevation grid processing (preserves ridge/valley topography), (3) Spectral data smoothing (preserves absorption features), (4) Feature-preserving preprocessing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$savitzky_golay_2d_filter(...)
}

scharr_filter <- function(...) {
  # The Scharr filter is an edge detection operator that improves upon the Sobel filter by using optimized kernel coefficients specifically designed to reduce directional bias and provide superior rotation invariance. The Scharr operator employs 3×3 convolution kernels with integer coefficients (3, 10, 3) that are empirically optimized for 0°, 45°, 90°, and 135° edge directions, delivering more accurate gradient estimation than traditional Sobel filters especially for circular features and rotated edges. The filter computes both horizontal and gradient magnitude simultaneously, enabling robust edge localization. Key advantages include superior accuracy for directional gradients, reduced rotational bias compared to Sobel, and efficient 3×3 kernel computation requiring minimal memory overhead. Output includes both magnitude and optional directional components. The Scharr filter excels in feature extraction, boundary detection, and quality assurance workflows requiring high directional accuracy. Use cases include extracting building footprints from aerial imagery, detecting road networks, delineating water boundaries with minimal distortion, and identifying geological lineaments in satellite data. The filter performs exceptionally well in urban mapping, agricultural boundary detection, and autonomous navigation applications. Output interpretation requires understanding that magnitude values represent edge strength—higher values indicate sharper transitions between distinct spectral classes. Directional components reveal predominant edge orientation (horizontal, diagonal, or vertical), useful for lineament analysis. For multi-band rasters, apply separately to each band or use a computed index. Background values appear dark in output; strong edges appear bright. RMSE comparison with reference edges validates filter performance. Scale the output to 0-255 for standard visualization or preserve floating-point for quantitative analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$scharr_filter(...)
}

wbw_scharr_filter <- function(...) {
  # The Scharr filter is an edge detection operator that improves upon the Sobel filter by using optimized kernel coefficients specifically designed to reduce directional bias and provide superior rotation invariance. The Scharr operator employs 3×3 convolution kernels with integer coefficients (3, 10, 3) that are empirically optimized for 0°, 45°, 90°, and 135° edge directions, delivering more accurate gradient estimation than traditional Sobel filters especially for circular features and rotated edges. The filter computes both horizontal and gradient magnitude simultaneously, enabling robust edge localization. Key advantages include superior accuracy for directional gradients, reduced rotational bias compared to Sobel, and efficient 3×3 kernel computation requiring minimal memory overhead. Output includes both magnitude and optional directional components. The Scharr filter excels in feature extraction, boundary detection, and quality assurance workflows requiring high directional accuracy. Use cases include extracting building footprints from aerial imagery, detecting road networks, delineating water boundaries with minimal distortion, and identifying geological lineaments in satellite data. The filter performs exceptionally well in urban mapping, agricultural boundary detection, and autonomous navigation applications. Output interpretation requires understanding that magnitude values represent edge strength—higher values indicate sharper transitions between distinct spectral classes. Directional components reveal predominant edge orientation (horizontal, diagonal, or vertical), useful for lineament analysis. For multi-band rasters, apply separately to each band or use a computed index. Background values appear dark in output; strong edges appear bright. RMSE comparison with reference edges validates filter performance. Scale the output to 0-255 for standard visualization or preserve floating-point for quantitative analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$scharr_filter(...)
}

sediment_transport_index <- function(...) {
  # Calculates the sediment transport index (LS factor) from specific catchment area and slope.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sediment_transport_index(...)
}

wbw_sediment_transport_index <- function(...) {
  # Calculates the sediment transport index (LS factor) from specific catchment area and slope.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sediment_transport_index(...)
}

segment_graph_felzenszwalb <- function(...) {
  # Felzenswalb's graph-based segmentation treats the image as weighted undirected graph where pixels are nodes and edges connect adjacent pixels with weights representing spectral dissimilarity. Segments merge iteratively by comparing edge weights within components against dynamic thresholds; edges with weights below threshold merge, producing segments of locally homogeneous spectral characteristics. This hierarchical approach produces perceptually meaningful segmentations sensitive to local contrast variations and natural color/texture discontinuities. Key Features: Graph-based hierarchical segmentation; efficient O(n log n) computational complexity; sensitive to local contrast variations; produces perceptually meaningful segments; supports multispectral/hyperspectral data; generates variable-sized regions preserving natural boundaries. Use Cases: Multispectral image segmentation; natural habitat mapping; urban feature extraction; forest canopy delineation; change detection preprocessing; hyperspectral data segmentation. Output Interpretation: Output is labeled raster; each pixel assigned segment ID. Segment size varies inversely with local spectral contrast; high-contrast boundaries produce smaller, numerous segments; uniform regions merge into larger segments. Sensitivity to k-parameter (threshold scale) allows producing coarser or finer segmentations. Segment boundaries correspond to natural spectral discontinuities.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_graph_felzenszwalb(...)
}

wbw_segment_graph_felzenszwalb <- function(...) {
  # Felzenswalb's graph-based segmentation treats the image as weighted undirected graph where pixels are nodes and edges connect adjacent pixels with weights representing spectral dissimilarity. Segments merge iteratively by comparing edge weights within components against dynamic thresholds; edges with weights below threshold merge, producing segments of locally homogeneous spectral characteristics. This hierarchical approach produces perceptually meaningful segmentations sensitive to local contrast variations and natural color/texture discontinuities. Key Features: Graph-based hierarchical segmentation; efficient O(n log n) computational complexity; sensitive to local contrast variations; produces perceptually meaningful segments; supports multispectral/hyperspectral data; generates variable-sized regions preserving natural boundaries. Use Cases: Multispectral image segmentation; natural habitat mapping; urban feature extraction; forest canopy delineation; change detection preprocessing; hyperspectral data segmentation. Output Interpretation: Output is labeled raster; each pixel assigned segment ID. Segment size varies inversely with local spectral contrast; high-contrast boundaries produce smaller, numerous segments; uniform regions merge into larger segments. Sensitivity to k-parameter (threshold scale) allows producing coarser or finer segmentations. Segment boundaries correspond to natural spectral discontinuities.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_graph_felzenszwalb(...)
}

segment_multiresolution_hierarchical <- function(...) {
  # Generates multi-scale hierarchical segmentations (coarse and fine) with explicit parent-child mappings. Enables scale-dependent feature extraction and multi-level classification workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_multiresolution_hierarchical(...)
}

wbw_segment_multiresolution_hierarchical <- function(...) {
  # Generates multi-scale hierarchical segmentations (coarse and fine) with explicit parent-child mappings. Enables scale-dependent feature extraction and multi-level classification workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_multiresolution_hierarchical(...)
}

segment_scale_parameter_optimizer <- function(...) {
  # Searches candidate segmentation scale parameters to identify optimal scale matching target object count. Automated scale selection eliminates manual tuning for consistent segmentation quality.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_scale_parameter_optimizer(...)
}

wbw_segment_scale_parameter_optimizer <- function(...) {
  # Searches candidate segmentation scale parameters to identify optimal scale matching target object count. Automated scale selection eliminates manual tuning for consistent segmentation quality.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_scale_parameter_optimizer(...)
}

segment_slic_superpixels <- function(...) {
  # SLIC (Simple Linear Iterative Clustering) performs iterative pixel clustering in the 5D feature space combining spatial coordinates and color/spectral values, converging superpixels toward local homogeneity. The algorithm initializes a regular grid of cluster centers and assigns pixels to nearest centers, iteratively updating centers and reducing search regions. This produces compact, regularly-shaped superpixels with minimal boundary violation compared to watershed or mean-shift alternatives, offering superior boundary adherence to natural edges. Key Features: Produces uniform, compact superpixels; computationally efficient with linear time complexity; user-configurable compactness parameter balances spatial regularity with spectral coherence; minimal boundary overshooting; supports multispectral imagery. Use Cases: Object-based classification preprocessing; hierarchical region analysis; SAR and optical image segmentation; urban mapping; vegetation delineation; land-use boundary identification. Output Interpretation: Output is labeled raster where pixel values represent assigned superpixel IDs. Superpixel boundaries align with dominant edges and color transitions. Smaller superpixels (higher granularity) capture finer details but increase computational load; larger superpixels (lower granularity) merge similar regions, improving efficiency. Boundary accuracy depends on compactness parameter tuning and multispectral band separation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_slic_superpixels(...)
}

wbw_segment_slic_superpixels <- function(...) {
  # SLIC (Simple Linear Iterative Clustering) performs iterative pixel clustering in the 5D feature space combining spatial coordinates and color/spectral values, converging superpixels toward local homogeneity. The algorithm initializes a regular grid of cluster centers and assigns pixels to nearest centers, iteratively updating centers and reducing search regions. This produces compact, regularly-shaped superpixels with minimal boundary violation compared to watershed or mean-shift alternatives, offering superior boundary adherence to natural edges. Key Features: Produces uniform, compact superpixels; computationally efficient with linear time complexity; user-configurable compactness parameter balances spatial regularity with spectral coherence; minimal boundary overshooting; supports multispectral imagery. Use Cases: Object-based classification preprocessing; hierarchical region analysis; SAR and optical image segmentation; urban mapping; vegetation delineation; land-use boundary identification. Output Interpretation: Output is labeled raster where pixel values represent assigned superpixel IDs. Superpixel boundaries align with dominant edges and color transitions. Smaller superpixels (higher granularity) capture finer details but increase computational load; larger superpixels (lower granularity) merge similar regions, improving efficiency. Boundary accuracy depends on compactness parameter tuning and multispectral band separation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_slic_superpixels(...)
}

segment_watershed_markers <- function(...) {
  # Marker-driven watershed-like segmentation separating objects around identified marker seed regions. Emphasizes boundary preservation while controlling segment size for hierarchical OBIA workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_watershed_markers(...)
}

wbw_segment_watershed_markers <- function(...) {
  # Marker-driven watershed-like segmentation separating objects around identified marker seed regions. Emphasizes boundary preservation while controlling segment size for hierarchical OBIA workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segment_watershed_markers(...)
}

segments_merge_small_regions <- function(...) {
  # Segment merging implements hierarchical consolidation through spatial adjacency analysis and user-defined merge criteria. Evaluates each undersized segment against neighboring regions using size thresholds, spectral similarity measures, or custom morphological criteria; progressively merges candidate segments into absorbing neighbors following priority queues based on merge cost, preserving segment connectivity and avoiding topology violations. Key features include post-processing regularization of over-segmented imagery, user-configurable merge criteria (minimum size, spectral similarity threshold, morphological properties), preservation of segment boundary integrity during merging, production of compact simplified segment maps, and hierarchical refinement without full resegmentation. Use cases include cleanup of over-segmented OBIA results reducing fragmentation and noise, simplification of segments for improved classification stability, elimination of spurious small segments from initial segmentation, standardization of segment properties for uniform downstream feature extraction, and quality assurance refinement of multi-scale segmentation hierarchies. Output exhibits decreased segment count reflecting consolidation; merged segments inherit spectral statistics from absorbed components; boundaries become smoother with reduced complexity; merged regions maintain spatial integrity but exhibit slightly increased internal spectral heterogeneity; output is optimized for downstream classification and feature stability.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segments_merge_small_regions(...)
}

wbw_segments_merge_small_regions <- function(...) {
  # Segment merging implements hierarchical consolidation through spatial adjacency analysis and user-defined merge criteria. Evaluates each undersized segment against neighboring regions using size thresholds, spectral similarity measures, or custom morphological criteria; progressively merges candidate segments into absorbing neighbors following priority queues based on merge cost, preserving segment connectivity and avoiding topology violations. Key features include post-processing regularization of over-segmented imagery, user-configurable merge criteria (minimum size, spectral similarity threshold, morphological properties), preservation of segment boundary integrity during merging, production of compact simplified segment maps, and hierarchical refinement without full resegmentation. Use cases include cleanup of over-segmented OBIA results reducing fragmentation and noise, simplification of segments for improved classification stability, elimination of spurious small segments from initial segmentation, standardization of segment properties for uniform downstream feature extraction, and quality assurance refinement of multi-scale segmentation hierarchies. Output exhibits decreased segment count reflecting consolidation; merged segments inherit spectral statistics from absorbed components; boundaries become smoother with reduced complexity; merged regions maintain spatial integrity but exhibit slightly increased internal spectral heterogeneity; output is optimized for downstream classification and feature stability.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segments_merge_small_regions(...)
}

segments_split_low_cohesion <- function(...) {
  # Re-segments existing low-cohesion objects using finer scale settings to improve spectral homogeneity. Adaptive refinement for problematic zones without affecting well-formed objects.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segments_split_low_cohesion(...)
}

wbw_segments_split_low_cohesion <- function(...) {
  # Re-segments existing low-cohesion objects using finer scale settings to improve spectral homogeneity. Adaptive refinement for problematic zones without affecting well-formed objects.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segments_split_low_cohesion(...)
}

segments_to_polygons <- function(...) {
  # Converts raster segment labels to vector polygons for interactive editing, quality control, and GIS integration. Enables seamless transition between raster and vector OBIA representations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segments_to_polygons(...)
}

wbw_segments_to_polygons <- function(...) {
  # Converts raster segment labels to vector polygons for interactive editing, quality control, and GIS integration. Enables seamless transition between raster and vector OBIA representations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$segments_to_polygons(...)
}

select_by_location <- function(...) {
  # Filters target features by spatial predicates (intersects, within, contains, touches, overlaps, etc.) relative to query features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$select_by_location(...)
}

wbw_select_by_location <- function(...) {
  # Filters target features by spatial predicates (intersects, within, contains, touches, overlaps, etc.) relative to query features.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$select_by_location(...)
}

select_tiles_by_polygon <- function(...) {
  # Batch tile selection: copies LAS/LAZ tiles from directory to output when tile sample points intersect polygon boundaries. AOI-based data extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$select_tiles_by_polygon(...)
}

wbw_select_tiles_by_polygon <- function(...) {
  # Batch tile selection: copies LAS/LAZ tiles from directory to output when tile sample points intersect polygon boundaries. AOI-based data extraction.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$select_tiles_by_polygon(...)
}

set_nodata_value <- function(...) {
  # Sets a raster nodata value and maps existing nodata cells to the specified background value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$set_nodata_value(...)
}

wbw_set_nodata_value <- function(...) {
  # Sets a raster nodata value and maps existing nodata cells to the specified background value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$set_nodata_value(...)
}

shadow_animation <- function(...) {
  # Creates an interactive HTML viewer and animated GIF showing terrain shadows throughout a day.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shadow_animation(...)
}

wbw_shadow_animation <- function(...) {
  # Creates an interactive HTML viewer and animated GIF showing terrain shadows throughout a day.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shadow_animation(...)
}

shadow_image <- function(...) {
  # Generates a terrain shadow intensity raster for a specified date, time, and location.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shadow_image(...)
}

wbw_shadow_image <- function(...) {
  # Generates a terrain shadow intensity raster for a specified date, time, and location.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shadow_image(...)
}

shape_complexity_index_raster <- function(...) {
  # Computes raster patch shape complexity from horizontal/vertical transition frequency normalized by patch span.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shape_complexity_index_raster(...)
}

wbw_shape_complexity_index_raster <- function(...) {
  # Computes raster patch shape complexity from horizontal/vertical transition frequency normalized by patch span.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shape_complexity_index_raster(...)
}

shape_complexity_index_vector <- function(...) {
  # Computes shape complexity index for vector polygon features using normalized form factor.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shape_complexity_index_vector(...)
}

wbw_shape_complexity_index_vector <- function(...) {
  # Computes shape complexity index for vector polygon features using normalized form factor.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shape_complexity_index_vector(...)
}

shape_index <- function(...) {
  # Calculates the shape index surface form descriptor from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shape_index(...)
}

wbw_shape_index <- function(...) {
  # Calculates the shape index surface form descriptor from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shape_index(...)
}

shortest_path_network <- function(...) {
  # Finds the shortest path between start and end coordinates over a line network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shortest_path_network(...)
}

wbw_shortest_path_network <- function(...) {
  # Finds the shortest path between start and end coordinates over a line network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shortest_path_network(...)
}

shreve_stream_magnitude <- function(...) {
  # Calculates Shreve stream magnitude.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shreve_stream_magnitude(...)
}

wbw_shreve_stream_magnitude <- function(...) {
  # Calculates Shreve stream magnitude.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$shreve_stream_magnitude(...)
}

sieve <- function(...) {
  # Removes small isolated patches below a cell-count threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sieve(...)
}

wbw_sieve <- function(...) {
  # Removes small isolated patches below a cell-count threshold.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sieve(...)
}

sigmoidal_contrast_stretch <- function(...) {
  # Performs sigmoidal contrast stretching using gain and cutoff.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sigmoidal_contrast_stretch(...)
}

wbw_sigmoidal_contrast_stretch <- function(...) {
  # Performs sigmoidal contrast stretching using gain and cutoff.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sigmoidal_contrast_stretch(...)
}

simple_kriging <- function(...) {
  # Performs simple kriging with a known constant mean. Requires a pre-fitted variogram model (from fit_variogram). Produces lower variance than ordinary kriging when the mean is reliably known.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$simple_kriging(...)
}

wbw_simple_kriging <- function(...) {
  # Performs simple kriging with a known constant mean. Requires a pre-fitted variogram model (from fit_variogram). Produces lower variance than ordinary kriging when the mean is reliably known.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$simple_kriging(...)
}

simplify_features <- function(...) {
  # Reduces geometry complexity using Douglas-Peucker algorithm to minimize file size, remove GPS noise, and optimize rendering performance while preserving shape.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$simplify_features(...)
}

wbw_simplify_features <- function(...) {
  # Reduces geometry complexity using Douglas-Peucker algorithm to minimize file size, remove GPS noise, and optimize rendering performance while preserving shape.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$simplify_features(...)
}

sin <- function(...) {
  # Computes the sine of each raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sin(...)
}

wbw_sin <- function(...) {
  # Computes the sine of each raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sin(...)
}

singlepart_to_multipart <- function(...) {
  # Merges single-part features into multi-part features, grouped by an optional categorical field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$singlepart_to_multipart(...)
}

wbw_singlepart_to_multipart <- function(...) {
  # Merges single-part features into multi-part features, grouped by an optional categorical field.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$singlepart_to_multipart(...)
}

sinh <- function(...) {
  # Computes the hyperbolic sine of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sinh(...)
}

wbw_sinh <- function(...) {
  # Computes the hyperbolic sine of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sinh(...)
}

sink <- function(...) {
  # Identifies cells that belong to topographic depressions in a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sink(...)
}

wbw_sink <- function(...) {
  # Identifies cells that belong to topographic depressions in a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sink(...)
}

sky_view_factor <- function(...) {
  # Calculates the proportion of visible sky from a DEM/DSM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sky_view_factor(...)
}

wbw_sky_view_factor <- function(...) {
  # Calculates the proportion of visible sky from a DEM/DSM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sky_view_factor(...)
}

skyline_analysis <- function(...) {
  # Performs skyline analysis for one or more observation points and writes a vector horizon trace plus HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$skyline_analysis(...)
}

wbw_skyline_analysis <- function(...) {
  # Performs skyline analysis for one or more observation points and writes a vector horizon trace plus HTML report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$skyline_analysis(...)
}

slope <- function(...) {
  # Zevenbergen-Thorne slope gradient (degrees/radians/percent). Fundamental geomorphometric metric; downstream input to curvature, flow direction, shading, visibility.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$slope(...)
}

wbw_slope <- function(...) {
  # Zevenbergen-Thorne slope gradient (degrees/radians/percent). Fundamental geomorphometric metric; downstream input to curvature, flow direction, shading, visibility.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$slope(...)
}

slope_vs_aspect_plot <- function(...) {
  # Creates an HTML radial slope-vs-aspect analysis plot for an input DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$slope_vs_aspect_plot(...)
}

wbw_slope_vs_aspect_plot <- function(...) {
  # Creates an HTML radial slope-vs-aspect analysis plot for an input DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$slope_vs_aspect_plot(...)
}

slope_vs_elev_plot <- function(...) {
  # Creates an HTML slope-vs-elevation analysis chart for one or more DEMs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$slope_vs_elev_plot(...)
}

wbw_slope_vs_elev_plot <- function(...) {
  # Creates an HTML slope-vs-elevation analysis chart for one or more DEMs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$slope_vs_elev_plot(...)
}

smooth_vectors <- function(...) {
  # Smooths polyline or polygon geometries using moving-average filtering to reduce digitization noise and GPS track jitter.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$smooth_vectors(...)
}

wbw_smooth_vectors <- function(...) {
  # Smooths polyline or polygon geometries using moving-average filtering to reduce digitization noise and GPS track jitter.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$smooth_vectors(...)
}

smooth_vegetation_residual <- function(...) {
  # Reduces canopy residual roughness by masking high local DEV responses at small scales and re-interpolating masked elevations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$smooth_vegetation_residual(...)
}

wbw_smooth_vegetation_residual <- function(...) {
  # Reduces canopy residual roughness by masking high local DEV responses at small scales and re-interpolating masked elevations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$smooth_vegetation_residual(...)
}

snap_endnodes <- function(...) {
  # Snaps nearby polyline endpoints to a shared location within a tolerance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$snap_endnodes(...)
}

wbw_snap_endnodes <- function(...) {
  # Snaps nearby polyline endpoints to a shared location within a tolerance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$snap_endnodes(...)
}

snap_events_to_routes <- function(...) {
  # Snaps event points to route lines and reports route measure/offset diagnostics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$snap_events_to_routes(...)
}

wbw_snap_events_to_routes <- function(...) {
  # Snaps event points to route lines and reports route measure/offset diagnostics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$snap_events_to_routes(...)
}

snap_points_to_network <- function(...) {
  # Snaps input point features to the nearest location along a network line layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$snap_points_to_network(...)
}

wbw_snap_points_to_network <- function(...) {
  # Snaps input point features to the nearest location along a network line layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$snap_points_to_network(...)
}

snap_pour_points <- function(...) {
  # Snaps pour points to the highest flow-accumulation cell within a search distance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$snap_pour_points(...)
}

wbw_snap_pour_points <- function(...) {
  # Snaps pour points to the highest flow-accumulation cell within a search distance.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$snap_pour_points(...)
}

sobel_filter <- function(...) {
  # The Sobel operator detects edges via directional gradient estimation in both x (horizontal) and y (vertical) directions, combining orthogonal derivative kernels into a unified magnitude representation. Implementation applies two 3×3 convolution kernels independently (one emphasizing horizontal edges, one emphasizing vertical), then combines results via the Euclidean norm: magnitude = √(Gx² + Gy²). This separable approach reduces computational cost while maintaining edge detection accuracy. The mathematical basis derives from discrete approximations of image gradients, with kernel weights biasing toward center pixels to improve noise robustness. Key features include directional gradient measurement enabling edge orientation determination, relatively low computational overhead, proven effectiveness across satellite and aerial imagery, and minimal parameter tuning requirements. Sobel filtering finds extensive application in terrain slope and aspect calculation, feature boundary extraction for object detection workflows, river network delineation from DEM data, and infrastructure (roads, buildings, power lines) mapping from high-resolution imagery. Output interpretation reveals magnitude indicates edge strength (higher values = sharper transitions), while directional components (Gx, Gy) enable orientation analysis. Typical gradient magnitudes range 0-256 for 8-bit imagery; values exceeding 100 generally indicate significant edges. The ratio Gx/Gy provides edge orientation information: ratio approaching 1 indicates 45-degree edges, ratio >>1 indicates horizontal features, ratio <<1 indicates vertical features. False positives commonly occur in noisy regions; median filtering or morphological operations effectively reduce spurious detections. Combine with thresholding for binary edge masks suitable for segmentation pipelines.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sobel_filter(...)
}

wbw_sobel_filter <- function(...) {
  # The Sobel operator detects edges via directional gradient estimation in both x (horizontal) and y (vertical) directions, combining orthogonal derivative kernels into a unified magnitude representation. Implementation applies two 3×3 convolution kernels independently (one emphasizing horizontal edges, one emphasizing vertical), then combines results via the Euclidean norm: magnitude = √(Gx² + Gy²). This separable approach reduces computational cost while maintaining edge detection accuracy. The mathematical basis derives from discrete approximations of image gradients, with kernel weights biasing toward center pixels to improve noise robustness. Key features include directional gradient measurement enabling edge orientation determination, relatively low computational overhead, proven effectiveness across satellite and aerial imagery, and minimal parameter tuning requirements. Sobel filtering finds extensive application in terrain slope and aspect calculation, feature boundary extraction for object detection workflows, river network delineation from DEM data, and infrastructure (roads, buildings, power lines) mapping from high-resolution imagery. Output interpretation reveals magnitude indicates edge strength (higher values = sharper transitions), while directional components (Gx, Gy) enable orientation analysis. Typical gradient magnitudes range 0-256 for 8-bit imagery; values exceeding 100 generally indicate significant edges. The ratio Gx/Gy provides edge orientation information: ratio approaching 1 indicates 45-degree edges, ratio >>1 indicates horizontal features, ratio <<1 indicates vertical features. False positives commonly occur in noisy regions; median filtering or morphological operations effectively reduce spurious detections. Combine with thresholding for binary edge masks suitable for segmentation pipelines.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sobel_filter(...)
}

sort_lidar <- function(...) {
  # Orders points by multiple criteria: x/y/z with bin sizes, plus derived attributes. Optimizes spatial coherence for compression and tile processing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sort_lidar(...)
}

wbw_sort_lidar <- function(...) {
  # Orders points by multiple criteria: x/y/z with bin sizes, plus derived attributes. Optimizes spatial coherence for compression and tile processing.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sort_lidar(...)
}

spacetime_kriging <- function(...) {
  # Performs space-time kriging for spatially-distributed time series data. Requires separate fitted spatial and temporal variogram models.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spacetime_kriging(...)
}

wbw_spacetime_kriging <- function(...) {
  # Performs space-time kriging for spatially-distributed time series data. Requires separate fitted spatial and temporal variogram models.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spacetime_kriging(...)
}

spatial_error_regression <- function(...) {
  # Estimates spatial error model addressing exogenous spatial dependence in residuals from omitted variables or measurement error.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_error_regression(...)
}

wbw_spatial_error_regression <- function(...) {
  # Estimates spatial error model addressing exogenous spatial dependence in residuals from omitted variables or measurement error.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_error_regression(...)
}

spatial_error_regression_raster <- function(...) {
  # Estimates SEM model and outputs fitted value surface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_error_regression_raster(...)
}

wbw_spatial_error_regression_raster <- function(...) {
  # Estimates SEM model and outputs fitted value surface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_error_regression_raster(...)
}

spatial_join <- function(...) {
  # Transfers attributes from join-layer features to targets using spatial predicates; supports aggregation strategies (count, sum, mean, min, max) for multiple matches.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_join(...)
}

wbw_spatial_join <- function(...) {
  # Transfers attributes from join-layer features to targets using spatial predicates; supports aggregation strategies (count, sum, mean, min, max) for multiple matches.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_join(...)
}

spatial_lag_regression <- function(...) {
  # Estimates spatial autoregressive model capturing endogenous spillover effects where dependent variable is influenced by spatial neighbors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_lag_regression(...)
}

wbw_spatial_lag_regression <- function(...) {
  # Estimates spatial autoregressive model capturing endogenous spillover effects where dependent variable is influenced by spatial neighbors.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_lag_regression(...)
}

spatial_lag_regression_raster <- function(...) {
  # Estimates SAR model and outputs fitted value surface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_lag_regression_raster(...)
}

wbw_spatial_lag_regression_raster <- function(...) {
  # Estimates SAR model and outputs fitted value surface.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spatial_lag_regression_raster(...)
}

spectral_angle_mapper <- function(...) {
  # Spectral Angle Mapping classifies pixels by computing spectral angles between each pixel spectrum and reference library spectra, assigning pixels to the library spectrum with minimum angle, representing maximum spectral similarity independent of illumination intensity. SAM treats each pixel and reference spectrum as vectors in N-dimensional spectral space, computing angles between vectors using dot product operations and inverse cosine transformations. This spectral-angle-based classification is invariant to illumination and topographic effects that scale overall brightness but preserve spectral shape, making it robust for complex terrain and varying acquisition conditions. Key features include automatic spectral angle threshold definition enabling probabilistic classification confidence, reference library import supporting user-provided spectral signatures from field samples or spectral libraries, illumination invariance handling variable lighting while preserving spectral discrimination, and rapid computation enabling real-time classification of large images. Common applications include material identification and geological mapping using USGS spectral libraries, vegetation species classification combining multispectral satellite data with field-collected spectra, mineral prospecting in hyperspectral airborne surveys, and accuracy assessment comparing image spectra against ground-collected reference signatures. SAM output enables confident material identification leveraging spectral shape signatures. Classification output produces single-band imagery with integer class labels corresponding to library entries; confidence raster optionally records minimum spectral angles for each pixel enabling threshold-based filtering; output enables direct material identification and confidence-based filtering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spectral_angle_mapper(...)
}

wbw_spectral_angle_mapper <- function(...) {
  # Spectral Angle Mapping classifies pixels by computing spectral angles between each pixel spectrum and reference library spectra, assigning pixels to the library spectrum with minimum angle, representing maximum spectral similarity independent of illumination intensity. SAM treats each pixel and reference spectrum as vectors in N-dimensional spectral space, computing angles between vectors using dot product operations and inverse cosine transformations. This spectral-angle-based classification is invariant to illumination and topographic effects that scale overall brightness but preserve spectral shape, making it robust for complex terrain and varying acquisition conditions. Key features include automatic spectral angle threshold definition enabling probabilistic classification confidence, reference library import supporting user-provided spectral signatures from field samples or spectral libraries, illumination invariance handling variable lighting while preserving spectral discrimination, and rapid computation enabling real-time classification of large images. Common applications include material identification and geological mapping using USGS spectral libraries, vegetation species classification combining multispectral satellite data with field-collected spectra, mineral prospecting in hyperspectral airborne surveys, and accuracy assessment comparing image spectra against ground-collected reference signatures. SAM output enables confident material identification leveraging spectral shape signatures. Classification output produces single-band imagery with integer class labels corresponding to library entries; confidence raster optionally records minimum spectral angles for each pixel enabling threshold-based filtering; output enables direct material identification and confidence-based filtering.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spectral_angle_mapper(...)
}

spectral_library_matching <- function(...) {
  # Spectral library matching performs classification by comparing image pixel spectra to reference library spectra using multiple similarity metrics including spectral angle (angle between spectra vectors), Euclidean distance (magnitude difference), and spectral information divergence. The algorithm accepts user-provided reference spectral library with known material/class spectra, computes similarity metrics between each image pixel and library entries, identifies the library spectrum with best match (minimum angle, minimum distance, or minimum divergence), and outputs class labels with optional confidence/similarity scores. Library matching enables material identification without field training samples by leveraging reference spectra from USGS, field surveys, or laboratory spectroscopy. Key features include multiple similarity metrics enabling metric selection for specific spectral characteristics and class distributions, library import flexibility supporting various spectral library formats, optional confidence/uncertainty quantification, and direct identifiable material output. Applications include geological mapping using USGS spectral library for mineralogy, vegetation classification using plant spectral reference libraries, building material identification in urban areas, and airborne hyperspectral survey analysis. Spectral library matching enables automated material identification. Output comprises classified map with library entry IDs as class labels, similarity/confidence raster quantifying match quality, and optional full spectral angle/distance stack for each library entry enabling threshold-based filtering; metadata documents reference library source and similarity metric used.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spectral_library_matching(...)
}

wbw_spectral_library_matching <- function(...) {
  # Spectral library matching performs classification by comparing image pixel spectra to reference library spectra using multiple similarity metrics including spectral angle (angle between spectra vectors), Euclidean distance (magnitude difference), and spectral information divergence. The algorithm accepts user-provided reference spectral library with known material/class spectra, computes similarity metrics between each image pixel and library entries, identifies the library spectrum with best match (minimum angle, minimum distance, or minimum divergence), and outputs class labels with optional confidence/similarity scores. Library matching enables material identification without field training samples by leveraging reference spectra from USGS, field surveys, or laboratory spectroscopy. Key features include multiple similarity metrics enabling metric selection for specific spectral characteristics and class distributions, library import flexibility supporting various spectral library formats, optional confidence/uncertainty quantification, and direct identifiable material output. Applications include geological mapping using USGS spectral library for mineralogy, vegetation classification using plant spectral reference libraries, building material identification in urban areas, and airborne hyperspectral survey analysis. Spectral library matching enables automated material identification. Output comprises classified map with library entry IDs as class labels, similarity/confidence raster quantifying match quality, and optional full spectral angle/distance stack for each library entry enabling threshold-based filtering; metadata documents reference library source and similarity metric used.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spectral_library_matching(...)
}

spherical_std_dev_of_normals <- function(...) {
  # Calculates spherical standard deviation of local surface normals.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spherical_std_dev_of_normals(...)
}

wbw_spherical_std_dev_of_normals <- function(...) {
  # Calculates spherical standard deviation of local surface normals.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$spherical_std_dev_of_normals(...)
}

split_colour_composite <- function(...) {
  # Splits a packed RGB colour composite raster into three separate single-band rasters representing red, green, and blue channels. Algorithm: This tool extracts individual colour bands from a composite image where R, G, and B values are packed into a single raster (often using standard 24-bit RGB or 32-bit RGBA encoding). The separation is performed through bitwise operations to isolate each 8-bit channel component. Key features: Preserves original radiometric values (0–255), handles standard RGB composites and extended formats, outputs three independent georeferenced rasters. Use cases: Spectral analysis where individual bands must be processed separately; creating input datasets for vegetation indices (NDVI, EVI) calculations; preparing data for band algebra operations; enabling advanced color transformations like RGB-to-IHS conversion; extracting specific bands for supervised or unsupervised classification workflows. Applications: Remote sensing image analysis, satellite data preprocessing, multispectral analysis preparation, image enhancement pipelines. Output interpretation: Three single-band rasters are produced with identical spatial extent, projection, and georeference as the input composite. Each output band contains 8-bit radiometric values (0–255) representing the intensity of that colour component across the scene. Band statistics (min, max, mean) reflect the spectral characteristics of that colour channel; dominant values indicate colour dominance across the image. Output rasters are immediately suitable for band calculations, spectral indices, or further multi-band processing workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_colour_composite(...)
}

wbw_split_colour_composite <- function(...) {
  # Splits a packed RGB colour composite raster into three separate single-band rasters representing red, green, and blue channels. Algorithm: This tool extracts individual colour bands from a composite image where R, G, and B values are packed into a single raster (often using standard 24-bit RGB or 32-bit RGBA encoding). The separation is performed through bitwise operations to isolate each 8-bit channel component. Key features: Preserves original radiometric values (0–255), handles standard RGB composites and extended formats, outputs three independent georeferenced rasters. Use cases: Spectral analysis where individual bands must be processed separately; creating input datasets for vegetation indices (NDVI, EVI) calculations; preparing data for band algebra operations; enabling advanced color transformations like RGB-to-IHS conversion; extracting specific bands for supervised or unsupervised classification workflows. Applications: Remote sensing image analysis, satellite data preprocessing, multispectral analysis preparation, image enhancement pipelines. Output interpretation: Three single-band rasters are produced with identical spatial extent, projection, and georeference as the input composite. Each output band contains 8-bit radiometric values (0–255) representing the intensity of that colour component across the scene. Band statistics (min, max, mean) reflect the spectral characteristics of that colour channel; dominant values indicate colour dominance across the image. Output rasters are immediately suitable for band calculations, spectral indices, or further multi-band processing workflows.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_colour_composite(...)
}

split_lidar <- function(...) {
  # Partitions points into separate files by attribute: groups by class, source-id, time window, spatial bin, or point count. Data stratification and distribution.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_lidar(...)
}

wbw_split_lidar <- function(...) {
  # Partitions points into separate files by attribute: groups by class, source-id, time window, spatial bin, or point count. Data stratification and distribution.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_lidar(...)
}

split_lines_at_intersections <- function(...) {
  # Splits a line network wherever line segments intersect, including self-intersections.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_lines_at_intersections(...)
}

wbw_split_lines_at_intersections <- function(...) {
  # Splits a line network wherever line segments intersect, including self-intersections.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_lines_at_intersections(...)
}

split_vector_lines <- function(...) {
  # Splits each polyline feature into segments of a maximum specified length.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_vector_lines(...)
}

wbw_split_vector_lines <- function(...) {
  # Splits each polyline feature into segments of a maximum specified length.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_vector_lines(...)
}

split_with_lines <- function(...) {
  # Splits input polylines using intersection points from a split line layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_with_lines(...)
}

wbw_split_with_lines <- function(...) {
  # Splits input polylines using intersection points from a split line layer.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$split_with_lines(...)
}

sqrt <- function(...) {
  # Computes the square-root of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sqrt(...)
}

wbw_sqrt <- function(...) {
  # Computes the square-root of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sqrt(...)
}

square <- function(...) {
  # Squares each raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$square(...)
}

wbw_square <- function(...) {
  # Squares each raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$square(...)
}

standard_deviation_contrast_stretch <- function(...) {
  # Performs linear contrast stretch using mean plus/minus a standard deviation multiplier.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$standard_deviation_contrast_stretch(...)
}

wbw_standard_deviation_contrast_stretch <- function(...) {
  # Performs linear contrast stretch using mean plus/minus a standard deviation multiplier.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$standard_deviation_contrast_stretch(...)
}

standard_deviation_filter <- function(...) {
  # Computes moving-window standard deviation, measuring local value variation/dispersion. High stdev = diverse values (rough/heterogeneous), low stdev = uniform values (smooth/homogeneous). Reveals texture, roughness, and variability patterns. Critical for uncertainty quantification and quality assessment.  Standard deviation is more robust than range for characterizing local variation (not biased by single outlier). Enables classification of areas by texture: steep slopes (high stdev), gentle slopes (low stdev); forests (high stdev), grasslands (low stdev). Often normalized (coefficient of variation = stdev/mean) to enable comparison across data with different value ranges. Can be computed from histogram (variance = mean_of_squares - square_of_mean).  Applications: (1) Texture mapping (roughness/heterogeneity analysis), (2) Uncertainty quantification in noisy data, (3) Quality assessment (uniform background = low stdev, feature-rich areas = high), (4) Classification confidence (high stdev = mixed/uncertain classes), (5) Multi-band heterogeneity (stack stdevs from each band). Typical workflow: compute stdev at multiple scales→compare pattern changes across scales→identify characteristic scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$standard_deviation_filter(...)
}

wbw_standard_deviation_filter <- function(...) {
  # Computes moving-window standard deviation, measuring local value variation/dispersion. High stdev = diverse values (rough/heterogeneous), low stdev = uniform values (smooth/homogeneous). Reveals texture, roughness, and variability patterns. Critical for uncertainty quantification and quality assessment.  Standard deviation is more robust than range for characterizing local variation (not biased by single outlier). Enables classification of areas by texture: steep slopes (high stdev), gentle slopes (low stdev); forests (high stdev), grasslands (low stdev). Often normalized (coefficient of variation = stdev/mean) to enable comparison across data with different value ranges. Can be computed from histogram (variance = mean_of_squares - square_of_mean).  Applications: (1) Texture mapping (roughness/heterogeneity analysis), (2) Uncertainty quantification in noisy data, (3) Quality assessment (uniform background = low stdev, feature-rich areas = high), (4) Classification confidence (high stdev = mixed/uncertain classes), (5) Multi-band heterogeneity (stack stdevs from each band). Typical workflow: compute stdev at multiple scales→compare pattern changes across scales→identify characteristic scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$standard_deviation_filter(...)
}

standard_deviation_of_slope <- function(...) {
  # Calculates local standard deviation of slope as a terrain roughness metric.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$standard_deviation_of_slope(...)
}

wbw_standard_deviation_of_slope <- function(...) {
  # Calculates local standard deviation of slope as a terrain roughness metric.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$standard_deviation_of_slope(...)
}

standard_deviation_overlay <- function(...) {
  # Computes the per-cell standard deviation across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$standard_deviation_overlay(...)
}

wbw_standard_deviation_overlay <- function(...) {
  # Computes the per-cell standard deviation across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$standard_deviation_overlay(...)
}

stochastic_depression_analysis <- function(...) {
  # Runs Monte Carlo DEM perturbations and estimates depression-membership probability.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stochastic_depression_analysis(...)
}

wbw_stochastic_depression_analysis <- function(...) {
  # Runs Monte Carlo DEM perturbations and estimates depression-membership probability.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stochastic_depression_analysis(...)
}

strahler_order_basins <- function(...) {
  # Delineates watershed basins labelled by the Horton-Strahler order of their draining stream link.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$strahler_order_basins(...)
}

wbw_strahler_order_basins <- function(...) {
  # Delineates watershed basins labelled by the Horton-Strahler order of their draining stream link.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$strahler_order_basins(...)
}

strahler_stream_order <- function(...) {
  # Assigns Strahler stream order to stream cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$strahler_stream_order(...)
}

wbw_strahler_stream_order <- function(...) {
  # Assigns Strahler stream order to stream cells.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$strahler_stream_order(...)
}

stream_link_class <- function(...) {
  # Classifies stream links as interior, exterior, or source.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_link_class(...)
}

wbw_stream_link_class <- function(...) {
  # Classifies stream links as interior, exterior, or source.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_link_class(...)
}

stream_link_identifier <- function(...) {
  # Assigns unique ID to each stream link.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_link_identifier(...)
}

wbw_stream_link_identifier <- function(...) {
  # Assigns unique ID to each stream link.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_link_identifier(...)
}

stream_link_length <- function(...) {
  # Calculates total length for each stream link.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_link_length(...)
}

wbw_stream_link_length <- function(...) {
  # Calculates total length for each stream link.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_link_length(...)
}

stream_link_slope <- function(...) {
  # Calculates average slope for each stream link.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_link_slope(...)
}

wbw_stream_link_slope <- function(...) {
  # Calculates average slope for each stream link.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_link_slope(...)
}

stream_slope_continuous <- function(...) {
  # Calculates slope value for each stream cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_slope_continuous(...)
}

wbw_stream_slope_continuous <- function(...) {
  # Calculates slope value for each stream cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$stream_slope_continuous(...)
}

subbasins <- function(...) {
  # Identifies the catchment area of each stream link (sub-basins) in a D8 stream network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$subbasins(...)
}

wbw_subbasins <- function(...) {
  # Identifies the catchment area of each stream link (sub-basins) in a D8 stream network.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$subbasins(...)
}

subtract <- function(...) {
  # Subtracts the second raster from the first on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$subtract(...)
}

wbw_subtract <- function(...) {
  # Subtracts the second raster from the first on a cell-by-cell basis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$subtract(...)
}

sum_overlay <- function(...) {
  # Computes the per-cell sum across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sum_overlay(...)
}

wbw_sum_overlay <- function(...) {
  # Computes the per-cell sum across a raster stack, propagating NoData if any input cell is NoData.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$sum_overlay(...)
}

surface_area_ratio <- function(...) {
  # 3D surface area / planimetric area ratio (Jenness method). >1.0=rough terrain, ≈1.0=flat. Dimensionless rugosity metric enabling cross-region terrain comparison.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$surface_area_ratio(...)
}

wbw_surface_area_ratio <- function(...) {
  # 3D surface area / planimetric area ratio (Jenness method). >1.0=rough terrain, ≈1.0=flat. Dimensionless rugosity metric enabling cross-region terrain comparison.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$surface_area_ratio(...)
}

svm_classification <- function(...) {
  # Support Vector Machine (SVM) Classification applies machine learning Support Vector Machine algorithms to multispectral remote sensing data, separating training classes through optimal hyperplane placement in high-dimensional spectral feature space. Algorithm: transforms spectral feature vectors into high-dimensional space via kernel functions (linear, RBF, polynomial), identifies maximum-margin hyperplane separating training classes, classifies new pixels according to hyperplane position; tolerance parameters and kernel selection control generalization. Handles nonlinear class separation effectively. Key features: robust to high-dimensional spectral data, excellent generalization with limited training samples, kernel flexibility accommodates diverse spectral distributions, provides probability/confidence estimates. Capabilities: multiclass classification, soft-margin tolerance, automatic class weight balancing. Use cases: detailed land classification with sparse training data, spectral-spatial feature integration, change detection, precision agriculture, urban mapping. Applications: hyperspectral image classification, complex ecosystem mapping, crop-type delineation, infrastructure classification. Output interpretation: class membership indicates predicted category with spatial coherence revealing classification quality; probability estimates quantify pixel-level confidence; misclassification patterns indicate training data deficiencies or spectral overlap problems.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$svm_classification(...)
}

wbw_svm_classification <- function(...) {
  # Support Vector Machine (SVM) Classification applies machine learning Support Vector Machine algorithms to multispectral remote sensing data, separating training classes through optimal hyperplane placement in high-dimensional spectral feature space. Algorithm: transforms spectral feature vectors into high-dimensional space via kernel functions (linear, RBF, polynomial), identifies maximum-margin hyperplane separating training classes, classifies new pixels according to hyperplane position; tolerance parameters and kernel selection control generalization. Handles nonlinear class separation effectively. Key features: robust to high-dimensional spectral data, excellent generalization with limited training samples, kernel flexibility accommodates diverse spectral distributions, provides probability/confidence estimates. Capabilities: multiclass classification, soft-margin tolerance, automatic class weight balancing. Use cases: detailed land classification with sparse training data, spectral-spatial feature integration, change detection, precision agriculture, urban mapping. Applications: hyperspectral image classification, complex ecosystem mapping, crop-type delineation, infrastructure classification. Output interpretation: class membership indicates predicted category with spatial coherence revealing classification quality; probability estimates quantify pixel-level confidence; misclassification patterns indicate training data deficiencies or spectral overlap problems.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$svm_classification(...)
}

svm_regression <- function(...) {
  # Performs supervised support-vector-machine regression on multi-band input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$svm_regression(...)
}

wbw_svm_regression <- function(...) {
  # Performs supervised support-vector-machine regression on multi-band input rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$svm_regression(...)
}

symmetrical_difference <- function(...) {
  # Computes non-overlapping polygon regions from input and overlay layers.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$symmetrical_difference(...)
}

wbw_symmetrical_difference <- function(...) {
  # Computes non-overlapping polygon regions from input and overlay layers.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$symmetrical_difference(...)
}

tan <- function(...) {
  # Computes the tangent of each raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tan(...)
}

wbw_tan <- function(...) {
  # Computes the tangent of each raster cell value.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tan(...)
}

tangential_curvature <- function(...) {
  # Calculates tangential curvature (E-W direction component), similar to plan curvature but directional. Used for comprehensive curvature characterization capturing lateral flow divergence perpendicular to slope direction. Often combined with profile for full 3D curvature understanding.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tangential_curvature(...)
}

wbw_tangential_curvature <- function(...) {
  # Calculates tangential curvature (E-W direction component), similar to plan curvature but directional. Used for comprehensive curvature characterization capturing lateral flow divergence perpendicular to slope direction. Often combined with profile for full 3D curvature understanding.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tangential_curvature(...)
}

tanh <- function(...) {
  # Computes the hyperbolic tangent of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tanh(...)
}

wbw_tanh <- function(...) {
  # Computes the hyperbolic tangent of each raster cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tanh(...)
}

terrain_corrected_optical_analytics <- function(...) {
  # Topographic C-correction of multispectral optical bands using a co-registered DEM. Outputs surface reflectance stack, correction factor, cloud/shadow mask, and quality confidence.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$terrain_corrected_optical_analytics(...)
}

wbw_terrain_corrected_optical_analytics <- function(...) {
  # Topographic C-correction of multispectral optical bands using a co-registered DEM. Outputs surface reflectance stack, correction factor, cloud/shadow mask, and quality confidence.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$terrain_corrected_optical_analytics(...)
}

thicken_raster_line <- function(...) {
  # Thickens diagonal raster line segments to prevent diagonal leak-through.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$thicken_raster_line(...)
}

wbw_thicken_raster_line <- function(...) {
  # Thickens diagonal raster line segments to prevent diagonal leak-through.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$thicken_raster_line(...)
}

time_in_daylight <- function(...) {
  # Calculates the proportion of daytime each cell is illuminated (not in terrain/object shadow).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$time_in_daylight(...)
}

wbw_time_in_daylight <- function(...) {
  # Calculates the proportion of daytime each cell is illuminated (not in terrain/object shadow).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$time_in_daylight(...)
}

tin_interpolation <- function(...) {
  # Interpolates a raster from point samples using Delaunay triangulation and planar interpolation within each triangle.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tin_interpolation(...)
}

wbw_tin_interpolation <- function(...) {
  # Interpolates a raster from point samples using Delaunay triangulation and planar interpolation within each triangle.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tin_interpolation(...)
}

to_degrees <- function(...) {
  # Converts each raster cell from radians to degrees.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$to_degrees(...)
}

wbw_to_degrees <- function(...) {
  # Converts each raster cell from radians to degrees.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$to_degrees(...)
}

to_radians <- function(...) {
  # Converts each raster cell from degrees to radians.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$to_radians(...)
}

wbw_to_radians <- function(...) {
  # Converts each raster cell from degrees to radians.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$to_radians(...)
}

tophat_transform <- function(...) {
  # Performs a white or black morphological top-hat transform.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tophat_transform(...)
}

wbw_tophat_transform <- function(...) {
  # Performs a white or black morphological top-hat transform.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tophat_transform(...)
}

topo_render <- function(...) {
  # Creates a pseudo-3D topographic rendering using palette tinting, hillshade, shadows, and attenuation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topo_render(...)
}

wbw_topo_render <- function(...) {
  # Creates a pseudo-3D topographic rendering using palette tinting, hillshade, shadows, and attenuation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topo_render(...)
}

topographic_hachures <- function(...) {
  # Creates topographic hachure polylines from a DEM using contour-seeded downslope and upslope flowlines. Legacy authorship attribution is intentionally preserved for this tool.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topographic_hachures(...)
}

wbw_topographic_hachures <- function(...) {
  # Creates topographic hachure polylines from a DEM using contour-seeded downslope and upslope flowlines. Legacy authorship attribution is intentionally preserved for this tool.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topographic_hachures(...)
}

topographic_position_animation <- function(...) {
  # Creates an interactive HTML viewer and animated GIF of DEV or DEVmax across nonlinearly sampled scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topographic_position_animation(...)
}

wbw_topographic_position_animation <- function(...) {
  # Creates an interactive HTML viewer and animated GIF of DEV or DEVmax across nonlinearly sampled scales.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topographic_position_animation(...)
}

topological_breach_burn <- function(...) {
  # Burns streams into a DEM, conditions the surface, and returns stream, DEM, pointer, and accumulation rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topological_breach_burn(...)
}

wbw_topological_breach_burn <- function(...) {
  # Burns streams into a DEM, conditions the surface, and returns stream, DEM, pointer, and accumulation rasters.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topological_breach_burn(...)
}

topological_stream_order <- function(...) {
  # Assigns topological stream order based on link count.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topological_stream_order(...)
}

wbw_topological_stream_order <- function(...) {
  # Assigns topological stream order based on link count.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topological_stream_order(...)
}

topology_rule_autofix <- function(...) {
  # Automatically applies safe, auditable fixes to topology violations detected by topology_rule_validate.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topology_rule_autofix(...)
}

wbw_topology_rule_autofix <- function(...) {
  # Automatically applies safe, auditable fixes to topology violations detected by topology_rule_validate.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topology_rule_autofix(...)
}

topology_rule_validate <- function(...) {
  # Validates vector topology against rule-set checks (self-intersection, overlap, gaps, dangles, point coverage, endpoint snapping) and emits feature-level violations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topology_rule_validate(...)
}

wbw_topology_rule_validate <- function(...) {
  # Validates vector topology against rule-set checks (self-intersection, overlap, gaps, dangles, point coverage, endpoint snapping) and emits feature-level violations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topology_rule_validate(...)
}

topology_validation_report <- function(...) {
  # Audits a vector layer for topology issues and writes a per-feature CSV report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topology_validation_report(...)
}

wbw_topology_validation_report <- function(...) {
  # Audits a vector layer for topology issues and writes a per-feature CSV report.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$topology_validation_report(...)
}

total_curvature <- function(...) {
  # Calculates total curvature (quadratic mean of principal curvatures). Scalar metric independent of direction. High values indicate highly curved terrain (peaks, pits); low values indicate planar terrain. Useful as dimensionless roughness metric for terrain classification and anomaly detection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$total_curvature(...)
}

wbw_total_curvature <- function(...) {
  # Calculates total curvature (quadratic mean of principal curvatures). Scalar metric independent of direction. High values indicate highly curved terrain (peaks, pits); low values indicate planar terrain. Useful as dimensionless roughness metric for terrain classification and anomaly detection.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$total_curvature(...)
}

total_filter <- function(...) {
  # Computes moving-window sum (total) of pixel values in neighborhood. Integrates local signal strength. Applications depend on data semantics: for counts/densities, total reveals local density patterns; for precipitation, total reveals basin-scale accumulation; for reflectance, total is proportional to local target size.  Total filtering has different interpretations by domain. In count/population data, total reveals clustering and hotspots. In elevation data, total is rarely used (sum has no geomorphological meaning). In spectral analysis, total can reveal multi-band signal strength. Often used as intermediate step (e.g., divide by neighborhood cell count to compute mean, or compare with neighboring totals for local heterogeneity detection).  Applications: (1) Hotspot detection in count data (high total = clusters), (2) Basin/watershed accumulation models, (3) Integration of distributed measurements, (4) Intermediate calculation (total/N = mean), (5) Signal strength aggregation in multi-sensor mosaics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$total_filter(...)
}

wbw_total_filter <- function(...) {
  # Computes moving-window sum (total) of pixel values in neighborhood. Integrates local signal strength. Applications depend on data semantics: for counts/densities, total reveals local density patterns; for precipitation, total reveals basin-scale accumulation; for reflectance, total is proportional to local target size.  Total filtering has different interpretations by domain. In count/population data, total reveals clustering and hotspots. In elevation data, total is rarely used (sum has no geomorphological meaning). In spectral analysis, total can reveal multi-band signal strength. Often used as intermediate step (e.g., divide by neighborhood cell count to compute mean, or compare with neighboring totals for local heterogeneity detection).  Applications: (1) Hotspot detection in count data (high total = clusters), (2) Basin/watershed accumulation models, (3) Integration of distributed measurements, (4) Intermediate calculation (total/N = mean), (5) Signal strength aggregation in multi-sensor mosaics.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$total_filter(...)
}

trace_downslope_flowpaths <- function(...) {
  # Marks D8 flowpaths initiated from seed points until no-flow or grid edge.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$trace_downslope_flowpaths(...)
}

wbw_trace_downslope_flowpaths <- function(...) {
  # Marks D8 flowpaths initiated from seed points until no-flow or grid edge.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$trace_downslope_flowpaths(...)
}

transfer_attributes <- function(...) {
  # Transfers source attributes onto target features using a spatial predicate.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$transfer_attributes(...)
}

wbw_transfer_attributes <- function(...) {
  # Transfers source attributes onto target features using a spatial predicate.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$transfer_attributes(...)
}

travelling_salesman_problem <- function(...) {
  # Finds approximate solutions to the travelling salesman problem (TSP) using 2-opt heuristics. Given a set of point locations, identifies the shortest route connecting all points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$travelling_salesman_problem(...)
}

wbw_travelling_salesman_problem <- function(...) {
  # Finds approximate solutions to the travelling salesman problem (TSP) using 2-opt heuristics. Given a set of point locations, identifies the shortest route connecting all points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$travelling_salesman_problem(...)
}

trend_surface <- function(...) {
  # Fits a polynomial trend surface to a raster using least-squares regression.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$trend_surface(...)
}

wbw_trend_surface <- function(...) {
  # Fits a polynomial trend surface to a raster using least-squares regression.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$trend_surface(...)
}

trend_surface_vector_points <- function(...) {
  # Fits a polynomial trend surface to vector point data using least-squares regression.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$trend_surface_vector_points(...)
}

wbw_trend_surface_vector_points <- function(...) {
  # Fits a polynomial trend surface to vector point data using least-squares regression.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$trend_surface_vector_points(...)
}

tributary_identifier <- function(...) {
  # Assigns unique ID to each tributary.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tributary_identifier(...)
}

wbw_tributary_identifier <- function(...) {
  # Assigns unique ID to each tributary.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$tributary_identifier(...)
}

truncate <- function(...) {
  # Truncates each raster cell value to its integer part.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$truncate(...)
}

wbw_truncate <- function(...) {
  # Truncates each raster cell value to its integer part.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$truncate(...)
}

turning_bands_simulation <- function(...) {
  # Creates a spatially-autocorrelated random field using the turning bands algorithm.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$turning_bands_simulation(...)
}

wbw_turning_bands_simulation <- function(...) {
  # Creates a spatially-autocorrelated random field using the turning bands algorithm.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$turning_bands_simulation(...)
}

two_sample_ks_test <- function(...) {
  # Performs a two-sample Kolmogorov-Smirnov test on two raster value distributions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$two_sample_ks_test(...)
}

wbw_two_sample_ks_test <- function(...) {
  # Performs a two-sample Kolmogorov-Smirnov test on two raster value distributions.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$two_sample_ks_test(...)
}

union <- function(...) {
  # Dissolves combined input and overlay polygons into a unified polygon coverage.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$union(...)
}

wbw_union <- function(...) {
  # Dissolves combined input and overlay polygons into a unified polygon coverage.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$union(...)
}

universal_kriging <- function(...) {
  # Performs universal kriging (kriging with a polynomial trend). Requires a pre-fitted variogram model (from fit_variogram). Use when spatial data has a systematic trend.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$universal_kriging(...)
}

wbw_universal_kriging <- function(...) {
  # Performs universal kriging (kriging with a polynomial trend). Requires a pre-fitted variogram model (from fit_variogram). Use when spatial data has a systematic trend.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$universal_kriging(...)
}

unnest_basins <- function(...) {
  # Creates one basin raster per pour-point nesting level from a D8 pointer grid.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$unnest_basins(...)
}

wbw_unnest_basins <- function(...) {
  # Creates one basin raster per pour-point nesting level from a D8 pointer grid.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$unnest_basins(...)
}

unsharp_masking <- function(...) {
  # Unsharp masking performs image sharpening by subtracting a smoothed (low-pass) version from the original image, enhancing edges and fine details. The mathematical transformation is I_sharp = I_original + w·(I_original - I_smooth), where w is sharpening weight controlling enhancement strength. The process isolates high-frequency components and amplifies them, effectively separating detail from broad tonal variation. Key features include flexible parameter control (blur radius and weight enabling detail control), computational efficiency via Gaussian smoothing reuse, interpretable enhancement (weight=0 gives original; weight=1 gives true high-pass; weight>1 provides aggressive sharpening), and effectiveness on multispectral data. Unsharp masking excels in satellite image preparation for manual interpretation (enhances subtle terrain, vegetation, infrastructure), LiDAR-derived product enhancement (sharpens DEMs, vegetation metrics), orthophoto quality improvement for feature visibility, and archaeological/survey imagery enhancement. Output interpretation requires understanding that sharpened values concentrate on edges; homogeneous regions remain unchanged. Weight parameter controls enhancement magnitude: w=0.5-1.0 provides subtle enhancement; w=1.0-2.0 provides moderate sharpening; w>2.0 produces aggressive, potentially artifact-laden results. Blur radius controls feature scale: smaller radius (3-5 pixels) enhances fine texture; larger radius (10-20 pixels) enhances moderate features. Output values may exceed input range; clipping typically necessary. Artifacts include halos around strong edges (larger weight or radius = more pronounced), amplified noise if source is noisy, and potential false colors in multispectral sharpening. Verify enhancement via difference images. Apply selectively in visualization workflows; avoid before automated analysis that's sensitive to output range changes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$unsharp_masking(...)
}

wbw_unsharp_masking <- function(...) {
  # Unsharp masking performs image sharpening by subtracting a smoothed (low-pass) version from the original image, enhancing edges and fine details. The mathematical transformation is I_sharp = I_original + w·(I_original - I_smooth), where w is sharpening weight controlling enhancement strength. The process isolates high-frequency components and amplifies them, effectively separating detail from broad tonal variation. Key features include flexible parameter control (blur radius and weight enabling detail control), computational efficiency via Gaussian smoothing reuse, interpretable enhancement (weight=0 gives original; weight=1 gives true high-pass; weight>1 provides aggressive sharpening), and effectiveness on multispectral data. Unsharp masking excels in satellite image preparation for manual interpretation (enhances subtle terrain, vegetation, infrastructure), LiDAR-derived product enhancement (sharpens DEMs, vegetation metrics), orthophoto quality improvement for feature visibility, and archaeological/survey imagery enhancement. Output interpretation requires understanding that sharpened values concentrate on edges; homogeneous regions remain unchanged. Weight parameter controls enhancement magnitude: w=0.5-1.0 provides subtle enhancement; w=1.0-2.0 provides moderate sharpening; w>2.0 produces aggressive, potentially artifact-laden results. Blur radius controls feature scale: smaller radius (3-5 pixels) enhances fine texture; larger radius (10-20 pixels) enhances moderate features. Output values may exceed input range; clipping typically necessary. Artifacts include halos around strong edges (larger weight or radius = more pronounced), amplified noise if source is noisy, and potential false colors in multispectral sharpening. Verify enhancement via difference images. Apply selectively in visualization workflows; avoid before automated analysis that's sensitive to output range changes.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$unsharp_masking(...)
}

unsphericity <- function(...) {
  # Calculates the unsphericity curvature (half the difference of principal curvatures) from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$unsphericity(...)
}

wbw_unsphericity <- function(...) {
  # Calculates the unsphericity curvature (half the difference of principal curvatures) from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$unsphericity(...)
}

update <- function(...) {
  # Replaces input features with update features where they overlap; input features outside the update layer are preserved.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$update(...)
}

wbw_update <- function(...) {
  # Replaces input features with update features where they overlap; input features outside the update layer are preserved.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$update(...)
}

update_nodata_cells <- function(...) {
  # Assigns NoData cells in input1 from corresponding valid cells in input2.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$update_nodata_cells(...)
}

wbw_update_nodata_cells <- function(...) {
  # Assigns NoData cells in input1 from corresponding valid cells in input2.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$update_nodata_cells(...)
}

upslope_depression_storage <- function(...) {
  # Maps mean upslope depression-storage depth by routing depression depth over a conditioned DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$upslope_depression_storage(...)
}

wbw_upslope_depression_storage <- function(...) {
  # Maps mean upslope depression-storage depth by routing depression depth over a conditioned DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$upslope_depression_storage(...)
}

user_defined_weights_filter <- function(...) {
  # The user-defined weights filter provides maximum flexibility for custom convolution analysis by accepting arbitrary weighted coefficients for neighborhood pixels, enabling implementation of specialized operators, domain-specific kernels, and research-grade algorithms without requiring tool modifications or specialized software. Users specify kernel dimensions (typically 3×3 or 5×5), assign floating-point weights to each position, and optionally designate edge-handling methods (reflection, wrapping, constant-fill). This filter applies the custom kernel across the entire raster through standard convolution mathematics: each output pixel equals the sum of weighted neighbors, enabling both traditional image processing filters and custom analytical kernels. Key features include complete customization for research applications, support for both enhancement and analysis operations, compatibility with normalized and unnormalized kernels, and preservation of floating-point precision throughout computation. Use cases span advanced spatial filtering for specialized spectral indices, implementation of experimental operators for algorithm validation, custom texture analysis kernels, weighted neighborhood aggregations for multi-criteria analysis, and standardized kernel application across diverse datasets. Applications include academic research prototyping, industry algorithm evaluation, regional customization of processing pipelines, and performance comparison studies. Output interpretation depends entirely on user-defined coefficients; different kernels produce fundamentally different results. Normalized kernels (sum of weights equals 1.0) preserve value ranges useful for smoothing; unnormalized kernels (typically summing to zero) emphasize differences useful for edge/derivative detection. Users must validate kernel properties—coefficient sign, magnitude, and sum—before production application. Documentation of kernel specifications is essential for reproducible workflows. Output value ranges depend on kernel design; documentation should specify expected output characteristics and scaling requirements.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$user_defined_weights_filter(...)
}

wbw_user_defined_weights_filter <- function(...) {
  # The user-defined weights filter provides maximum flexibility for custom convolution analysis by accepting arbitrary weighted coefficients for neighborhood pixels, enabling implementation of specialized operators, domain-specific kernels, and research-grade algorithms without requiring tool modifications or specialized software. Users specify kernel dimensions (typically 3×3 or 5×5), assign floating-point weights to each position, and optionally designate edge-handling methods (reflection, wrapping, constant-fill). This filter applies the custom kernel across the entire raster through standard convolution mathematics: each output pixel equals the sum of weighted neighbors, enabling both traditional image processing filters and custom analytical kernels. Key features include complete customization for research applications, support for both enhancement and analysis operations, compatibility with normalized and unnormalized kernels, and preservation of floating-point precision throughout computation. Use cases span advanced spatial filtering for specialized spectral indices, implementation of experimental operators for algorithm validation, custom texture analysis kernels, weighted neighborhood aggregations for multi-criteria analysis, and standardized kernel application across diverse datasets. Applications include academic research prototyping, industry algorithm evaluation, regional customization of processing pipelines, and performance comparison studies. Output interpretation depends entirely on user-defined coefficients; different kernels produce fundamentally different results. Normalized kernels (sum of weights equals 1.0) preserve value ranges useful for smoothing; unnormalized kernels (typically summing to zero) emphasize differences useful for edge/derivative detection. Users must validate kernel properties—coefficient sign, magnitude, and sum—before production application. Documentation of kernel specifications is essential for reproducible workflows. Output value ranges depend on kernel design; documentation should specify expected output characteristics and scaling requirements.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$user_defined_weights_filter(...)
}

vector_hex_binning <- function(...) {
  # Aggregates point features into hexagonal bins, counting points per hex cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_hex_binning(...)
}

wbw_vector_hex_binning <- function(...) {
  # Aggregates point features into hexagonal bins, counting points per hex cell.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_hex_binning(...)
}

vector_lines_to_raster <- function(...) {
  # Rasterizes line and polygon boundary geometries to a raster grid.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_lines_to_raster(...)
}

wbw_vector_lines_to_raster <- function(...) {
  # Rasterizes line and polygon boundary geometries to a raster grid.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_lines_to_raster(...)
}

vector_points_to_raster <- function(...) {
  # Rasterizes point or multipoint vectors to a grid using a selected assignment operation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_points_to_raster(...)
}

wbw_vector_points_to_raster <- function(...) {
  # Rasterizes point or multipoint vectors to a grid using a selected assignment operation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_points_to_raster(...)
}

vector_polygons_to_raster <- function(...) {
  # Rasterizes polygon vectors to a grid, supporting attribute-driven burn values.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_polygons_to_raster(...)
}

wbw_vector_polygons_to_raster <- function(...) {
  # Rasterizes polygon vectors to a grid, supporting attribute-driven burn values.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_polygons_to_raster(...)
}

vector_stream_network_analysis <- function(...) {
  # Comprehensive vector stream network analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_stream_network_analysis(...)
}

wbw_vector_stream_network_analysis <- function(...) {
  # Comprehensive vector stream network analysis.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_stream_network_analysis(...)
}

vector_summary_statistics <- function(...) {
  # Computes count, sum, mean, min, max, and standard deviation by categorical group and exports to CSV.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_summary_statistics(...)
}

wbw_vector_summary_statistics <- function(...) {
  # Computes count, sum, mean, min, max, and standard deviation by categorical group and exports to CSV.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vector_summary_statistics(...)
}

vehicle_routing_cvrp <- function(...) {
  # Builds capacity-constrained multi-depot delivery routes with heterogeneous fleet controls, objective modes, and optional local optimization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vehicle_routing_cvrp(...)
}

wbw_vehicle_routing_cvrp <- function(...) {
  # Builds capacity-constrained multi-depot delivery routes with heterogeneous fleet controls, objective modes, and optional local optimization.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vehicle_routing_cvrp(...)
}

vehicle_routing_pickup_delivery <- function(...) {
  # Builds paired pickup-delivery routes with precedence and capacity constraints using a deterministic nearest-neighbour baseline.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vehicle_routing_pickup_delivery(...)
}

wbw_vehicle_routing_pickup_delivery <- function(...) {
  # Builds paired pickup-delivery routes with precedence and capacity constraints using a deterministic nearest-neighbour baseline.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vehicle_routing_pickup_delivery(...)
}

vehicle_routing_vrptw <- function(...) {
  # Builds capacity-constrained multi-depot VRPTW routes with heterogeneous fleet settings, break windows, and objective-mode controls.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vehicle_routing_vrptw(...)
}

wbw_vehicle_routing_vrptw <- function(...) {
  # Builds capacity-constrained multi-depot VRPTW routes with heterogeneous fleet settings, break windows, and objective-mode controls.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vehicle_routing_vrptw(...)
}

vertical_excess_curvature <- function(...) {
  # Calculates vertical excess curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vertical_excess_curvature(...)
}

wbw_vertical_excess_curvature <- function(...) {
  # Calculates vertical excess curvature from a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$vertical_excess_curvature(...)
}

viewshed <- function(...) {
  # Computes station visibility counts from point stations over a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$viewshed(...)
}

wbw_viewshed <- function(...) {
  # Computes station visibility counts from point stations over a DEM.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$viewshed(...)
}

visibility_index <- function(...) {
  # Calculates a topography-based visibility index from sampled viewsheds.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$visibility_index(...)
}

wbw_visibility_index <- function(...) {
  # Calculates a topography-based visibility index from sampled viewsheds.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$visibility_index(...)
}

voronoi_diagram <- function(...) {
  # Creates Voronoi (Thiessen) polygons from input point locations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$voronoi_diagram(...)
}

wbw_voronoi_diagram <- function(...) {
  # Creates Voronoi (Thiessen) polygons from input point locations.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$voronoi_diagram(...)
}

watershed <- function(...) {
  # Delineates watersheds from a D8 pointer and vector pour points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$watershed(...)
}

wbw_watershed <- function(...) {
  # Delineates watersheds from a D8 pointer and vector pour points.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$watershed(...)
}

watershed_from_raster_pour_points <- function(...) {
  # Delineates watersheds from a D8 pointer and a raster of pour-point outlet IDs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$watershed_from_raster_pour_points(...)
}

wbw_watershed_from_raster_pour_points <- function(...) {
  # Delineates watersheds from a D8 pointer and a raster of pour-point outlet IDs.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$watershed_from_raster_pour_points(...)
}

weighted_overlay <- function(...) {
  # Combines factor rasters using normalized weights, optional cost flags, and optional binary constraints.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$weighted_overlay(...)
}

wbw_weighted_overlay <- function(...) {
  # Combines factor rasters using normalized weights, optional cost flags, and optional binary constraints.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$weighted_overlay(...)
}

weighted_sum <- function(...) {
  # Computes a weighted sum across a raster stack after normalizing weights to sum to one.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$weighted_sum(...)
}

wbw_weighted_sum <- function(...) {
  # Computes a weighted sum across a raster stack after normalizing weights to sum to one.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$weighted_sum(...)
}

wetness_index <- function(...) {
  # Calculates the topographic wetness index ln(SCA / tan(slope)).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$wetness_index(...)
}

wbw_wetness_index <- function(...) {
  # Calculates the topographic wetness index ln(SCA / tan(slope)).
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$wetness_index(...)
}

wiener_filter <- function(...) {
  # The Wiener filter performs adaptive noise reduction by minimizing mean-squared error between filtered output and true signal, assuming knowledge of signal and noise statistical properties. Implementation estimates local signal and noise variances within moving windows, computing filter coefficients that balance noise suppression against detail preservation: F = μ + (σ² - σₙ²)/σ² · (I - μ), where μ is local mean, σ² is signal variance, σₙ² is noise variance. This data-driven adaptation ensures filtering strength responds to local image characteristics. Key features include automatic adaptation to local statistics (flat regions smooth aggressively; detailed regions preserve structure), proven effectiveness on optical and SAR imagery, interpretable parameters based on noise model assumptions, and computational feasibility via separable approximations. Wiener filtering excels in satellite image preprocessing where noise varies spatially, SAR speckle reduction while preserving point targets, despeckled multispectral data for vegetation mapping, and radar-optical fusion denoising. Output interpretation shows that high-variance (detailed) regions filter minimally, while low-variance (noisy) regions filter aggressively. Noise variance estimation affects output: underestimated noise variance yields under-smoothing; overestimated variance causes over-smoothing and detail loss. Output ranges approach input ranges; examine difference images (original - filtered) to verify noise reduction. Peak Signal-to-Noise Ratio (PSNR) and Structural Similarity Index (SSIM) quantify filtering effectiveness. Local variance thresholds indicate processing impact: regions with detected variance ratio > 5 filter substantially; ratios < 1 filter minimally. Common pitfalls include inaccurate noise variance estimation (conduct dark-frame or homogeneous-region analysis for estimation) and window-size selection affecting localization. Apply before classification or feature extraction to reduce noise-driven category misclassification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$wiener_filter(...)
}

wbw_wiener_filter <- function(...) {
  # The Wiener filter performs adaptive noise reduction by minimizing mean-squared error between filtered output and true signal, assuming knowledge of signal and noise statistical properties. Implementation estimates local signal and noise variances within moving windows, computing filter coefficients that balance noise suppression against detail preservation: F = μ + (σ² - σₙ²)/σ² · (I - μ), where μ is local mean, σ² is signal variance, σₙ² is noise variance. This data-driven adaptation ensures filtering strength responds to local image characteristics. Key features include automatic adaptation to local statistics (flat regions smooth aggressively; detailed regions preserve structure), proven effectiveness on optical and SAR imagery, interpretable parameters based on noise model assumptions, and computational feasibility via separable approximations. Wiener filtering excels in satellite image preprocessing where noise varies spatially, SAR speckle reduction while preserving point targets, despeckled multispectral data for vegetation mapping, and radar-optical fusion denoising. Output interpretation shows that high-variance (detailed) regions filter minimally, while low-variance (noisy) regions filter aggressively. Noise variance estimation affects output: underestimated noise variance yields under-smoothing; overestimated variance causes over-smoothing and detail loss. Output ranges approach input ranges; examine difference images (original - filtered) to verify noise reduction. Peak Signal-to-Noise Ratio (PSNR) and Structural Similarity Index (SSIM) quantify filtering effectiveness. Local variance thresholds indicate processing impact: regions with detected variance ratio > 5 filter substantially; ratios < 1 filter minimally. Common pitfalls include inaccurate noise variance estimation (conduct dark-frame or homogeneous-region analysis for estimation) and window-size selection affecting localization. Apply before classification or feature extraction to reduce noise-driven category misclassification.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$wiener_filter(...)
}

wilcoxon_signed_rank_test <- function(...) {
  # Performs a Wilcoxon signed-rank test on paired raster differences.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$wilcoxon_signed_rank_test(...)
}

wbw_wilcoxon_signed_rank_test <- function(...) {
  # Performs a Wilcoxon signed-rank test on paired raster differences.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$wilcoxon_signed_rank_test(...)
}

wisart_iterative_clustering <- function(...) {
  # Wishart iterative clustering performs unsupervised classification of SAR polarimetric data by iteratively refining cluster centers using the complex Wishart statistical distance metric, which measures similarity in multivariate polarimetric probability distributions. The algorithm initializes from H/α decomposition zones (providing 9 seed clusters with known physical interpretation), then enters an expectation-maximization-like loop: (1) compute Wishart distance from each pixel's estimated coherency matrix to each cluster prototype; (2) reassign pixels to closest cluster; (3) update cluster prototypes by averaging assigned pixel matrices; (4) iterate until convergence (pixel reassignment rate <convergence_threshold) or max_iterations reached. Key features include complex-valued statistical framework properly handling polarimetric data structure unlike Euclidean distance; automatic initialization from interpretable H/α zones reducing dependency on random seeds; per-pixel convergence monitoring enabling adaptive iteration targeting; optional input of pre-computed (H,α) or automatic matrix computation from raw coherency inputs; and built-in robustness to single-look speckle through multi-look processing compatibility. The tool supports both conventional and compact matrix formats. Primary use cases encompass SAR polarimetric image classification producing refined land cover maps beyond H/α 9-zone partition, iterative refinement of initial unsupervised classification for cartography, automated polarimetric data quality assessment through cluster stability metrics, and time-series SAR classification enabling temporal change detection via cluster transition analysis. Output interpretation: Refined cluster map (typically 3-9 classes depending on convergence) showing well-separated scattering mechanism groups. Convergence history provides confidence metric—rapid early convergence indicates stable class separation; slow convergence suggests ambiguous pixels benefiting from multi-view or change detection analysis. Integration with H/α zones enables legend development: maintain H/α zone correspondence where possible to preserve interpretability.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$wisart_iterative_clustering(...)
}

wbw_wisart_iterative_clustering <- function(...) {
  # Wishart iterative clustering performs unsupervised classification of SAR polarimetric data by iteratively refining cluster centers using the complex Wishart statistical distance metric, which measures similarity in multivariate polarimetric probability distributions. The algorithm initializes from H/α decomposition zones (providing 9 seed clusters with known physical interpretation), then enters an expectation-maximization-like loop: (1) compute Wishart distance from each pixel's estimated coherency matrix to each cluster prototype; (2) reassign pixels to closest cluster; (3) update cluster prototypes by averaging assigned pixel matrices; (4) iterate until convergence (pixel reassignment rate <convergence_threshold) or max_iterations reached. Key features include complex-valued statistical framework properly handling polarimetric data structure unlike Euclidean distance; automatic initialization from interpretable H/α zones reducing dependency on random seeds; per-pixel convergence monitoring enabling adaptive iteration targeting; optional input of pre-computed (H,α) or automatic matrix computation from raw coherency inputs; and built-in robustness to single-look speckle through multi-look processing compatibility. The tool supports both conventional and compact matrix formats. Primary use cases encompass SAR polarimetric image classification producing refined land cover maps beyond H/α 9-zone partition, iterative refinement of initial unsupervised classification for cartography, automated polarimetric data quality assessment through cluster stability metrics, and time-series SAR classification enabling temporal change detection via cluster transition analysis. Output interpretation: Refined cluster map (typically 3-9 classes depending on convergence) showing well-separated scattering mechanism groups. Convergence history provides confidence metric—rapid early convergence indicates stable class separation; slow convergence suggests ambiguous pixels benefiting from multi-view or change detection analysis. Integration with H/α zones enables legend development: maintain H/α zone correspondence where possible to preserve interpretability.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$wisart_iterative_clustering(...)
}

write_function_memory_insertion <- function(...) {
  # Creates a packed RGB change-visualization composite from two or three single-band dates.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$write_function_memory_insertion(...)
}

wbw_write_function_memory_insertion <- function(...) {
  # Creates a packed RGB change-visualization composite from two or three single-band dates.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$write_function_memory_insertion(...)
}

yamaguchi_4component_decomposition <- function(...) {
  # Yamaguchi 4-component SAR decomposition decomposes dual-polarization synthetic aperture radar data into physically interpretable components representing surface scattering, double-bounce (volume) scattering, helix scattering, and volume scattering using model-based polarimetric analysis with optional DEM incorporation. The decomposition separates different backscattering mechanisms through eigenvalue analysis of polarimetric covariance matrices, interpreting components as surface reflection (Bragg scattering), double-bounce reflection from corner reflectors, helical polarization rotation (uncommon), and diffuse volume scattering from vegetation or rough surface. Incorporation of external DEM estimates topographic scattering contribution enabling improved discrimination of true volume scattering from topographic effects. Key features include model-based physical interpretation enabling meaningful geophysical parameter extraction, optional DEM-based topographic correction improving component accuracy over terrain, non-negative component constraints preventing unphysical decomposition results, and automatic handling of data gaps and layover regions. Applications include forest biomass estimation from volume scattering component, urban mapping exploiting double-bounce dominance in built areas, soil moisture estimation from surface scattering behavior, and landslide/change detection through component ratio changes. Yamaguchi decomposition output enables geophysical interpretation. Output comprises four-component imagery (surface, double-bounce, helix, volume scattering power), decomposition quality metrics quantifying fit accuracy, mean scattering type indices facilitating land cover characterization, and optional coherency/entropy diagnostics guiding data quality assessment.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$yamaguchi_4component_decomposition(...)
}

wbw_yamaguchi_4component_decomposition <- function(...) {
  # Yamaguchi 4-component SAR decomposition decomposes dual-polarization synthetic aperture radar data into physically interpretable components representing surface scattering, double-bounce (volume) scattering, helix scattering, and volume scattering using model-based polarimetric analysis with optional DEM incorporation. The decomposition separates different backscattering mechanisms through eigenvalue analysis of polarimetric covariance matrices, interpreting components as surface reflection (Bragg scattering), double-bounce reflection from corner reflectors, helical polarization rotation (uncommon), and diffuse volume scattering from vegetation or rough surface. Incorporation of external DEM estimates topographic scattering contribution enabling improved discrimination of true volume scattering from topographic effects. Key features include model-based physical interpretation enabling meaningful geophysical parameter extraction, optional DEM-based topographic correction improving component accuracy over terrain, non-negative component constraints preventing unphysical decomposition results, and automatic handling of data gaps and layover regions. Applications include forest biomass estimation from volume scattering component, urban mapping exploiting double-bounce dominance in built areas, soil moisture estimation from surface scattering behavior, and landslide/change detection through component ratio changes. Yamaguchi decomposition output enables geophysical interpretation. Output comprises four-component imagery (surface, double-bounce, helix, volume scattering power), decomposition quality metrics quantifying fit accuracy, mean scattering type indices facilitating land cover characterization, and optional coherency/entropy diagnostics guiding data quality assessment.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$yamaguchi_4component_decomposition(...)
}

z_scores <- function(...) {
  # Standardizes raster values to z-scores using global mean and standard deviation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$z_scores(...)
}

wbw_z_scores <- function(...) {
  # Standardizes raster values to z-scores using global mean and standard deviation.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$z_scores(...)
}

zonal_statistics <- function(...) {
  # Summarises the values of a data raster within zones defined by a feature raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$zonal_statistics(...)
}

wbw_zonal_statistics <- function(...) {
  # Summarises the values of a data raster within zones defined by a feature raster.
  session <- wbw_make_session(include_pro = FALSE, tier = "open")
  session$zonal_statistics(...)
}

