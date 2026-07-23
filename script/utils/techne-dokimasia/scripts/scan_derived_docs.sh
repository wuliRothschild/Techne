#!/usr/bin/env bash
# scan_derived_docs.sh — 衍生文档扫描（C18 派生原则）
# 通过环境变量注入 DERIVED_DOCS_DIRS（空格分隔目录列表，相对 REPO_ROOT）。
# REPO_ROOT 强制以参数传入；不假设默认项目目录结构。
# 用法：bash script/utils/techne-dokimasia/scripts/scan_derived_docs.sh <repo_root>

set -euo pipefail

REPO_ROOT="${1:-}"
if [[ -z "$REPO_ROOT" || ! -d "$REPO_ROOT" ]]; then
  echo "FAIL: need repo_root as argument 1" >&2
  exit 1
fi

if [[ -z "${DERIVED_DOCS_DIRS:-}" ]]; then
  exit 0  # 未注入 = 无扫描
fi

for dir in $DERIVED_DOCS_DIRS; do
  full="${REPO_ROOT}/${dir}"
  if [[ ! -d "${full}" ]]; then
    continue
  fi
  find "${full}" -type f \( -name "*.html" -o -name "*.pdf" -o -name "*.txt" \) 2>/dev/null | sed "s|^${REPO_ROOT}/||"
done