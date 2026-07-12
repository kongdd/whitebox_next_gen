// SPDX-License-Identifier: MIT OR Apache-2.0
//
// `whitebox_hydro` —— 暴露 whitebox_next_gen 水文子集的 C ABI 动态库。
//
// 设计原则（一次做好一件事）：
//   1. cdylib 形态：C ABI 是跨语言 FFI 的事实标准
//   2. 所有入参/出参均为 JSON 字符串，避免暴露 Rust 内部类型
//   3. 调用方负责 free() 输出字符串（用 C 的 libc::free 配套）
//   4. 工具 dispatch 走单一注册表，CLI 和动态库共用同一逻辑
//
// ABI 见同目录 `wb_hydro.h`。

use std::collections::BTreeMap;
use std::ffi::{CStr, CString};
use std::os::raw::{c_char, c_int};
use std::ptr;
use std::time::Instant;

use anyhow::{Context, Result};
use serde_json::{json, Value};
use wbcore::{
    AllowAllCapabilities, ProgressSink, Tool, ToolArgs, ToolContext, ToolError, ToolMetadata,
    ToolRunResult,
};
use wbtools_oss::tools::{
    BasinsTool, BreachDepressionsLeastCostTool, D8FlowAccumTool, D8PointerTool, ExtractStreamsTool,
    FillDepressionsTool, JensonSnapPourPointsTool, StrahlerStreamOrderTool, StreamLinkClassTool,
    StreamLinkIdentifierTool, StreamLinkLengthTool, StreamLinkSlopeTool, WatershedTool,
};

// ===========================================================================
// 错误码（与 wb_hydro.h 保持一致）
// ===========================================================================

pub const WB_OK: c_int = 0;
pub const WB_ERR_NULL_ARG: c_int = -1;
pub const WB_ERR_INVALID_JSON: c_int = -2;
pub const WB_ERR_NOT_FOUND: c_int = -3;
pub const WB_ERR_VALIDATION: c_int = -4;
pub const WB_ERR_RUNTIME: c_int = -5;
pub const WB_ERR_INTERNAL: c_int = -6;
pub const WB_ERR_PANICKED: c_int = -7;

// ===========================================================================
// 工具注册表（CLI 与动态库共用）
// ===========================================================================

/// 工具路由表：内部稳定 id → 构造器
type ToolBuilder = fn() -> Box<dyn Tool>;

fn registry() -> Vec<(&'static str, ToolBuilder)> {
    vec![
        ("fill_depressions", || Box::new(FillDepressionsTool) as Box<dyn Tool>),
        (
            "breach_depressions_least_cost",
            || Box::new(BreachDepressionsLeastCostTool) as Box<dyn Tool>,
        ),
        ("d8_pointer", || Box::new(D8PointerTool) as Box<dyn Tool>),
        ("d8_flow_accum", || Box::new(D8FlowAccumTool) as Box<dyn Tool>),
        (
            "jenson_snap_pour_points",
            || Box::new(JensonSnapPourPointsTool) as Box<dyn Tool>,
        ),
        ("watershed", || Box::new(WatershedTool) as Box<dyn Tool>),
        ("basins", || Box::new(BasinsTool) as Box<dyn Tool>),
        (
            "strahler_stream_order",
            || Box::new(StrahlerStreamOrderTool) as Box<dyn Tool>,
        ),
        (
            "stream_link_identifier",
            || Box::new(StreamLinkIdentifierTool) as Box<dyn Tool>,
        ),
        (
            "stream_link_class",
            || Box::new(StreamLinkClassTool) as Box<dyn Tool>,
        ),
        (
            "stream_link_length",
            || Box::new(StreamLinkLengthTool) as Box<dyn Tool>,
        ),
        (
            "stream_link_slope",
            || Box::new(StreamLinkSlopeTool) as Box<dyn Tool>,
        ),
        (
            "extract_streams",
            || Box::new(ExtractStreamsTool) as Box<dyn Tool>,
        ),
    ]
}

