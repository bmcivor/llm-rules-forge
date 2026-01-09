# Git Base Rules

Git-specific rules that apply when using git operations.

**Inherits from:** `../base.md`

## Safety

- Never run destructive commands (reset --hard, push --force, clean -fd) without explicit approval
- Never amend or rebase commits that have been pushed
- Always confirm before any operation that rewrites history

## Commit Discipline

- Check `git status` before committing
- Review staged changes with `git diff --staged` before committing
- Write descriptive commit messages - not "Updated files" or "Fixed bug"
- Keep commits atomic - one logical change per commit
- Confirm which branch you're on before committing

## Hygiene

- Never stage with `git add .` without reviewing what's included
- Never commit secrets, credentials, or .env files
- Check .gitignore exists and covers generated files

## Viewing Changes

- To view the content of the current commit, use `git show` - nothing more complicated is required

---

*This file contains git-specific rules.*
