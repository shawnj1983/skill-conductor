#!/usr/bin/env bash
# List agent skills the conductor can route to.
# Usage: inventory.sh [--builtins]
set -euo pipefail

include_builtins=0
if [[ "${1:-}" == "--builtins" ]]; then
  include_builtins=1
fi

emit() {
  local skill_md="$1"
  local dir name desc
  dir="$(dirname "$skill_md")"
  name="$(basename "$dir")"
  desc="$(
    awk '
      BEGIN { in_yaml=0 }
      /^---[[:space:]]*$/ { in_yaml++; next }
      in_yaml==1 && $0 ~ /^description:[[:space:]]*>-/ { getline; sub(/^[[:space:]]+/, ""); print; exit }
      in_yaml==1 && $0 ~ /^description:[[:space:]]+/ {
        sub(/^description:[[:space:]]+/, "")
        gsub(/^["'\'']|["'\'']$/, "")
        print
        exit
      }
    ' "$skill_md" 2>/dev/null || true
  )"
  if [[ -z "$desc" ]]; then
    desc="(no description)"
  fi
  printf '%s\t%s\n' "$name" "$desc"
}

scan_dir() {
  local root="$1"
  [[ -d "$root" ]] || return 0
  local f
  # One SKILL.md per skill folder; skip nested copies.
  find "$root" -mindepth 2 -maxdepth 3 -type f -name SKILL.md 2>/dev/null | sort | while read -r f; do
    emit "$f"
  done
}

echo "# skill-conductor inventory"
echo "# name<TAB>description"

if [[ -f "${HOME}/.cursor/skills/INDEX.md" ]]; then
  echo "# index: ${HOME}/.cursor/skills/INDEX.md"
fi

scan_dir "${HOME}/.cursor/skills"

if [[ -d "${PWD}/.cursor/skills" ]]; then
  echo "# project: ${PWD}/.cursor/skills"
  scan_dir "${PWD}/.cursor/skills"
fi

if [[ "$include_builtins" -eq 1 ]]; then
  echo "# builtins: ${HOME}/.cursor/skills-cursor"
  scan_dir "${HOME}/.cursor/skills-cursor"
fi