/// 在路由表中查找工具构造器
fn lookup(id: &str) -> Option<Box<dyn Tool>> {
    registry().into_iter().find(|(k, _)| *k == id).map(|(_, b)| b())
}

// ===========================================================================
// 进度输出：写到 stderr；动态库场景下用户重定向即可关闭
// ===========================================================================

pub struct StderrSink {
    pub start: Instant,
    pub quiet: bool,
}

impl ProgressSink for StderrSink {
    fn info(&self, msg: &str) {
        if !self.quiet {
            let secs = self.start.elapsed().as_secs_f64();
            eprintln!("[{:7.2}s] {}", secs, msg);
        }
    }
    fn progress(&self, pct: f64) {
        if self.quiet {
            return;
        }
        // 仅当跨过 10% 整数倍时输出，避免刷屏
        let bucket = (pct * 10.0).floor() as i32;
        // 进程内单例：使用 thread_local 避免静态可变状态的 unsafe
        thread_local! {
            static LAST: std::cell::Cell<i32> = const { std::cell::Cell::new(-1) };
        }
        LAST.with(|c| {
            let prev = c.get();
            if bucket != prev && bucket >= 0 && bucket <= 10 {
                c.set(bucket);
                eprintln!(
                    "[{:7.2}s] progress {:>3}%",
                    self.start.elapsed().as_secs_f64(),
                    bucket * 10
                );
            }
        });
    }
}

// ===========================================================================
// 内部：运行工具（被动态库与 CLI 共用）
// ===========================================================================

#[derive(Debug)]
pub struct RunOutcome {
    pub status: String, // "ok" | "error"
    pub outputs: Value,
    pub error: Option<String>,
}

pub fn run(id: &str, mut args: BTreeMap<String, Value>, quiet: bool) -> Result<RunOutcome> {
    // 未识别的 id —— 报 Err 让 FFI 层映射为 WB_ERR_NOT_FOUND
    let tool = lookup(id)
        .ok_or_else(|| anyhow::anyhow!("未识别的工具 id：`{}`（用 `list` 查看）", id))?;

    // 若用户未提供 output 键，使用默认名
    if !args.contains_key("output") {
        let stem = id.replace('_', "-");
        args.insert("output".to_string(), json!(format!("{}.tif", stem)));
    }

    let start = Instant::now();
    let sink = StderrSink { start, quiet };
    let ctx = ToolContext {
        progress: &sink,
        capabilities: &AllowAllCapabilities,
    };

    let tool_args: ToolArgs = args;
    // 工具运行时错误也包为 Ok(RunOutcome) —— FFI 返回 WB_OK + body.status="error"
    // 仅 NOT_FOUND/INVALID_JSON/VALIDATION/INTERNAL 报为 Err 以返回错误码
    Ok(match tool.run(&tool_args, &ctx) {
        Ok(result) => outcome_ok(result, start.elapsed()),
        Err(e) => outcome_err(&e, start.elapsed()),
    })
}

fn outcome_ok(result: ToolRunResult, dur: std::time::Duration) -> RunOutcome {
    RunOutcome {
        status: "ok".into(),
        outputs: json!({
            "outputs": result.outputs,
            "elapsed_sec": dur.as_secs_f64(),
        }),
        error: None,
    }
}

fn outcome_err(e: &ToolError, dur: std::time::Duration) -> RunOutcome {
    RunOutcome {
        status: "error".into(),
        outputs: Value::Null,
        error: Some(format!("工具执行失败：{}（耗时 {:.2}s）", e, dur.as_secs_f64())),
    }
}

/// 列出所有工具 id
pub fn list_ids() -> Vec<&'static str> {
    registry().into_iter().map(|(k, _)| k).collect()
}

/// 列出所有工具的详细元数据
pub fn list_detailed() -> Vec<ToolMetadata> {
    registry()
        .into_iter()
        .map(|(_, b)| {
            let t = b();
            t.metadata()
        })
        .collect()
}

