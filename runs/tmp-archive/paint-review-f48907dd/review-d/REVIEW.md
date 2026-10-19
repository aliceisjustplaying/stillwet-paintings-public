# Review D: N16, N2, N1, N4, N3 (easel, against main 4ec3169)

Scratch: `[local path redacted] Worktree `wt/` detached. Merged scratch
commit **2e86692**, tree identical to the lane's ac7cbf1 (`git diff ac7cbf1` is empty).
`cargo test -p easel -p paint` on the merge: all green (easel unit 55, boxes 5, delivery 2,
determinism 2, session_integrity 10, smoke 1, paint 167 + 2 + 1; 0 failed).

## Verdicts

| Branch | Verdict |
|---|---|
| fix/N16-look-filenames (cfb0538) | **ship with nits** |
| fix/N2-text-only-load (9314a01) | **needs changes** (one line; safe only when merged with N1) |
| fix/N1-no-addresses (ef2de96) | **needs changes** (callback error leak) |
| fix/N4-guarded-finalization (a9be988) | **ship with nits** |
| fix/N3-session-lock (e385f51) | **ship with nits** |

## Hard requirement: past paintings don't change

The static check finds nothing in the 97 logs that behaves differently. The file list is
`review-d/corpus.txt`: the 38 studio logs plus the 59 committed `.lua` files outside
`crates/easel/src`.
- `tostring`: every use is an argument to `print`
  (e.g. paint-studio-520026 painting.lua:2526, cd267e:834/867/911, 9aae10:1447/1450). None
  is a table key, a comparison or a concatenation outside print.
- `string.format` with `%s`: only inside `print` (520026:5842, :5854). Non-print formats use
  only `%d/%f` (58dfc6:370, 9aae10:349, l5_near.lua:151). There is no `%p` anywhere.
- `setmetatable`/`__*` metamethods: **0 hits**. So the `__tostring`/`__name`/C-depth effects
  below can't apply.
- `pcall`: 520026:3011-3056 (result only printed) and cd267e:854 (`pcall(ribbon, …)`,
  branches on `ok` only, never on the message). No `error(`, `load`, `loadstring`,
  `string.dump`, `debug`, `require` or `dofile`. The one "load" hit is a comment
  (497bcf:2371).
- `pairs(_G)`: 520026:2526 and 58dfc6:4777. _G has only string keys, so it walks in Lua's own
  order. The branches only reassign existing keys (`load`, `tostring`) and add none. The
  output is only printed or sorted.
- No `pairs(string)`. No table keyed by a library function (`[print]`, `[tostring]`,
  `[load]`, `[string.*]`) and no alias `= tostring|string.format|load`.
- No log contains an ESC byte (the `\x1bLua` signature). All 97 start with `-`.

Empirical check:
- `notes/time/edge_instant.lua` replayed by the lane's release `easel-main` and
  `easel-merged` (the same tree as 2e86692). The PNG and `--dump-surface` are byte-identical
  (`cmp`). Stdout differs only in paths and timings (`review-d/replay/`).
- The lane's full 6399ad replay was identical (stage1-easel.md).
- I didn't replay all 97. One small log takes about 110 s per build on a shared machine.

What does change (none of it is in the corpus):
- `pairs` over a table keyed by `tostring`, `string.format` or `load`. These are now
  closures, so they sort by serial, not by name. Probe (`review-d/probe/probe2.lua` chunk 3),
  table `{[print]=1,[tostring]=2,[string.format]=3,[load]=4,[math.floor]=5,[ipairs]=6}`:
  main `1 6 4 5 3 2`, merged `4 2 3 1 6 5`.
- `pairs(string)`: 17 entries on main, 16 merged (`string.dump` removed).
- The C-call budget (Lua 5.5.1 `LUAI_MAXCCALLS` 200, ldo.h:63). Only C-boundary calls count
  (ldo.c:761). Measured in the same probe:
  - pcall recursion: 199 on main, 198 merged (N1 `guard` adds a `pcall`, prelude.lua:346).
  - `__index` function recursion: 197 → 196.
  - `__tostring` recursion: **197 → 98**. `det_tostring` adds a `pcall` per level
    (prelude.lua:294).

  A log that succeeded within 1–99 levels of the limit would now fail. None in the corpus
  can: no metatables, and pcall isn't recursive there.
- Stdout of replays: objects print `table: (hidden)`, not an address (nondeterministic
  before anyway). Error objects a painting catches with `pcall` now carry two more traceback
  lines, `[C]: in upvalue 'pcall'` and `[string "prelude.lua"]:346` (probe chunk 3,
  520026:3011-3056 prints such values). This matters only if some golden check compares
  stdout.

The other questions in the brief:
- N4 on successful chunks: the same steps in the same order (`chunk → check → flush →
  globals`), now inside the guard (session.rs:273-281 on the branch). `global_values` is raw
  `lua_next` (`for_each`, session.rs:410-419), so the live deadline hook can't fire during
  it. Replay has no deadline. Which chunks succeed is unchanged, except that a chunk whose
  globals read failed used to be kept unlogged and is now rolled back.
- N3: `easel run`/`check` don't take the lock (only `serve`, main.rs:559). The log format
  and files are untouched. The lock is a new file, `out/easel/<name>/lock`. smoke,
  delivery and determinism pass.
- RNG and clock: no branch touches the seed. The clock only through N4's unchanged
  `time::flush`.

## Findings by severity

### High
**H1 (N2 as a standalone branch): the raw C `load` leaks through a replaced global `pcall`.**
- On the N2 branch, `text_load` calls the *global* `pcall`. The prelude's locals
  (prelude.lua:9) don't include it. The calls are `pcall(rawload…)` at prelude.lua:245,
  :248 and :251. `luac -l` of the N2 prelude shows `GETTABUP _ENV "pcall"` three times in
  `function <…:235,267>`, and none in the merged prelude.
- A painting can do `pcall = function(f, ...) RAW = f; return real(f, ...) end;
  load("x")`, and `RAW` is Lua's own `load`, which takes bytecode.
- Reproduced with `lane-easel/easel-n2 run review-d/probe/probe.lua`: `captured: true fn`.
  Merged: `captured: false`.
- The merge is safe only because N1 adds `local format, pcall = string.format, pcall`
  (merged prelude.lua:15).
- Fix: add `pcall` to N2's locals, plus a test that replaces `pcall`, `string.find` and
  `string.gsub` before calling `load`.

### Medium
**M1 (N1): an error object raised in a Lua callback the easel calls still shows its address.**
- mlua's error handler turns any non-`WrappedFailure` error value into text with C
  `luaL_tolstring` (mlua-0.12.1 src/util/error.rs:322-323). That happens before the prelude
  `guard` sees the value.
- Callbacks go through it: `eval_mask` `g.call` (api.rs:674), `curve_of` `f.call`
  (api.rs:685) and `sample` (api.rs:147, used at :194 and :229).
- Merged build, `review-d/probe/probe3.lua`:
  `pcall(mask, function() error({}) end)` gives `runtime error: table: 0x7aa503ce10`, and
  `error(function() end)` gives `function: 0x7aa5108430`. Uncaught, the same text is the
  chunk's error reply.
- A painting can print this string or branch on it. That contradicts the commit message and
  N1 acceptance 3.
- Fix: call painter callbacks through a Lua wrapper that applies `hidden` to the error value
  (like `guard`). Or scrub `0x[0-9a-f]+` in the Rust error conversion. Add these cases to
  `no_memory_address_reaches_a_painting`.

### Low
- **L1 (N1):** `det_tostring` halves how deep `__tostring` can recurse (197 → 98). `guard`
  takes one C level from every chunk. See above. There are no metatables in the corpus.
  Document it, or skip `pcall` in `det_tostring` when `hidden(v)` is nil and there's no
  `__tostring`.
- **L2 (N3): the lock fd and the env var are inherited by any child the server spawns.**
  - `lsof` on a scratch server (EASEL_ROOT=review-d/root) shows fd `0u` and `3u` on `…/lock`.
  - fd 0 is not close-on-exec: `.stdin(lock)` at main.rs:465. The dup at main.rs:511 is.
  - `EASEL_LOCK_ON_STDIN=1` is in the server's environment (main.rs:463, seen with
    `ps eww`).
  - The server spawns no children today (the only `Command::new` is in `open`). A future
    child would hold the session's lock after the server dies, and every open would wait.
  - Fix: `dup2(/dev/null, 0)` and `remove_var(LOCK_ON_STDIN)` after `serve_lock`.
- **L3 (N3): deploying while a pre-N3 daemon is replaying.** The old daemon holds no lock.
  If it hasn't bound its socket yet, a new `open` takes the lock, removes the socket and
  starts a second server: the old race, once. Restart live daemons (they aren't mine to
  touch) when this ships.
- **L4 (N4): the server path of a failed rollback isn't tested.** No test covers the
  `unrestored` reply or `rebuild_serving_status` after one (main.rs:816). The restore-panic
  arm (session.rs:301) isn't exercised either: only `Err` is injected (session.rs:197).
  The session-level rebuild is tested (`a_failed_rollback_rebuilds_from_the_log_before_painting_again`,
  session.rs:923).
- **L5 (N4): steps outside the guard.** `snap()`, `fresh()` and `st.begin(n)`
  (session.rs:264) run before the guard. A panic there escapes `run`. Nothing has run yet,
  but `begin` has touched Studio. `gc_collect` after the guard is still ignored. Known (lane
  "Open").

### Nits
- **N16:** `new_look` parses any `look-<u64>.png` (main.rs:669). A stray
  `look-18446744073709551615.png` makes `n += 1` (main.rs:672) panic in debug and wrap to
  `look-0000` in release. Use `checked_add` or cap the digits. `parse::<u64>` also accepts
  `look-+5.png`.
- **N16:** frames still overwrite, and there's no content hash or generation binding (known).
- **N16:** concurrent looks can't collide. The server is single-threaded, N3 allows one
  server, and `create_new` covers the rest. A failed write removes the partial file.
- **N3:** the pid in the lock file (main.rs:531) is only for the message. Correctness
  doesn't depend on it, so PID reuse is harmless. A crash releases the flock (kill -9 is
  tested). Stale sockets are removed only by the lock holder (main.rs:457 and serve).
- **N3:** a waiting open treats `easel: fatal` in server.log as its own failure (main.rs:495).
  There's a window of under 100 ms where it could read the previous run's log before the
  winner truncates it.
- **N2:** reader functions are safe. Lua picks binary or text from the first byte, so
  `"\27"` then `"Lua"` in pieces is refused ("attempt to load a binary chunk (mode is 't')"
  in the probe). `getmetatable("").__index.dump` is nil. `require`, `dofile`, `loadfile`,
  `debug`, `coroutine`, `io` and `os` are all nil. heap.lua, api.rs and legacy/ capture no
  `load`. The only painter-source load is session.rs:268 (`ChunkMode::Text`).
- **N1:** `%s` counting in `det_format` can misalign only on format strings Lua itself
  rejects. It changes a successful format only for `%p`, which is now refused (the probe
  also checked `%10p`).
