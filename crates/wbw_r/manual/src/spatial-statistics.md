# Spatial Statistics and Geostatistics

Spatial statistics and geostatistics form the quantitative foundation for understanding geographic patterns, relationships, and uncertainty in R. This chapter covers methods for detecting spatial autocorrelation, analyzing point patterns, modeling spatial relationships through regression, and predicting values at unsampled locations using kriging. These tools answer critical GIS questions: *Are phenomena clustered or dispersed? Is there spatial dependence in my data? How can I interpolate values with quantified uncertainty?*

---

## Core Concepts

Before working with spatial statistics, understand these foundational terms:

- **Spatial autocorrelation**: The degree to which observations at nearby locations resemble each other. Positive autocorrelation means nearby values are similar; negative means they differ; zero means spatial independence. Most real-world geographic data exhibit positive autocorrelation.
- **Moran's I**: Global measure of spatial autocorrelation ranging from -1 (perfect negative) to +1 (perfect positive). Statistical tests determine whether observed I differs significantly from zero (random spatial arrangement).
- **LISA (Local Indicators of Spatial Association)**: Local versions of Moran's I and Getis-Ord Gi* that identify hot spots (high-high clusters), cold spots (low-low), and spatial outliers (high-low, low-high).
- **Hot spot**: Statistically significant cluster of high values. Cold spot: cluster of low values. Spatial outlier: anomalously high or low value surrounded by opposite values.
- **Point pattern**: Distribution of point events across a study area. Patterns can be clustered (aggregated), dispersed (regular/uniform), or random. Distinguishing between them requires statistical tests.
- **Ripley's K function**: Cumulative measure of clustering intensity across distance scales. Deviations from expected random values indicate clustering or dispersion.
- **Spatial regression**: Statistical models that incorporate spatial dependence. SAR (Spatial AutoRegressive) models include lagged dependent variables; SEM (Spatial Error Model) models incorporate spatial correlation in residuals; GWR (Geographically Weighted Regression) estimates parameters locally, allowing relationships to vary across space.
- **Variogram**: Describes how variance in a spatial field increases with distance. Essential for kriging parameter estimation; plot shape reveals range (distance beyond which values become independent) and nugget (variance at zero distance, often due to measurement error).
- **Kriging**: Spatial interpolation method that minimizes prediction variance. Ordinary kriging estimates both value and prediction uncertainty at unsampled locations. Universal kriging includes drift (polynomial trend).
- **Prediction variance / uncertainty**: Kriging variance reflects model confidence in predictions. High variance at sparse-data locations; low variance near data points. Always examine variance maps alongside predictions.

---

## Session Setup

```r
library(whiteboxworkflows)

# Create session (analogous to WbEnvironment in Python)
s <- wbw_session()

# Set working directory
wbw_set_working_directory('/data/spatial_stats', session = s)

# Optional: enable verbose output for progress tracking
wbw_set_verbose(TRUE, session = s)
```

---

## Autocorrelation Analysis: Detecting Spatial Structure

### Global Moran's I: Is My Data Spatially Autocorrelated?

Global Moran's I tests whether observations are randomly distributed or exhibit spatial structure. A significant positive I indicates clustering; negative indicates alternating patterns.

```r
# Read point features with a measurement attribute
stations <- wbw_read_vector('weather_stations.gpkg', session = s)

# Calculate global Moran's I using the 'temperature' attribute
# Uses a queen contiguity weight matrix (8-neighbour)
result <- wbw_global_morans_i(
  input = 'weather_stations.gpkg',
  field = 'temperature',
  session = s
)

# View results
cat('Morans I:', result$morans_i, '\n')
cat('p-value:', result$p_value, '\n')
```

The output file contains:
- **Moran's I**: The autocorrelation index
- **Expected value**: I under random permutation hypothesis (typically near zero)
- **Variance**: Variance of I under randomization
- **p-value**: Probability that observed I arose by chance
- **Interpretation**: p < 0.05 indicates significant spatial structure

