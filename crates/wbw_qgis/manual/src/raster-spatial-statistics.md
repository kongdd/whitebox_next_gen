# Raster Spatial Statistics

Raster-based spatial statistics methods in the Whitebox QGIS plugin analyze gridded data to detect patterns, model spatial relationships, and produce interpolated predictions with uncertainty quantification. This section covers kriging methods for spatial interpolation, local regression approaches, and hot spot detection for raster grids.

---

## Core Concepts

- **Kriging**: Spatial interpolation method that minimizes prediction variance. Produces both predicted values and prediction variance (uncertainty) maps. Ordinary kriging estimates with unknown mean; universal kriging includes polynomial drift.
- **Prediction variance**: Kriging variance reflects model confidence. High variance at sparse-data locations; low variance near calibration points. Always examine variance maps alongside predictions.
- **Local Ordinary Kriging**: Moving-window kriging for large datasets. Improves efficiency and captures non-stationary spatial structure by estimating parameters locally using nearby data.
- **Simple Kriging**: Kriging with known global mean, reducing prediction variance when prior information is reliable.
- **Universal Kriging**: Kriging with polynomial drift (trend), appropriate when data exhibit strong directional gradients.
- **Spatial lag regression**: Linear model including spatially lagged dependent variable, capturing spillover effects between grid cells.
- **Spatial error regression**: Linear model with spatial correlation in residuals, appropriate when spatial dependence arises from omitted variables.
- **GWR (Geographically Weighted Regression)**: Local regression estimation allowing parameters to vary spatially. Produces maps of local slopes and intercepts.
- **Local Moran's I**: Local spatial autocorrelation statistic identifying hot spots, cold spots, and spatial outliers in gridded data.
- **Getis-Ord Gi***: Z-score-based hot spot detector for continuous raster data. Directly interpretable as standard deviations from mean under null hypothesis.
- **Inhomogeneous Intensity**: Estimate point density (or raster intensity) as function of environmental covariates, useful for species distribution modeling and risk mapping.

---

## Kriging Methods for Raster Grids

### Ordinary Kriging Interpolation

Ordinary kriging produces optimal linear predictions on a regular grid with prediction uncertainty. Requires point-sampled data (vector input converted to raster output).

**Function name:** `ordinary_kriging`

**In QGIS Plugin:**
1. Load point feature layer with measurement attribute
2. Navigate to **Vector → Spatial Statistics → Ordinary Kriging Interpolation**
3. Specify:
   - Input layer: Point feature file
   - Value field: Attribute to interpolate (e.g., temperature, soil pH)
   - Cell size: Output grid resolution (meters)
   - Base raster (optional): Template to inherit extent/CRS
4. Output: Raster grids for prediction and variance

**Workflow: Temperature Interpolation for Climate Modeling**

1. Load `weather_stations.gpkg` with `temperature` field
2. Run Ordinary Kriging:
   - Input: weather_stations.gpkg
   - Field: temperature
   - Cell size: 1000 m
   - Base raster: dem.tif (optional, inherits extent)
3. Output layers:
   - `ordinary_kriging_interpolation.tif` - predicted temperature grid
   - `ordinary_kriging_variance.tif` - prediction uncertainty grid
4. Inspect variance map: low variance near stations, high in remote areas
5. Use variance for model uncertainty quantification in downstream analyses

**Interpretation:**
- Predictions are weighted averages of nearby observations
- Variance reflects model confidence, not data variability
- Variance increases with distance from data points

---

### Local Kriging

Moving-window kriging using only nearby data. More computationally efficient than global kriging for large datasets. Captures non-stationary spatial structure.

**Function name:** `local_kriging`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Local Kriging**
2. Specify:
   - Input layer: Point feature file with measurement attribute
   - Value field: Attribute to interpolate
   - Cell size: Output grid resolution
   - Search radius: Maximum distance to include neighboring points
   - Number of points: Maximum neighbors to use in local window (e.g., 100)

**Workflow: Soil Contamination Mapping with Large Dataset**

1. Load `soil_samples.gpkg` with `heavy_metal_ppm` field (10,000+ points)
2. Run Local Kriging:
   - Search radius: 20 km
   - Number of points: 100
   - Cell size: 100 m
3. Output: Prediction and variance rasters
4. Use variance to prioritize remediation in high-uncertainty zones
5. Local kriging reveals regional variations in spatial structure

---

### Simple Kriging

Kriging with known global mean, reducing prediction variance when prior information is reliable.

