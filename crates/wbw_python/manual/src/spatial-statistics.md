# Spatial Statistics and Geostatistics

Spatial statistics and geostatistics form the quantitative foundation for understanding geographic patterns, relationships, and uncertainty. This chapter covers methods for detecting spatial autocorrelation, analyzing point patterns, modeling spatial relationships through regression, and predicting values at unsampled locations using kriging. These tools answer critical GIS questions: *Are phenomena clustered or dispersed? Is there spatial dependence in my data? How can I interpolate values with quantified uncertainty?*

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

## Autocorrelation Analysis: Detecting Spatial Structure

### Global Moran's I: Is My Data Spatially Autocorrelated?

Global Moran's I tests whether observations are randomly distributed or exhibit spatial structure. A significant positive I indicates clustering; negative indicates alternating patterns.

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/spatial_stats'

# Read point features with a measurement attribute (e.g., precipitation, elevation, disease rate)
points = wbe.read_vector('weather_stations.gpkg')

# Calculate global Moran's I using the 'temperature' attribute
# Uses a queen contiguity weight matrix (8-neighbour)
result = wbe.gis.spatial_statistics.global_morans_i(
    input='weather_stations.gpkg',
    field='temperature'
)
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

```python
# Vector version: produces output shapefile with cluster classifications
result = wbe.gis.spatial_statistics.local_morans_i_lisa(
    input='weather_stations.gpkg',
    field='temperature',
    output='lisa_clusters.gpkg'
)

# Raster version: accepts gridded data (e.g., DEM or classification raster)
# Produces raster with cluster codes
result = wbe.gis.spatial_statistics.local_morans_i_lisa_raster(
    input='temperature_grid.tif',
    output='lisa_raster.tif'
)
```

**LISA classification:**
- **Cluster-High (Hot Spot)**: High values surrounded by high values (HH)
- **Cluster-Low (Cold Spot)**: Low values surrounded by low values (LL)
- **Outlier-High**: High value surrounded by low values (HL)
- **Outlier-Low**: Low value surrounded by high values (LH)
- **No significant cluster**: Location does not have statistically significant local autocorrelation (p ≥ 0.05)

**Workflow: Identifying Disease Clusters**

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/disease_surveillance'

# Read confirmed cases by health district
cases = wbe.read_vector('disease_cases.gpkg')

# Run LISA on case count field
wbe.gis.spatial_statistics.local_morans_i_lisa(
    input='disease_cases.gpkg',
    field='case_count',
    output='disease_hotspots.gpkg'
)

# Load results and filter to significant clusters
hotspots = wbe.read_vector('disease_hotspots.gpkg')

# Identify HH (high-case clusters) for intervention planning
# Feature classification field typically contains: 'Cluster-High', 'Cluster-Low', etc.
```

---

### Getis-Ord Gi*: Hot Spot Analysis with Distance Decay

Getis-Ord Gi* is a z-score-based hot spot detector. Unlike LISA, Gi* includes the focal location itself and is directly interpretable as a z-score (standard deviations from the mean under null hypothesis of spatial randomness).

```python
# Vector version
result = wbe.gis.spatial_statistics.getis_ord_gi_star(
    input='crime_incidents.gpkg',
    field='incident_count'
)