**Practical guidance:**
- If p < 0.05 and I > 0, data are significantly clustered. Validate with LISA to locate hot/cold spots.
- If p > 0.05, spatial structure is not statistically significant; patterns may be random. Still use LISA to visually explore.
- Moran's I is sensitive to boundary effects; ensure your study area includes all meaningful neighbors.

---

### Local Moran's I (LISA): Where Are the Clusters?

Local Moran's I decomposes global autocorrelation into contributions from each location, revealing hot spots, cold spots, and spatial outliers. Results are typically visualized as a categorical map.

```r
# Vector version: produces output with cluster classifications
result <- wbw_local_morans_i_lisa(
  input = 'weather_stations.gpkg',
  field = 'temperature',
  output = 'lisa_clusters.gpkg',
  session = s
)

# Raster version: accepts gridded data (e.g., DEM or classification raster)
result <- wbw_local_morans_i_lisa_raster(
  input = 'temperature_grid.tif',
  output = 'lisa_raster.tif',
  session = s
)

# Read results for inspection
lisa_output <- wbw_read_vector('lisa_clusters.gpkg', session = s)
```

**LISA classification:**
- **Cluster-High (Hot Spot)**: High values surrounded by high values (HH)
- **Cluster-Low (Cold Spot)**: Low values surrounded by low values (LL)
- **Outlier-High**: High value surrounded by low values (HL)
- **Outlier-Low**: Low value surrounded by high values (LH)
- **No significant cluster**: Location does not have statistically significant local autocorrelation (p ≥ 0.05)

**Workflow: Identifying Disease Clusters**

```r
library(whiteboxworkflows)

s <- wbw_session()
wbw_set_working_directory('/data/disease_surveillance', session = s)

# Read confirmed cases by health district
cases <- wbw_read_vector('disease_cases.gpkg', session = s)

# Run LISA on case count field
wbw_local_morans_i_lisa(
  input = 'disease_cases.gpkg',
  field = 'case_count',
  output = 'disease_hotspots.gpkg',
  session = s
)

# Load results and filter to significant clusters
hotspots <- wbw_read_vector('disease_hotspots.gpkg', session = s)

# Identify HH (high-case clusters) for intervention planning
# The cluster classification field typically contains: 'Cluster-High', 'Cluster-Low', etc.
hh_clusters <- hotspots[hotspots$cluster_class == 'Cluster-High', ]

cat('Identified', nrow(hh_clusters), 'high-case cluster zones\n')
```

---

### Getis-Ord Gi*: Hot Spot Analysis with Distance Decay

Getis-Ord Gi* is a z-score-based hot spot detector. Unlike LISA, Gi* includes the focal location itself and is directly interpretable as a z-score (standard deviations from the mean under null hypothesis of spatial randomness).

```r
# Vector version
result <- wbw_getis_ord_gi_star(
  input = 'crime_incidents.gpkg',
  field = 'incident_count',
  session = s
)

# Raster version
result <- wbw_getis_ord_gi_star_raster(
  input = 'pollution_concentration.tif',
  output = 'hotspots_raster.tif',
  session = s
)
```

**Interpretation:**
- **Gi* > 1.96**: Hot spot (high values, statistically significant at 95% confidence)
- **Gi* < -1.96**: Cold spot (low values, significant)
- **-1.96 ≤ Gi* ≤ 1.96**: No significant clustering

**Advantage over LISA:** Gi* produces continuous z-scores ideal for mapping risk or intensity gradients. LISA produces discrete categories.

---

## Point Pattern Analysis: Clustering vs. Dispersion

### Nearest Neighbour Index: Overall Clustering Test

The Nearest Neighbour Index (NNI) compares mean nearest-neighbour distances in observed data to expected distances under complete spatial randomness (CSR).

$$\text{NNI} = \frac{\text{Observed Mean Distance}}{\text{Expected Mean Distance}}$$

- **NNI ≈ 1**: Pattern consistent with CSR (random)
- **NNI < 1**: Clustering (points closer than random expectation)
- **NNI > 1**: Dispersion (points farther apart than random)

