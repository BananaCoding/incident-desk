---
name: ror-security
description: Security review and hardening for Incident Desk (authentication, authorization, input handling, secrets, broadcasts, dependencies). Use before finishing a feature or when asked about security.
---

# Security checklist

1. Run `bin/brakeman` and `bin/bundler-audit`; fix or explain every warning.
2. Authentication: `has_secure_password`; generic error "Invalid email or password"; reset the session on sign-in; sign-out works.
3. Authorization: every controller action scopes records by role. Customers use `current_user.tickets`, never `Ticket.find(params[:id])`. Add a test for access to another customer's ticket.
4. Input: strong parameters; whitelist `severity` and `status` values; never trust role or `assignee_id` from a customer.
5. Output: rely on ERB escaping; do not use `html_safe` or `raw` on user content; render Markdown through a sanitizer.
6. Live updates: Turbo Stream and Action Cable channels must authorize the subscriber for that ticket.
7. Secrets: never hardcode credentials or tokens. Use Rails credentials or environment variables. If a secret is found in code or history, warn the user immediately; they must purge the history and rotate the credential.
8. Data: no real customer or employee data in seeds, fixtures, logs or tests; filter sensitive params in logs.
9. Report findings with severity and a concrete fix.
