# Techne —— Agent 项目架构设计哲学

[English](README.md) | [简体中文](README.zh-CN.md)

> 道生一，一生二，二生三，三生万物

> 一切由 Agent 构建与交付之项目的统一架构宪法。**每个项目是一件造物**：源不可变、链可复现、结构同构、态迹两清、界面单点、人与 Agent 同等可读、可复合为新造物。全部规则由七条公理推导生成，任何无公理出处的规定不成立。

**先读**：[`techne-agora.zh-CN.md`](techne-agora.zh-CN.md)（介绍与论战）→ [`techne-arche.md`](techne-arche.md)（太初 · 典则全文）→ [`techne-daemon.md`](techne-daemon.md)（守护灵 · 常驻投影）

> 本仓库即 **techne-demiurge** 元项目——它生产、维护、迭代上述造物。新会话启动顺序：本 README → `HANDOFF.md` 顶部 → 开工。

---

## 三分钟版（没用过 AI Agent？从这里开始）

**一句话**：AI 每轮对话结束就失忆——这个项目让每个项目成为一个自带说明书的**盒子**：任何人、任何 AI，第一次拿到就能看懂、会用、能查对错、还能接着往上拼。

**痛点**：用 AI 助手就像雇了一位每 24 小时失忆一次的顶级厨师。业界流行的 skill 只是菜谱便签——教 AI 怎么做菜，却不管厨房的样子；Techne 定义的是厨房本身。

**七条厨房规矩（大白话）**：原料锁进保险柜永不动 · 每道菜附可照做的做法 · 所有盒子长一个样（学会一个等于学会全部）· 现状与历史分居（历史全写在一本只增不删的日志里）· 换厨房只改一张纸 · 一切写给陌生人看（人和 AI 是同一种读者）· 盒子能互相拼，拼出来的大东西还是盒子。这不是七条建议，而是像几何题一样、从七条公理推导出来的规则。

**三个文档**：预告片 → 宪法 → 每日检查卡——按此顺序读（见上方"先读"）。

**最快路径**：读预告片（[techne-agora.zh-CN.md](techne-agora.zh-CN.md)）；被说服后通读一遍宪法（[techne-arche.md](techne-arche.md)）；再把检查卡（[techne-daemon.md](techne-daemon.md)）交给你的 Agent，开工。

---

## 快速开始

Techne 的完整工作流是一个**四步闭环**，从公理体系直接推导而来（A7·SOP-0·T9·C17·C22）：

1. **触发**（首次）：`/techne-arche` → Agent 读典则，建立体系；然后描述你的项目；
2. **循环**（每轮）：`/techne-daemon` → Agent 读守护灵，按典则作业；继续用自然语言提示词对话；
3. **审计**（形式收口）：`/techne-dokimasia` → 八镜片并行审验（t7/c11/a7/c8/t9/rg/c20/c21），形式挂靠（C20）；零 violation 方可交付；若不满足则修复后重跑第 3 步；交付仍未闭合则自第 2 步再循环；
4. **复核**（事实收口）：`/techne-epikrisis` → r20 单 sub-agent（**不与 dokimasia 并行**，避免单轮 LLM 注意力稀释）；完整性与事实有效性双校验（C22）；零 violation 方可交付。

> **公理推导**：A7（明读）要求读者首次即可理解 → `/techne-arche` 在首次接触时建立完整认知框架；A5（态迹）要求历史只增不删 → `/techne-daemon` 作为常驻投影确保每轮对话不丢失上下文；T9（审计三径）要求三条独立路径验证合规性 → `/techne-dokimasia` 八镜片并行审验（C17）；C22（事实性内容审查义务）要求形式合规后再做内容审查 → `/techne-epikrisis` r20 单 sub-agent（C22）；用户主权决定 audit→epikrisis 还是 epikrisis→audit 顺序，工作流以审计与复核双收口。

### 首次部署

