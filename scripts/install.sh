#!/usr/bin/env bash
# Install the skill + rule pair so they stay one source of truth.
# Usage: ./scripts/install.sh
set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
skill_src="${root}/skills/skill-conductor"
rule_src="${root}/.cursor/rules/skill-conductor.mdc"

skill_dst="${HOME}/.cursor/skills/skill-conductor"
rule_dst="${HOME}/.cursor/rules/skill-conductor.mdc"

if [[ ! -f "${skill_src}/SKILL.md" ]]; then
  echo "missing ${skill_src}/SKILL.md" >&2
  exit 1
fi
if [[ ! -f "$rule_src" ]]; then
  echo "missing ${rule_src}" >&2
  exit 1
fi

mkdir -p "${HOME}/.cursor/skills" "${HOME}/.cursor/rules"

ln -sfn "$skill_src" "$skill_dst"
ln -sfn "$rule_src" "$rule_dst"

echo "linked skill → ${skill_dst}"
echo "linked rule  → ${rule_dst}"
echo "pair lives in ${root} — edit there, not the copies."
