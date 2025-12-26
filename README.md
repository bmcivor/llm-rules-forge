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
│   ├── python.md             # Cursor + Python rules (inherits from both base files)
│   └── javascript.md         # Cursor + JavaScript rules (inherits from both base files)
└── docs/                      # Additional project documentation
```

## How It Works

Rules follow an inheritance chain:

1. **Root `base.md`**: Universal principles that apply everywhere
2. **Tool-specific `base.md`**: Tool-specific guidelines (e.g., `cursor/base.md`)
3. **Language-specific files**: Combined tool + language rules (e.g., `cursor/python.md`)

Each level builds upon the previous, allowing for shared best practices while maintaining specificity where needed.

## Usage

Copy the relevant rules into your LLM tool's configuration:
- For Python development in Cursor: Use `base.md` + `cursor/base.md` + `cursor/python.md`
- For JavaScript development in Cursor: Use `base.md` + `cursor/base.md` + `cursor/javascript.md`

## Contributing

This is an opinionated collection. Contributions are welcome for:
- New language support
- New tool support
- Improvements to existing rules

## License

Apache 2.0
