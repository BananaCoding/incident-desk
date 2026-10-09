# Pull Request Guidelines (AI-Driven Workflow)

In this project the AI does the implementation and a human reviews the finished result. That makes the human review the **only** quality gate, so the process is built to make that one review fast, reliable, and hard to rubber-stamp.

## Principles
1. **The reviewer owns what ships.** "The AI wrote it" is never an excuse.
2. **Define done before the AI starts**, not after. You can only verify against criteria that exist.
3. **Machines check first, humans check last.** The human's time goes to intent, design, and risk, not to catching what CI can catch.
4. **Small PRs.** A reviewer who sees one huge diff at the end will skim it. Don't let that happen.

## 1. Before the AI starts: write the task
Every AI task needs a written brief, saved in the issue or PR description:
- **Goal**: what and why, in 1–3 sentences.
- **Acceptance criteria**: a checklist of observable behaviors ("returns 404 for unknown id"), not "works well".
- **Out of scope**: what the AI must not touch.
- **Constraints**: files/modules allowed, libraries allowed, style to follow.
- **Risk level**: Low / Medium / High (see section 5).

For anything beyond a trivial change, have the AI produce a **plan first** (files to change, approach, risks) and approve it before it writes code. Catching a wrong approach at plan stage is far cheaper than at final review.

## 2. Task size: slice the work
- One purpose per PR, target under ~400 changed lines.
- Split large features into a sequence of small tasks, each with its own PR. Review each as it lands rather than once at the very end.
- Refactors and behavior changes go in separate PRs.
- If the AI produces a diff larger than the limit, **send it back to be split**, don't review it as-is.

## 3. Automated gates (must pass before human review)
The PR is not ready for a human until all of these are green:
- Build, lint, formatter, type check
- Full test suite, with new or changed behavior covered
- Secret scanning (e.g. gitleaks)
- Dependency check for new or changed packages
- Security scan (SAST) on changed code

A red CI means the AI keeps working; the reviewer is not pulled in.

## 4. Writing the PR description
The PR must be easy for a human to read. The AI fills in the template (Summary, What Changed, Why, Test Plan, Risks / Notes) in plain language:
- **Summary**: one or two sentences, no jargon.
- **What Changed**: behavior-level bullets, not a file-by-file dump.
- **Why**: the problem being solved, tied to the brief.
- **Test Plan**: steps and expected results a reviewer can run, covering each acceptance criterion.
- **Risks / Notes**: what could break, rollback, what the AI is unsure about or did not do, deviations from the brief, new dependencies/config/permissions, and the tool/model used.

Reviewers treat the description as a claim to verify, not as proof. Never accept "all tests pass" without CI confirming it.

### Rules for the AI when creating a PR
1. Use the PR template.
2. Keep the PR focused on one logical change.
3. Explain the problem before describing the implementation.
4. List all significant code changes.
5. Report tests that were actually run.
6. Do not claim tests passed if they were not executed.
7. Do not claim manual testing if it was not performed.
8. Screenshots are optional.
9. If screenshots cannot be captured, omit the screenshot section.
10. Mention any known limitations, risks, or follow-up work.

## 5. Human review: what to check
Because you review only at the end, use this order:

1. **Intent**: does the diff do what the brief asked, and nothing else? Look for scope creep and unrelated edits.
2. **Acceptance criteria**: verify each one yourself (run it, or read the test that proves it).
3. **Tests are meaningful**: would each test fail if the logic were broken? AI tests often just mirror the implementation. Spot-check by breaking the code.
4. **Hallucinations**: imports, functions, config keys, and packages that don't exist or aren't what they seem.
5. **Security and data**: input validation, auth, injection, unsafe deserialization, logging of sensitive data.
6. **Deletions and weakened checks**: removed tests, loosened assertions, disabled lint rules, `skip`/`ignore` markers, broadened permissions. These are the most common way AI "makes tests pass".
7. **Maintainability**: could you explain this code to a teammate? If not, request changes.

### Review depth by risk
| Risk | Examples | Review |
|------|----------|--------|
| Low | docs, copy, tests, small isolated fix | Skim diff + CI green |
| Medium | new feature, business logic, API changes | Full read + run it locally |
| High | auth, payments, data migrations, infra, permissions, anything touching customer/employee/financial data | Full read + run locally + **second human reviewer** |

If you cannot explain a part of the diff, do not approve it. Ask the AI to explain or simplify, and verify the explanation against the code.

## 6. Security and data (mandatory)
- **Never commit secrets**: passwords, API keys, tokens, private keys. Use environment variables or a secrets manager.
- **If a secret is committed**: stop, purge it from git history (a follow-up commit is not enough), and **rotate the credential immediately**. Tell your team lead.
- Do not put internal company, employee, customer, or financial data into prompts, code, tests, or fixtures. Use fake data.
- Give the AI the **least access it needs**: no production credentials, no production database, scoped tokens only.
- Review any change to CI config, dependency manifests, or permissions with extra care.

## 7. Dependencies
- New dependencies need a one-line justification in the PR.
- Verify the package name, publisher, and popularity (watch for typosquats and invented packages).
- Prefer the standard library or an already-installed dependency.

## 8. Merging
- Human approval is required. AI review tools are advisory only and never count as approval.
- Squash-merge with a clear message. Keep the AI co-author trailer for traceability.
- Delete the branch after merge.
- For Medium/High risk, watch the deploy and know the rollback step.

## 9. Reject or send back when
- The brief or acceptance criteria are missing
- The diff is oversized or includes unrelated changes
- CI is red, or tests were removed or weakened to pass
- The self-report is missing, vague, or contradicts the diff
- Secrets or internal data appear anywhere
- The reviewer cannot explain what the code does

## 10. Improve the loop
When you find a bug in review (or after merge), ask: could a better brief, a CI check, or a project instruction file have prevented it? Add that rule to the AI's project instructions (e.g. `CLAUDE.md`) so the same mistake doesn't repeat.
