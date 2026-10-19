--@ undone 1 · was chunk 2 · undone · 1026 bytes

-- B1: masses first, one sitting. The bank, its earth and its reflection are ONE dark shape:
-- laid together, thin, the bush in a few big turning strokes, the reflection pulled DOWN in
-- vertical strokes (as a brush drags a reflection), the earth level. Far shore and its
-- reflection likewise as one band.
darkm = bank + refl
local turn = noise{seed=7, period=30}
work(bush, {hand="body", tool="filbert 6", color=bushcol, angle=function(x, y) return 1.2 + 1.2*turn(x, y) end,
  length={10, 26}, coverage=2.6, medium=0.3, load=0.8})
work(earth, {hand="body", tool="filbert 5", color=earthcol, angle=0.03, length={20, 60}, coverage=2.6, medium=0.3, load=0.8})
work(refl, {hand="body", tool="filbert 6", color=reflsrc, angle=math.pi/2, angle_jitter=0.05, length={12, 40}, coverage=2.8, medium=0.35, load=0.8})
farband = far + farrefl
work(farband, {hand="body", tool="filbert 4", color=function(x, y) return y < HZ and farcol(x, y) or farreflcol(x, y) end,
  angle=0.02, length={30, 90}, coverage=2.6, medium=0.3, load=0.8})

--@ undone 2 · was chunk 4 · undone · 926 bytes

-- B3: same sitting, the darks still open: the sky and the water laid AROUND them in long level
-- strokes of thin paint, a slow band noise so neither is an even ramp. Unclipped: the sky runs
-- over the far crest (lost there), the water strokes run into the reflection edges and soften them.
sn = noise{seed=31, octaves=3, period=200, stretch={0, 7}}
local band = function(c, x, y, k) local v = sn(x, y); return shift(c, k*v, 0, 0.3*k*v) end
work(skym - bank, {hand="broad", color=function(x, y) return band(skycol(x, y), x, y, 0.018) end, angle=0, angle_jitter=0.015,
  length={120, 320}, coverage=3.8, medium=0.4, load=0.7, pal=skypal})
openw = water - refl - farrefl
work(openw, {hand="broad", color=function(x, y) return band(watercol(x, y), x, y + 400, 0.012) end, angle=0, angle_jitter=0.004,
  curve={0, 0}, length={120, 320}, coverage=3.8, medium=0.4, load=0.7, pal=skypal})
print(drying(300, 650), drying(300, 520))

--@ undone 3 · was chunk 6 · undone · 637 bytes

-- B5: same sitting: a few unequal lights laid into the wet bush (not a layer): three or four
-- lit masses toward the upper left, gated by a coarse noise, a warm light olive
local pn = noise{seed=5, octaves=2, period=55}
litm = (bush * mask(function(x, y)
  return (1 - smoothstep(banktop(x) + 6, banktop(x) + 40, y)) * (1 - smoothstep(180, 500, x)) * smoothstep(0.0, 0.35, pn(x, y))
end)):blur(2)
local turn = noise{seed=7, period=30}
work(litm, {hand="body", tool="filbert 4", color="#7d7c4a", angle=function(x, y) return 1.2 + 1.2*turn(x, y) end,
  length={6, 16}, coverage=1.6, medium=0.25, load=0.8, hug=false})
print(litm:area())

--@ undone 4 · was chunk 7 · undone · 537 bytes

-- B6: the one accent: a thin broken sheen where the bank meets the water, three strokes of a
-- rigger along the waterline, the water color lifted; laid into the open paint
print(drying(300, WL(300) + 2))
local r = brush("rigger", 1.2)
for _, run in ipairs({{70, 240}, {300, 430}, {470, 630}}) do
  local pts = {}
  for x = run[1], run[2], 8 do pts[#pts + 1] = {x, WL(x) + 1.8 + randn(0, 0.25)} end
  r:reload(shift(watercol(run[1], HZ + 40), 0.03, 0, 0), 0.7)
  r:stroke(pts, {pressure={0.1, 0.55, 0.5, 0.05}, ramps={0.25, 0.35}})
end

--@ undone 5 · was chunk 7 · replaced by edit · 525 bytes

-- B6: the one accent: a broken sheen where the bank meets the water, three strokes of a round
-- brush along the waterline, the pale low sky as the water mirrors it; laid into the open paint
local r = brush("round", 2.4)
for _, run in ipairs({{60, 230}, {290, 420}, {480, 636}}) do
  local pts = {}
  for x = run[1], run[2], 8 do pts[#pts + 1] = {x, WL(x) + 2.2 + randn(0, 0.3)} end
  r:reload(shift(watercol(run[1], HZ + 30), 0.02, 0, 0), 0.8)
  r:stroke(pts, {pressure={0.15, 0.7, 0.45, 0.65, 0.1}, ramps={0.2, 0.3}})
end

