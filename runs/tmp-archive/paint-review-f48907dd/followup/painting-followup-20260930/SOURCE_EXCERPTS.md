# Archived source excerpts for the follow-up

These are exact numbered excerpts from the supplied archive, not from the unseen experimental worktree. Source paths are relative to `repos/claude-paint`. No source bytes were modified.

## crates/paint/src/bristle.rs

SHA-256: `20e30838c8f36a32f38a388e55ecb6d4fb3d9f0716f4462c4e2e98051aea3011`

### Lines 30–65

```text
  30 /// The level a brush rests on around each pixel: the median height within
  31 /// about `r` px either side (a running median along the rows, then along the
  32 /// columns, over ±1.5 r), smoothed a little (a box blur of radius r/3).
  33 /// The weave and brush-mark relief, a tooth or so either side, sits about
  34 /// its median. A step of thick paint doesn't lift the level of the thin
  35 /// paint beside it (with a mean, the thin side would be a valley ~2r wide
  36 /// that no bristle reaches, and paint laid up to the step would stop short
  37 /// of it). Only the corner right at the foot of the step is missed.
  38 pub(crate) fn contact_level(height: &[f32], w: usize, h: usize, r: usize) -> Vec<f32> {
  39     use rayon::prelude::*;
  40     // a window of ±1.5 r
  41     let rm = (3 * r).div_ceil(2).max(1);
  42     let rows = |src: &[f32], w: usize| -> Vec<f32> {
  43         let mut out = vec![0.0f32; src.len()];
  44         out.par_chunks_mut(w).zip(src.par_chunks(w)).for_each(|(o, s)| running_median(s, rm, o));
  45         out
  46     };
  47     let t = transpose(&rows(height, w), w, h);
  48     let m = transpose(&rows(&t, h), h, w);
  49     crate::surface::box_blur(&m, w, h, (r / 3).max(1))
  50 }
  51 
  52 /// Median of `s[i - r ..= i + r]` (edges repeated) into `out[i]`.
  53 fn running_median(s: &[f32], r: usize, out: &mut [f32]) {
  54     let n = s.len();
  55     let at = |i: isize| s[i.clamp(0, n as isize - 1) as usize];
  56     let mut win: Vec<f32> = (-(r as isize)..=r as isize).map(at).collect();
  57     win.sort_by(f32::total_cmp);
  58     for (i, o) in out.iter_mut().enumerate() {
  59         *o = win[r];
  60         let (gone, come) = (at(i as isize - r as isize), at(i as isize + r as isize + 1));
  61         let k = win.partition_point(|v| v.total_cmp(&gone).is_lt());
  62         win.remove(k);
  63         let k = win.partition_point(|v| v.total_cmp(&come).is_lt());
  64         win.insert(k, come);
  65     }
```

### Lines 550–570

```text
 550     fh: usize,
 551     scale: f32,
 552     vol: *mut f32,
 553     lat: *mut Latent,
 554     hide: *mut Prop,
 555     stroke: *mut u32,
 556     touched: *mut u32,
 557     floor: *mut f32,
 558     cover: *mut f32,
 559     base: *const f32,
 560     /// Drying state (null until the canvas has waited): how open or tacky
 561     /// the paint under a bristle is (see `drying::feel`).
 562     dry: *mut crate::drying::Px,
 563     /// Paint laid or moved updates the film's cure at once (see `add`;
 564     /// engine 2). Engine 1 left it to the next `wait`.
 565     cure_now: bool,
 566 }
 567 // SAFETY: callers only run brushes concurrently on pixel sets that cannot
 568 // overlap (tiles separated by more than the largest stroke extent).
 569 unsafe impl Send for Surf {}
 570 unsafe impl Sync for Surf {}
```

### Lines 582–623

