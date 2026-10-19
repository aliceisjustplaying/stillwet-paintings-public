# Harness verification: findings 1, 2, 11, 12, 13, 14, 15

Repo `[local path redacted] at `08f632434fd03bf7e85129539f7e184a91db9056` (checked with `git rev-parse HEAD`). Installed pi `@earendil-works/pi-coding-agent` 0.99.1. No repo files were edited; `git status --short` is empty after the test runs. Probes and copies are in `[local path redacted] (`probe*.mts`, `p1/`, `p2/`, `p14/`, `p15/`, `s1*/`, `tests-*.txt`). No provider requests were made. The only pi launch used an empty `PI_CODING_AGENT_DIR` (no credentials) and exited in `session_start`.

---

## #1 Read validation and execution resolve different files (P1): CONFIRMED

**Code**

- The guard checks the raw string. `harness/painter/easel-tools.ts:104-107`:
  ```ts
  pi.on("tool_call", (event) => {
      if (event.toolName !== "read") return undefined;
      const path = String((event.input as { path?: unknown }).path ?? "");
      return inStudio(studio, path) ? undefined : { block: true, reason: `${path} is outside the studio` };
  ```
  `harness/painter/easel-client.ts:74` `const full = isAbsolute(path) ? path : resolve(studio, path);`. A path that doesn't exist falls back to that raw join (`:79` `real = full; // doesn't exist: read says so`).
- pi's `tool_call` gets the untouched args: `dist/core/agent-session.js:316` `input: args,`.
- pi's read resolves the path differently: `dist/core/tools/read.js:56` `const absolutePath = await resolveReadPathAsync(path, ctx?.cwd || cwd);`, which calls `resolvePath(..., { normalizeUnicodeSpaces: true, stripAtPrefix: true })` (`dist/core/tools/path-utils.js:43`). `dist/utils/paths.js` then:
  - `:64-65` strips a leading `@`
  - `:72-75` expands `~` / `[local path redacted]
  - `:78-79` `if (/^file:\/\//.test(normalized)) return fileURLToPath(normalized);`
  - `:62` maps Unicode spaces to ASCII spaces
  - `path-utils.js:50-69` falls back to AM/PM, NFD and curly-quote variants when the literal file is missing.

**Probe** (`probe1.mts`: the repo's `inStudio` plus pi's real `createReadToolDefinition(studio).execute`, with an outside sentinel file):
```
"../outside/secret.txt"                      guard=DENY   (blocked)
"file://[local path redacted]"  guard=ALLOW  read→ "OUTSIDE-SENTINEL"
"@[local path redacted]"        guard=ALLOW  read→ "OUTSIDE-SENTINEL"
"[local path redacted]"  guard=ALLOW  read→ "OUTSIDE-SENTINEL"
```
`probe1b.mts`: `[local path redacted] guard: ALLOW`. That file exists on this machine and holds the Anthropic OAuth credential (README:67-68); it was not read. Other studios, `[local path redacted] and prompts are equally reachable. The variant fallbacks add a second, narrower hole. `inStudio` falls back to the raw path when the literal file is missing (`easel-client.ts:78-79`), while pi may open an existing variant name through a symlink in the studio. That needs a studio symlink, which the painter cannot create without a shell.

**Severity:** P1 is right. It's reachable through the current `read` tool in the round 19 tool set (`r19_chains.py:89` `TOOLS = "paint,look,note,status,log,read"`). The model needs no unusual capability: `[local path redacted] is a natural spelling. Credentials and other painters' work can enter the context and the session files.

**Fix sketch** (about 15-25 lines in `easel-tools.ts`, and `easel-client.ts`):
1. Wrap `read.execute` instead of relying on `tool_call`.
2. Reject paths starting with `@`, `~` or `file:`, and paths containing the Unicode spaces from `paths.js:6`. Or apply the same normalization first.
3. `resolve(realpathSync(studio), path)`, then `realpathSync` the file, which must exist. Check containment.
4. Call `read.execute` with that canonical absolute path. pi's resolver then finds the literal file on its first `pathExists` check (`path-utils.js:74-75`), so its variant fallbacks never run.

