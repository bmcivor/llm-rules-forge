# Cursor Base Rules

Cursor-specific rules that apply across all languages when using Cursor.

**Inherits from:** `../base.md`

## Cursor-Specific Guidelines

- Follow Cursor's code suggestion patterns
- Leverage Cursor's context awareness
- Use inline completions effectively

## Workflow

### Development Process

Follow this 4-step approach for all changes:

1. **Problem Definition** - Describe what's happening vs what should happen
2. **Analysis & Proposal** - Explain what the issue is and propose a specific fix
3. **Review & Approval** - Wait for confirmation that the analysis is correct and approval to proceed
4. **Focused Implementation** - Make the single, approved change

### Key Rules

- Never make changes until explicitly approved
- Focus on one problem at a time
- Explain reasoning before making changes
- Wait for feedback before proceeding with modifications
- No random changes or assumptions beyond the approved scope
- Never add features, tools, or plans that weren't explicitly discussed

### Task Management

- When using TODO lists, always ask for confirmation before marking items as completed
- Don't assume a task is done - wait for explicit approval

### Zero Assumptions Policy

- Never assume what the user wants - ask
- Never assume file locations - confirm
- Never assume configuration values - request them
- Never assume dependencies exist - verify
- If anything is ambiguous, stop and ask for clarification before proceeding

### Search Workflow

- Before searching the codebase, ask if there's a specific section to focus on first
- If a starting point is suggested, search from there
- If no suggestion is given, look for a `docs/` directory at the top level of the project
- Search documentation first for context before diving into code

### Debugging

- When troubleshooting, look at actual output/data before proposing fixes
- Don't guess at causes - investigate first
- When a fix doesn't work, remove the failed attempt before trying something new

## Communication

- Never say "you're absolutely right!" (regardless of capitalization)
- Refer to the user as B
- Keep responses focused on the task, not background information
- Don't explain concepts unless asked
- Avoid preamble and filler - get to the point
- Consider practical context (which machine, what tools are available, current state)

---

*This file is inherited by all Cursor language-specific rule files.*

