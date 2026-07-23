# 方法学

> **角色**：方法学层唯一正文与入口（C16·§5.4-5）。  
> **阅读路径**：新接手者 §1 → 维护者按任务取 §2–§3 → 审计者 §4–§5 → 构造者索引 §6。  
> **一名一实**：脚本／规程与本节锚点一一对应。

### 节锚点索引

| 节 | 职能 |
|---|---|
| §1 总览 | 两层循环、阅读路由、设计理由 |
| §2 典则修订 | 附录 C · C19 最小重构程序 |
| §3 投影再生 | daemon 与 arche 同态 |
| §4 态纯扫描 | `purity_scan.sh` 方法与校验 |
| §5 源校验 | `verify_checksums.sh`（有源时） |
| §6 构造者锚点 | install／扫描／编排与 §4–§5 一名一实 |
| §7 公开发布 | 态／迹分发、敏感门、禁止回声 |

---

## 1. 总览

techne-demiurge 的方法学服务两层循环。

**（1）一切 techne 项目的标准工作流**——详见 [`README.zh-CN.md`](../../README.zh-CN.md) 快速开始／§4.1 与 [`README.md`](../../README.md)（不复制；用户主权宣示已并入 `script/utils/techne-dokimasia/SKILL.md` 与 `script/utils/techne-epikrisis/SKILL.md`）。本节只维护元项目特有步骤。

**（2）本元项目维护循环**（在（1）之内——典则修订后再生 daemon，再 purity_scan，再交付前调审计门 + 复核门）：

```
修订典则（§2） → 再生投影（§3） → 态纯扫描（§4） → 源校验（§5，有源时） → HANDOFF → 审计门（dokimasia） → 复核门（epikrisis） → 提交
```

**组件衔接与设计理由**（A2·A5·C17·C22）：`install_audit.sh`／`install_epikrisis.sh` 将 skill 单元幂等部署至运行时目录（env 注入，无家目录硬编码）；`purity_scan.sh` 证态纯（A5·C5）；`verify_checksums.sh` 证源不可变（A1，空源 SKIP）；`scan_derived_docs.sh`／`audit_orchestrator.sh` 服务形式门八镜；`epikrisis_orchestrator.sh` 服务事实门 r20。双门**不并行**（C22），顺序由用户主权决定。构造者表见 §6。

典则（`techne-arche.md`）是唯一权威源。修订后必须再生 `techne-daemon.md`（C11），再通过 purity_scan（A5·C5）；有源之日另跑 verify_checksums（A1·C8）。修正程序见典则附录 C 与 C19：一次推导、最小重构、态只留现在时。

HANDOFF 秉笔直书 6 件齐备与居所唯一见 **C21**（本处不复述）。

| 读者 | 先读 | 再读 |
|---|---|---|
| 下游构建者 | README 快速开始 | §1 |
| 维护者（改典则） | §2 → §3 | §4 · §6 |
| 审计者 | §4 → §5 · §6 | — |
| 新接手者 | §1 节索引 | 按上表 |

---

## 2. 典则修订方法学

> 对应对象：`techne-arche.md` 的任何变更。

### 2.1 职责

规定修改典则的完整流程，使每次修订满足附录 C 并保持 daemon 同步。

### 2.2 方法学

1. **提案定性**：公理层 → 主版本；定理／推论层 → 次版本；构造／制度层 → 修订号（附录 C）。
2. **批判性还原**（附录 A · C19）：新规则若无公理出处，先尝试还原为既有定理／推论；能还原则不新增条文；必须新增时并入应在层级。
3. **最小重构**（C19）：改写宿主条款为**单一连贯表述**；删除被取代的旧句、例外编号与并行解释；禁止补丁叠补丁。
4. **推导链更新**：检查受影响规则的［A→T→C→§］是否仍闭合。
5. **同步投影**：按 §3 再生 `techne-daemon.md`（不可豁免）。
6. **纯净性扫描**：`script/utils/purity_scan.sh`，零命中方可收尾。
7. **记录与提交**：理由与版本基线入 HANDOFF；git 原子提交。

### 2.3 校验

purity_scan 零命中；附录交叉引用闭合；daemon 与 arche 映射可对（§3.3）；全文无“旧句＋补丁句”双层并存。

### 2.4 上下游

上游：HANDOFF 快照中的版本基线。下游：`techne-daemon.md`、README 谱系（若版本变更）、公开仓库推送。

---

### 2.5 审计门判定纪律

主 agent 收 8 镜片 findings 后，按 **C19／附录 A** 还原为公理给出 **deterministic** 结论（接受/反驳附 axiom_trace）；升用户仅在 axiom_trace 真正 ambiguous 时。协议细节（门禁轮数、升用户判据、镜片清单）以 `script/utils/techne-dokimasia/SKILL.md`（C17）为唯一权威；本节不复制。

## 3. 投影生成方法学

> **最小重构**：修订后须再生 daemon 为当前态全文；禁止残留旧句（C19）。（arche → daemon）

> 对应对象：`techne-daemon.md`。daemon 只允许由本方法学生成，禁止游离修订。

### 3.1 职责

由典则全文生成常驻投影：每轮可读、最小自足、永不独立。

### 3.2 压缩规则

- **只取操作面**：规则、禁令、协议、目录树；不取证明机器。  
- **指针替代复制**：论证以 A／T／C／SOP 编号引用。  
- **四条款头部**：性质／权威／同步义务／升级条款。  
- **长度约束**：约 70–90 行量级；超限先压缩表述，不得删禁令。  
- **与 arche 同态**：禁令计数、document 末端规则、SOP-2 文档同步句、知识单点表述须与当前 arche 一致。

