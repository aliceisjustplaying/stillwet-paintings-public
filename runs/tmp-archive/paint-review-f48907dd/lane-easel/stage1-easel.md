# Stage 1, lane "easel": report

Worktree wt-easel, each branch from main 4ec3169. Nothing pushed or merged. Scratch: lane-easel/.
Test command for every Rust item: `TMPDIR=<lane-easel> cargo test -p easel` (full suite green
on each branch: 7 test binaries, 0 failures). The painter build is checked with
`cargo check -p easel --no-default-features` (clean).

## N16: look filenames
- Branch `fix/N16-look-filenames`, commit **cfb0538**. Label: **intentional behavior change** (bug fix).
- Change: an automatic look is `look-NNNN.png` with NNNN = one above the highest existing
  number, written with `create_new` (retries upward on EEXIST); rendering is split from
  writing (`look::render`). main.rs `new_look`, look.rs `render`.
- Test: `cargo test -p easel --test session_integrity a_look_never_overwrites_an_earlier_observation`.
  Main: FAIL (look-0001 removed, look-0002 marked, the next look wrote `look-0002.png`
  over it). Branch: pass.
- Open: frames (`frames/NNNN.png`, one per chunk) still overwrite by design. No persisted
  sequence number and no content hash binding (ledger acceptance 2-3).

## N2: binary chunks
- Branch `fix/N2-text-only-load`, commit **9314a01**. Label: **intentional behavior change** (sandbox contract).
- Change: prelude.lua wraps `load` to force text mode for strings and reader functions (arity
  kept, so an explicit nil env still means nil `_ENV`); Lua's own errors are rebuilt with the
  caller's name and position. `string.dump` removed. `Session::run` loads painter chunks
  with `ChunkMode::Text`: mlua treats a source starting with `\x1bLua` as bytecode
  (mlua-0.12.1 src/chunk.rs:744-751). The only alias of the C `load` is a prelude local, and
  heap.lua/api don't capture it.
- Test: `cargo test -p easel --bin easel binary_chunks_are_refused_and_text_load_still_works`.
  Main (embedded Lua 5.5): FAIL on 5 cases: `string.dump` present; `load(bin)`,
  `load(bin,'x','b'|'bt')` and the reader form all loaded bytecode; a `\x1bLua` chunk was
  parsed as binary ("bad binary format (version mismatch)"). Branch: pass.
- Legacy: confirmed no log uses it. `grep` over the 38 studio logs plus the 59 committed .lua
  (list: lane-easel/corpus-files.txt) finds no `load(`, `loadstring`, `load"`/`load[[`,
  `_G.load` or `string.dump` (one hit is a comment). So there is no legacy path.
- Error text compared with main on 13 load cases (lane-easel/lerrs): identical except a failing
  **reader function's returned** message (main appended mlua's stack traceback) and
  `(mode is 'b')` → kept by a rewrite.

## N1: addresses
- Branch `fix/N1-no-addresses`, commit **ef2de96**. Label: **intentional behavior change** (printed text).
- New form: an object (table, function, userdata or thread) without `__tostring` prints as
  **`<type>: (hidden)`**, with its `__name` as the type as in Lua, e.g. `table: (hidden)` or
  `Thing: (hidden)`. This applies to `tostring`, `print` (api.rs:1113 reads the global
  `tostring`), `string.format` `%s`, and chunk error values (a prelude guard around the chunk,
  since mlua stringifies error objects with C `luaL_tolstring`, util/error.rs:323).
  `string.format("%p", …)` is refused ("%p shows a memory address…"). The guide has a new
  bullet (notes/easel_guide.md, "No memory addresses").
- Why not serials: allocation serials aren't transactionally restored (live snapshots and
  rollbacks allocate, replays don't), so `#<serial>` would differ live vs replay. The fixed
  form gives up uniqueness: two tables print alike. Corpus: every `tostring` of an object is
  inside `print`.
- The C-level route is closed: `lua_pointer2str` is an unguarded `#define` (lua-5.5.1
  luaconf.h:591).
- Tests: `cargo test -p easel --bin easel no_memory_address_reaches_a_painting`. Main: FAIL
  (`table: 0x7b24c64990…` in print, tostring, %s and error objects). Branch: pass.
  100 fresh processes (lane-easel/errs/p100.lua): **main 99 distinct outputs, branch 1**.
- Error text compared with main on 24 cases (lane-easel/errs; bad format args, method
  calls, local aliases, pcall'd format, `%q` modifiers, `__tostring` returning a table, stack
  overflow, callback errors): identical except the two intended ones (error object, `%p`).
- Open: replacing `tostring`/`string.format` with closures moves them from name order to
  creation order as table keys in `pairs` (only a table keyed by these functions would
  notice; same for `load`/`gmatch`). Rust error texts checked: none formats a Lua value with
  `Debug` (`{o:?}` uses are strings).

