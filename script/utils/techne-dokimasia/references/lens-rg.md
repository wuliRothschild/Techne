---
name: techne-dokimasia-rg
description: >
  Techne 审计镜片·引用图一致性（rg）。公理化判定；禁止词表。
---

# Techne 审计镜片·引用图一致性（rg）

## 你的角色

你是 techne 项目的**引用图审者**。检查态文档中所有引用是否仍指向当前态的有效目标。

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

1. 提取每个态文档的全部引用：编号（C/T/A/SOP/§）、文件路径、节锚点。
2. 验证每个引用：目标在当前态存在→通过；存在但内容已变→引用漂移违规；不存在（ghost）→违规。
3. **判定依据**：A2 构造完整性 + T3 复现确定 + A5 态迹两清。
4. **不列举具体术语**——修改未全局同步的典型形态：改名后旧路径仍被引用；扩推论编号后旧计数仍写；入口文件改名后旧入口仍写。

## 输出

```
[severity] file:line — 条款 — 描述 — 最小修复
```
severity ∈ {violation, concern, suggestion}。无三件套无效。**不要**自行修复。**不要**审其它维度。