```bash
git clone https://github.com/wuliRothschild/Techne
cd Techne
# 部署前必须先注入 env（脚本不设家目录默认）
export AUDIT_COMMANDS_DIR="${HOME}/.claude/commands"
export TECHNE_SKILLS_DIR="${HOME}/.claude/skills"
bash script/utils/install_audit.sh
bash script/utils/install_epikrisis.sh
ls "${AUDIT_COMMANDS_DIR}"          # 应有 techne-arche.md + techne-daemon.md
ls "${TECHNE_SKILLS_DIR}/techne-dokimasia/"  # 应有 SKILL.md + 8 lens-*.md
ls "${TECHNE_SKILLS_DIR}/techne-epikrisis/"  # 应有 SKILL.md + lens-r20.md
```

### 手动部署（脚本不可用时）

若 `bash script/utils/install_audit.sh` 跑不起来（缺 git、缺 bash、或没有写权限），按下面手抄即可：

1. `cp techne-arche.md "${AUDIT_COMMANDS_DIR:-~/.claude/commands}/"`
2. `cp techne-daemon.md "${AUDIT_COMMANDS_DIR:-~/.claude/commands}/"`
3. `cp -r script/utils/techne-dokimasia/ "${TECHNE_SKILLS_DIR:-~/.claude/skills}/techne-dokimasia/"`
4. `cp -r script/utils/techne-epikrisis/ "${TECHNE_SKILLS_DIR:-~/.claude/skills}/techne-epikrisis/"`
5. 核验 dokimasia：`SKILL.md`、`references/`（含 8 镜片与 `techne-arche.md`）、`scripts/`
6. 核验 epikrisis：`SKILL.md`、`references/lens-r20.md`、`scripts/epikrisis_orchestrator.sh`
7. 与仓库源对照 lens 文件无 diff 即对齐

| 现象 | 先查 | 处理 |
|---|---|---|
| skill 能加载但没有镜片 | `ls ~/.claude/skills/techne-dokimasia/references/` | 重做第 3 步 |
| 审计结果永远空 | 是否有 `references/techne-arche.md` | 手动拷贝该文件 |
| skill 根本加载不了 | `~/.claude/` 写权限 | 修好权限 |
| `purity_scan` 假 PASS | `config/run_config.sh` 里 `CANON_FILE` 是否指向 `techne-arche.md` | 改回默认 |

---

## 1. 来源、目的与第一性原理

techne-demiurge（δημιουργός，造物工匠，依照永恒形式塑造宇宙者）是《Agent 项目架构设计哲学》的**元项目**：

- **`techne-arche.md`** —— 太初（ἀρχή，本原／第一原理／宪制）——典则全文：七公理（A1–A7）→ 十二定理（T1–T12）→ 二十二条推论（C1–C22）→ 构造典则（十型）→ SOP（0–5、7–9）→ 谱系 → 示例 → 附录（还原·术语·自指）。
- **`techne-daemon.md`** —— 守护灵（δαίμων，守护灵／常驻进程）——典则的操作性投影：会话内每一轮完整读取的常驻 Prompt。

**第一性原理**：项目 ＝ 信息 ＋ 推导 的系统；其全部价值在于被未知的未来主体（人或 Agent）无损接管与复合。本元项目自身首先满足该原理——你此刻的无缝阅读即是证明。

## 2. 谱系（出生证明）

父造物：无——**源生项目**：典则在原则上以自身为起点（ἀρχή·太初）。复合方式：不适用。所依典则：自指——本项目即典则之元项目，遵循 `techne-arche.md` 当前态；版本基线见 `HANDOFF.md` 快照。

## 3. 目录释义

本树实例化典则十型（典则 §5.2）。根目录恰容三类：型载体（`README.md` 及语种变体、`HANDOFF.md`）、交付造物（techne-arche／daemon／agora——本体系的公开界面，由 slash command 寻址）、制度文件（`LICENSE`、`NOTICE`、`.gitignore`）；此外无物可居根目录。

