#!/bin/bash
# PreToolUse hook: block dangerous git commands.
# Based on mattpocock/skills git-guardrails-claude-code, but works without jq
# (it matches against the raw hook JSON, so it fails closed instead of open).

INPUT=$(cat)

DANGEROUS_PATTERNS=(
  "git push"
  "git reset --hard"
  "git clean -[a-z]*f"
  "git branch -D"
  "git checkout \."
  "git restore \."
  "push --force"
  "reset --hard"
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$INPUT" | grep -qE "$pattern"; then
    echo "BLOCKED: command matches dangerous pattern '$pattern'. The user has prevented you from doing this." >&2
    exit 2
  fi
done

exit 0
