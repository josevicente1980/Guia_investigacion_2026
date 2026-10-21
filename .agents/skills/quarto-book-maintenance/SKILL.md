---
name: quarto-book-maintenance
description: Maintain the Quarto book structure and render configuration safely.
---

Workflow:

1. Apply `git-safe-change`.
2. Read `.agent/memory/CHECKPOINT_ACTUAL.md`.
3. Review `_quarto.yml` before any structural edit.
4. Change only what the task requires.
5. Preserve chapter order, 29 numbered chapters, and 8 visible unnumbered parts.
6. Do not reintroduce chapters 15, 17, 18, 21, 23, or 27 as independent book chapters.
7. Do not renumber physical filenames for appearance or modify unrelated chapters.
8. Run `git diff --check`.
9. Render only when needed and authorized by task scope.
10. Provide a concise handoff with Git status and verification.