# Raster version
result = wbe.gis.spatial_statistics.getis_ord_gi_star_raster(
    input='pollution_concentration.tif',
    output='hotspots_raster.tif'
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

```python
# Calculate nearest neighbour index for point pattern
result = wbe.gis.spatial_statistics.nearest_neighbour_index(
    input='earthquake_epicenters.gpkg'
)

# Output includes:
# - NNI value
# - z-score and p-value for statistical significance
# - Observed and expected mean distances
```

**Workflow: Analyzing Wildfire Clustering**

```python
wbe.working_directory = '/data/wildfire'

# Load fire event points
fires = wbe.read_vector('wildfire_points.gpkg')

# Test if fires cluster or disperse
nni_result = wbe.gis.spatial_statistics.nearest_neighbour_index(
    input='wildfire_points.gpkg'
)

# If NNI significantly < 1, fires cluster → investigate common conditions (drought, fuel, ignition)
# If NNI near 1, fires appear random → likely independent ignition sources
```

---

### Ripley's K Function: Clustering Across Multiple Scales

While NNI gives a single summary statistic, Ripley's K examines clustering intensity across a range of distance scales. This reveals whether clustering is local (fine-scale) or regional (broad-scale).

```python
# Compute Ripley's K at multiple distance thresholds
result = wbe.gis.spatial_statistics.ripleys_k(
    input='plant_locations.gpkg'
)

# Output: K(d) values at regularly spaced distance intervals
# Also includes L(d) = sqrt(K(d)/π) - d, which linearizes the plot for easier interpretation
```

**Interpretation of K(d):**
- **K(d) > πd²**: Clustering at distance d (more points within radius d than random expectation)
- **K(d) ≈ πd²**: Random pattern
- **K(d) < πd²**: Dispersion at distance d

**Advanced: Envelope Test**

Determine confidence bands around expected K under CSR by Monte Carlo simulation:

```python
# Generate confidence envelope through permutation testing
result = wbe.gis.spatial_statistics.envelope_test(
    input='seedling_locations.gpkg'
)

# Compares observed K(d) to envelope of null K(d) from random simulations
# Reveals at which scales clustering is statistically significant
```

---

### Quadrat Count Test: Grid-Based Pattern Analysis

Divide study area into grid cells (quadrats), count points in each cell, and test whether counts follow a Poisson distribution (expected under CSR).

```python
# Specify quadrat size (e.g., 1000 m × 1000 m)
result = wbe.gis.spatial_statistics.quadrat_count_test(
    input='tree_locations.gpkg',
    cell_size=1000
)

# Output includes:
# - Chi-squared statistic
# - Degrees of freedom and p-value
# - Variance-to-mean ratio (dispersion index)
#   If > 1: clustering; if ≈ 1: random; if < 1: dispersion
```

**When to use:** Grid-based methods work well for ecological point surveys and disease surveillance data that align naturally with administrative or survey grids.

---

## Spatial Regression: Modeling Spatial Dependence

### Spatial Lag Autoregression (SAR)

SAR includes a spatially lagged dependent variable, capturing spatial spillover effects:

$$y = \rho W y + X \beta + \epsilon$$

where $\rho$ is the spatial lag coefficient, $W$ is the spatial weight matrix, and spillover effects propagate through the network.

```python
# Spatial Lag Regression on vector features
result = wbe.gis.spatial_statistics.spatial_lag_regression(
    input='property_values.gpkg',
    dependent_variable='price',
    independent_variables=['sqft', 'age', 'bedrooms']
)

# Output: Regression coefficients, spatial lag coefficient, diagnostics

# Raster version: for gridded continuous fields
result = wbe.gis.spatial_statistics.spatial_lag_regression_raster(
    input='soil_ph_map.tif',
    dependent_field='ph',
    independent_field=['elevation', 'slope']
)
```

**Interpretation:**
- **ρ (rho) coefficient**: Strength of spatial spillover. Significant ρ indicates neighboring values influence focal location.
- **β coefficients**: Partial effects of independent variables, controlling for spatial dependence.
- **Moran's I of residuals**: Should be near zero; if significant, model missed spatial structure.

**Workflow: House Price Spillover Effects**

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/real_estate'

# Read properties with structural attributes and prices
properties = wbe.read_vector('properties_with_prices.gpkg')

# Model prices accounting for spatial spillover (neighborhood effects)
result = wbe.gis.spatial_statistics.spatial_lag_regression(
    input='properties_with_prices.gpkg',
    dependent_variable='sale_price',
    independent_variables=['living_area', 'lot_size', 'year_built']
)

# Significant positive ρ suggests gentrification or neighborhood effects:
# High-value properties increase surrounding property values
```

---

### Spatial Error Model (SEM)

SEM assumes spatial correlation in residuals rather than in the dependent variable:

$$y = X \beta + u, \quad u = \lambda W u + \epsilon$$

Use SEM when spatial dependence arises from omitted variables or measurement error rather than true spillover.

```python
result = wbe.gis.spatial_statistics.spatial_error_regression(
    input='crop_yield.gpkg',
    dependent_variable='yield_kg_ha',
    independent_variables=['nitrogen_applied', 'rainfall', 'temperature']
)

# Output: Coefficients, lambda (spatial error lag), diagnostics
```

**When to use SAR vs. SEM:**
- **SAR**: Theory suggests spillover effects (price contagion, disease transmission, traffic congestion)
- **SEM**: Spatial pattern suggests omitted variables or measurement issues (unobserved soil heterogeneity, unregistered weather stations)

---

### Geographically Weighted Regression (GWR)

GWR estimates regression parameters locally, allowing relationships to vary spatially. Useful for non-stationary processes where driver-response relationships differ across regions.

```python
# Vector version
result = wbe.gis.spatial_statistics.geographically_weighted_regression(
    input='school_performance.gpkg',
    dependent_variable='graduation_rate',
    independent_variables=['student_poverty_rate', 'teacher_experience'],
    kernel_type='adaptive'  # adaptive or fixed bandwidth
)

# Raster version
result = wbe.gis.spatial_statistics.geographically_weighted_regression_raster(
    input='crop_response.tif',
    dependent_field='yield',
    independent_fields=['rainfall', 'temperature']
)
```

**Output:** For each location, GWR produces:
- Local regression coefficients (how relationships vary by location)
- Local R² values (model fit quality varies spatially)
- Standard errors (parameter uncertainty)

**Workflow: Regional Climate-Vegetation Relationships**

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/climate_vegetation'

# Vegetation greenness (NDVI) and climate predictors across continents
observations = wbe.read_vector('ndvi_climate_observations.gpkg')

# Standard regression assumes uniform temperature-vegetation relationship globally
# GWR reveals that relationship strength varies by latitude/longitude

result = wbe.gis.spatial_statistics.geographically_weighted_regression(
    input='ndvi_climate_observations.gpkg',
    dependent_variable='ndvi',
    independent_variables=['temperature', 'precipitation']
)

# Inspect local coefficients: tropical vs. temperate regions show different sensitivities
```

---

## Geostatistics and Kriging: Spatial Interpolation with Uncertainty

### Variogram Estimation: Quantifying Spatial Correlation

The variogram describes how data variance increases with distance. Essential for all kriging methods.

```python
# Compute empirical variogram from point measurements
result = wbe.gis.spatial_statistics.estimate_variogram(
    input='water_quality_samples.gpkg',
    field='dissolved_oxygen',
    lag_size=500,  # distance interval (m)
    num_lags=15    # number of distance bins
)

# Output: Variogram values at each lag distance
# Plot the variogram to assess range (distance of spatial correlation) and nugget
```

**Variogram interpretation:**
- **Nugget**: Variance at distance 0 (due to measurement error or microscale variation)
- **Sill**: Maximum variance (asymptotic level as distance increases)
- **Range**: Distance beyond which values are uncorrelated

**Common variogram models:**
- **Spherical**: Reaches sill asymptotically; realistic for many spatial fields
- **Exponential**: Slower approach to sill; more gradual correlation decay
- **Gaussian**: Smooth parabolic shape near origin; assumes high smoothness

---

### Fitting Variogram Models

Estimate model parameters (nugget, sill, range) from empirical variogram:

```python
# Fit spherical variogram model
result = wbe.gis.spatial_statistics.fit_variogram(
    input='water_quality_samples.gpkg',
    field='dissolved_oxygen',
    model='spherical',
    initial_lag=500,
    num_lags=15
)

# Output: Fitted model parameters
# - Nugget (c0): measurement error variance
# - Partial sill (c): spatial structure variance
# - Range (a): distance of spatial correlation
```

---

### Ordinary Kriging: Grid Prediction with Uncertainty

Ordinary kriging produces optimal linear predictions at unmeasured locations plus associated prediction variance.

```python
# Predict air temperature on a 500 m grid
result = wbe.gis.spatial_statistics.ordinary_kriging(
    input='weather_stations.gpkg',
    field='temperature',
    cell_size=500,
    base_raster='dem.tif'  # optional: inherit extent/CRS from template
)

# Output: prediction raster and variance raster
```

**Workflow: Air Temperature Interpolation for Climate Modeling**

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/climate'

# Weather station observations
stations = wbe.read_vector('weather_network.gpkg')

# Estimate variogram structure
wbe.gis.spatial_statistics.estimate_variogram(
    input='weather_network.gpkg',
    field='temperature',
    lag_size=1000,
    num_lags=20
)

# Fit spherical model
wbe.gis.spatial_statistics.fit_variogram(
    input='weather_network.gpkg',
    field='temperature',
    model='spherical'
)

# Krige predictions on national 1 km grid
wbe.gis.spatial_statistics.ordinary_kriging(
    input='weather_network.gpkg',
    field='temperature',
    cell_size=1000
)

# Inspect variance map: low variance near stations, high in remote areas
# Use prediction variance for climate model uncertainty quantification
```

---

### Local Ordinary Kriging: Moving-Window Interpolation

For very large datasets, compute kriging parameters using only nearby data (moving window) to improve computational efficiency and capture non-stationary spatial structure.

```python
# Krige using local 100 nearest neighbours within 20 km search radius
result = wbe.gis.spatial_statistics.local_kriging(
    input='soil_samples.gpkg',
    field='heavy_metal_concentration',
    cell_size=100,
    search_radius=20000,
    num_points=100
)

# Output: Prediction and variance grids
# Non-stationary: kriging parameters adapt locally, capturing regional variation
```

---

### Simple Kriging: Known Global Mean

If the global mean is known (e.g., from prior surveys or theory), simple kriging can reduce prediction variance:

```python
result = wbe.gis.spatial_statistics.simple_kriging(
    input='ecosystem_productivity.gpkg',
    field='gpp_moles_co2_m2_s',
    mean=8.5  # known from large-scale eddy covariance network
)
```

**When to use:** Most applicable when global mean is statistically reliable from extensive prior data. Ordinary kriging is safer when uncertain.

---

### Universal Kriging: Drift Modeling

Universal kriging estimates and removes polynomial trend (drift) before kriging residuals. Useful for data with strong directional trends.

```python
# Model elevation with quadratic drift (captures topographic slope and curvature)
result = wbe.gis.spatial_statistics.universal_kriging(
    input='rainfall_stations.gpkg',
    field='annual_rainfall',
    drift_order=1  # 0=mean, 1=linear trend, 2=quadratic
)

# Output: Trend surface + residual kriging
# Total prediction = trend + kriged residuals
```

**Workflow: Rainfall Interpolation with Elevation Trend**

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/hydrology'

# Rainfall observations at weather stations with elevation
stations = wbe.read_vector('rainfall_stations.gpkg')

# Rainfall typically increases with elevation. Universal kriging decomposes this:
# - Linear drift captures elevation effect
# - Residual kriging captures local deviations

result = wbe.gis.spatial_statistics.universal_kriging(
    input='rainfall_stations.gpkg',
    field='mean_annual_precip',
    drift_order=1,
    cell_size=1000
)

# Output prediction and variance rasters account for elevation trend
```

---

### Space-Time Kriging: Dynamic Interpolation

For spatio-temporal data (e.g., satellite time series, weather time series), model correlation across both space and time:

```python
# Interpolate SST (sea surface temperature) across ocean gridpoints and time steps
result = wbe.gis.spatial_statistics.space_time_kriging(
    input='sst_observations.gpkg',
    space_field='geometry',       # location column
    time_field='date',            # time column
    value_field='temperature',
    cell_size=10000,              # spatial grid resolution (m)
    temporal_resolution=86400     # temporal resolution (seconds, e.g., 1 day)
)
```

---

## Diagnostic and Validation Tools

### Kriging Cross-Validation

Leave-one-out cross-validation assesses kriging model reliability by removing each data point, predicting it from remaining data, and comparing prediction to true value.

```python
# Evaluate ordinary kriging model
result = wbe.gis.spatial_statistics.kriging_cross_validation(
    input='soil_ph_samples.gpkg',
    field='ph',
    model='ordinary'
)

# Output:
# - Residuals (true - predicted)
# - Standardized residuals (residual / kriging_std_error)
# - RMSE, MAE, correlation coefficient
```

**Interpretation:**
- **Standardized residuals near ±1**: Model confidence (variance) is well-calibrated
- **Standardized residuals >> 1**: Model underestimates variance (too confident)
- **Standardized residuals << 1**: Model overestimates variance (overly cautious)
- **RMSE vs. observation std dev**: RMSE should be notably smaller than raw data spread, indicating predictive skill

---

### Inhomogeneous Poisson Process: Intensity Estimation

Estimate point intensity (density) as a function of covariates, useful for understanding how environmental factors influence point occurrence.

```python
# Model tree location intensity as function of elevation and slope
result = wbe.gis.spatial_statistics.inhomogeneous_intensity(
    input='tree_observations.gpkg',
    covariate_rasters=['elevation.tif', 'slope.tif'],
    output='tree_intensity.tif'
)

# Output: Local intensity (expected tree density per unit area)
```

---

### Advanced: Point Process Residuals

After fitting a spatial model, examine residuals to diagnose model adequacy:

```python
# Extract model residuals for inspection
result = wbe.gis.spatial_statistics.point_process_residuals(
    input='species_occurrence.gpkg',
    baseline_intensity='habitat_suitability.tif'
)

# Compare residuals to expected pattern under null model
# Clustering of residuals indicates unmodeled spatial structure
```

---

### Hotspot vs. Process Comparison

Distinguish between observed hot spots (data clustering) and clustered underlying process intensity:

```python
result = wbe.gis.spatial_statistics.hotspot_vs_process(
    input='disease_cases.gpkg',
    intensity_raster='population_density.tif'
)

# Reveals whether clustering is due to data aggregation (sampling bias)
# or true underlying process heterogeneity
```

---

## Real-World Integrated Workflows

### Workflow 1: Epidemiological Cluster Detection

**Objective:** Identify statistically significant disease clusters for outbreak investigation.

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/epidemiology'
wbe.verbose = True

# Load case-level data
cases = wbe.read_vector('covid_cases.gpkg')

# Step 1: Global test — is clustering significant overall?
global_result = wbe.gis.spatial_statistics.global_morans_i(
    input='covid_cases.gpkg',
    field='case_count'
)
# If p < 0.05, proceed to local analysis

# Step 2: Identify clusters
lisa_result = wbe.gis.spatial_statistics.local_morans_i_lisa(
    input='covid_cases.gpkg',
    field='case_count',
    output='covid_clusters.gpkg'
)

# Step 3: Load results and filter for high-case clusters
clusters = wbe.read_vector('covid_clusters.gpkg')

# Export cluster layer for mapping and epidemiologic investigation
wbe.write_vector(clusters, 'significant_hotspots.gpkg')
```

**Outputs for decision-making:**
- Hot spot map highlighting regions requiring intervention
- Cluster statistics (how many cases in top 10% clusters?)
- Temporal trends in cluster location (clusters migrating or static?)

---

### Workflow 2: Soil Variability Mapping with Kriging

**Objective:** Create interpolated soil fertility map with prediction uncertainty.

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/soil_survey'

# Soil sample locations and measurements
samples = wbe.read_vector('soil_samples.gpkg')

# Step 1: Estimate variogram structure
wbe.gis.spatial_statistics.estimate_variogram(
    input='soil_samples.gpkg',
    field='available_phosphorus_ppm',
    lag_size=500,
    num_lags=20
)

# Step 2: Fit variogram model (typically spherical for soil properties)
wbe.gis.spatial_statistics.fit_variogram(
    input='soil_samples.gpkg',
    field='available_phosphorus_ppm',
    model='spherical'
)

# Step 3: Krige predictions on 100 m management-unit grid
wbe.gis.spatial_statistics.ordinary_kriging(
    input='soil_samples.gpkg',
    field='available_phosphorus_ppm',
    cell_size=100,
    base_raster='field_boundary.tif'  # Match field extent
)

# Step 4: Cross-validate to assess reliability
wbe.gis.spatial_statistics.kriging_cross_validation(
    input='soil_samples.gpkg',
    field='available_phosphorus_ppm',
    model='ordinary'
)

# Output: prediction and variance rasters for precision agriculture decisions
```

**Decision support:** High-variance zones require more intensive sampling. Use variance map to prioritize investment in dense grids near field boundaries.

---

### Workflow 3: Urban Heat Island Analysis with GWR

**Objective:** Understand how urban form (building density, tree canopy) drives temperature variation.

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/urban_climate'

# Temperature observations and urban predictors (building density, green space)
observations = wbe.read_vector('temperature_obs_with_predictors.gpkg')

# Step 1: Check for spatial autocorrelation
wbe.gis.spatial_statistics.global_morans_i(
    input='temperature_obs_with_predictors.gpkg',
    field='air_temp_c'
)

# Step 2: GWR to assess spatial non-stationarity
result = wbe.gis.spatial_statistics.geographically_weighted_regression(
    input='temperature_obs_with_predictors.gpkg',
    dependent_variable='air_temp_c',
    independent_variables=['building_density', 'tree_canopy_pct'],
    kernel_type='adaptive'
)

# Output: Maps of local coefficients revealing how building density effect
# varies from downtown (strong) to suburban (weak)

# Step 3: Visualize local relationships
# Map building_density coefficient to show UHI driver strength by location
```

---

### Workflow 4: Climate Change Detection with Space-Time Kriging

**Objective:** Interpolate temperature time series to detect regional warming trends.

```python
import whitebox_workflows as wbw

wbe = wbw.WbEnvironment()
wbe.working_directory = '/data/climate_change'

# Monthly temperature time series from weather stations (30 years)
temperature_timeseries = wbe.read_vector('temp_monthly_1990_2020.gpkg')
# Attributes: date (monthly), geometry, temperature_c

# Space-time kriging to produce gridded time series
result = wbe.gis.spatial_statistics.space_time_kriging(
    input='temp_monthly_1990_2020.gpkg',
    space_field='geometry',
    time_field='date',
    value_field='temperature_c',
    cell_size=50000,              # 50 km grid
    temporal_resolution=2592000   # 30 days in seconds
)

# Output: Monthly temperature grids for entire study region
# Use for trend analysis, seasonal decomposition, or climate impact assessment
```

---

## Best Practices and Troubleshooting

### Weight Matrix Construction
- **Queen contiguity**: 8 neighbors (includes diagonals). Most common; captures local effects.
- **Rook contiguity**: 4 neighbors (cardinal directions). Use when diagonal connection is unrealistic.
- **Distance-based**: All points within fixed radius. Appropriate for continuous fields.

### Choosing Between Methods
- **Global Moran's I → Local LISA**: First test if clustering is significant, then locate it
- **NNI → Ripley's K → Quadrat test**: NNI summarizes; K reveals scale-dependence; Quadrat tests specific grid
- **SAR vs. SEM vs. GWR**: SAR for spillover, SEM for omitted variables, GWR for non-stationarity
- **Ordinary vs. Universal Kriging**: Ordinary if no trend; Universal if strong directional trend

### Variogram Troubleshooting
- **Noisy variogram?** Increase lag size or number of points
- **Variogram doesn't level off?** May indicate trend; use universal kriging
- **Nugget too large?** High measurement error; consider measurement improvement or simpler model

### Kriging Predictions Outside Data Range
- Kriging predictions are bounded by observed data values
- If predictions look "too smooth," increase kriging neighborhood or reduce nugget relative to sill
- Always inspect variance map; high variance zones should be viewed skeptically

---

## Summary

Spatial statistics and geostatistics provide rigorous methods for detecting patterns, modeling relationships, and making predictions with quantified uncertainty. Key takeaways:

1. **Start with autocorrelation tests** (Global Moran's I) to determine if data exhibit spatial structure
2. **Locate clusters** with LISA or Getis-Ord Gi* for targeted investigation
3. **Model spatial relationships** with SAR, SEM, or GWR depending on your hypothesis
4. **Interpolate with kriging** when you need both predictions and uncertainty; always validate with cross-validation
5. **Respect the uncertainty**: Maps of kriging variance are as important as prediction maps

Integration with other Whitebox tools (network analysis for distance metrics, raster operations for covariate preparation) enables sophisticated multi-stage workflows combining spatial statistics with domain knowledge.
