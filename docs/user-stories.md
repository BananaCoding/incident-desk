# User Stories

---

### Story 1: User Login

> **As a** user (customer or agent),
> **I want to** sign in with my email and password,
> **So that** I can access my tickets securely.

**Acceptance Criteria:**

* User enters email and password into a sign-in form.
* System verifies credentials:
* If valid: redirects to the ticket dashboard.
* If invalid: shows an error message "Invalid email or password".


* User can log out at any time from the top navigation bar.

---

### Story 2: Create a Ticket (Customer)

> **As a** customer,
> **I want to** submit a new incident with a title, description, and severity,
> **So that** support agents can investigate my problem.

**Acceptance Criteria:**

* Customer sees a "New Ticket" button on their dashboard.
* Form requires:
* Title (minimum 5 characters)
* Description (minimum 10 characters)
* Severity (dropdown: `Low`, `Medium`, `High`, `Urgent`)


* Submitting redirects the user to the ticket detail page.
* Status defaults to `Open`.

---

### Story 3: View & Filter Tickets (Agent)

> **As an** agent,
> **I want to** view all customer tickets in a central list,
> **So that** I can prioritize and pick up unassigned work.

**Acceptance Criteria:**

* Agent sees a table of all tickets with columns: ID, Title, Customer, Severity, Status, Created At.
* Quick filters allow viewing by status: `All`, `Open`, `In Progress`, `Resolved`.
* High and Urgent tickets are visually highlighted.

---

### Story 4: Update Ticket Status (Agent)

> **As an** agent,
> **I want to** change a ticket's status from `Open` to `In Progress` or `Resolved`,
> **So that** everyone knows the current progress.

**Acceptance Criteria:**

* Agent clicks a status dropdown or action button on the ticket detail page.
* Ticket status updates immediately in the database.
* The customer's open browser tab updates the badge instantly via WebSockets (no refresh needed).
* System records an internal status change event.

---

### Story 5: Ticket Discussion & Comments

> **As a** customer or agent,
> **I want to** post comments on a ticket,
> **So that** we can share updates and troubleshoot together.

**Acceptance Criteria:**

* Ticket detail page has a comment thread under the description.
* Submitting a comment clears the input box.
* New comment appends to the bottom of the conversation thread on all connected screens in real time.

---

### Story 6: Automated Ticket Escalation

> **As a** support lead,
> **I want** urgent unassigned tickets to trigger an escalation job,
> **So that** no critical incident is ignored.

**Acceptance Criteria:**

* Creating a `High` or `Urgent` ticket schedules a background job.
* The job runs in the background using the database queue.
* If still unassigned when the job runs, it updates the ticket with an escalation tag.

---