```r
# Calculate nearest neighbour index for point pattern
result <- wbw_nearest_neighbour_index(
  input = 'earthquake_epicenters.gpkg',
  session = s
)

# Extract statistics
cat('NNI:', result$nni_value, '\n')
cat('z-score:', result$z_score, '\n')
cat('p-value:', result$p_value, '\n')
```

**Workflow: Analyzing Wildfire Clustering**

```r
s <- wbw_session()
wbw_set_working_directory('/data/wildfire', session = s)

# Load fire event points
fires <- wbw_read_vector('wildfire_points.gpkg', session = s)

# Test if fires cluster or disperse
nni_result <- wbw_nearest_neighbour_index(
  input = 'wildfire_points.gpkg',
  session = s
)

# If NNI significantly < 1, fires cluster → investigate common conditions
if (nni_result$p_value < 0.05 && nni_result$nni_value < 1) {
  cat('Fire clustering detected (p =', nni_result$p_value, ')\n')
  cat('Investigate drought, fuel loads, and ignition source patterns\n')
} else if (nni_result$nni_value > 1) {
  cat('Fire dispersion detected: likely independent ignition sources\n')
}
```

---

### Ripley's K Function: Clustering Across Multiple Scales

While NNI gives a single summary statistic, Ripley's K examines clustering intensity across a range of distance scales. This reveals whether clustering is local (fine-scale) or regional (broad-scale).

```r
# Compute Ripley's K at multiple distance thresholds
result <- wbw_ripleys_k(
  input = 'plant_locations.gpkg',
  session = s
)

# Output: K(d) values at regularly spaced distance intervals
# Also includes L(d) = sqrt(K(d)/π) - d for easier interpretation
```

**Interpretation of K(d):**
- **K(d) > πd²**: Clustering at distance d
- **K(d) ≈ πd²**: Random pattern
- **K(d) < πd²**: Dispersion at distance d

**Advanced: Envelope Test**

Determine confidence bands around expected K under CSR through Monte Carlo simulation:

```r
# Generate confidence envelope through permutation testing
result <- wbw_envelope_test(
  input = 'seedling_locations.gpkg',
  session = s
)

# Compares observed K(d) to envelope of null K(d) from random simulations
# Reveals at which scales clustering is statistically significant
```

---

### Quadrat Count Test: Grid-Based Pattern Analysis

Divide study area into grid cells (quadrats), count points in each cell, and test whether counts follow a Poisson distribution (expected under CSR).

```r
# Specify quadrat size (e.g., 1000 m × 1000 m)
result <- wbw_quadrat_count_test(
  input = 'tree_locations.gpkg',
  cell_size = 1000,
  session = s
)

# Extract statistics
cat('Chi-squared:', result$chi_squared, '\n')
cat('p-value:', result$p_value, '\n')
cat('Dispersion Index:', result$dispersion_index, '\n')
# If > 1: clustering; if ≈ 1: random; if < 1: dispersion
```

**When to use:** Grid-based methods work well for ecological point surveys and disease surveillance data that align naturally with administrative or survey grids.

---

## Spatial Regression: Modeling Spatial Dependence

### Spatial Lag Autoregression (SAR)

SAR includes a spatially lagged dependent variable, capturing spatial spillover effects.

```r
# Spatial Lag Regression on vector features
result <- wbw_spatial_lag_regression(
  input = 'property_values.gpkg',
  dependent_variable = 'price',
  independent_variables = c('sqft', 'age', 'bedrooms'),
  session = s
)

# Output: Regression coefficients, spatial lag coefficient, diagnostics

# Raster version: for gridded continuous fields
result <- wbw_spatial_lag_regression_raster(
  input = 'soil_ph_map.tif',
  dependent_field = 'ph',
  independent_field = c('elevation', 'slope'),
  session = s
)
```

**Interpretation:**
- **ρ (rho) coefficient**: Strength of spatial spillover. Significant ρ indicates neighboring values influence focal location.
- **β coefficients**: Partial effects of independent variables, controlling for spatial dependence.
- **Moran's I of residuals**: Should be near zero; if significant, model missed spatial structure.

