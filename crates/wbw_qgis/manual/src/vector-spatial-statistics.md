# Vector Spatial Statistics

Vector-based spatial statistics methods in the Whitebox QGIS plugin analyze point and polygon features to detect spatial patterns, model relationships, and test for clustering. This section covers autocorrelation detection, point pattern analysis, spatial regression, and variogram-based spatial structure assessment.

---

## Core Concepts

- **Spatial autocorrelation**: Degree to which observations at nearby locations resemble each other. Most geographic data exhibit positive autocorrelation.
- **Moran's I**: Global measure of autocorrelation. Significant positive I indicates clustering; negative indicates alternating patterns.
- **LISA (Local Indicators of Spatial Association)**: Local autocorrelation revealing hot spots (HH), cold spots (LL), and outliers (HL, LH).
- **Hot spot**: Statistically significant cluster of high values. Cold spot: cluster of low values.
- **Point pattern**: Distribution of point events. Can be clustered (aggregated), dispersed (regular), or random.
- **Ripley's K function**: Cumulative measure of clustering intensity across distance scales.
- **Variogram**: Describes variance increase with distance. Essential for kriging.
- **Spatial regression**: Models incorporating spatial dependence (SAR, SEM, GWR).
- **Null hypothesis (CSR)**: Complete Spatial Randomness; used as baseline for pattern tests.

---

## Autocorrelation Analysis: Detecting Spatial Structure

### Global Moran's I: Overall Spatial Autocorrelation

Tests whether observations are randomly distributed or exhibit spatial structure.

**Function name:** `global_morans_i`

**In QGIS Plugin:**
1. Load vector layer with numerical attribute
2. Navigate to **Vector → Spatial Statistics → Global Morans I**
3. Specify:
   - Input layer: Feature collection
   - Field: Attribute to analyze (e.g., temperature, disease rate)
   - Weight matrix: queen (8-neighbor) or rook (4-neighbor)
4. Output: Text report with Moran's I, p-value, interpretation

**Example: Regional Temperature Autocorrelation**

1. Load `weather_stations.gpkg` with `temperature` field
2. Run Global Moran's I
3. Interpretation:
   - If p < 0.05 and I > 0: Significant clustering; nearby stations have similar temperatures
   - If p > 0.05: No significant spatial structure; patterns likely random
4. Proceed to LISA for cluster localization

---

### Local Moran's I (LISA): Cluster Identification

Decomposes global autocorrelation into local contributions, identifying hot spots, cold spots, and outliers.

**Function name:** `local_morans_i_lisa`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Local Morans I (LISA)**
2. Specify:
   - Input layer: Feature collection
   - Field: Attribute to analyze
   - Output: New shapefile with cluster classifications
3. Output feature attributes include:
   - Cluster classification: Cluster-High (HH), Cluster-Low (LL), Outlier-High (HL), Outlier-Low (LH), No significant
   - Local Moran's I value
   - p-value (statistical significance)

**Workflow: Disease Surveillance Cluster Detection**

1. Load `covid_cases.gpkg` with `case_count` field
2. Run Global Moran's I to confirm clustering:
   - If p < 0.05, proceed to local analysis
3. Run Local Moran's I:
   - Input: covid_cases.gpkg
   - Field: case_count
   - Output: covid_hotspots.gpkg
4. In QGIS, symbolize output by cluster classification:
   - Red: Cluster-High (intervention zones)
   - Blue: Cluster-Low (low-prevalence areas)
   - Gray: Not significant (random variation)
5. Use hot spot map for outbreak response planning

**Interpretation Guide:**

| Cluster Type | Meaning | Action |
|-------------|---------|--------|
| Cluster-High (HH) | High values clustered together | Investigate common risk factors |
| Cluster-Low (LL) | Low values clustered together | Identify protective factors |
| Outlier-High (HL) | High surrounded by low | Anomaly; verify data quality |
| Outlier-Low (LH) | Low surrounded by high | Edge/boundary zones |
| No significant | Not statistically significant | Random variation expected |

---

### Getis-Ord Gi*: Z-Score-Based Hot Spots

Z-score-based hot spot detector providing continuous intensity scores directly interpretable as standard deviations from mean.

