# Techne — every techne a work of craft, every work a foundation

[English](techne-agora.md) | [简体中文](techne-agora.zh-CN.md)

> A public-square (ἀγορά) document for the Techne canon: what it is, and why it aims beyond "skills".

**This is an idea file.** Copy-paste it to your own LLM agent (Claude Code, Codex, Kimi, …). It communicates the pattern; the full, self-contained canon lives in this repository — [`techne-arche.md`](techne-arche.md) — and your agent can instantiate techne with you from there. Chinese edition: [`techne-agora.zh-CN.md`](techne-agora.zh-CN.md).

## The core idea

Most agent sessions today end the same way: the agent chats back some files. The files are… somewhere. The reasoning is… gone. Ask the next session — even the *same* agent — to continue, modify, or audit the work, and it must do archaeology: which file is final? which parameters were used, and why? what was tried and failed? Nothing accumulates; every session re-derives the world from scratch.

The industry's current answer is the **skill**: a packaged how-to (a `SKILL.md` plus resources) that teaches an agent a procedure — make a deck, fill a PDF, build a spreadsheet. Skills are genuinely useful. But notice what a skill *is*: a page of instructions about a task. It says nothing about what the task **leaves behind**. A skill tells the agent how to build; it does not define what a build *is*. The output of a skillful session is still a pile of artifacts with no stable address, no provenance, no memory, and no way to be picked up by the next reader — human or machine.

Techne inverts the viewpoint. The unit of agent work is not the task, and not the skill. It is the **project** — and every project is a **work** (造物):

- **self-contained** — nothing referenced lives outside the work;
- **reproducible** — every derived artifact has an executable chain back to immutable sources;
- **structurally identical** to every other work — learn one, you have learned all;
- **state/trace separated** — the present contains no history; history lives append-only elsewhere;
- **single-point interface** — one config file absorbs all machine/account/platform variance;
- **legible to a first-time reader** — human or AI: the same reader, no oral tradition;
- **composable** — works compose into new works, and the composite is still a work.

These are not seven features. They are seven **axioms** (A1–A7); everything else — twelve theorems, twenty-two corollaries, ten canonical types, nine SOPs (SOP-0..5, SOP-7..9) — is *derived*, not stipulated. Any rule without an axiomatic source does not hold.

## Why not skills

Skills and techne answer different questions. That is precisely the point.

| | **Skill** | **Techne** |
|---|---|---|
| Question | *How* does the agent do task X? | *What* is the project that X leaves behind? |
| Nature | procedural note (说明书) | constitution of existence (存在形式的宪法) |
| Content | instructions (+ optional resources) | sources, derivations, outputs, documents, trace — the whole project |
| State | stateless; every call starts cold | state & trace, separated; memory compounds across sessions |
| Reproducibility | best-effort | theorem (T3): same inputs + same interface ⇒ same outputs |
| Auditability | none | three independent paths: re-run, trace back, read the record (T9) |
| Composition | none — skills don't compose | techne compose; the composite is still a techne (T10, associative) |
| Takeover | not designed for it | designed for exactly one thing: lossless takeover by an unknown future reader |
| Trust model | trust the author | run the checks (`verify_checksums`, `purity_scan`, SOP-9 list) |
| Loading | progressive disclosure | layered reading protocol (same idea, generalized) |

Five claims follow.

**1. Every skill can be internalized into a techne — losslessly.** The instructions become a skill-anchor section in the methodology body; the scripts become `script/utils/`; the templates and reference files become `data/ref/`; the usage contract becomes an SOP or a section of the resident prompt. Skill ⊂ Techne.

**2. No techne can be expressed as a skill.** The skill format has no place for immutable sources with checksums (A1), a deterministic derivation chain (C1), state/trace separation (A5), a genealogy of parent techne (T10), or an append-only record of decisions (HANDOFF). The containment is proper: **Skill ⊊ Techne**.

**3. Therefore the target is not skills, but the formlessness after skills.** Techne do not compete with a good procedure; they give every procedure's output a *form* — addressable, reproducible, auditable, composable. If skills are how an agent learns a craft, techne are the physics of the world the craft is practiced in.

**4. Techne need no separate maintenance — using a techne *is* maintaining it.** A skill is a side artifact: written apart from the work it describes, it decouples from reality and rots. A techne is maintained *by* the work itself — every build, analysis, fix, and improvement performed under the canon leaves the techne more complete: its HANDOFF richer, its methodology sharper, its outputs more reusable. There is no maintenance budget to blow, because the project's upkeep *is* the techne's upkeep. And because techne compose (T10), yesterday's well-kept techne become today's immutable sources: every project adds permanent, reusable value to every future project that extends it. Skill upkeep is a recurring cost; techne upkeep is compound interest.