```text
 582 impl Surf {
 583     /// Lay `v` coats of paint of cure `cure` (0: fresh) at pixel `i`: it
 584     /// mixes by volume into the color and into the film's cure, so the next
 585     /// bristle feels the film as it now is, not as it was at the last wait.
 586     #[inline]
 587     unsafe fn add(&self, i: usize, v: f32, lat: &Latent, hide: Prop, cure: f32) {
 588         unsafe {
 589             if v <= 0.0 {
 590                 return;
 591             }
 592             let vol = &mut *self.vol.add(i);
 593             let l = &mut *self.lat.add(i);
 594             let hd = &mut *self.hide.add(i);
 595             let t = *vol + v;
 596             let a = v / t;
 597             for k in 0..LAT {
 598                 l[k] += (lat[k] - l[k]) * a;
 599             }
 600             for k in 0..hd.len() {
 601                 hd[k] += (hide[k] - hd[k]) * a;
 602             }
 603             if self.cure_now && !self.dry.is_null() {
 604                 // (a film too thin for `wait` to count is bare: no cure)
 605                 let p = &mut *self.dry.add(i);
 606                 p.cure = if t < 1e-5 { 0.0 } else { p.cure + (cure - p.cure) * a };
 607             }
 608             *vol = t;
 609         }
 610     }
 611 
 612     /// Lift `v` coats off pixel `i`. The paint left keeps its cure; a pixel
 613     /// left bare (as `wait` judges it) holds no film to have one.
 614     #[inline]
 615     unsafe fn take(&self, i: usize, v: f32) {
 616         unsafe {
 617             let vol = &mut *self.vol.add(i);
 618             *vol -= v;
 619             if self.cure_now && *vol < 1e-5 && !self.dry.is_null() {
 620                 (*self.dry.add(i)).cure = 0.0;
 621             }
 622         }
 623     }
```

### Lines 1357–1409

```text
1357                     sf.add(i, dep_per_w * wt, &blat, bhide, bcure);
1358                     *sf.stroke.add(i) = id;
1359                 }
1360                 // plough: move paint outward from the bristle's path, and ahead
1361                 if push_k > 0.0 {
1362                     let v = *sf.vol.add(i);
1363                     let m = v * push_k * wt * fl;
1364                     if m > 1e-6 {
1365                         let (px, py) = (x as f32 + 0.5, y as f32 + 0.5);
1366                         let side = if (px - a.0) * nx + (py - a.1) * ny >= 0.0 { 1.0 } else { -1.0 };
1367                         let tx = px + (nx * side * 0.75 + mx * 0.45) * off;
1368                         let ty = py + (ny * side * 0.75 + my * 0.45) * off;
1369                         // where the paint goes: the pixel under the target,
1370                         // or for a moving hair, shared
1371                         // bilinearly by the four pixels around it (a hair
1372                         // finer than a pixel would otherwise leave a ridge
1373                         // of dots along its track where rounding lands it)
1374                         let mut to = [(0.0f32, 0.0f32, 0.0f32); 4];
1375                         let n_to = if spread {
1376                             let (gx, gy) = (tx - 0.5, ty - 0.5);
1377                             let (fx, fy) = (gx - gx.floor(), gy - gy.floor());
1378                             let (bx, by) = (gx.floor() + 0.5, gy.floor() + 0.5);
1379                             to = [(bx, by, (1.0 - fx) * (1.0 - fy)), (bx + 1.0, by, fx * (1.0 - fy)), (bx, by + 1.0, (1.0 - fx) * fy), (bx + 1.0, by + 1.0, fx * fy)];
1380                             4
1381                         } else {
1382                             to[0] = (tx, ty, 1.0);
1383                             1
1384                         };
1385                         for &(tx, ty, share) in &to[..n_to] {
1386                             if share <= 0.0 {
1387                                 continue;
1388                             }
1389                             // (paint pushed out of a crop window stays put)
1390                             let inside = tx >= ox as f32 && ty >= oy as f32 && (tx as usize) < w.min(ox + sf.w) && (ty as usize) < h.min(oy + sf.h);
1391                             debug_assert!(!inside || (tx >= lim.0 as f32 && ty >= lim.1 as f32 && (tx as usize) < lim.2 && (ty as usize) < lim.3), "plough target outside the stroke footprint {lim:?}");
1392                             if inside && tx >= lim.0 as f32 && ty >= lim.1 as f32 && (tx as usize) < lim.2 && (ty as usize) < lim.3 {
1393                                 let (tx, ty) = (tx as usize, ty as usize);
1394                                 let j = (ty - oy) * bw_buf + tx - ox;
1395                                 // a clipped stroke can't push paint past its mask:
1396                                 // only the accepted share moves, the rest stays
1397                                 let m = m * share * clip.map_or(1.0, |c| c.at(ty * w + tx).0);
1398                                 if j != i && m > 0.0 {
1399                                     let l = *sf.lat.add(i);
1400                                     let hd = *sf.hide.add(i);
1401                                     let cure = if sf.dry.is_null() { 0.0 } else { (*sf.dry.add(i)).cure };
1402                                     // the paint moved covers its share of
1403                                     // the pixel it came from
1404                                     // (its film there thins but still covers it)
1405                                     let cj = &mut *sf.cover.add(j);
1406                                     *cj = if fine { ((if *sf.vol.add(j) < 1e-6 { 0.0 } else { *cj }) + (m / v.max(1e-9)).min(1.0) * *sf.cover.add(i)).min(1.0) } else { 1.0 };
1407                                     sf.take(i, m);
1408                                     sf.add(j, m, &l, hd, cure);
1409                                 }
```

