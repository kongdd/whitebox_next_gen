# View Source Button — Design and Implementation Plan

**Created**: 2026-07-06  
**Status**: Design Proposal  
**Author**: John Lindsay  
**Scope**: `wbcore`, `wbtools_oss`, `wbtools_pro` (and any crate exposing tool manifests), `wbw_python`, `wbw_qgis`

---

## Background and Motivation

Whitebox GAT, the original desktop GUI predecessor to Whitebox Workflows, included a "View Code" button in every tool dialog. This was a defining feature of GAT's *open-access* philosophy: rather than merely being open-source (source code available somewhere in a repository), the software made its own implementation directly inspectable at the point of use. A user running the Slope tool could click one button and immediately see the algorithm code, with syntax highlighting, without navigating a repository, installing a separate viewer, or understanding the project's directory structure.

This feature was lost when the project transitioned from GAT (a monolithic desktop application with a one-tool-one-file codebase architecture) to WhiteboxTools and then to Whitebox Next Gen. The Next Gen codebase intentionally groups related tools into shared modules (e.g., `basic_terrain_tools.rs` contains slope, aspect, hillshade, and related functions), which means there is no longer a one-to-one mapping between tool and source file. This makes a naive "open the source file for this tool" button ambiguous.

This document describes a design that solves the ambiguity problem by embedding per-tool source location metadata directly into the tool manifest, and surfacing a "View Source" link in the QGIS plugin's tool help panel.

---

## Design Goals

1. Every tool in the QGIS plugin should display a "View Source" link in its help/description panel that navigates directly to the relevant implementation in the source repository.
2. The link must be specific enough to be useful — pointing to the function or algorithm block, not just the file.
3. The metadata must be maintainable: low per-tool authoring cost, no separate synchronisation process, no external tooling required to keep it current.
4. The feature must be backwards-compatible: tools that have not yet been annotated simply show no link, with no error or degraded behaviour.
5. The feature should be extensible to include documentation URLs, tool version information, and manifest schema versioning for future use.

---

## Architecture Overview

The data flows through the existing pipeline:

```
ToolManifest (Rust struct in wbcore)
    │  serde::Serialize
    ▼
catalog entry JSON  (assembled in wbw_python)
    │  RuntimeSession.list_tool_catalog_json()
    ▼
WhiteboxCatalogAlgorithm._manifest dict  (Python, in wbw_qgis/plugin)
    │  shortHelpString() renders HTML
    ▼
QGIS tool help panel  (clickable link opens browser)
```

Because the manifest is already serialised over this pipeline and the QGIS algorithm already reads arbitrary keys from `_manifest`, no new transport mechanism is needed. Adding a new optional field to `ToolManifest` in Rust causes it to appear automatically in the JSON catalog and therefore in `_manifest` on the Python side.

---

## Step 1 — Extend `ToolManifest` in `wbcore`

**File**: `crates/wbcore/src/lib.rs`

Add a new optional struct `ToolSourceInfo` and an optional `source` field to `ToolManifest`.

### New struct

```rust
/// Source code location metadata for a tool.
///
/// Populated at tool registration time. All fields are `'static` string
/// references so they carry zero runtime allocation cost. The `commit`
/// field is intended to be stamped at build time via a build script.
#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct ToolSourceInfo {
    /// Base URL of the source repository.
    /// Example: `"https://github.com/jblindsay/whitebox_next_gen"`
    pub repository: &'static str,

    /// Repository-relative path to the source file containing the tool's
    /// primary algorithm implementation.
    /// Example: `"crates/wbtools_oss/src/tools/geomorphometry/basic_terrain_tools.rs"`
    pub path: &'static str,

    /// First line (1-indexed, inclusive) of the primary algorithm function.
    pub line_start: u32,

    /// Last line (1-indexed, inclusive) of the primary algorithm function.
    pub line_end: u32,

    /// Git commit hash at the time the binary was built.
    /// Set via `option_env!("WBW_GIT_COMMIT")` in a build script.
    /// Falls back to `"main"` when not available (e.g. development builds).
    #[serde(skip_serializing_if = "Option::is_none")]
    pub commit: Option<&'static str>,

    /// Optional URL to the tool's documentation page.
    /// Example: `"https://www.whiteboxgeo.com/manual/wbw-user-manual/book/tool_help.html#slope"`
    #[serde(skip_serializing_if = "Option::is_none")]
    pub documentation_url: Option<&'static str>,
}