```
techne-demiurge/                  （＝仓库根）
├── README.md                    英文版使用文档
├── README.zh-CN.md              本文件（中文版使用文档）
├── HANDOFF.md                   开发轨迹（快照＋倒序条目）
├── techne-arche.md               主交付物：典则全文（太初）
├── techne-daemon.md              交付物：常驻 Prompt（守护灵·投影）
├── techne-agora.md               介绍与论战文（英文版）
├── techne-agora.zh-CN.md         介绍与论战文（中文版）
├── config/                      run_config.sh（唯一机器特定点）＋ default.sh（变体层）
├── source/                      源（不可变；空实例，其历史在 git 中）
├── data/ref  data/pipeline  data/unformatted  output  panel  figure   空阶段（平凡实例）
├── document/
│   ├── research/                背景调研（不可还原）
│   ├── reports/                 结果报告
│   ├── methodology/             方法学（末端唯一 md＋节锚点一名一实）
│   ├── metadata/                样本／对象元信息（空实例）
│   ├── dataset/                 数据集登记（空实例）
│   └── parameters/              参数文档（空实例）
├── script/utils/
│   ├── purity_scan.sh · verify_checksums.sh（维护工具）
│   ├── install_audit.sh             部署形式审计门（dokimasia）到运行时
│   ├── install_epikrisis.sh         部署事实复核门（epikrisis）到运行时
│   ├── techne-dokimasia/            形式审计门源（dokimasia）
│   │   ├── SKILL.md + references/lens-{t7,c11,a7,c8,t9,rg,c20,c21}.md
│   │   └── scripts/{scan_derived_docs,audit_orchestrator}.sh
│   └── techne-epikrisis/            事实复核门源（epikrisis）
│       ├── SKILL.md + references/lens-r20.md
│       └── scripts/epikrisis_orchestrator.sh
└── .git/                        迹（只增不删）
```

## 4. 使用方法

### 4.1 标准工作流（四步闭环）

工作流即「快速开始」的四步闭环，适用于任何 techne 项目（含本元项目）。各步详情与公理依据：

| 步骤 | 动作 | 触发方式 | 公理依据 |
|---|---|---|---|
| 1. 触发 | Agent 读典则，建立体系；然后描述你的项目 | `/techne-arche` 斜杠命令 + 自然语言 | A7（明读）：首次读者须自足理解 |
| 2. 循环 | Agent 读守护灵，按典则作业；继续用自然语言提示词对话 | 每轮 `/techne-daemon` 斜杠命令 | A5（态迹）：历史只增不删，常驻投影保上下文；A2·A3·A4（构造·确定·类型）：推导确定、各归其位 |
| 3. 审计 | 八镜片并行审验（C20 形式挂靠），零 violation 交付 | `/techne-dokimasia` skill | T9（审计三径）· C17（审计门义务） |
| 4. 复核 | r20 单 sub-agent 完整 + 事实双校验，零 violation 交付 | `/techne-epikrisis` skill（**不与 ③ 并行**） | C22（事实性内容审查义务）· A7·T3 |

**顺序与用户主权**：四步闭环中 ③ 与 ④ 的先后由用户主权决定——一般推荐 ③ 先（形式合规在前），亦可 ④ 先（如对抗式审稿）；交付前提是 ③ + ④ 各自零 violation。

**用户主权**：审计门**不**自动触发。主 agent 完成构建后主动提醒用户调用 `/techne-dokimasia`，用户决定是否审计、何时审计、是否接受结果。审计协议（门禁轮数、升用户判据、deterministic 决议）的唯一权威在 [`script/utils/techne-dokimasia/SKILL.md`](script/utils/techne-dokimasia/SKILL.md)。

### 4.2 下游使用（绝大多数 Agent／会话）

- **首次接触**：完整阅读 `techne-arche.md` 一次，建立体系。
- **每轮常驻**：将 `techne-daemon.md` 作为常驻 Prompt（每轮完整读取）。
- **分层阅读协议**：常驻＝第〇层＋第五层＋§5.5；按任务取 SOP；追问理由时回溯定理/公理层；全文复读仅限三种情形——首次接触、典则版本变更、对典则本身做元工作。

### 4.3 维护本元项目

