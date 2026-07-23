#!/bin/bash
# default.sh —— 默认分析方案（变体层）[T8·T11]
# 本项目为单方案项目；新增方案＝新增一件 config/<variant>.sh，不改本文件。
source "$(dirname "${BASH_SOURCE[0]}")/run_config.sh"

export VARIANT="default"
# 本变体无差异参数覆盖：维护任务直接作用于根目录交付物。