pub const VERSION: &str = env!("CARGO_PKG_VERSION");

// ===========================================================================
// 错误码映射：把 anyhow::Error 转换为 c_int
// ===========================================================================

fn map_anyhow(e: &anyhow::Error) -> c_int {
    let s = format!("{:#}", e);
    if s.contains("未识别") {
        WB_ERR_NOT_FOUND
    } else if s.contains("invalid JSON") || s.contains("JSON") {
        WB_ERR_INVALID_JSON
    } else if s.contains("validation") || s.contains("validate") {
        WB_ERR_VALIDATION
    } else {
        WB_ERR_INTERNAL
    }
}

// ===========================================================================
// C ABI：动态库导出
// ===========================================================================

/// 将 Rust 字符串移交到 C 调用方。
/// 用 libc 的 malloc，让调用方用 free() 释放。
fn hand_off(s: String) -> *mut c_char {
    match CString::new(s) {
        Ok(cs) => cs.into_raw(),
        Err(_) => ptr::null_mut(),
    }
}

/// 通用 panic 捕获：把所有 panic 转成错误响应（避免跨 FFI 边界未定义行为）
fn catch_unwind_json<F: FnOnce() -> Result<String> + std::panic::UnwindSafe>(
    f: F,
) -> (c_int, Option<String>) {
    match std::panic::catch_unwind(f) {
        Ok(Ok(s)) => (WB_OK, Some(s)),
        Ok(Err(e)) => {
            let code = map_anyhow(&e);
            (code, Some(format!("{{\"status\":\"error\",\"error\":\"{}\"}}", e)))
        }
        Err(p) => {
            let msg = if let Some(s) = p.downcast_ref::<&'static str>() {
                (*s).to_string()
            } else if let Some(s) = p.downcast_ref::<String>() {
                s.clone()
            } else {
                "panic with unknown payload".to_string()
            };
            (WB_ERR_PANICKED, Some(format!("{{\"status\":\"error\",\"error\":\"panic: {}\"}}", msg)))
        }
    }
}

/// 释放由 wb_hydro_* 分配的字符串
///
/// # Safety
/// `ptr` 必须是由 `wb_hydro_*` 函数返回的指针，或为 null。
#[no_mangle]
pub extern "C" fn wb_hydro_free(ptr: *mut c_char) {
    if ptr.is_null() {
        return;
    }
    // SAFETY: 由 wb_hydro_* 通过 CString::into_raw 移交；调用方负责不重复 free
    unsafe {
        let _ = CString::from_raw(ptr);
    }
}

/// 返回版本字符串（静态生命周期，调用方**不**应 free）
#[no_mangle]
pub extern "C" fn wb_hydro_version() -> *const c_char {
    // 静态字符串，无需释放
    concat!(env!("CARGO_PKG_VERSION"), "\0").as_ptr() as *const c_char
}

/// 列出所有可用工具 id（JSON 数组字符串）。
///
/// # Safety
/// 调用方必须传入非空 `out_json` 指针；本函数会写入一个由 `wb_hydro_free` 释放的字符串。
#[no_mangle]
pub extern "C" fn wb_hydro_list_tools(out_json: *mut *mut c_char) -> c_int {
    if out_json.is_null() {
        return WB_ERR_NULL_ARG;
    }
    let (code, opt) = catch_unwind_json(|| {
        let ids = list_ids();
        let v: Vec<String> = ids.iter().map(|s| s.to_string()).collect();
        Ok(serde_json::to_string(&v)?)
    });
    match opt {
        Some(s) => {
            unsafe {
                *out_json = hand_off(s);
            }
            code
        }
        None => code,
    }
}

