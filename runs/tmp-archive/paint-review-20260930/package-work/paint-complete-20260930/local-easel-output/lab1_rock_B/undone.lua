--@ undone 1 · was chunk 2 · replaced by edit · 2536 bytes
-- B chunk 2: one session, alla prima. The picture planned as value families: the DARK family is
-- the rock's shadow side + its contact + its cast shadow (one connected shape across the rock/ground
-- boundary); the LIGHT family is the lit face + the sunlit heath. Sky first (two thin layers wet into
-- wet, one blend), then the sunlit heath with the whole rock and its shadow reserved, then the dark
-- family edge to edge with it (dark laid over wet light turned to lace in the foliage study).
ROCKM = rk:mask()
local c1, c7 = rk:cast():blur(1.2), rk:cast():blur(7)
local foot = rk.base
-- the cast shadow: crisp at the foot, softening as it runs out to the right
CASTM = mask(function(x, y) local t = smoothstep(700, 1000, x) return (1 - t) * c1:at(x, y) + t * c7:at(x, y) end) - ROCKM
SHADEM = rk:shadow(0.3) * ROCKM
DARKM = SHADEM + CASTM + rk:contact() * (-ROCKM)
-- the rock's surface normal (down-facing planes get the ground's bounce, sky-facing ones the sky)
NY = mask(function(x, y) if ROCKM:at(x, y) < 0.5 then return 0.5 end local s = rk:sample(x, y) return clamp((s.n[2] + 1) / 2, 0, 1) end):blur(3)
LITB = rk:lit(0.2):blur(10)
skym = above(function(x) return HZ + 6 end)
work(skym, {hand="broad", color=sky, angle=0, coverage=5, medium=0.22, load=1, pal=skypal, clip=skym})
work(skym, {hand="broad", color=sky, angle=0.01, coverage=3.5, medium=0.25, load=0.9, pal=skypal, clip=skym})
blend(skym, {angle=0, coverage=1.5, clip=skym})
local lit = land - ROCKM:shrink(1.5) - CASTM:shrink(1.5)
work(lit, {hand="body", color=groundcol, angle=0.03, length={14, 40}, coverage=3.4, medium=0.18, clip=lit})
-- the dark family: on the rock, cool where a plane turns to the sky, warm where it faces the heath,
-- darkest at the turn (core) and at the foot, where it takes the cast shadow's own value
SHADOWFN = function(x, y)
  local ny = NY:at(x, y)
  local c = mix("#5b5d62", "#51483d", smoothstep(0.4, 0.75, ny))
  c = mix(c, "#34322e", 0.6 * LITB:at(x, y))
  return mix(c, "#3a382b", smoothstep(foot - 40, foot - 4, y))
end
CASTFN = function(x, y)
  local far = smoothstep(740, 1000, x)
  return shift(groundcol(x, y), -0.2 + 0.07 * far, -0.004, -0.022 + 0.008 * far)
end
work(SHADEM, {hand="body", tool="filbert 5", color=SHADOWFN, angle=rk:field("plane"), length={8, 20}, coverage=3, medium=0.25, load=0.7, clip=ROCKM})
work(CASTM, {hand="body", tool="filbert 5", color=CASTFN, angle=0.04, length={14, 36}, coverage=3.2, medium=0.25, load=0.7, hug=false, clip=land - ROCKM:shrink(3)})
print(SHADEM:area(), CASTM:area(), foot)

