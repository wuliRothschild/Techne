---
name: techne-epikrisis
description: >
  Factual-content and completeness review gate (epikrisis) for techne-compatible projects.
  CONTRACT: triggered EXPLICITLY by user invocation. Does NOT auto-trigger.
  Invoked AFTER or independently of techne-dokimasia to verify form-compliant evidence
  hooks actually substantiate the claim. Spawns sub-agent(s) loading
  references/lens-r20.md verbatim. Reference canon at references/techne-arche.md.
  Use ONLY when user signals factual review / commit-prior / delivery / counter-prompt.
---

# Techne-Epikrisis (epikrisis)

> **角色**：techne 项目的**事实层**审查入口。它只**给出审查契约与加载清单**，由 main agent 加载后**触发 sub-agent** 重打开工件／DOIs 验证。
> **词源**：epikrisis（希腊文 epikrisis）——「再裁定／复核」：epi（upon / after）+ krisis（judgment / decision）。在希腊医学与法律中指对既有判定的二次审定，而非初次检验（dokimasia）。
> **触发契约**：用户主权——用户调 `/techne-epikrisis` skill 才加载；不自动触发。
> **与 dokimasia 的分工**：dokimasia 审**形式**（C20：路径／DOI 是否在场）；epikrisis 审**事实**（C22：路径内容是否真支撑结论）。

## Resource layout (skill-creator 规范)

```
techne-epikrisis/
├── SKILL.md
├── references/
│   ├── lens-r20.md
│   └── techne-arche.md
└── scripts/
    └── epikrisis_orchestrator.sh
```

## Required Input
- **techne project path** (MANDATORY; reject if missing — DO NOT silently default to cwd)

## Workflow

1. **接收路径**：与 dokimasia 一致；缺失报失败。
2. **路径校验**：必须含 `README.md` + `HANDOFF.md` + `document/reports/` + `.git/`。
3. `cd <path>` 与 `git ls-files`。
4. **必读扫描**：`document/reports/` 全报告 + `output/` 与 `panel/` 全部清单（仅列举，不打开）。
5. **verbatim 加载**：从 `references/` 读取 `lens-r20.md` 一字不差；另加载 `references/techne-arche.md`（intra-unit ref）。
6. **preflight**：不调 purity；epikrisis 与态纯正交。
7. **r20 sub-agent 触发**——一次只下发一个 review 任务给 sub-agent（避免跨 LLM 注意力稀释）。
8. **main agent STOP**：不写文件、改 HANDOFF、推送。
9. **逐条回应**：判定 deliberate 5 级——`strong` / `moderate` / `weak` / `contested` / `unverified`。
10. **最小修复**：每条 finding 配 `[[ev:ID]]` 锚点 + supporting/opposing 数组 + `strength`；终态 fenced `evidence` JSON。
11. **门禁 ≤ 3 轮**；不收敛升级用户。
12. **记录**：findings 与反驳入 HANDOFF「反驳索引」。

## r20 镜片清单（唯一）

| 镜片 | 来源 | 职责（公理推导） |
|---|---|---|
| r20 | references/lens-r20.md | **完整性** + **事实有效性**——A2+A3+A7+T9+T12+T3+C20+C22 合取 |

判定**仅由公理体系推导**，不列举具体术语作审查模式。lens 可完整应用 `references/techne-arche.md` 全部内容（intra-unit ref）。

## 严格约束

- sub-agent ONLY；verbatim 不可改；路径不可省；main agent STOP；
- **不与 dokimasia 8 镜片并行触发**——防止单轮 LLM 注意力稀释；
- 每个支持的证据必须**重打开工件**确认数字与方向匹配；
- 每个 DOI 必须 Crossref 可解析；
- 输出末尾**精确一个** fenced `evidence` JSON 数组。

## 部署位置

- 源：本仓库 epikrisis 单元（`script/utils/techne-epikrisis/`）
- 运行时：由造物系统的部署构造者实例化（目标路径经 env 层注入，不硬编码）
- 必须含 SKILL.md + references/（含 techne-arche.md 副本）+ scripts/

## 强制触发

- 典则层：C22——main agent 完成后**主动提醒**用户调本 skill
- 运行时层：用户调 `/techne-epikrisis` 显式触发
