# Techne — The Agent Project Architecture Philosophy

[English](README.md) | [简体中文](README.zh-CN.md)

> The way begets one; one begets two; two begets three; three begets the myriad creatures.

> One canon for every project an Agent builds and delivers. **Every project is a work**: immutable sources, reproducible chains, isomorphic structure, state/history separation, single-point interfaces, equal readability for humans and Agents, composable into new works. All rules are derived from seven axioms; nothing without an axiomatic source holds.

**Read first**: [`techne-agora.md`](techne-agora.md) (introduction & why-beyond-skills) → [`techne-arche.md`](techne-arche.md) (the canon) → [`techne-daemon.md`](techne-daemon.md) (resident prompt)

> This repository is the **techne-demiurge** meta-project — it produces, maintains, and iterates the works above. New session boot sequence: this README → top of `HANDOFF.md` → work.

---

## The 3-Minute Version (new to AI agents? Start here)

**One line**: AI agents forget everything between sessions — so this project gives every project a self-documenting shape: a **box** that any future reader (human or AI) can understand, verify, and build on, without asking anyone.

**The pain.** Using an AI assistant today is like hiring a brilliant chef who loses all memory every 24 hours. The industry's current answer, *skills*, are recipe notes — they teach the agent how to cook a dish, but say nothing about the state of the kitchen. Techne defines the kitchen.

**The seven house rules, in plain words**: raw materials are locked away untouched · every result comes with the exact recipe to reproduce it · every box has the same layout (learn one, know all) · the present and the history live apart (history in one append-only log) · moving kitchens means editing one file · everything is written for a stranger (human and AI are the same reader) · boxes snap together, and the bigger thing is still a box. These are not tips — they are *derived*, like geometry, from seven axioms.

**The three documents**: the *trailer* → the *constitution* → the *daily checklist* — read them in that order (see "Read first" above).

**Fastest path**: read the trailer ([techne-agora.md](techne-agora.md)); if persuaded, read the constitution once ([techne-arche.md](techne-arche.md)); then hand the checklist ([techne-daemon.md](techne-daemon.md)) to your agent and start building.

---

## Quick Start

Techne's complete workflow is a **four-step closed loop**, derived directly from the axiomatic system (A7·SOP-0·T9·C17·C22):

1. **Trigger** (first time): `/techne-arche` → Agent reads the canon, builds the system; then describe your project in natural language;
2. **Loop** (every round): `/techne-daemon` → Agent reads the daemon, works per canon; continue the conversation with natural-language prompts
3. **Audit** (close, form): `/techne-dokimasia` → eight-lens parallel audit (t7/c11/a7/c8/t9/rg/c20/c21) — form verification (C20); zero violation required for delivery; if not satisfied, fix findings and re-run step 3; if delivery is still open, restart from step 2.
4. **Epikrisis** (close, content): `/techne-epikrisis` → r20 sub-agent single-task — factual completeness + factuality verification (C22); zero violation required for delivery.

> **Axiomatic derivation**: A7 (legibility) requires first-time self-sufficiency → `/techne-arche` establishes the full cognitive framework on first contact; A5 (state/trace) requires history to be append-only → `/techne-daemon` as resident projection preserves context across rounds; T9 (audit three paths) requires three independent verification paths → `/techne-dokimasia` eight-lens parallel audit; C17 (audit gate obligation) requires pre-delivery audit; C22 (factual review obligation) requires post-form-audit content verification → workflow closes with audit+review.

### First deployment

```bash
git clone https://github.com/wuliRothschild/Techne
cd Techne
# Required: inject env before deploy (installers have no home-dir defaults)
export AUDIT_COMMANDS_DIR="${HOME}/.claude/commands"
export TECHNE_SKILLS_DIR="${HOME}/.claude/skills"
bash script/utils/install_audit.sh
bash script/utils/install_epikrisis.sh
ls "${AUDIT_COMMANDS_DIR}"
ls "${TECHNE_SKILLS_DIR}/techne-dokimasia/"
ls "${TECHNE_SKILLS_DIR}/techne-epikrisis/"
```

### Manual deployment fallback

If `bash script/utils/install_audit.sh` is unavailable or fails (missing git, bash, or write permission), deploy by hand (paths via env; defaults shown):

1. `cp techne-arche.md "${AUDIT_COMMANDS_DIR:-$HOME/.claude/commands}/"`
2. `cp techne-daemon.md "${AUDIT_COMMANDS_DIR:-$HOME/.claude/commands}/"`
3. `cp -r script/utils/techne-dokimasia/ "${TECHNE_SKILLS_DIR:-$HOME/.claude/skills}/techne-dokimasia/"`
4. `cp -r script/utils/techne-epikrisis/ "${TECHNE_SKILLS_DIR:-$HOME/.claude/skills}/techne-epikrisis/"`
5. Verify dokimasia: `SKILL.md` + `references/` (8 lenses + `techne-arche.md`) + `scripts/`
6. Verify epikrisis: `SKILL.md` + `references/lens-r20.md` + `scripts/epikrisis_orchestrator.sh`
7. Parity-check lens files against the repository sources

