---
name: skill-conductor
description: >-
  Routes the agent to the best skill(s) for the current task, applies each
  one fully, then runs a second pass to catch misses. Use when starting any
  task, when choosing which skill to load, when the user says conductor,
  right skill, use every skill, skill router, or double-check the skills.
---

# Skill Conductor

The agent owns the catalog. Pick the right skill. Use it fully. Then check.

This skill **lives with** the Cursor rule `skill-conductor.mdc`. The rule is the standing order. This file is the procedure. Do not ship one without the other.

## Potential, not volume

Using a skill to its potential means: **if it applies, load its `SKILL.md` and finish its checklist.**

It does **not** mean running every installed skill on every prompt. A typo fix that fires forty skills is a miss, not coverage.

A miss is the opposite: a skill that **should** have run, and did not — or a selected skill that was half-followed.

## Loop (every task)

Copy this and fill it. Keep it short. Do not dump it on the user unless they ask.

```
Task:
Primary:
Supporting:
Skipped (and why):
Second pass:
```

### 1. Inventory

Load the catalog before acting.

Prefer, in this order:

1. `~/.cursor/skills/INDEX.md` if it exists
2. Project `.cursor/skills/**/SKILL.md`
3. `~/.cursor/skills/**/SKILL.md`
4. This repo’s `scripts/inventory.sh`

Read **descriptions**, not only names. Built-ins under `~/.cursor/skills-cursor/` are in play when the task matches (create-skill, create-rule, canvas, …). Never edit `~/.cursor/skills-cursor/`.

### 2. Route

Pick **one primary** skill (the job) and **zero or more supporting** skills (constraints, research, review, close-out).

Match on the user’s words **and** the work you are about to do.

| Situation | Typical primary |
|-----------|-----------------|
| User names a skill | That skill |
| Research / scrape / “learn this” | `learn-from-internet` or the house research skill |
| New skill or rule | `create-skill` / `create-rule` + this conductor |
| Ambiguous build | Grill / align skill first, then implement |
| Tiny, obvious edit | No extra skills — note `Skipped: catalog, one-step edit` |

If two skills overlap, pick the **narrower** one as primary. The broader one may support.

### 3. Load fully

For each selected skill:

1. Read its `SKILL.md` (and one-level references it points at).
2. Follow its steps. Do not paraphrase away a hard “do not”.
3. If it says to ask before a risky action, ask.

Half-reading the description and improvising is a miss.

### 4. Do the work

Stay inside the selected skills. If the work changes shape, **re-route** — do not silently drop the catalog.

### 5. Second pass (required)

Before you declare done, answer all four:

1. **Missed skill?** Is there a catalog entry whose “when” matches this task that you did not load?
2. **Half-used?** Did a selected skill have a step you skipped?
3. **Conflict?** Did two skills disagree? Name the conflict and which one won.
4. **Close-out?** If this chat taught a repeatable workflow and the house has `conversation-to-skill` (or equivalent), record the skill or the deliberate no.

If (1) or (2) is yes, load the miss and do that work. Then stop. One extra pass is enough — do not loop forever.

## Do not

- Do not invent a skill that already exists. Update it.
- Do not install someone else’s entire pack over the house catalog.
- Do not paste secrets into a skill file.
- Do not skip the second pass because the first pass “felt complete”.

## Pair

| Piece | Job |
|-------|-----|
| **Rule** `.cursor/rules/skill-conductor.mdc` | Always on. “Own the catalog. Route. Iterate.” |
| **Skill** this file | How to inventory, pick, load, and second-pass. |
| **`scripts/inventory.sh`** | Print name + description from the skill folders. |

Install both. See the repo README.
