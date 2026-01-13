# llm-rules-forge

Curated, opinionated rule sets for LLM-powered developer tools

## Overview

This repository contains a hierarchical collection of rules and guidelines designed to help LLMs write better code across different tools and languages. Rules are organized by tool (e.g., Cursor) and language (e.g., Python, JavaScript), with inheritance from base configurations.

## Structure

```
llm-rules-forge/
├── base.md                    # Universal rules for all tools and languages
├── cursor/
│   ├── base.md               # Cursor-specific rules (inherits from base.md)
│   ├── python.md             # Cursor + Python rules
│   └── javascript.md         # Cursor + JavaScript rules
├── git/
│   └── base.md               # Git-specific rules
├── ticketing/
│   └── base.md               # Ticketing/project management rules
├── generate.sh               # Tool to concatenate rules
└── Makefile                  # Installation helpers
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
llm-forge cursor python git ticketing > my-rules.md
```

See available options:

```bash
llm-forge --list
llm-forge --help
```

### Examples

```bash
# Cursor + Python + Git rules
llm-forge cursor python git

# Cursor + JavaScript + Ticketing rules
llm-forge cursor javascript ticketing

# Everything
llm-forge cursor python git ticketing
```

Copy the output into your LLM tool's configuration (e.g., Cursor Settings → User Rules).

## How It Works

Rules follow an inheritance chain:

1. **Root `base.md`**: Universal principles that apply everywhere
2. **Tool-specific `base.md`**: Tool-specific guidelines (e.g., `cursor/base.md`)
3. **Language-specific files**: Combined tool + language rules (e.g., `cursor/python.md`)
4. **Module files**: Additional rule sets (e.g., `git/base.md`, `ticketing/base.md`)

Each level builds upon the previous, allowing for shared best practices while maintaining specificity where needed.

## Contributing

This is an opinionated collection. Contributions are welcome for:
- New language support
- New tool support
- New modules
- Improvements to existing rules

## License

Apache 2.0