| Symptom | Check | Fix |
|---|---|---|
| Skill loads but no lenses | skills dir `references/` | re-run step 3 |
| Audit returns zero findings | confirm `references/techne-arche.md` exists | copy the file manually |
| Skill fails to load | write permission on skills dir | fix write permission |
| `purity_scan` false PASS | `config/run_config.sh` `CANON_FILE` → `techne-arche.md` | fix the default |

---

## 1. Origin, Purpose, First Principles

techne-demiurge (δημιουργός, the demiurge who fashions the cosmos from eternal forms) is the meta-project of the Agent Project Architecture Philosophy:

- **`techne-arche.md`** — 太初 (ἀρχή: first principle / origin / rule) — the full canon: seven axioms (A1–A7) → twelve theorems (T1–T12) → twenty-two corollaries (C1–C22) → construction canon (ten types) → SOP (SOP-0..5, SOP-7..9) → genealogy → examples → appendices (reduction · glossary · self-reference).
- **`techne-daemon.md`** — 守护灵 (δαίμων: guardian spirit / resident process) — the canon's operative projection: a resident prompt read in full every round of a session.

**First principle**: a project is a system of information plus derivation; its entire value lies in being losslessly taken over and composed by unknown future agents (human or AI). This meta-project satisfies that principle first — your seamless reading right now is the proof.

## 2. Genealogy (Birth Certificate)

Parent techne: none — a **source-born project**: the canon is, in principle, its own origin (ἀρχή · 太初). Composition: not applicable. Canon followed: self-referential — this is the canon's own meta-project, following the current state of `techne-arche.md`; version baseline in the `HANDOFF.md` snapshot.

## 3. Repository Layout

The tree instantiates the canon's ten types (§5.2 of the canon). The root carries exactly three kinds: type carriers (`README.md` and its language variants, `HANDOFF.md`), the deliverable techne (`techne-arche/daemon/agora` — the system's public interface, addressed by the delegation sentence), and institutional files (`LICENSE`, `NOTICE`, `.gitignore`); nothing else may live at root.

```
techne-demiurge/                  (= repository root)
├── README.md                    This file (English edition)
├── README.zh-CN.md              Chinese usage document
├── HANDOFF.md                   Development trace (state snapshot + reverse-chron log)
├── techne-arche.md               Main deliverable: the canon (太初 / first principle)
├── techne-daemon.md              Deliverable: resident prompt, the projection (守护灵 / guardian)
├── techne-agora.md               Introduction & why-beyond-skills essay (English edition)
├── techne-agora.zh-CN.md         Introduction essay (Chinese edition)
├── config/                      run_config.sh (single machine point) + default.sh (variant)
├── source/                      Immutable sources (empty instance; its history in git)
├── data/ref  data/pipeline  data/unformatted  output  panel  figure   Empty stages (trivial instances)
├── document/
│   ├── research/                Background research (irreducible)
│   ├── reports/                 Findings reports
│   ├── methodology/             Methodology (single terminal md + section anchors)
│   ├── metadata/                Sample/object metadata (empty instance)
│   ├── dataset/                 Dataset registry (empty instance)
│   └── parameters/              Parameter docs (empty instance)
├── script/utils/
│   ├── purity_scan.sh · verify_checksums.sh (maintenance)
│   ├── install_audit.sh             deploys dokimasia (form audit) to runtime
│   ├── install_epikrisis.sh          deploys epikrisis (fact review) to runtime
│   ├── techne-dokimasia/            form audit gate (dokimasia)
│   │   ├── SKILL.md + references/lens-{t7,c11,a7,c8,t9,rg,c20,c21}.md
│   │   └── scripts/{scan_derived_docs,audit_orchestrator}.sh
│   └── techne-epikrisis/            fact review gate (epikrisis)
│       ├── SKILL.md + references/lens-r20.md
│       └── scripts/epikrisis_orchestrator.sh
└── .git/                        Trace (append-only)
```

## 4. Usage

### 4.1 Standard Workflow (Four-Step Closed Loop)

The workflow is the four-step loop of "Quick Start" above, applicable to any techne project (including this meta-project). Detailed steps and axiomatic basis per row:

| Step | Action | Trigger | Axiomatic basis |
|---|---|---|---|
| 1. Trigger | Agent reads canon, builds system; then describe your project | `/techne-arche` slash command + natural language | A7 (legibility): first-time reader must be self-sufficient |
| 2. Loop | Agent reads daemon, works per canon; continue with natural-language prompts | `/techne-daemon` slash command per round | A5 (state/trace): history append-only, resident projection preserves context; A2·A3·A4 (construction·determinism·type): deterministic derivation, each in its place |
| 3. Audit (form) | Eight-lens parallel audit (t7/c11/a7/c8/t9/rg/c20/c21) — form verification (C20); zero violation for delivery | `/techne-dokimasia` skill | T9 (audit three paths) · C17 (audit gate obligation) |
| 4. Epikrisis (content) | r20 single sub-agent — factual completeness + factuality (C22); zero violation for delivery | `/techne-epikrisis` skill (single-task; not parallel with ③) | C22 (factual review obligation) · A7 · T3 |