pi's resolver isn't in the package index (a grep for `resolveReadPath|resolvePath|normalizePath` in `dist/index.d.ts`/`index.js` found nothing), so mirroring it or rejecting these forms is the practical route.

**Test:** extend `test/easel-client.test.ts` "read stays inside the studio" with `file://`, `@`, `[local path redacted] and Unicode-space spellings of an outside sentinel. Run it through the registered read execute path (as `probe1.mts` does), not only `inStudio`. Add an AM/PM-variant symlink case.

---

## #2 Launch instructions expose shell access and omit painting tools (P1): CONFIRMED

**Code**

- `harness/painter/README.md:30` and `:37`: `--system-prompt "$H/system_prompt.md" --tools bash,read \`. The same file still describes the shell era: `:3-4` "the `bash` and `read` tools", `:10` "makes `bash`/`read` run one at a time" and `:24` `H=[local path redacted] The prompt at `:33` asks for "the paths of the saved painting and its log", and the tool set has no save.
- pi's allowlist covers extension tools too. `dist/cli/args.js:299-300` "Comma-separated allowlist of tool names to enable / Applies to built-in, extension, and custom tools". `dist/core/agent-session.js:2747` `const isAllowedTool = (name) => (!allowedToolNames || allowedToolNames.has(name)) && ...` and `:2755` `].filter((tool) => isAllowedTool(tool.definition.name));`.
- The harness never checks this. `grep -n bash harness/painter/painter.ts harness/painter/easel-tools.ts` finds nothing (exit 1), and `painter.ts:8-9` claims "No shell".

**Probe** (`p2/`: the README flags, a probe extension printing `pi.getActiveTools()` in `session_start` and then `process.exit(0)`, and an empty `PI_CODING_AGENT_DIR`):
```
== --tools bash,read
ACTIVE: ["bash","read"]
== --tools paint,look,note,status,log,read
ACTIVE: ["paint","look","note","status","log","read"]
```

**Scope:** the tracked round 19 runner is correct (`r19_chains.py:88-91`: `TOOLS = "paint,look,note,status,log,read"` ... `"--tools", TOOLS`). Older runners still pass `bash,read` (`r17_chains.py:74`, `r18_open.py:75`, `r18r_open.py:91`, `r18g_open.py:86`). Rerunning them, or copying the README, gives the painter a full shell. It could still paint through `bin/easel`, so the failure is silent.

**Severity:** P1 holds for the harness's missing enforcement: a documented launch silently breaks the isolation that `painter.ts` promises. Current round 19 runs aren't affected, so practical urgency is lower than #1.

**Fix sketch:** README `:30`/`:37` → `--tools paint,look,note,status,log,read`, and refresh `:3-4`, `:10`, `:24` and `:33` (2 files, about 10 lines). In `painter.ts`, add a `session_start` check that `pi.getActiveTools()` equals exactly the expected set, and exit with a clear error otherwise (about 8 lines).

**Test:** a unit test of an exported `checkTools(active)` helper. The `p2/` launch, which makes no provider request, can serve as an integration smoke test.

---

## #11 Timeout starts after unbounded opening probes (P2): CONFIRMED

**Code**

