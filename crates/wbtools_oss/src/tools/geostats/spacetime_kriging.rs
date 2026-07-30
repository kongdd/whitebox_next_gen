use super::*;

pub struct SpaceTimeKrigingTool;

impl Tool for SpaceTimeKrigingTool {
    fn metadata(&self) -> ToolMetadata {
        ToolMetadata {
            id: "spacetime_kriging",
            display_name: "Space-Time Kriging",
            summary: r#"Performs space-time kriging to jointly model spatial and temporal variation in point observations. Extends ordinary kriging to 3D (x, y, t), weighting nearby observations more heavily in both space and time. Suitable for spatially-distributed time series: air quality networks, climate stations, environmental sensor arrays.

Requires separate fitted variograms for the spatial and temporal dimensions. The prediction_time parameter specifies the target time slice for the output raster; if omitted it defaults to the mean training time. All grid cells are predicted at the same target time, producing a snapshot interpolation.

Workflow: estimate_variogram (spatial) → fit_variogram (spatial) → estimate_variogram (temporal) → fit_variogram (temporal) → spacetime_kriging. Output includes predictions and optional kriging variance raster."#,
            category: ToolCategory::Raster,
            license_tier: LicenseTier::Open,
            params: vec![
                ToolParamSpec {
                    name: "training_points",
                    description:
                        "Vector layer with training points (must include a numeric time field)",
                    required: true,
                },
                ToolParamSpec {
                    name: "field",
                    description: "Field containing measurement values",
                    required: true,
                },
                ToolParamSpec {
                    name: "time_field",
                    description:
                        "Field containing numeric time values (e.g. Julian day, epoch seconds)",
                    required: true,
                },
                ToolParamSpec {
                    name: "spatial_variogram_json",
                    description: "Fitted spatial variogram model as JSON (from fit_variogram)",
                    required: true,
                },
                ToolParamSpec {
                    name: "temporal_variogram_json",
                    description:
                        "Fitted temporal variogram model as JSON (from fit_variogram on time axis)",
                    required: true,
                },
                ToolParamSpec {
                    name: "template_raster",
                    description: "Raster template defining output grid and CRS",
                    required: true,
                },
                ToolParamSpec {
                    name: "output",
                    description: "Output kriged raster path",
                    required: true,
                },
                ToolParamSpec {
                    name: "prediction_time",
                    description:
                        "Target time value for the output snapshot (default: mean training time)",
                    required: false,
                },
                ToolParamSpec {
                    name: "output_variance",
                    description: "If true, write kriging variance raster alongside predictions",
                    required: false,
                },
            ],
        }
    }

    fn manifest(&self) -> ToolManifest {
        let mut defaults = ToolArgs::new();
        defaults.insert("training_points".to_string(), json!("samples.gpkg"));
        defaults.insert("field".to_string(), json!("value"));
        defaults.insert("time_field".to_string(), json!("time"));
        defaults.insert("spatial_variogram_json".to_string(), json!("{}"));
        defaults.insert("temporal_variogram_json".to_string(), json!("{}"));
        defaults.insert("template_raster".to_string(), json!("template.tif"));
        defaults.insert("output".to_string(), json!("spacetime_kriging.tif"));
        defaults.insert("output_variance".to_string(), json!(false));
        let mut example_args = defaults.clone();
        example_args.insert("prediction_time".to_string(), json!(150.0));
        example_args.insert("output_variance".to_string(), json!(true));
        ToolManifest {
            id: "spacetime_kriging".to_string(),
            display_name: "Space-Time Kriging".to_string(),
            summary: "Performs space-time kriging for spatially-distributed time series data. Requires separate fitted spatial and temporal variogram models.".to_string(),
            category: ToolCategory::Raster,
            license_tier: LicenseTier::Open,
            params: vec![
                ToolParamDescriptor { name: "training_points".to_string(), description: "Vector layer with training points (must include a numeric time field)".to_string(), required: true },
                ToolParamDescriptor { name: "field".to_string(), description: "Field containing measurement values".to_string(), required: true },
                ToolParamDescriptor { name: "time_field".to_string(), description: "Field containing numeric time values".to_string(), required: true },
                ToolParamDescriptor { name: "spatial_variogram_json".to_string(), description: "Fitted spatial variogram model as JSON".to_string(), required: true },
                ToolParamDescriptor { name: "temporal_variogram_json".to_string(), description: "Fitted temporal variogram model as JSON".to_string(), required: true },
                ToolParamDescriptor { name: "template_raster".to_string(), description: "Raster template defining output grid and CRS".to_string(), required: true },
                ToolParamDescriptor { name: "output".to_string(), description: "Output kriged raster path".to_string(), required: true },
                ToolParamDescriptor { name: "prediction_time".to_string(), description: "Target time value for prediction snapshot (default: mean training time)".to_string(), required: false },
                ToolParamDescriptor { name: "output_variance".to_string(), description: "If true, write kriging variance raster alongside predictions".to_string(), required: false },
            ],
            defaults,
            examples: vec![ToolExample {
                name: "spacetime_kriging_snapshot".to_string(),
                description: "Space-time kriging snapshot at a specific time with variance output.".to_string(),
                args: example_args,
            }],
            tags: vec!["geostatistics".to_string(), "kriging".to_string(), "raster".to_string(), "interpolation".to_string(), "spatiotemporal".to_string(), "uncertainty".to_string()],
            stability: ToolStability::Stable,
        }
    }