**Function name:** `getis_ord_gi_star`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Getis-Ord Gi Star**
2. Specify:
   - Input layer: Feature collection
   - Field: Attribute to analyze
   - Output: New shapefile with Gi* z-scores
3. Interpret z-scores:
   - Z > 1.96: Hot spot (p < 0.05)
   - Z < -1.96: Cold spot (p < 0.05)
   - -1.96 ≤ Z ≤ 1.96: No significant clustering

**Workflow: Crime Hot Spot Mapping**

1. Load `crime_incidents.gpkg` with `incident_count` field
2. Run Getis-Ord Gi*:
   - Input: crime_incidents.gpkg
   - Field: incident_count
   - Output: crime_hotspots.gpkg
3. Symbolize by z-score:
   - Red (Z > 2.576, p < 0.01): Very high-confidence hotspots
   - Orange (1.96 < Z ≤ 2.576, p < 0.05): Hotspots
   - Blue (Z < -1.96, p < 0.05): Cold spots (low crime)
4. Use for police resource allocation and intervention targeting

---

## Point Pattern Analysis: Clustering vs. Dispersion

### Nearest Neighbour Index: Overall Pattern Test

Compares observed nearest-neighbour distances to expected distances under Complete Spatial Randomness (CSR).

$$\text{NNI} = \frac{\text{Observed Mean Distance}}{\text{Expected Mean Distance}}$$

**Function name:** `nearest_neighbour_index`

**In QGIS Plugin:**
1. Load point layer (e.g., tree locations, earthquake epicenters)
2. Navigate to **Vector → Spatial Statistics → Nearest Neighbour Index**
3. Output includes:
   - NNI value
   - z-score and p-value
   - Observed and expected mean distances
4. Interpret:
   - NNI ≈ 1: Random pattern (CSR)
   - NNI < 1: Clustering (p < 0.05 indicates significant)
   - NNI > 1: Dispersion (regular spacing)

**Example: Wildfire Clustering Analysis**

1. Load `fire_events.gpkg` (point layer of fire locations)
2. Run NNI:
   - If NNI < 1, p < 0.05: Fires significantly clustered
   - Investigate common conditions: drought, fuel load, ignition sources
   - If NNI ≈ 1: Random pattern suggests independent ignition events

---

### Ripley's K Function: Scale-Dependent Clustering

Examines clustering intensity across multiple distance scales, revealing whether clustering is local (fine-scale) or regional (broad-scale).

**Function name:** `ripleys_k_function`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Ripley's K Function**
2. Specify:
   - Input layer: Point features
   - Distance intervals and number of scales
3. Output: Text file or table with K(d) values at each distance

**Interpretation:**
- K(d) > πd²: Clustering at scale d
- K(d) ≈ πd²: Random pattern
- K(d) < πd²: Dispersion at scale d

---

### Envelope Test: Confidence Bands for Clustering

Determine confidence envelope around expected K function under CSR through Monte Carlo simulation.

**Function name:** `envelope_test` and `point_pattern_envelope`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Point Pattern Envelope Test**
2. Specify:
   - Input layer: Point features
   - Number of simulations: 99 or 999 for Monte Carlo permutations
3. Output: Envelope boundaries showing significant clustering/dispersion ranges

**Workflow: Vegetation Clustering in Forests**

1. Load `plant_observations.gpkg` (species point locations)
2. Run Ripley's K Function:
   - Identifies clustering scales (e.g., significant at 0-200 m, independent beyond 500 m)
3. Run Envelope Test:
   - Compares observed K(d) to random permutation envelope
   - Reveals statistically significant scales
4. Interpretation: Strong clustering 0-100 m suggests facilitating factors (microhabitat, species facilitation, regeneration from seed)

---

### Quadrat Count Test: Grid-Based Pattern Analysis

Divide study area into grid cells (quadrats), count points in each, and test if counts follow Poisson distribution (expected under CSR).

**Function name:** `quadrat_count_test`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Quadrat Count Test**
2. Specify:
   - Input layer: Point features
   - Cell size: Quadrat size (e.g., 1000 m × 1000 m)
3. Output includes:
   - Chi-squared statistic
   - p-value
   - Variance-to-mean ratio (dispersion index)
4. Interpret:
   - Dispersion index > 1: Clustering
   - Dispersion index ≈ 1: Random (CSR)
   - Dispersion index < 1: Dispersion

