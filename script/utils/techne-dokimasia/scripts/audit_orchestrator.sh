#!/usr/bin/env bash
# audit_orchestrator.sh — 审计门编排（由 sub-agent 或主 agent 调 bash；不引入 hooks）
# REPO_ROOT 强制参数；PURITY_SCAN 工具路径由环境变量注入；不假设默认项目目录结构。

set -euo pipefail
REPO_ROOT="${1:-}"
if [[ -z "$REPO_ROOT" || ! -d "$REPO_ROOT" ]]; then
  echo "FAIL: need techne project path" >&2
  exit 1
fi
cd "$REPO_ROOT"
SCOPE=$(git ls-files | grep -E '\.(md|sh)$' | grep -vE '^(source|data|output|panel|figure)/' | sort || true)
echo "scope_files=$(echo "$SCOPE" | wc -l)"
SKILL_SRC="${TECHNE_DOKIMASIA_SRC:-script/utils/techne-dokimasia}"
# purity_scan 工具路径由环境变量注入（PURITY_SCAN 抽象名；具体脚本由造物系统提供）
if [[ -n "${PURITY_SCAN:-}" && -f "${PURITY_SCAN}" ]]; then
  for f in "$SKILL_SRC"/SKILL.md "$SKILL_SRC"/references/lens-*.md; do
    [[ -f "$f" ]] || continue
    bash "${PURITY_SCAN}" "$f" || true
  done
fi
if [[ -f "$SKILL_SRC/scripts/scan_derived_docs.sh" ]]; then
  bash "$SKILL_SRC/scripts/scan_derived_docs.sh" "$REPO_ROOT" || true
fi
echo "audit_orchestrator ready: spawn 8 sub-agents with verbatim lenses"
echo "lenses: t7 c11 a7 c8 t9 rg c20 c21"