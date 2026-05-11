# llm-rules-forge

Curated, opinionated rule sets for LLM-powered developer tools.

## Overview

This repository contains a collection of rules and guidelines designed to help LLMs write better code across different tools and languages. Rules are organised by concern into focused files that can be selectively bundled for your setup.

## Structure

```
llm-rules-forge/
├── base.md                  # Universal rules for everything below
├── agent/                   # Agent-mode rules (Cursor Composer, Claude Code, Cline, Aider)
│   ├── base.md              # Directory overview
│   ├── workflow.md          # 4-step process, key rules, revert discipline, zero assumptions
│   ├── certainty.md         # Facts vs inferences, "confirmed" reservations
│   ├── debugging.md         # Investigation discipline, workaround chains
│   ├── scope.md             # Scope discipline, output sizing
│   ├── tool-economy.md      # Token usage, agent vs WebFetch, batching
│   ├── communication.md     # Addressing the user, response sizing
│   ├── honesty.md           # Anti-sycophancy, attribution, hallucinated-approval guards
│   └── composer.md          # Pair programming, host installs, secrets, external systems
├── languages/               # Language-specific rules
│   ├── python.md
│   └── javascript.md
├── git/base.md              # Git rules
├── ticketing/base.md        # Ticketing / project management rules
├── ansible/base.md          # Ansible rules
├── code-review/base.md      # Code review rules
├── generate.sh              # Concatenation tool
└── Makefile                 # Installation helpers
```

## Installation

```bash
make install
```

This creates a symlink at `~/.local/bin/llm-forge`. Ensure `~/.local/bin` is in your PATH.

To uninstall:

```bash
make uninstall
```

## Usage

Generate combined rules for your setup:

```bash
llm-forge agent python git ticketing > my-rules.md
```

The first argument is a tool directory. All `.md` files in that directory are included automatically — `base.md` first if present, then the rest alphabetically. Subsequent arguments are extras: language names are looked up in `languages/`, and module names (e.g. `git`, `ticketing`) are looked up as top-level directories.

See available options:

```bash
llm-forge --list
llm-forge --help
```

### Examples

```bash
# Just the agent rules
llm-forge agent

# Agent + Python + Git
llm-forge agent python git

# Agent + JavaScript + Ticketing
llm-forge agent javascript ticketing

# Everything: root base + every tool dir + every language + every module
llm-forge all
```

Copy the output into your LLM tool's user rules configuration (e.g. Cursor Settings → User Rules, or `~/.claude/CLAUDE.md`).

## How it works

Rules are organised by concern rather than by tool:

1. **Root `base.md`** — universal principles
2. **Tool directories** — focused groups of rules for a category of LLM usage. `agent/` is the main one today, covering any agent / pair-programming mode (Cursor Composer, Claude Code, Cline, Aider).
3. **`languages/`** — language-specific rules (Python, JavaScript, …)
4. **Modules** — additional rule sets layered on top (`git/`, `ticketing/`, `ansible/`, `code-review/`)

`llm-forge <tool> [extras...]` concatenates root base → all files in the tool dir → each extra, in that order.

## Contributing

This is an opinionated collection. Contributions are welcome for:

- New language support
- New rule modules
- Improvements to existing rules

## License

Apache 2.0