**Function name:** `simple_kriging`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Simple Kriging**
2. Specify:
   - Input layer: Point measurements
   - Value field: Attribute
   - Known mean: Specify global mean (e.g., 8.5 for ecosystem productivity)
   - Cell size: Output resolution

**When to Use:**
- Global mean estimated from large external dataset
- Statistically reliable prior knowledge
- Reduces prediction variance compared to ordinary kriging

---

### Universal Kriging with Drift

Kriging with polynomial trend removal. Useful for data with strong directional gradients (elevation, rainfall).

**Function name:** `universal_kriging`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Universal Kriging**
2. Specify:
   - Input layer: Point measurements
   - Value field: Attribute
   - Drift order:
     - 0 = constant mean (ordinary kriging)
     - 1 = linear trend (captures slope)
     - 2 = quadratic trend (captures curvature)
   - Cell size: Output resolution

**Workflow: Precipitation Interpolation with Elevation Trend**

1. Load `rainfall_stations.gpkg` with `annual_precip_mm` field
2. Many regions show rainfall increase with elevation
3. Run Universal Kriging (drift_order=1):
   - Estimates linear elevation trend
   - Removes trend and krigas residuals
   - Total prediction = trend surface + residual kriging
4. Output: Prediction and variance rasters
5. Result captures both regional gradient and local deviations

**Advantages:**
- Removes systematic trend, improving residual kriging fit
- More accurate than ordinary kriging for trending data
- Variance map reflects uncertainty after trend removal

---

### Space-Time Kriging

Interpolate data with both spatial and temporal dimensions (satellite time series, weather monitoring).

**Function name:** `spacetime_kriging`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Space-Time Kriging**
2. Specify:
   - Input layer: Point measurements with date/time attribute
   - Space field: Geometry column (coordinates)
   - Time field: Date/time attribute
   - Value field: Measurement
   - Cell size: Spatial grid resolution (meters)
   - Temporal resolution: Time step (seconds; e.g., 86400 for daily)

**Example: Sea Surface Temperature (SST) Time Series**

Output: Monthly temperature grids spanning study area and full time range, enabling:
- Climate anomaly detection
- Seasonal pattern analysis
- Trend assessment
- Nowcasting/forecasting validation

---

## Spatial Regression for Rasters

### Spatial Lag Regression (SAR)

Regression including spatially lagged dependent variable, capturing spillover effects between neighboring grid cells.

**Function name:** `spatial_lag_regression_raster`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Spatial Lag Regression (SAR) - Raster Output**
2. Specify:
   - Input raster: Dependent variable grid
   - Independent rasters: Predictor grids (list multiple)
   - Output: Regression coefficient raster

**Workflow: House Price Spillover Effects**

1. Prepare rasters:
   - `price_grid.tif` - median property price per 1 km cell
   - `sqft_grid.tif` - mean living area
   - `age_grid.tif` - mean property age
2. Run SAR:
   - Dependent: price_grid.tif
   - Independent: sqft_grid.tif, age_grid.tif
3. Output includes:
   - Spatial lag coefficient: Strength of neighborhood price effects
   - β coefficients: Partial effects of independent variables
4. Significant positive spatial lag indicates neighborhood spillover

---

### Spatial Error Regression (SEM)

Regression with spatial correlation in residuals (rather than dependent variable).

**Function name:** `spatial_error_regression_raster`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Spatial Error Regression (SEM) - Raster Output**
2. Specify:
   - Input/independent rasters: Same as SAR
3. Interpret λ (lambda): Strength of spatial error correlation

**When to Use:**
- Spatial dependence arises from omitted variables or measurement error
- Hypothesis: Unobserved heterogeneity drives spatial pattern

---

### Geographically Weighted Regression (GWR)

Local regression allowing relationships to vary spatially. Produces maps of local slopes/intercepts.

**Function name:** `geographically_weighted_regression_raster`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Geographically Weighted Regression - Raster Output**
2. Specify:
   - Dependent raster: Outcome variable
   - Independent rasters: Predictors
   - Kernel: adaptive (local bandwidth) or fixed (distance-based)
3. Output: Maps of local coefficients and local R² values

**Workflow: Climate-Vegetation Relationships Across Continents**

1. Prepare data:
   - `ndvi.tif` - vegetation greenness
   - `temperature.tif` - mean temperature
   - `precipitation.tif` - mean annual precipitation
2. Run GWR:
   - Dependent: ndvi.tif
   - Independent: temperature.tif, precipitation.tif
