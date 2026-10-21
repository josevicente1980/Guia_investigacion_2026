---
name: git-safe-change
description: Safe preflight and handoff protocol for every repository modification.
---

Use before any repository change.

Workflow:

1. Run `git status -sb`.
2. Run `git rev-parse HEAD`.
3. Confirm the working-tree state and expected base.
4. Never destroy unrelated changes.
5. Make minimal edits.
6. Run `git diff --check`.
7. Review `git diff --stat`.
8. Review `git status --short`.
9. Do not commit or push without explicit authorization.

Never use destructive `reset`, `restore`, or `checkout` unless explicitly authorized.