--@ undone 2 · was chunk 2 · replaced by edit · 2637 bytes
-- B chunk 2: one session, alla prima. The picture planned as value families: the DARK family is
-- the rock's shadow side + its contact + its cast shadow (one connected shape across the rock/ground
-- boundary); the LIGHT family is the lit face + the sunlit heath. Sky first (two thin layers wet into
-- wet, one blend), then the sunlit heath with the whole rock and its shadow reserved, then the dark
-- family edge to edge with it (dark laid over wet light turned to lace in the foliage study).
ROCKM = rk:mask()
local c1, c7 = rk:cast():blur(1.2), rk:cast():blur(7)
local foot = rk.base
-- the cast shadow: crisp at the foot, softening as it runs out to the right; none under the lit
-- front (there a dark strip reads as an outline)
CASTM = mask(function(x, y) local t = smoothstep(700, 1000, x) return ((1 - t) * c1:at(x, y) + t * c7:at(x, y)) * smoothstep(400, 540, x) end) - ROCKM
SHADEM = rk:shadow(0.3) * ROCKM
DARKM = SHADEM + CASTM + rk:contact() * (-ROCKM)
-- the rock's surface normal (down-facing planes get the ground's bounce, sky-facing ones the sky)
NY = mask(function(x, y) if ROCKM:at(x, y) < 0.5 then return 0.5 end local s = rk:sample(x, y) return clamp((s.n[2] + 1) / 2, 0, 1) end):blur(3)
LITB = rk:lit(0.2):blur(10)
skym = above(function(x) return HZ + 6 end)
work(skym, {hand="broad", color=sky, angle=0, coverage=5, medium=0.22, load=1, pal=skypal, clip=skym})
work(skym, {hand="broad", color=sky, angle=0.01, coverage=3.5, medium=0.25, load=0.9, pal=skypal, clip=skym})
blend(skym, {angle=0, coverage=1.5, clip=skym})
local lit = land - ROCKM:shrink(1.5) - CASTM:shrink(1.5)
work(lit, {hand="body", color=groundcol, angle=0.03, length={14, 40}, coverage=3.4, medium=0.18, clip=lit})
-- the dark family: on the rock, cool where a plane turns to the sky, warm where it faces the heath,
-- darkest at the turn (core) and at the foot, where it takes the cast shadow's own value
SHADOWFN = function(x, y)
  local ny = NY:at(x, y)
  local c = mix("#5b5d62", "#51483d", smoothstep(0.4, 0.75, ny))
  c = mix(c, "#34322e", 0.6 * LITB:at(x, y))
  return mix(c, "#34332a", smoothstep(foot - 70, foot - 6, y))
end
CASTFN = function(x, y)
  local far = smoothstep(740, 1000, x)
  return shift(groundcol(x, y), -0.15 + 0.05 * far, -0.004, -0.02 + 0.008 * far)
end
work(SHADEM, {hand="body", tool="filbert 5", color=SHADOWFN, angle=rk:field("plane"), length={8, 20}, coverage=3.8, medium=0.25, load=0.85, clip=ROCKM})
work(CASTM, {hand="body", tool="filbert 5", color=CASTFN, angle=0.04, length={14, 36}, coverage=3.2, medium=0.25, load=0.7, hug=false, clip=land - ROCKM:shrink(3)})
print(SHADEM:area(), CASTM:area(), foot)

--@ undone 3 · was chunk 3 · replaced by edit · 1030 bytes
-- B chunk 3: next day, the shadow family SETTING (open, a light laid into it plows; tacky, it sits
-- as a flat slab). The lit face in few big strokes of stiffer paint, down each plane, its values
-- kept inside the light family (no chalk); at the terminator the strokes thin out into the setting
-- shadow (hug=false), so the form turns instead of splitting along a seam.
wait(1800)
print("shadow:", drying(600, 400), drying(560, 330), "ground:", drying(300, 560))
local v = rk:value()
local lo, hi = rk:levels(0.03, 0.97)
local mot = noise{seed=77, octaves=3, period=60}
LITFN = function(x, y)
  local t = smoothstep(lo, hi, v:at(x, y))
  local c = gradient({{0, "#6f6960"}, {0.45, "#8a8276"}, {0.75, "#a39a8a"}, {1, "#b7ad99"}}, t)
  return shift(c, 0.03 * mot(x, y), 0.004 * mot(x + 40, y), 0.008 * mot(x, y + 40))
end
LITM = rk:lit(0.25) * ROCKM
work(LITM, {hand="body", tool="filbert 5", color=LITFN, angle=rk:field("plane"), length={10, 24}, coverage=3.6, medium=0.15, load=0.85, hug=false, clip=ROCKM})
print(LITM:area())

--@ undone 4 · was chunk 4 · undone · 507 bytes
-- B chunk 4: the same session. The turn: a clean blender along the terminator only (the lit face
-- still open, the shadow setting), short strokes down the planes, so light turns into shadow over
-- a halftone instead of meeting it at a seam.
local lb = rk:lit(0.25):blur(7)
TERM = lb:map(function(v) return smoothstep(0.1, 0.35, v) * (1 - smoothstep(0.65, 0.9, v)) end) * ROCKM:shrink(3)
blend(TERM, {angle=rk:field("plane"), tool="filbert 4", length={6, 14}, coverage=1.6, clip=ROCKM})
print(TERM:area())