- `easel-client.ts:46` `const st = await easel(studio, ["status"], undefined, signal);` and `:48` `easel(studio, ["open"], undefined, signal)` pass no `waitMs`. `:36` `const timer = waitMs ? setTimeout(...) : undefined;` sets no timer when `waitMs` is missing. The limits only reach the later call (`:55-56`).
- The native client blocks without a limit: `crates/easel/src/main.rs:328` `s.read_to_string(&mut resp)`, with no read timeout on the client socket. The server serves one connection at a time (`main.rs:491` `for conn in l.incoming() {`), so any stuck handler (for example finding 3's grid loop) stalls every later `status`.

**Probe** (`probe11.mts`, a stub `bin/easel` whose `status` sleeps 30 s):
```
#11: still pending after 5s (WAIT_MS.other is 3 min, but status probe has none) 5003 ms
```
A stuck server would leave it pending indefinitely.

**Severity:** P2 is right. It needs a stuck server (finding 3, or a native hang), but then the painter hangs with no tool error. The runner's 30-minute watchdog (`r19_chains.py:86` `WATCHDOG_MIN = 30`) is the only backstop.

**Fix sketch** (about 5 lines in `easel-client.ts`): pass a probe limit (for example 30 s) to the `status` and `open` calls. If `status` times out, throw ("the easel isn't answering") instead of calling `open`; `open` must not run beside a live but busy server.

**Test:** copy the existing "a client that hangs is stopped" test (`test/easel-client.test.ts:56-64`) with a stub whose `status` sleeps, and assert that `atEasel` rejects within the bound.

---

## #12 A broken input pipe terminates the painter process (P2): CONFIRMED (severity: P3)

**Code:** `easel-client.ts:34` `p.on("error", fail);` covers the child only. There's no `p.stdin.on("error", …)`, and `:40` `p.stdin.end(input ?? "");` writes the input.

**Probe** (`probe12.mts`, a stub that exits at once, with 8 MiB of input):
```
Error: write EPIPE ... Emitted 'error' event on Socket instance ... code: 'EPIPE'
node exit=1
```
Neither the `catch` nor the `exit`-code logger ran; the process died. pi catches `uncaughtException` only in interactive mode, and even there it exits: `dist/modes/interactive/interactive-mode.js:3455` `console.error(\`${APP_NAME} exiting due to uncaughtException:\`)`, followed by `process.exit(1)`. The runner uses `--print`, which has no handler.

**Reachability:** the real client resolves the session before it reads stdin. `main.rs:344` `let name = current(name)?;` runs before `:358` `std::io::stdin().read_to_end(&mut b)`. So the client exits unread only if `out/easel/current` is missing or the binary fails early, and the chunk or note must exceed the pipe buffer (about 64 KiB). Normal chunks are well under that.

**Severity:** the impact matches P2 (the whole sitting crashes and counts against `MAX_CRASHES`), but the trigger is narrow. I'd rate it **P3**. The fix is trivial either way.

**Fix sketch** (3-6 lines): `p.stdin.on("error", () => {})` (the `close` handler already reports the exit code), plus a `settled` flag so `done`/`fail` run once.

**Test:** `probe12.mts` as a node test: a stub that exits 0 with 8 MiB of input must resolve or reject, and the test process must survive.

---

## #13 Cancellation can execute work and retain completed clients (P2): CONFIRMED

**Code:** `easel-client.ts:38-39` `const stop = kill; signal?.addEventListener("abort", stop, { once: true });`. There's no `signal.aborted` check before `spawn` at `:23`, and `close` at `:37` never removes the listener. `ensureOpen` (`:46-49`) and `atEasel` (`:54-56`) never check `signal` between steps.

**Probes**

- `probe13.mts` (pre-aborted signal):
  ```
  #13a pre-aborted easel(): resolved code 0 out "ok"
  #13b pre-aborted atEasel resolved
  calls: do - / status / open / do -
  #13c abort listeners after 6 completed atEasel calls: 18
  ```
  That's 3 per call, because this stub's `status` fails. With a working `status` it's 2 per call, which matches the review's 12.
- `probe13b.mts` is the realistic case. `status` takes 2 s and the signal aborts at 300 ms:
  ```
  #13d atEasel resolved: ran do
  calls: status / open / do -
  ```
  The abort kills `status`. `ensureOpen` reads the non-zero exit as "not open", runs `open`, and then the `do` runs the chunk and returns success.

**Context:** pi usually stops pre-aborted calls itself (`pi-agent-core/dist/agent-loop.js:435-438` `if (signal?.aborted) { ... createErrorToolResult("Operation aborted")`), so 13a/13b are mostly defense in depth. The mid-`status` abort (13d) isn't covered by pi and commits a chunk after the user cancelled. The listener buildup lasts for one agent run. In `--print` a whole sitting is one prompt, so hundreds of tool calls accumulate listeners. Each closure keeps its `ChildProcess` alive and, through the stdout handlers, its `out` string, including full `log` outputs.

**Severity:** P2 is right. Painting state can change after cancellation.

**Fix sketch** (about 10 lines in `easel-client.ts`):
- In `easel()`, reject if `signal?.aborted` before spawning.
- Call `signal?.removeEventListener("abort", stop)` in the `close` and `error` paths.
- In `ensureOpen` and `atEasel`, throw after each await if `signal?.aborted`. An aborted `status` must not lead to `open`.

**Test:** turn `probe13b.mts` into a node test asserting that `calls.log` never contains `do` and that `atEasel` rejects. Add a check that `getEventListeners(signal, "abort").length === 0` after completed calls.

---

## #14 Missing paths misclassified under a symlinked studio root (P3): CONFIRMED (not reachable in production)

**Code:** `easel-client.ts:74` `resolve(studio, path)` uses the unresolved `studio`. `:79` `real = full;` applies to missing files. `:81` `relative(realpathSync(studio), real)` compares against the canonical root.

**Probes**

- `probe14.mts` (studio passed as `p14/link` → `p14/real`):
  ```
  studio via link, existing notes/a.md: true
  studio via link, missing BRIEF.md   : false
  studio via link, abs missing        : false
  process.cwd() after cd via link     : .../p14/real
  ```
- The repo's own tests, with no repo edits:
  - canonical `TMPDIR`: `ℹ tests 23 / pass 22 / fail 0 / skipped 1` (the skip is the `EASEL_BIN` real-easel test, `test/easel-client.test.ts:35-36`)
  - symlinked `TMPDIR`: `✖ read stays inside the studio, links included`, `pass 21 / fail 1`

  (Logs: `tests-canon.txt` and `tests-link.txt`.) macOS's default `os.tmpdir()` is under `/var` → `/private/var`, so the test fails there too, not only under `/tmp`.

**Reachability:** production calls `registerEaselTools(pi, process.cwd())` (`painter.ts:74`), and `process.cwd()` is already canonical (last line of the probe). The mismatch also fails closed: a missing in-studio file gets "outside the studio" instead of "not found". So only the test harness sees it.

**Severity:** P3 is right, and arguably test-only.

**Fix sketch** (3-6 lines): `const root = realpathSync(studio)` and resolve relative paths against `root`. For missing files, realpath the nearest existing ancestor and append the rest. This merges naturally with the #1 fix.

**Test:** the existing test with the studio passed through a symlink, as in `probe14.mts`.

---

## #15 Compaction invents globals and omits real ones (P2): CONFIRMED (severity: P3 at current sitting lengths)

**Code:** `compaction.ts:134-135`:
```ts
const fn = /^function\s+([A-Za-z_]\w*)\s*\(/.exec(line);
const assign = /^([A-Za-z_]\w*(?:\s*,\s*[A-Za-z_]\w*)*)\s*=(?!=)/.exec(line);
```
It works line by line with no lexer. The doc comment at `:117-118` says "Indented lines (function bodies, loops) are skipped". The output is presented under `:191` `"## Globals defined in paintings/lua/painting.lua"`. `:201` also tells a painter with no shell to use "`bin/easel log`" (stale; the tool is `log`). The easel runs Lua 5.5 (`crates/easel/Cargo.toml:37` `features = ["lua55", ...]`), so `global x = …` declarations are real syntax too.

**Probes**

- Synthetic (`p15/probe15.mts`, with a byte-identical copy of `compaction.ts` checked by `cmp`, because the repo copy can't resolve `@earendil-works/pi-coding-agent` outside pi):
  ```
  listed as globals: [ 'story', 'ghost', 'phantom', 'shade' ]
  real globals:      [total, palette, story, sky]
  ```
  It invented a long-string line (`ghost`), a block-comment line (`phantom`) and a reassigned local (`shade`). It missed indented globals in `for`/`if` blocks and a `global` declaration.
- Real tracked logs (`p15/real15.mts`). Ground truth is every `SETTABUP _ENV "name"` in `luac -l -p` for each chunk, using Lua 5.5.0:
  ```
  easel3_green.lua: listed=37 actual=39 missed=2 [OB,OTOP] invented=0
  easel3_near.lua:  listed=36 actual=34 missed=0 invented=2 [cush,dm]
  easel4_free.lua:  listed=49 actual=50 missed=1 [FY] invented=0
  easel4_green.lua: listed=38 actual=37 missed=0 invented=1 [tm]
  easel4_near.lua:  listed=35 actual=34 missed=0 invented=1 [w2]
  r8arm1_far_hills.lua: listed=18 actual=17 invented=1 [pts]
  (6 other logs exact)
  ```
  Real causes:
  - `easel3_near.lua:409` `local dm = nil` … `:414` `dm = dm:roughen(...)`: a local reassigned at column 0 gets listed as a global.
  - `easel3_green.lua:225` `OSKY = cl; OB = oak.bounds; OTOP = oak.bounds[2]`: `;`-joined statements lose everything after the first.

  So the review's long-string example is contrived, but the defect is real in ordinary painter code. A listed "global" that is really a local will be nil in a later chunk.

**Severity:** the mechanism is confirmed, but "an active source of misleading context" overstates how often it runs. Compaction starts at about 900K tokens, and round 19's largest sitting was 328K (README:144-145, `compaction.ts:43`), so the summary hasn't been used in current runs. I'd rate it **P3** now and P2 if sittings get long enough to compact.

**Fix sketch:**
- Best: get the real globals from the easel, for example a `status --globals` that walks `_ENV` minus the prelude's names. That's about 20 lines of Rust or Lua plus 5 in `compaction.ts`, and the result is exact.
- Minimal (about 10 lines): split on `;` outside strings, skip names declared `local` earlier in the same chunk, and retitle `:191` "Names assigned at the top level (approximate; the `log` tool has the whole log)". Also fix `:201`.

**Test:** a `scanLog` unit test using the synthetic log above, plus regression expectations from `easel3_near` and `easel3_green` (the `dm`/`cush` and `OB`/`OTOP` cases).

---

## Summary

| # | Review sev. | Verdict | My severity | Key receipt | Fix size |
|---|---|---|---|---|---|
| 1 | P1 | CONFIRMED | P1 | `file://`, `@`, `[local path redacted] spellings: guard ALLOW, pi read returns the outside sentinel; `[local path redacted] gets ALLOW (`easel-tools.ts:106-107` vs `paths.js:64-79`) | 15-25 lines, 1-2 files |
| 2 | P1 | CONFIRMED (README and old runners only; r19 runner correct) | P1 for missing enforcement; current runs unaffected | `--tools bash,read` → `ACTIVE: ["bash","read"]` (`agent-session.js:2747`) | README about 10 lines + about 8-line tool check |
| 11 | P2 | CONFIRMED | P2 | `easel-client.ts:46,48` pass no `waitMs`; probe still pending after 5 s; client `read_to_string` has no timeout (`main.rs:328`) | about 5 lines |
| 12 | P2 | CONFIRMED | P3 (narrow trigger: `main.rs:344` before `:358`, needs >64 KiB) | unhandled `EPIPE`, node exit 1; no stdin error handler at `easel-client.ts:34,40` | 3-6 lines |
| 13 | P2 | CONFIRMED | P2 | abort during `status` → `open` + `do` still run and succeed; 18 listeners after 6 calls | about 10 lines |
| 14 | P3 | CONFIRMED (test-only; `process.cwd()` is canonical) | P3 | the repo test fails with a symlinked TMPDIR (`pass 21 / fail 1`) and passes with a canonical one (`22 pass, 1 skip`) | 3-6 lines |
| 15 | P2 | CONFIRMED | P3 now (compaction not reached: README:144-145); P2 if sittings grow | real logs: 5 of 12 wrong vs `luac` ground truth (`dm`, `cush`, `OB`, `OTOP`, `FY`, …) | about 10 lines minimal; about 25 for exact easel-backed globals |