## crates/paint/src/surface.rs

SHA-256: `10949d67a21698071b3e81c22fb0347e4b0815fc732e3391fab7ceb84187bae9`

### Lines 157–190

```text
 157 /// Separable box blur of a rect-sized buffer (w × h), radius r, clamped.
 158 pub(crate) fn box_blur(src: &[f32], w: usize, h: usize, r: usize) -> Vec<f32> {
 159     if r == 0 {
 160         return src.to_vec();
 161     }
 162     let n = (2 * r + 1) as f32;
 163     let mut tmp = vec![0.0f32; w * h];
 164     tmp.par_chunks_mut(w).enumerate().for_each(|(y, row)| {
 165         let s = &src[y * w..(y + 1) * w];
 166         let mut acc = 0.0f32;
 167         for k in 0..=2 * r {
 168             acc += s[k.saturating_sub(r).min(w - 1)];
 169         }
 170         for (x, o) in row.iter_mut().enumerate() {
 171             *o = acc / n;
 172             acc += s[(x + r + 1).min(w - 1)] - s[x.saturating_sub(r)];
 173         }
 174     });
 175     let mut out = vec![0.0f32; w * h];
 176     // vertical: running sums per column, processed in column blocks
 177     let cols: Vec<usize> = (0..w).collect();
 178     let colvals: Vec<Vec<f32>> = cols
 179         .par_chunks(64)
 180         .map(|cs| {
 181             let mut res = vec![0.0f32; cs.len() * h];
 182             for (ci, &x) in cs.iter().enumerate() {
 183                 let mut acc = 0.0f32;
 184                 for k in 0..=2 * r {
 185                     acc += tmp[k.saturating_sub(r).min(h - 1) * w + x];
 186                 }
 187                 for y in 0..h {
 188                     res[ci * h + y] = acc / n;
 189                     acc += tmp[(y + r + 1).min(h - 1) * w + x] - tmp[y.saturating_sub(r) * w + x];
 190                 }
```

## crates/easel/src/session.rs

SHA-256: `d749ab456628a53b5ba1a1b66734fe1642e7219b2ef95fe6c38789ad020dbdbd`

### Lines 27–36

```text
  27 pub const ENGINE_MARK: &str = "--@ engine";
  28 
  29 /// The longest a chunk of a live session may run (the longest of 2,502 painters' chunks on
  30 /// 2026-09-27 took 94 s). A chunk that runs longer is stopped like a failed one: nothing it
  31 /// did is kept. Replays have no limit: a chunk in the log succeeded once and must replay the
  32 /// same on a slower or busier machine.
  33 pub const CHUNK_LIMIT: Duration = Duration::from_secs(600);
  34 /// Lua instructions between two looks at the clock.
  35 const HOOK_EVERY: u32 = 1_000_000;
  36 
```

