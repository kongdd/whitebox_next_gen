#!/usr/bin/env bash
# build_cli.sh —— 编译 whitebox_hydro_cli（C ABI 动态库 + CLI）
# 用法：scripts/build_cli.sh [--release]
set -euo pipefail
cd "$(cd "$(dirname "$0")/.." && pwd)"
[ "${1:-}" = "--release" ] && profile="--release" || profile=""
exec cargo build $profile -p whitebox_hydro_cli