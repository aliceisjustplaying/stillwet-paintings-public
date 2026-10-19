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

### Local branches

| branch | tip | in main | not in main | origin | worktree | tag |
|---|---|---|---|---|---|---|
| codex/r17-recovery | e2ccc0a | no | 3 | - | [local path redacted] | archive/r17-base |
| craft-trees | 2220e6f | yes | 0 | same |  |  |
| fix-cracks | d65a27b | yes | 0 | same |  |  |
| fix-dry-rims | 7428052 | yes | 0 | same |  |  |
| fix-twigs | 5085433 | yes | 0 | same |  |  |
| fix/archive | 84257e4 | no | 5 | - | [local path redacted] |  |
| fix/clips | 2f0a945 | yes | 0 | - | [local path redacted] |  |
| fix/easel-limits | dc6c43c | yes | 0 | - | [local path redacted] |  |
| fix/easel-replay | 0f8c3b8 | yes | 0 | - | [local path redacted] |  |
| fix/engine | 062e5a8 | yes | 0 | - | [local path redacted] |  |
| fix/globals | 661c757 | yes | 0 | - | [local path redacted] |  |
| fix/harness | 605f451 | yes | 0 | - | [local path redacted] |  |
| fix/integrate | 661c757 | yes | 0 | - | [local path redacted] |  |
| fix/oldlogs | 661c757 | yes | 0 | - | [local path redacted] |  |
| fix/runner | 21dce0d | yes | 0 | - | [local path redacted] |  |
| fix/studio | 5251392 | yes | 0 | - | [local path redacted] |  |
| main | 661c757 | yes | 0 | same | [local path redacted] |  |
| r10-arm1 | fb3e092 | no | 8 | same | [local path redacted] | archive/r10-arm1 |
| r10-arm2 | 3195bac | no | 4 | same | [local path redacted] | archive/r10-arm2 |
| r10-arm3 | 1cab236 | no | 8 | same | [local path redacted] | archive/r10-arm3 |
| r11-astra | e5e3bbd | no | 3 | same | [local path redacted] | archive/r11-astra |
| r11-fable | 9f80ae7 | no | 6 | same | [local path redacted] | archive/r11-fable |
| r11-flash | 61e37f7 | no | 2 | same | [local path redacted] | archive/r11-flash |
| r11-study1 | c5429f8 | no | 4 | same | [local path redacted] | archive/r11-study1 |
| r11-study2 | 0c43391 | no | 9 | same | [local path redacted] | archive/r11-study2 |
| r11-study3 | e1bdbdd | no | 6 | same | [local path redacted] | archive/r11-study3 |
| r12-tree1 | 6fbf646 | no | 7 | same | [local path redacted] | archive/r12-tree1 |
| r12-tree2 | d14a211 | no | 5 | same | [local path redacted] | archive/r12-tree2 |
| r12-tree3 | e15de32 | no | 3 | same | [local path redacted] | archive/r12-tree3 |
| r13-base | 8b6b44a | no | 1 | same | [local path redacted] | archive/r13-base |
| r13-tree1 | 321280c | no | 4 | same | [local path redacted] | archive/r13-tree1 |
| r13-tree2 | 434d60b | no | 5 | same | [local path redacted] | archive/r13-tree2 |
| r13-tree3 | 63df233 | no | 6 | same | [local path redacted] | archive/r13-tree3 |
| r14-base | 9c0b603 | no | 7 | same | [local path redacted] | archive/r14-base |
| r14-p1 | 404df88 | no | 8 | same | [local path redacted] | archive/r14-p1 |
| r14-p2 | 11640fd | no | 8 | same | [local path redacted] | archive/r14-p2 |
| r14-p3 | 2c3ee4a | no | 8 | same | [local path redacted] | archive/r14-p3 |
| r14a-p1 | 346dc1f | no | 5 | same |  | archive/r14a-p1 |
| r15-base | 1b7e32e | no | 21 | same | [local path redacted] | archive/r15-base |
| r15-p1 | a2d1e9a | no | 22 | same | [local path redacted] | archive/r15-p1 |
| r15-p2 | 5014d01 | no | 22 | same | [local path redacted] | archive/r15-p2 |
| r15-p3 | 26a235b | no | 22 | same | [local path redacted] | archive/r15-p3 |
| r16-base | 38a990d | yes | 0 | same |  | round-16 |
| r17-base | e2ccc0a | no | 3 | same |  | archive/r17-base |
| r19-base | 5069814 | yes | 0 | same |  | round-19 |
| r20-base | c2901f8 | yes | 0 | same |  | round-20 |
| r6-glitch | 37d3f30 | yes | 0 | - |  |  |
| r6-house | 31a64c0 | yes | 0 | - |  |  |
| r6-lab1 | fc66feb | yes | 0 | - |  |  |
| r6-lab2 | 3d39c11 | yes | 0 | - |  |  |
| r6-lab3 | 104eb21 | yes | 0 | - |  |  |
| r6-lab4 | b9233fe | yes | 0 | - |  |  |
| r6-maint-a | ce1b789 | yes | 0 | - |  |  |
| r6-maint-b | 7de35ab | yes | 0 | - |  |  |
| r6-oak | decd006 | yes | 0 | same |  |  |
| r6-pencil | bc46aa0 | yes | 0 | - |  |  |
| r6-time | 09973c1 | yes | 0 | - |  |  |
| r6-varnish | 97fa9cf | yes | 0 | same |  |  |
| r6-wet | 62ace25 | no | 33 | differs | [local path redacted] | archive/r6-wet |
| r7-arm1 | 3c51bf0 | no | 9 | same | [local path redacted] | archive/r7-arm1 |
| r7-arm2 | fe38d44 | no | 6 | same | [local path redacted] | archive/r7-arm2 |
| r7-arm3 | f4af482 | no | 7 | same | [local path redacted] | archive/r7-arm3 |
| r7-cracks | f4a8590 | yes | 0 | - |  |  |
| r7-d | c374046 | yes | 0 | - |  |  |
| r7-edges | 3143893 | yes | 0 | - |  |  |
| r7-friedrich | 97a8968 | yes | 0 | - |  |  |
| r7-paint-wet | 8e3fa81 | no | 33 | same | [local path redacted] | archive/r7-paint-wet |
| r7-paint1 | ba29e7d | yes | 0 | - |  |  |
| r7-piles | 83e8360 | no | 8 | same | [local path redacted] | archive/r7-piles |
| r7-process | 5ba9d35 | yes | 0 | - |  |  |
| r7-python | 4047841 | no | 2 | - | [local path redacted] | archive/r7-python |
| r7-sitting | cffbc16 | yes | 0 | - |  |  |
| r7-texture | 2e9e4c6 | no | 1 | - | [local path redacted] | archive/r7-texture |
| r7-winter | 505fa85 | yes | 0 | - |  |  |
| r7-winter-ab | 145e2f9 | yes | 0 | - |  |  |
| r8-arm1 | 16768f4 | no | 11 | same | [local path redacted] | archive/r8-arm1 |
| r8-arm2 | 25ee859 | no | 5 | same | [local path redacted] | archive/r8-arm2 |
| r8-arm3 | d867285 | no | 8 | same | [local path redacted] | archive/r8-arm3 |
| r9-arm1 | e90a7ce | no | 9 | same | [local path redacted] | archive/r9-arm1 |
| r9-arm2 | 0b0fab2 | no | 6 | same | [local path redacted] | archive/r9-arm2 |
| r9-arm3 | 4a4b3a8 | no | 8 | same | [local path redacted] | archive/r9-arm3 |
| research-trees | b6386b7 | yes | 0 | same |  |  |
| test-audit | 2eae003 | yes | 0 | - |  |  |
| wet-before | 1e9737d | no | 2 | - | [local path redacted] | archive/wet-before |
| wet-merge | e7956e5 | no | 37 | - | [local path redacted] | archive/wet-merge |
| workshop | e0f1533 | yes | 0 | same |  |  |
| workshop2 | bc86e30 | yes | 0 | - |  |  |

### Origin-only branches

| branch | tip | in main | not in main | tag |
|---|---|---|---|---|
| amnesia-coast | 2a157cb | no | 11 | archive/amnesia-coast |
| amnesia-mountains | a852f3e | no | 12 | archive/amnesia-mountains |
| amnesia-winter | fa772d2 | no | 15 | archive/amnesia-winter |
| easel3-free | a6b7e2c | no | 23 | archive/easel3-free |
| easel3-green | e5b34a2 | no | 16 | archive/easel3-green |
| easel3-near | ffaa0f2 | no | 15 | archive/easel3-near |
| easel4-free | 7f39937 | no | 17 | archive/easel4-free |
| easel4-green | 38bcf86 | no | 7 | archive/easel4-green |
| easel4-near | 5761454 | no | 6 | archive/easel4-near |
| loop1-green | 126f3f8 | no | 2 | archive/loop1-green |
| loop1-near | 357c8d2 | no | 3 | archive/loop1-near |
| loop2-green | 1258392 | no | 3 | archive/loop2-green |
| loop2-near | 543eae2 | no | 3 | archive/loop2-near |
| loop3-green | 3ab6278 | no | 2 | archive/loop3-green |
| loop3-near | 58d26cb | no | 4 | archive/loop3-near |
| loop4-near | d301946 | no | 2 | archive/loop4-near |
| loop5-near | f387ece | no | 2 | archive/loop5-near |

### Worktrees

