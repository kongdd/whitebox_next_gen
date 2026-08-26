// Mimic exactly what D8FlowAccumTool::run() does and dump output stats.
use std::env;
use wbraster::formats::geotiff::read as read_geotiff;
use wbraster::formats::geotiff::write_with_options;
use wbraster::{DataType, GeoTiffWriteOptions};
use wbtools_oss::tools::flow_algorithms::{d8_dir_from_pointer, d8_dir_from_dem, d8_flow_accum_core};

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = &args[1];
    let out_path = &args[2];
    let esri = args.iter().any(|a| a == "--esri" || a == "--esri-pntr");
    let use_dem = args.iter().any(|a| a == "--dem");
    let out_type = if args.iter().any(|a| a == "--ca") { "ca" } else { "cells" };

    let input = read_geotiff(path).expect("open");
    println!("input: rows={} cols={} nodata={} dtype={:?} geo? (cell_x={}, cell_y={})",
        input.rows, input.cols, input.nodata, input.data_type,
        input.cell_size_x, input.cell_size_y);

    let flow_dir = if use_dem { d8_dir_from_dem(&input) } else { d8_dir_from_pointer(&input, esri) };
    let mut accum = d8_flow_accum_core(&flow_dir, input.rows, input.cols, -32768.0);

    let mut a_max = f64::MIN; let mut a_count = 0i64; let mut a_neg = 0i64;
    for (i, &v) in accum.iter().enumerate() {
        if flow_dir[i] == -2 { a_neg += 1; continue; }
        if v == -32768.0 { continue; }
        if v > a_max { a_max = v; }
        a_count += 1;
    }
    println!("after d8_flow_accum_core: max={} count={} nodata={}", a_max, a_count, a_neg);

    // Mimic the CLI run() output construction
    let mut out = input.clone();
    out.data_type = DataType::F32;
    out.nodata = -32768.0;

    let cell_area = input.cell_size_x * input.cell_size_y;
    let flow_width = (input.cell_size_x + input.cell_size_y) / 2.0;
    println!("non-geo path: cell_area={} flow_width={}", cell_area, flow_width);

    // (non-geo branch — Hubei is geo but mimic anyway)
    let eff_area = if out_type == "cells" { 1.0 } else { cell_area };
    let eff_width = if out_type == "cells" || out_type == "ca" { 1.0 } else { flow_width };

    for r in 0..input.rows {
        for c in 0..input.cols {
            let i = r * input.cols + c;
            let v = if flow_dir[i] == -2 {
                -32768.0
            } else {
                accum[i] * eff_area / eff_width
            };
            out.set_unchecked(0, r as isize, c as isize, v);
        }
    }

    // dump out stats
    let mut o_max = f64::MIN; let mut o_min = f64::MAX; let mut o_count = 0i64;
    let mut o_neg = 0i64;
    for r in 0..input.rows {
        for c in 0..input.cols {
            let i = r * input.cols + c;
            let v = out.get(0, r as isize, c as isize);
            if v == -32768.0 { o_neg += 1; continue; }
            if v > o_max { o_max = v; }
            if v < o_min { o_min = v; }
            o_count += 1;
        }
    }
    println!("after set_unchecked + get loop: min={} max={} count={} nodata={}", o_min, o_max, o_count, o_neg);

    write_with_options(&out, out_path, &GeoTiffWriteOptions::default()).expect("write");
    println!("written: {}", out_path);
}