## N4: finalization inside the guard
- Branch `fix/N4-guarded-finalization`, commit **a9be988**. Label: **intentional behavior
  change** for failure paths; behavior-preserving for successful chunks (same flush and
  globals, same order).
- Change (session.rs `run`): `time::flush` and the globals read (`next_globals`, computed
  into a new map, swapped in only on success) run inside `catch_unwind`, so a failure
  there rolls back like a failed chunk. A restore that errors or panics sets `stale` (the
  existing rebuild-from-log path) plus `unrestored`; the reply says "the easel couldn't put
  back what the chunk did (…), so it rebuilds the painting from its log before it paints
  again". main.rs handles the `unrestored` message. The server already refuses everything
  but status during a rebuild.
- Seam: `#[cfg(test)] fail_at` + `inject()` (no-op outside tests). Nothing a painting can do
  makes these steps fail, and the brief requires injection.
- Tests: `cargo test -p easel --bin easel -- a_chunk_whose_ending_fails_changes_nothing a_failed_rollback_rebuilds_from_the_log_before_painting_again`.
  Main + seam only: FAIL on all three (globals: "the canvas kept what the chunk painted";
  flush: the panic escaped the guard; restore: `run` returned Err and went on, not stale).
  Branch: pass.
- Open: persistence handoff (`save_log` failing after a successful run) was already
  fail-closed on main (`ready()`: "uncommitted state; restart required"), but its reply
  doesn't say the chunk is lost. That belongs to N5's outcome reporting. Cleanup
  (`gc_collect`) can't fail meaningfully and is still ignored. The ledger's explicit
  prepared/executing/finalized/durable/acknowledged states aren't modeled.

## N3: per-session lock
- Branch `fix/N3-session-lock`, commit **e385f51**. Label: **intentional behavior change** (lifecycle).
- Change (main.rs): `out/easel/<name>/lock` is locked with `File::try_lock` (flock, std, no
  new dependency). Only the `open` that takes the lock removes a dead socket, truncates
  server.log and spawns `serve`. It passes the locked file as the server's stdin (same open
  file description, so the server holds the lock until it exits; checked by dev/inode).
  Other opens wait, or take the lock if the server has gone, and don't respawn after their
  own child died. `serve` without an inherited lock takes it itself, else fails with
  "another easel serves session … (pid N)" before replaying or touching the socket. The pid is
  written into the lock file.
- Tests: `cargo test -p easel --test session_integrity -- racing_opens_start_one_server a_second_server_is_refused_and_a_dead_ones_socket_is_recovered`.
  Race test on main: **FAIL, 8 servers at once** for one session (8 racing opens while a
  1e8-iteration log replayed). Branch: pass (3 rounds, max 1). The second test (second
  `serve` refused, socket inode unchanged, `kill -9` then reopen recovers) is a new-policy
  contract; on main it fails only on the refusal text.
- Harness: `EASEL_BIN=<painter build of this branch> node --test harness/painter/test/easel-client.test.ts`:
  13/13 pass, the real-easel test included.
- Open: readiness is still "status answers" (no published generation or start id).
  Pre-existing test flake: `rebuilding_serves_progress_and_refuses_nonstatus_requests`
  connects as soon as the socket file exists, which can be before `listen()` (seen once on
  N2, session_integrity.rs:148).

## N5: unknown outcomes (design only)
- Not implemented. Design and decisions needed: **lane-easel/N5-design.md** (request ids,
  create-new receipts plus `.pending` crash recovery under the N3 lock, an `easel outcome
  <id>` answered from files, exit code 3 for unknown, harness texts for
  committed/rolled back/unknown). The policy call is whether to cancel on client loss or run
  to completion.

## Final replay check (the brief's hard constraint)
- All five branches merged on a detached HEAD, **ac7cbf1** (no ref, not on main). Conflicts
  were only additive (N1/N2 prelude sections and tests, N1/N4 guard in `run`, N16/N3 tests).
  Merged suite: all green (55 unit tests, 10 integrity tests).
- `easel run [local path redacted] --dump-surface`, main
  release build vs merged release build: PNG sha256 **38cfed65…c6a8 on both**; surface.f32
  `cmp` identical; stdout identical (lane-easel/replay/). There's no golden for 6399ad yet
  (golden/ has no paint-studio-6399ad dir), so the comparison is against main's replay, as
  the brief allows.

## Housekeeping
- The daemons my tests started are all stopped (`pgrep -f "wt-easel.*easel serve"` finds
  none). A panicking N16 test run once left one; I killed it (only mine). Other studio
  daemons untouched.
- The worktree is left detached at main.