| path | branch / HEAD | changes | untracked | gallery painter |
|---|---|---|---|---|
| [local path redacted] | main | 0 | 0 |  |
| [local path redacted] | r10-arm1 | 0 | 0 | claude-paint-r10-arm1 |
| [local path redacted] | r10-arm2 | 0 | 1 | claude-paint-r10-arm2 |
| [local path redacted] | r10-arm3 | 0 | 0 | claude-paint-r10-arm3 |
| [local path redacted] | r11-astra | 0 | 0 | claude-paint-r11-astra |
| [local path redacted] | r11-fable | 0 | 0 | claude-paint-r11-fable |
| [local path redacted] | r11-flash | 0 | 0 | claude-paint-r11-flash |
| [local path redacted] | r11-study1 | 0 | 0 |  |
| [local path redacted] | r11-study2 | 0 | 0 |  |
| [local path redacted] | r11-study3 | 0 | 0 |  |
| [local path redacted] | r12-tree1 | 0 | 0 | claude-paint-r12-tree1 |
| [local path redacted] | r12-tree2 | 0 | 1 | claude-paint-r12-tree2 |
| [local path redacted] | r12-tree3 | 0 | 0 | claude-paint-r12-tree3 |
| [local path redacted] | r13-base | 0 | 0 |  |
| [local path redacted] | r13-tree1 | 0 | 0 | claude-paint-r13-tree1 |
| [local path redacted] | r13-tree2 | 0 | 0 | claude-paint-r13-tree2 |
| [local path redacted] | r13-tree3 | 0 | 0 | claude-paint-r13-tree3 |
| [local path redacted] | r14-base | 0 | 0 |  |
| [local path redacted] | r14-p1 | 0 | 0 |  |
| [local path redacted] | r14-p2 | 0 | 0 |  |
| [local path redacted] | r14-p3 | 0 | 0 |  |
| [local path redacted] | r15-base | 0 | 0 |  |
| [local path redacted] | r15-p1 | 0 | 0 |  |
| [local path redacted] | r15-p2 | 0 | 0 |  |
| [local path redacted] | r15-p3 | 0 | 0 |  |
| [local path redacted] | codex/r17-recovery | 0 | 0 |  |
| [local path redacted] | detached 2a157cb | 0 | 0 |  |
| [local path redacted] | detached a852f3e | 0 | 0 |  |
| [local path redacted] | detached fa772d2 | 0 | 0 |  |
| [local path redacted] | r6-wet | 0 | 0 |  |
| [local path redacted] | r7-arm1 | 0 | 0 | claude-paint-r7-arm1 |
| [local path redacted] | r7-arm2 | 0 | 0 | claude-paint-r7-arm2 |
| [local path redacted] | r7-arm3 | 0 | 0 | claude-paint-r7-arm3 |
| [local path redacted] | r7-paint-wet | 1 | 0 |  |
| [local path redacted] | r7-piles | 0 | 0 |  |
| [local path redacted] | r7-python | 0 | 0 |  |
| [local path redacted] | r7-texture | 0 | 1 |  |
| [local path redacted] | r8-arm1 | 0 | 0 | claude-paint-r8-arm1 |
| [local path redacted] | r8-arm2 | 0 | 0 | claude-paint-r8-arm2 |
| [local path redacted] | r8-arm3 | 0 | 0 | claude-paint-r8-arm3 |
| [local path redacted] | r9-arm1 | 0 | 0 | claude-paint-r9-arm1 |
| [local path redacted] | r9-arm2 | 0 | 0 | claude-paint-r9-arm2 |
| [local path redacted] | r9-arm3 | 0 | 0 | claude-paint-r9-arm3 |
| [local path redacted] | wet-before | 0 | 0 |  |
| [local path redacted] | wet-merge | 0 | 0 |  |
| [local path redacted] | fix/archive | 0 | 0 |  |
| [local path redacted] | fix/clips | 0 | 0 |  |
| [local path redacted] | fix/easel-limits | 0 | 0 |  |
| [local path redacted] | fix/easel-replay | 0 | 0 |  |
| [local path redacted] | fix/engine | 0 | 0 |  |
| [local path redacted] | fix/globals | 2 | 0 |  |
| [local path redacted] | fix/harness | 0 | 0 |  |
| [local path redacted] | fix/integrate | 0 | 0 |  |
| [local path redacted] | fix/oldlogs | 5 | 1 |  |
| [local path redacted] | fix/runner | 0 | 0 |  |
| [local path redacted] | fix/studio | 0 | 0 |  |
| [local path redacted] | detached 0abe49e | 1 | 1 |  |
| [local path redacted] | detached 61e5786 | 2 | 1 |  |
| [local path redacted] | detached 02f8946 | 6 | 0 |  |
| [local path redacted] | detached 0830b64 | 3 | 0 |  |
| [local path redacted] | detached e5cfa8b | 3 | 0 |  |
| [local path redacted] | detached fa772d2 | 0 | 0 |  |
| [local path redacted] | detached fb3e092 | 4 | 1 |  |
| [local path redacted] | detached 3195bac | 4 | 1 |  |
| [local path redacted] | detached 1cab236 | 4 | 1 |  |
| [local path redacted] | detached 199b80d | 2 | 1 |  |
| [local path redacted] | detached 6244bdb | 0 | 0 |  |
| [local path redacted] | detached 199b80d | 0 | 0 |  |
| [local path redacted] | detached 6244bdb | 0 | 0 |  |
| [local path redacted] | detached 199b80d | 7 | 0 |  |
| [local path redacted] | detached 62ace25 | 0 | 1 |  |
| [local path redacted] | detached eefdfec | 0 | 1 |  |
| [local path redacted] | detached 6bd8253 | 1 | 1 |  |
| [local path redacted] | detached fa1862b | 1 | 1 |  |
| [local path redacted] | detached 43249ba | 2 | 0 |  |

### Unique commits (oneline) per unmerged branch

<details><summary>codex/r17-recovery (3)</summary>

```
e2ccc0a replay_clip: --open-hold S shows the bare canvas first (taken out of the rest); usage prints the whole header
acd022a Make easel check a lightweight integrity check
e2cafaa Show progress while reopening paintings
```
</details>

<details><summary>fix/archive (5)</summary>

```
84257e4 export_r16_studio defaults to the round-16 tag (the r16-base branch goes); the BUILD notes of rounds 16, 17 and 19 name their tags (round-16, archive/r17-base, round-19)
1604357 HANDOFF.md removed: a machine-move note (2026-09-23) that became a hand-kept status log and went stale; what is still true and needed (the anonymity hook and history rewrite, rounds as tags, where runners, run data and studios live, the viewers, the gallery and its studio sync, working rules) is in the README; the three notes that pointed at it no longer do
747b9b7 round 19 runner: runs round 19's code from the round-19 tag, extracted with git archive into run/code (the export reading the tag through GIT_DIR), so it no longer needs the r19-base branch or its worktree; notes/r20/BUILD.md names the round-20 tag
c74f85b export_r16_studio: R16_BRANCH may be a tag (round-19, round-20): the build folder and the report name its commit, not the tag object's hash (which built the same code again under another name)
48fce1a studio: a painter whose folder is gone (a round's worktree, removed) is served from archive/sources/<folder name>, which holds the painting source files the viewer and export served for the 27 painters of rounds 7-15 whose folders are worktrees or copies (so removing those keeps the gallery's /studio/ byte for byte)
```
</details>

<details><summary>r10-arm1 (8)</summary>

```
fb3e092 r10_winter_a: final render notes
392989c r10_winter_a: broken snag, boulder uprights, critique
17929d6 r10_winter_a: light through the dolmen, calmer stone, notes
89a8296 r10_winter_a: crescent moon mask, limb reloads, splinters
419ab46 r10_winter_a: figure, footprints, subtle drift crests
d3646cb r10_winter_a: pointed tips, drift crests, softer cracks, notes
abbdbeb r10_winter_a: dolmen modeling, bark, grass, cracks
9c6dddc r10_winter_a: first complete pass (dolmen in snow at dusk), own oak habit
```
</details>

<details><summary>r10-arm2 (4)</summary>

```
3195bac r10_winter_b: notes, friction list, critique
90578c4 r10_winter_b: perspective drifts, snow palette family, spruce masses, stone planes
fd9c042 r10_winter_b: fir wood, spruces, stone, village, quieter cracks; notes
01fc5b7 r10_winter_b: first complete painting
```
</details>

<details><summary>r10-arm3 (8)</summary>

```
1cab236 notes/r10_summer.md: last friction item, render times
a05de79 r10_summer: dock leaves lit
ff301a1 r10_summer: figures' heads and shawl, corner plants
b4632b7 r10_summer: cloud palette, thinner sky underpainting; notes: method, friction, critique
c2657c3 r10_summer: horses, rut grain, thistle, quieter far grass
6dda351 r10_summer: trunk as a modeled column, shadow laid into the meadow, ovate lobed crown, swallows
920af44 r10_summer: clouds, track, plants, crown masses; notes
84ffaf2 r10_summer: first passes of the summer lime painting, notes
```
</details>

<details><summary>r11-astra (3)</summary>

```
e5e3bbd Finish winter ford painting and document full-resolution verification
52be012 Refine connected oak, restrained pigment families and broken river ice
12f3faf Establish winter ford composition and record first preview critique
```
</details>

<details><summary>r11-fable (6)</summary>

```
9f80ae7 r11_winter_fable: final notes
e22d3ab r11_winter_fable: thick wood gone over twice, riggers kept fed
509937f r11_winter_fable: a broken fence receding to the right; notes
231c6e4 r11_winter_fable: snow lies on the limbs as strokes, mist as a scumble, coat flares, tracks
3079d3a r11_winter_fable: notes
3d2d086 r11_winter_fable: winter dusk on the marsh, first complete draft
```
</details>

<details><summary>r11-flash (2)</summary>

```
61e37f7 r11_winter_flash: program as left when the painter's provider ran out of credits (saved by the integrator)
76fb1a5 Initialize notes for r11_winter_flash with composition concept and Friedrich motifs
```
</details>

<details><summary>r11-study1 (4)</summary>

```
c5429f8 r11_study1: final renders, notes and critique
887a5c4 r11_study1: bark marks stop at the snow, fuller root flare
c7c70e5 r11_study1: modeled trunk, contour, bark plates along the axis, tufts; notes
9861c52 r11_study1: trunk against sky and snow, first full pass
```
</details>

<details><summary>r11-study2 (9)</summary>

```
0c43391 r11_study2: notes
b9ac93f r11_study2: trunk body over the limbs' and root's starts
699538f r11_study2: notes, last round
dceb737 r11_study2: uneven trunk, root under the snow, fallen leaves
fd4f0c4 r11_study2: notes
9fe7934 r11_study2: smooth modeled limbs, fork, lip, grass
cc7e327 r11_study2: scar instead of stub, lip toned
ca08626 r11_study2: base, shadow, snow
f57cf5b r11_study2: first pass
```
</details>

<details><summary>r11-study3 (6)</summary>

