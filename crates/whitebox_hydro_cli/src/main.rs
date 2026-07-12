// SPDX-License-Identifier: MIT OR Apache-2.0
//
// `whitebox-hydro` —— 动态库的薄 CLI 包装。
// 核心逻辑在 `lib.rs`（cdylib），这里只做参数解析与人类可读的输出。

use std::collections::BTreeMap;
use std::env;
use std::process::ExitCode;

use serde_json::{json, Value};
use whitebox_hydro::{list_detailed, list_ids, run, RunOutcome, VERSION};

fn main() -> ExitCode {
    let argv: Vec<String> = env::args().skip(1).collect();
    if argv.is_empty() || argv[0] == "-h" || argv[0] == "--help" {
        print_help();
        return ExitCode::SUCCESS;
    }

    match argv[0].as_str() {
        "list" | "ls" => cmd_list(),
        "info" => cmd_info(&argv[1..]),
        "version" | "-V" | "--version" => {
            println!("whitebox-hydro {}", VERSION);
            ExitCode::SUCCESS
        }
        sub => {
            // 形如：<subcommand> --k v ...  →  路由到对应工具
            let (pos, named) = match parse_args(&argv[1..]) {
                Ok(v) => v,
                Err(e) => {
                    eprintln!("[error] 参数解析失败：{}", e);
                    return ExitCode::from(2);
                }
            };
            if !pos.is_empty() {
                eprintln!("[error] 子命令 `{}` 不接受位置参数：{:?}", sub, pos);
                return ExitCode::from(2);
            }
            let id = kebab_to_id(sub).ok_or_else(|| {
                format!(
                    "未知子命令：`{}`（用 `whitebox-hydro list` 查看）",
                    sub
                )
            });
            let id = match id {
                Ok(s) => s,
                Err(e) => {
                    eprintln!("[error] {}", e);
                    return ExitCode::from(2);
                }
            };
            let outcome = match run(&id, named, false) {
                Ok(o) => o,
                Err(e) => {
                    eprintln!("[error] {:#}", e);
                    return ExitCode::from(1);
                }
            };
            report(&id, &outcome);
            if outcome.status == "ok" {
                ExitCode::SUCCESS
            } else {
                ExitCode::from(1)
            }
        }
    }
}

// ---------------------------------------------------------------------------
// 子命令 → 工具 id 映射（与 lib.rs 的 registry 保持同步）
// ---------------------------------------------------------------------------

fn kebab_to_id(s: &str) -> Option<&'static str> {
    Some(match s {
        "fill-depressions" => "fill_depressions",
        "breach-depressions" => "breach_depressions_least_cost",
        "d8-pointer" => "d8_pointer",
        "d8-flow-accum" => "d8_flow_accum",
        "jenson-snap-pour-points" => "jenson_snap_pour_points",
        "watershed" => "watershed",
        "basins" => "basins",
        "strahler-order" => "strahler_stream_order",
        "stream-link-identifier" => "stream_link_identifier",
        "stream-link-class" => "stream_link_class",
        "stream-link-length" => "stream_link_length",
        "stream-link-slope" => "stream_link_slope",
        "extract-streams" => "extract_streams",
        _ => return None,
    })
}

// ---------------------------------------------------------------------------
// 列表 / 详情
// ---------------------------------------------------------------------------

fn cmd_list() -> ExitCode {
    let ids = list_ids();
    println!("whitebox-hydro v{} —— 水文子集工具（{} 个）", VERSION, ids.len());
    for (i, id) in ids.iter().enumerate() {
        println!("  {:>2}. {}", i + 1, id);
    }
    println!("\n更多信息：`whitebox-hydro info <id>`");
    println!("动态库 ABI 见 `wb_hydro.h`；可用 `wb_hydro_list_tools_detailed()` 查询元数据。");
    ExitCode::SUCCESS
}

fn cmd_info(args: &[String]) -> ExitCode {
    let id = match args.first() {
        Some(s) => s.as_str(),
        None => {
            eprintln!("[error] `info` 需要一个工具 id");
            return ExitCode::from(2);
        }
    };
    let id = kebab_to_id(id).unwrap_or(id);
    let metas = list_detailed();
    let meta = match metas.iter().find(|m| m.id == id) {
        Some(m) => m,
        None => {
            eprintln!("[error] 未找到工具：`{}`", id);
            return ExitCode::from(2);
        }
    };
    println!("{} —— {}", meta.id, meta.display_name);
    println!("\n{}\n", meta.summary);
    println!("参数：");
    for p in &meta.params {
        let req = if p.required { "必填" } else { "可选" };
        println!("  --{:<24}  [{}]  {}", p.name.replace('_', "-"), req, p.description);
    }
    ExitCode::SUCCESS
}

// ---------------------------------------------------------------------------
// 输出报告
// ---------------------------------------------------------------------------

fn report(id: &str, o: &RunOutcome) {
    if o.status == "ok" {
        eprintln!("[done] {}", id);
        if let Some(outputs) = o.outputs.get("outputs") {
            eprintln!("[done] outputs: {}", outputs);
        }
    } else if let Some(err) = &o.error {
        eprintln!("[error] {}", err);
    }
}

// ---------------------------------------------------------------------------
// 极简参数解析（与之前版本一致，但去掉了 C ABI 相关代码）
// ---------------------------------------------------------------------------

type Parsed = (Vec<String>, BTreeMap<String, Value>);