### 3.3 节映射（arche → daemon）

| techne-arche.md | techne-daemon.md |
|---|---|
| 0.1 一句话 | §一 |
| C17 · C22 · SOP-0（运行时四角工作流合取） | §二 |
| SOP-0 | §三 |
| §5.1–5.2 十型与树 | §四 |
| C1 | §五 |
| §5.5 二十三条禁令 | §六（全量） |
| SOP-2 · 附录 A · C19 · C20 · C22 | §七（每轮作业纪律；含即时 HANDOFF + verbatim 入条 + 报告证据挂靠 + 事实性内容审查） |
| SOP-3 · C17 · C22 | §八（收尾；审计门 + 复核门指针） |
| T12 · §5.3-4 · C19 · C20 · C22 | §九 |

### 3.4 校验

映射无缺；四条款头部在；禁令计数＝arche 当前数；无 arche 中不存在的规则；末端一文件／最小重构出现于 §三或 §九。

---


## 4. purity_scan

> 脚本：`script/utils/purity_scan.sh`。

仅 HANDOFF 豁免（迹）。research／reports 为态，不整文件豁免；领域泄漏由 t7 语义审，purity 词表不列领域专名（T5·T6）。

### 4.1 职责

扫描 `techne-arche.md`（可选 daemon），检出修订痕迹、版本词、外部文档指涉——守护 A5·C5。

### 4.2 方法学

以 `PURITY_PATTERN`（`config/run_config.sh`）为正则 grep；零命中通过。模式集针对**自述性**痕迹，不含规则条文内作为反例的引述字样。

### 4.3 校验

脏文本应被命中；当前 arche／daemon 应 PASS。

---

## 5. verify_checksums

> 脚本：`script/utils/verify_checksums.sh`。

### 5.1 职责

核验 `source/` 自内化以来未被改动（A1·C8）。元项目 source 当前为空实例；有源之日执行；实例化项目可复用。

### 5.2 方法学

在源目录对 `checksums.md5` 执行 `md5sum -c`；全部 OK 为通过。FAILED 则恢复原件并查 HANDOFF。

### 5.3 校验

人为改动源文件应 FAILED；合规态全部 OK。

---

## 6. 构造者锚点（与 §4-§5 一名一实）

| 构造者 | 职责 | 上下游 |
|---|---|---|
| `script/utils/install_audit.sh` | 部署 dokimasia skill 至运行时目录；md5 幂等；env 注入 | 调用方：用户／元项目维护循环 |
| `script/utils/install_epikrisis.sh` | 部署 epikrisis skill 至运行时目录；md5 幂等；env 注入 | 同上 |
| `script/utils/techne-dokimasia/scripts/scan_derived_docs.sh` | 派生文档扫描（C18） | 上游：purity_scan；下游：审计门 |
| `script/utils/techne-dokimasia/scripts/audit_orchestrator.sh` | 8 镜片 sub-agent 编排 | 入口：审计门触发 |
| `script/utils/techne-epikrisis/scripts/epikrisis_orchestrator.sh` | r20 单 sub-agent 编排（事实性内容） | 入口：epikrisis 触发 |
| `script/utils/public_sensitivity_scan.sh` | 公开发布前敏感字面门（路径／实例回声／外部产品名） | 上游：态纯与闭包语义审；下游：公开 push |

每行对应一个可执行构造者，与 §4-§5 一名一实；新增构造者须在此增行（C11）。

---

## 7. 公开发布（态／迹分发）

> 脚本：`script/utils/public_sensitivity_scan.sh`。公理：A5·T5·C15·C21。

### 7.1 职责

把**可公开的态**与**不可公开的维护迹**分开：私有 HANDOFF 可含完整 verbatim 与排查细节；公开树默认**不**携带私有 HANDOFF 全文。若公开需要迹，仅允许**最小公开迹**（无本机绝对路径、无会话 UUID、无他项目实例回声——后者由语义闭包审，不靠公开词表复写）。

### 7.2 方法学

1. **导出**：自私有仓 `git ls-files` 复制态与脚本；**默认排除**私有 `HANDOFF.md`，或替换为公开最小迹模板（见公开仓 `HANDOFF.md`）。  
2. **结构隐私门**：在公开树根执行 `bash script/utils/public_sensitivity_scan.sh .` — 只检**机器坐标**（绝对路径形、会话 UUID 形）；零命中方可继续。  
3. **语义闭包（不靠词表）**：他项目实例表值、外部产品专名、领域样本堆砌的归属判定由 dokimasia（t7／c20／C15）语义审；**禁止**在元项目工具层维护一份「他项目禁词表」——那会把他项目实例重新内嵌进 meta 工具（违 T5 闭包与 A5 态纯）。  
4. **禁止 verbatim 回声入公开迹**：私有 HANDOFF 的 (a) 原文与排查可含敏感；发布时不得把该回声拷入公开树（methodology 本条 + c21 公开迹分岔）。  
5. **文献形式不禁**：DOI／PMID 作为本项目论证标识可出现于态（C20）。  
6. **干净历史**：公开仓独立 root；误发后 **force 换根** 撤回敏感 blob（私有仓仍 append-only）。  
7. **用户确认**：重建公开仓与 push 前须用户主权确认。

### 7.3 校验

故意放入的本机路径／UUID 应 FAIL；当前可发树应 PASS。语义闭包仍由 dokimasia 承担——结构门是**坐标后门**，不是领域词表。

### 7.4 上下游

上游：私有仓合规态 + 私有 HANDOFF。下游：公开 git 远程。
