#!/usr/bin/env bash
set -euo pipefail

ROOT="/Users/tao/Projects/Working/skills"
SKILL_ROOT="$HOME/.agents/skills"

repos=(
  "superpowers|$ROOT/vendor/superpowers|https://github.com/obra/superpowers.git"
  "planning-with-files|$ROOT/vendor/planning-with-files|https://github.com/OthmanAdi/planning-with-files.git"
  "openai-skills|$ROOT/vendor/openai-skills|https://github.com/openai/skills.git"
)

skills=(
  "using-superpowers|$ROOT/vendor/superpowers/skills/using-superpowers"
  "systematic-debugging|$ROOT/vendor/superpowers/skills/systematic-debugging"
  "verification-before-completion|$ROOT/vendor/superpowers/skills/verification-before-completion"
  "requesting-code-review|$ROOT/vendor/superpowers/skills/requesting-code-review"
  "test-driven-development|$ROOT/vendor/superpowers/skills/test-driven-development"
  "finishing-a-development-branch|$ROOT/vendor/superpowers/skills/finishing-a-development-branch"
  "writing-plans|$ROOT/vendor/superpowers/skills/writing-plans"
  "planning-with-files|$ROOT/vendor/planning-with-files/.codex/skills/planning-with-files"
  "playwright|$ROOT/vendor/openai-skills/skills/.curated/playwright"
)

for entry in "${repos[@]}"; do
  IFS='|' read -r name repo expected_remote <<<"$entry"
  if [[ ! -d "$repo/.git" ]]; then
    printf 'SKIP %s: repository missing: %s\n' "$name" "$repo"
    continue
  fi

  actual_remote="$(git -C "$repo" remote get-url origin 2>/dev/null || true)"
  if [[ "$actual_remote" != "$expected_remote" ]]; then
    printf 'SKIP %s: unexpected origin: %s\n' "$name" "${actual_remote:-<missing>}"
    continue
  fi

  before="$(git -C "$repo" rev-parse HEAD)"
  if [[ -n "$(git -C "$repo" status --porcelain --untracked-files=all)" ]]; then
    printf 'SKIP %s: local changes present (SHA %s)\n' "$name" "$before"
    continue
  fi

  branch="$(git -C "$repo" branch --show-current)"
  if [[ -z "$branch" ]]; then
    printf 'SKIP %s: detached HEAD at %s\n' "$name" "$before"
    continue
  fi

  printf 'UPDATE %s: before=%s branch=%s\n' "$name" "$before" "$branch"
  git -C "$repo" pull --ff-only
  after="$(git -C "$repo" rev-parse HEAD)"
  printf 'UPDATE %s: after=%s\n' "$name" "$after"
done

failed=0
for entry in "${skills[@]}"; do
  IFS='|' read -r name target <<<"$entry"
  link="$SKILL_ROOT/$name"

  if [[ ! -d "$target" || ! -f "$target/SKILL.md" ]]; then
    printf 'FAIL %s: source or SKILL.md missing: %s\n' "$name" "$target"
    failed=1
    continue
  fi
  if [[ ! -L "$link" ]]; then
    printf 'FAIL %s: link missing or not symbolic: %s\n' "$name" "$link"
    failed=1
    continue
  fi

  resolved="$(cd "$(dirname "$link")" && cd "$(dirname "$(readlink "$link")")" 2>/dev/null && pwd -P)/$(basename "$(readlink "$link")")"
  target_resolved="$(cd "$target" && pwd -P)"
  if [[ "$resolved" != "$target_resolved" ]]; then
    printf 'FAIL %s: link target mismatch: %s -> %s\n' "$name" "$link" "$(readlink "$link")"
    failed=1
    continue
  fi
  printf 'OK %s: %s -> %s\n' "$name" "$link" "$target_resolved"
done

if [[ "$failed" -ne 0 ]]; then
  exit 1
fi