fn parse_args(argv: &[String]) -> Result<Parsed, String> {
    let mut positional = Vec::new();
    let mut named: BTreeMap<String, Value> = BTreeMap::new();

    let mut i = 0;
    while i < argv.len() {
        let tok = &argv[i];
        if tok == "--" {
            // 剩余全部视为位置参数
            positional.extend(argv[i + 1..].iter().cloned());
            break;
        }
        if tok.starts_with("--") {
            if tok == "--" {
                break;
            }
            let rest = &tok[2..];
            if rest.is_empty() {
                return Err("孤立的 '--'".into());
            }
            if let Some(eq) = rest.find('=') {
                let key = alias(&canonicalize_key(&rest[..eq]));
                let val = &rest[eq + 1..];
                named.insert(key, parse_value(val));
            } else {
                let key = alias(&canonicalize_key(rest));
                if i + 1 < argv.len() && !is_flag_token(&argv[i + 1]) {
                    let val = &argv[i + 1];
                    if val == "true" || val == "false" {
                        named.insert(key, json!(val.parse::<bool>().unwrap()));
                    } else {
                        named.insert(key, json!(val));
                    }
                    i += 1;
                } else {
                    named.insert(key, json!(true));
                }
            }
        } else if tok.starts_with('-') && tok.len() > 1 && !tok.starts_with("--") {
            // 短形式：-o value / -o=value / -x（旗标）
            let rest = &tok[1..];
            if let Some(eq) = rest.find('=') {
                let key = alias(&canonicalize_key(&rest[..eq]));
                let val = &rest[eq + 1..];
                named.insert(key, parse_value(val));
            } else {
                let key = alias(&canonicalize_key(rest));
                if i + 1 < argv.len() && !is_flag_token(&argv[i + 1]) {
                    let val = &argv[i + 1];
                    if val == "true" || val == "false" {
                        named.insert(key, json!(val.parse::<bool>().unwrap()));
                    } else {
                        named.insert(key, json!(val));
                    }
                    i += 1;
                } else {
                    named.insert(key, json!(true));
                }
            }
        } else {
            positional.push(tok.clone());
        }
        i += 1;
    }
    Ok((positional, named))
}

fn canonicalize_key(k: &str) -> String {
    k.replace('-', "_")
}

/// 判断 token 是否像"旗标"（下一参数应作为值）
fn is_flag_token(s: &str) -> bool {
    s.starts_with('-') && s != "-" && s != "--"
}

/// CLI 短名 → 工具参数名 的别名映射
fn alias(k: &str) -> String {
    match k {
        "o" => "output".to_string(),
        "i" => "input".to_string(),
        other => other.to_string(),
    }
}

fn parse_value(s: &str) -> Value {
    if s == "true" {
        return json!(true);
    }
    if s == "false" {
        return json!(false);
    }
    if let Ok(n) = s.parse::<i64>() {
        return json!(n);
    }
    if let Ok(f) = s.parse::<f64>() {
        if s.contains('.') || s.contains('e') || s.contains('E') {
            return json!(f);
        }
    }
    json!(s)
}

// ---------------------------------------------------------------------------
// 帮助
// ---------------------------------------------------------------------------

fn print_help() {
    let prog = env::args().next().unwrap_or_else(|| "whitebox-hydro".into());
    println!(
        "{prog} —— whitebox_next_gen 水文子集 CLI（动态库 `libwhitebox_hydro` 的薄包装）

用法：
  {prog} list
  {prog} info <子命令>
  {prog} <子命令> [--key value ...] [-o output.tif]

子命令（kebab 形式，参数键名中 '-' 等同于 '_'）：
  fill-depressions        --dem <dem.tif> [-o filled.tif]
  breach-depressions      --dem <dem.tif> [-o breached.tif]
  d8-pointer              --dem <dem.tif> [-o d8.tif] [--esri-pntr]
  d8-flow-accum           --input <d8.tif|dem.tif> [-o acc.tif] [--out-type cells|ca|sca]
                                       [--log-transform] [--input-is-pointer] [--esri-pntr]
  jenson-snap-pour-points --pour-pts <pts.shp> --streams <streams.tif>
                                       [--snap-dist 100.0] [-o snapped.shp]
  watershed               --d8-pntr <d8.tif> --pour-pts <pts.shp> [-o ws.tif]
                                       [--esri-pntr]
  basins                  --d8-pntr <d8.tif> [-o basins.tif] [--esri-pntr]
  strahler-order          --d8-pntr <d8.tif> --streams <streams.tif> [-o order.tif]
                                       [--esri-pntr] [--zero-background]
  stream-link-identifier  --d8-pntr <d8.tif> --streams-raster <streams.tif> [-o link-id.tif]
  stream-link-class       --d8-pntr <d8.tif> --streams-raster <streams.tif> [-o link-class.tif]
  stream-link-length      --d8-pntr <d8.tif> --streams-raster <streams.tif> [-o link-len.tif]
  stream-link-slope       --d8-pntr <d8.tif> --streams-raster <streams.tif> [-o link-slp.tif]
  extract-streams         --flow-accumulation <acc.tif> [--threshold 1000.0]
                                       [--zero-background] [-o streams.tif]

跨语言调用：本 crate 同时编译为动态库 `libwhitebox_hydro.{{so,dll,dylib}}`。
  ABI 见同目录 `wb_hydro.h`：
    int wb_hydro_run(const char* id, const char* args_json, char** out_json);
    int wb_hydro_list_tools(char** out_json);
    void wb_hydro_free(char* ptr);

示例：
  {prog} d8-pointer --dem ../data/Hubei_demfill.tif -o /tmp/d8.tif
  {prog} watershed --d8-pntr /tmp/d8.tif --pour-pts pour.shp -o /tmp/ws.tif
  {prog} stream-link-identifier --d8-pntr /tmp/d8.tif --streams-raster /tmp/streams.tif -o /tmp/link-id.tif"
    );
}