--@ undone 5 · was chunk 4 · undone · 1932 bytes
-- B chunk 4: next day, the lit face SETTING, ground and shadow tacky. Seat the foot: the lit face
-- darkens as it turns under toward the heath (occlusion, feathered up), and the heath itself grows
-- over the base in a few clustered tufts, so no line runs along the bottom (no pale strip, no dark
-- outline: the two old failures).
wait(1800)
print("lit face:", drying(320, 500), "ground:", drying(300, 560))
local foot = rk.base
-- the rock's own base line, per x (lowest point of the mask in each column)
BASEY = {}
for x = 250, 760, 2 do local yb = nil for y = 460, 560 do if ROCKM:at(x, y) > 0.5 then yb = y end end BASEY[x] = yb end
local function base(x) x = 2 * math.floor(x / 2) return BASEY[x] end
local occl = mask(function(x, y) local yb = base(x) if not yb then return 0 end return smoothstep(yb - 22, yb - 2, y) end) * ROCKM * rk:lit(0.1)
work(occl, {hand="body", tool="filbert 3", length={5, 12}, coverage=2.2, medium=0.2, load=0.6, hug=false, clip=ROCKM, angle=-1.45, angle_jitter=0.3,
  color_over=function(x, y, under) return shift(mix(under, "#5f5a4d", 0.45), 0, 0, 0.006) end})