impl ToolSourceInfo {
    /// Constructs the full GitHub permalink URL for this tool's implementation.
    ///
    /// The URL format is:
    /// `{repository}/blob/{commit}/{path}#L{line_start}-L{line_end}`
    ///
    /// Falls back to `"main"` if `commit` is `None`.
    pub fn github_permalink(&self) -> String {
        let commit = self.commit.unwrap_or("main");
        if self.line_start > 0 && self.line_end >= self.line_start {
            format!(
                "{}/blob/{}/{}#L{}-L{}",
                self.repository, commit, self.path, self.line_start, self.line_end
            )
        } else {
            format!("{}/blob/{}/{}", self.repository, commit, self.path)
        }
    }
}
```

### Modified `ToolManifest`

Add two new fields at the end of the struct, both optional:

```rust
#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct ToolManifest {
    pub id: String,
    pub display_name: String,
    pub summary: String,
    pub category: ToolCategory,
    pub license_tier: LicenseTier,
    pub params: Vec<ToolParamDescriptor>,
    pub defaults: ToolArgs,
    pub examples: Vec<ToolExample>,
    pub tags: Vec<String>,
    pub stability: ToolStability,

    // ── New fields ──────────────────────────────────────────────────────────
    /// Source code location for the "View Source" link. `None` for tools
    /// that have not yet been annotated.
    #[serde(skip_serializing_if = "Option::is_none")]
    pub source: Option<ToolSourceInfo>,

    /// Monotonically increasing integer version for this tool's manifest
    /// schema. Starts at 1. Increment when the manifest structure for this
    /// tool changes in a breaking way. Separate from `stability`, which
    /// describes the tool's algorithm maturity.
    #[serde(skip_serializing_if = "Option::is_none")]
    pub manifest_version: Option<u32>,

    /// Semantic version string for the tool implementation itself.
    /// Distinct from the overall WbW library version. Optional; used
    /// primarily for toolsets that track independent versioning.
    #[serde(skip_serializing_if = "Option::is_none")]
    pub tool_version: Option<&'static str>,
}
```

Both new fields use `#[serde(skip_serializing_if = "Option::is_none")]` so they are absent from the JSON for un-annotated tools, keeping the catalog payload compact.

The `From<ToolMetadata> for ToolManifest` impl must also be updated to set both new fields to `None`:

```rust
impl From<ToolMetadata> for ToolManifest {
    fn from(m: ToolMetadata) -> Self {
        // ... existing field mappings ...
        Self {
            // ... existing fields ...
            source: None,
            manifest_version: None,
            tool_version: None,
        }
    }
}
```

---

## Step 2 — Add a Build Script to Stamp the Git Commit Hash

**File**: `crates/wbtools_oss/build.rs` (new file; also add to `wbtools_pro` and any other crate that exposes tools)

The `ToolSourceInfo.commit` field is intended to link directly to the exact revision of the source that was compiled. This is only meaningful if the commit hash is available at compile time.

```rust
fn main() {
    // Stamp the git commit hash into the build environment so tools can
    // reference it in source permalinks via option_env!("WBW_GIT_COMMIT").
    if let Ok(output) = std::process::Command::new("git")
        .args(["rev-parse", "--short", "HEAD"])
        .output()
    {
        if output.status.success() {
            let hash = String::from_utf8_lossy(&output.stdout).trim().to_string();
            if !hash.is_empty() {
                println!("cargo:rustc-env=WBW_GIT_COMMIT={}", hash);
            }
        }
    }
    // Always re-run if the HEAD ref changes.
    println!("cargo:rerun-if-changed=.git/HEAD");
    println!("cargo:rerun-if-changed=.git/refs/heads");
}
```

In tool manifest functions, the commit is then injected with:

```rust
commit: option_env!("WBW_GIT_COMMIT"),
```

`option_env!` (not `env!`) is used so that builds without a git repository (e.g. source tarballs, CI environments without `.git`) produce `None` rather than a compile error. In that case the link falls back to `"main"`, which always points to the latest code on the default branch — a reasonable fallback.

---

## Step 3 — Annotate Tool Manifests

**Files**: all `*_manifest()` functions across `wbtools_oss`, `wbtools_pro`, and any other crate that registers tools.

This is the bulk of the per-tool authoring work. Each `fn <name>_manifest() -> ToolManifest` function gains a `source` block. The minimum required fields are `repository`, `path`, `line_start`, and `line_end`.

### Example: `slope` in `basic_terrain_tools.rs`

