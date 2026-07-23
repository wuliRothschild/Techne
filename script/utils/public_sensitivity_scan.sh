#!/usr/bin/env bash
# public_sensitivity_scan.sh — structural privacy gate before public release (A5·T5)
# Scans for machine-local coordinates only. Does NOT ban domain terms, DOI/PMID form,
# or peer product names (those are semantic closure — t7/c20/C15; listing them here
# would re-embed foreign instances into the meta-project tool layer).
# Self-file exempt from match reporting on pattern definitions.
set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

# Structural only: absolute Windows/Unix homes, drive-rooted paths, UUID-like session ids
# (generic shapes — not project names)
STRUCT_RE='(^|[^A-Za-z0-9_])([A-Za-z]:\|/[Uu]sers/|/home/[A-Za-z0-9._-]+/)|\b[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\b'

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  mapfile -d '' FILES < <(git ls-files -z)
else
  mapfile -d '' FILES < <(find . -type f ! -path './.git/*' ! -path './.git.bak.*/*' -print0)
fi

hits=0
for f in "${FILES[@]}"; do
  [[ -z "$f" || ! -f "$f" ]] && continue
  case "$f" in
    *public_sensitivity_scan.sh*) continue ;;
  esac
  if grep -nE "$STRUCT_RE" -- "$f" >/dev/null 2>&1; then
    echo "HIT: $f"
    grep -nE "$STRUCT_RE" -- "$f" | head -15
    hits=$((hits + 1))
  fi
done

if [[ "$hits" -gt 0 ]]; then
  echo "FAIL: $hits file(s) matched structural privacy patterns (absolute paths / session UUIDs)" >&2
  exit 1
fi
echo "PASS: public structural privacy scan ($ROOT)"
exit 0