**User sovereignty on order**: The user decides whether ③ → ④ or ④ → ③; recommend audit first (form-then-content), but counter-style review order is acceptable. Delivery requires both gates zero violation.

**User sovereignty**: The audit gate does **not** auto-trigger. The main agent proactively reminds the user to invoke `/techne-dokimasia` after building; the user decides whether to audit, when to audit, and whether to accept the result. Audit protocol (gate rounds, escalation rule, deterministic judgment) lives in one place: [`script/utils/techne-dokimasia/SKILL.md`](script/utils/techne-dokimasia/SKILL.md).

### 4.2 Downstream Use (most Agents/sessions)

- **First contact**: read `techne-arche.md` once, in full, to build the system.
- **Resident**: load `techne-daemon.md` as the resident prompt, read every round.
- **Layered reading protocol**: resident = §0 + §5 + §5.5 of the canon; pull SOPs per task; trace theorems/axioms when asking why; full re-read only on first contact, canon version change, or meta-work on the canon itself.

### 4.3 Maintaining This Meta-Project

Read `HANDOFF.md` snapshot → amend canon per `document/methodology/methodology.md` §2 → regenerate daemon per §3 → run `bash script/utils/install_audit.sh` and `bash script/utils/install_epikrisis.sh` (deploy form + fact gates) → run `script/utils/purity_scan.sh` (and `verify_checksums.sh` when sources exist) → **main agent proactively reminds the user to invoke `/techne-dokimasia` (form) and `/techne-epikrisis` (fact)** (not auto-triggered; user sovereignty; both gates zero violation for delivery) → user verification → git push (manual).

This project's iterations follow the **C19 fundamental reconstruction obligation** (see [techne-arche.md C19](techne-arche.md) / appendix C amendment procedure): any fix or improvement must be examined from the axiomatic source; if derivable from existing rules, no new clause is added; patch-on-patch is prohibited. Reports follow **C20 evidence attachment**: every claim/conclusion must hang output/panel and/or DOI.

### 4.4 Advanced: Custom Resident Projection

The default `techne-daemon.md` is the **general** operative projection of the canon: critical reduction, minimal reconstruction, and the pre-delivery audit reminder already live in it (daemon §九). Calling `/techne-daemon` each round is enough — no separate prompt block is needed in the README.

When a domain needs a tighter resident constraint (emphasizing certain SOPs, domain naming, or entry habits), you may ask the Agent to help draft a **task-scoped** resident projection **under the canon's authority**. It must:
- introduce **no** rules outside the canon (C11: a projection is never a second source of truth);
- only compress or highlight the operative surface relevant to the task; arguments still point back via A／T／C／SOP numbers;
- be **regenerated** or realigned per methodology §3 whenever the canon changes; conflicts resolve to `techne-arche.md`;
- keep the same upgrade clauses as the standard daemon (first contact, canon version change, rule disputes, meta-work on the canon → return to the full text).

A custom projection may live as a "resident" section in the target project's single methodology body, or as a session-level add-on read; it must **not** replace this repository's published `techne-daemon.md` as a second cross-project authority.

## 5. Reproduction

Verify state purity (A5·C5): `bash script/utils/purity_scan.sh`. Verify source immutability when sources exist (A1): `bash script/utils/verify_checksums.sh` (`source/` is currently an empty instance). Re-derive the canon (logical replay of T3): pick any rule and trace its derivation chain ([A→T→C→§]) back to the axioms; Appendix A reduces every candidate "axiom" to a theorem. Regenerate the projection per `document/methodology/methodology.md` and diff against `techne-daemon.md`.

## 6. Deliverables

| Deliverable | Type | Downstream use |
|---|---|---|
| `techne-arche.md` | Canon (work) | Architecture constitution for all projects; cited, internalized (`document/research/`), or extended |
| `techne-daemon.md` | Projection (derivative) | Resident prompt per session; never amended apart from the canon |
| `document/research/` | Research (works) | Rationale for every rule; required reading before amending the canon |

## 7. Dependencies & Migration

No external runtime dependencies (closure, T5); the only tool dependencies are POSIX basics (`md5sum`, `grep`), declared in `config/run_config.sh`. Migration: copy the directory; on a new machine only the tool paths in `config/run_config.sh` need checking. Prohibitions: never write revision traces, version words, or external-document references into `techne-arche.md` (A5); never amend `techne-daemon.md` without syncing the canon (C11); never rewrite git history — the trace is append-only (A5).

## 8. License & Attribution

Everything in this repository (the canon, daemon, agora, `document/**`, scripts, README, HANDOFF) is under **CC BY 4.0** (see `LICENSE`). You may use, adapt, and redistribute anything here, commercially or not — but you **must give attribution**: state "Techne by wuliRothschild", link to this repository, mark your changes, and retain `NOTICE`. The name "Techne" and the techne-* naming family are not licensed as trademarks. Techne was originated and first published by wuliRothschild on 2026-07-21.

---

> ἀρχή (太初, principle) · δαίμων (守护灵, guardian) · δημιουργός (maker) · ἀγορά (square) — every work obeys one form, every session starts from one reading, every end is the beginning of the next work.