**Workflow: House Price Spillover Effects**

```r
s <- wbw_session()
wbw_set_working_directory('/data/real_estate', session = s)

# Read properties with structural attributes and prices
properties <- wbw_read_vector('properties_with_prices.gpkg', session = s)

# Model prices accounting for spatial spillover (neighborhood effects)
result <- wbw_spatial_lag_regression(
  input = 'properties_with_prices.gpkg',
  dependent_variable = 'sale_price',
  independent_variables = c('living_area', 'lot_size', 'year_built'),
  session = s
)

# Extract coefficients
coeffs <- result$coefficients
rho <- coeffs['rho', 'coefficient']

if (rho > 0 && result$p_values['rho', 'p_value'] < 0.05) {
  cat('Significant positive spillover (ρ =', rho, ')\n')
  cat('High-value properties increase surrounding property values\n')
}
```

---

### Spatial Error Model (SEM)

SEM assumes spatial correlation in residuals rather than in the dependent variable.

```r
result <- wbw_spatial_error_regression(
  input = 'crop_yield.gpkg',
  dependent_variable = 'yield_kg_ha',
  independent_variables = c('nitrogen_applied', 'rainfall', 'temperature'),
  session = s
)

# Output: Coefficients, lambda (spatial error lag), diagnostics
```

**When to use SAR vs. SEM:**
- **SAR**: Theory suggests spillover effects (price contagion, disease transmission)
- **SEM**: Spatial pattern suggests omitted variables or measurement issues

---

### Geographically Weighted Regression (GWR)

GWR estimates regression parameters locally, allowing relationships to vary spatially.

```r
# Vector version
result <- wbw_geographically_weighted_regression(
  input = 'school_performance.gpkg',
  dependent_variable = 'graduation_rate',
  independent_variables = c('student_poverty_rate', 'teacher_experience'),
  kernel_type = 'adaptive',  # or 'fixed'
  session = s
)

# Raster version
result <- wbw_geographically_weighted_regression_raster(
  input = 'crop_response.tif',
  dependent_field = 'yield',
  independent_fields = c('rainfall', 'temperature'),
  session = s
)
```

**Output:** For each location, GWR produces:
- Local regression coefficients (how relationships vary by location)
- Local R² values (model fit quality varies spatially)
- Standard errors (parameter uncertainty)

**Workflow: Regional Climate-Vegetation Relationships**

```r
s <- wbw_session()
wbw_set_working_directory('/data/climate_vegetation', session = s)

# Vegetation greenness (NDVI) and climate predictors across continents
observations <- wbw_read_vector('ndvi_climate_observations.gpkg', session = s)

# Standard regression assumes uniform temperature-vegetation relationship globally
# GWR reveals that relationship strength varies by latitude/longitude

result <- wbw_geographically_weighted_regression(
  input = 'ndvi_climate_observations.gpkg',
  dependent_variable = 'ndvi',
  independent_variables = c('temperature', 'precipitation'),
  session = s
)

# Inspect local coefficients: tropical vs. temperate regions show different sensitivities
local_coeff <- result$local_coefficients
cat('Temperature coefficient range:', 
    min(local_coeff$temperature), 'to', max(local_coeff$temperature), '\n')
```

---

## Geostatistics and Kriging: Spatial Interpolation with Uncertainty

### Variogram Estimation: Quantifying Spatial Correlation

The variogram describes how data variance increases with distance. Essential for all kriging methods.

```r
# Compute empirical variogram from point measurements
result <- wbw_estimate_variogram(
  input = 'water_quality_samples.gpkg',
  field = 'dissolved_oxygen',
  lag_size = 500,      # distance interval (m)
  num_lags = 15,       # number of distance bins
  session = s
)

# Output: Variogram values at each lag distance
# Plot the variogram to assess range and nugget
```

**Variogram interpretation:**
- **Nugget**: Variance at distance 0 (due to measurement error or microscale variation)
- **Sill**: Maximum variance (asymptotic level)
- **Range**: Distance beyond which values are uncorrelated

---

### Fitting Variogram Models

Estimate model parameters from empirical variogram:

