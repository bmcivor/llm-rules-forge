# Git Base Rules

Git-specific rules that apply when using git operations.

**Inherits from:** `../base.md`

## LLM Restrictions

### Exploratory (read-only) — allowed

The assistant **may run** commands that **only inspect or compare** state: they **do not** stage files, create commits, merge, rebase, reset, push, pull into `HEAD`, switch `HEAD`, or rewrite published history. (Updating **remote-tracking** refs with `git fetch` is allowed — it does not merge and does not move your current branch.)

**Examples (allowed):**

- `git status`, `git status -sb`
- `git diff`, `git diff --staged`, `git diff <ref>..<ref>`
- `git log` (with any read-only flags), `git show`, `git shortlog`
- `git branch -a`, `git branch -vv` (listing only)
- `git remote -v`, `git rev-parse`, `git describe`
- `git blame` (read-only), `git ls-files`, `git tag -l`
- `git fetch`, `git fetch --all` (updates `refs/remotes/*` only)

### Mutating or history-changing — not allowed for the assistant to run

The assistant **must not execute** git commands that **stage, commit, merge, rebase, reset, push, pull, change branches, rewrite history, or otherwise mutate** the repo. **Give the user the exact command** to run themselves.

**Examples (do not run — suggest for B):**

- Index / tree: `git add`, `git rm`, `git mv`, `git restore` / `git checkout --` (when changing files)
- Commits: `git commit`, `git cherry-pick`, `git revert`
- History / refs: `git merge`, `git rebase`, `git reset`, `git stash` (push/pop/apply), `git tag` when it creates a tag you would push
- Remotes: `git push`, `git pull` (`git pull` = fetch + merge; not the same as `git fetch` alone)
- Branch / checkout: `git checkout` / `git switch` when it changes `HEAD` or working tree, `git branch -d` / `-D`

If in doubt: **read-only inspection = allowed; anything that would appear in a tutorial as “now your repo changed” = suggest, don’t run.**

### General (still applies)

- Don't assume branch, remote, or status — use exploratory commands or ask B
- When **suggesting** mutating commands, explain what they do and what state they leave the repo in
- After B runs a mutating command, wait for output before suggesting the next step
- Don't chain mutating commands in one suggestion — one operation at a time
- Don't assume commit hashes, branch names, or remote names — confirm with B first
- If a git operation fails, ask B to share the error before the next suggestion

## Safety

- Never run destructive commands (reset --hard, push --force, clean -fd) without explicit approval
- Never amend or rebase commits that have been pushed
- Always confirm before any operation that rewrites history
- If the user says not to modify a file or repo, that is absolute — do not touch it even to "fix" something you broke

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
