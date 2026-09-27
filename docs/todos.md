# Todos

Outstanding work on MacNewStarter

## Track nono config

Bring `~/.config/nono` into `configs/` so it is symlinked and git tracked like
the other entries there. Deferred because, as of 2026-09-27, the directory
contains no user-authored config at all — only pack-manager state.

What is actually in `~/.config/nono` today:

| Path | What it is | Track? |
| --- | --- | --- |
| `profiles/` | Your own sandbox profiles | Yes — but currently empty |
| `packages/` | Downloaded pack contents, plus a `.staging/` dir | No |
| `packages/lockfile.json` | Installed pack versions, SHAs and signing provenance | No |
| `pack-update-hints.json` | Update-check cache, rewritten with a new timestamp on every check | No |
| `profile-drafts/` | Contains only `.nono-claude-pack-marker` | No |

So the work is mostly ignore rules, in the same shape `configs/opencode/`
already uses for its `node_modules`/`package.json` install artifacts:

1. `cp -R ~/.config/nono configs/nono`
2. Add to the root `.gitignore`:
   ```
   # nono pack-manager state
   /configs/nono/packages/
   /configs/nono/pack-update-hints.json
   /configs/nono/profile-drafts/
   ```
3. Run `mns setup-configs`, which backs up the existing `~/.config/nono` to
   `nono.backup_<timestamp>` and symlinks the repo copy in its place.

No script changes are needed — `scripts/configs.sh` already loops over every
entry in `configs/`.

The open question is whether this is worth doing before there is a profile worth
tracking. Revisit once `~/.config/nono/profiles/` has something in it, since
until then the commit is an empty directory plus five ignore rules.

## Track Claude config

Agreed in principle, not started. `~/.claude` cannot use the `configs/`
infrastructure: it lives in `$HOME`, not `~/.config/`, and `scripts/dotfiles.sh`
only symlinks files, not directories.

Chosen shape is **per-item symlinks**, not a whole-directory symlink. A new
`claude/` directory in the repo plus a `scripts/claude-config.sh` that symlinks
only named items into a `~/.claude` that stays a real directory — the same
pattern `scripts/vscode-settings.sh` uses. Wire it into `run.sh` as
`mns setup-claude-config`.

Start with `settings.json`, the only user-authored file there today. Add
`CLAUDE.md`, `commands/`, `agents/`, `skills/` and `keybindings.json` to the
list as they appear.

The reason for per-item rather than whole-directory: `~/.claude` is ~22M and
almost all of it is machine state that must never reach a public repo,
`history.jsonl`, `.claude.json`, `cache/`, `sessions/`,`shell-snapshots/`,
`file-history/`, `paste-cache/`, `backups/`, `daemon/`,`jobs/`,
`session-env/`, `stats-cache.json`. Symlinking the whole directory
would need a long ignore list that has to be maintained against future Claude
Code releases, and one missed rule leaks transcripts.

## Stop `run_subcommand` reporting success after a failure

`run_subcommand` in `run.sh` calls `log_success "🎉 Command '$cmd' completed!"`
unconditionally after its `case` block, so a subcommand that warns or fails
still prints a success banner. Reproduce with `mns check-brew` while a Brewfile
entry is missing: it lists what is missing, then claims success.

Deliberately not fixed alongside a narrower change, because it touches how every
subcommand reports its outcome and deserves its own pass.
