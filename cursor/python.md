# Cursor + Python Rules

Rules specific to using Cursor with Python development.

**Inherits from:** 
- `../base.md` (root base rules)
- `./base.md` (Cursor base rules)

## Environment and dependency commands (Composer / agent)

- Run `uv`, `uv venv`, `pip`, `pip install`, or other package/env commands **only** when **B explicitly asked** for environment or dependency work (e.g. set up a venv, add a dependency, sync a lockfile).
- If the task is code or review only, **do not** run those commands — **propose** the exact commands for B to run. See **`cursor/composer.md`** (*Host environment and installs*).

## Python-Specific Guidelines

- Follow PEP 8 style guidelines
- Use type hints where appropriate
- Prefer list comprehensions for simple transformations
- Optimize for algorithmic efficiency (memory and runtime); use parallelization or vectorization where it fits
- Reuse code (DRY); avoid extra code or unnecessary technical debt
- Prefer clarity and maintainability over cleverness

## Preferred Tools

- Use `uv` for package management and to create a `.venv` when missing **once env/deps work is in scope** (see *Environment and dependency commands* above)
- For Jupyter: install `ipykernel` and `ipywidgets` in `.venv` (not in package requirements); use `tqdm` for long-running loops with a clear `description`
- Use `orjson` for JSON load/dump; use `logger.error` (not `print`) when reporting errors to the console
- Data science: use `polars` instead of `pandas`; when printing a dataframe, do not also print row count or schema; work on subsets (e.g. at most 10 rows) to avoid overloading context
- Databases: do not denormalize unless asked; use appropriate types (e.g. `DATETIME`/`TIMESTAMP` for datetimes, `ARRAY` for nested data, not `TEXT`/`STRING`)
- In Jupyter, explicitly `print()` DataFrame results inside conditional blocks so they are visible

## Code Style

- Use spaces for indentation, never tabs (4 spaces)
- Ensure generated code has no trailing whitespace or whitespace errors
- Import statements must always be at the top of the file, never inside functions
- Use meaningful, descriptive names: `snake_case` for functions and variables, `PascalCase` for classes, `UPPER_CASE` for constants
- Limit line length to 88 characters (Ruff default)
- No emoji or emoji-like unicode (except in tests for multibyte behavior)

## Documentation

- Use docstrings for functions and classes
- No inline or block comments — if comments are needed, they go in docstrings
- Document parameters, return values, and exceptions raised for public API; for non-obvious behavior, include a short example in the docstring

Example docstring:

```
Args:
  items: List of item dicts with 'price' keys.
  tax_rate: Tax rate as decimal (e.g. 0.08 for 8%).

Returns:
  Total cost including tax.

Raises:
  ValueError: If items is empty or tax_rate is negative.
```

## Type Hints

- Use type hints on all function signatures (parameters and return type)
- Avoid `Any` unless necessary; use `Optional[T]` or `T | None` for nullable types
- Always use type hints from the typing module like Dict, not python primitives like dict

## Error Handling

- Do not swallow exceptions without logging; do not use bare `except:`
- Catch specific exception types; use context managers (`with`) for resources and cleanup
- Use clear, actionable error messages

## Function Design

- One clear responsibility per function; return early to keep nesting low
- Do not use mutable defaults (e.g. `[]`, `{}`); limit to 5 or fewer parameters

## Class Design

- One clear responsibility per class; keep `__init__` simple
- Use dataclasses for simple data containers; prefer composition over inheritance
- Use `@property` for computed attributes; avoid extra methods that aren’t needed

## Testing

- Write pytest-compatible tests
- Use descriptive test function names
- Write unit tests for new functions and classes; mock external dependencies (APIs, DBs, filesystem)
- Save tests in their own file before running them; do not delete files created for testing; add test output directories to `.gitignore`
- Follow Arrange–Act–Assert
- Test docstrings format:
  ```
  Setup:
  Expectations:
  ```
- Do not leave commented-out tests in the code

## Imports and Dependencies

- No wildcard imports (`from module import *`)
- Document dependencies in `pyproject.toml`; use `uv` for installs and resolution
- Order imports: standard library, then third-party, then local; use Ruff (or isort) for import formatting

## Python Practices

- Do not use mutable default arguments; use context managers for files and other resources
- Compare to `None`, `True`, `False` with `is`; use f-strings for formatting
- Prefer list comprehensions and generator expressions; use `enumerate()` instead of manual counters

## Security

- Do not put secrets, API keys, or passwords in code; use `.env` and ensure `.env` is in `.gitignore`
- Do not print or log URLs that contain an API key; use environment variables for sensitive config; do not log secrets, tokens, or PII

## Tools

- Use Ruff for formatting and linting; use mypy for type checking; use `uv` for package management; use pytest for tests

## Before Handing Off

- Public functions have docstrings and type hints; no commented-out code or debug statements; no hardcoded credentials

---
