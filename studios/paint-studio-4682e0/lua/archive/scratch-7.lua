-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 1}}, texture=0.25, um=70}, {apply="brush", pile={{"lead white", 3}, {"yellow ochre", 1.2}, {"raw umber", 1}, {"red earth", 0.35}}, um=25}}, linen={16, 14}, seed=1873, size=700}

--@ chunk 2
wallDk = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.6}}
gunMetal = pile{{"bone black", 1}, {"ultramarine blue", 0.2}, {"raw umber", 0.3}}
local all = rect(0, 0, 1000, 750)
work(all, {hand="broad", pile=wallDk, coverage=2, fill=true, clip=all, angle=0})
for i = 0, 2 do
  local x = 60 + i * 320
  local barrel = ribbon({{x, 401}, {x + 51, 385}}, {5.2, 4.6})
  work(barrel, {hand="detail", tool={kind="round", width=2.2}, pile=gunMetal, coverage=4, fill=true, clip=barrel, angle=-0.3, length={6, 20}})
end
print(wait(16 * 24 * 60))
palette{scrape={wallDk, gunMetal}}
sm1 = pile{{"Naples yellow", 2}, {"orange chrome", 0.5}, {"yellow ochre", 1}, {"lead white", 0.4}, medium=0.8}
sm2 = pile{{"yellow ochre", 2}, {"raw sienna", 1}, {"Naples yellow", 1}, {"lead white", 0.3}, medium=0.8}
sm3 = pile{{"lead white", 2}, {"orange chrome", 1}, {"Naples yellow", 1}, {"burnt sienna", 0.2}, medium=0.85}
local nz = noise{seed=23, octaves=3, period=40, kind="billow"}
for i, p in ipairs({sm1, sm2, sm3}) do
  local cx = 80 + (i - 1) * 140
  local function den(x, y)
    local d = math.sqrt((x - cx)^2 + (y - 120)^2)
    return (1 - smoothstep(20, 55, d)) * (0.5 + 0.5 * nz:at01(x, y))
  end
  local a = mask(function(x, y) return den(x, y) > 0.04 and 1 or 0 end)
  stipple(a, {pile=p, width=10, coverage=function(x, y) return 2.4 * den(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
  blend(a:grow(8):blur(8), {angle=-1.0})
  blend(a:grow(6):blur(6), {angle=0.6})
end

--@ chunk 3
flashCore = pile{{"lead white", 4}, {"lemon chrome", 1}, name="core"}
flashY = pile{{"lead white", 2}, {"cadmium yellow", 1.5}, {"lemon chrome", 0.5}, name="flashY"}
flashO = pile{{"cadmium yellow", 1}, {"orange chrome", 1.2}, {"lead white", 0.6}, name="flashO"}
glowO = pile{{"orange chrome", 1}, {"Naples yellow", 1}, {"lead white", 0.6}, {"vermilion", 0.15}, medium=0.45, name="glowO"}
smokeG = pile{{"lead white", 3}, {"Naples yellow", 0.8}, {"yellow ochre", 0.6}, medium=0.85, name="smokeG"}
function hotGlow(mx, my, R, rot)
  local function hot(x, y)
    local dx, dy = x - mx, y - my
    local u = dx * math.cos(rot) + dy * math.sin(rot) - 14
    local v = -dx * math.sin(rot) + dy * math.cos(rot)
    local d = math.sqrt((u * 0.85)^2 + v * v)
    return 1 - smoothstep(6, R, d)
  end
  local area = mask(function(x, y) return hot(x, y) > 0.02 and 1 or 0 end)
  stipple(area, {pile=glowO, width=8, coverage=function(x, y) return 3.2 * hot(x, y) ^ 1.6 end, feather=1, pressure={0.3, 0.6}, dips={30, 0.5, 0}})
  blend(area:grow(3):blur(5), {angle=0.3})
  blend(area:grow(3):blur(5), {angle=-1.2})
end
function flashR3(mx, my, sc, rot)
  local function P(a, L) return mx + math.cos(a + rot) * L, my + math.sin(a + rot) * L end
  local o = brush{kind="round", width=8 * sc, point=0.75, lay=3}
  local spikes = {{-0.42, 24, 0.8}, {-0.13, 40, 1.0}, {0.1, 50, 1.0}, {0.38, 28, 0.8}, {-1.05, 13, 0.6}, {1.0, 14, 0.6}, {-0.7, 18, 0.7}}
  for _, j in ipairs(spikes) do
    local a, L, p = j[1], j[2] * sc, j[3]
    local x1, y1 = P(a, L * 0.3)
    local x2, y2 = P(a + 0.05, L * 0.7)
    local x3, y3 = P(a, L)
    o:reload(flashO, 0.75)
    o:gesture({{mx + 1, my, p}, {x1, y1, p}, {x2, y2, p * 0.5}, {x3, y3, 0.0}}, {wobble=1.2})
  end
  local y = brush{kind="round", width=9 * sc, point=0.6, lay=5}
  for _, j in ipairs({{-0.12, 28}, {0.08, 36}, {0.38, 16}, {-0.45, 15}}) do
    local a, L = j[1], j[2] * sc
    local x1, y1 = P(a, L * 0.4)
    local x2, y2 = P(a, L)
    y:reload(flashY, 0.9)
    y:gesture({{mx, my, 1.0}, {x1, y1, 0.85}, {x2, y2, 0.0}}, {wobble=0.8})
  end
  local c = brush{kind="round", width=10 * sc, point=0.4, lay=8}
  local cx1, cy1 = P(0, 9 * sc)
  local cx2, cy2 = P(0, 21 * sc)
  c:reload(flashCore, 1.0)
  c:gesture({{mx, my, 1.0}, {cx1, cy1, 0.95}, {cx2, cy2, 0.0}})
  local tx, ty = P(0, 6 * sc)
  c:reload(flashCore, 1.0)
  c:touch(tx, ty, {pressure=1.0})
end
function gunSmoke(mx, my, rot, seed)
  local nz = noise{seed=seed, octaves=4, period=36, kind="billow", warp={60, 22}}
  local function env(x, y)
    local dx, dy = x - mx, y - my
    local u = dx * math.cos(rot) + dy * math.sin(rot)
    local v = -dx * math.sin(rot) + dy * math.cos(rot)
    if u < -8 then return 0 end
    local w = 10 + u * 0.45
    return math.exp(-(v / w)^2) * math.exp(-((u - 40) / 70)^2) * smoothstep(-8, 10, u)
  end
  local function den(x, y) return env(x, y) * (0.3 + 0.9 * nz:at01(x, y)) end
  local area = mask(function(x, y) return den(x, y) > 0.05 and 1 or 0 end)
  stipple(area, {pile=smokeG, width=8, coverage=function(x, y) return 2.6 * den(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
  blend(area:grow(8):blur(8), {angle=rot})
  blend(area:grow(6):blur(6), {angle=rot + 1.4})
  blend(area:grow(6):blur(6), {angle=rot})
end
gunSmoke(111, 385, -0.45, 31)
hotGlow(111, 385, 46, -0.3)
flashR3(111, 385, 0.9, -0.3)

--@ chunk 4
glowO2 = pile{{"orange chrome", 1}, {"cadmium yellow", 0.5}, {"vermilion", 0.25}, medium=0.35, name="glowO2"}
flashR = pile{{"orange chrome", 1}, {"vermilion", 0.6}, {"cadmium yellow", 0.3}, name="flashR"}
function hotGlow2(mx, my, R, rot)
  local function hot(x, y)
    local dx, dy = x - mx, y - my
    local u = dx * math.cos(rot) + dy * math.sin(rot) - 18
    local v = -dx * math.sin(rot) + dy * math.cos(rot)
    local d = math.sqrt((u * 0.8)^2 + v * v)
    return 1 - smoothstep(4, R, d)
  end
  local area = mask(function(x, y) return hot(x, y) > 0.02 and 1 or 0 end)
  stipple(area, {pile=glowO2, width=7, coverage=function(x, y) return 3.0 * hot(x, y) ^ 2 end, feather=1, pressure={0.3, 0.6}, dips={30, 0.5, 0}})
  blend(area:grow(3):blur(5), {angle=rot})
  blend(area:grow(3):blur(5), {angle=rot + 1.5})
end
function flash4(mx, my, sc, rot)
  local function P(a, L) return mx + math.cos(a + rot) * L, my + math.sin(a + rot) * L end
  -- outer red-orange tongues: long, sharp
  local r = brush{kind="round", width=6 * sc, point=0.95, lay=3}
  local tongues = {{-0.5, 34}, {-0.22, 58}, {0.0, 70}, {0.2, 56}, {0.48, 36}, {-0.95, 22}, {0.9, 24}, {-1.5, 12}, {1.45, 13}}
  for _, j in ipairs(tongues) do
    local a, L = j[1], j[2] * sc
    local x1, y1 = P(a, L * 0.25)
    local x2, y2 = P(a + 0.04, L * 0.65)
    local x3, y3 = P(a - 0.02, L)
    r:reload(flashR, 0.75)
    r:gesture({{mx, my, 1.0}, {x1, y1, 0.9}, {x2, y2, 0.45}, {x3, y3, 0.0}})
  end
  local o = brush{kind="round", width=7 * sc, point=0.9, lay=4}
  for _, j in ipairs({{-0.35, 30}, {-0.1, 44}, {0.12, 48}, {0.35, 30}, {-0.8, 16}, {0.75, 17}}) do
    local a, L = j[1], j[2] * sc
    local x1, y1 = P(a, L * 0.3)
    local x2, y2 = P(a, L)
    o:reload(flashO, 0.85)
    o:gesture({{mx, my, 1.0}, {x1, y1, 0.85}, {x2, y2, 0.0}})
  end
  local y = brush{kind="round", width=9 * sc, point=0.8, lay=6}
  for _, j in ipairs({{-0.15, 26}, {0.05, 34}, {0.25, 22}}) do
    local a, L = j[1], j[2] * sc
    local x1, y1 = P(a, L * 0.4)
    local x2, y2 = P(a, L)
    y:reload(flashY, 0.95)
    y:gesture({{mx, my, 1.0}, {x1, y1, 0.9}, {x2, y2, 0.0}})
  end
  local c = brush{kind="round", width=11 * sc, point=0.5, lay=9}
  local cx1, cy1 = P(0, 10 * sc)
  local cx2, cy2 = P(0, 22 * sc)
  c:reload(flashCore, 1.0)
  c:gesture({{mx, my, 1.0}, {cx1, cy1, 1.0}, {cx2, cy2, 0.0}})
  local tx, ty = P(0, 7 * sc)
  c:reload(flashCore, 1.0)
  c:touch(tx, ty, {pressure=1.0})
end
gunSmoke(431, 385, -0.45, 37)
hotGlow2(431, 385, 54, -0.3)
flash4(431, 385, 1.0, -0.3)

--@ chunk 5
palette{scrape={sm1, sm2, sm3}}
g1 = pile{{"vermilion", 1}, {"orange chrome", 1}, {"lead white", 0.3}, medium=0.3}
g2 = pile{{"orange chrome", 1}, {"Naples yellow", 0.5}, {"vermilion", 0.3}, {"lead white", 0.8}}
g3 = pile{{"cadmium red", 0.4}, {"orange chrome", 1}, {"lead white", 0.5}, {"cadmium yellow", 0.3}}
local nz = noise{seed=5, octaves=3, period=30, kind="fbm"}
for i, p in ipairs({g1, g2, g3}) do
  local cx, cy = 80 + (i - 1) * 140, 600
  local function hot(x, y) local d = math.sqrt((x - cx)^2 + (y - cy)^2) return 1 - smoothstep(4, 50, d) end
  local area = mask(function(x, y) return hot(x, y) > 0.02 and 1 or 0 end)
  stipple(area, {pile=p, width=7, coverage=function(x, y) return 3.0 * hot(x, y) ^ 2 end, feather=1, pressure={0.3, 0.6}, dips={30, 0.5, 0}})
  blend(area:grow(3):blur(5), {angle=0.3})
  blend(area:grow(3):blur(5), {angle=1.8})
end

--@ chunk 6
local a = rect(500, 560, 60, 60)
stipple(a, {pile=g2, width=7, coverage=2, pressure={0.3, 0.6}, dips={30, 0.5, 0}})
local b = rect(600, 560, 60, 60)
work(b, {hand="body", tool="filbert 6", pile=g2, coverage=2, fill=true, clip=b, angle=0})
local c = rect(700, 560, 60, 60)
work(c, {hand="body", tool="filbert 6", pile=g2, coverage=2, fill=true, clip=c, angle=0})
blend(c, {angle=0.3})
print(drying(530, 590), drying(630, 590), drying(730, 590))

--@ chunk 7
local cx, cy = 880, 600
local function hot(x, y) local d = math.sqrt((x - cx)^2 + (y - cy)^2) return 1 - smoothstep(4, 50, d) end
local area = mask(function(x, y) return hot(x, y) > 0.02 and 1 or 0 end)
stipple(area, {pile=g2, width=7, coverage=function(x, y) return 3.0 * hot(x, y) ^ 2 end, feather=1, pressure={0.3, 0.6}, dips={30, 0.5, 0}})
print("after stipple", drying(880, 600))
blend(area:grow(3):blur(5), {angle=0.3})
print("after blend", drying(880, 600))

--@ chunk 8
local cx, cy = 880, 600
local function hot(x, y) local d = math.sqrt((x - cx)^2 + (y - cy)^2) return 1 - smoothstep(4, 50, d) end
local area = mask(function(x, y) return hot(x, y) > 0.02 and 1 or 0 end)
blend(area:grow(3):blur(5), {angle=1.8})
print("after blend2", drying(880, 600))

--@ chunk 9
palette{scrape={g1, g2, g3, glowO, glowO2, smokeG}}
sky = pile{{"lead white", 8}, {"Naples yellow", 1}, {"lemon chrome", 0.25}}
wallDk = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.6}}
local cr = rect(300, 620, 300, 120)
work(cr, {hand="body", tool="filbert 10", pile=sky, coverage=2.5, fill=true, clip=cr, angle=1.57})
print(wait(16 * 24 * 60))
veilA = pile{{"lead white", 2}, {"raw umber", 0.6}, {"yellow ochre", 0.8}, medium=0.85}
veilB = pile{{"raw sienna", 1}, {"raw umber", 0.5}, {"lead white", 1}, medium=0.85}
smokeHot2 = pile{{"lead white", 2}, {"yellow ochre", 1}, {"Naples yellow", 1}, {"orange chrome", 0.35}, medium=0.75}
local nz = noise{seed=41, octaves=3, period=40, kind="billow"}
local function den(cx, cy, x, y) local d = math.sqrt((x - cx)^2 + (y - cy)^2) return (1 - smoothstep(15, 50, d)) * (0.5 + 0.5 * nz:at01(x, y)) end
local a1 = mask(function(x, y) return den(370, 680, x, y) > 0.04 and 1 or 0 end)
stipple(a1, {pile=veilA, width=10, coverage=function(x, y) return 2.4 * den(370, 680, x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
blend(a1:grow(8):blur(8), {angle=-1.0})
local a2 = mask(function(x, y) return den(520, 680, x, y) > 0.04 and 1 or 0 end)
stipple(a2, {pile=veilB, width=10, coverage=function(x, y) return 2.4 * den(520, 680, x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
blend(a2:grow(8):blur(8), {angle=-1.0})
local a3 = mask(function(x, y) return den(150, 680, x, y) > 0.04 and 1 or 0 end)
stipple(a3, {pile=smokeHot2, width=10, coverage=function(x, y) return 2.8 * den(150, 680, x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
blend(a3:grow(8):blur(8), {angle=-1.0})

--@ chunk 10
local b = brush{kind="filbert", width=8}
b:load(smokeHot2, 0.6)
b:stroke({{40, 470}, {200, 470}}, {pressure=0.5})
local t1 = pile{{"lead white", 2}, {"yellow ochre", 1}, {"Naples yellow", 1}, medium=0.75}
local t2 = pile{{"lead white", 2}, {"yellow ochre", 1}, {"orange chrome", 0.35}, medium=0.75}
local a = rect(240, 450, 50, 40)
stipple(a, {pile=t1, width=10, coverage=2, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
local c = rect(320, 450, 50, 40)
stipple(c, {pile=t2, width=10, coverage=2, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
local d = rect(400, 450, 50, 40)
stipple(d, {pile=smokeHot2, width=10, coverage=2, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
print(drying(120, 470), drying(265, 470), drying(345, 470), drying(425, 470))

--@ chunk 11
veilC = pile{{"raw umber", 1}, {"raw sienna", 1}, {"lead white", 0.6}, medium=0.8}
veilD = pile{{"raw umber", 1}, {"burnt sienna", 0.5}, {"yellow ochre", 0.5}, {"lead white", 0.5}, medium=0.75}
local nz = noise{seed=43, octaves=3, period=40, kind="billow"}
local function den(cx, cy, x, y) local d = math.sqrt((x - cx)^2 + (y - cy)^2) return (1 - smoothstep(15, 50, d)) * (0.5 + 0.5 * nz:at01(x, y)) end
local a1 = mask(function(x, y) return den(370, 680, x, y) > 0.04 and 1 or 0 end)
stipple(a1, {pile=veilC, width=10, coverage=function(x, y) return 2.4 * den(370, 680, x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
print(drying(370, 680))
blend(a1:grow(8):blur(8), {angle=-1.0})
print(drying(370, 680))
local a2 = mask(function(x, y) return den(520, 680, x, y) > 0.04 and 1 or 0 end)
stipple(a2, {pile=veilD, width=10, coverage=function(x, y) return 2.4 * den(520, 680, x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
blend(a2:grow(8):blur(8), {angle=-1.0})

--@ chunk 12
palette{scrape={veilA, veilB, veilC, smokeHot2}}
smokeW3 = pile{{"lead white", 3}, {"Naples yellow", 0.8}, {"yellow ochre", 0.8}, {"orange chrome", 0.12}, medium=0.6, name="smokeW3"}
smokeHot3 = pile{{"lead white", 2}, {"Naples yellow", 1}, {"orange chrome", 0.5}, {"yellow ochre", 0.5}, medium=0.6, name="smokeHot3"}
local mx, my, rot = 751, 385, -0.55
local nz = noise{seed=61, octaves=4, period=30, kind="billow", warp={50, 18}}
local function env(x, y)
  local dx, dy = x - mx, y - my
  local u = dx * math.cos(rot) + dy * math.sin(rot)
  local v = -dx * math.sin(rot) + dy * math.cos(rot)
  if u < -6 then return 0 end
  local w = 8 + u * 0.5
  return math.exp(-(v / w)^2) * math.exp(-((u - 30) / 75)^2) * smoothstep(-6, 6, u)
end
local function den(x, y) return env(x, y) * (0.35 + 0.85 * nz:at01(x, y)) end
local function hot(x, y) local d = math.sqrt((x - mx - 10)^2 + (y - my + 4)^2) return 1 - smoothstep(10, 45, d) end
local area = mask(function(x, y) return den(x, y) > 0.05 and 1 or 0 end)
stipple(area, {pile=smokeW3, width=8, coverage=function(x, y) return 3.6 * den(x, y) * (1 - 0.7 * hot(x, y)) end, feather=1, pressure={0.25, 0.55}, dips={30, 0.45, 0}})
stipple(area, {pile=smokeHot3, width=8, coverage=function(x, y) return 3.6 * den(x, y) * hot(x, y) end, feather=1, pressure={0.25, 0.55}, dips={30, 0.45, 0}})
blend(area:grow(6):blur(7), {angle=rot})
blend(area:grow(4):blur(5), {angle=rot + 1.4})