3. Output:
   - `gwr_temperature_coeff.tif` - local temperature sensitivity
   - `gwr_precipitation_coeff.tif` - local precipitation sensitivity
   - `gwr_r2.tif` - local model fit
4. Interpretation:
   - Tropical zones: High temperature sensitivity, moderate precipitation
   - Temperate: Lower temperature sensitivity, high precipitation sensitivity
   - Arid: Very high precipitation sensitivity

---

## Hot Spot Detection for Rasters

### Local Moran's I (LISA) - Raster Output

Local Moran's I identifies hot spots (high-high clusters), cold spots (low-low), and spatial outliers in gridded data.

**Function name:** `local_morans_i_lisa_raster`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Local Moran's I (LISA) - Raster Output**
2. Specify:
   - Input raster: Grid to analyze
   - Output: Raster with cluster classifications
3. Output raster values:
   - Cluster-High (HH): High values surrounded by high values
   - Cluster-Low (LL): Low values surrounded by low values
   - Outlier-High (HL): High surrounded by low
   - Outlier-Low (LH): Low surrounded by high
   - No significant cluster: Not statistically significant

**Workflow: Poverty Concentration in Urban Areas**

1. Load `poverty_rate_grid.tif`
2. Run LISA:
   - Input: poverty_rate_grid.tif
   - Output: lisa_clusters.tif
3. Map results:
   - Red: High poverty clusters (target intervention)
   - Blue: Low poverty clusters (affluent areas)
   - Gray: No significant clusters

---

### Getis-Ord Gi* - Raster Output

Z-score-based hot spot detector for continuous raster data. Directly interpretable as standard deviations from mean under null hypothesis.

**Function name:** `getis_ord_gi_star_raster`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Getis-Ord Gi* - Raster Output**
2. Specify:
   - Input raster: Continuous variable
   - Output: Raster with Gi* z-scores
3. Interpret output:
   - Z > 1.96: Statistically significant hot spot (p < 0.05)
   - Z < -1.96: Statistically significant cold spot
   - -1.96 ≤ Z ≤ 1.96: No significant clustering

**Workflow: Air Quality Hot Spot Identification**

1. Load `pm2.5_annual_mean.tif`
2. Run Getis-Ord Gi*:
   - Input: pm2.5_annual_mean.tif
   - Output: gi_star.tif
3. Classify output:
   - Z > 2.576 (p < 0.01): Very high-confidence hotspot
   - 1.96 < Z ≤ 2.576 (p < 0.05): Hotspot

---

## Intensity Estimation from Point Data

### Inhomogeneous Intensity (Raster Output)

Estimate point density as a function of environmental covariates. Useful for species distribution modeling and risk mapping.

**Function name:** `inhomogeneous_intensity_raster`

**In QGIS Plugin:**
1. Navigate to **Raster → Spatial Statistics → Inhomogeneous Intensity - Raster Output**
2. Specify:
   - Input layer: Point feature layer
   - Covariate rasters: Environmental predictors
   - Output: Intensity grid

**Workflow: Tree Distribution Analysis**

1. Load `tree_observations.gpkg`
2. Prepare covariates:
   - `elevation.tif`
   - `slope.tif`
   - `forest_type.tif`
3. Run Inhomogeneous Intensity:
   - Input: tree_observations.gpkg
   - Covariates: elevation.tif, slope.tif, forest_type.tif
   - Output: tree_intensity.tif
4. Interpretation:
   - High intensity zones: Suitable habitat
   - Low intensity zones: Marginal habitat

---

## Best Practices for Raster Spatial Statistics

### Choosing Kriging Method

| Scenario | Method | Rationale |
|----------|--------|-----------|
| No trend in data | Ordinary Kriging | Standard approach; works well for stationary fields |
| Strong directional gradient | Universal Kriging | Removes systematic trend, improves residual fit |
| Large dataset (>5,000 points) | Local Kriging | Efficient, captures non-stationarity |
| Known global mean | Simple Kriging | Reduces variance when prior is reliable |
| Time series data | Space-Time Kriging | Models temporal evolution in space |

### Variance Map Interpretation

- **High variance zones** (red): Sparse data, low model confidence. Invest in additional sampling.
- **Low variance zones** (green): Dense calibration data, high model confidence.
- Always report variance alongside predictions for uncertainty communication.

---

## Summary

Raster spatial statistics methods enable interpolation with uncertainty quantification, detection of spatial hot spots, and modeling of non-stationary relationships. Integration with vector spatial statistics, terrain analysis, and remote sensing tools enables comprehensive spatial analysis workflows.