### Lines 130–139

```text
 130         api::install(&lua, st.clone())?;
 131         let deadline = Rc::new(Cell::new(None::<Instant>));
 132         let d = deadline.clone();
 133         lua.set_hook(mlua::HookTriggers::new().every_nth_instruction(HOOK_EVERY), move |_, _| match d.get() {
 134             Some(t) if Instant::now() > t => Err(mlua::Error::runtime(format!(
 135                 "the chunk ran longer than {} minutes and was stopped; nothing it did was kept",
 136                 CHUNK_LIMIT.as_secs() / 60
 137             ))),
 138             _ => Ok(mlua::VmState::Continue),
 139         })?;
```

### Lines 168–172

```text
 168     /// Replaying (reopening a log): no snapshot before each chunk, since a failed chunk ends
 169     /// the reopen anyway, and no time limit. Off again once the log is in.
 170     pub fn set_replaying(&mut self, on: bool) {
 171         self.replay = on;
 172     }
```

### Lines 246–286

```text
 246         let mut snap = if !self.replay { Some(self.snap().map_err(|e| e.to_string())?) } else { None };
 247         let n = self.log.len() as u64 + 1;
 248         self.prelude.as_ref().unwrap().0.call::<()>(()).map_err(|e| e.to_string())?;
 249         self.st.borrow_mut().begin(n);
 250         let t0 = Instant::now();
 251         let chunk = self.lua.load(src.as_str()).set_name(format!("chunk {n}"));
 252         let check = self.prelude.as_ref().unwrap().2.clone();
 253         let deadline = (!self.replay).then(|| t0 + self.chunk_limit);
 254         self.deadline.set(deadline);
 255         let r = std::panic::catch_unwind(std::panic::AssertUnwindSafe(|| chunk.exec().and_then(|()| check.call::<()>(()))));
 256         self.deadline.set(None);
 257         // the hand time the chunk spent goes on the clock before it ends
 258         if matches!(r, Ok(Ok(()))) {
 259             crate::time::flush(&self.st, true);
 260         }
 261         let secs = t0.elapsed().as_secs_f64();
 262         let out = self.st.borrow().out.clone();
 263         let fail = match r {
 264             Ok(Ok(())) => None,
 265             Ok(Err(e)) => Some(clean_error(&e.to_string())),
 266             Err(p) => Some(format!("engine panic: {}", p.downcast_ref::<String>().cloned().or(p.downcast_ref::<&str>().map(|s| s.to_string())).unwrap_or_default())),
 267         };
 268         // Rollback must finish even after the chunk exhausted its deadline. The
 269         // private restore uses raw operations and runs no painter code; collection
 270         // below reinstates the deadline because it can run Lua work.
 271         // put back what a failed chunk did (no painter code runs in restore)
 272         if fail.is_some()
 273             && let Some(snap) = snap.take()
 274         {
 275             self.stale = self.restore(&snap).map_err(|e| e.to_string())? > 0;
 276         }
 277         // before collecting: the values the chunk replaced aren't held here any more
 278         if fail.is_none() {
 279             self.note_globals(n as usize).map_err(|e| e.to_string())?;
 280         }
 281         // masks and brushes hold memory Lua can't see: collect between chunks, without the
 282         // snapshot, as a replay does, and within the chunk's time
 283         drop(snap);
 284         self.deadline.set(deadline);
 285         let _ = self.lua.gc_collect();
 286         self.deadline.set(None);
```

### Lines 625–646

