---
name: techne-dokimasia
description: >
  Multi-lens adversarial audit gate (δοκιμασία 系统审验) for techne-compatible projects.
  CONTRACT: triggered EXPLICITLY by user invocation. Does NOT auto-trigger.
  ALWAYS invoke before any git commit/push on a techne-compatible project.
  Main agent MUST remind user to trigger this skill before delivery — main agent must NOT audit itself.
  When invoked: requires techne project path; spawns 8 independent sub-agents in parallel
  (t7/c11/a7/c8/t9/rg/c20/c21); main agent MUST STOP and wait. Lens prompts loaded verbatim from
  references/lens-{t7,c11,a7,c8,t9,rg,c20,c21}.md. Derived-doc scan is MANDATORY. Reference canon at
  references/techne-arche.md. Use ONLY when user signals audit / commit-prior / delivery.
---

# Techne-Dokimasia (δοκιμασία)

> **角色**：techne 项目的审计门入口。它**不执行**审计本身；它**只**列出 8 个镜片与触发规约，由 main agent 加载后**并行触发 8 sub-agent**。
> **词源**：δοκιμασία（dokimasia）——雅典民主用于审验候选官员的"系统检验"。
> **触发契约**：用户主权——用户调 `/techne-dokimasia` skill 才加载；**不**自动触发。

## Resource layout (skill-creator 规范)

```
techne-dokimasia/
├── SKILL.md
├── references/
│   ├── lens-t7.md · lens-c11.md · lens-a7.md · lens-c8.md · lens-t9.md · lens-rg.md · lens-c20.md · lens-c21.md
│   └── techne-arche.md
└── scripts/
    ├── scan_derived_docs.sh
    └── audit_orchestrator.sh
```

## Required Input
- **techne project path** (MANDATORY; reject if missing — DO NOT silently default to cwd)

## Workflow

1. **接收路径**：用户调用 skill 时必须明确给出造物路径。缺失则报失败。
2. **路径校验**：必须含 `README.md`、`HANDOFF.md`、`.git/`（审计**目标**接口要求；arche／daemon 由 skill 单元 references 副本提供，非目标仓强制文件）。
3. `cd <path>` 与 `git ls-files`（C18）。
4. **派生文档扫描（必选）**：相对本 skill 根执行 `bash scripts/scan_derived_docs.sh <path>`（仓库源路径：`script/utils/techne-dokimasia/scripts/scan_derived_docs.sh`；部署后位于 `${TECHNE_SKILLS_DIR}/techne-dokimasia/scripts/`）。
5. **verbatim 加载**：从 `references/` 读取 8 个 lens prompt，**一字不差**；每个 lens 另完整加载 `references/techne-arche.md`（本 skill 单元内 ref，intra-unit）。
6. **预检**：对每个 lens 跑项目 env 层「态纯扫描」工具（`purity_scan` 通用名；具体脚本由审计目标的造物系统维护循环提供）。
7. **8 sub-agent 并行触发**；main agent 立即停止所有其他任务等待返回。
8. **main agent STOP**：不得写文件、改 HANDOFF、推送。
9. **逐条回应**：按 C19／附录 A 还原为公理后判定；deterministic 决议。
10. **最小修复**：violation 必修；concern 走 HANDOFF。
11. **门禁 ≤ 3 轮**；axiom_trace 真正 ambiguous 才升用户。
12. **记录**：findings 与 reasoning 入 HANDOFF；本轮反驳入"反驳索引"。

## 8 镜片清单

| 镜片 | 源文件 | 职责（公理推导） |
|---|---|---|
| t7 | references/lens-t7.md | 态文档是否含历史叙事（A5） |
| c11 | references/lens-c11.md | 知识两处 / 末端多 md（T12+T5） |
| a7 | references/lens-a7.md | 首次读者自足性（A7） |
| c8 | references/lens-c8.md | 补丁叠补丁（**C19**·附录 A） |
| t9 | references/lens-t9.md | 三径可通（T9+SOP-7） |
| rg | references/lens-rg.md | 引用图一致性（A2+T3+A5） |
| c20 | references/lens-c20.md | 报告证据挂靠（C20） |
| c21 | references/lens-c21.md | 迹完整性／秉笔直书（A5+A7+C11） |

判定**仅由公理体系推导**，不列举具体术语作审查模式。lens 可完整应用 `references/techne-arche.md` 全部内容（单元内 ref）；lens 之间互不引用。

## 严格约束

- sub-agent ONLY；全部 8 镜片必跑；verbatim 不可改；路径不可省；main agent STOP；派生扫描必选；公理化判定。
- **运行时四角自包含**（arche/daemon/dokimasia 与 epikrisis 单元互不路径引用；C19·A6）：本 skill 单元与 arche／daemon 单元互不以文件路径引用对方内容；公理／定理／推论以 A／T／C／SOP 编号引用。

## 部署位置

- 源：本仓库审计门单元（`script/utils/techne-dokimasia/`）
- 运行时：由造物系统的部署构造者实例化（目标路径经 env 层注入，不硬编码）
- 必须含 SKILL.md + references/（含 techne-arche.md 副本）+ scripts/

## 强制触发

- 典则层：C17／SOP-3——main agent 完成后**主动提醒**用户调本 skill
- 运行时层：用户调 `/techne-dokimasia` 显式触发
