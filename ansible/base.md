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

- Never commit secrets to version control in plaintext
- Use ansible-vault for sensitive data
- Keep vaulted files separate (e.g., `inventory/group_vars/all/vault.yaml`)

### Vault operations (agent safety)

- Prefer **`vault_password_file`** in `ansible.cfg` (or project docs) so playbooks decrypt without pasting passwords in chat
- **Do not** paste `ansible-vault view` / decrypt output into assistant messages
- **Do not** modify or re-encrypt an existing vaulted file without **explicit** user approval; vault edits rotate ciphertext and are easy to get wrong under pressure
- Document the workflow: `ansible-vault edit <path>` (often via the project’s Dockerized Ansible image), not ad-hoc installs of `ansible-core` on the host to get `ansible-vault`

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
