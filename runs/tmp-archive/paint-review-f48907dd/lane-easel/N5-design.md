# N5: request IDs and unknown outcomes (design only, not implemented)

Stopped at design: this needs a protocol change on both ends (server + `easel` client +
harness/painter/easel-client.ts), a durable receipt store and a policy decision on
cancellation. It is bigger than one small PR, and the ledger lists R6 (bounded native work)
as a dependency. It builds on N3 (one server a session, e385f51) and N4 (ending inside the
guard, a9be988).

## Today (main 4ec3169)
- `easel do` connects, sends, then blocks in `read_to_string` (main.rs `request`). If the
  client is killed or times out, the server still runs the chunk and commits it
  (`check::client_gone` only skips requests *not yet started*, main.rs `serve` loop).
- The harness kills the client's process group on timeout (easel-client.ts `easel()`,
  `process.kill(-p.pid)`) and says: "the easel didn't answer within N minutes; `status`
  shows whether the chunk count changed" (easel-client.ts `atEasel`). Any other non-zero exit
  becomes a plain tool error. A connection reset mid-reply ("the easel closed without
  answering") is a plain error too, and so reads like an ordinary failed chunk ("changed
  nothing").

## Proposal
1. **Request ID.** The harness generates a 128-bit hex id per `do` and passes
   `easel do --id <hex> -`. The CLI makes one up if none is given (and prints it on stderr).
   The id goes in the request head (`do\t--id\t<hex>`); it isn't in the log (log bytes and
   replay stay unchanged).
2. **Receipts.** `out/easel/<name>/receipts/<id>`, written with create_new + fsync + rename:
   - `committed <chunk n> <sha256 of committed.lua>`: written after `save_log` returns and
     before the reply;
   - `rolled_back`: written after `run` returns Err and the rollback is done (including a
     stale rebuild pending).
   A receipt for an id that already exists means a duplicate: the server does **not** run the
   chunk again; it replies with the stored outcome.
3. **Crash window.** The server may die after `save_log` but before the receipt. The
   `outcome` query then compares the log: if the log's last chunk text equals the request's
   chunk (the server keeps `receipts/<id>.pending` holding the chunk's sha256, written before
   `run`), the answer is `committed` (recovered); otherwise it's `rolled_back`. With
   `.pending` present and no server running, nothing else is possible, because N3's lock
   ensures a single writer.
4. **Query.** `easel outcome <id>` → `committed chunk N` | `rolled_back` | `running` (the
   `.pending` file exists and the server holds the lock but hasn't finished) | `unknown` (no
   record at all: the request never reached the server). The server is single-threaded, so
   `outcome` must be answered from files without the server (the CLI reads the receipts
   directly), otherwise it would queue behind the chunk it asks about.
5. **Client.** When `easel do` loses the connection or gets an empty reply, it prints
   `unknown outcome for request <id>: the easel may still be running it; don't send it again,
   ask: easel outcome <id>` and exits with a dedicated code (3).
6. **Harness.** On a timeout, abort or exit 3, `atEasel` runs `easel outcome <id>` (bounded
   polling while it says `running`) and returns one of three distinct texts:
   committed (the chunk *is* in the painting, with its number), rolled back (changed nothing)
   or unknown (with the id and the query command). It never resends a `do` automatically.
7. **Cancellation.** Cooperative server cancellation (the deadline hook checking
   `client_gone` or a cancel file) is only safe before `save_log`; after that the outcome
   is committed. Choosing between "cancel on client loss" and "run to completion" is the
   **policy decision needed**: with cancellation, a painter whose client merely timed out
   loses the chunk; without it, the chunk lands unseen but is reported via `outcome`.

## Tests (acceptance)
- Disconnect before admission: `unknown`, then no receipt ever; resend is safe.
- Disconnect during native work (a slow chunk; kill the client): `running`, then `committed`;
  resending the same id doesn't paint twice (chunk count +1 only).
- Kill the server between `save_log` and the receipt (a test-only fault point): `outcome`
  recovers `committed` from `.pending` + log.
- Harness: a fake easel that exits 3 → the tool error says "unknown outcome" and names the
  id, and is distinct from "changed nothing".

## Decisions needed
- Cancel on client loss, or run to completion (item 7).
- Where receipts are retained and when they are pruned (per session for good, or last K).
- Whether the painter build's `easel` CLI exposes `outcome` to the painter or only the
  harness uses it.
