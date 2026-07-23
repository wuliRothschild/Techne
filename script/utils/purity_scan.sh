#!/bin/bash
# purity_scan.sh —— 纯净性扫描（方法学见 document/methodology/methodology.md §4）
# 用法：bash script/utils/purity_scan.sh [目标文件]（默认扫描 techne-arche.md）
# HANDOFF.md 是迹（A5），豁免。research/reports 同为态，不整文件豁免。
# 领域泄漏（外部项目名／领域实例）由 t7 等镜片语义审——本脚本词表只含态纯修订痕迹，不列领域专名（T5·T6）。
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../config/run_config.sh"

TARGET="${1:-$CANON_FILE}"

# 迹豁免：仅 HANDOFF（A5）。research／reports 同为态——C15 通用化与领域泄漏由 t7 等镜片语义审；本脚本不整文件豁免 research。
case "$(basename "$TARGET")" in
  HANDOFF.md)
    echo "Skipping: $TARGET — HANDOFF 是迹（A5），豁免态纯扫描。"
    exit 0
    ;;
esac

echo "Scanning: $TARGET"
# 自描述豁免：行内出现「禁｜排除｜BANNED」「不得｜不应｜禁止｜不要」等反例语境词时跳过（规则条文自描述非违例）
HITS=$("$GREP_BIN" -nE "$PURITY_PATTERN" "$TARGET" || true)
if [[ -n "$HITS" ]]; then
  FILTERED=$(echo "$HITS" | "$GREP_BIN" -vE '(禁|排除|BANNED|不得|不应|禁止|不要|时态词|版本词|禁用)' || true)
  if [[ -n "$FILTERED" ]]; then
    echo "$FILTERED"
    echo "FAIL: 检出修订痕迹/外部指涉（见上行）"
    exit 1
  fi
  echo "PASS (self-describing exemption applied): $TARGET — 命中均为规则自描述"
  exit 0
fi
echo "PASS: 态纯，零命中"