-- tufts: clustered along the base, heavier in the lit front, a few in the shadow; dark stalks
-- with a lit tip here and there
local patch = noise{seed=78, period=40}
local g = brush("rigger", 0.9)
local cols = {"#4a4630", "#3b3a28", "#5d5838", "#6f6844", "#343325"}
local n = 0
for i = 1, 900 do
  local x = rand(250, 770)
  local yb = base(x)
  if yb and patch:at01(x, 0) > 0.45 then
    local y = yb + rand(-3, 14)
    local h = rand(6, 18) * (0.6 + patch:at01(x, 0))
    local a = -1.5708 + randn(0, 0.3)
    local curl = randn(0, 0.3)
    if n % 6 == 0 then g:reload(cols[(n // 6) % 5 + 1], 0.75) end
    g:stroke({{x, y}, {x + math.cos(a) * h * 0.5, y + math.sin(a) * h * 0.5}, {x + math.cos(a + curl) * h, y + math.sin(a + curl) * h}},
      {pressure={0.55, 0}, ramps={0.05, 0.75}})
    n = n + 1
  end
end
print("tufts", n)

--@ undone 6 · was chunk 4 · undone · 1977 bytes
-- B chunk 4: next day, the lit face SETTING, ground and shadow tacky. Seat the foot: the heath grows
-- up over the base in irregular clumps of its OWN colors (short scrubbed strokes rising from below
-- the base into the rock's setting foot), with a few darks where the rock undercuts, so no line
-- runs along the bottom (no pale strip, no dark outline: the two old failures). A first try with
-- ~600 rigger blades read as a beard of hair on the lit side and straw on the dark side.
wait(1800)
print("lit face:", drying(320, 500), "ground:", drying(300, 560))
BASEY = {}
for x = 250, 760, 2 do local yb = nil for y = 460, 560 do if ROCKM:at(x, y) > 0.5 then yb = y end end BASEY[x] = yb end
local function base(x) x = 2 * math.floor(x / 2) return BASEY[x] end
local patch = noise{seed=78, period=34}
local b = brush("filbert", 3)
local n = 0
for i = 1, 520 do
  local x = rand(252, 766)
  local yb = base(x)
  local p = patch:at01(x, 0)
  if yb and p > 0.35 then
    local y0 = yb + rand(2, 14)
    local reach = rand(4, 8 + 16 * p)
    local a = -1.5708 + randn(0, 0.25)
    local inshadow = CASTM:at(x, yb + 6) > 0.5 or SHADEM:at(x, yb - 6) > 0.5
    local c = inshadow and CASTFN(x, yb + 8) or groundcol(x, yb + 12)
    if rand() < 0.25 then c = shift(c, -0.08, 0, -0.01) end
    b:reload(c, 0.55)
    b:stroke({{x, y0}, {x + math.cos(a) * reach * 0.5, y0 + math.sin(a) * reach * 0.5}, {x + math.cos(a) * reach, y0 + math.sin(a) * reach}},
      {pressure={0.7, 0.05}, ramps={0.05, 0.7}})
    n = n + 1
  end
end
-- a few darks only where the rock turns under (its lowest few units), in short broken touches
local d = brush("round", 2.2)
local k = 0
for x = 256, 764, 5 do
  local yb = base(x)
  if yb and patch:at01(x + 300, 0) > 0.55 then
    if k % 5 == 0 then d:reload("#302d25", 0.7) end
    d:stroke({{x - rand(2, 5), yb - rand(0, 3)}, {x + rand(2, 5), yb + rand(-1, 1)}}, {pressure={0.6, 0.2}})
    k = k + 1
  end
end
print("heath strokes", n, "dark touches", k)

--@ undone 7 · was chunk 4 · undone · 1561 bytes
-- B chunk 4: next day, the lit face SETTING, ground and shadow tacky. Seat the foot: the heath grows
-- up over the base in irregular clumps of its OWN colors (short scrubbed strokes rising from below
-- the base into the rock's setting foot), so no line
-- runs along the bottom (no pale strip, no dark outline: the two old failures). A first try with
-- ~600 rigger blades read as a beard of hair on the lit side and straw on the dark side;
-- dark touches along the undercut read as a row of beads.
wait(1800)
print("lit face:", drying(320, 500), "ground:", drying(300, 560))
BASEY = {}
for x = 250, 760, 2 do local yb = nil for y = 460, 560 do if ROCKM:at(x, y) > 0.5 then yb = y end end BASEY[x] = yb end
local function base(x) x = 2 * math.floor(x / 2) return BASEY[x] end
local patch = noise{seed=78, period=34}
local b = brush("filbert", 3)
local n = 0
for i = 1, 520 do
  local x = rand(252, 766)
  local yb = base(x)
  local p = patch:at01(x, 0)
  if yb and p > 0.35 then
    local y0 = yb + rand(2, 14)
    local reach = rand(4, 8 + 16 * p)
    local a = -1.5708 + randn(0, 0.25)
    local inshadow = CASTM:at(x, yb + 6) > 0.5 or SHADEM:at(x, yb - 6) > 0.5
    local c = inshadow and CASTFN(x, yb + 8) or groundcol(x, yb + 12)
    if rand() < 0.25 then c = shift(c, -0.08, 0, -0.01) end
    b:reload(c, 0.55)
    b:stroke({{x, y0}, {x + math.cos(a) * reach * 0.5, y0 + math.sin(a) * reach * 0.5}, {x + math.cos(a) * reach, y0 + math.sin(a) * reach}},
      {pressure={0.7, 0.05}, ramps={0.05, 0.7}})
    n = n + 1
  end
end
print("heath strokes", n)

--@ undone 8 · was chunk 3 · replaced by edit · 1216 bytes
-- B chunk 3: next day, the shadow family SETTING (open, a light laid into it plows; tacky, it sits
-- as a flat slab). The lit face in few big strokes of stiffer paint, down each plane, its values
-- kept inside the light family (no chalk); at the terminator the strokes thin out into the setting
-- shadow (hug=false), so the form turns instead of splitting along a seam.
wait(1800)
print("shadow:", drying(600, 400), drying(560, 330), "ground:", drying(300, 560))
local v = rk:value()
local lo, hi = rk:levels(0.03, 0.97)
local mot = noise{seed=77, octaves=3, period=60}
LITFN = function(x, y)
  local t = smoothstep(lo, hi, v:at(x, y))
  local c = gradient({{0, "#6f6960"}, {0.45, "#8a8276"}, {0.75, "#a39a8a"}, {1, "#b7ad99"}}, t)
  return shift(c, 0.03 * mot(x, y), 0.004 * mot(x + 40, y), 0.008 * mot(x, y + 40))
end
-- the crack groove fell in the shadow family (a wide dark band): the light goes over it; the crack
-- is restated later as one thin stroke
LITM = (rk:lit(0.25) + rk:cracks():grow(3) * rk:lit(0.1):grow(8)) * ROCKM
work(LITM, {hand="body", tool="filbert 5", color=LITFN, angle=rk:field("plane"), length={10, 24}, coverage=3.6, medium=0.15, load=0.85, hug=false, clip=ROCKM})
print(LITM:area())

--@ undone 9 · was chunk 5 · undone · 398 bytes

-- B chunk 5: the same session. The accents, very few: the lights where the top turns toward the
-- sun (the lit arrises only, thin coverage), laid into the setting lit face.
local ar = rk:arrises() * rk:lit(0.35) * rk:up(0.2, 0.6)
work(ar, {hand="detail", tool="round 2", color="#bcb19b", angle=rk:field("crack"), length={4, 10}, coverage=0.7, clip=ROCKM, hug=false, medium=0.1})
print(ar:area())

