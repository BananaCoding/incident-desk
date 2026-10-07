---
name: db-migrate-safe
description: Write safe, reversible Rails migrations for the SQLite database. Use whenever creating or changing tables, columns, indexes or constraints.
---

# Safe migrations

- Generate with `bin/rails g migration ...`; one concern per migration.
- Must be reversible: use `change` with reversible operations, or `up`/`down`.
- Add constraints in the database too: `null: false`, defaults, foreign keys (`foreign_key: true`), unique indexes (e.g. `users.email`).
- Add indexes for foreign keys and for columns used in filters or sorting.
- Enums: store as integer or string with a default (new ticket status is `open`) and validate in the model.
- Changing existing data: separate the schema change from the data backfill; keep the backfill idempotent. Never edit a migration that has already been merged; add a new one.
- SQLite limits: some `ALTER TABLE` operations rebuild the table; keep changes simple and test on a copy of the data.
- Verify: `bin/rails db:migrate`, `bin/rails db:rollback`, `bin/rails db:migrate` again; commit the updated `db/schema.rb`.
- Never run destructive commands (`db:drop`, `db:reset`) against anything but the local development or test database, and confirm before doing so.
