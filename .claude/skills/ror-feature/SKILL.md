---
name: ror-feature
description: Implement a user story end to end in Incident Desk (migration, model, controller, views, Turbo, tests). Use when asked to build or add a feature or story.
---

# Implement a feature

1. Read `docs/requirements.md`, the matching story in `docs/user-stories.md`, `docs/definition-of-done.md`, and the related mockup in `docs/design/`. Ask if they conflict or are silent.
2. Restate the acceptance criteria as a short checklist before coding.
3. Build in this order, keeping each step small:
   - Migration (see `db-migrate-safe`) and model with validations, enums and associations
   - Routes using RESTful resources
   - Thin controller with strong parameters and role-based scoping (customers only reach their own tickets)
   - Views from the mockup using Tailwind; use Turbo Frames/Streams for live updates
   - Tests with Minitest (model, controller/integration, job boundary cases, audit event on status change)
4. Put multi-step business logic in a service object under `app/services`, not the controller.
5. Run `bin/rubocop` and `bin/rails test`, then check the Definition of Done. Report real results.

Stay inside scope: no SMTP password reset, attachments, rich-text editors, or complex permissions.