/// 列出所有工具的元数据（JSON 数组）。
///
/// # Safety
/// 同 `wb_hydro_list_tools`。
#[no_mangle]
pub extern "C" fn wb_hydro_list_tools_detailed(out_json: *mut *mut c_char) -> c_int {
    if out_json.is_null() {
        return WB_ERR_NULL_ARG;
    }
    let (code, opt) = catch_unwind_json(|| {
        let metas = list_detailed();
        // 序列化为精简 JSON：仅暴露公开字段
        let v: Vec<Value> = metas
            .iter()
            .map(|m| {
                json!({
                    "id": m.id,
                    "display_name": m.display_name,
                    "summary": m.summary,
                    "category": format!("{:?}", m.category),
                    "license_tier": format!("{:?}", m.license_tier),
                    "params": m.params.iter().map(|p| json!({
                        "name": p.name,
                        "description": p.description,
                        "required": p.required,
                    })).collect::<Vec<_>>(),
                })
            })
            .collect();
        Ok(serde_json::to_string(&v)?)
    });
    match opt {
        Some(s) => {
            unsafe {
                *out_json = hand_off(s);
            }
            code
        }
        None => code,
    }
}

/// 运行指定工具。
///
/// # Safety
/// - `id` 与 `args_json` 必须是合法的 UTF-8 C 字符串（可为 null 表示空）
/// - `out_json` 必须非空；本函数会写入由 `wb_hydro_free` 释放的字符串
#[no_mangle]
pub extern "C" fn wb_hydro_run(
    id: *const c_char,
    args_json: *const c_char,
    out_json: *mut *mut c_char,
) -> c_int {
    if out_json.is_null() {
        return WB_ERR_NULL_ARG;
    }
    if id.is_null() {
        unsafe {
            *out_json = hand_off(
                "{\"status\":\"error\",\"error\":\"id is null\"}".to_string(),
            );
        }
        return WB_ERR_NULL_ARG;
    }

    // SAFETY: 调用方保证指针有效；parse 失败立即返回错误
    let id_str = unsafe { CStr::from_ptr(id) }
        .to_str()
        .map_err(|e| anyhow::anyhow!("id 不是合法 UTF-8：{}", e));
    let id_owned = match id_str {
        Ok(s) => s.to_string(),
        Err(e) => {
            let code = map_anyhow(&e);
            unsafe {
                *out_json = hand_off(format!(
                    "{{\"status\":\"error\",\"error\":\"{}\"}}",
                    e
                ));
            }
            return code;
        }
    };

    let args_owned: String = if args_json.is_null() {
        "{}".to_string()
    } else {
        match unsafe { CStr::from_ptr(args_json) }.to_str() {
            Ok(s) => s.to_string(),
            Err(e) => {
                let ae = anyhow::anyhow!("args_json 不是合法 UTF-8：{}", e);
                let code = map_anyhow(&ae);
                unsafe {
                    *out_json = hand_off(format!(
                        "{{\"status\":\"error\",\"error\":\"{}\"}}",
                        ae
                    ));
                }
                return code;
            }
        }
    };

    let (code, opt) = catch_unwind_json(|| -> Result<String> {
        let map: BTreeMap<String, Value> = serde_json::from_str(&args_owned)
            .with_context(|| format!("args_json 解析失败：{}", args_owned))?;
        let outcome = run(&id_owned, map, true).with_context(|| format!("运行 {}", id_owned))?;
        let mut resp = serde_json::Map::new();
        resp.insert("status".into(), json!(outcome.status));
        resp.insert("elapsed_sec".into(), json!(outcome.outputs.get("elapsed_sec").cloned().unwrap_or(json!(0.0))));
        if let Some(err) = outcome.error {
            resp.insert("error".into(), json!(err));
        } else if let Some(outputs) = outcome.outputs.get("outputs") {
            resp.insert("outputs".into(), outputs.clone());
        }
        Ok(serde_json::to_string(&resp)?)
    });

    match opt {
        Some(s) => {
            unsafe {
                *out_json = hand_off(s);
            }
            code
        }
        None => code,
    }
}

