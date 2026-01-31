# Ansible Base Rules

Rules for writing Ansible playbooks and roles.

**Inherits from:** `../base.md`

## Idempotency

- Tasks must be idempotent - running twice should produce the same result
- Avoid shell/command modules when a proper module exists
- Use creates/removes arguments for shell/command when needed

## Handlers

- Use handlers for service restarts, don't restart directly in tasks
- Name handlers clearly (e.g., `restart nginx`, `reload systemd`)
- Handlers should be in `handlers/main.yaml`, not inline

## Variables

- Use clear, prefixed variable names (e.g., `nginx_port`, not `port`)
- Define defaults in `defaults/main.yaml`
- Don't hardcode values in tasks - use variables
- Check for Ansible reserved variable names before using (e.g., `action`, `name`, `environment`)

## Secrets

- Never commit secrets to version control
- Use ansible-vault for sensitive data
- Keep vaulted files separate (e.g., `vault.yaml`)

## Style

- Use native YAML syntax, not key=value inline format
- Use `true`/`false` for booleans, not `yes`/`no`
- Use `loop` over deprecated `with_*` forms

## Privilege Escalation

- Be explicit about `become: true` - don't assume
- Specify `become_user` when not root
- Limit privilege escalation to tasks that need it

## Structure

- Follow standard role directory structure (tasks, handlers, defaults, vars, templates)
- One concern per role
- Use tags for selective execution

---

*This file contains Ansible-specific rules.*