```
e1bdbdd r11_study3 notes: friction top five, critique
373769f r11_study3: foot cleaned (crease on the edge, aimed lip touches, no claws), crust on the up side
ee56cb6 r11_study3: crooked limb, dead branch, quieter crests, fuller grass
802c61c r11_study3: crotch, stub break, copses into dry snow, brushed cloud streaks
b86dd6a r11_study3 notes
e8e0c5e r11_study3: trunk in snow against evening sky, first working version
```
</details>

<details><summary>r12-tree1 (7)</summary>

```
6fbf646 r12_tree1 notes: final round
4fe9f69 r12_tree1: sky light on the big wood, denser twig veil
95db35c r12_tree1 notes: log, critique, friction
39bb445 r12_tree1: root buttresses under an uneven snow bank
b895d55 r12_tree1: crows, fallen limb, twig veil, tidy
27c66a2 r12_tree1: broad old oak (seed 1), snow heaps, quieter bark
ba32662 r12_tree1: old oak in snow, first working version
```
</details>

<details><summary>r12-tree2 (5)</summary>

```
d14a211 r12_tree2: notes, friction, critique
019f23e r12_tree2: breaks splintered, dead edges in dead paint, snow modeling stipple, larger fallen limb
bf19df7 r12_tree2: denser oak habit (seed 9), soft stratus banks, clipped snow, stronger far band
9080cd9 r12_tree2: form-laid bole, twig net, snow on limbs, foot drift, grass patches; notes
cf6afcc r12_tree2: first pass (sky, snow, oak, twigs, bark, snow on limbs)
```
</details>

<details><summary>r12-tree3 (3)</summary>

```
e15de32 r12_tree3: veil glaze, final render, notes and critique
6acc3a8 r12_tree3: dead wood, shoots, snow heaps; notes
2b03fb3 r12_tree3: old oak in snow, first working version
```
</details>

<details><summary>r13-base (1)</summary>

```
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r13-tree1 (4)</summary>

```
321280c r13_tree1: sky stipple, woods, leaves, foot; notes and critique
1e840b6 r13_tree1: stag-headed oak, foot, snow; notes
000978f r13_tree1: first program (oak skeleton, stages)
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r13-tree2 (5)</summary>

```
434d60b r13_tree2: branch joins, cool drift face, notes and critique
8e3d357 r13_tree2: stag-head, dead wood, drifts, foot
e82e718 r13_tree2: bark, stump, drift, notes
b035848 r13_tree2: an old oak in winter, first full pass
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r13-tree3 (6)</summary>

```
63df233 r13_tree3: overcast deck, wood tones, more snow; final render
8f8774d r13_tree3: twig net, fallen limb, critique and friction
bafb719 r13_tree3: sky veil, calmer snow, drift crest, far hedges and trees, crotch, notes
d414c53 r13_tree3: staggered limb strokes, snow ridges, drift, twiglets, leaves
edf9fa1 r13_tree3: stag-headed oak in snow, first version
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r14-base (7)</summary>

```
9c0b603 r14 base: descriptive notebook
56f188b r14 base: same
f62ad65 r14 base: the revised workshop notebook (no instructions)
6906e98 r14 base: the corrected workshop notebook
e0cbeff r14 base: the notebook is notes/workshop.md
a2d9ea2 r14 base: the workshop notebook on trees in; the botany note out
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r14-p1 (8)</summary>

```
404df88 r14-p1: painter 1's program, notes and craft notes
9c0b603 r14 base: descriptive notebook
56f188b r14 base: same
f62ad65 r14 base: the revised workshop notebook (no instructions)
6906e98 r14 base: the corrected workshop notebook
e0cbeff r14 base: the notebook is notes/workshop.md
a2d9ea2 r14 base: the workshop notebook on trees in; the botany note out
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r14-p2 (8)</summary>

```
11640fd r14-p2: painter 2's program, notes and craft notes
9c0b603 r14 base: descriptive notebook
56f188b r14 base: same
f62ad65 r14 base: the revised workshop notebook (no instructions)
6906e98 r14 base: the corrected workshop notebook
e0cbeff r14 base: the notebook is notes/workshop.md
a2d9ea2 r14 base: the workshop notebook on trees in; the botany note out
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r14-p3 (8)</summary>

```
2c3ee4a r14-p3: painter 3's program, notes and craft notes
9c0b603 r14 base: descriptive notebook
56f188b r14 base: same
f62ad65 r14 base: the revised workshop notebook (no instructions)
6906e98 r14 base: the corrected workshop notebook
e0cbeff r14 base: the notebook is notes/workshop.md
a2d9ea2 r14 base: the workshop notebook on trees in; the botany note out
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r14a-p1 (5)</summary>

```
346dc1f r14-p1: painter 1's program, notes and craft notes (copied from its plain folder)
6906e98 r14 base: the corrected workshop notebook
e0cbeff r14 base: the notebook is notes/workshop.md
a2d9ea2 r14 base: the workshop notebook on trees in; the botany note out
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r15-base (21)</summary>

```
1b7e32e Comments: two leftover phrasings (assert message, canvas orientation)
4e46b61 .gitignore: drop entries for output directories that don't exist
3feaad4 Comments: handling, stipple, bristle, tally, checkpoint, graphite: present-tense mechanics, current checkpoint format, fixed stale references; neutral test names
605e289 Comments: scene, form, hand, mask, canvas, color, shape, edge, fence, noise, sched: present-tense geometry and API descriptions; neutral fixture names
2ddfdbc Comments: crack, outline, tests, studies, Cargo.toml, peek: present-tense descriptions; neutral fixture names and labels
b849c68 Comments: palette, wet, drying, surface, style, study_spectral in present-tense physical terms; neutral test and study labels
b8f84ac README and guide: --full (2400 px) in every command; minimal program is one swatch ending in end/save; finish shown as an option; removed generators and studies out of the docs
3e39f6a Runner: --full defaults to 2400 px; module docs with a neutral swatch example ending in end/save; history out of comments; neutral test stage names
a024f38 Research notes: drop the dead friedrich_process.md reference and the no-green-data list; paintings lib header
927fdab Remove subject generators: rock and atmos modules, form::Ridge
5144e88 Remove scene and motif studies: sky, stipple, tip, edges, color, strokes, aging, cracks
be6733e Painter's guide: README and notes/guide.md
a9af3ba r15 base: research notes keep the sourced facts; engine-building sections out
37b81d6 r15 base: painters' view only: engine, runner, studies, research; no past paintings, motif modules, dev notes or history in comments
9c0b603 r14 base: descriptive notebook
56f188b r14 base: same
f62ad65 r14 base: the revised workshop notebook (no instructions)
6906e98 r14 base: the corrected workshop notebook
e0cbeff r14 base: the notebook is notes/workshop.md
a2d9ea2 r14 base: the workshop notebook on trees in; the botany note out
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r15-p1 (22)</summary>

```
a2d1e9a r15-p1: program, notes, craft notes
1b7e32e Comments: two leftover phrasings (assert message, canvas orientation)
4e46b61 .gitignore: drop entries for output directories that don't exist
3feaad4 Comments: handling, stipple, bristle, tally, checkpoint, graphite: present-tense mechanics, current checkpoint format, fixed stale references; neutral test names
605e289 Comments: scene, form, hand, mask, canvas, color, shape, edge, fence, noise, sched: present-tense geometry and API descriptions; neutral fixture names
2ddfdbc Comments: crack, outline, tests, studies, Cargo.toml, peek: present-tense descriptions; neutral fixture names and labels
b849c68 Comments: palette, wet, drying, surface, style, study_spectral in present-tense physical terms; neutral test and study labels
b8f84ac README and guide: --full (2400 px) in every command; minimal program is one swatch ending in end/save; finish shown as an option; removed generators and studies out of the docs
3e39f6a Runner: --full defaults to 2400 px; module docs with a neutral swatch example ending in end/save; history out of comments; neutral test stage names
a024f38 Research notes: drop the dead friedrich_process.md reference and the no-green-data list; paintings lib header
927fdab Remove subject generators: rock and atmos modules, form::Ridge
5144e88 Remove scene and motif studies: sky, stipple, tip, edges, color, strokes, aging, cracks
be6733e Painter's guide: README and notes/guide.md
a9af3ba r15 base: research notes keep the sourced facts; engine-building sections out
37b81d6 r15 base: painters' view only: engine, runner, studies, research; no past paintings, motif modules, dev notes or history in comments
9c0b603 r14 base: descriptive notebook
56f188b r14 base: same
f62ad65 r14 base: the revised workshop notebook (no instructions)
6906e98 r14 base: the corrected workshop notebook
e0cbeff r14 base: the notebook is notes/workshop.md
a2d9ea2 r14 base: the workshop notebook on trees in; the botany note out
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r15-p2 (22)</summary>

```
5014d01 r15-p2: program, notes, craft notes
1b7e32e Comments: two leftover phrasings (assert message, canvas orientation)
4e46b61 .gitignore: drop entries for output directories that don't exist
3feaad4 Comments: handling, stipple, bristle, tally, checkpoint, graphite: present-tense mechanics, current checkpoint format, fixed stale references; neutral test names
605e289 Comments: scene, form, hand, mask, canvas, color, shape, edge, fence, noise, sched: present-tense geometry and API descriptions; neutral fixture names
2ddfdbc Comments: crack, outline, tests, studies, Cargo.toml, peek: present-tense descriptions; neutral fixture names and labels
b849c68 Comments: palette, wet, drying, surface, style, study_spectral in present-tense physical terms; neutral test and study labels
b8f84ac README and guide: --full (2400 px) in every command; minimal program is one swatch ending in end/save; finish shown as an option; removed generators and studies out of the docs
3e39f6a Runner: --full defaults to 2400 px; module docs with a neutral swatch example ending in end/save; history out of comments; neutral test stage names
a024f38 Research notes: drop the dead friedrich_process.md reference and the no-green-data list; paintings lib header
927fdab Remove subject generators: rock and atmos modules, form::Ridge
5144e88 Remove scene and motif studies: sky, stipple, tip, edges, color, strokes, aging, cracks
be6733e Painter's guide: README and notes/guide.md
a9af3ba r15 base: research notes keep the sourced facts; engine-building sections out
37b81d6 r15 base: painters' view only: engine, runner, studies, research; no past paintings, motif modules, dev notes or history in comments
9c0b603 r14 base: descriptive notebook
56f188b r14 base: same
f62ad65 r14 base: the revised workshop notebook (no instructions)
6906e98 r14 base: the corrected workshop notebook
e0cbeff r14 base: the notebook is notes/workshop.md
a2d9ea2 r14 base: the workshop notebook on trees in; the botany note out
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r15-p3 (22)</summary>

