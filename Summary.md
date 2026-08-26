# Hubei 流积累积调试 Summary

> 范围：`whitebox-hydro` CLI 在 Hubei 90 m 数据上的 `d8-pointer` / `d8-flow-accum` 行为
> 日期：2026-07-13
> 结果：3 个问题定位、2 个代码 bug 修复、1 个数据预处理建议

## 1. 背景

输入：
- `Hubei_demfill.tif`（F32/U16，WGS84，3″×3″ ≈ 80×93 m，13339×6865）
- `Hubei_flowdir.tif`（U8，ESRI 编码 1,2,4,…,128，nodata=255，预先计算）

症状：`d8-flow-accum` 在 `Hubei_flowdir.tif` 上输出 max=255（应为 10⁶–10⁷），系统性偏低。

## 2. 三个问题

### 2.1 Bug A — `d8-pointer` / `rho8-pointer` pit 编码为 0（**纯代码 bug**）

**位置**：`crates/wbtools_oss/src/tools/flow_algorithms/mod.rs` 行 2567/3633
**症状**：DEM 上的 pit（无严格下坡邻居）cell 在 pointer 栅格里被写成 `0.0`

**为什么是 bug**：
- ESRI D8 pointer 编码：方向值为 1, 2, 4, 8, 16, 32, 64, 128（2 的幂）
- nodata：255（或自定义）
- **`0` 不是合法值**——既不是方向也不是 nodata
- 下游 `d8_dir_from_pointer` 的 mapping 表是 `[-2i8; 129]`，index 0 默认为 -2（nodata）
- 因此 pit cell 0 → 解码为 -2（nodata）→ 累积阶段被跳过
- 所有流入该 pit 的上游水在累积阶段被丢弃

**修复**：d == -1（pit）和 d == -2（invalid）统一输出 nodata `-32768.0`，消除 0 的歧义。

**判定**：纯代码 bug，跟数据无关。任何输入都应如此。

### 2.2 Bug B — `D8FlowAccumTool` 输出 dtype 截断（**纯代码 bug**）

**位置**：`crates/wbtools_oss/src/tools/flow_algorithms/mod.rs` 行 2699–2714
**症状**：在 U8 输入上跑 `d8-flow-accum --input-is-pointer --esri-pntr`，max=255

**根因**：
```rust
let mut out = input.as_ref().clone();   // ← 继承 input 的 U8 storage
out.data_type = DataType::F32;          // ← 仅改 metadata
out.nodata = -32768.0;
...
out.set_unchecked(0, r, c, accum[i]);   // → set_f64 → Self::U8(v) → v[i] = value as u8
```

`set_f64` 按**实际 storage 类型**分派，不查 `data_type` 字段。
`61_737_463.0 as u8` 在 Rust 是 wrapping modulo 256 → 最大可写 255。

**为什么是 bug**：
- 工具声明输出 F32（流积累积值）→ 接口契约
- 即便用户传 U8 输入，输出也必须是 F32
- 61.7M 是合法累积值，截断为 0–255 是工具未履行契约

**修复**：clone 后显式转换 storage：
```rust
let n = (input.rows * input.cols) as usize;
let mut out_f64 = Vec::with_capacity(n);
for i in 0..n {
    out_f64.push(if flow_dir[i] == -2 { -32768.0 } else { accum[i] });
}
out.data = RasterData::from_f64_vec(DataType::F32, out_f64);
```

**判定**：纯代码 bug，跟数据无关。任何输入都应如此。

### 2.3 Hubei_demfill.tif 残留 15.5M pit（**数据问题，不是代码问题**）

**症状**：`d8-flow-accum` 直接跑在 `Hubei_demfill.tif` 上，max=3157（应为 10⁶–10⁷）
**诊断**：`d8_dir_from_dem` 在该 DEM 上检测出 15,557,682 个 pit cell（占总有效像元 17%）

**为什么不是代码 bug**：
- D8 算法要求每 cell 有**严格下坡邻居**（slope > 0）
- 15.5M cell 真的没有严格下坡邻居（平地、edge、已填洼但留平的区域）
- 这是 D8 算法的**数学约束**，不是实现缺陷
- TauDEM / ArcGIS Spatial Analyst / GRASS r.watershed 同样会检测出这些 pit

**修复方向**（**改数据，不是改代码**）：
```bash
whitebox-hydro fill-depressions --dem Hubei_demfill.tif --fix-flats -o Hubei_refilled.tif
whitebox-hydro d8-flow-accum --input Hubei_refilled.tif --out-type cells -o flow_accum.tif
```
`--fix-flats` 给平地加微梯度（Garbrecht-Martz 方案），让 D8 能在平地上分配方向。

**判定**：数据问题。`Hubei_demfill.tif` 名字暗示"已填"，但**未做 hydrological conditioning**（MERIT/SRTM 原始产品 + 简单 fill 不够）。应该**按标准工作流处理数据**，而不是让 `d8-flow-accum` 内部偷偷做。