```text
 625 /// The engine version a session file names in its head (its `ENGINE_MARK`
 626 /// line before the first chunk): 1 if it names none.
 627 pub fn logged_engine(text: &str) -> Result<u32, String> {
 628     let mut found = None;
 629     for l in text.lines() {
 630         let l = l.trim();
 631         if l.starts_with(MARK) {
 632             break;
 633         }
 634         if let Some(rest) = l.strip_prefix(ENGINE_MARK) {
 635             let v = rest.strip_prefix(' ').and_then(|v| v.trim().parse::<u32>().ok()).filter(|v| (1..=paint::ENGINE).contains(v));
 636             let Some(v) = v else {
 637                 return Err(format!("the log's line {l:?} names no engine this easel has ({ENGINE_MARK} <1 to {}>)", paint::ENGINE));
 638             };
 639             if found.is_some() {
 640                 return Err(format!("the log names its engine twice ({ENGINE_MARK} lines)"));
 641             }
 642             found = Some(v);
 643         }
 644     }
 645     Ok(found.unwrap_or(1))
 646 }
```

## harness/painter/easel-client.ts

SHA-256: `a0ab6ad04628271de5268d723d9b50356f13dcea4f62d25001d1304c74990d76`

### Lines 18–45

```text
  18 /** Tool budgets include opening, except advancing log rebuilds get a separate stall budget.
  19  * A chunk may run 10 minutes (the easel's own limit).
  20  */
  21 export const WAIT_MS = { do: 12 * 60_000, other: 3 * 60_000, rebuild: 30 * 60_000 };
  22 
  23 /** Run the studio's easel client with `args`, `input` on stdin; stdout and stderr together, in order. */
  24 export function easel(studio: string, args: string[], input?: string, signal?: AbortSignal, waitMs?: number): Promise<Ran> {
  25 	return new Promise((done, fail) => {
  26 		if (signal?.aborted) return fail(new Error("Operation aborted"));
  27 		const env = { PATH: "/usr/bin:/bin", HOME: process.env.HOME ?? "" };
  28 		// its own process group: a timeout or an abort stops it and anything it started
  29 		const p = spawn(join(studio, "bin", "easel"), args, { cwd: studio, env, stdio: ["pipe", "pipe", "pipe"], detached: true });
  30 		const kill = () => {
  31 			try {
  32 				process.kill(-p.pid!, "SIGTERM");
  33 			} catch {
  34 				p.kill("SIGTERM");
  35 			}
  36 		};
  37 		let timedOut = false;
  38 		const timer = waitMs ? setTimeout(() => ((timedOut = true), kill()), waitMs) : undefined;
  39 		signal?.addEventListener("abort", kill, { once: true });
  40 		const end = () => (clearTimeout(timer), signal?.removeEventListener("abort", kill));
  41 		let out = "";
  42 		p.stdout.on("data", (d) => (out += d));
  43 		p.stderr.on("data", (d) => (out += d));
  44 		p.on("error", (e) => (end(), fail(e)));
  45 		p.on("close", (code) => (end(), done({ code: timedOut ? null : code, out: timedOut ? "" : out, timedOut } as Ran)));
```

### Lines 97–107

```text
  97 export async function atEasel(studio: string, args: string[], input: string | undefined, signal?: AbortSignal): Promise<string> {
  98 	const wait = args[0] === "do" ? WAIT_MS.do : WAIT_MS.other;
  99 	let deadline = Date.now() + wait;
 100 	if (await ensureOpen(studio, signal, deadline)) deadline = Date.now() + wait;
 101 	const r = await step(studio, args, input, signal, deadline);
 102 	if (r.timedOut) {
 103 		throw new Error(`the easel didn't answer within ${wait / 60_000} minutes; \`status\` shows whether the chunk count changed`);
 104 	}
 105 	const text = r.out.trimEnd();
 106 	if (r.code !== 0) throw new Error(text || "the easel gave no answer");
 107 	return text;
