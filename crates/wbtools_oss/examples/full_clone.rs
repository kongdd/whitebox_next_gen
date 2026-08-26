use std::env;
use wbraster::formats::geotiff::{read as read_geotiff, write_with_options};
use wbraster::{raster::RasterData, DataType, GeoTiffWriteOptions};
use wbtools_oss::tools::flow_algorithms::{d8_dir_from_pointer, d8_flow_accum_core};

fn main() {
    let args: Vec<String> = env::args().collect();
    let path = &args[1];
    let out_path = &args[2];

    let input = read_geotiff(path).expect("open");
    println!("input: rows={} cols={} nodata={} dtype={:?}",
        input.rows, input.cols, input.nodata, input.data_type);

    let flow_dir = d8_dir_from_pointer(&input, true);
    let accum = d8_flow_accum_core(&flow_dir, input.rows, input.cols, -32768.0);

    let mut out = input.clone();
    out.data_type = DataType::F32;
    out.nodata = -32768.0;
    let n = (input.rows * input.cols) as usize;
    let mut out_f32: Vec<f32> = Vec::with_capacity(n);
    for i in 0..n {
        let v = if flow_dir[i] == -2 { -32768.0 } else { accum[i] };
        out_f32.push(v as f32);
    }
    out.data = RasterData::F32(out_f32);
    println!("out.data_type: {:?}", out.data.data_type());

    let mut o_max = f64::MIN;
    for r in 0..input.rows {
        for c in 0..input.cols {
            let v = out.get(0, r as isize, c as isize);
            if v != -32768.0 && v > o_max { o_max = v; }
        }
    }
    println!("out (after clone+data fix, no set_unchecked): max={}", o_max);

    write_with_options(&out, out_path, &GeoTiffWriteOptions::default()).expect("write");
    println!("written: {}", out_path);
}
