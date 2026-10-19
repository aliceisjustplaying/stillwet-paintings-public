# Overnight studio review

**Do not treat these exports as enforcing the round's rules.** A scratch run demonstrated an uncommitted preview, exact rollback of a successful chunk, numerical PNG sampling and instant-dry poured paint. The Lua interface removes several shortcuts, but the painter still controls the executable and its files.

Evidence paths below are relative to `[local path redacted] `S/` means either `blank/` or `friedrich/`: `diff -qr friedrich/crates blank/crates` produced no differences. Runtime probes used only `scratch/session-audit/`, a copy of the blank studio. Full command/output receipts: `[local path redacted] Original studios and `[local path redacted] were not modified. Findings are ranked; A–D refer to the requested review categories.

## 1. An ordinary command provides hypothetical previews (A, D — critical)

Copy the current log, append a proposed chunk and run `easel run hypothetical.lua --out hypothetical.png`. It accepts arbitrary input without consulting the live session's integrity record (`S/crates/easel/src/main.rs:503–530`). Multiple named sessions and `EASEL_ROOT` also permit independent copies (`main.rs:237–264`; `session.rs:405–417`). The guide advertises both replay and session selection (`S/notes/easel_guide.md:45–48,465–474`). None of the briefs explicitly prohibits hypothetical replays or alternate sessions (`brief_A.md:10–18`; C:8–16; B/D have matching instructions).

**Demonstrated:** the hypothetical PNG was written from two chunks while `easel status` still reported `1 chunks`. Its SHA-1 `4cad7f3a3cb518df6485228ec89d6964bbac7d82` later matched the genuinely committed result (`runtime.txt`). This is a real preview, not merely a speculative attack.

**Fix:** remove arbitrary `run` and alternate sessions from the painter-facing service; replay only a trusted committed log for delivery/checking. Enforce one canvas outside the painter's writable workspace. With unrestricted shell/source access, an easel CLI patch alone cannot prevent cloning or rebuilding; an explicit brief prohibition is only an honor rule, not enforcement.

## 2. Two writable copies of the log do not prevent undo (A, D — critical)

The integrity record is another plaintext copy at `out/easel/<name>/committed.lua`. A live process detects edits, but reopening trusts matching canonical files (`S/crates/easel/src/main.rs:337–371`). Close, replace **both** files with an earlier pair and reopen; copying/restoring the entire workspace is equivalent.

**Demonstrated:** after committing chunk 2, restoring the pair reopened at `resumed 1 chunks`. Before/restored PNG SHA-1s both equal `20a9d9bba59f6b194cb0030f72560aaa0d247c3e`; the committed chunk-2 PNG differed (`runtime.txt`). Editing only one file is correctly rejected; coordinated rollback is not.

**Fix:** keep authoritative state and a monotonically advancing commit record in a separate service/account the painter cannot rewrite or restore. Do not rely on local hashes or two local files. Remove the guide's invitation to move both files from the painter workflow. If that isolation cannot happen tonight, explicitly prohibit copying/restoring/editing session state and label the run honor-enforced.

## 3. Glaze and an overflowing wait bypass the drying contract (A, C — high)

`Canvas::glaze` writes directly into dry pixels and film thickness; its comment explicitly says “It dries at once” (`S/crates/paint/src/canvas.rs:390–431`). Checking that the substrate is dry does not make the **new** oily paint wet (`S/crates/easel/src/api.rs:1380–1388`).

**Demonstrated:** on dry ground, `p=pile{{"bone black",1},medium=0.9}; print(wait(0)); glaze(nil,{pile=p,coats=20}); print(drying(500,100)); print(wait(0))` printed `day 1, 09:00`, `dry`, `day 1, 09:00` (`glaze.txt`). The minute-rounded output does not establish zero hand time; the defect is that a thick, oily new layer is already dry.

**Fix in engine:** deposit poured glaze into the wet-film model with the pile's drying rate and medium, advancing only normal hand time. Alternatively remove poured `glaze` for this run and retain brushed `work(...,{hand="glaze",pile=p})`. This is a real shortcut even though no Lua `dry()` exists. Varnish uses the same dry-film path (`api.rs:1439`).

**A second demonstrated shortcut:** `wait(1e100)` passes finite-f64 validation, overflows the f32 cast (`api.rs:1399–1404`) and calls `Canvas::dry()` (`S/crates/paint/src/drying.rs:212–215`). The probe printed `open`, `day 1, 09:00`, `day 11, 03:31`, `dry`—it waited only until the film dried, not the requested duration (`wait.txt`). Fix the duration representation and remove nonfinite-to-dry dispatch; do not introduce an artistic time budget.

**Additional source-traced timing gaps:** palette mixing/loading accrues time without flushing, and the next mark happens before the flush (`time.rs:60–71,100–115`), so mixing and painting within one chunk can use paint that should already have aged. `erase` and `fix` have no hand-time wrapper (`S/crates/easel/src/draw_pencil.rs:277–294`). Charge/flush palette time before subsequent marks and add time accounting for those drawing operations.

## 4. Scalar masks and glaze thickness can carry a computed image (A — high)

Lua `mask(function(x,y)...)` evaluates coverage at every pixel (`S/crates/easel/src/api.rs:1299`; guide:243–262). `glaze` accepts computed `coats`; scalar functions are sampled/interpolated (`api.rs:168–184,1380–1386`). The engine multiplies that field by each pixel's mask coverage and composites the pile over the pixel (`S/crates/paint/src/canvas.rs:407–429`). Thus a computed grayscale image can be encoded as the opacity of one dark pile; multiple fixed colored piles can carry separate computed coverage channels. No RGB-valued Lua return is necessary. Likewise arithmetic can choose the tube proportions supplied to `pile`.

**Fix:** removing `color=` is insufficient. For enforceable rule 3, expose bounded geometric coverage and constant paint parameters through a restricted drawing interface rather than arbitrary per-pixel functions; also constrain programmatic pile-generation loops if “by hand” excludes them. If retaining general Lua/masks is intentional, the brief must explicitly forbid encoding target color/value images in masks, thickness, load or pile ratios. That distinction is semantic and cannot be guaranteed by checking field names alone. Ordinary shape masks need not be banned as color math.

**Direct non-pile color edits also remain:** repeatable `relief()` multiplies/adds RGB in the canvas (`S/crates/paint/src/canvas.rs:464–473`); varnish uses hard-coded `#e6d3a4` (`api.rs:1439,1493`); cracks use fixed pigments (`S/crates/paint/src/crack.rs:1361–1385`). Remove these from strict mode or explicitly authorize physical finishing exceptions; make relief a fixed display calculation, not a repeatable pixel edit. Pencil/chalk likewise need an explicit drawing-material exception (`S/crates/easel/src/draw_pencil.rs:21–29,57–68`).

