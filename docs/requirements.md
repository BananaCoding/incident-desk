# Support Ticket & Incident Tracker — Requirements

---

## 1. Project Overview

A web app where customers submit support incidents and support agents resolve them. All updates happen in real time on the screen without full-page reloads.

---

## 2. User Roles

* **Customer:** Creates tickets, views their own tickets, and reads/adds comments.
* **Agent:** Views all tickets, changes ticket status, assigns tickets, and posts replies.

---

## 3. Functional Requirements

### 3.1 Authentication & Access

* Users can sign in using an email address and password.
* Customers can only edit or view their own submitted tickets.
* Agents can view, assign, and update any ticket in the system.

### 3.2 Ticket Management

* Every ticket has:
* **Title** (short summary)
* **Description** (detailed explanation)
* **Severity** (`Low`, `Medium`, `High`, `Urgent`)
* **Status** (`Open`, `In Progress`, `Resolved`)
* **Creator** (Customer)
* **Assignee** (Agent, optional)


* Tickets default to `Open` status on creation.

### 3.3 Live Interaction

* When an agent changes a ticket status, the change appears instantly on the customer's screen.
* When either user adds a comment, it appears immediately in the conversation thread without a page refresh.

### 3.4 Automated Background Processing

* If a ticket with `High` or `Urgent` severity stays `Open` for more than 15 minutes without an assignee, a background job automatically flags it as "Overdue" and sends a notification log.

### 3.5 Event Tracking

* Every change to a ticket's status triggers an internal system event for audit logging.

---

## 4. Explicitly Out of Scope

* Password reset emails via external SMTP.
* File and screenshot attachments.
* Complex permission matrix (only simple `customer` vs `agent`).
* Rich-text WYSIWYG editors (plain text or basic Markdown only).

---
