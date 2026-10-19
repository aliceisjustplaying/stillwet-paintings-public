# claude-paint: branches, worktrees and what depends on them (2026-09-30)

Main repo `[local path redacted] main at `661c757`. Data: `gitinv.json` (git), `painters.json`
(gallery painters), both in this folder, made by `gitinv.py` and `painters.py`. Nothing was deleted.

## Summary

- **Local branches: 87.** Besides main, 42 are merged into main (10 of the `fix/*` among them).
  42 round and experiment branches aren't in main; 40 of them have a worktree (not `r14a-p1` or
  `r17-base`). The 2 others not in main are `fix/archive` (this work) and `codex/r17-recovery`,
  which is the same commit as `r17-base` (its worktree is `[local path redacted]
  `r6-wet` is 2 commits ahead of `origin/r6-wet`; every other branch on origin matches its local.
- **Origin-only branches: 17** (`amnesia-*`, `easel3-*`, `easel4-*`, `loop*`). None is in main;
  their logs and notes were copied into `notes/amnesia2|3|4` and `notes/loops/` earlier.
- **Worktrees: 75.** 44 are in `[local path redacted] (3 of them the detached r2 ones), 11 are
  `fix/*` in `[local path redacted] 19 are detached scratch worktrees in `[local path redacted] and one is
  main. The worktrees of `r16-base`, `r19-base` and `r20-base` are already gone.
- **Dirty: 21 worktrees.** 4 are round worktrees, 15 are in `[local path redacted] and 2 are the parent's
  `fix/globals` and `fix/oldlogs` (in use, excluded). See "Dirty worktrees".
- **Detached HEADs in no branch or tag:** `199b80d` (3 `[local path redacted] worktrees) and `6244bdb` (2).
  `199b80d`'s evening_lake files are byte-identical in `r7-paint-wet` (`8e3fa81`), and `6244bdb`
  has the same tree as `2159c6c` (on `origin/r6-wet`). They are rebased duplicates, tagged anyway
  (`archive/wt-*`).
- **Tags:** only `round-19` and `round-20` exist (both on origin). The plan adds 62:
  `archive/<branch>` for the 42 unmerged round and experiment branches and the 17 origin-only ones,
  `archive/wt-199b80d`, `archive/wt-6244bdb` and `round-16` (merged, but
  `scripts/export_r16_studio`'s default).
- **A stray process:** `easel serve wet` (pid 22778, up for about a day) runs a binary from the
  deleted `[local path redacted] with its cwd in that deleted folder.

## What depends on what

**(a) The gallery's studio (stillwet `/studio/`, and the viewers).** `studio/studio.py`
`painting_sources()` reads the painting source from the painter's cwd (the last `session` line of
its pi log). 27 of the 64 exported painters have cwds that aren't `paint-studio-*` folders:

- 21 round worktrees, from `claude-paint-r7-arm1` to `claude-paint-r13-tree3`;
- 6 plain folders (not git): `paint-r14-p1..3` and `paint-r15-p1..3`.

21 of them serve one file each (`paintings/src/bin/<prog>.rs`). `r7-arm1`, `r7-arm3`, `r8-arm1`,
`r8-arm3`, `r9-arm1` and `r9-arm3` serve nothing (no `painting.lua`, no `cargo paint`
bin). None of the 27 has a `BRIEF.md` at `[local path redacted]<folder>`, so `subject()`, the other folder
read, is `""` for them either way.

- The fix (fix/archive `48fce1a`): those 21 files are in `archive/sources/<folder>/`, and
  `painting_sources()` falls back to that copy when the cwd is missing.
- The proof: the new exporter ran on copies of the live `dist/studio` with those 27 folders made
  to look missing. Its output was byte-identical to the live export and to a control run, both
  for the 58 `data/*/file/` files and for the whole tree
  (`e2e/{live,control,simulated}.all.sha`).
- **Order matters.** launchd `art.stillwet.studio.sync` runs
  `[local path redacted] (the main checkout's working tree) every minute
  and rsyncs with `--delete` to the VPS. fix/archive must be merged and checked out in main before
  any worktree goes. The two viewers (`art.stillwet.studio.tailnet` and `.public`, cwd
  `[local path redacted] must be restarted to load the new `studio.py`. The plan checks the first
  and does the second.

**(b) Runners.**
- `notes/round19/runner/r19_chains.py` used the `claude-paint-r19-base` worktree and the `r19-base`
  branch; that worktree is already gone. It now extracts the `round-19` tag with `git archive` into
  `run/code` and exports with `R16_BRANCH=round-19 GIT_DIR=[local path redacted] (commit
  `747b9b7`). Proof: a real `checkout()` and blank export from `round-19` built and probed its easel
  (`r19run/`).
- The copies in `[local path redacted] and `r20/` are the old versions (`r20_chains.py`:
  `BASE = claude-paint-r20-base`, already gone). Copy the new runner there before rerunning.
- The runners of rounds 17, 18, 18g and 18r (`notes/round17/runner/r17_chains.py`,
  `notes/round18*/`) use `BASE = claude-paint-r17-base` and `BRANCH = r17-base`. They're
  historical records: after the plan they can't run as they are.
- `notes/round15/chain.sh` uses `[local path redacted] (plain folders the plan doesn't touch).
- `notes/round19/runner/make_painter_text_diff.sh` reads the r17-base and r19-base worktrees and
  a prebuilt easel inside the r17-base worktree's `target/`. It's a one-off that already produced
  its diff and is already broken (r19-base is gone).

**(c) Scripts and docs in the repo.**
- `scripts/export_r16_studio` defaults to `r16-base`. It now defaults to `round-16` (commit
  `84257e4`), and it names a tag's commit instead of the tag object (`c74f85b`; with the tag,
  `rev-parse --short round-19` gave `e8d7026`, not `5069814`). Proof: `R16_BRANCH=round-20`
  exported blank "from round-20 (c2901f8)".
- `harness/painter/README.md` launched from `claude-paint-r17-base`; it now uses this folder.
- `notes/r16|r17|r19|r20/BUILD.md` now name tags. The briefs in `notes/briefs/sent/` and the round
  READMEs name the old folders as history; they're left as they are.

**(d) stillwet (outside this repo; nothing was edited there).**
- `sync-studio.sh:14` and `deploy.sh:30,46` run `../claude-paint/studio/export_static.py`. That's
  covered by (a).
- `stages.py:59-83` builds each painting's program in its folder (`claude-paint-r2-*`,
  `claude-paint-r7..r13-*`, `paint-r14*`, `paint-r15*`). It re-creates only the r2 ones, from
  `origin/amnesia-*`. After the plan those refs are `archive/amnesia-*`, and the other rows need a
  ref too (`archive/<branch>`). It's a one-off with 4 of 25 done
  (`[local path redacted]
- `inputs_extract.py:61` `R17_SYSTEM` reads
  `[local path redacted] and at line 581 it silently
  skips that match when the file is missing. Change it to
  `git -C [local path redacted] show archive/r17-base:harness/painter/system_prompt.md`.
  `git_versions()` (`git log --all`) keeps every blob, because every unmerged branch and detached
  HEAD gets a tag.
- `DEPLOY.md:65-66`: "rounds 16-18: `r17-base`, round 19: `r19-base`" should become
  `archive/r17-base` and `round-19`. It should also say that `/studio/` needs claude-paint's
  `archive/sources/` (the painters of rounds 7-15).

**(e) launchd.** `[local path redacted] (see (a)).
None of them names a worktree or branch.

## Dirty worktrees

"NEW" means the file's current content is in no commit in the repo. Everything is saved in
`dirty/<path>/` here (`tracked.diff` and `untracked.tgz`).

| worktree | what's uncommitted | NEW? |
|---|---|---|
| [local path redacted] (r10-arm2) | untracked `paintings/src/bin/r10_crackslab.rs` (46 KB) | NEW |
| [local path redacted] (r12-tree2) | untracked `out/r12_tree2_probe.pgm` (1.4 MB probe image) | NEW, disposable |
| [local path redacted] (r7-paint-wet) | `scripts/peek` modified (8 lines) | the content exists in another commit |
| [local path redacted] (r7-texture) | untracked `scripts/__pycache__/*.pyc` | disposable |
| [local path redacted] (0abe49e) | `crack.rs` +4, untracked `crack_lab.rs` | both exist in commits |
| [local path redacted] (61e5786) | `easel/src/main.rs`, `pace.test.ts`, untracked `check.rs` | all exist in commits |
| [local path redacted] | frames port for old rounds: `easel/src/frames.rs` (+169), main.rs, time.rs, tally.rs, 2 Cargo.toml | NEW |
| [local path redacted] | frames port (easel3-free): frames.rs (+108), api.rs, main.rs | NEW |
| [local path redacted] | frames port (easel4-free): the same 3 files | NEW |
| [local path redacted] arm2, arm3 | frames port for r10: bristle.rs, canvas.rs, lib.rs, sched.rs (+38); frames.rs exists in a commit | NEW (4 files each) |
| [local path redacted] (199b80d) | `crack.rs` (+393, exists in a commit), `easel/src/api.rs`, untracked `examples/crackbench.rs` | 2 NEW |
| [local path redacted] (199b80d) | piles, staged: 7 files (+850); piles.rs, handling.rs and api.rs exist in commits | README, main.rs, lib.rs NEW |
| [local path redacted] (62ace25) | untracked `paintings/src/bin/fresh2_winter.rs` (70 KB) | NEW |
| [local path redacted] bis2, bis3 | untracked `fresh2_winter.rs` (a bisect copy each); bis2 and bis3 also `canvas.rs` (1 line) | NEW |
| [local path redacted] (43249ba) | `canvas.rs`, `stipple.rs` (A/B switches, 3 lines) | NEW |

The ports in `old-rounds-frames` and `r10-frames` made the clips of rounds 3-10 (the old HANDOFF:
"ports in `[local path redacted]"). They're worth keeping if old rounds will ever be
clipped again. The `r7-winter-ab` ones are bisect scaffolding, and `r12-tree2` and `r7-texture`
hold disposable files. `r10_crackslab.rs` is a painter's lab file that was never committed.

## Folders that aren't worktrees

`[local path redacted] `paint-r15-p1..3`, `paint-r14a-p1` and `paint-r14b-p1-poisoned` are
plain copies (no `.git`). The gallery no longer needs the first six (their sources are archived),
but stillwet `stages.py` builds in them. The plan doesn't touch them.

