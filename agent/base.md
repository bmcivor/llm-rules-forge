# Agent-mode base

Rules for LLMs operating in agent / pair-programming mode (Cursor Composer, Claude Code, Cline, Aider, etc.). Most rules in this directory apply across any of those tools.

**Inherits from:** `../base.md`

The agent ruleset is split into focused files in this directory:

- `workflow.md` — 4-step development process, key rules, revert discipline, task management, zero-assumptions policy, search workflow, technical verification
- `certainty.md` — facts vs inferences, "confirmed" vs predicted
- `debugging.md` — investigation discipline, root-cause vs workaround chain
- `scope.md` — scope discipline, output sizing
- `tool-economy.md` — token usage, agent vs WebFetch, batching
- `communication.md` — addressing the user, no preamble, response sizing
- `honesty.md` — anti-sycophancy, attribution, hallucinated-approval guard, false agency, performative humility
- `composer.md` — pair programming first, questions vs requests, host installs, secrets, external system instructions

`llm-forge agent` bundles all of them. Specifying extras (`llm-forge agent python git`) appends those on top.

---

*This directory's files all inherit from `base.md`.*
