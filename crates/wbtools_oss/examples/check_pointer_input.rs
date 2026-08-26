//! 检查 D8 pointer 输入：nodata 元数据、像元 0、ESRI 合法方向码分布。
//!
//! ```bash
//! cargo run -p wbtools_oss --example check_pointer_input -- /path/to/flowdir.tif
//! ```

use std::env;
use wbraster::formats::geotiff::read as read_geotiff;

fn main() {
    let path = env::args().nth(1).expect("usage: check_pointer_input <geotiff>");
    let r = read_geotiff(&path).expect("read geotiff");
    let n = r.rows * r.cols;
    let mut nodata_cells = 0usize;
    let mut zero_cells = 0usize;
    let mut esri_dirs = 0usize;
    let mut other_positive = 0usize;
    const ESRI: [u8; 8] = [1, 2, 4, 8, 16, 32, 64, 128];

    for row in 0..r.rows {
        for col in 0..r.cols {
            let z = r.get(0, row as isize, col as isize);
            if r.is_nodata(z) {
                nodata_cells += 1;
                continue;
            }
            if z == 0.0 {
                zero_cells += 1;
                continue;
            }
            let zi = z as u8;
            if ESRI.contains(&zi) {
                esri_dirs += 1;
            } else if z > 0.0 {
                other_positive += 1;
            }
        }
    }

    println!("file: {}", path);
    println!("size: {} x {}  dtype={:?}  nodata(meta)={}", r.rows, r.cols, r.data_type, r.nodata);
    println!("nodata cells (is_nodata): {}", nodata_cells);
    println!("value == 0 (pit/no-flow, not meta nodata): {}", zero_cells);
    println!("ESRI direction codes (1,2,4,...,128): {}", esri_dirs);
    println!("other positive values: {}", other_positive);
    println!("valid + zero + nodata = {} (grid {})", esri_dirs + zero_cells + nodata_cells, n);

    if r.nodata == 0.0 {
        println!("note: nodata(meta)==0 — value 0 is nodata; pit sinks must use another code in this file.");
    } else if zero_cells > 0 {
        println!("note: nodata(meta)!={} — {} cells with value 0 are pits/sinks, not nodata.", r.nodata, zero_cells);
    }
}