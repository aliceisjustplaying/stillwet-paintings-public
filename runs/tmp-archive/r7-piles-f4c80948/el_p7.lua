-- easel session "evening_lake": a painting replayed chunk by chunk.
--   easel run paintings/lua/evening_lake.lua [--width 3200]
-- Each "--@ chunk" line starts one chunk as it was run at the easel (clock = painting minutes).

--@ chunk 1 · clock 0
-- Evening at a Mountain Lake. Twilight after sunset, contre-jour: the afterglow low over the lake,
-- a thin waxing crescent above it, a far range in mist, a fir promontory from the left and its
-- reflection, a dark near shore with stones.
canvas{style="friedrich", palette="friedrich_1820_greens", aspect=1.4, seed=47, hand=true}
skypal = pal:only{"lead white","pale smalt","cobalt blue","yellow ochre","raw umber","red earth","chrome yellow","vermilion"}
G = function(x, c, s) return math.exp(-((x - c)/s)^2) end
HZ = 432                               -- the lake's far edge (eye level)
SUNX = 600                             -- the sun has set here
MOON = {676, 158}
rn = noise{seed=5, octaves=5, period=170}
rn2 = noise{seed=6, octaves=3, period=60}
crest = function(x)
  return HZ - 10 - 14*rn:at01(x, 0) - 3*rn2(x, 0) - 66*G(x, 790, 140) - 30*G(x, 960, 60) - 20*G(x, 470, 110) - 8*G(x, 640, 40)
end
-- the promontory: a fir wood's skyline falling from the upper left to a low point at the water
PROM = {{-10,206},{36,188},{70,214},{112,222},{150,212},{186,252},{226,270},{262,318},{296,352},{318,398},{334,440},{346,458},{380,462},{420,466},{448,470}}
PWL = function(x) return 470 + 0.02*(448 - x) end         -- its waterline (nearer than the horizon)
-- the near shore: a dark bank along the bottom, rising a little to the right
SHORE = function(x) return 646 - 44*G(x, 800, 170) - 12*G(x, 620, 60) - 8*rn2(x, 300) + 10*G(x, 200, 160) end
water = mask(function(x, y) return (y > HZ and y < SHORE(x) + 4) and 1 or 0 end)
print(H, water:area())

