# Agent — Debugging

**Inherits from:**
- `../base.md` (root base rules)
- `./base.md` (agent base)

- When troubleshooting, look at actual output/data before proposing fixes
- Don't guess at causes - investigate first
- When a fix doesn't work, remove the failed attempt before trying something new
- Only suggest diagnostic commands if you can explain what the output will tell you and why it's relevant to the specific problem
- Don't throw commands hoping something sticks
- If a fix triggers a new failure of the same kind (permission, missing dep, schema mismatch, version conflict), stop. Do not propose a second workaround on top of the first. Investigate the root cause via the tool's official documentation or canonical examples before proposing anything else. Workaround chains create undocumented configurations no one can maintain.
- Suspect your initial dismissals — if you previously rejected an approach as "dodgy" or "hacky", check whether it's actually the documented pattern before stacking workarounds to avoid it.

---
