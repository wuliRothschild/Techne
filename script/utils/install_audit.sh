#!/usr/bin/env bash
# install_audit.sh — techne-dokimasia 部署器（A2 构造者）
# 将仓库内 script/utils/techne-dokimasia/* 部署到运行时接口：
#   - SKILL.md                         → ${DST_SKILLS}/SKILL.md
#   - references/lens-*.md (t7/c11/a7/c8/t9/rg/c20/c21) → ${DST_SKILLS}/references/lens-{...}.md
#   - scripts/scan_derived_docs.sh     → ${DST_SKILLS}/scripts/scan_derived_docs.sh
#   - techne-arche.md                 → ${DST_COMMANDS}/techne-arche.md
#   - techne-daemon.md                → ${DST_COMMANDS}/techne-daemon.md
# 幂等：md5 一致则跳过；不一致则覆盖；目标目录缺失则创建。
# 注：不处理目标运行时目录下的孤儿文件（用户手动清理）。
# 部署目标必须由环境变量 AUDIT_COMMANDS_DIR / TECHNE_SKILLS_DIR 显式注入（无硬编码家目录默认）。

set -euo pipefail

# 界面层（§5.4-1）声明运行时接口路径
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
if [[ -f "${REPO_ROOT}/config/run_config.sh" ]]; then
  # shellcheck disable=SC1091
  source "${REPO_ROOT}/config/run_config.sh"
fi

DST_COMMANDS="${AUDIT_COMMANDS_DIR:-}"
DST_SKILLS="${TECHNE_SKILLS_DIR:-}/techne-dokimasia"
if [[ -z "${AUDIT_COMMANDS_DIR:-}" || -z "${TECHNE_SKILLS_DIR:-}" ]]; then
  echo "FAIL: set AUDIT_COMMANDS_DIR and TECHNE_SKILLS_DIR (no hardcoded home defaults; T5/A6)" >&2
  exit 1
fi
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/techne-dokimasia"

if [[ ! -d "${SRC_DIR}" ]]; then
  echo "FAIL: 源目录不存在 ${SRC_DIR}" >&2
  exit 1
fi

# 清理：仅本 Skill 自己的旧版本（其他孤儿用户手动）
rm -rf "${DST_SKILLS}"

mkdir -p "${DST_COMMANDS}" "${DST_SKILLS}"

copied=0
skipped=0
failed=0

# 1) SKILL.md（顶层）
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

# 1) SKILL.md
deploy_file "${SRC_DIR}/SKILL.md" "${DST_SKILLS}/SKILL.md" "SKILL.md"

# 2) references/lens-*.md（C18 描述：必选 scan_derived_docs.sh 同源；references 为按需加载文档）
if [[ -d "${SRC_DIR}/references" ]]; then
  mkdir -p "${DST_SKILLS}/references"
  for f in "${SRC_DIR}"/references/lens-*.md; do
    [[ -f "${f}" ]] || continue
    name="$(basename "${f}")"
    deploy_file "${f}" "${DST_SKILLS}/references/${name}" "references/${name}"
  done
fi

# 3) scripts/*（可执行代码——含 scan_derived_docs.sh）
if [[ -d "${SRC_DIR}/scripts" ]]; then
  mkdir -p "${DST_SKILLS}/scripts"
  for f in "${SRC_DIR}"/scripts/*; do
    [[ -f "${f}" ]] || continue
    name="$(basename "${f}")"
    deploy_file "${f}" "${DST_SKILLS}/scripts/${name}" "scripts/${name}"
    # 保留执行权限
    if [[ -x "${f}" ]]; then
      chmod +x "${DST_SKILLS}/scripts/${name}"
    fi
  done
fi

# 3) techne-arche.md runtime 副本（lens "必须阅读" 依赖）
if [[ -f "${REPO_ROOT}/techne-arche.md" ]]; then
  deploy_file "${REPO_ROOT}/techne-arche.md" "${DST_SKILLS}/references/techne-arche.md" "references/techne-arche.md"
fi

# 4) 两个 slash command
for cmd_file in techne-arche.md techne-daemon.md; do
  src_cmd="${REPO_ROOT}/${cmd_file}"
  dst_cmd="${DST_COMMANDS}/${cmd_file}"
  if [[ -f "${src_cmd}" ]]; then
    if cp "${src_cmd}" "${dst_cmd}"; then
      echo "  copied: ${cmd_file} → ${DST_COMMANDS}/"
    fi
  fi
done

echo "installed: ${copied} copied, ${skipped} skipped, ${failed} failed (skill); commands deployed to ${DST_COMMANDS}"
if [[ ${failed} -gt 0 ]]; then
  exit 1
fi