## 5. “Only the real canvas” is not the available viewing boundary (A — high)

**Real numeric sampling:** `magick hypothetical.png -format 'pixel(100,100)=%[pixel:p{100,100}]\n' info:` returned `pixel(100,100)=srgb(160,157,149)` (`diagnostics.txt`). `save` exposes full-resolution RGB pixels (`S/crates/easel/src/main.rs:443–447,490–498`), so removing Lua sampling does not prevent ImageMagick, Python/uv or another decoder from reading them. The same applies to saved real-canvas PNGs.

**Nonvisual diagnostics:** `run --dump-surface` produced `surface 2400x600 µm` and a 5,760,000-byte float file (`diagnostics.txt`; `main.rs:508,532–538`). `look --mode wet` is a false-color drying map, not the actual paint colors (`S/crates/easel/src/look.rs:21–23,352,444–460`). Value, blur, mirror and grid views also transform/annotate the image (guide:420–432). These are not hypothetical paintings, but the strict wording of rule 4 does not authorize them. Synthetic normals/depth/reflection queries (`S/crates/easel/src/world.rs:177–186,205–249`) and `drawing_mask()` reading graphite beneath paint (`draw_pencil.rs:297–303`; `S/crates/paint/src/graphite.rs:682–684`) also expose information beyond the visible canvas.

**Fix:** remove surface dumps and diagnostic views from the painter service; retain only actual current-canvas views/crops unless the owner expressly permits visual aids. To enforce no numeric sampling, keep PNG bytes outside the shell/file tools and return images only through a controlled viewer. A brief can prohibit pixel decoding and external analysis, but accessible image bytes remain decodable.

## 6. Rust/source access bypasses all Lua restrictions; journal append-only is also local (A, D)

The exported engine publicly offers `Canvas::sample`, arbitrary per-pixel `apply`/`apply_masked` (`S/crates/paint/src/canvas.rs:349–375`) and `Canvas::dry` (`S/crates/paint/src/drying.rs:348–355`). A painter can write a Rust caller or alter the Lua bindings. This does **not** mean the removed automatic color matcher still exists; it means a caller can implement its own search or painting path outside Lua.

`easel note` opens the journal in append mode (`S/crates/easel/src/main.rs:153–175`), but nothing protects the file from shell truncation/replacement. The briefs ask painters not to rewrite it without requiring the append command or saying it is addressed to no one (`brief_A/B.md:37–38`; C/D:31–32).

**Fix:** isolate the fixed easel binary, authoritative session files and append-only journal behind a service; let painters submit chunks/notes and read sanitized documentation. Restrict host execution and writable source access. Add “Use `easel note`; the journal is private working notes addressed to no one.” A brief-only restriction is the fallback, not a technical closure.

## 7. Subject, palette and taste steering survives (B, D)

