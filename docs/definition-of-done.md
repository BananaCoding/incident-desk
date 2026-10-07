# Definition of Done

A user story is **Done** only when every applicable item below is met.

---

## 1. Functionality

* All acceptance criteria in the user story (`docs/user-stories.md`) are met.
* Behavior matches the requirements (`docs/requirements.md`) and nothing listed as out of scope was added.
* The UI follows the matching mockup in `docs/design/`.
* Live updates (ticket status, comments) appear without a full-page reload, and work in two browser sessions at once.
* Empty, error and invalid-input states are handled with clear messages (e.g. "Invalid email or password").

## 2. Access Control

* Unauthenticated users are redirected to the sign-in page.
* Customers can only view or edit their own tickets; direct URL access to another customer's ticket is denied.
* Agents can view, assign and update any ticket.
* Live broadcasts (Turbo Streams / Action Cable) only reach users allowed to see that ticket.

## 3. Code Quality

* Code is reviewed and approved through a pull request.
* `bin/rubocop` passes with no offenses.
* No dead code, commented-out code or leftover debug statements.
* Database changes are made through reversible migrations, and `db/schema.rb` is up to date.
* Data integrity is enforced in both models (validations) and the database (null constraints, foreign keys, indexes).

## 4. Testing

* New behavior has automated tests (model, controller/integration and, for live-update flows, system tests).
* `bin/rails test` passes locally and in CI.
* Background jobs (e.g. Overdue flagging after 15 minutes) are tested, including the boundary cases: severity, assignee present, status not Open.
* Status changes are tested to confirm an audit event is recorded.

## 5. Security

* `bin/brakeman` reports no new warnings.
* `bin/bundler-audit` reports no known vulnerable gems.
* Passwords are stored hashed (`has_secure_password`); no secrets, credentials or tokens are committed. Use Rails credentials or environment variables.
* Strong parameters are used for all user input; output is escaped.

## 6. Operations

* The app boots and `/up` returns 200.
* `bin/setup` and `bin/dev` work on a fresh checkout.
* Seed data (`db/seeds.rb`) includes at least one customer and one agent for demos.
* Background jobs run via Solid Queue and failures are logged.

## 7. Documentation

* `README.md` explains setup, how to run the app and tests, and the demo accounts.
* New decisions or changes to scope are reflected in `docs/`.

## 8. Delivery

* The branch is merged to `main` with CI green.
* Commits use clear messages (e.g. `feat:`, `fix:`, `chore:`).
* The feature has been demoed and accepted by the product owner.