```rust
fn slope_manifest() -> ToolManifest {
    ToolManifest {
        id: "slope".to_string(),
        display_name: "Slope".to_string(),
        summary: r#"Zevenbergen-Thorne slope gradient ..."#.to_string(),
        // ... all existing fields unchanged ...
        source: Some(ToolSourceInfo {
            repository: "https://github.com/jblindsay/whitebox_next_gen",
            path: "crates/wbtools_oss/src/tools/geomorphometry/basic_terrain_tools.rs",
            line_start: 575,
            line_end: 660,
            commit: option_env!("WBW_GIT_COMMIT"),
            documentation_url: Some(
                "https://www.whiteboxgeo.com/manual/wbw-user-manual/book/tool_help.html#slope"
            ),
        }),
        manifest_version: Some(1),
        tool_version: None,
    }
}
```

### Constant for the repository URL

To avoid repeating the repository URL string across hundreds of manifest functions, define a module-level constant in each tool crate:

```rust
// In crates/wbtools_oss/src/tools/mod.rs (or a shared constants module)
pub(crate) const REPO: &str = "https://github.com/jblindsay/whitebox_next_gen";
```

Then each manifest function uses `repository: REPO`.

### Line range staleness

Line numbers will drift as code is edited. This is intentional and acceptable: the link will point to approximately the right location and GitHub's in-page search is sufficient for the small drift that accumulates between releases. For a tighter guarantee, a CI check (see Step 6) can flag when the declared line range no longer contains the function signature.

The practical authoring workflow is:
1. Open the source file.
2. Find the `run_<tool>` function (the actual algorithm implementation, not the manifest function itself).
3. Record the first and last lines of that function body.
4. Populate `line_start` and `line_end`.

Note that the manifest function and the run function are typically in the same file but at different lines. The `source` block should point to the **run function**, not the manifest function.

---

## Step 4 — Pass `source` Through the Catalog JSON Pipeline

**File**: `crates/wbw_python/src/lib.rs`

The `ToolManifest` is already serialised to JSON in the `catalog_entry_json` function via `manifest_with_param_schema_json`. Because `ToolSourceInfo` derives `Serialize`, the new `source` field will be included automatically when it is `Some`. No code changes are required in `wbw_python` for the field to appear in the catalog JSON.

The resulting JSON entry for an annotated tool will include:

```json
{
  "id": "slope",
  "display_name": "Slope",
  ...
  "source": {
    "repository": "https://github.com/jblindsay/whitebox_next_gen",
    "path": "crates/wbtools_oss/src/tools/geomorphometry/basic_terrain_tools.rs",
    "line_start": 575,
    "line_end": 660,
    "commit": "a3f2c91",
    "documentation_url": "https://www.whiteboxgeo.com/manual/wbw-user-manual/book/tool_help.html#slope"
  },
  "manifest_version": 1
}
```

Un-annotated tools simply omit the `source` key entirely.

---

## Step 5 — Render the Link in the QGIS Plugin

**File**: `crates/wbw_qgis/plugin/whitebox_workflows_qgis/algorithm.py`

### Option A — Append to `shortHelpString` (Recommended)

The `shortHelpString` method in `WhiteboxCatalogAlgorithm` already assembles an HTML string from the tool summary, help excerpt, and render hints. Append a "View Source" line at the end when the `source` key is present in `_manifest`.

```python
def shortHelpString(self):
    summary = str(self._manifest.get("summary", "") or "")
    tool_id = self.name()
    help_provider = get_help_provider()
    help_excerpt = help_provider.get_tool_help_excerpt(tool_id)
    hint_text = _render_hint_summary(self._render_hints)

    # ... existing locked-tool handling unchanged ...

    parts = [summary] if summary else []
    if help_excerpt and help_excerpt != summary:
        parts.append(help_excerpt)
    if hint_text:
        parts.append(hint_text)

    # ── View Source link (new) ───────────────────────────────────────────
    source = self._manifest.get("source")
    if isinstance(source, dict) and source.get("path"):
        repo = source.get("repository", "")
        path = source.get("path", "")
        commit = source.get("commit") or "main"
        l1 = source.get("line_start")
        l2 = source.get("line_end")
        doc_url = source.get("documentation_url")

        if repo and path:
            anchor = f"#L{l1}-L{l2}" if l1 and l2 else ""
            src_url = f"{repo}/blob/{commit}/{path}{anchor}"
            source_links = [f'<a href="{src_url}">View algorithm source</a>']
            if doc_url:
                source_links.append(f'<a href="{doc_url}">Online documentation</a>')
            parts.append("  ·  ".join(source_links))

    return "\n\n".join(p for p in parts if p)
```

QGIS renders the `shortHelpString` return value as HTML in the right-hand help panel of the Processing dialog. Anchor tags are rendered as clickable hyperlinks that open in the system browser. No Qt widget changes are required.

### Option B — Dedicated "View Source" button (future enhancement)