```r
# Fit spherical variogram model
result <- wbw_fit_variogram(
  input = 'water_quality_samples.gpkg',
  field = 'dissolved_oxygen',
  model = 'spherical',  # or 'exponential', 'gaussian'
  initial_lag = 500,
  num_lags = 15,
  session = s
)

# Output: Fitted model parameters
# - Nugget (c0), Partial sill (c), Range (a)
```

---

### Ordinary Kriging: Grid Prediction with Uncertainty

Ordinary kriging produces optimal linear predictions at unmeasured locations plus associated prediction variance.

```r
# Predict air temperature on a 500 m grid
result <- wbw_ordinary_kriging(
  input = 'weather_stations.gpkg',
  field = 'temperature',
  cell_size = 500,
  base_raster = 'dem.tif',  # optional: inherit extent/CRS
  session = s
)

# Output: prediction raster and variance raster
```

**Workflow: Air Temperature Interpolation for Climate Modeling**

```r
library(whiteboxworkflows)

s <- wbw_session()
wbw_set_working_directory('/data/climate', session = s)

# Weather station observations
stations <- wbw_read_vector('weather_network.gpkg', session = s)

# Estimate variogram structure
wbw_estimate_variogram(
  input = 'weather_network.gpkg',
  field = 'temperature',
  lag_size = 1000,
  num_lags = 20,
  session = s
)

# Fit spherical model
wbw_fit_variogram(
  input = 'weather_network.gpkg',
  field = 'temperature',
  model = 'spherical',
  session = s
)

# Krige predictions on national 1 km grid
wbw_ordinary_kriging(
  input = 'weather_network.gpkg',
  field = 'temperature',
  cell_size = 1000,
  session = s
)

# Inspect variance: low near stations, high in remote areas
```

---

### Local Ordinary Kriging: Moving-Window Interpolation

For large datasets, compute kriging parameters using only nearby data (moving window) to improve efficiency and capture non-stationary structure.

```r
# Krige using local 100 nearest neighbours within 20 km search radius
result <- wbw_local_kriging(
  input = 'soil_samples.gpkg',
  field = 'heavy_metal_concentration',
  cell_size = 100,
  search_radius = 20000,
  num_points = 100,
  session = s
)

# Output: Prediction and variance grids
# Non-stationary: kriging parameters adapt locally
```

---

### Simple Kriging: Known Global Mean

If the global mean is known, simple kriging can reduce prediction variance:

```r
result <- wbw_simple_kriging(
  input = 'ecosystem_productivity.gpkg',
  field = 'gpp_moles_co2_m2_s',
  mean = 8.5,  # known from prior surveys
  session = s
)
```

---

### Universal Kriging: Drift Modeling

Universal kriging estimates and removes polynomial trend before kriging residuals.

```r
# Model elevation trend (captures topographic slope and curvature)
result <- wbw_universal_kriging(
  input = 'rainfall_stations.gpkg',
  field = 'annual_rainfall',
  drift_order = 1,  # 0=mean, 1=linear trend, 2=quadratic
  session = s
)

# Output: Trend surface + residual kriging
```

**Workflow: Rainfall Interpolation with Elevation Trend**

```r
s <- wbw_session()
wbw_set_working_directory('/data/hydrology', session = s)

# Rainfall observations with elevation
stations <- wbw_read_vector('rainfall_stations.gpkg', session = s)

# Rainfall typically increases with elevation.
# Universal kriging decomposes: trend + residuals

result <- wbw_universal_kriging(
  input = 'rainfall_stations.gpkg',
  field = 'mean_annual_precip',
  drift_order = 1,
  cell_size = 1000,
  session = s
)

# Output: prediction and variance rasters accounting for trend
```

---

### Space-Time Kriging: Dynamic Interpolation

For spatio-temporal data (satellite time series, weather time series), model correlation across space and time:

```r
# Interpolate SST across ocean and time steps
result <- wbw_space_time_kriging(
  input = 'sst_observations.gpkg',
  space_field = 'geometry',         # location column
  time_field = 'date',              # time column
  value_field = 'temperature',
  cell_size = 10000,                # spatial grid (m)
  temporal_resolution = 86400,      # temporal resolution (seconds)
  session = s
)
```

