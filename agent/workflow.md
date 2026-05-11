# Agent — Workflow

**Inherits from:**
- `../base.md` (root base rules)
- `./base.md` (agent base)

## Development Process

Follow this 4-step approach for all changes:

1. **Problem Definition** - Describe what's happening vs what should happen
2. **Analysis & Proposal** - Explain what the issue is and propose a specific fix
3. **Review & Approval** - Wait for confirmation that the analysis is correct and approval to proceed
4. **Focused Implementation** - Make the single, approved change

## Key Rules

- Never make changes until explicitly approved
- Focus on one problem at a time
- Explain reasoning before making changes
- Wait for feedback before proceeding with modifications
- No random changes or assumptions beyond the approved scope
- Never add features, tools, or plans that weren't explicitly discussed
- Explicitly state which step of the 4-step process you're on before proceeding
- Do not skip steps 2 and 3 even when you feel confident about the answer
- Before producing any artefact (report, ticket, code), confirm scope and format - a 30-second clarifying question saves the user 10 minutes of correcting output
- When told "no code changes" or placed in a read-only mode, that constraint overrides all other instructions — do not edit files, even to "help"
- Do not interpret follow-up discussion as implicit approval to start implementing
- Do not make changes in a different repository or project than the one being actively worked on without explicit approval — if a fix requires changes in another repo, propose it and wait
- Changes to unrelated systems (CI, infra, other projects) go on their own branch — never mix them into the current work

## Revert Discipline

- If a change was made in error, revert it to the exact original state — verify with a diff, don't eyeball it
- Never chain additional edits on top of a failed revert
- If you can't cleanly revert, stop and tell the user what state the file is in

## Task Management

- When using TODO lists, always ask for confirmation before marking items as completed
- Don't assume a task is done - wait for explicit approval

## Zero Assumptions Policy

- Never assume what the user wants - ask
- Never assume file locations - confirm
- Never assume configuration values - request them
- Never assume dependencies exist — **verify by reading** manifests and lockfiles (`pyproject.toml`, `package.json`, `requirements*.txt`, `Dockerfile`, etc.), repo docs, or the project's stated toolchain — **not** by running installers to "see if it works" (installs require approval per `composer.md` when applicable)
- If anything is ambiguous, stop and ask for clarification before proceeding
- Never fill knowledge gaps with plausible-sounding details - leave gaps empty and flag them
- When you lack context to be useful on a topic, say so explicitly rather than producing low-confidence output
- Never use the user's personal information (name, email, etc.) from system context unless they've explicitly told you to
- Never assume the workspace root is a single project — verify the workspace structure before scoping searches
- When searching for files, use absolute paths scoped to the relevant project directory

## Search Workflow

- If the user already gave a **file path**, **stack trace**, **symbol**, or **repo area**, **do not** ask "where should I search?" — start from that anchor
- If no starting point was given, ask if there's a specific section to focus on first
- If a starting point is suggested, search from there
- If no suggestion is given, look for a `docs/` directory at the top level of the project
- Search documentation first for context before diving into code

## Technical Verification

- Before suggesting any implementation, verify syntax and reserved words for that tool/language
- Check best practices and common gotchas before proposing code
- Don't suggest code you haven't mentally validated

---
