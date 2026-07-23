#!/usr/bin/env bash
# epikrisis_orchestrator.sh — 审查门编排（与 audit_orchestrator 并列，独立 sub-agent）
# REPO_ROOT 强制参数；不调 purity（与态纯正交）

set -euo pipefail
REPO_ROOT="${1:-}"
if [[ -z "$REPO_ROOT" || ! -d "$REPO_ROOT" ]]; then
  echo "FAIL: need techne project path" >&2
  exit 1
fi
cd "$REPO_ROOT"
SCOPE=$(git ls-files | grep -E '\.(md|sh)$' | grep -vE '^(source|data|output|panel|figure)/' | sort || true)
echo "scope_files=$(echo "$SCOPE" | wc -l)"
EPIKRISIS_SRC="${TECHNE_EPIKRISIS_SRC:-script/utils/techne-epikrisis}"
if [[ -d "$EPIKRISIS_SRC/references" ]]; then
  echo "epikrisis_references:"
  ls "$EPIKRISIS_SRC/references" || true
fi
echo "epikrisis_orchestrator ready: spawn 1 sub-agent with r20 lens (concurrent = 1 to avoid attention dilution)"
echo "lens: r20"
