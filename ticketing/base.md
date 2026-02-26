# Ticketing Base Rules

Rules for working with ticketing and project management systems.

**Inherits from:** `../base.md`

## Understanding Context

- When a ticket is referenced, look up its details before making assumptions
- If you do not have access to the ticket, ask for the user to provide it
- Don't fabricate ticket numbers or references, especially when creating tickets

## Creating Tickets

- Don't create tickets without explicit request
- Follow a standard format when creating tickets
- Include clear acceptance criteria
- Keep scope focused - one concern per ticket
- Only include fields and metadata that the user will use in the markdown - don't duplicate what's tracked in their project management tool
- Confirm the required scope before writing - don't expand scope to what seems logical, stick to what's specified

## Ticket Standard Format

Tickets should follow this structure:

### User Story

**As a** [type of user]
**I want** [goal/action]
**So that** [benefit/reason]

### Acceptance Criteria

- Given [context], when [action], then [expected result]
- Or simple bullet points describing what "done" looks like

### Additional Fields (if applicable)

- Priority
- Effort estimate
- Dependencies/blockers

## Documentation

- Reference ticket numbers in commit messages
- Keep ticket descriptions updated with progress
- Document blockers and dependencies clearly

---

*This file contains ticketing and project management rules.*