```
26a235b r15-p3: program, notes, craft notes
1b7e32e Comments: two leftover phrasings (assert message, canvas orientation)
4e46b61 .gitignore: drop entries for output directories that don't exist
3feaad4 Comments: handling, stipple, bristle, tally, checkpoint, graphite: present-tense mechanics, current checkpoint format, fixed stale references; neutral test names
605e289 Comments: scene, form, hand, mask, canvas, color, shape, edge, fence, noise, sched: present-tense geometry and API descriptions; neutral fixture names
2ddfdbc Comments: crack, outline, tests, studies, Cargo.toml, peek: present-tense descriptions; neutral fixture names and labels
b849c68 Comments: palette, wet, drying, surface, style, study_spectral in present-tense physical terms; neutral test and study labels
b8f84ac README and guide: --full (2400 px) in every command; minimal program is one swatch ending in end/save; finish shown as an option; removed generators and studies out of the docs
3e39f6a Runner: --full defaults to 2400 px; module docs with a neutral swatch example ending in end/save; history out of comments; neutral test stage names
a024f38 Research notes: drop the dead friedrich_process.md reference and the no-green-data list; paintings lib header
927fdab Remove subject generators: rock and atmos modules, form::Ridge
5144e88 Remove scene and motif studies: sky, stipple, tip, edges, color, strokes, aging, cracks
be6733e Painter's guide: README and notes/guide.md
a9af3ba r15 base: research notes keep the sourced facts; engine-building sections out
37b81d6 r15 base: painters' view only: engine, runner, studies, research; no past paintings, motif modules, dev notes or history in comments
9c0b603 r14 base: descriptive notebook
56f188b r14 base: same
f62ad65 r14 base: the revised workshop notebook (no instructions)
6906e98 r14 base: the corrected workshop notebook
e0cbeff r14 base: the notebook is notes/workshop.md
a2d9ea2 r14 base: the workshop notebook on trees in; the botany note out
8b6b44a r13 base: no growth model (growth, fir, broadleaf, trees.rs, their programs and docs removed; easel out of the workspace); painters' view only, never merged
```
</details>

<details><summary>r17-base (3)</summary>

```
e2ccc0a replay_clip: --open-hold S shows the bare canvas first (taken out of the rest); usage prints the whole header
acd022a Make easel check a lightweight integrity check
e2cafaa Show progress while reopening paintings
```
</details>

<details><summary>r6-wet (33)</summary>

```
62ace25 Re-record the golden scene and replay hashes for the W1/T fixes (both profiles; non-incremental builds)
8db03f5 Wet glitches W1 and T (notes/glitch.md): a lifting brush's crowded hairs don't heap its stroke end; a blender spreads what it parts
f2d23b1 Merge main (2159c6c: glitch census, bead_cover) into r6-wet
5d3c1aa Merge branch 'main' into r6-wet
b013577 peek: quality 95, 4:4:4 (from main)
9472a0d Merge main into r6-wet (housekeeping)
1cd757b Merge main into r6-wet (optimized [profile.test]): golden and the test-profile replay hash re-recorded for this engine under the new profile (the latter now equals the release hash)
3c34f40 Merge branch 'main' into r6-wet
fc74d03 Review fixes: refuse non-finite or negative film volume in checkpoints (test fails before); studies' line band as a unit normal (resolution-independent); notes
dd8db96 Merge branch 'main' into r6-wet
d769b46 Re-record the golden scene and replay hashes for the merged engine (B10)
29cfb50 Merge main (2a652cf) into r6-wet
de8c202 notes/wet.md §9: the maintenance round (S2, B3, B7, B8, B9, S6); correct the memory figure in wet.md and round6.md; film.rs and exchange.rs in the house line width (rustfmt, no code change)
d0c5271 Re-record the golden scene and replay hashes (both profiles) for B3 and B7
47e7f75 Capillary feed leaves the dirty tip on its hair (B7)
545c0b9 The plough's stiffness counts the set-aside film as itself (B3)
871ce9d Checkpoint: refuse a corrupt surface film (B8)
ef45c5c Wet studies: one shared study module (paintings/src/study.rs); measured numbers identical (diffed)
cbeb42b Wet film restructure (S2, B9): a Layer type owned by wet.rs; film.rs and exchange.rs split out of bristle.rs
1c7ae00 Wet control experiment: study results, repaints, owner sheets
e24d777 Lift-off (a flat rolls onto its chisel edge, a round draws to its point, hairs trail as the handle rises, over the release ramp); study_wet_control and the owner's control sheets (main, r6-wet, r6-wet + lift-off)
a0f4949 Merge branch 'main' into r6-wet
29a6338 checkpoint test: corrupt-drawing offset accounts for the version 8 film block after the drawing
c073f65 Merge branch 'main' into r6-wet
2b2d8f9 notes/wet.md: review fix (conservation), before/after crops; checkpoint renumbering pending main
9cd0f52 Wet on wet: conserve paint through a film set aside mid-stroke (review fix)
5fb57e6 Wet on wet, third pass: a tip layer on each bristle
92feb8d Wet on wet, second pass: notes (lab failures one by one, veins, l5_near floor pass), study_wet_lab panel 6, evidence
896a7b7 Wet on wet, second pass: lab failures, veins, blending
96f5d44 Merge branch 'main' into r6-wet
849af30 Wet on wet: notes (audit, change, evidence), sketchbook: wet, tacky or dry by the edge you want, easel guide
c8c6017 Wet on wet: a surface film per wet pixel, stirring, a plough floor
6254051 Wet-on-wet audit: study_wet (four gestures over open, setting, tacky, dry paint) and findings
```
</details>

<details><summary>r7-arm1 (9)</summary>

```
3c51bf0 arm1: The Old Willow at Evening, finished; renders and notes
2bc9f03 arm1: fuller crown, water lines
666b6f5 arm1: bank grass, bole straightened and seated
e1332a1 arm1: the bole and rods
d1bb201 arm1: far shore, reflection, bank body
f71ec8b arm1: evening streaks
c198c6f arm1: sky stippled
8e43f64 arm1: sky and water first layer
be8261b arm1: willows, drawing and brown lay-in
```
</details>

<details><summary>r7-arm2 (6)</summary>

```
fe38d44 Round 7 arm 2: Two Poplars at a Pond, Evening (pond_poplars), renders and notes
cc13a3e pond_poplars: tapered crown core, snag top, reeds on their own seed
3c64362 pond_poplars: moon before clouds, fused strands, foreground tufts, water drags, trunk images
65b9360 pond_poplars: bank crest cut in, shore grass, reeds in the shallows, no ploughed chevrons
a9c9f9e pond_poplars: branch-built poplars, bank after water, no mist
afb1d69 pond_poplars: first draft
```
</details>

<details><summary>r7-arm3 (7)</summary>

```
f4af482 arm3: Evening on the Bodden: renders (1000, 3200) and notes
d26f4b2 arm3: bodden, finished (lose, varnish, cracks, relief)
50b64a1 arm3: bodden, sitting 6 (calm lines, grass and reeds)
0d401fa arm3: bodden, sitting 5 (spire, mills, water second layer, bank)
a4ca5ce arm3: bodden, sitting 4 (clouds, far shore and town)
d92935b arm3: bodden, sittings 2-3 (sky stipple)
493d37c arm3: bodden, sitting 1 (drawing, lay-in, sky and water first layers)
```
</details>

<details><summary>r7-paint-wet (33)</summary>

```
8e3fa81 evening_lake: notes, Alice sheet (lossless), evidence crops
bf26caa evening_lake: finished (shore, stones, figure, moon, glaze, varnish)
30d3687 evening_lake: sitting 3 (fir promontory, spit, front row)
6a50f4e evening_lake: sitting 2 (range, sky, bank, lake, mist)
a266664 evening_lake: drawing and dead color
9472a0d Merge main into r6-wet (housekeeping)
1cd757b Merge main into r6-wet (optimized [profile.test]): golden and the test-profile replay hash re-recorded for this engine under the new profile (the latter now equals the release hash)
3c34f40 Merge branch 'main' into r6-wet
fc74d03 Review fixes: refuse non-finite or negative film volume in checkpoints (test fails before); studies' line band as a unit normal (resolution-independent); notes
dd8db96 Merge branch 'main' into r6-wet
d769b46 Re-record the golden scene and replay hashes for the merged engine (B10)
29cfb50 Merge main (2a652cf) into r6-wet
de8c202 notes/wet.md §9: the maintenance round (S2, B3, B7, B8, B9, S6); correct the memory figure in wet.md and round6.md; film.rs and exchange.rs in the house line width (rustfmt, no code change)
d0c5271 Re-record the golden scene and replay hashes (both profiles) for B3 and B7
47e7f75 Capillary feed leaves the dirty tip on its hair (B7)
545c0b9 The plough's stiffness counts the set-aside film as itself (B3)
871ce9d Checkpoint: refuse a corrupt surface film (B8)
ef45c5c Wet studies: one shared study module (paintings/src/study.rs); measured numbers identical (diffed)
cbeb42b Wet film restructure (S2, B9): a Layer type owned by wet.rs; film.rs and exchange.rs split out of bristle.rs
1c7ae00 Wet control experiment: study results, repaints, owner sheets
e24d777 Lift-off (a flat rolls onto its chisel edge, a round draws to its point, hairs trail as the handle rises, over the release ramp); study_wet_control and the owner's control sheets (main, r6-wet, r6-wet + lift-off)
a0f4949 Merge branch 'main' into r6-wet
29a6338 checkpoint test: corrupt-drawing offset accounts for the version 8 film block after the drawing
c073f65 Merge branch 'main' into r6-wet
2b2d8f9 notes/wet.md: review fix (conservation), before/after crops; checkpoint renumbering pending main
9cd0f52 Wet on wet: conserve paint through a film set aside mid-stroke (review fix)
5fb57e6 Wet on wet, third pass: a tip layer on each bristle
92feb8d Wet on wet, second pass: notes (lab failures one by one, veins, l5_near floor pass), study_wet_lab panel 6, evidence
896a7b7 Wet on wet, second pass: lab failures, veins, blending
96f5d44 Merge branch 'main' into r6-wet
849af30 Wet on wet: notes (audit, change, evidence), sketchbook: wet, tacky or dry by the edge you want, easel guide
c8c6017 Wet on wet: a surface film per wet pixel, stirring, a plough floor
6254051 Wet-on-wet audit: study_wet (four gestures over open, setting, tacky, dry paint) and findings
```
</details>