**5. Skills depreciate with the model; techne don't.** A skill encodes a procedure calibrated to what today's model *cannot yet do*. As models improve, most skills quietly expire — the procedure becomes native ability, and the note becomes a museum piece. A techne encodes no procedure at all: it specifies what must *hold* of the result — form, provenance, auditability — whatever the agent's ability level. The problem skills answer (teach the model a task) is model-dependent and shrinks as models grow; the problem techne answer (lossless takeover by an unknown future reader, across machines and time) is model-independent and does not. Stronger models make the constitution *more* necessary, not less: the more powerful the agent, the more valuable the form that disciplines its outputs. The canon itself can be amended (it carries its own amendment procedure), but amendment here is growth, not decay. Skills age like tutorials; techne age like law.

(Karpathy's `llm-wiki` pattern makes the same point from another domain — see *Why this works*.)

## Architecture

The system rests on three stone files, each with a Greek name and a single job:

| File | Role | Etymology |
|---|---|---|
| [`techne-arche.md`](techne-arche.md) | the canon — the full axiomatic system | ἀρχή: first principle, origin, rule — 太初 |
| [`techne-daemon.md`](techne-daemon.md) | the resident prompt — read in full every round | δαίμων: guardian spirit; a resident process — 守护灵 |
| [`HANDOFF.md`](HANDOFF.md) | the trace — state snapshot + append-only reverse log | — |

The canon itself is a derivation stack:

```
A1 源始 origin       A2 构造 construction   A3 确定 determinism   A4 类型 type
A5 态迹 state/trace   A6 界面 interface      A7 明读 legibility
        │
        ▼  twelve theorems (T1–T12)
  T3 reproducibility · T6 structural isomorphism · T9 audit (3 paths) · T10 techne composition …
        │
        ▼  twenty-two corollaries (C1–C22)
  C1 verification chain · C5 state purity · C12 dataset equivalence …
        │
        ▼  construction canon — ten types, one tree for every project

<project>/
├── README.md      usage knowledge (state)         ├── config/    the only machine-specific point
├── HANDOFF.md     decision trace (append-only)    ├── script/    derivations: pipeline · datasets · utils
├── source/        given, immutable, checksummed   ├── document/  research · reports · methodology ·
├── data/          ref · pipeline · unformatted    │              metadata · dataset · parameters
├── output/        publishable assertions          ├── panel/     raw visualizations
└── figure/        declared hand-finish only
```

Every project — omics analysis, literature review, software build, knowledge base — is an instance of the same tree. Stage slots may be empty; types are never merged, renamed, or invented per-project.

## Operations

**Four-step closed loop** (A7·SOP-0·T9·C17·C22) — the full workflow for any techne project:

1. **Trigger** (first time): `/techne-arche` → Agent reads the canon, builds the system; then describe your project in natural language;
2. **Loop** (every round): `/techne-daemon` → Agent reads the daemon, works per canon; continue the conversation with natural-language prompts;
3. **Audit** (close, form): `/techne-dokimasia` → eight-lens parallel audit (form; C20); zero violation required for delivery.
4. **Epikrisis** (close, content): `/techne-epikrisis` → r20 single sub-agent (factual completeness + factuality; C22); not parallel with step 3; zero violation required for delivery.

Within that loop, the daily mechanics stay the same:

**Boot (SOP-0).** New session: read README → read top of HANDOFF → read config → state an alignment conclusion (what can be reused, what must be built, what must change). No alignment, no work.

**Delegate.** Project composition is governed by T10 (a direct corollary of A1–A7·T5). When composing projects, the new project's `source` accepts a parent project's `output` (with checksums and a genealogy entry); never modify an upstream project to fit a downstream need. All adaptation happens in the downstream's interface layer and dataset-specific application layer.

**Work (SOP-2).** Every decision logged the same day, with reasons and candidates. Every artifact lands in its type's place immediately. External dependencies: internalize into `data/ref/` *or* declare in config — two choices, no third. Non-deterministic inputs (API responses, manual judgment, sampling) are frozen into source/data artifacts with checksums *before* entering the chain.

**Close (SOP-3).** Re-run touched chains → finish today's HANDOFF entry → purge process traces from state → one atomic commit per complete intention → check against the SOP-9 acceptance list. The deliverable must itself be a composable, compliant techne.

**Audit (SOP-7).** Three independent paths, cross-validating: re-compute and compare (forward); walk the chain back to source and verify checksums (backward); read the HANDOFF narrative of *why* (narrative). The audit gate is user-sovereign: main agent reminds, user invokes `/techne-dokimasia`.

## Reading protocol (the daemon)

Reading the whole canon every session is *not* best practice — the canon itself says so. First contact: read [`techne-arche.md`](techne-arche.md) once, in full, to build the system. Resident: [`techne-daemon.md`](techne-daemon.md) — a ~70-line operative projection with a four-clause header declaring it a *projection*, never a second source of truth — read every round. Per task: pull the relevant SOP. Full re-read on three occasions only: first contact, canon version change, or meta-work on the canon itself.

## A worked example: this repository

Techne ships as its own meta-project — **techne-demiurge** (δημιουργός, the craftsman who fashions worlds from eternal forms). The repo you are reading is a techne that produces the canon. Its `source/` is an empty instance — state/trace separation taken to its limit: history is kept outside the current state, in git history and in [`HANDOFF.md`](HANDOFF.md), append-only and publicly auditable; the canon is, in principle, its own origin. `document/research/` holds the project's irreducible research documents (C15); `document/reports/` holds the result reports of canon iterations; `HANDOFF.md` records every decision with its reasons — the public audit trail behind every claim in this repo. From that discipline comes one timeless rule: *push nothing from memory; verify everything by hash.*

## Tips and tricks

- **Verify sources**: `bash script/utils/verify_checksums.sh` — makes "immutable" checkable.
- **Lint state purity**: `bash script/utils/purity_scan.sh` — greps the canon for revision traces, version words, and cross-references that must not live in state.
- **Edit serially**: parallel edits to one file race; serial edits avoid race loss of concurrent writes. Serialize.
- **Push nothing from memory**: read the file from disk immediately before any transfer; accept "blob SHA equal" as the *only* acceptance criterion.
- **Naming**: family members take Greek/Latin roots — ἀρχή 太初 (canon), δαίμων 守护灵 (guardian), δημιουργός (maker), ἀγορά (this square). Etymology is logged in HANDOFF.

## Why this works

The tedious part of project work is not the thinking — it is the bookkeeping: naming, filing, logging decisions, keeping the present free of history, keeping dependencies declared. Humans abandon such discipline because maintenance cost grows faster than value. Agents don't get bored — but they *do* forget, because they have no past. Techne's answer: make the bookkeeping **structural** (types, not intentions), make the memory **a file** (HANDOFF, not chat history), and make the rules **derivable** (seven axioms, not seven hundred conventions). The agent never has to remember *that* it must log; the SOP it already read tells it *when*, and the form tells it *where*.

It is worth noting how Karpathy's [`llm-wiki`](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f) pattern independently rediscovers the same categories in the personal-knowledge domain: immutable *raw sources* ≙ `source/` (A1); the compounding *wiki* ≙ project state (A5); the *schema* (`CLAUDE.md`) ≙ `techne-arche.md` + `techne-daemon.md`; content-oriented *index.md* ≙ `README.md`; chronological append-only *log.md* ≙ `HANDOFF.md`; the *Lint* operation ≙ SOP-7 + `purity_scan`; "good answers filed back into the wiki" ≙ results filed to `document/reports/` (T12). `llm-wiki` is a techne instantiated in the knowledge-base domain; Techne is the axiomatized general form of that pattern — for every domain an agent delivers in.

## Scope and limits

Honesty section. Techne are not free: the canon costs context on first contact (the daemon is cheap thereafter), and the full SOP discipline is overkill for one-shot Q&A with no deliverable. Skills remain the lighter tool for *stateless micro-procedures* — how to call an API, how to format a date — where there is no project to leave behind. The two compose well: keep your skills, and file them into techne (`document/methodology/`), where they gain provenance, audit, and memory. The claim here is not "delete your skills"; it is that the skill paradigm, alone, leaves agent work formless — and that form is derivable.

## Note

This document is intentionally one level above the canon. The exact structure, the ten types, the SOPs, the acceptance lists — all live, self-contained, in [`techne-arche.md`](techne-arche.md); the operative minimum in [`techne-daemon.md`](techne-daemon.md). Everything is modular: instantiate the tree for your domain, keep what serves, and let the HANDOFF record what you changed and why. This document's only job is to communicate the pattern — if it is the trailer, then 太初 is the constitution and 守护灵 is the daily checklist pinned above the workbench — and to state, in the open square, that the age of formless deliverables can end.
