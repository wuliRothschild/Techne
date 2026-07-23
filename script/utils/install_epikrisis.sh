#!/usr/bin/env bash
# install_epikrisis.sh — techne-epikrisis 部署器（A2 构造者；与 install_audit.sh 并列）
# 部署目标必须由环境变量 AUDIT_COMMANDS_DIR / TECHNE_SKILLS_DIR 显式注入。

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
if [[ -f "${REPO_ROOT}/config/run_config.sh" ]]; then
  # shellcheck disable=SC1091
  source "${REPO_ROOT}/config/run_config.sh"
fi

if [[ -z "${AUDIT_COMMANDS_DIR:-}" || -z "${TECHNE_SKILLS_DIR:-}" ]]; then
  echo "FAIL: set AUDIT_COMMANDS_DIR and TECHNE_SKILLS_DIR (no hardcoded home defaults; T5/A6)" >&2
  exit 1
fi
EPIKRISIS_DST_SKILLS="${TECHNE_SKILLS_DIR}/techne-epikrisis"
EPIKRISIS_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/techne-epikrisis"

if [[ ! -d "${EPIKRISIS_SRC}" ]]; then
  echo "FAIL: 源目录不存在 ${EPIKRISIS_SRC}" >&2
  exit 1
fi

rm -rf "${EPIKRISIS_DST_SKILLS}"
mkdir -p "${EPIKRISIS_DST_SKILLS}"

copied=0
skipped=0
failed=0

deploy_file() {
  local src="$1" dst="$2" rel="$3"
  local src_md5 dst_md5
  src_md5="$(md5sum "${src}" | awk '{print $1}')"
  if [[ -f "${dst}" ]]; then
    dst_md5="$(md5sum "${dst}" | awk '{print $1}')"
    if [[ "${src_md5}" == "${dst_md5}" ]]; then
      skipped=$((skipped+1))
      return 0
    fi
  fi
  if cp "${src}" "${dst}"; then
    copied=$((copied+1))
    echo "  copied: ${rel}"
  else
    failed=$((failed+1))
    echo "FAIL: ${rel}" >&2
  fi
}

deploy_file "${EPIKRISIS_SRC}/SKILL.md" "${EPIKRISIS_DST_SKILLS}/SKILL.md" "SKILL.md"

if [[ -d "${EPIKRISIS_SRC}/references" ]]; then
  mkdir -p "${EPIKRISIS_DST_SKILLS}/references"
  for f in "${EPIKRISIS_SRC}"/references/*; do
    [[ -f "${f}" ]] || continue
    name="$(basename "${f}")"
    deploy_file "${f}" "${EPIKRISIS_DST_SKILLS}/references/${name}" "references/${name}"
  done
fi

if [[ -f "${REPO_ROOT}/techne-arche.md" ]]; then
  deploy_file "${REPO_ROOT}/techne-arche.md" "${EPIKRISIS_DST_SKILLS}/references/techne-arche.md" "references/techne-arche.md"
fi

if [[ -d "${EPIKRISIS_SRC}/scripts" ]]; then
  mkdir -p "${EPIKRISIS_DST_SKILLS}/scripts"
  for f in "${EPIKRISIS_SRC}"/scripts/*; do
    [[ -f "${f}" ]] || continue
    name="$(basename "${f}")"
    deploy_file "${f}" "${EPIKRISIS_DST_SKILLS}/scripts/${name}" "scripts/${name}"
    if [[ -x "${f}" ]]; then
      chmod +x "${EPIKRISIS_DST_SKILLS}/scripts/${name}"
    fi
  done
fi

echo "installed: ${copied} copied, ${skipped} skipped, ${failed} failed (epikrisis)"
if [[ ${failed} -gt 0 ]]; then
  exit 1
fi