---

## Diagnostic and Validation Tools

### Kriging Cross-Validation

Leave-one-out cross-validation assesses kriging model reliability:

```r
# Evaluate ordinary kriging model
result <- wbw_kriging_cross_validation(
  input = 'soil_ph_samples.gpkg',
  field = 'ph',
  model = 'ordinary',
  session = s
)

# Output: Residuals, standardized residuals, RMSE, MAE, correlation
```

**Interpretation:**
- **Standardized residuals near ±1**: Model confidence is well-calibrated
- **Standardized residuals >> 1**: Model underestimates variance
- **RMSE smaller than raw data std dev**: Model has predictive skill

---

### Inhomogeneous Poisson Process: Intensity Estimation

Estimate point intensity as a function of covariates:

```r
# Model tree location intensity as function of elevation and slope
result <- wbw_inhomogeneous_intensity(
  input = 'tree_observations.gpkg',
  covariate_rasters = c('elevation.tif', 'slope.tif'),
  output = 'tree_intensity.tif',
  session = s
)

# Output: Local intensity (expected tree density per unit area)
```

---

### Advanced: Point Process Residuals

Extract model residuals to diagnose model adequacy:

```r
# Extract residuals for inspection
result <- wbw_point_process_residuals(
  input = 'species_occurrence.gpkg',
  baseline_intensity = 'habitat_suitability.tif',
  session = s
)

# Compare to expected pattern under null model
# Clustering of residuals indicates unmodeled spatial structure
```

---

### Hotspot vs. Process Comparison

Distinguish between data clustering and underlying process intensity:

```r
result <- wbw_hotspot_vs_process(
  input = 'disease_cases.gpkg',
  intensity_raster = 'population_density.tif',
  session = s
)

# Reveals whether clustering is due to sampling bias or true heterogeneity
```

---

## Real-World Integrated Workflows

### Workflow 1: Epidemiological Cluster Detection

**Objective:** Identify statistically significant disease clusters for outbreak investigation.

```r
library(whiteboxworkflows)

s <- wbw_session()
wbw_set_working_directory('/data/epidemiology', session = s)
wbw_set_verbose(TRUE, session = s)

# Load case-level data
cases <- wbw_read_vector('covid_cases.gpkg', session = s)

# Step 1: Global test — is clustering significant?
global_result <- wbw_global_morans_i(
  input = 'covid_cases.gpkg',
  field = 'case_count',
  session = s
)

if (global_result$p_value < 0.05) {
  cat('Significant clustering detected (p =', global_result$p_value, ')\n')
  
  # Step 2: Identify clusters
  lisa_result <- wbw_local_morans_i_lisa(
    input = 'covid_cases.gpkg',
    field = 'case_count',
    output = 'covid_clusters.gpkg',
    session = s
  )
  
  # Step 3: Load and analyze
  clusters <- wbw_read_vector('covid_clusters.gpkg', session = s)
  
  # Export for mapping and investigation
  wbw_write_vector(clusters, 'significant_hotspots.gpkg', session = s)
}
```

---

### Workflow 2: Soil Variability Mapping with Kriging

**Objective:** Create interpolated soil fertility map with prediction uncertainty.

```r
library(whiteboxworkflows)

s <- wbw_session()
wbw_set_working_directory('/data/soil_survey', session = s)

# Soil sample locations and measurements
samples <- wbw_read_vector('soil_samples.gpkg', session = s)

# Step 1: Estimate variogram structure
wbw_estimate_variogram(
  input = 'soil_samples.gpkg',
  field = 'available_phosphorus_ppm',
  lag_size = 500,
  num_lags = 20,
  session = s
)

# Step 2: Fit variogram model
wbw_fit_variogram(
  input = 'soil_samples.gpkg',
  field = 'available_phosphorus_ppm',
  model = 'spherical',
  session = s
)

# Step 3: Krige predictions on 100 m grid
wbw_ordinary_kriging(
  input = 'soil_samples.gpkg',
  field = 'available_phosphorus_ppm',
  cell_size = 100,
  base_raster = 'field_boundary.tif',
  session = s
)

# Step 4: Cross-validate
wbw_kriging_cross_validation(
  input = 'soil_samples.gpkg',
  field = 'available_phosphorus_ppm',
  model = 'ordinary',
  session = s
)

# Output: prediction and variance rasters for precision agriculture
```