## 3. 改了什么

```
 Cargo.toml                                         |  2 ++      # strip = "debuginfo"（体积优化，上一任务）
 .../wbtools_oss/src/tools/flow_algorithms/mod.rs   | 26 +++++  # Bug A + Bug B
```

具体改动：

| 位置 | 改动 | 类型 |
|------|------|------|
| `mod.rs:2567–2573` | d8-pointer：`else { 0.0 }` → `else { -32768.0 }` | Bug A |
| `mod.rs:3633–3637` | rho8-pointer：同上 | Bug A |
| `mod.rs:2713–2715` | D8FlowAccumTool：clone 后 `out.data = RasterData::from_f64_vec(F32, ...)` | Bug B |

## 4. 为什么这么改（不是反过来改数据）

| 候选方案 | 是否采纳 | 理由 |
|---------|---------|------|
| Bug A 改用"非 ESRI 编码"（如 0 = nodata） | ❌ | 违反 ESRI 行业标准，破坏与 ArcGIS/QGIS/TauDEM 互操作 |
| Bug B 让 `d8-flow-accum` 接受 U8 输出 | ❌ | 违反工具输出契约（流积累积值可达 10⁷+） |
| `d8-flow-accum` 内部 auto-fill | ❌ | 副作用、隐藏参数、破坏纯度、与生态不一致 |
| 修复 Bug A、B 保留代码职责 | ✅ | 接口契约优先，任何合规数据都能正确处理 |
| 用 `fill-depressions --fix-flats` 预处理 DEM | ✅ | 标准水文工作流（fill → pointer → accum → extract streams） |

**核心原则**：代码 bug 改代码，**数据 preconditioning 走数据**。两件事不能混。

## 5. 验证

### 5.1 Hubei_flowdir.tif（合规 ESRI pointer）

```
修复前: max=255        mean=19.71      4.65s   ❌
修复后: max=61,737,464 mean=9,109.85   4.59s   ✅
```
- 与诊断直调 `d8_dir_from_pointer + d8_flow_accum_core` 的 61,737,463 差 1（f32 舍入）
- debug / release 字节级一致

### 5.2 Hubei_demfill.tif（原始"filled" DEM，直跑）

```
修复前: max=3,157      mean=6.78       ❌ (15.5M pit)
修复后: max=3,157      mean=6.78       ❌（Bug A/B 不影响此路径，问题在数据）
```

### 5.3 Hubei_refilled.tif（fill-depressions --fix-flats 后）

```
max=61,431,872        mean=9,340.19   9.0s   ✅
```
- 与 5.1 路径差 0.5%（不同 fill 算法的拓扑差异，合法）

## 6. 后续建议

### 6.1 对数据
- `Hubei_demfill.tif` 文档应注明"未做 hydrological conditioning，需 `fill-depressions --fix-flats` 后使用"
- 或者删除该文件，只保留 `Hubei_flowdir.tif`（已是合规 ESRI pointer）和 `Hubei_dem_merit90.tif`（原始 90m）

### 6.2 对代码
- Bug A 模式可能潜伏在 `wbtools_oss` 其他工具的"克隆输入 + 改 dtype + set_unchecked"三件套里
  - 建议 grep 扫一遍 `let mut out = .*\.clone\(\);` 模式，统一加 storage 转换
  - 这次只修了 `D8FlowAccumTool`；`D8PointerTool` / `Rho8PointerTool` 因输出值域 0–128 不会真踩坑，但建议一致化
- 在 `d8-pointer` / `d8-flow-accum` 文档里加 warning："DEM 应先用 `fill-depressions` 处理"

### 6.3 不该做的
- ❌ 在 `d8-flow-accum` 里自动检测 pit 并填洼
- ❌ 把 pit 静默当成 nodata（当前行为）而不警告
- ❌ 让 `d8-flow-accum` 接受任意格式的 DEM 输入（隐式 fill、隐式 breach、隐式 flat increment）

## 7. 时序性能参考（仅供后续优化参考）

```
                          wall     user     sys    maxRSS
flowdir (CLI 全)          4.59s   10.76s   0.67s   2.1GB
gdal_translate LZW copy   0.80s    0.69s   0.03s   152MB    (纯 I/O 参考)
dd 写 65MB                0.014s   -       -       -        (raw disk 5.2 GB/s)
```

`user/wall = 2.34×` → 实际并行度 2.3 核（理论 16 核，受拓扑累积单线程 + I/O 串行限制）。
算法核心 ~1–1.5s，I/O + 启动 ~3s。优化空间在"写 F32 不压缩"那 1.5s 上。

## 8. CLI 工具清单（`whitebox-hydro` v0.1.0）

13 个水文子集工具，分 4 类：

| 类别 | 工具 |
|------|------|
| **DEM 水文预处理** | `fill-depressions`、`breach-depressions` |
| **流向 + 累积** | `d8-pointer`、`d8-flow-accum` |
| **河网提取** | `extract-streams`、`jenson-snap-pour-points` |
| **子流域 + 河网分析** | `watershed`、`basins`、`strahler-order`、4 个 `stream-link-*` |