---

## Spatial Regression: Modeling Spatial Relationships

### Spatial Lag Regression (SAR)

Includes spatially lagged dependent variable, capturing spillover/contagion effects.

**Function name:** `spatial_lag_regression`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Spatial Lag Regression**
2. Specify:
   - Input layer: Feature collection with dependent and independent variables
   - Dependent variable: Outcome field
   - Independent variables: Predictor fields (multiple)
3. Output: Report with coefficients, spatial lag parameter (ρ), diagnostics

**Workflow: Real Estate Price Spillover Analysis**

1. Load `properties.gpkg` with:
   - `sale_price` (dependent)
   - `living_area`, `lot_size`, `year_built` (independent)
2. Run SAR:
   - Dependent: sale_price
   - Independent: living_area, lot_size, year_built
3. Interpret ρ (spatial lag coefficient):
   - Significant positive ρ: Neighborhood effects (gentrification, price contagion)
   - Significant negative ρ: Competition effects (unusual)
   - Non-significant ρ: Spatial independence (rare in real estate)
4. Use for property valuation modeling accounting for neighborhood context

---

### Spatial Error Regression (SEM)

Regression with spatial correlation in residuals (rather than dependent variable). Appropriate when spatial dependence arises from omitted variables.

**Function name:** `spatial_error_regression`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Spatial Error Regression**
2. Specify: Input layer, dependent, independent variables
3. Output: Coefficients, lambda (spatial error lag), diagnostics

**When to Use:**
- Theory suggests omitted variable is spatially structured (unobserved soil heterogeneity, unmeasured environmental factor)
- Example: Crop yield with unobserved soil type, elevation-related variables

---

### Geographically Weighted Regression (GWR)

Local regression estimation allowing relationships to vary spatially. Produces maps of local parameters.

**Function name:** `geographically_weighted_regression`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Geographically Weighted Regression**
2. Specify:
   - Input layer: Feature collection
   - Dependent variable: Outcome field
   - Independent variables: Predictor fields
   - Kernel: adaptive (local bandwidth) or fixed (distance)
3. Output: Shapefile with local coefficients, local R² values

**Workflow: School Performance Regional Variation**

1. Load `school_districts.gpkg` with:
   - `graduation_rate` (dependent)
   - `student_poverty_rate`, `teacher_experience` (independent)
2. Run GWR:
   - Output: local_coefficients.gpkg
3. Inspect local `student_poverty_rate` coefficient:
   - Urban areas: Strong negative effect (poverty strongly linked to lower graduation)
   - Suburban areas: Moderate effect (other factors important)
   - Rural areas: Weak effect (cultural, school-quality variation dominates)
4. Use for targeted policy: interventions match local relationship patterns

---

## Geostatistics: Variogram Analysis and Kriging Parameters

### Estimate Variogram: Quantifying Spatial Correlation

Compute empirical variogram from point measurements. Essential for all kriging methods.

**Function name:** `estimate_variogram`

**In QGIS Plugin:**
1. Load point layer with measurement attribute
2. Navigate to **Vector → Spatial Statistics → Estimate Variogram**
3. Specify:
   - Input layer: Point features
   - Value field: Attribute to analyze
   - Lag size: Distance interval (e.g., 500 m)
   - Number of lags: Distance bins to compute (e.g., 15)
4. Output: Text file or table with variogram values

**Interpretation:**
- **Nugget**: Variance at distance 0 (measurement error, microscale variation)
- **Sill**: Maximum variance (asymptotic level)
- **Range**: Distance beyond which values uncorrelated

**Workflow: Soil pH Spatial Structure**

1. Load `soil_samples.gpkg` with `soil_ph` field
2. Run Estimate Variogram:
   - Lag size: 500 m
   - Number of lags: 20
3. Plot variogram:
   - Steep initial rise: Strong local variation
   - Leveloff at 3000 m: Range of spatial dependence
   - Sill ≈ 0.5: Total variance after removing trend
4. Use for variogram model selection

---

### Fit Variogram: Model Parameter Estimation

Fit parametric variogram model (Spherical, Exponential, Gaussian) to empirical variogram.