<details><summary>r7-piles (8)</summary>

```
83e8360 piles: lead with painter-named piles (colors=); auto-picked piles from a formula only as a fallback (principles)
566a4ab Merge main (r7-edges) into r7-piles: keep both install lines and both guide sections
6ee379b piles.rs: clippy (no behavior change)
429f1ba Piles study: evening_lake sky and lake from piles vs the formula (blind A/B lossless sheet notes/piles/piles_alice.png, plain paintings, the log and its diff, key); notes/piles.md; sketchbook: mix piles, don't paint a formula
31468b2 Piles: easel tests (a sky from piles steps, replays exactly and differs from the formula; the painter's own unmixed piles in a stipple; option errors)
cc11e3a Piles by paint: piles chosen from a field are clustered on the paint each stroke needs (aimed over what is under it) and a stroke picks the pile nearest its need (one bank over a dark sky and a warm glow gets two paints, not one violet pile over both); piles{} takes the pass it mixes for (hand, tool, coverage, load) for the aim; guide section; test
fd8c471 Piles (easel): piles(field, {n, over, colors, pal, medium, aim, coats, mix, overlap, patch, vary, batch, dirty, seed}) mixes a pile set looking at the canvas (hand time: a remix per pile); color=<piles> in work loads strokes from the piles, elsewhere reads the stepped field; p:colors(), p:recipes(), p:at(), p:pick(), p:field()
0dff9b9 Piles (paint): PileSet chooses a few piles along a color field's range, knifes each once (aimed over the underlayer, with a miss), picks a pile per stroke with a ragged wandering boundary, and re-knifes batches per part of the picture; Handling::piles (small hook in finish_plan, old behavior unchanged)
```
</details>

<details><summary>r7-python (2)</summary>

```
4047841 python_friedrich: The Chapel Gable at Evening, final renders (1000, 3200) and notes
5bf679b python_friedrich: control experiment, first working painter (gable, figure, sky, sea)
```
</details>

<details><summary>r7-texture (1)</summary>

```
2e9e4c6 Texture forensics (Round 7): PAINT_TEXOFF switches (default off) for every pixel-scale texture source, 28 blind variants on four windows, metrics script and notes/round7/texture.md
```
</details>

<details><summary>r8-arm1 (11)</summary>

```
16768f4 r8 arm1: final renders
d9a3b07 r8 arm1: notes
8354ac6 r8 arm1: stones, prints, deeper evening
da6e631 r8 arm1: notes
b4840f7 r8 arm1: figure modeled, finish
649b6eb r8 arm1: ice, drifts
c81a2e2 r8 arm1: moon, church, glaze
963fc3f r8 arm1: willows, cross, figure, prints, grass
0f5adf1 r8 arm1: oak
f8483af r8 arm1: sky, hills, pond, snow lay-in
024b1a4 r8 arm1: notes skeleton
```
</details>

<details><summary>r8-arm2 (5)</summary>

```
25ee859 winter_ruin: final renders and notes
bd0afac winter_ruin: bank crests, crow, hill, mullion
aaf3806 winter_ruin: spruce cores, oak bark and roots, churchyard, no corner cracks
f817c80 winter_ruin: spruces, boulder, ruin, mist reworked; first full render; notes
3539ce4 winter_ruin: first complete pass
```
</details>

<details><summary>r8-arm3 (8)</summary>

```
d867285 arm3: final renders and notes
b7c861f arm3: trunk rim, snow veil, finish; notes
c2a8ac6 arm3: sky veil, finish
fa79776 arm3: grass, drifts
4e93fc4 arm3: path, figure, strata, ice, reeds
1b6ac27 arm3: wood, church, oak, firs
e67b372 arm3: pond, sky, snow, far hills
16ace09 arm3: notes skeleton
```
</details>

<details><summary>r9-arm1 (9)</summary>

```
e90a7ce r9 arm1: final renders and notes
20863c9 r9 arm1: swells kept clear of the trunks
e1f44a3 r9 arm1: wind-drift swells
4f96856 r9 arm1: drifts dragged across the feet, glaze even on trunks
675d731 r9 arm1: finish
e9bf52e r9 arm1: notes, crows, grass, moon
558372a r9 arm1: track, walker
54ed9f4 r9 arm1: willows
f897599 r9 arm1: winter willows in progress
```
</details>

<details><summary>r9-arm2 (6)</summary>

```
0b0fab2 r9 arm2: final render, notes and friction
28bc4f0 r9 arm2: boat hull in side view, grass in patches
a442dab r9 arm2: willow heads, cleft, drifts, fence, reeds, town roofs, gentler cracks
ee0b716 r9 arm2: first full render and notes
6a66f4d r9 arm2: willow path, ice, boat, shadows as glaze
93fd01f r9 arm2: Winter Morning on the Ryck, first pass
```
</details>

<details><summary>r9-arm3 (8)</summary>

```
4a4b3a8 r9 arm3: final render and notes
cb07b7e r9 arm3: refine oak foot, hedges, stones
b7316e1 r9 arm3: notes
418ae98 r9 arm3: finished, 1000px
d3b46b8 r9 arm3: particulars
18105b0 r9 arm3: stones
1bf32bb r9 arm3: oak, cross, walker
fba4796 r9 arm3: sky, snow, far wood
```
</details>

<details><summary>wet-before (2)</summary>

```
1e9737d ab_r2_coast: skip the two NaN marks today's engine refuses; PORTS.md: r2 coast skips, r1 winter not rendered
169d45c Port every painting to today's API for the wet-merge before/after (the same files on wet-before and wet-merge; changes per painting in notes/wet_merge/PORTS.md)
```
</details>

<details><summary>wet-merge (37)</summary>

```
e7956e5 notes/wet_merge/README.md: every painting on main's engine and on the wet merge
8db9f50 ab_r2_coast: skip the two NaN marks today's engine refuses; PORTS.md: r2 coast skips, r1 winter not rendered
10ad936 Port every painting to today's API for the wet-merge before/after (the same files on wet-before and wet-merge; changes per painting in notes/wet_merge/PORTS.md)
84cb412 Merge main (4abe5b4) into the wet-on-wet engine
62ace25 Re-record the golden scene and replay hashes for the W1/T fixes (both profiles; non-incremental builds)
8db03f5 Wet glitches W1 and T (notes/glitch.md): a lifting brush's crowded hairs don't heap its stroke end; a blender spreads what it parts
f2d23b1 Merge main (2159c6c: glitch census, bead_cover) into r6-wet
5d3c1aa Merge branch 'main' into r6-wet
b013577 peek: quality 95, 4:4:4 (from main)
9472a0d Merge main into r6-wet (housekeeping)
1cd757b Merge main into r6-wet (optimized [profile.test]): golden and the test-profile replay hash re-recorded for this engine under the new profile (the latter now equals the release hash)
3c34f40 Merge branch 'main' into r6-wet
fc74d03 Review fixes: refuse non-finite or negative film volume in checkpoints (test fails before); studies' line band as a unit normal (resolution-independent); notes
dd8db96 Merge branch 'main' into r6-wet
d769b46 Re-record the golden scene and replay hashes for the merged engine (B10)
29cfb50 Merge main (2a652cf) into r6-wet
de8c202 notes/wet.md §9: the maintenance round (S2, B3, B7, B8, B9, S6); correct the memory figure in wet.md and round6.md; film.rs and exchange.rs in the house line width (rustfmt, no code change)
d0c5271 Re-record the golden scene and replay hashes (both profiles) for B3 and B7
47e7f75 Capillary feed leaves the dirty tip on its hair (B7)
545c0b9 The plough's stiffness counts the set-aside film as itself (B3)
871ce9d Checkpoint: refuse a corrupt surface film (B8)
ef45c5c Wet studies: one shared study module (paintings/src/study.rs); measured numbers identical (diffed)
cbeb42b Wet film restructure (S2, B9): a Layer type owned by wet.rs; film.rs and exchange.rs split out of bristle.rs
1c7ae00 Wet control experiment: study results, repaints, owner sheets
e24d777 Lift-off (a flat rolls onto its chisel edge, a round draws to its point, hairs trail as the handle rises, over the release ramp); study_wet_control and the owner's control sheets (main, r6-wet, r6-wet + lift-off)
a0f4949 Merge branch 'main' into r6-wet
29a6338 checkpoint test: corrupt-drawing offset accounts for the version 8 film block after the drawing
c073f65 Merge branch 'main' into r6-wet
2b2d8f9 notes/wet.md: review fix (conservation), before/after crops; checkpoint renumbering pending main
9cd0f52 Wet on wet: conserve paint through a film set aside mid-stroke (review fix)
5fb57e6 Wet on wet, third pass: a tip layer on each bristle
92feb8d Wet on wet, second pass: notes (lab failures one by one, veins, l5_near floor pass), study_wet_lab panel 6, evidence
896a7b7 Wet on wet, second pass: lab failures, veins, blending
96f5d44 Merge branch 'main' into r6-wet
849af30 Wet on wet: notes (audit, change, evidence), sketchbook: wet, tacky or dry by the edge you want, easel guide
c8c6017 Wet on wet: a surface film per wet pixel, stirring, a plough floor
6254051 Wet-on-wet audit: study_wet (four gestures over open, setting, tacky, dry paint) and findings
```
</details>

<details><summary>amnesia-coast (11)</summary>

