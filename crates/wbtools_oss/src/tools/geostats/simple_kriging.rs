use super::*;

pub struct SimpleKrigingTool;

impl Tool for SimpleKrigingTool {
    fn metadata(&self) -> ToolMetadata {
        ToolMetadata {
            id: "simple_kriging",
            display_name: "Simple Kriging",
            summary: r#"Performs simple kriging interpolation when the mean of the spatial field is known a priori. Unlike ordinary kriging (which estimates an unknown mean), simple kriging incorporates a user-supplied constant mean, reducing kriging variance and providing more stable predictions when the mean is reliably known from external information.

Simple kriging is appropriate when you have strong prior knowledge of the field mean (e.g., from regional climate normals, geological surveys, or calibration data). Compared to ordinary kriging, it generally produces lower prediction variance due to the fixed mean constraint.

Workflow: estimate_variogram → fit_variogram → (optional) kriging_cross_validation → simple_kriging. Output includes predictions and optional kriging variance raster."#,
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
                    name: "known_mean",
                    description: "Known constant mean of the spatial field (default: sample mean)",
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
        defaults.insert("output".to_string(), json!("simple_kriging.tif"));
        defaults.insert("output_variance".to_string(), json!(false));
        let mut example_args = defaults.clone();
        example_args.insert("known_mean".to_string(), json!(100.0));
        example_args.insert("output_variance".to_string(), json!(true));
        ToolManifest {
            id: "simple_kriging".to_string(),
            display_name: "Simple Kriging".to_string(),
            summary: "Performs simple kriging with a known constant mean. Requires a pre-fitted variogram model (from fit_variogram). Produces lower variance than ordinary kriging when the mean is reliably known.".to_string(),
            category: ToolCategory::Raster,
            license_tier: LicenseTier::Open,
            params: vec![
                ToolParamDescriptor { name: "training_points".to_string(), description: "Vector layer with training points".to_string(), required: true },
                ToolParamDescriptor { name: "field".to_string(), description: "Field containing measurement values".to_string(), required: true },
                ToolParamDescriptor { name: "variogram_json".to_string(), description: "Fitted variogram model as JSON (from fit_variogram)".to_string(), required: true },
                ToolParamDescriptor { name: "template_raster".to_string(), description: "Raster template defining output grid and CRS".to_string(), required: true },
                ToolParamDescriptor { name: "output".to_string(), description: "Output kriged raster path".to_string(), required: true },
                ToolParamDescriptor { name: "known_mean".to_string(), description: "Known constant mean of the spatial field (omit to use sample mean)".to_string(), required: false },
                ToolParamDescriptor { name: "output_variance".to_string(), description: "If true, write kriging variance raster alongside predictions".to_string(), required: false },
            ],
            defaults,
            examples: vec![ToolExample {
                name: "simple_kriging_basic".to_string(),
                description: "Simple kriging with a known mean and variance output.".to_string(),
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
        Ok(())
    }

    fn run(&self, args: &ToolArgs, ctx: &ToolContext) -> Result<ToolRunResult, ToolError> {
        ctx.progress.info("Simple Kriging Interpolation");

        let training = load_vector_arg(args, "training_points")?;
        let field_name = parse_string_arg(args, "field")?;
        let vario_json_str = parse_string_arg(args, "variogram_json")?;
        let template_path = parse_string_arg(args, "template_raster")?;
        let output_path = parse_string_arg(args, "output")?;
        let output_variance = parse_bool_arg(args, "output_variance", false);

        let vario = parse_variogram_json(vario_json_str)?;

        ctx.progress.info("Loading training points...");
        let (coords, values) = extract_training_points(&training, field_name)?;
        ctx.progress
            .info(&format!("Loaded {} training points", coords.len()));

        // Default known_mean to sample mean if not provided
        let known_mean = parse_optional_f64_arg(args, "known_mean")
            .unwrap_or_else(|| values.iter().sum::<f64>() / values.len() as f64);
        ctx.progress.info(&format!(
            "Building simple kriging engine (known_mean={:.4})",
            known_mean
        ));

        let kriging = SimpleKriging::new(coords, values, vario, known_mean)
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
                "known_mean": known_mean,
                "output_path": output_path,
                "variance_path": variance_path,
                "status": "complete"
            }),
        );
        ctx.progress.info("Simple kriging interpolation complete");
        Ok(ToolRunResult {
            outputs,
            ..Default::default()
        })
    }
}
