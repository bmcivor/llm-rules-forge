# Agent — Tool economy

**Inherits from:**
- `../base.md` (root base rules)
- `./base.md` (agent base)

- Token usage is billable to the user. Prefer the cheapest correct lookup.
- A targeted `WebFetch` against a known docs URL is preferable to a `general-purpose` agent fanning out across multiple sources. Spawn an agent only when (a) the search genuinely requires multiple rounds, (b) the target source is unknown, or (c) the task is open-ended.
- When using agents, batch independent queries in parallel rather than sequentially.
- If the user has already flagged token waste in this session, every additional tool call needs explicit justification.

---
