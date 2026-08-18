# Skill Conductor — reference

Read this when you need catalog mechanics. Keep `SKILL.md` as the loop.

## Where skills live

| Kind | Path | Notes |
|------|------|-------|
| Personal | `~/.cursor/skills/<name>/SKILL.md` | Cross-project. Canonical for a solo operator. |
| Project | `.cursor/skills/<name>/SKILL.md` | Ships with the repo. |
| Built-in | `~/.cursor/skills-cursor/<name>/SKILL.md` | Cursor-owned. Read, never edit. |
| This pair | `skills/skill-conductor/SKILL.md` | The router. |

An `INDEX.md` next to personal skills is optional and better than scanning fifty files every turn. If it exists, trust it, then spot-check that the folders still match.

## Skill vs rule

| | Skill | Rule |
|--|-------|------|
| Format | Folder + `SKILL.md` | `.mdc` with YAML frontmatter |
| When it loads | Description match, or user names it | `alwaysApply: true` or glob |
| Length | Procedure, examples, scripts | Short standing order |
| This pair | How to route and second-pass | You must route and second-pass |

A rule without a skill is a slogan. A skill without a rule is opt-in. Together they are a system.

## Frontmatter the conductor cares about

```yaml
---
name: kebab-name
description: What it does. Use when the user mentions X, Y, or Z.
---
```

`description` is the routing key. Vague descriptions make the conductor guess. Third person. Include **what** and **when**.

Omit `disable-model-invocation` when the agent should reach for the skill on its own. Set it only for user-typed slash skills.

## Inventory script

From the repo root or anywhere:

```bash
./scripts/inventory.sh
./scripts/inventory.sh --builtins
```

Prints `name<TAB>description` (first description line). The agent may run this instead of hand-listing folders.

## Second-pass rubric

A second pass is **not** a rewrite of the whole answer. It is four yes/no checks. If all no, you are done. If a miss exists, do only the miss.

## What “every skill to its potential” is not

- Not a requirement to mention every skill in the reply
- Not a requirement to load skills whose “when” does not match
- Not permission to stall the user while you read the entire catalog into the window

Inventory from INDEX or the script. Load only the picks. Read those fully.
