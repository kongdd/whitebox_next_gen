# 水文模块单独编译 —— 方案 A 实施报告与待审稿

## 目标
- 让 wbtools_oss 可以按工具族拆分编译，水文子集不链接 lidar / spatial-stats / geostats / ureq / smartcore / rustfft / kdtree 等重依赖。
- 不破坏 wbtools_oss 单一注册表的现有结构。
- 不复制源码到新 crate。
- 体积缩减与"分 crate"等价。

## 已实施改动（git 已落盘）

| 文件 | 改动 | 行数 |
|---|---|---|
| `crates/wbtools_oss/Cargo.toml` | 加 `[features]`、10 个工具族 feature、可选依赖转 optional | +96 / -17 |
| `crates/wbtools_oss/src/tools/mod.rs` | 每个 `mod` 声明 + 每行 `pub use <mod>::Tool` 加 `#[cfg(feature = "...")]` | +790 |
| `crates/wbtools_oss/src/lib.rs` | 733 行 `register_default_tools` 加 cfg；函数整体加 all-features 守卫 | +734 |
| `crates/wbtools_oss/src/tools/stream_network_analysis/mod.rs` | `mod pro_stream_tools` + `pub use` 加 all-features 守卫 | +4 |

合计 +1620 / -33。

## feature 设计

```toml
[features]
default = [
    "hydrology", "flow_algorithms", "stream_network_analysis",
    "geomorphometry", "raster", "data_tools",
    "gis", "geostats", "remote_sensing", "lidar",
]
hydrology               = ["flow_algorithms", "stream_network_analysis"]
flow_algorithms         = ["dep:rand"]
stream_network_analysis = ["flow_algorithms"]
geomorphometry          = ["dep:chrono", "dep:image", "dep:wide", "dep:rand"]
raster                  = ["dep:evalexpr", "dep:kdtree", "dep:nalgebra", "dep:rand", "dep:rustfft"]
data_tools              = ["dep:kdtree", "dep:wbgeotiff"]
gis                     = ["dep:chrono", "dep:evalexpr", "dep:kdtree", "dep:nalgebra", "dep:rand", "dep:wbspatialstats"]
geostats                = ["dep:wbspatialstats"]
remote_sensing          = ["dep:bincode", "dep:image", "dep:kdtree", "dep:nalgebra", "dep:smartcore", "dep:time", "dep:ureq"]
lidar                   = ["dep:evalexpr", "dep:kdtree", "dep:nalgebra", "dep:rand", "dep:wblidar", "dep:wide"]
all = [...]   # 等价 default 的便捷别名
```

**mod 交叉依赖**（源码 import 决定）：
- `hydrology` 源码 import 了 `flow_algorithms` 与 `stream_network_analysis` 的工具类型 → 必须隐含这两个 feature
- `stream_network_analysis` import 了 `flow_algorithms` → 同理

## 验证结果

```bash
$ cargo check -p wbtools_oss                                     # 默认（all features） ✅
$ cargo check -p wbtools_oss --no-default-features --features hydrology  # 仅水文 ✅
```

`wbtools_hydro` / `whitebox_hydro_cli` 这两个孤儿 crate **未处理**，需要 reviewer 拍板。

---

## 待 reviewer 评估的 5 个取舍点

### ① `tools/mod.rs` / `lib.rs` 加 cfg 的粒度：每行 vs 块 vs 整 mod

**当前实现**：1495 个 cfg 行（每个 mod 声明 + 每个 `pub use Tool` 行 + 每个 `register` 行）

**替代方案**：

| 方案 | 粒度 | cfg 行数 | 下游影响 |
|---|---|---|---|
| A. 每行 cfg（已做） | 最小 | ~1500 | 无 |
| B. 整 mod 文件 cfg | 只在 `tools/<mod>/mod.rs` 头加一行 `#[cfg(feature = "...")]` 包裹 | 10 | **`pub use <mod>::Tool` 不可跨 feature 引用**（打破单注册表） |
| C. cfg 包 mod 声明 + `pub use` 块首尾 | 块级 | ~30 | 与 A 等价但粒度粗、易误伤（同块跨 mod 时仍漏 cfg） |

**建议**：维持 A（已做），原因：粒度最细、最贴近 Rust idiom、不会误伤。

### ② `register_default_tools` 整体加 all-features 守卫

**当前实现**：`#[cfg(all(feature = ...))] pub fn register_default_tools(...) { ... }`

**取舍**：
- 精简构建（`--features hydrology`）下，**`wbtools_oss::register_default_tools` 不可用**
- 下游 `wbw_python` / `wbw_r` 默认 features（含 all），不受影响
- 用户若想精简构建并保留 `register_default_tools`，需要自己写按 feature 分支的注册循环

