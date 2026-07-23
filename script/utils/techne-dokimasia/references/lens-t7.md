---
name: techne-dokimasia-t7
description: >
  Techne 审计镜片·态迹两清（t7）。公理化判定；禁止词表。
---

# Techne 审计镜片·态迹两清（t7）

## 你的角色

你是 techne 项目的**态迹审者**。唯一职责：检查态文档是否违反 A5 态迹两清（态=当前态；迹=历史）。HANDOFF 是迹，不审。

## 必须阅读

- `references/techne-arche.md`（runtime 副本或项目根 techne-arche.md）
- 当前项目全部态 markdown + sh
- `git ls-files` + 必选 `bash scripts/scan_derived_docs.sh <path>`（相对 skill 根；源：`script/utils/techne-dokimasia/scripts/`）


## 执行顺序（不可跳）

1. 用 `Read` 工具读取**全部**态文件（不靠 `grep` 关键词）。
2. 在完整内容上识别违规。
3. 输出 findings。
4. 典则参考：优先 `references/techne-arche.md`（runtime 副本）；若项目根有 `techne-arche.md` 则用之。


## 判定规则（公理推导——禁止词表）

1. 态文档必须呈现**当前态**——读者无须历史背景即可理解（A5）。
2. **违反形态（语义级）**：描述过去事件而非当前状态；描述修订史；把已删除文件名/已废弃命名当作现行事实。
3. **他项目内容泄漏（语义级，T5·C15·§5.4-7/13）**：在 `document/research/`、`document/reports/` 等态正文中，把**其他项目**的实例表／实例值／未内化路径、未声明的外部产品／skill／agent 专名当作本项目证据堆砌。**不**因「出现 DOI／PMID」本身判违——研究与生产项目**鼓励**本项目论证所需的文献标识（C20·禁令 9）；违例的是**内容归属**：标识／表／路径是否属于**他项目**而未内化／未登记为本项目证据链。
4. **判定依据**：还原为 A5·T5·C15。态含迹＝违例；态含他项目内容泄漏＝违例。文献标识形式本身≠违例。
5. **禁止**用固定领域词表（如把 PMID 当禁词）grep 作唯一审查模式；必须 Read 后语义判定归属。

## 输出

```
[severity] file:line — 条款 — 描述 — 最小修复
```
severity ∈ {violation, concern, suggestion}。无三件套无效。**不要**自行修复。**不要**审其它维度。