    fn validate(&self, args: &ToolArgs) -> Result<(), ToolError> {
        let _ = load_vector_arg(args, "training_points")?;
        let _ = parse_string_arg(args, "field")?;
        let _ = parse_string_arg(args, "time_field")?;
        let _ = parse_string_arg(args, "spatial_variogram_json")?;
        let _ = parse_string_arg(args, "temporal_variogram_json")?;
        let _ = parse_string_arg(args, "template_raster")?;
        let _ = parse_string_arg(args, "output")?;
        Ok(())
    }

    fn run(&self, args: &ToolArgs, ctx: &ToolContext) -> Result<ToolRunResult, ToolError> {
        ctx.progress.info("Space-Time Kriging Interpolation");

        let training = load_vector_arg(args, "training_points")?;
        let field_name = parse_string_arg(args, "field")?;
        let time_field_name = parse_string_arg(args, "time_field")?;
        let spatial_vario_str = parse_string_arg(args, "spatial_variogram_json")?;
        let temporal_vario_str = parse_string_arg(args, "temporal_variogram_json")?;
        let template_path = parse_string_arg(args, "template_raster")?;
        let output_path = parse_string_arg(args, "output")?;
        let output_variance = parse_bool_arg(args, "output_variance", false);

        let spatial_vario = parse_variogram_json(spatial_vario_str)?;
        let temporal_vario = parse_variogram_json(temporal_vario_str)?;

        ctx.progress.info("Loading training points...");
        let field_idx = training.schema.field_index(field_name).ok_or_else(|| {
            ToolError::Validation(format!("field '{}' does not exist", field_name))
        })?;
        let time_idx = training
            .schema
            .field_index(time_field_name)
            .ok_or_else(|| {
                ToolError::Validation(format!("time field '{}' does not exist", time_field_name))
            })?;

        let mut coords_spatial = Vec::new();
        let mut coords_temporal = Vec::new();
        let mut values = Vec::new();

        for feature in &training.features {
            if let Some(geom) = &feature.geometry {
                if let wbvector::Geometry::Point(coord) = geom {
                    if let (Some(val), Some(t)) = (
                        feature.attributes.get(field_idx).and_then(|v| v.as_f64()),
                        feature.attributes.get(time_idx).and_then(|v| v.as_f64()),
                    ) {
                        if val.is_finite() && t.is_finite() {
                            coords_spatial.push((coord.x, coord.y));
                            coords_temporal.push(t);
                            values.push(val);
                        }
                    }
                }
            }
        }

        if coords_spatial.len() < 4 {
            return Err(ToolError::Execution(format!(
                "At least 4 points with valid values and times required, found {}",
                coords_spatial.len()
            )));
        }
        ctx.progress
            .info(&format!("Loaded {} training points", coords_spatial.len()));

        let prediction_time = parse_optional_f64_arg(args, "prediction_time")
            .unwrap_or_else(|| coords_temporal.iter().sum::<f64>() / coords_temporal.len() as f64);
        ctx.progress.info(&format!(
            "Building space-time kriging engine (prediction_time={:.4})",
            prediction_time
        ));

        let kriging = SpaceTimeKriging::new(
            coords_spatial,
            coords_temporal,
            values,
            spatial_vario,
            temporal_vario,
        )
        .map_err(|e| ToolError::Execution(format!("Kriging setup error: {}", e)))?;

        ctx.progress.info("Loading template raster...");
        let mut template = Raster::read(template_path)
            .map_err(|e| ToolError::Execution(format!("Failed to read template raster: {}", e)))?;
        ctx.progress.info(&format!(
            "Template grid: {} x {} cells",
            template.rows, template.cols
        ));

        let n_cells = template.rows * template.cols;
        ctx.progress.info(&format!(
            "Predicting {} grid cells at time {:.4}...",
            n_cells, prediction_time
        ));

        let grid_spatial = generate_raster_grid(&template);
        let grid_temporal = vec![prediction_time; grid_spatial.len()];

        let predictions = kriging
            .predict_batch(grid_spatial.clone(), grid_temporal)
            .map_err(|e| ToolError::Execution(format!("Kriging prediction error: {}", e)))?;

        let mut pred_data = vec![0.0_f64; template.data.len()];
        let mut var_data = vec![0.0_f64; template.data.len()];
        for (idx, result) in predictions.iter().enumerate() {
            if idx < pred_data.len() {
                pred_data[idx] = result.prediction;
                var_data[idx] = result.variance;
            }
        }

        template.data = wbraster::raster::RasterData::F64(pred_data);
        ctx.progress
            .info(&format!("Writing output to {}", output_path));
        let format = RasterFormat::for_output_path(output_path)
            .map_err(|e| ToolError::Execution(format!("Invalid output format: {}", e)))?;
        template
            .write(output_path, format)
            .map_err(|e| ToolError::Execution(format!("Failed to write raster: {}", e)))?;

        let variance_path = if output_variance {
            let vpath = derive_variance_path(output_path);
            ctx.progress
                .info(&format!("Writing variance raster to {}", vpath));
            template.data = wbraster::raster::RasterData::F64(var_data);
            template.write(&vpath, format).map_err(|e| {
                ToolError::Execution(format!("Failed to write variance raster: {}", e))
            })?;
            Some(vpath)
        } else {
            None
        };

        let mut outputs = std::collections::BTreeMap::new();
        outputs.insert(
            "kriging_report".to_string(),
            json!({
                "grid_cells": n_cells,
                "prediction_time": prediction_time,
                "output_path": output_path,
                "variance_path": variance_path,
                "status": "complete"
            }),
        );
        ctx.progress
            .info("Space-time kriging interpolation complete");
        Ok(ToolRunResult {
            outputs,
            ..Default::default()
        })
    }
}
