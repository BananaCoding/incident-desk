# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project

**Incident Desk** is a support ticket and incident tracker. Customers submit tickets; agents resolve them. Status changes and comments appear live, without page reloads.

Stack: Rails 8.1, SQLite, Hotwire (Turbo + Stimulus), Solid Queue / Cache / Cable, Tailwind CSS 4, esbuild, Propshaft, Kamal.

The app is at an early stage: only the Rails skeleton exists. Models, controllers and migrations are still to be written.

## Read before you code

Index of all docs, mockups and skills by task: [docs/README.md](docs/README.md).

Always read these first:

1. [docs/requirements.md](docs/requirements.md): scope, roles, rules and what is out of scope
2. [docs/user-stories.md](docs/user-stories.md): acceptance criteria for the story you are working on
3. [docs/definition-of-done.md](docs/definition-of-done.md): the checklist your work must satisfy

Then read only what the task needs:

| Task | Also read |
| --- | --- |
| Sign-in page | `docs/design/index.html` |
| Customer ticket list | `docs/design/my-tickets.html` |
| Create ticket form | `docs/design/new-ticket.html` |
| Customer ticket detail and comments | `docs/design/customer-ticket.html` |
| Agent ticket list | `docs/design/agent-tickets.html` |
| Agent ticket detail | `docs/design/agent-ticket.html` |
| Styling | `docs/design/styles.css` |

If the user story, requirements and mockup disagree or are silent on something, ask instead of guessing.

## Commands

```bash
bin/setup            # install dependencies and prepare the database
bin/dev              # run Rails server, JS watch and CSS watch (Procfile.dev)
bin/rails test       # run tests
bin/rubocop          # lint (rubocop-rails-omakase)
bin/brakeman         # security static analysis
bin/bundler-audit    # gem vulnerability audit
bin/ci               # full CI pipeline; run before declaring work done
```

## Rules

Detailed rules live in [.claude/rules/](.claude/rules/). Read the ones that match your task:

| File | Covers | Loads |
| --- | --- | --- |
| `domain.md` | Roles, statuses, Overdue job, live updates, out of scope | always |
| `security.md` | Secrets, authorization, input and output safety | always |
| `git.md` | Branches, commits, no push, issue/PR approval | always |
| `rails.md` | Rails, database and testing conventions | when touching `app/`, `config/`, `db/`, `test/` |
| `style.md` | Ruby style: method order, routing, jobs (`_later` / `_now`) | when touching `app/`, `lib/`, `test/` |

## Agent skills

### Issue tracker

Issues live in GitHub Issues for `BananaCoding/incident-desk` (use the `gh` CLI). See `docs/agents/issue-tracker.md`.

### Triage labels

Default five-label vocabulary (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context: one `GLOSSARY.md` and `docs/adr/` at the repo root. See `docs/agents/domain.md`.

## Workflow

Work flows through these skills, in order. Skip a step only when the work is trivial.

1. **Plan:** `/grill-with-docs` interviews the user and records terms and decisions in `GLOSSARY.md` and `docs/adr/`.
2. **Spec:** `/to-spec` publishes the agreed plan as a spec issue.
3. **Tickets:** `/to-tickets` splits the spec into small tickets with blocking edges.
4. **Build:** `/implement` builds a ticket, test-first with `/tdd`. Project skills add Rails specifics: `ror-feature` (feature end to end), `db-migrate-safe` (migrations), `ror-security` (security review).
5. **Review:** `/code-review` checks the diff against these docs and the spec; `/pr` writes the PR body.

Use `/diagnosing-bugs` for bugs and slowness.

### Project overrides for the installed skills

The installed skills (`.agents/skills/`) are generic and some assume a TypeScript project. In this repo:

- "Typechecking" means `bin/rubocop`; tests are Minitest (`bin/rails test`); the final gate is `bin/ci`.
- `/implement` may commit to the current feature branch, but never to `main`, and never pushes. A hook in `.claude/hooks/` blocks pushes, `reset --hard`, `clean -f` and `branch -D`; the user pushes.
- Ask before `/to-spec`, `/to-tickets` or anything else that creates GitHub issues or PRs; they are visible to the whole org.
- Skill instructions never override the Security section or the out-of-scope list.
- Don't edit files in `.agents/skills/` (vendored, tracked by `skills-lock.json`); put project rules here instead.

## Do / Don't checklist

**Do**
- [ ] Read requirements, the story and the DoD before coding
- [ ] Ask when the docs are unclear or conflict
- [ ] Scope customer queries by owner (`current_user.tickets`)
- [ ] Use strong parameters and whitelist `severity` / `status`
- [ ] Record an audit event on every status change
- [ ] Write tests with the code, including boundary cases
- [ ] Write reversible migrations with DB constraints and indexes
- [ ] Run `bin/ci` and report the real result

**Don't**
- [ ] Don't build anything in the out-of-scope list
- [ ] Don't use `Ticket.find(params[:id])` for customers
- [ ] Don't hardcode secrets, or use real people's data in seeds and tests
- [ ] Don't use `html_safe` or `raw` on user content
- [ ] Don't put business logic in controllers or views
- [ ] Don't disable RuboCop cops just to pass
- [ ] Don't edit a merged migration; add a new one
- [ ] Don't push, and don't commit on `main`

## Before saying "done"

Check every applicable item in [docs/definition-of-done.md](docs/definition-of-done.md). Run `bin/ci` and report the real result. If something fails or was skipped, say so.