--@ chunk 2 · clock 0
-- the drawing: a light 2H search, then 3B for what I am sure of; the lake's far edge ruled
local function line_of(f, x0, x1, step) local p = {} for x = x0, x1, step do p[#p+1] = {x, f(x)} end return p end
RANGE_PTS = line_of(crest, 0, 1000, 25)
SHORE_PTS = line_of(SHORE, 0, 1000, 25)
local h = pencil("2H")
h:rule({0, HZ}, {1000, HZ}, {pressure=0.3})
h:sketch(RANGE_PTS, {pressure=0.3})
h:sketch(PROM, {pressure=0.3})
h:sketch(SHORE_PTS, {pressure=0.3})
local b = pencil("3B")
b:line(PROM, {pressure={0.55, 0.7, 0.65, 0.5}})
b:rule({448, HZ}, {1000, HZ}, {pressure=0.45})
b:line(RANGE_PTS, {pressure={0.4, 0.55, 0.5}})
b:line(SHORE_PTS, {pressure={0.5, 0.65, 0.5}})
-- the moon's place, a small circle
local m = {} for i = 0, 16 do local a = i/16*2*math.pi m[#m+1] = {MOON[1] + 9*math.cos(a), MOON[2] + 9*math.sin(a)} end
h:sketch(m, {pressure=0.25})
fix()
print(drawing_mask():area())

--@ chunk 3 · clock 2.4503677748143673
-- masks for the whole picture
local pl = {} for i, p in ipairs(PROM) do pl[i] = {p[1], p[2]} end
pl[#pl+1] = {452, PWL(452) + 1}; pl[#pl+1] = {-10, PWL(-10) + 1}
promM = poly(pl)                                              -- the promontory's land, skyline to waterline
promSky = function(x)                                        -- its skyline as a function (linear between points)
  if x <= PROM[1][1] then return PROM[1][2] end
  for i = 2, #PROM do local a, b = PROM[i-1], PROM[i]
    if x <= b[1] then return lerp(a[2], b[2], (x - a[1])/(b[1] - a[1])) end end
  return PWL(x)
end
promRefl = mask(function(x, y)                               -- the mirror of the promontory, shortened (we look down a little)
  if x > 452 then return 0 end
  local wl = PWL(x); local d = wl - promSky(x)
  return (y > wl and y < wl + 0.78*d) and 1 or 0 end):soften(1.5)
rangeM = mask(function(x, y) return (y > crest(x) and y < HZ + 2) and 1 or 0 end) - promM
rangeRefl = mask(function(x, y) return (y >= HZ and y < HZ + 0.7*(HZ - crest(x))) and 1 or 0 end) - promM - promRefl
shoreM = below(SHORE)
skyM = above(crest) - promM
waterM = mask(function(x, y) return (y > HZ and y < SHORE(x) + 6) and 1 or 0 end) - promM
print(promM:area(), promRefl:area(), rangeM:area(), shoreM:area(), skyM:area(), waterM:area())
-- the dead color: thin, lean, one sitting; values only a little lighter than meant, cool in the sky
local dead = pal:only{"lead white","raw umber","bone black","yellow ochre","cobalt blue"}
work(skyM, {hand="body", tool="filbert 10", color=function(x, y)
    return mix(mix("#6f757f", "#a9a293", smoothstep(80, HZ, y)), "#bca98c", 0.6*G(x, SUNX, 260)*smoothstep(200, HZ, y)) end,
  angle=0, angle_jitter=0.15, length={40, 120}, coverage=3.2, medium=0.4, load=0.6, pal=dead, clip=skyM:grow(3)})
work(waterM - promRefl, {hand="body", tool="filbert 10", color=function(x, y)
    return mix(mix("#a49d8f", "#6f727a", smoothstep(HZ, 640, y)), "#b3a48b", 0.5*G(x, SUNX, 200)*(1 - smoothstep(HZ, 600, y))) end,
  angle=0, angle_jitter=0.08, length={40, 120}, coverage=3.2, medium=0.4, load=0.6, pal=dead, clip=(waterM - promRefl):grow(3)})
work(rangeM + rangeRefl, {hand="body", tool="filbert 8", color="#6e6c70", angle=0, length={30, 90}, coverage=3, medium=0.4, load=0.6, pal=dead, clip=(rangeM + rangeRefl):grow(1.5)})
work(promM + promRefl, {hand="body", tool="filbert 8", color="#3a3a35", angle=1.3, angle_jitter=0.6, length={20, 60}, coverage=3.2, medium=0.4, load=0.6, pal=dead, clip=(promM + promRefl):grow(1.5)})
work(shoreM, {hand="body", tool="filbert 10", color="#3e3934", angle=0.05, angle_jitter=0.3, length={30, 90}, coverage=3.2, medium=0.4, load=0.6, pal=dead, clip=shoreM:grow(2)})
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))

--@ chunk 4 · clock 185.17565667256713
print(dry())

--@ chunk 5 · clock 30339.550656672567
-- sitting 2. The darks of the distance first: the far range as one hazed mass, lighter and warmer toward
-- its misty foot, and its reflection pulled down under it, a little darker. The sky comes to it next, wet.
rangecol = function(x, y)
  local t = smoothstep(crest(x) + 4, HZ, y)
  local c = mix("#5d6072", "#7d7a80", t)                      -- blue-violet top, grayer and lighter at the foot
  return mix(c, "#8a7f7c", 0.25*G(x, SUNX, 200))              -- warmer where it stands in the glow
end
rangereflcol = function(x, y)
  local d = y - HZ
  return shift(rangecol(x, HZ - d/0.7), -0.03, 0, -0.01)
end
work(rangeM, {hand="body", tool="filbert 6", color=rangecol, angle=0.04, angle_jitter=0.12, length={24, 80},
  coverage=3.0, medium=0.3, load=0.8, clip=rangeM, pal=skypal})
work(rangeRefl, {hand="body", tool="filbert 6", color=rangereflcol, angle=math.pi/2, angle_jitter=0.06, length={8, 24},
  coverage=2.8, medium=0.3, load=0.8, pal=skypal, clip=rangeRefl:grow(1)})
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))

--@ chunk 6 · clock 30389.59835069999
-- the sky, same sitting: unequal horizontal bands of thin paint brought down over the wet range top
-- (it overlaps the crest by 3 units) and 14 units into the promontory, where the firs will stand over it.
gn = noise{seed=17, octaves=3, period=260}
glow = function(x, y)
  local gx = math.exp(-((x - SUNX)/(300 + 70*gn(x, 0)))^2)
  return gx * smoothstep(HZ - 330, HZ - 20, y)
end
skycol = function(x, y)
  local t = clamp(y / HZ, 0, 1)
  local c = gradient({{0,"#47536c"},{0.25,"#5f6a82"},{0.5,"#8b8d9c"},{0.66,"#a8999c"},{0.8,"#c6b39e"},{1,"#d2bd98"}}, t)
  return mix(c, "#ecd49e", 0.6*glow(x, y))
