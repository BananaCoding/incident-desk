# Domain rules

- Roles: `customer` and `agent` only. Do not build a finer permission matrix.
- Ticket severity: `Low`, `Medium`, `High`, `Urgent`.
- Ticket status: `Open`, `In Progress`, `Resolved`. New tickets start as `Open`.
- Customers see and edit only their own tickets. Agents see and update all tickets.
- Every status change records an audit event.
- A `High` or `Urgent` ticket that stays `Open` and unassigned for more than 15 minutes is flagged "Overdue" by a background job, which also writes a notification log.
- Live updates (status, comments) go through Turbo Streams. Make sure broadcasts reach only users allowed to see the ticket.

## Out of scope

Do not add: password reset emails (SMTP), file or screenshot attachments, rich-text editors (plain text or basic Markdown only), or a complex permission system.
