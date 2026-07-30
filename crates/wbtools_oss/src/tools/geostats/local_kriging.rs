use super::*;

pub struct LocalOrdinaryKrigingTool;

impl Tool for LocalOrdinaryKrigingTool {
    fn metadata(&self) -> ToolMetadata {
        ToolMetadata {
            id: "local_kriging",
            display_name: "Local Ordinary Kriging",
            summary: r#"Performs local ordinary kriging interpolation using k-nearest neighbors, providing efficient spatial estimation for large datasets. For each prediction location, only the k nearest training points are used, reducing computation from O(n³) to O(k³) while preserving kriging's geostatistical properties.

Local kriging is ideal when spatial correlation structure varies across the study area (non-stationary) or when datasets are too large for global ordinary kriging (>5000 points). The k_neighbors parameter controls the trade-off between accuracy and speed; typical values are 10–20. Uses the provided fitted variogram model (from fit_variogram tool) for all predictions.

Workflow: estimate_variogram → fit_variogram → (optional) kriging_cross_validation → local_kriging. Output includes predictions and optional kriging variance raster."#,
            category: ToolCategory::Raster,
            license_tier: LicenseTier::Open,
            params: vec![
                ToolParamSpec {
                    name: "training_points",
                    description: "Vector layer with training points",
                    required: true,
                },
                ToolParamSpec {
                    name: "field",
                    description: "Field containing measurement values",
                    required: true,
                },
                ToolParamSpec {
                    name: "variogram_json",
                    description: "Fitted variogram model as JSON (from fit_variogram)",
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
                    name: "k_neighbors",
                    description: "Number of nearest neighbors to use (default: 20)",
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
        defaults.insert("variogram_json".to_string(), json!("{}"));
        defaults.insert("template_raster".to_string(), json!("template.tif"));
        defaults.insert("output".to_string(), json!("local_kriging.tif"));
        defaults.insert("k_neighbors".to_string(), json!(20));
        defaults.insert("output_variance".to_string(), json!(false));
        let mut example_args = defaults.clone();
        example_args.insert("output_variance".to_string(), json!(true));
        ToolManifest {
            id: "local_kriging".to_string(),
            display_name: "Local Ordinary Kriging".to_string(),
            summary: "Performs local ordinary kriging using k-nearest neighbors. Efficient for large datasets. Requires a pre-fitted variogram model (from fit_variogram).".to_string(),
            category: ToolCategory::Raster,
            license_tier: LicenseTier::Open,
            params: vec![
                ToolParamDescriptor { name: "training_points".to_string(), description: "Vector layer with training points".to_string(), required: true },
                ToolParamDescriptor { name: "field".to_string(), description: "Field containing measurement values".to_string(), required: true },
                ToolParamDescriptor { name: "variogram_json".to_string(), description: "Fitted variogram model as JSON (from fit_variogram)".to_string(), required: true },
                ToolParamDescriptor { name: "template_raster".to_string(), description: "Raster template defining output grid and CRS".to_string(), required: true },
                ToolParamDescriptor { name: "output".to_string(), description: "Output kriged raster path".to_string(), required: true },
                ToolParamDescriptor { name: "k_neighbors".to_string(), description: "Number of nearest neighbors (default: 20)".to_string(), required: false },
                ToolParamDescriptor { name: "output_variance".to_string(), description: "If true, write kriging variance raster alongside predictions".to_string(), required: false },
            ],
            defaults,
            examples: vec![ToolExample {
                name: "local_kriging_basic".to_string(),
                description: "Local kriging with k=20 neighbors and variance output.".to_string(),
                args: example_args,
            }],
            tags: vec!["geostatistics".to_string(), "kriging".to_string(), "raster".to_string(), "interpolation".to_string(), "uncertainty".to_string()],
            stability: ToolStability::Stable,
        }
    }

    fn validate(&self, args: &ToolArgs) -> Result<(), ToolError> {
        let _ = load_vector_arg(args, "training_points")?;
        let _ = parse_string_arg(args, "field")?;
        let _ = parse_string_arg(args, "variogram_json")?;
        let _ = parse_string_arg(args, "template_raster")?;
        let _ = parse_string_arg(args, "output")?;
        let k = args
            .get("k_neighbors")
            .and_then(|v| v.as_u64())
            .unwrap_or(20);
        if k < 3 {
            return Err(ToolError::Validation(
                "k_neighbors must be at least 3".to_string(),
            ));
        }
        Ok(())
    }

    fn run(&self, args: &ToolArgs, ctx: &ToolContext) -> Result<ToolRunResult, ToolError> {
        ctx.progress.info("Local Ordinary Kriging Interpolation");

        let training = load_vector_arg(args, "training_points")?;
        let field_name = parse_string_arg(args, "field")?;
        let vario_json_str = parse_string_arg(args, "variogram_json")?;
        let template_path = parse_string_arg(args, "template_raster")?;
        let output_path = parse_string_arg(args, "output")?;
        let k_neighbors = args
            .get("k_neighbors")
            .and_then(|v| v.as_u64())
            .unwrap_or(20) as usize;
        let output_variance = parse_bool_arg(args, "output_variance", false);

        let vario = parse_variogram_json(vario_json_str)?;

        ctx.progress.info("Loading training points...");
        let (coords, values) = extract_training_points(&training, field_name)?;
        ctx.progress
            .info(&format!("Loaded {} training points", coords.len()));

        let k = k_neighbors.min(coords.len());
        ctx.progress
            .info(&format!("Building local kriging engine (k={})", k));
        let kriging = LocalOrdinaryKriging::new(coords, values, vario, k)
            .map_err(|e| ToolError::Execution(format!("Kriging setup error: {}", e)))?;

        ctx.progress.info("Loading template raster...");
        let mut template = Raster::read(template_path)
            .map_err(|e| ToolError::Execution(format!("Failed to read template raster: {}", e)))?;
        ctx.progress.info(&format!(
            "Template grid: {} x {} cells",
            template.rows, template.cols
        ));

        ctx.progress.info(&format!(
            "Predicting {} grid cells...",
            template.rows * template.cols
        ));
        let grid_coords = generate_raster_grid(&template);
        let predictions = kriging
            .predict_batch(&grid_coords)
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
                "grid_cells": grid_coords.len(),
                "k_neighbors": k,
                "output_path": output_path,
                "variance_path": variance_path,
                "status": "complete"
            }),
        );
        ctx.progress.info("Local kriging interpolation complete");
        Ok(ToolRunResult {
            outputs,
            ..Default::default()
        })
    }
}