end
sn = noise{seed=31, octaves=3, period=190, stretch={0, 7}}
skyB = function(x, y) local v = sn(x, y) return shift(skycol(x, y), 0.02*v, 0.003*v, 0.008*v) end
skyS = mask(function(x, y) return y < crest(x) + 3 and 1 or 0 end) - promM:shrink(14)
-- mix piles, don't paint a formula: seven piles knifed along the sky's range, looking at the dead color
-- they go over; each stroke loads from one, the steps are made on the canvas (wet, then the blend)
SKYP = piles(skyB, {n=7, over=skyS, pal=skypal, medium=0.3, seed=601})
print(SKYP)
work(skyS, {hand="broad", color=SKYP, angle=0, angle_jitter=0.02, length={120, 320}, coverage=3.8, medium=0.3, load=0.75,
  pal=skypal, clip=skyS:grow(2):blur(1.5)})
blend(skyS, {angle=0, coverage=1.2, length={150, 400}, clip=skyS:grow(1):blur(1)})
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))

--@ chunk 7 · clock 30412.46690076217
-- the cloud bank into the open sky: one long low bank above the glow that thins and parts over it,
-- and one thin high wisp; unclipped, few long strokes; then warm lights on the bank's underside
-- toward the glow, and its top lost into the sky.
bn = noise{seed=9, octaves=5, period=240, stretch={0, 5}}
bn2 = noise{seed=23, octaves=4, period=120, stretch={0, 4}}
band = function(y, c, th) return 1 - smoothstep(0.5*th, th, math.abs(y - c)) end
c_low = function(x) return 300 + 12*bn(x, 90) - 0.05*(x - 600) end
c_high = function(x) return 196 + 16*bn(x*0.6, 0) + 0.03*(x - 600) end
bankLow = mask(function(x, y)
  local th = (26 + 14*bn2(x, 300)) * (1 - 0.8*G(x, SUNX + 30, 70)) * smoothstep(320, 440, x)
  return band(y, c_low(x) + 6*bn2(x, y*0.5), th) * (0.55 + 0.45*smoothstep(-0.5, 0.1, bn2(x*1.3, 500)))
end):blur(1.5) - promM
bankHigh = mask(function(x, y)
  local th = 9 * smoothstep(-0.1, 0.4, bn2(x, 40)) * smoothstep(440, 560, x)
  return band(y, c_high(x), th)
end):blur(1.5)
cloudcol = function(x, y)
  local high = y < 250
  local body = high and "#6a6c80" or "#6f6a7a"
  local under = high and "#a58f92" or "#cdb096"
  local c = high and c_high(x) or c_low(x)
  local lit = smoothstep(c - 4, c + 16, y) * (0.3 + 0.7*G(x, SUNX, 300))
  return mix(body, under, lit)
end
cm = (bankLow + bankHigh):blur(3)
BANKP = piles(cloudcol, {n=4, over=cm, pal=skypal, medium=0.32, seed=701})
print(BANKP)
work(cm, {hand="broad", color=BANKP, hug=false, angle=-0.03, angle_jitter=0.02, curve={0, 0}, length={90, 260},
  coverage=2.2, medium=0.32, load=0.9, pressure={0.45, 0.7}, ramps={0.25, 0.35}, pal=skypal})
local pn = noise{seed=44, octaves=2, period=150, stretch={0, 3}}
local low = bankLow:blur(3)
lightm = ((low:grow(4) - low:shrink(10)) * mask(function(x, y)
  return smoothstep(c_low(x) - 2, c_low(x) + 8, y) * G(x, SUNX, 360) * smoothstep(-0.2, 0.2, pn(x, 0))
end)):blur(2)
LITP = piles(function(x, y) return mix("#bfa99c", "#e2c9a0", G(x, SUNX, 200)) end, {n=3, over=lightm, pal=skypal, medium=0.3, seed=702})
print(LITP)
work(lightm, {hand="broad", color=LITP,
  hug=false, angle=-0.03, length={60, 170}, coverage=1.2, medium=0.3, load=0.9, pressure={0.35, 0.5}, ramps={0.35, 0.4}, pal=skypal})
topsm = (cm:grow(6) * mask(function(x, y)
  local c = y > 250 and c_low(x) or c_high(x)
  return 1 - smoothstep(c - 2, c + 8, y) end)):blur(5)
blend(topsm, {angle=0, coverage=2.4, length={60, 200}, hug=false})
local t = timesheet() print(string.format("%.0f min this sitting; bank %.0f lights %.0f", t.sitting, cm:area(), lightm:area()))