- **Explicit added taste direction:** A/B:34–35 insist on “small, particular details” and “don't stop at broad passages.” This goes beyond the intended winter/summer/Friedrich assignment. Remove it if painters truly make every artistic decision.
- **Subject recipe and another painter:** A/B:29 require `friedrich/notes/research/trees.md`. That note selects trees/snow and supplies branching arithmetic, including daughter diameters of 0.71 and 0.87 of the parent, under “Leonardo's rule” (trees.md:3,7–12,24–30). It is botanical research, not an executable generator, but still teaches a specific subject and names another painter. Remove the note/read requirement for strict rule 5, or explicitly authorize that exception.
- **Materials notes still steer application/palette:** `friedrich/notes/research/friedrich_materials.md:9–18,92–94,126–149,182–188` prescribe characteristic thin layers, stippling, detail and green mixtures. These are sourced historical observations, but sourcing does not make them neutral. Retain only the explicitly intended materials exception; remove application sequences and praise-like wording (“lush variety”). Descriptions by dates/dimensions and “another painter” remain at :30–42, not artwork titles, but they retain identifiable art-history context.
- **Blank is not aesthetically neutral:** the shared guide supplies exact colored ground/pile recipes (:28,54–56,82–83), a landscape-world example with horizon, ground, water and sun (:332–346) and a “Finishing” block of aged varnish, cracks and relief (:397–409). Label aging operations optional or remove them, replace executable palette recipes with parameter forms and move landscape scaffolding out of the blank guide. These are steering examples, not proof of an automatic subject generator.

## 8. Required studio notes contradict the actual workflow (C — high practical risk)

- `S/notes/studio_notes.md:136–137` says `glaze()` waits for dry substrate and advances time. It actually **errors** on wet covered pixels (`S/crates/easel/src/api.rs:1078–1085`); the guide correctly says wait first or brush into wet paint (guide:217–223).
- Studio notes:73–76 promise automatic gap filling at coverage ≥1.5. `Handling::fills` defaults to false (`S/crates/paint/src/handling.rs:331–339`); guide:189 says explicit `fill=true` is required.
- Studio notes:175 says “With hand time on,” suggesting an optional setting; `time.rs:93–96` always enables it. Notes:201–205 discuss different live/render resolutions although live and replay are both fixed at 2400 (`main.rs:31–32,513`).

**Fix:** replace these statements with the implemented behavior, explicitly label old resolution discussion as irrelevant or remove it and eliminate wording implying optional hand time. Painters are required to read both documents, so leaving the accurate guide alongside stale notes is not enough.

## 9. Review provenance and people remain readable (B)

Both exports retain “finding 6” (`S/crates/easel/src/draw_outline.rs:368`), `owner_regressions` plus development commentary (`api.rs:1530–1535`) and dangling references to `paintings::run` (`S/crates/paint/src/checkpoint.rs:2`; `canvas.rs:164–165`). Remove review provenance and obsolete runner references, keeping behavior-focused explanations/test names.

Under a literal “no people anywhere” rule, research author names also violate it (`S/notes/research/oil_paint_physics.md:157–175`) as does the required copyright attribution (`S/THIRD_PARTY_NOTICES.md:14,23–24`). Do **not** delete legally required notices. Define a narrow citation/license exception or serve sanitized documentation without distributing the source package. No comprehensive absence-of-names claim is warranted from the builder's fixed-name scan.

## 10. Briefs omit delivery and leave important behavioral boundaries implicit (D)

All endings request only a title/optional description (`brief_A/B.md:41–43`; C/D:35–37), not a final save, session name or artifact path. The guide does explain startup and the default PNG path (`S/notes/easel_guide.md:20–48`), so startup is not absent, but its example closes after looking without saving (line 31). “Paint dries ... while you rest” in the briefs can suggest wall-clock drying; the guide correctly says real time between commands does not advance it (guide:369–373).

**Fix:** require one named session, a final `easel save` and the returned PNG/log paths in the completion reply. Say “Only painting operations and `wait(minutes)` advance virtual drying; waiting in the shell does not.” State no previews, alternate sessions, log edits, pixel decoding or alternative renderers if host isolation cannot be installed. State that the virtual clock is neither a budget nor a performance target. Make the scratch directory an explicit exception to “Work only there” and show valid shell syntax: `export TMPDIR="$scratch" TMP="$scratch" TEMP="$scratch"`, not “export TMPDIR=TMP=TEMP to it” (A/B:10,19–20; C/D:8,17–18).

## Confirmed useful restrictions, not loopholes

The live Lua canvas cannot be reset with a second `canvas{}` (`S/crates/easel/src/api.rs:1158–1160`). Lua omits file/OS libraries and removes file-loading functions (`session.rs:74–86`). Brush loading requires pile userdata (`api.rs:530–550`). Hand time is always enabled (`time.rs:93–96`); ordinary finite nonnegative waits have no artificial budget/cap (`api.rs:1399–1407`). `save` uses the current seen pixels, not a hypothetical dried rendering (`main.rs:490–498`). Failed chunks roll back internally (`session.rs:147–175`); without a visual output path inside the chunk, that alone is not a demonstrated image-preview loophole. These restrictions do not close the host-level bypasses above.