---

### Workflow 3: Urban Heat Island Analysis with GWR

**Objective:** Understand how urban form drives temperature variation.

```r
library(whiteboxworkflows)

s <- wbw_session()
wbw_set_working_directory('/data/urban_climate', session = s)

# Temperature observations with urban predictors
observations <- wbw_read_vector('temperature_obs_with_predictors.gpkg', session = s)

# Step 1: Test for spatial autocorrelation
wbw_global_morans_i(
  input = 'temperature_obs_with_predictors.gpkg',
  field = 'air_temp_c',
  session = s
)

# Step 2: GWR to assess spatial non-stationarity
result <- wbw_geographically_weighted_regression(
  input = 'temperature_obs_with_predictors.gpkg',
  dependent_variable = 'air_temp_c',
  independent_variables = c('building_density', 'tree_canopy_pct'),
  kernel_type = 'adaptive',
  session = s
)

# Maps of local coefficients reveal UHI driver strength by location
```

---

### Workflow 4: Climate Change Detection with Space-Time Kriging

**Objective:** Interpolate temperature time series to detect regional warming trends.

```r
library(whiteboxworkflows)

s <- wbw_session()
wbw_set_working_directory('/data/climate_change', session = s)

# Monthly temperature time series from stations (30 years)
# Attributes: date (monthly), geometry, temperature_c
temp_ts <- wbw_read_vector('temp_monthly_1990_2020.gpkg', session = s)

# Space-time kriging
result <- wbw_space_time_kriging(
  input = 'temp_monthly_1990_2020.gpkg',
  space_field = 'geometry',
  time_field = 'date',
  value_field = 'temperature_c',
  cell_size = 50000,              # 50 km grid
  temporal_resolution = 2592000,  # 30 days
  session = s
)

# Output: Monthly temperature grids for entire region
# Use for trend analysis or climate impact assessment
```

---

## Best Practices and Troubleshooting

### Weight Matrix Construction
- **Queen contiguity**: 8 neighbors (includes diagonals). Most common; captures local effects.
- **Rook contiguity**: 4 neighbors (cardinal directions).
- **Distance-based**: All points within fixed radius.

### Choosing Between Methods
- **Global Moran's I → Local LISA**: First test if significant, then locate clusters
- **NNI → Ripley's K → Quadrat test**: NNI summarizes; K reveals scale-dependence
- **SAR vs. SEM vs. GWR**: SAR for spillover, SEM for omitted variables, GWR for non-stationarity

### Variogram Troubleshooting
- **Noisy variogram?** Increase lag size or number of points
- **Doesn't level off?** May indicate trend; use universal kriging
- **Large nugget?** High measurement error; consider kriging simplified model

### Kriging Predictions Outside Data Range
- Kriging predictions bounded by observed data values
- If predictions too smooth, increase neighborhood size
- Always inspect variance map; high variance zones should be viewed skeptically

---

## Summary

Spatial statistics and geostatistics provide rigorous methods for detecting patterns, modeling relationships, and making predictions with quantified uncertainty. Key takeaways:

1. **Start with autocorrelation tests** (Global Moran's I) to determine if data exhibit spatial structure
2. **Locate clusters** with LISA or Getis-Ord Gi* for targeted investigation
3. **Model spatial relationships** with SAR, SEM, or GWR depending on your hypothesis
4. **Interpolate with kriging** when you need both predictions and uncertainty
5. **Validate with cross-validation** and always examine prediction uncertainty maps

Integration with other Whitebox tools enables sophisticated multi-stage workflows combining spatial statistics with domain knowledge for rigorous geographic analysis.
