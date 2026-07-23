# 常驻 Prompt（守护灵）· Agent 项目架构设计哲学（操作核投影）

> **性质**：本文件是《techne-arche.md》（Agent 项目架构设计哲学，下称**典则**）的操作性投影，供会话内每一轮完整读取。
> **权威**：典则是唯一权威源。本投影不含典则之外的任何规则；一切冲突以典则为准；引用规则用推导链编号（A／T／C／SOP），不复制其论证。
> **同步义务**：典则修订后，本投影须同步再生。
> **升级条款**（出现以下任一情形，回归典则全文）：首次接触典则；典则版本变更；规则分歧或审计；修改典则本身。

---

## 一、一句话

**每个项目是一件造物：源不可变、链可复现、结构同构、态迹两清、界面单点、人与 Agent 同等可读、可与其他造物复合为新造物。** 全部规则由七公理生成——A1 源始 · A2 构造 · A3 确定 · A4 类型 · A5 态迹 · A6 界面 · A7 明读；无公理出处的规定不成立。

## 二、运行时四角（接口层）

```
/techne-arche        首次接触或升级条款触发——读典则全文，建体系；然后描述项目
/techne-daemon       每轮循环——读守护灵投影，按典则作业；继续用自然语言提示词
/techne-dokimasia    形式审计收口——用户显式触发；八镜片（t7/c11/a7/c8/t9/rg/c20/c21）
                     并行审；零 violation 方可交付（C17 审计门，C20 形式挂靠）
/techne-epikrisis     事实性内容审查收口——用户显式触发；r20 独立 sub-agent 审
                     完整性 + 事实有效性；零 violation 方可交付（C22 事实审查）
```

**顺序与用户主权**：四步闭环的工作流（详见 README 快速开始／§4.1）为 `trigger → residence → audit → review`，**用户主权**决定先 audit 还是先 review——一般推荐 audit 先（形式合规）、再 review（事实合规）；亦可 review 先（如对抗式审稿）。

## 三、开工前（每会话一次，SOP-0）

1. 读目标项目 `README.md` → 上下文、用法、谱系；
2. 读 `HANDOFF.md` 顶部 → 现状与最近决策；
3. 读 `config/` 环境层 → 环境；
4. 输出**对齐结论**（哪些造物可复用／什么需新建／什么需调整）——**未对齐，不动工**。

## 四、典则十型与目录树（T6）

阶段脊：`source → data → output → panel → figure`；角色肋：`script` · `config` · `document` · `README.md` · `HANDOFF.md`。

```
<项目>/
├── README.md  HANDOFF.md
├── config/    run_config.<ext> · <variant>.<ext>
├── source/<dataset>/
├── data/      ref/ · pipeline/<dataset>/ · unformatted/<dataset>/
├── output/<dataset>/   panel/<dataset>/（_summary/）  figure/<dataset>/
├── document/  research/ · reports/ · methodology/ · metadata/<dataset>/ · dataset/ · parameters/
│              （每个末端叶子仅一份 md；methodology 文首＝入口，节锚点＝一名一实）
└── script/    pipeline/{上游,下游}/ · datasets/<dataset>/ · utils/
```

顶层类型不可增删改名（C4）；多数据集先 `<类>/<dataset>/`（C12）；变体输出隔离于 `<variant>/`（C9）。

## 五、验证链（C1）

```
source →(script)→ data →(script)→ output →(script)→ panel →(script／声明的编辑)→ figure
source →(script)→ data →(script)→ panel →(script／声明的编辑)→ figure
```

## 六、二十三禁令（§5.5）

1 硬编码绝对路径；2 项目外引用／跨项目记忆；3 态内嵌修订／版本／会话痕迹；4 未声明手改下游；5 私创／合并／改名顶层类型；6 第二个机器配置文件；7 跨变体写入／引用；8 知识两处存放；9 孤立参考文献清单；10 未冻结非确定输入；11 反向依赖；12 文档三角缺面；13 数据集 ID 多别名；14 半成品入 research；或 research／reports 态堆砌他项目实例内容（他仓路径／未声明外部产品专名；本项目 DOI／PMID 不禁）；15 git 跟踪过程态与大文件；16 多数据集平铺；改上游适配下游；17 结果无 reports；18 数据集无结构化登记；19 表格方言化；20 知识层无入口；21 document 末端多 md 或 md 裸露于 document 根；22 报告判断／结论无证据挂靠（无 output／panel 且缺所需 DOI）（C20）；23 报告证据仅路径存在／单边／幻觉数字／DOI 不解析（C22）。

## 七、每轮作业纪律（SOP-2 · 附录 A · C19 最小重构的操作化复述；不引入新规则）

从 A1–A7 审视当前任务 → 还原缺口／误读 → 能推则不增 → 必要时按附录 A 并入应在层级 → 改写宿主条款为单一连贯表述（删旧句、删旁注、删并行解释）→ 同步投影与方法学 → **每轮 verbatim 记录于 HANDOFF 对应条目（原始提示词原封不动 + 决策 + 讨论 + 轨迹 + 所有改动 + 见解），不延迟、不省略、不附录化（秉笔直书）** → **结果报告每一判断／结论后挂靠 output／panel 与／或 DOI（C20，形式）** → 交付前**提醒用户**调 `/techne-dokimasia` 与 `/techne-epikrisis`（用户主权，不自动；四步闭环）。

详 SOP-2 与附录 A、C19（最小重构）、C8（审计日常化／HANDOFF 当日入迹）、C20、C22；秉笔直书 6 件齐备见 C21。

## 八、收尾（SOP-3）

重跑触及的链（或声明未验证项及原因）→ HANDOFF 当日条目＋快照 → 态当前态化 → **运行时四角收口**：审计门（C17）零 violation + 复核门（C22）零 violation → git 原子提交 → SOP-9 验收。交付物须为可接续积木（T10）。审计门协议的完整细节在 C17，epikrisis 复核门协议的完整细节在 C22；他处不再复述。

## 九、知识单点 · 末端一文件 · 最小重构 · 证据挂靠 · 事实性内容审查

使用 → `README.md`；轨迹 → `HANDOFF.md`；方法 → `document/`。同一句话不写两遍。
document 每叶子仅一份 md；一名一实＝一脚本一锚点；Methods 对标发表级文风。
迭代遵 C19（含附录 C 最小重构程序）。
**结果报告遵 C20**：判断／结论后立即挂靠 `output/`／`panel/` 与／或可解析文献标识（DOI 等，**鼓励**），禁止悬空断言；禁止**他项目**内容泄漏入态（C15·T5）。
**事实性内容遵 C22**：挂靠之外，所引证据须真支撑；证据完整性 + 事实有效性由 `/techne-epikrisis` 独立审查。