```
2a157cb fresh2_coast: notes (friction, critique) final
cf4856f fresh2_coast: weathered poles, rope coil on a peg, stronger ripples
a9c844f fresh2_coast: underpainting follows the sea, clean blender
0c3d46e fresh2_coast: clamp glaze traces (black-stroke blowup)
3ac3dd8 fresh2_coast: smooth veil and halo glazes, fewer pits
fc032aa fresh2_coast: sails, figure colors, brushed veil, thresholded reflection mask
0be39ec fresh2_coast: reflections glazed, ripple fields, transparent shadows, finer cracks
af2ec94 fresh2_coast: horizon cut in by hand; notes
15b4d36 fresh2_coast: underpainting, erratic as a block, mesh net, calmer sea
6445fd9 fresh2_coast: first complete draft (Rügen shore before sunrise)
0552e05 Amnesia round 2 (coast): clean slate, no existing paintings or figure motifs
```
</details>

<details><summary>amnesia-mountains (12)</summary>

```
a852f3e fresh2_mountains: notes final
07396c5 fresh2_mountains: mid range buttresses instead of curtains; critique
a3fd7bb fresh2_mountains: far range a grayer violet
7aff312 fresh2_mountains: violet far range (smalt + vermilion family), notes
2a6d04d fresh2_mountains: waning crescent, ranges stippled more
039967f fresh2_mountains: near range kept off the knoll; notes
3fa11af fresh2_mountains: cool family for ranges, distant spruces, grass attack, ragged mats
0267ff2 fresh2_mountains: mid range deeper, foreground outcrop, clipped blends, darker stones
b931a4c fresh2_mountains: mist off the knoll, brushed veils, clouds laid in, birds, chapel, cracks
d7a6ff6 fresh2_mountains: underpainting under ranges, crest tufts, spruce tips, notes
4711bca fresh2_mountains: dawn in the Riesengebirge, first complete version
083d96c Amnesia round 2 (mountains): clean slate, no existing paintings or figure motifs
```
</details>

<details><summary>amnesia-winter (15)</summary>

```
fa772d2 fresh2_winter: notes numbering
6bdefd2 fresh2_winter: final notes
aa707bf fresh2_winter: violet in the snow shadows; notes
ebb4b4c fresh2_winter: rose afterglow band, far range, crows
41a3647 fresh2_winter: stones, shadows judged against the canvas
442985f fresh2_winter: crescent faces the afterglow
e5a6048 fresh2_winter: spruce spires, snow streaks, footing
2e65142 fresh2_winter: drift shadows, footprints
97275b4 fresh2_winter: ruin foot, oak foot and shadow, figure, brook banks
7e09828 fresh2_winter: stratus, moon, bark, snow line
2191381 fresh2_winter: fence, veil, notes
2b74544 fresh2_winter: ruin details, moon crescent, fixes
cc06674 fresh2_winter: gnarled oak, perspective brook, grass patches
ca9fa99 fresh2_winter: first complete pass
47a880f Amnesia round 2 (winter): clean slate, no existing paintings or figure motifs
```
</details>

<details><summary>easel3-free (23)</summary>

```
a6b7e2c easel3_free: notes updated after figure rescue
7e72745 easel3_free: figure kept out of the sea veil and repainted; final varnish
ff962ff easel3_free: sea veil and fresh glints; final varnish
dfaf10b easel3_free: notes, final renders
33fde83 easel3_free: final varnish, gentler relief
1ce467d easel3_free: figure shoulders, dead oak roots, heather toned
04922ab easel3_free: stones sunk in grass; varnish
eb9f2d7 easel3_free: staff, varnish
3ac0f9d easel3_free: oak roots in turf, heather sprigs, tufts over stones
4852446 easel3_free: cloud wisps
f938f82 easel3_free: dolmen particulars
ea57c75 easel3_free: glints kept off the barrow
bbee8a1 easel3_free: foreground grass, stones, stalks
6ac85b7 easel3_free: moon, star, sails
c1d11e7 easel3_free: figure; glints kept off the stones
84cfd87 easel3_free: path, heather, dune grass
51a619c easel3_free: sea glaze and glints
c925d75 easel3_free: oaks
44bde20 easel3_free: sea, land, dolmen silhouette
5742eb2 easel3_free: sky
93d61ee easel3_free: notes started
0830b64 Amnesia round 3: drop study_scene (uses the shared figures) and motifs notes
33f6c18 Amnesia round 3 (free): clean slate at the easel
```
</details>

<details><summary>easel3-green (16)</summary>

```
e5b34a2 easel3_green notes: critique
331727c easel3_green notes: last stages
6b9d223 easel3_green: distant village church; varnish
bea87e0 easel3_green: stones modeled with filbert and blended
521fb98 easel3_green notes: refinement, friction, critique
d805a7f easel3_green: groves varied, meadow flowers, sorrel, seed grasses; varnish
ca608ed easel3_green: lobed bladed oak shadow, tufts
e931bc0 easel3_green: rebuilt oak (denser crown, leaf-mark edges, dead crown), crest seam faded
1a2401d easel3_green notes
37f07d4 easel3_green: fix crest smear, soften shadow, varnish
722e098 easel3_green: figure, sheep, stones, thistle
5f72936 easel3_green: meadow grass
7f32366 easel3_green: oak, track, foreground
63870b4 easel3_green: sky, ranges, plain, groves
41b68db Amnesia round 3: drop study_scene (uses the shared figures) and motifs notes
6c23a5f Amnesia round 3 (green): clean slate at the easel
```
</details>

<details><summary>easel3-near (15)</summary>

```
ffaa0f2 easel3_near: final renders and notes
f7a47d3 easel3_near: lit bracken fronds, final varnish
121489a easel3_near: bracken at the foot, wood glaze, birch bark, varnish
22f24da easel3_near: notes
bfcca24 easel3_near: complete first state, varnished
c04fc64 easel3_near: values, young spruces
158c9fe easel3_near: foreground
2404248 easel3_near: ledges
92e4657 easel3_near: grass, bracken
fc3db18 easel3_near: birch, floor, shadows
d1daeb8 easel3_near: rock color, grain, cracks
8216ca8 easel3_near: rock v4, wood edge
5459d80 easel3_near: sky, far wood, rock, spruces
8cf7907 Amnesia round 3: drop study_scene (uses the shared figures) and motifs notes
f9e55f4 Amnesia round 3 (near): clean slate at the easel
```
</details>

<details><summary>easel4-free (17)</summary>

```
7f39937 easel4_free: final 3200px render
1329620 easel4_free: notes, final 1000px render
ebb7283 easel4_free: dolmen back stones
289c404 easel4_free: pointed junipers, repainted rocks, lighter fg glaze, dimmer puddles
cee8077 easel4_free: puddles, path-edge grass, oak roots
491e3b8 easel4_free: stones repainted, calmer relief
8c329cc easel4_free: angular twigs, bark, drop sky veil
a784ac9 easel4_free: notes
b660a19 easel4_free: foreground particulars, varnish; notes draft
3c44869 easel4_free: glaze, varnish
acde1be easel4_free: rocks, grass, figure, ravens
7a183cf easel4_free: town, moon, path
cd86347 easel4_free: dolmen
117d1d3 easel4_free: oak
059bd6b easel4_free: sky, clouds, ground
916ef2b easel4_free: canvas and underdrawing
e5cfa8b Amnesia round 4 (free): clean slate at the easel
```
</details>

<details><summary>easel4-green (7)</summary>

```
38bcf86 easel4_green: final notes
6fdadbb easel4_green: foreground meadow blades, notes
549d0cc easel4_green: foreground particulars, value band, varnish
e84f36d easel4_green: complete first pass
2bc1fb3 easel4_green: woods, oak, stone, figure
7dec728 easel4_green: drawing, sky, ranges, valley, river
16152c9 Amnesia round 4 (green): clean slate at the easel
```
</details>

<details><summary>easel4-near (6)</summary>

```
5761454 easel4_near: retouch the stones' feet; notes
c314680 easel4_near notes
fbf54cf easel4_near: particulars, snow on the spruce, varnish
aabbb34 easel4_near: boulder, spruce, stump, shadows, grass
0a5bb0b easel4_near: drawing, sky, snow, wood edge
1cbed83 Amnesia round 4 (near): clean slate at the easel
```
</details>

<details><summary>loop1-green (2)</summary>

```
126f3f8 Loop 1 green: grouped field trees, muted plain/hill/clouds, figure and boulder restated
e7f299e Loop 1: start from the round-4 green session
```
</details>

<details><summary>loop1-near (3)</summary>

```
357c8d2 l1_near notes: 3200 check
e9febf2 Loop 1 near: thin drifts from the stone's foot line, modulated shadow band, wood interior drawn
7588e4e Loop 1: start from the round-4 near session
```
</details>

<details><summary>loop2-green (3)</summary>

```
1258392 l2_green notes: 3200 halo observation
93a01e0 l2_green: stilled evening sky, oak crown restated by clumps, figure/stone contact, evening glaze on land
917958d Loop 2: start from the loop-1 green session
```
</details>

<details><summary>loop2-near (3)</summary>

```
543eae2 l2_near: renders and 3200 notes
cc806b1 l2_near: continuous drift bank, contact shade into the crease, comb broken, wood floor opened
bc7fb78 Loop 2: start from the loop-1 near session
```
</details>

<details><summary>loop3-green (2)</summary>

```
3ab6278 loop3-green: halos fixed (exact motif masks in chunks 23/24/28, sampled-ground repaint around the stone and trunk); notes
508ef3c loop3-green: start from the previous session
```
</details>

<details><summary>loop3-near (4)</summary>

```
58d26cb l3_near notes: 3200 check (branchlet drips, seam)
108dd50 Loop 3 near: stump shadow at its true size (tapered, fading), no belly shadow before the boulder, lopsided spruce with hanging branchlets and snow in lumps, weathered stump break, wood specks hatched out
2c51081 Merge main (halo fix) into loop3-near
fabfb76 Loop 3: start from the loop-2 near session
```
</details>

<details><summary>loop4-near (2)</summary>

```
d301946 loop4-near: wood recedes into air (graded veil + foot mist), cooler foot-bank glaze; notes
0ead1f1 loop4-near: start from the previous session
```
</details>

<details><summary>loop5-near (2)</summary>

```
f387ece l5_near: wood and young spruce regrown with fir_wood/fir, foot of wood without ledge, stump break redrawn, brambles removed
c2842bd Loop 5: start from loop-3 near (its best)
```
</details>

<details><summary>detached 2a157cb (11, first 20)</summary>