// ===========================================================================
// 单元测试
// ===========================================================================

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn registry_has_thirteen_tools() {
        assert_eq!(registry().len(), 13);
        assert!(lookup("watershed").is_some());
        assert!(lookup("stream_link_identifier").is_some());
        assert!(lookup("nonexistent_tool").is_none());
    }

    #[test]
    fn list_ids_returns_all() {
        let ids = list_ids();
        assert_eq!(ids.len(), 13);
        assert!(ids.contains(&"watershed"));
        assert!(ids.contains(&"d8_pointer"));
        assert!(ids.contains(&"stream_link_slope"));
    }

    #[test]
    fn run_unknown_id_returns_err() {
        // NOT_FOUND 必须以 Err 形式返回，FFI 层映射为 WB_ERR_NOT_FOUND
        let result = run("not_a_tool", BTreeMap::new(), true);
        assert!(result.is_err());
        assert!(format!("{:#}", result.unwrap_err()).contains("未识别的工具 id"));
    }

    #[test]
    fn cstr_round_trip() {
        let s = hand_off("hello".to_string());
        assert!(!s.is_null());
        let back = unsafe { CStr::from_ptr(s) }.to_str().unwrap();
        assert_eq!(back, "hello");
        wb_hydro_free(s);
    }

    #[test]
    fn list_tools_json_is_valid_array() {
        let mut out: *mut c_char = ptr::null_mut();
        let code = wb_hydro_list_tools(&mut out);
        assert_eq!(code, WB_OK);
        assert!(!out.is_null());
        let s = unsafe { CStr::from_ptr(out) }.to_str().unwrap();
        let v: Vec<String> = serde_json::from_str(s).unwrap();
        assert_eq!(v.len(), 13);
        wb_hydro_free(out);
    }

    #[test]
    fn list_detailed_json_includes_params() {
        let mut out: *mut c_char = ptr::null_mut();
        let code = wb_hydro_list_tools_detailed(&mut out);
        assert_eq!(code, WB_OK);
        let s = unsafe { CStr::from_ptr(out) }.to_str().unwrap();
        let v: Vec<Value> = serde_json::from_str(s).unwrap();
        assert_eq!(v.len(), 13);
        let watershed = v.iter().find(|x| x["id"] == "watershed").unwrap();
        let params = watershed["params"].as_array().unwrap();
        let names: Vec<&str> = params.iter().map(|p| p["name"].as_str().unwrap()).collect();
        assert!(names.contains(&"d8_pntr"));
        assert!(names.contains(&"pour_pts"));
        // 验证 StreamLink 工具参数是 streams_raster（不是 streams）
        let sli = v.iter().find(|x| x["id"] == "stream_link_identifier").unwrap();
        let sli_params: Vec<&str> = sli["params"]
            .as_array().unwrap()
            .iter().map(|p| p["name"].as_str().unwrap()).collect();
        assert!(sli_params.contains(&"streams_raster"));
        wb_hydro_free(out);
    }

    #[test]
    fn run_with_invalid_json_yields_error_code() {
        let mut out: *mut c_char = ptr::null_mut();
        let id = b"watershed\0".as_ptr() as *const c_char;
        let bad = b"{not json\0".as_ptr() as *const c_char;
        let code = wb_hydro_run(id, bad, &mut out);
        assert!(code < 0);
        assert!(!out.is_null());
        wb_hydro_free(out);
    }

    #[test]
    fn null_out_returns_null_arg_error() {
        assert_eq!(wb_hydro_list_tools(ptr::null_mut()), WB_ERR_NULL_ARG);
        assert_eq!(wb_hydro_list_tools_detailed(ptr::null_mut()), WB_ERR_NULL_ARG);
    }

    #[test]
    fn version_is_not_null() {
        let p = wb_hydro_version();
        assert!(!p.is_null());
        let s = unsafe { CStr::from_ptr(p) }.to_str().unwrap();
        assert!(s.starts_with("0.1."));
    }
}