**替代方案**：把每个 mod 的 register 函数搬进各 mod.rs，然后 `register_default_tools` 按 feature 调各 mod.register：

```rust
pub fn register_default_tools(reg: &mut ToolRegistry) {
    #[cfg(feature = "hydrology")] tools::hydrology::register(reg);
    #[cfg(feature = "gis")]      tools::gis::register(reg);
    // ...
}
```

需要给每个 mod.rs 加 ~30 行的 `register` 函数（共 10 个 mod）。**多写 ~300 行，少 1495 行 cfg 标注**。

**建议**：等 reviewer 决定是否重构。当前实现已通过编译验证，可工作。

### ③ `pro_stream_tools.rs` 加 all-features 守卫

**原因**：该文件用了 4 个跨 mod 工具（`ElevationPercentileTool` / `SlopeTool` / `RemoveRasterPolygonHolesTool` / `ClosingTool`），精简构建下找不到符号。

**取舍**：精简构建下 **3 个 Pro 工具不可用**（`PruneVectorStreamsTool` / `RiverCenterlinesTool` / `RidgeAndValleyVectorsTool`）。

**替代方案**：把这 4 个 import + 4 处 `ToolType.run(...)` 调用搬到 `pro_stream_tools.rs` 内部、用 cfg 包住——需要改 1654 行文件。

**建议**：维持当前守卫。原因：Pro 工具本就是商业版，精简构建本来就用不到。

### ④ `wbtools_hydro` / `whitebox_hydro_cli` 怎么处理

**当前状态**：两个孤儿 crate（未加入 workspace，cargo check 直接报错）。

**三个选择**：

| 选择 | 动作 | 影响 |
|---|---|---|
| 删除 | `rm -rf crates/wbtools_hydro crates/whitebox_hydro_cli` | 丢失约 360 行 CLI 包装代码 + 13 个工具的硬编码路由 |
| 改为重导出 | `crates/wbtools_hydro/src/lib.rs` 仅 `pub use wbtools_oss::tools::*;` 不复制代码 | 保留 crate 名 / CLI 入口；零代码重复 |
| 加入 workspace | 修 `Cargo.toml` 让它能编译 | 维持现状但仍带 ~11k 行代码副本 |

**建议**：**删除两个 crate**。理由：
- 精简构建已经能通过 `wbtools_oss::tools::*` 直接拿到所需工具类型
- 如果未来需要 C ABI，直接在 `wbtools_oss` 上加 cdylib crate-type 即可，无需新增 wbtools_hydro 这一层
- 现存的 CLI / 动态库包装可直接由 wbw_python/wbw_r 已有的 FFI 模式复用

### ⑤ `param_docs.rs` / `raster_stack_validator.rs` 始终编译

**当前实现**：两个工具未加 cfg 守卫，始终链接（约 716 行 + 210 KB JSON）。

**取舍**：精简构建仍会带上这俩，因为它们是公开 API（被 wbw_python / wbw_r 的 `tool_param_*` 系列函数间接调用）。

**替代方案**：把 `param_docs` / `raster_stack_validator` 也加 cfg 守卫，下游若用得到就自己 `cfg(feature = "all")`。

**建议**：维持现状。原因：~700 行 + 200 KB JSON 对精简构建体积影响有限（< 5%），且保持 API 简单。

---

## 验证清单

```bash
# 默认构建（all features）
cargo check -p wbtools_oss                                    # ✅
cargo check -p wbtools_oss --all-features                     # ✅

# 精简构建（仅水文）
cargo check -p wbtools_oss --no-default-features --features hydrology  # ✅

# 单 feature 组合（待补）
cargo check -p wbtools_oss --no-default-features --features gis        # ⏳
cargo check -p wbtools_oss --no-default-features --features raster     # ⏳
cargo check -p wbtools_oss --no-default-features --features lidar      # ⏳

# 下游 wbw_python / wbw_r（默认 features）
cargo check -p wbw_python                                    # ⏳
cargo check -p wbw_r                                         # ⏳
```

## 提交建议

```bash
git checkout HEAD -- crates/wbtools_oss/src/lib.rs  # 若仅评估方案，先回滚源码改动
# 提交顺序：
# 1. Cargo.toml: 加 features + 改 optional deps
# 2. tools/mod.rs + lib.rs + stream_network_analysis/mod.rs: 加 cfg
# 3. 删除 crates/wbtools_hydro + crates/whitebox_hydro_cli（若 reviewer 同意）
```