读 `HANDOFF.md` 快照 → 修订典则遵 `document/methodology/methodology.md` §2 → 再生投影遵同文件 §3 → 跑 `bash script/utils/install_audit.sh` 与 `bash script/utils/install_epikrisis.sh`（部署形式门 + 事实门）→ 跑 `script/utils/purity_scan.sh`（有源时另跑 `verify_checksums.sh`）→ **主 agent 主动提醒用户调 `/techne-dokimasia`（形式）与 `/techne-epikrisis`（事实）**（用户主权，不自动；双门零 violation 方可交付）→ 用户验收 → git push（手动）。

本项目迭代遵循 **C19 根本性重构义务**（详 [techne-arche.md C19](techne-arche.md)／附录 C 修正程序）：任何修复或改进须从公理化源头审视，能由既有规则推出则不新增条文，禁止补丁叠补丁。结果报告遵循 **C20 证据挂靠**：每一判断／结论后须挂靠 output／panel 与／或 DOI。

### 4.4 进阶：定制守护投影

默认 `techne-daemon.md` 是典则的**通用**操作核投影：批判性还原、最小重构与审计提醒已内化在其中（daemon §九），会话里调用 `/techne-daemon` 即可，无需在 README 再贴一段提示词。

若任务域需要更贴身的常驻约束（例如只强调某几条 SOP、某领域的命名或入口习惯），可让 Agent **在典则权威下**协助起草一份任务向的守护投影——仍须：
- **不引入**典则外的新规则（C11：投影不是第二真相源）；
- 只压缩／突出与任务相关的操作面，论证仍以 A／T／C／SOP 编号回指典则；
- 典则修订后按 methodology §3 **再生**或对齐该投影；冲突以 `techne-arche.md` 为准；
- 升级条款同标准 daemon：首次接触、典则版本变更、规则分歧、改典则本身时回归全文。

定制投影可放在目标项目的 `document/methodology/` 层内唯一正文中作「常驻节」，或作为会话级附加读本；**不得**替代本仓库发布的 `techne-daemon.md` 成为跨项目的第二权威源。

## 5. 复现引导

验证态纯（A5·C5）：`bash script/utils/purity_scan.sh`。有源时验证源不可变（A1）：`bash script/utils/verify_checksums.sh`（`source/` 当前为空实例）。重推典则（T3 的逻辑重放）：任选一条规则，沿推导链标注（［A→T→C→§］）回溯至公理；附录 A 给出全部候选"公理"的还原证明。按 `document/methodology/methodology.md` 再生投影并与 `techne-daemon.md` 比对。

## 6. 交付物清单

| 交付物 | 类型 | 下游用法 |
|---|---|---|
| `techne-arche.md` | 典则（造物） | 一切项目的架构宪法，可引用、内化（`document/research/`）或作他项目之源被复合 |
| `techne-daemon.md` | 投影（派生物） | 常驻 Prompt；不得脱离典则单独修订 |
| `document/research/` | 调研（造物） | 各规则的出处与裁断理由；修订典则前必读 |

## 7. 外部依赖与迁移注意

无外部运行时依赖（闭包 T5）；唯二工具依赖为 POSIX 基础工具（`md5sum`、`grep`），见 `config/run_config.sh`。迁移：整体复制项目目录即可；换机仅需核对 `config/run_config.sh` 中的工具路径。禁忌：不得在 techne-arche.md 中写入修订痕迹、版本词或外部文档指涉（A5）；不得单独修订 techne-daemon.md 而不同步典则（C11）；不得改写 git 历史——迹只增不删（A5）。

## 8. 许可与署名

本仓库一切内容（典则、daemon、agora、`document/**`、脚本、README、HANDOFF）采用 **CC BY 4.0**（见 `LICENSE`）。允许任意使用、改编与再分发（含商用）——但**必须署名**：注明"Techne by wuliRothschild"、链接本仓库、标注改动之处、并保留 `NOTICE` 文件。"Techne"名称与 techne-* 命名族不授予商标使用权。Techne 体系由 wuliRothschild 于 2026-07-21 首创并公开发表。

---

> ἀρχή（太初，本原）· δαίμων（守护灵）· δημιουργός（营造者）· ἀγορά（广场）——每一件造物服从同一形式，每一次会话始于同一读本，每一个终点都是下一件造物的起点。