If a more prominent UI treatment is desired in a future release, `createCustomParametersWidget` can return a thin banner widget containing a `QPushButton`. The existing Field Calculator implementation in the same file demonstrates this exact pattern and can serve as a template. However, Option A is strongly recommended as the first implementation because:

- It requires no Qt widget code.
- It is rendered by QGIS's existing help panel, which already handles link clicks.
- It does not interfere with the standard parameter input form.
- It degrades gracefully: tools without `source` metadata simply show no link.

---

## Step 6 — Optional: CI Line-Range Validation Script

To prevent the declared line ranges from silently drifting too far from the actual implementation, a lightweight validation script can be added to the repository.

**File**: `crates/wbtools_oss/scripts/validate_source_line_ranges.py` (or similar)

Logic:
1. Parse all `source` blocks from tool manifest source files (via regex or `cargo metadata`).
2. For each declared `(file, line_start, line_end)`, verify that `line_start` falls within a `fn run_<tool>` function in the specified file.
3. Warn (not error) if the declared range is more than N lines away from the actual function boundary.

This script can be run as a pre-release check rather than a hard CI gate, since minor drift is expected and acceptable.

---

## Implementation Sequence

The following order minimises risk and allows incremental testing at each stage.

| Step | Location | Description | Effort |
|------|----------|-------------|--------|
| 1 | `wbcore/src/lib.rs` | Add `ToolSourceInfo` struct and `source`, `manifest_version`, `tool_version` fields to `ToolManifest` | Small |
| 2 | `wbtools_oss/build.rs` | Add build script to stamp `WBW_GIT_COMMIT` env var | Small |
| 3a | `wbtools_oss` (pilot) | Annotate 5–10 high-profile tools (slope, aspect, hillshade, d8_pointer, mean_filter) as a pilot | Small |
| 4 | `wbw_python/src/lib.rs` | Verify `source` field passes through catalog JSON automatically | Trivial (verify only) |
| 5 | `algorithm.py` | Add source link rendering in `shortHelpString` | Small |
| 3b | `wbtools_oss` (full) | Annotate all remaining tool manifests | Medium (mechanical) |
| 3c | `wbtools_pro` | Annotate Pro tool manifests | Medium (mechanical) |
| 6 | CI / scripts | Optional line-range validation script | Small |

Steps 1 through 5 (the pilot) can be completed and tested end-to-end before committing to the full annotation effort in step 3b.

---

## Scope of the Annotation Effort

As of the time of writing, there are approximately 84 `_manifest()` functions in `wbtools_oss` across 14 source files, plus additional manifests in `wbtools_pro` and other crates. The annotation is mechanical: for each function, record the file path relative to the repository root, find the corresponding `run_<tool>` function, and record its line range. With the `REPO` constant and the `option_env!("WBW_GIT_COMMIT")` macro, each annotation block is approximately 8 lines.

A rough estimate: annotating all OSS tools is approximately 2–3 hours of focused work. Pro tools add another 1–2 hours. The pilot (10 tools) is approximately 30 minutes.

---

## What the User Experience Looks Like

When a user opens the **Slope** tool dialog in QGIS:

1. The right-hand help panel shows the tool summary and help excerpt as today.
2. At the bottom of the panel, two hyperlinks appear:
   - **View algorithm source** — opens the browser at `https://github.com/jblindsay/whitebox_next_gen/blob/a3f2c91/crates/wbtools_oss/src/tools/geomorphometry/basic_terrain_tools.rs#L575-L660`
   - **Online documentation** — opens the WbW user manual page for Slope.
3. The browser highlights lines 575–660, showing the `run_slope` function directly.

For tools not yet annotated, the help panel shows no source link — identical to the current behaviour.

This restores the spirit of the original Whitebox GAT "View Code" button while working within the architectural constraints of the Next Gen monorepo and the QGIS Processing framework.

---

## Open Questions

- **Repository visibility**: The `source_url` points to a GitHub repository. If the repository is private at the time of a release (e.g. during a pre-release window), the link will return a 404 for non-collaborators. Consider defaulting to `"main"` rather than a commit hash for public releases where the commit may not yet be pushed.
- **Pro tool links**: Pro tool source lives in a private repository. The `source` block for Pro tools should either be omitted (`None`) or point to a different URL scheme (e.g. a documentation page rather than a raw source link). A `documentation_url` alone is appropriate for Pro tools.
- **Line number maintenance**: Decide on a policy for how frequently line ranges are updated. Suggestion: update line ranges as part of the release preparation checklist, or whenever a tool's implementation is substantially refactored.
- **`tool_version` semantics**: The current design leaves `tool_version` as a free-form string. If independent tool versioning is adopted in the future, the format should be defined (semver recommended) and a policy established for when it increments.
