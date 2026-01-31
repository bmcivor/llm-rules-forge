# Git Base Rules

Git-specific rules that apply when using git operations.

**Inherits from:** `../base.md`

## LLM Restrictions

- Never execute git commands directly - always provide commands for the user to run
- Don't assume the current branch, remote state, or repository status - ask or wait for the user to provide output
- When suggesting git commands, explain what they do and what state they'll leave the repo in
- After the user runs a command, wait for them to share the output before suggesting the next step
- Don't chain git commands together in a single suggestion - one operation at a time
- Never suggest commands that assume commit hashes, branch names, or remote names without the user confirming them first
- If a git operation fails, don't immediately suggest a fix - ask the user to share the error output first

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