```

## crates/paint/src/sched.rs

SHA-256: `e218b41d56d334b3740c6faa8145cca29ac677563c8af4ad6f205ecce37fd33a`

### Lines 152–187

```text
 152     pub(crate) fn paint_pass(&mut self, pass: Pass, paint: impl Fn(Surf, usize, u32) -> Bounds + Sync) {
 153         let Pass { grid, order, rects, secs, ids, slice } = pass;
 154         let order = match order {
 155             TileOrder::Default(_) if slice.is_some() => sweep_down(grid),
 156             TileOrder::Asked(o) | TileOrder::Default(o) => o,
 157         };
 158         let batches = batches(&order, &secs, slice);
 159         let n_batches = batches.len();
 160         let mut offsets = vec![0u32; ids.len()];
 161         for (bi, (order, bsecs)) in batches.into_iter().enumerate() {
 162             let mut in_batch = order.clone();
 163             in_batch.sort_unstable();
 164             let n: u32 = in_batch.iter().map(|&t| ids[t]).sum();
 165             let first = if n > 0 { self.next_stroke_ids(n) } else { 0 };
 166             let mut acc = 0u32;
 167             for &t in &in_batch {
 168                 offsets[t] = acc;
 169                 acc += ids[t];
 170             }
 171             let f = self.f;
 172             let order: Vec<usize> = order.into_iter().filter(|&t| rects[t].is_some_and(|r| f.clip(r).is_some())).collect();
 173             if std::env::var_os("PAINT_DEBUG").is_some() {
 174                 eprintln!("  {} tiles", order.len());
 175             }
 176             let surf = self.surf();
 177             // tiles run in parallel wherever that can't change the result: a
 178             // tile starts once every earlier tile (in `order`) it overlaps is
 179             // done
 180             let dirty = run_ordered(&order, &rects, |t| paint(surf, t, first.wrapping_add(offsets[t]))).into_iter().fold(None, union);
 181             if let Some((x0, y0, x1, y1)) = dirty {
 182                 self.wet.touch(x0, y0, x1, y1);
 183             }
 184             if bi + 1 < n_batches {
 185                 self.hand_pass(bsecs);
 186             }
 187         }
```

### Lines 191–210

```text
 191 /// Tiles (indices in painting `order`) in consecutive batches of about
 192 /// `slice` seconds of hand time each (`secs` per tile), with each batch's
 193 /// seconds. No slice (hand time off): one batch of everything. The cut
 194 /// follows the whole canvas's plan, so a crop ages its window on the same
 195 /// timeline.
 196 fn batches(order: &[usize], secs: &[f64], slice: Option<f64>) -> Vec<(Vec<usize>, f64)> {
 197     let Some(slice) = slice.filter(|s| *s > 0.0) else {
 198         return vec![(order.to_vec(), order.iter().map(|&t| secs[t]).sum())];
 199     };
 200     let mut out: Vec<(Vec<usize>, f64)> = vec![(Vec::new(), 0.0)];
 201     for &t in order {
 202         let last = out.last_mut().unwrap();
 203         if last.1 >= slice {
 204             out.push((vec![t], secs[t]));
 205         } else {
 206             last.0.push(t);
 207             last.1 += secs[t];
 208         }
 209     }
 210     out
```

## crates/paint/src/handling.rs

SHA-256: `8ceaf5d3efb9ffe55cb5166896bb731ea396ff2bfd05275ad0356d1c889138fd`

### Lines 718–767

```text
 718     fn run_plans(&mut self, plans: Vec<(f32, f32, Option<Rect>, Plan)>, (ex, ey): (f32, f32), gap: f32, tool: &Tool, hd: &Handling, ramps: (f32, f32), clip: Option<Clip<'_>>, seed: u64, rng: &mut Rng, piles: &mut Piles, slice: Option<f64>) {
 719         let f = self.f;
 720         // tiles are sized per axis from the footprints: tiles painted at the
 721         // same time are one tile apart, so a tile at least twice the largest
 722         // reach keeps their pixels disjoint (long horizontal strokes get wide,
 723         // short tiles)
 724         let margin = 2.0 / f.scale;
 725         let (tile_x, tile_y) = ((2.0 * ex + margin).max(gap * 2.0), (2.0 * ey + margin).max(gap * 2.0));
 726         let (tw, th) = ((f.width() / tile_x).ceil().max(1.0) as usize, (f.height() / tile_y).ceil().max(1.0) as usize);
 727         if std::env::var_os("PAINT_DEBUG").is_some() {
 728             eprintln!("work: {} strokes, reach {ex:.0}x{ey:.0}, tiles {tw}x{th}", plans.len());
 729         }
 730         let mut tiles: Vec<Vec<Plan>> = (0..tw * th).map(|_| Vec::new()).collect();
 731         // pixel footprint of each tile: the union of its strokes'
 732         let mut rects: Vec<Option<Rect>> = vec![None; tw * th];
 733         for (cx, cy, rect, p) in plans {
 734             let tx = ((cx / tile_x) as usize).min(tw - 1);
 735             let ty = ((cy / tile_y) as usize).min(th - 1);
 736             let t = ty * tw + tx;
 737             if let Some(r) = rect {
 738                 rects[t] = crate::sched::union(rects[t], Some(r));
 739                 tiles[t].push(p);
 740             }
 741         }
 742         // trips to the palette: every `dip_every` strokes within a tile, and
 743         // whenever the next stroke is in a new passage
 744         // (and the hand's ledger: every planned stroke and trip, counted on
 745         // the whole canvas before a crop drops any tiles; see `tally`)
 746         let mpu = self.mm_per_unit;
 747         let mut secs = Vec::with_capacity(tiles.len());
 748         for t in tiles.iter_mut() {
 749             let secs0 = self.tally.secs;
 750             let (mut since, mut last) = (0, None);
 751             for p in t.iter_mut() {
 752                 let moved = last != Some(p.passage);
 753                 last = Some(p.passage);
 754                 if since % hd.dip_every != 0 && !moved {
 755                     p.dip = None;
 756                     since += 1;
 757                 } else {
 758                     since = 1;
 759                 }
 760                 self.tally.stroke(tool, &p.pts, mpu);
 761                 if p.dip.is_some() {
 762                     if hd.blender {
 763                         self.tally.wipe();
 764                     } else if p.fresh {
 765                         self.tally.reload(1.0 / crate::tally::pace::DABS_PER_RELOAD);
 766                     } else {
 767                         piles.trip(&mut self.tally, p.want);
```

## crates/paint/src/canvas.rs

SHA-256: `d09092ece0824c85839563c846b34735ee8ff58eef145740d5cc6f89d0770795`

### Lines 277–300

```text
 277     /// A ground layer over the whole canvas: `um` µm of paint of `color` and
 278     /// `hiding`, spread with a knife or broad brush, leveled and set.
 279     /// `stiff` 0..1 is its body (fluid chalk-glue ≈ 0.2, oil lead white ≈ 0.6);
 280     /// `texture` 0..1 roughens it before it levels (a roller or scraped knife).
 281     pub fn prime(&mut self, color: Rgb, hiding: f32, um: f32, stiff: f32, texture: f32, seed: u64) {
 282         self.dry();
 283         let (w, h) = (self.f.w, self.f.h);
 284         let (ox, oy) = (self.f.x0, self.f.y0);
 285         let px = self.px_mm();
 286         let add: Vec<f32> = (0..w * h)
 287             .into_par_iter()
 288             .map(|i| {
 289                 let (x, y) = ((i % w + ox) as f32 * px, (i / w + oy) as f32 * px);
 290                 let n = 0.65 * vnoise(x / 0.3, y / 0.3, seed) + 0.35 * vnoise(x / 0.9, y / 0.9, seed + 1) - 0.5;
 291                 um * (1.0 + texture * 1.4 * n).max(0.0)
 292             })
 293             .collect();
 294         let sv = vec![stiff; w * h];
 295         let t = self.settle((0, 0, w, h), &add, &sv);
 296         let pig = Pigment::masstone_hiding(color, hiding);
 297         self.px.par_iter_mut().zip(&t).for_each(|(p, &ti)| *p = pig.over(*p, ti / COAT_UM));
 298         self.film.par_iter_mut().zip(&t).for_each(|(f, &ti)| *f += ti / COAT_UM);
 299         self.ground_um += um;
 300     }
```
