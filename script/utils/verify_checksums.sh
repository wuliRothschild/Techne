#!/bin/bash
# verify_checksums.sh —— 源不可变核验（方法学见 document/methodology/methodology.md §5）
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../config/run_config.sh"

if [[ ! -f "$CHECKSUM_FILE" ]] || [[ ! -s "$CHECKSUM_FILE" ]]; then
  echo "SKIP: empty source instance — no checksums.md5 (有源之日执行)"
  exit 0
fi

cd "$SOURCE_DIR"
"$MD5SUM_BIN" -c "$CHECKSUM_FILE"
echo "PASS: source 完整未被改动（A1）"
