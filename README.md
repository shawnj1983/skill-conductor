# Skill Conductor

**The agent decides which skill to use. It uses that skill fully. Then it checks its work.**

A **skill** and a **rule** that live together. The rule is always on. The skill is the procedure. Ship both or ship neither.

Most skill packs teach the model *how* to do a job. This pair teaches the model *which* job to pick — and refuses to call the work done until it has looked again.

```
           +--------------+
  task --->|  inventory   |
           +------+-------+
                  |
                  v
           +--------------+
           |    route     |  one primary + supporting
           +------+-------+
                  |
                  v
           +--------------+
           |  load fully  |  read SKILL.md, finish the list
           +------+-------+
                  |
                  v
           +--------------+
           |  do the work |
           +------+-------+
                  |
                  v
           +--------------+
           | second pass  |  missed skill? half-used?
           +------+-------+
                  |
          yes ----+---- no
           |             |
           v             v
     load the miss     done
     then stop
```

## Why a pair

| Piece | What it is | If you omit it |
|-------|------------|----------------|
| **Rule** `.cursor/rules/skill-conductor.mdc` | Standing order. `alwaysApply: true`. | The agent only routes when someone remembers to ask. |
| **Skill** `skills/skill-conductor/SKILL.md` | Inventory → route → load → second pass. | The rule is a slogan with no method. |

Cursor skills are opt-in by description. Cursor rules can be always on. The conductor uses that split on purpose.

## Potential, not volume

“Use every skill to its potential” means:

- The **catalog is yours.** You know what is installed.
- If a skill **applies**, you load it and finish it.
- After the work, you ask whether a matching skill was skipped.

It does **not** mean running every skill on every prompt. That wastes the window and is the opposite of potential.

## Install

From this repo:

```bash
./scripts/install.sh
```

That symlinks the skill into `~/.cursor/skills/skill-conductor` and the rule into `~/.cursor/rules/skill-conductor.mdc`. Edit the repo; the links follow.

**Project install** (this folder is a workspace): the rule in `.cursor/rules/` already applies. Copy or add the skill under `.cursor/skills/` if you want it project-scoped too.

**Other agents** (after this repo is on GitHub):

```bash
npx skills@latest add <your-github>/skill-conductor
```

Then copy `.cursor/rules/skill-conductor.mdc` into the project or user rules. The `npx` path copies skills; it does not always copy Cursor rules. The pair still matters.

### See what the agent can route to

```bash
./scripts/inventory.sh
./scripts/inventory.sh --builtins
```

## Files

```
skill-conductor/
├── .cursor/rules/skill-conductor.mdc   # the rule (always on)
├── skills/skill-conductor/
│   ├── SKILL.md                        # the loop
│   ├── reference.md                    # catalog mechanics
│   └── examples.md                     # routing cards
└── scripts/
    ├── install.sh
    └── inventory.sh
```

## What this is not

- Not a replacement for your other skills
- Not Matt Pocock’s pack (that pack is the library; this is the librarian)
- Not a promise that the model will recite forty names every turn

## License

MIT. Copyright (c) 2026 Patrick Johnston.