**Function name:** `fit_variogram`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Fit Variogram**
2. Specify:
   - Input layer: Point features
   - Value field: Attribute
   - Model type: spherical, exponential, gaussian
3. Output: Model parameters (nugget, partial sill, range)

**Common Models:**

| Model | Shape | Use Case |
|-------|-------|----------|
| Spherical | S-shaped, reaches sill asymptotically | Most common; realistic spatial correlation decay |
| Exponential | Smooth approach to sill | More gradual correlation decay; less abrupt |
| Gaussian | Parabolic near origin | Assumes high smoothness; rare |

---

### Kriging Cross-Validation: Model Reliability Assessment

Leave-one-out cross-validation: Remove each data point, predict from others, compare to true value.

**Function name:** `kriging_cross_validation`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Kriging Cross Validation**
2. Specify:
   - Input layer: Point features
   - Value field: Attribute
   - Kriging model: ordinary, simple, universal
3. Output: Diagnostics (RMSE, MAE, standardized residuals, correlation)

**Diagnostics Interpretation:**

| Statistic | Good Value | Bad Value |
|-----------|-----------|-----------|
| RMSE | Notably < observed std dev | Close to observed std dev (no skill) |
| Standardized residuals | Mean ≈ 0, σ ≈ 1 | Mean ≠ 0 (bias) or σ >> 1 (underconfident) |
| Correlation | High (> 0.7) | Low (< 0.5) |

---

## Advanced Spatial Pattern Diagnostics

### Point Process Residuals: Model Adequacy Testing

Extract residuals after fitting spatial model to diagnose model fit.

**Function name:** `point_process_residuals`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Point Process Residuals**
2. Specify:
   - Input layer: Point features
   - Baseline intensity: Expected density raster
3. Output: Residual pattern revealing unmodeled structure

**Workflow: Species Distribution Modeling**

1. Model predicts habitat suitability (baseline intensity)
2. Extract observed species locations
3. Compare residuals to null model:
   - Clustering of positive residuals: Unexplained clustering, missing predictor
   - Random residuals: Good model fit

---

### Hotspot vs. Process Comparison

Distinguish whether observed hot spots are sampling artifacts or true underlying process heterogeneity.

**Function name:** `hotspot_vs_process`

**In QGIS Plugin:**
1. Navigate to **Vector → Spatial Statistics → Hotspot vs Process Comparison**
2. Specify:
   - Input layer: Point observations
   - Intensity raster: Expected point density (e.g., population density for disease cases)
3. Output: Comparison of observed clustering to intensity-adjusted expectation

**Example: Disease Cluster Validity**

- Observed hot spot in dense urban zone
- Question: Is clustering due to population density (sampling) or disease risk?
- Output: If intensity-adjusted residuals cluster, suggests true disease hot spot
- If residuals random, hot spot is artifact of population distribution

---

## Best Practices for Vector Spatial Statistics

### Choosing Autocorrelation Method

| Scenario | Method | Rationale |
|----------|--------|-----------|
| Global overview needed | Global Moran's I | Summarizes entire dataset; fast |
| Cluster location required | Local Moran's I (LISA) | Identifies hot/cold spots; categorical |
| Continuous intensity scoring | Getis-Ord Gi* | Z-scores ideal for mapping |

### Weight Matrix Selection

- **Queen (8-neighbor)**: Most common; captures diagonal adjacencies
- **Rook (4-neighbor)**: Cardinal directions only; use for regular grids
- **Distance-based**: All features within fixed radius; for continuous fields

### Sample Size Considerations

- **< 30 samples**: Kriging unreliable; visual inspection only
- **30-100 samples**: Kriging viable for local interpolation
- **> 100 samples**: Kriging robust; consider local kriging for non-stationarity

---

## Summary

Vector spatial statistics methods enable:
1. **Cluster detection** (LISA, Getis-Ord Gi*) for targeted intervention
2. **Pattern testing** (NNI, Ripley's K, quadrat test) for ecological/epidemiological questions
3. **Spatial modeling** (SAR, SEM, GWR) accounting for spatial dependence
4. **Interpolation foundation** (variogram analysis) for kriging parameter estimation

Integration with vector geometry tools, network analysis, and overlay operations enables comprehensive spatial analysis workflows for epidemiology, ecology, real estate, and regional planning applications.


*No help documentation available for this tool.*