```
2a157cb fresh2_coast: notes (friction, critique) final
cf4856f fresh2_coast: weathered poles, rope coil on a peg, stronger ripples
a9c844f fresh2_coast: underpainting follows the sea, clean blender
0c3d46e fresh2_coast: clamp glaze traces (black-stroke blowup)
3ac3dd8 fresh2_coast: smooth veil and halo glazes, fewer pits
fc032aa fresh2_coast: sails, figure colors, brushed veil, thresholded reflection mask
0be39ec fresh2_coast: reflections glazed, ripple fields, transparent shadows, finer cracks
af2ec94 fresh2_coast: horizon cut in by hand; notes
15b4d36 fresh2_coast: underpainting, erratic as a block, mesh net, calmer sea
6445fd9 fresh2_coast: first complete draft (Rügen shore before sunrise)
0552e05 Amnesia round 2 (coast): clean slate, no existing paintings or figure motifs
```
</details>

<details><summary>detached a852f3e (12, first 20)</summary>

```
a852f3e fresh2_mountains: notes final
07396c5 fresh2_mountains: mid range buttresses instead of curtains; critique
a3fd7bb fresh2_mountains: far range a grayer violet
7aff312 fresh2_mountains: violet far range (smalt + vermilion family), notes
2a6d04d fresh2_mountains: waning crescent, ranges stippled more
039967f fresh2_mountains: near range kept off the knoll; notes
3fa11af fresh2_mountains: cool family for ranges, distant spruces, grass attack, ragged mats
0267ff2 fresh2_mountains: mid range deeper, foreground outcrop, clipped blends, darker stones
b931a4c fresh2_mountains: mist off the knoll, brushed veils, clouds laid in, birds, chapel, cracks
d7a6ff6 fresh2_mountains: underpainting under ranges, crest tufts, spruce tips, notes
4711bca fresh2_mountains: dawn in the Riesengebirge, first complete version
083d96c Amnesia round 2 (mountains): clean slate, no existing paintings or figure motifs
```
</details>

<details><summary>detached fa772d2 (15, first 20)</summary>

```
fa772d2 fresh2_winter: notes numbering
6bdefd2 fresh2_winter: final notes
aa707bf fresh2_winter: violet in the snow shadows; notes
ebb4b4c fresh2_winter: rose afterglow band, far range, crows
41a3647 fresh2_winter: stones, shadows judged against the canvas
442985f fresh2_winter: crescent faces the afterglow
e5a6048 fresh2_winter: spruce spires, snow streaks, footing
2e65142 fresh2_winter: drift shadows, footprints
97275b4 fresh2_winter: ruin foot, oak foot and shadow, figure, brook banks
7e09828 fresh2_winter: stratus, moon, bark, snow line
2191381 fresh2_winter: fence, veil, notes
2b74544 fresh2_winter: ruin details, moon crescent, fixes
cc06674 fresh2_winter: gnarled oak, perspective brook, grass patches
ca9fa99 fresh2_winter: first complete pass
47a880f Amnesia round 2 (winter): clean slate, no existing paintings or figure motifs
```
</details>

<details><summary>detached fa772d2 (15, first 20)</summary>

```
fa772d2 fresh2_winter: notes numbering
6bdefd2 fresh2_winter: final notes
aa707bf fresh2_winter: violet in the snow shadows; notes
ebb4b4c fresh2_winter: rose afterglow band, far range, crows
41a3647 fresh2_winter: stones, shadows judged against the canvas
442985f fresh2_winter: crescent faces the afterglow
e5a6048 fresh2_winter: spruce spires, snow streaks, footing
2e65142 fresh2_winter: drift shadows, footprints
97275b4 fresh2_winter: ruin foot, oak foot and shadow, figure, brook banks
7e09828 fresh2_winter: stratus, moon, bark, snow line
2191381 fresh2_winter: fence, veil, notes
2b74544 fresh2_winter: ruin details, moon crescent, fixes
cc06674 fresh2_winter: gnarled oak, perspective brook, grass patches
ca9fa99 fresh2_winter: first complete pass
47a880f Amnesia round 2 (winter): clean slate, no existing paintings or figure motifs
```
</details>

<details><summary>detached fb3e092 (8, first 20)</summary>

```
fb3e092 r10_winter_a: final render notes
392989c r10_winter_a: broken snag, boulder uprights, critique
17929d6 r10_winter_a: light through the dolmen, calmer stone, notes
89a8296 r10_winter_a: crescent moon mask, limb reloads, splinters
419ab46 r10_winter_a: figure, footprints, subtle drift crests
d3646cb r10_winter_a: pointed tips, drift crests, softer cracks, notes
abbdbeb r10_winter_a: dolmen modeling, bark, grass, cracks
9c6dddc r10_winter_a: first complete pass (dolmen in snow at dusk), own oak habit
```
</details>

<details><summary>detached 3195bac (4, first 20)</summary>

```
3195bac r10_winter_b: notes, friction list, critique
90578c4 r10_winter_b: perspective drifts, snow palette family, spruce masses, stone planes
fd9c042 r10_winter_b: fir wood, spruces, stone, village, quieter cracks; notes
01fc5b7 r10_winter_b: first complete painting
```
</details>

<details><summary>detached 1cab236 (8, first 20)</summary>

```
1cab236 notes/r10_summer.md: last friction item, render times
a05de79 r10_summer: dock leaves lit
ff301a1 r10_summer: figures' heads and shawl, corner plants
b4632b7 r10_summer: cloud palette, thinner sky underpainting; notes: method, friction, critique
c2657c3 r10_summer: horses, rut grain, thistle, quieter far grass
6dda351 r10_summer: trunk as a modeled column, shadow laid into the meadow, ovate lobed crown, swallows
920af44 r10_summer: clouds, track, plants, crown masses; notes
84ffaf2 r10_summer: first passes of the summer lime painting, notes
```
</details>

<details><summary>detached 199b80d (132, first 20)</summary>

```
199b80d evening_lake: notes, Alice sheet (lossless), evidence crops
de7083e evening_lake: finished (shore, stones, figure, moon, glaze, varnish)
7f4dfbe evening_lake: sitting 3 (fir promontory, spit, front row)
f6c71cc evening_lake: sitting 2 (range, sky, bank, lake, mist)
c0090f1 evening_lake: drawing and dead color
6c3169f Merge main into r6-wet (housekeeping)
5d0e40b Merge r6-house: 'owner' -> 'Alice' in notes and comments; tally::path_len -> path::length (identical math); anonymity lines say 'the user's real name'
df8c306 Anonymity lines: 'the user's real name' (Alice is the pseudonym)
0832453 Replace tally::path_len with path::length (identical float ops)
f321631 Refer to the project's owner as Alice in prose and comments
abacd02 Merge main into r6-wet (optimized [profile.test]): golden and the test-profile replay hash re-recorded for this engine under the new profile (the latter now equals the release hash)
9c0294b Tests: optimized, non-incremental [profile.test] (the suite runs in ~1 min instead of ~10); golden re-recorded for it (stable across runs); two test tiers documented in notes/workflow.md
3e6a3e6 Merge branch 'main' into r6-wet
8116d03 Review fixes: refuse non-finite or negative film volume in checkpoints (test fails before); studies' line band as a unit normal (resolution-independent); notes
089c9de surface: conserve_total pins until no new pixel crosses its bound (was capped at 8 rounds; a 1024-pixel cascade left pixels below the floor); regression test fails before, passes after; benchmarks identical
d594d3e Thermos: status at the end of the maintenance round
accfd87 Merge branch 'main' into r6-wet
3060281 Release profile: incremental = false, codegen-units = 1 (deterministic codegen; two clean builds in separate target dirs now give byte-identical binaries and benchmark renders; replay hashes unchanged)
45ffc79 Re-record the golden scene and replay hashes for the merged engine (B10)
4933673 Merge main (8c5bf96) into r6-wet
```
</details>

<details><summary>detached 6244bdb (110, first 20)</summary>

```
6244bdb Alice's review of Evening at a Mountain Lake; the plain painting (1000, 3200, aged 3200)
c6880b1 Merge r6-glitch: glitch census (detector scripts/glitch.py, catalog notes/glitch.md), pinhole fix (wet::bead_cover), four sketchbook pitfalls
b1349ec Round 7: Evening at a Mountain Lake (wet engine) for Alice: sheets (lossless), fresh vs aged, painter's notes, two blind critiques
392f2b7 Easel guide: easel run --dump-surface and the glitch detector
cab4f1c Glitch census: scripts/glitch.py (specks, pinholes, flecks, lines, mottle; calibrated on the owner's passages), notes/glitch.md (catalog, causes, status, wet-stream write-up), lossless sheets notes/glitch/alice_census.png and alice_fixes.png, four recipe pitfalls in the sketchbook
7820422 easel look: JPEG quality 95 with full-resolution color via jpeg-encoder (the image crate always halves color and was at 88)
5fe9154 peek: JPEG quality 95 with full-resolution color (was 80 with half-resolution color, which smeared thin strokes)
3ea0021 Craquelure is part of the standard finish (Alice): varnish; cracks{}; relief()
e832497 Glitch P1: paint on a sliver of a pixel can't stand taller than half the pixel is wide (wet::bead_cover at the bake and in the wet look); the lab 2 lime's pale pinholes at 3200 were 50-130 µm of dark paint leveled onto a pointed tool's hair-sized cover share. Test fails before (33 pixels), passes after. easel run --dump-surface (height µm, for diagnostics). Benchmarks at 1000 change slightly (l5_near 487 px > 4 levels, l3_green 4244, hedgerow fringes darker); golden unchanged
d25181e Merge r6-pencil: the rock outline isn't the pencil (it's the seat_rock contact and cast glazes); notes only
ee47bc6 Pencil check: the outline around the rocks is not the underdrawing (1/255 at the rock edges with and without it); it is the contact glaze and the blurred cast glaze spilling onto the rock's foot. Evidence sheet for Alice + notes for the glitch stream; no code change
5d0e40b Merge r6-house: 'owner' -> 'Alice' in notes and comments; tally::path_len -> path::length (identical math); anonymity lines say 'the user's real name'
df8c306 Anonymity lines: 'the user's real name' (Alice is the pseudonym)
0832453 Replace tally::path_len with path::length (identical float ops)
f321631 Refer to the project's owner as Alice in prose and comments
9c0294b Tests: optimized, non-incremental [profile.test] (the suite runs in ~1 min instead of ~10); golden re-recorded for it (stable across runs); two test tiers documented in notes/workflow.md
089c9de surface: conserve_total pins until no new pixel crosses its bound (was capped at 8 rounds; a 1024-pixel cascade left pixels below the floor); regression test fails before, passes after; benchmarks identical
d594d3e Thermos: status at the end of the maintenance round
3060281 Release profile: incremental = false, codegen-units = 1 (deterministic codegen; two clean builds in separate target dirs now give byte-identical binaries and benchmark renders; replay hashes unchanged)
8c5bf96 Merge r6-maint-a: thermos B1 B2 B4 B5 B6 S1 S4 S6 (one timed-pass runner, one hand-clock wrapper, sitting palette); hand-time-off output identical
```
</details>

