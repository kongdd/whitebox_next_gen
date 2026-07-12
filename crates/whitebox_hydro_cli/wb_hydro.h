// SPDX-License-Identifier: MIT OR Apache-2.0
//
// `wb_hydro.h` —— whitebox_hydro 动态库 C ABI 头文件
//
// 链接：本头文件与 `libwhitebox_hydro.{{so,dll,dylib}}` 配合。
// 内存契约：所有 `out_json` 字符串必须用 `wb_hydro_free()` 释放（C 的 free() 也可）。
// 线程安全：所有函数可重入；不同线程调用同一函数互不干扰（工具内部按需并行）。

#ifndef WB_HYDRO_H
#define WB_HYDRO_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

// ----- 错误码 -------------------------------------------------------------
#define WB_OK               0   // 成功
#define WB_ERR_NULL_ARG    -1   // 必填指针为 null
#define WB_ERR_INVALID_JSON -2  // args_json 解析失败
#define WB_ERR_NOT_FOUND   -3   // 工具 id 不存在
#define WB_ERR_VALIDATION  -4   // 工具 validate() 失败
#define WB_ERR_RUNTIME     -5   // 工具 run() 失败
#define WB_ERR_INTERNAL    -6   // 内部错误
#define WB_ERR_PANICKED    -7   // Rust 端 panic（已捕获，但表示严重问题）

// ----- 元数据 -------------------------------------------------------------

/// 返回版本字符串（静态，**勿** free）
const char* wb_hydro_version(void);

/// 列出所有可用工具 id（JSON 数组字符串，如 ["d8_pointer","watershed",...]）。
/// 调用方负责 wb_hydro_free(*out_json)。
int32_t wb_hydro_list_tools(char** out_json);

/// 列出所有工具的详细元数据（JSON 数组，每元素含 id/display_name/summary/params）。
/// 调用方负责 wb_hydro_free(*out_json)。
int32_t wb_hydro_list_tools_detailed(char** out_json);

// ----- 工具调用 -----------------------------------------------------------

/// 运行指定工具。
///
/// 参数：
///   id          工具 id（UTF-8 C 字符串，必填），如 "d8_pointer"
///   args_json   参数 JSON 对象（UTF-8 C 字符串，可为 null 表示 "{}"）。
///               例：`{"dem":"a.tif","output":"b.tif","esri_pntr":false}`
///   out_json    接收输出 JSON 字符串。成功时形如：
///                 {"status":"ok","elapsed_sec":1.23,"outputs":{"primary":"..."}}
///               失败时形如：
///                 {"status":"error","error":"..."}
///
/// 返回：WB_OK 或负的错误码。
/// 内存契约：成功时 *out_json 由 wb_hydro_free 释放；返回错误时也保证 *out_json 非 null。
int32_t wb_hydro_run(const char* id, const char* args_json, char** out_json);

// ----- 内存管理 -----------------------------------------------------------

/// 释放由 wb_hydro_* 分配的字符串（NULL 指针安全）。
void wb_hydro_free(char* ptr);

#ifdef __cplusplus
}
#endif

#endif // WB_HYDRO_H
