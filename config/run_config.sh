#!/bin/bash
# run_config.sh —— techne-demiurge 环境层（全项目唯一机器特定点）[T8]
# 换机／换账号／换平台只改此文件。变体层 source 本文件后仅覆盖差异参数。

# --- 项目根（唯一需要按机器调整的量） ---
export DEMIURGE_ROOT="${DEMIURGE_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

# --- 工具路径（POSIX 基础工具，本项目唯二外部依赖） ---
export MD5SUM_BIN="${MD5SUM_BIN:-md5sum}"   # macOS 可改为 md5 -r
export GREP_BIN="${GREP_BIN:-grep}"

# --- 路径派生模板（所有具体路径由此派生，变体层可覆盖） ---
export SOURCE_DIR="$DEMIURGE_ROOT/source"
export CHECKSUM_FILE="$SOURCE_DIR/checksums.md5"
export CANON_FILE="$DEMIURGE_ROOT/techne-arche.md"
export DAEMON_FILE="$DEMIURGE_ROOT/techne-daemon.md"

# --- 共享默认参数 ---
# 态纯扫描：自述性修订痕迹（通用；不含规则条文内作为反例的引述）
# 不含「本轮」等合法操作术语；不含「v2」等作为反例枚举的禁令用语
export PURITY_PATTERN='更新版|修订版|已纠正|已修正|该轮|WIP|TODO:fix|FIXME|deprecated|DEPRECATED'

# 审计门运行时接口（§5.4-1 外部资产登记；无默认值——须由用户环境显式注入）
export AUDIT_COMMANDS_DIR="${AUDIT_COMMANDS_DIR:-}"

# techne-dokimasia Skill 运行时部署目标（§5.4-1 外部资产登记；无默认值）
export TECHNE_SKILLS_DIR="${TECHNE_SKILLS_DIR:-}"

# 衍生文档目录（html/pdf/txt 等派生形态，由 techne-arche C18 派生原则要求扫描）
# 留空表示不扫描衍生目录；空格分隔多个路径
export DERIVED_DOCS_DIRS="${DERIVED_DOCS_DIRS:-}"