<details><summary>detached 199b80d (132, first 20)</summary>

```
199b80d evening_lake: notes, Alice sheet (lossless), evidence crops
de7083e evening_lake: finished (shore, stones, figure, moon, glaze, varnish)
7f4dfbe evening_lake: sitting 3 (fir promontory, spit, front row)
f6c71cc evening_lake: sitting 2 (range, sky, bank, lake, mist)
c0090f1 evening_lake: drawing and dead color
6c3169f Merge main into r6-wet (housekeeping)
5d0e40b Merge r6-house: 'owner' -> 'Alice' in notes and comments; tally::path_len -> path::length (identical math); anonymity lines say 'the user's real name'
df8c306 Anonymity lines: 'the user's real name' (Alice is the pseudonym)
0832453 Replace tally::path_len with path::length (identical float ops)
f321631 Refer to the project's owner as Alice in prose and comments
abacd02 Merge main into r6-wet (optimized [profile.test]): golden and the test-profile replay hash re-recorded for this engine under the new profile (the latter now equals the release hash)
9c0294b Tests: optimized, non-incremental [profile.test] (the suite runs in ~1 min instead of ~10); golden re-recorded for it (stable across runs); two test tiers documented in notes/workflow.md
3e6a3e6 Merge branch 'main' into r6-wet
8116d03 Review fixes: refuse non-finite or negative film volume in checkpoints (test fails before); studies' line band as a unit normal (resolution-independent); notes
089c9de surface: conserve_total pins until no new pixel crosses its bound (was capped at 8 rounds; a 1024-pixel cascade left pixels below the floor); regression test fails before, passes after; benchmarks identical
d594d3e Thermos: status at the end of the maintenance round
accfd87 Merge branch 'main' into r6-wet
3060281 Release profile: incremental = false, codegen-units = 1 (deterministic codegen; two clean builds in separate target dirs now give byte-identical binaries and benchmark renders; replay hashes unchanged)
45ffc79 Re-record the golden scene and replay hashes for the merged engine (B10)
4933673 Merge main (8c5bf96) into r6-wet
```
</details>

<details><summary>detached 6244bdb (110, first 20)</summary>

```
6244bdb Alice's review of Evening at a Mountain Lake; the plain painting (1000, 3200, aged 3200)
c6880b1 Merge r6-glitch: glitch census (detector scripts/glitch.py, catalog notes/glitch.md), pinhole fix (wet::bead_cover), four sketchbook pitfalls
b1349ec Round 7: Evening at a Mountain Lake (wet engine) for Alice: sheets (lossless), fresh vs aged, painter's notes, two blind critiques
392f2b7 Easel guide: easel run --dump-surface and the glitch detector
cab4f1c Glitch census: scripts/glitch.py (specks, pinholes, flecks, lines, mottle; calibrated on the owner's passages), notes/glitch.md (catalog, causes, status, wet-stream write-up), lossless sheets notes/glitch/alice_census.png and alice_fixes.png, four recipe pitfalls in the sketchbook
7820422 easel look: JPEG quality 95 with full-resolution color via jpeg-encoder (the image crate always halves color and was at 88)
5fe9154 peek: JPEG quality 95 with full-resolution color (was 80 with half-resolution color, which smeared thin strokes)
3ea0021 Craquelure is part of the standard finish (Alice): varnish; cracks{}; relief()
e832497 Glitch P1: paint on a sliver of a pixel can't stand taller than half the pixel is wide (wet::bead_cover at the bake and in the wet look); the lab 2 lime's pale pinholes at 3200 were 50-130 µm of dark paint leveled onto a pointed tool's hair-sized cover share. Test fails before (33 pixels), passes after. easel run --dump-surface (height µm, for diagnostics). Benchmarks at 1000 change slightly (l5_near 487 px > 4 levels, l3_green 4244, hedgerow fringes darker); golden unchanged
d25181e Merge r6-pencil: the rock outline isn't the pencil (it's the seat_rock contact and cast glazes); notes only
ee47bc6 Pencil check: the outline around the rocks is not the underdrawing (1/255 at the rock edges with and without it); it is the contact glaze and the blurred cast glaze spilling onto the rock's foot. Evidence sheet for Alice + notes for the glitch stream; no code change
5d0e40b Merge r6-house: 'owner' -> 'Alice' in notes and comments; tally::path_len -> path::length (identical math); anonymity lines say 'the user's real name'
df8c306 Anonymity lines: 'the user's real name' (Alice is the pseudonym)
0832453 Replace tally::path_len with path::length (identical float ops)
f321631 Refer to the project's owner as Alice in prose and comments
9c0294b Tests: optimized, non-incremental [profile.test] (the suite runs in ~1 min instead of ~10); golden re-recorded for it (stable across runs); two test tiers documented in notes/workflow.md
089c9de surface: conserve_total pins until no new pixel crosses its bound (was capped at 8 rounds; a 1024-pixel cascade left pixels below the floor); regression test fails before, passes after; benchmarks identical
d594d3e Thermos: status at the end of the maintenance round
3060281 Release profile: incremental = false, codegen-units = 1 (deterministic codegen; two clean builds in separate target dirs now give byte-identical binaries and benchmark renders; replay hashes unchanged)
8c5bf96 Merge r6-maint-a: thermos B1 B2 B4 B5 B6 S1 S4 S6 (one timed-pass runner, one hand-clock wrapper, sitting palette); hand-time-off output identical
```
</details>

<details><summary>detached 199b80d (132, first 20)</summary>

```
199b80d evening_lake: notes, Alice sheet (lossless), evidence crops
de7083e evening_lake: finished (shore, stones, figure, moon, glaze, varnish)
7f4dfbe evening_lake: sitting 3 (fir promontory, spit, front row)
f6c71cc evening_lake: sitting 2 (range, sky, bank, lake, mist)
c0090f1 evening_lake: drawing and dead color
6c3169f Merge main into r6-wet (housekeeping)
5d0e40b Merge r6-house: 'owner' -> 'Alice' in notes and comments; tally::path_len -> path::length (identical math); anonymity lines say 'the user's real name'
df8c306 Anonymity lines: 'the user's real name' (Alice is the pseudonym)
0832453 Replace tally::path_len with path::length (identical float ops)
f321631 Refer to the project's owner as Alice in prose and comments
abacd02 Merge main into r6-wet (optimized [profile.test]): golden and the test-profile replay hash re-recorded for this engine under the new profile (the latter now equals the release hash)
9c0294b Tests: optimized, non-incremental [profile.test] (the suite runs in ~1 min instead of ~10); golden re-recorded for it (stable across runs); two test tiers documented in notes/workflow.md
3e6a3e6 Merge branch 'main' into r6-wet
8116d03 Review fixes: refuse non-finite or negative film volume in checkpoints (test fails before); studies' line band as a unit normal (resolution-independent); notes
089c9de surface: conserve_total pins until no new pixel crosses its bound (was capped at 8 rounds; a 1024-pixel cascade left pixels below the floor); regression test fails before, passes after; benchmarks identical
d594d3e Thermos: status at the end of the maintenance round
accfd87 Merge branch 'main' into r6-wet
3060281 Release profile: incremental = false, codegen-units = 1 (deterministic codegen; two clean builds in separate target dirs now give byte-identical binaries and benchmark renders; replay hashes unchanged)
45ffc79 Re-record the golden scene and replay hashes for the merged engine (B10)
4933673 Merge main (8c5bf96) into r6-wet
```
</details>

<details><summary>detached 62ace25 (33, first 20)</summary>

```
62ace25 Re-record the golden scene and replay hashes for the W1/T fixes (both profiles; non-incremental builds)
8db03f5 Wet glitches W1 and T (notes/glitch.md): a lifting brush's crowded hairs don't heap its stroke end; a blender spreads what it parts
f2d23b1 Merge main (2159c6c: glitch census, bead_cover) into r6-wet
5d3c1aa Merge branch 'main' into r6-wet
b013577 peek: quality 95, 4:4:4 (from main)
9472a0d Merge main into r6-wet (housekeeping)
1cd757b Merge main into r6-wet (optimized [profile.test]): golden and the test-profile replay hash re-recorded for this engine under the new profile (the latter now equals the release hash)
3c34f40 Merge branch 'main' into r6-wet
fc74d03 Review fixes: refuse non-finite or negative film volume in checkpoints (test fails before); studies' line band as a unit normal (resolution-independent); notes
dd8db96 Merge branch 'main' into r6-wet
d769b46 Re-record the golden scene and replay hashes for the merged engine (B10)
29cfb50 Merge main (2a652cf) into r6-wet
de8c202 notes/wet.md §9: the maintenance round (S2, B3, B7, B8, B9, S6); correct the memory figure in wet.md and round6.md; film.rs and exchange.rs in the house line width (rustfmt, no code change)
d0c5271 Re-record the golden scene and replay hashes (both profiles) for B3 and B7
47e7f75 Capillary feed leaves the dirty tip on its hair (B7)
545c0b9 The plough's stiffness counts the set-aside film as itself (B3)
871ce9d Checkpoint: refuse a corrupt surface film (B8)
ef45c5c Wet studies: one shared study module (paintings/src/study.rs); measured numbers identical (diffed)
cbeb42b Wet film restructure (S2, B9): a Layer type owned by wet.rs; film.rs and exchange.rs split out of bristle.rs
1c7ae00 Wet control experiment: study results, repaints, owner sheets
```
</details>

