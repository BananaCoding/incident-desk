# Git rules

- Work on a feature branch, never directly on `main`.
- Use clear commit messages with prefixes such as `feat:`, `fix:`, `chore:`, `docs:`.
- Commit only when the user asks, or when running `/implement` on a feature branch. Never push; the user does that (a hook in `.claude/hooks/` enforces this).
- Ask before creating GitHub issues or PRs (`/to-spec`, `/to-tickets`); they are visible to the whole org.