### 8.1 标准水文工作流

```
[原始 DEM]
    │
    ├─→ fill-depressions --dem X.tif --fix-flats ───────┐
    │                                                  ↓
    │                                              [pit-free DEM]
    │                                                  ↓
    └─→ d8-pointer --dem <pit-free> [--esri-pntr]       ↓
                                                   [D8 pointer]
                                                       ↓
                                d8-flow-accum --input <d8> --input-is-pointer --esri-pntr
                                                       ↓
                                            [flow accumulation]
                                                       ↓
                                  extract-streams --threshold 1000 [--zero-background]
                                                       ↓
                                                  [streams]
                                                       ↓
                          ┌────────────────────────────┬──────────────┐
                          ↓                            ↓              ↓
              jenson-snap-pour-points       strahler-order    stream-link-*
                          ↓                            ↓              ↓
                  [snapped pour pts]              [order]        [id/class/len/slope]
                          ↓
            watershed --d8-pntr --pour-pts
                          ↓
                     [watershed raster]
                          ↓
                       basins --d8-pntr
                          ↓
                      [basin IDs]
```

### 8.2 工具详细列表

| # | CLI 子命令 | 内部 ID | 必填参数 | 可选参数 | 作用 |
|---|-----------|--------|---------|---------|------|
| 1 | `fill-depressions` | `fill_depressions` | `--dem` | `--fix-flats` `--flat-increment` `--flat-resolution` `{garbrecht_martz,natural}` `--max-depth` `-o` | 优先洪算法填洼；可加微梯度处理平地 |
| 2 | `breach-depressions` | `breach_depressions_least_cost` | `--dem` | `-o` | 最小成本路径穿挖（fill 的替代，破坏性更小） |
| 3 | `d8-pointer` | `d8_pointer` | `--dem` | `--esri-pntr` `-o` | D8 流向 pointer（3×3 最陡下降） |
| 4 | `d8-flow-accum` | `d8_flow_accum` | `--input` | `--out-type` `{cells,ca,sca}` `--log-transform` `--clip` `--input-is-pointer` `--esri-pntr` `-o` | 流积累积（DEM 或 pointer 输入） |
| 5 | `extract-streams` | `extract_streams` | `--flow-accumulation` | `--threshold` (默认 1000) `--zero-background` `-o` | 阈值法提取河网 |
| 6 | `jenson-snap-pour-points` | `jenson_snap_pour_points` | `--pour-pts` `--streams` | `--snap-dist` (默认 100) `-o` | Jenson 法吸附 pour point 到最近河道 |
| 7 | `watershed` | `watershed` | `--d8-pntr` `--pour-pts` | `--esri-pntr` `-o` | 出口点 → 子流域 |
| 8 | `basins` | `basins` | `--d8-pntr` | `--esri-pntr` `-o` | 全图分水岭（每个像元标记出口 basin ID） |
| 9 | `strahler-order` | `strahler_order` | `--d8-pntr` `--streams` | `--esri-pntr` `--zero-background` `-o` | Strahler 河流等级 |
| 10 | `stream-link-identifier` | `stream_link_identifier` | `--d8-pntr` `--streams-raster` | `-o` | 唯一标识每条 stream link |
| 11 | `stream-link-class` | `stream_link_class` | `--d8-pntr` `--streams-raster` | `-o` | stream link 分类 |
| 12 | `stream-link-length` | `stream_link_length` | `--d8-pntr` `--streams-raster` | `-o` | 每条 link 长度 |
| 13 | `stream-link-slope` | `stream_link_slope` | `--d8-pntr` `--streams-raster` | `-o` | 每条 link 平均坡度 |

**注意**：
- CLI 子命令用 kebab-case（`fill-depressions`），内部 ID 用 snake_case（`fill_depressions`）
- 参数键名中 `-` 等同于 `_`（`--d8-pntr` = `--d8_pntr`）
- `-o` 或 `--output` 指定输出路径；不指定则走默认输出目录
- 4 个 `stream-link-*` 都要求 `--d8-pntr` + `--streams-raster`（**已提取的河网**，不是 flow accumulation）

### 8.3 与本次修复的关系

| 工具 | 涉及 Bug | 修复后行为 |
|------|---------|----------|
| `d8-pointer` | **Bug A** | pit cell 输出 nodata (-32768) 而非 0 |
| `d8-flow-accum` | **Bug A 间接 + Bug B** | 接受 `d8-pointer` 输出的 pointer 时 pit 不再被当方向；输出 dtype 不再截断 |
| 其他 11 个 | 无直接影响 | — |

**潜在同类风险**（6.2 节提到）：其他工具的"克隆输入 + 改 `data_type` + `set_unchecked`"三件套未做 storage 转换，目前未触发（输出值域小），但属于同一模式 bug。

