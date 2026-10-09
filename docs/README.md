# Docs Index (for AI agents)

Start here. Find the task in the first table, read only the files listed, and skip the rest.

## 1. What to read for which task

| Task | Read |
| --- | --- |
| Any task (always) | `../AGENTS.md`, `requirements.md`, `definition-of-done.md` |
| Implement a user story | the story in `user-stories.md` + the matching mockup (section 3) |
| Plan or clarify a feature | `requirements.md`, `user-stories.md`, then `/grill-with-docs` |
| Write a spec or tickets | `agents/issue-tracker.md` (ask before publishing to GitHub) |
| Database change | `../.claude/skills/db-migrate-safe/SKILL.md` |
| Security review | `../.claude/skills/ror-security/SKILL.md` |
| Naming a domain concept | `../GLOSSARY.md` (created lazily; may not exist yet) |
| Architecture decision | `adr/` (created lazily; may not exist yet) |
| Finish or review work | `definition-of-done.md`, then `bin/ci` |

## 2. Documents

| File | What it contains |
| --- | --- |
| `../AGENTS.md` | Rules, commands, domain rules, workflow, Do/Don't checklist |
| `../.claude/rules/` | Detailed rules: `domain.md`, `security.md`, `git.md`, `rails.md`, `style.md` (the last two load only when touching code) |
| `requirements.md` | Scope, roles, ticket fields, live updates, Overdue job, out of scope |
| `user-stories.md` | User stories with acceptance criteria (only Story 1, login, so far) |
| `definition-of-done.md` | Checklist a story must meet before it is done |
| `agents/issue-tracker.md` | How skills read and write issues (GitHub, `gh` CLI) |
| `agents/triage-labels.md` | Triage label names |
| `agents/domain.md` | How to read `GLOSSARY.md` and `adr/` |

## 3. UI mockups (`design/`)

Static HTML. Treat them as the visual spec; styling lives in `design/styles.css`.

| Screen | File | Role |
| --- | --- | --- |
| Sign in | `design/index.html` | both |
| New ticket | `design/new-ticket.html` | customer |
| My tickets (list) | `design/my-tickets.html` | customer |
| Ticket detail and comments | `design/customer-ticket.html` | customer |
| All tickets (list) | `design/agent-tickets.html` | agent |
| Ticket detail, status, assign | `design/agent-ticket.html` | agent |

## 4. Skills (`../.claude/skills/`)

Project skills:

| Skill | Use for |
| --- | --- |
| `ror-feature` | Build a story end to end |
| `db-migrate-safe` | Migrations |
| `ror-security` | Security review before finishing |

Workflow skills (vendored in `../.agents/skills/`, do not edit):

| Step | Skill |
| --- | --- |
| Plan | `grill-with-docs` |
| Spec | `to-spec` |
| Tickets | `to-tickets` |
| Build | `implement`, `tdd` |
| Review | `code-review`, `pr` |
| Bugs, slowness | `diagnosing-bugs` |

## 5. Code map (current)

Only the Rails skeleton exists. Update this section as code is added.

| Path | Status |
| --- | --- |
| `app/models`, `app/controllers`, `app/views` | empty (only `ApplicationRecord` and `ApplicationController`) |
| `config/routes.rb` | health check `/up` only |
| `db/` | no schema or migrations yet |
| `test/` | Minitest, no tests yet |
| `bin/ci` | CI pipeline: rubocop, bundler-audit, yarn audit, brakeman, tests, seeds |
