# Installed Codex Skills

Installed on 2026-07-18. Third-party sources remain under `vendor/`; user-level discovery uses symbolic links in `~/.agents/skills`.

| Skill | Source repository | Source path | Commit SHA | Local source | Global link | Update method | Verified | Main capability | Known limitations |
|---|---|---|---|---|---|---|---|---|---|
| `using-superpowers` | `https://github.com/obra/superpowers.git` | `skills/using-superpowers` | `d884ae04edebef577e82ff7c4e143debd0bbec99` | `vendor/superpowers/skills/using-superpowers` | `~/.agents/skills/using-superpowers` | Clean-tree `git pull --ff-only` via `scripts/update-skills.sh` | Yes | Superpowers workflow bootstrap | Skill-only install; Codex marketplace plugin metadata/hooks are not installed. |
| `systematic-debugging` | `https://github.com/obra/superpowers.git` | `skills/systematic-debugging` | `d884ae04edebef577e82ff7c4e143debd0bbec99` | `vendor/superpowers/skills/systematic-debugging` | `~/.agents/skills/systematic-debugging` | Same as above | Yes | Root-cause-first debugging | Includes optional helper material; nothing runs automatically. |
| `verification-before-completion` | `https://github.com/obra/superpowers.git` | `skills/verification-before-completion` | `d884ae04edebef577e82ff7c4e143debd0bbec99` | `vendor/superpowers/skills/verification-before-completion` | `~/.agents/skills/verification-before-completion` | Same as above | Yes | Evidence-based completion checks | Workflow guidance only. |
| `requesting-code-review` | `https://github.com/obra/superpowers.git` | `skills/requesting-code-review` | `d884ae04edebef577e82ff7c4e143debd0bbec99` | `vendor/superpowers/skills/requesting-code-review` | `~/.agents/skills/requesting-code-review` | Same as above | Yes | Pre-merge/task code review | Some instructions assume subagent support. |
| `test-driven-development` | `https://github.com/obra/superpowers.git` | `skills/test-driven-development` | `d884ae04edebef577e82ff7c4e143debd0bbec99` | `vendor/superpowers/skills/test-driven-development` | `~/.agents/skills/test-driven-development` | Same as above | Yes | Red-green-refactor TDD | Strict workflow; project test tooling remains project-owned. |
| `finishing-a-development-branch` | `https://github.com/obra/superpowers.git` | `skills/finishing-a-development-branch` | `d884ae04edebef577e82ff7c4e143debd0bbec99` | `vendor/superpowers/skills/finishing-a-development-branch` | `~/.agents/skills/finishing-a-development-branch` | Same as above | Yes | Safe branch merge/PR/cleanup choices | Destructive discard still requires confirmation. |
| `writing-plans` | `https://github.com/obra/superpowers.git` | `skills/writing-plans` | `d884ae04edebef577e82ff7c4e143debd0bbec99` | `vendor/superpowers/skills/writing-plans` | `~/.agents/skills/writing-plans` | Same as above | Yes | Detailed implementation planning | Complements, but does not replace, persistent Planning with Files. |
| `planning-with-files` | `https://github.com/OthmanAdi/planning-with-files.git` | `.codex/skills/planning-with-files` | `7c6c6cbb76ebee7c7a7e28a38a08d3ad7d1e0427` | `vendor/planning-with-files/.codex/skills/planning-with-files` | `~/.agents/skills/planning-with-files` | Clean-tree `git pull --ff-only` via `scripts/update-skills.sh` | Yes (skill discovery); hooks not enabled | Persistent `task_plan.md`, `findings.md`, and `progress.md` planning | Global lifecycle hooks were intentionally not copied or merged; hook automation therefore remains disabled. |
| `playwright` | `https://github.com/openai/skills.git` | `skills/.curated/playwright` | `49f948faa9258a0c61caceaf225e179651397431` | `vendor/openai-skills/skills/.curated/playwright` | `~/.agents/skills/playwright` | Clean-tree sparse-checkout `git pull --ff-only` via `scripts/update-skills.sh` | Yes (skill discovery); CLI not executed | Browser automation and UI-flow debugging | Requires `npx` when invoked; wrapper may download `@playwright/cli` transiently. No dependency was installed during setup. |

## Discovery roots

- Current official Codex documentation identifies `$HOME/.agents/skills` as the user-level Skill root.
- `$HOME/.codex/skills/.system` contains bundled system Skills on this machine; no third-party links were added there.
- Repository-level `.agents/skills` directories are also discovered when present.

## Updating

Run:

```bash
/Users/tao/Projects/Working/skills/scripts/update-skills.sh
```

The updater skips dirty repositories, performs only fast-forward pulls, and validates every registered link and `SKILL.md` afterward.
