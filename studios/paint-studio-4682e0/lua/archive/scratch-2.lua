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
shirtMid = pile{{"Indian red", 1}, {"red earth", 0.6}, {"raw umber", 0.2}}
trousers = pile{{"bone black", 1}, {"ultramarine blue", 0.4}, {"raw umber", 1}, {"lead white", 0.35}}
woodLt = pile{{"burnt sienna", 1}, {"yellow ochre", 1}, {"raw umber", 0.6}}
work(rect(20, 650, 300, 80), {hand="body", tool="filbert 10", pile=shirtMid, coverage=2.5, fill=true, clip=rect(20, 650, 300, 80), angle=0})
work(rect(340, 650, 300, 80), {hand="body", tool="filbert 10", pile=trousers, coverage=2.5, fill=true, clip=rect(340, 650, 300, 80), angle=0})
work(rect(660, 650, 300, 80), {hand="body", tool="filbert 10", pile=woodLt, coverage=2.5, fill=true, clip=rect(660, 650, 300, 80), angle=0})
print(wait(12 * 24 * 60))
print(drying(100, 690), drying(400, 690), drying(700, 690))
redG = pile{{"permanent alizarin", 1}, {"bone black", 0.5}, {"burnt sienna", 0.5}, medium=0.4}
gE = pile{{"bone black", 1}, {"raw umber", 1}, {"burnt sienna", 0.5}, medium=0.3}
work(rect(30, 655, 80, 70), {hand="glaze", tool={kind="filbert", width=10}, pile=redG, coverage=1, clip=true})
work(rect(130, 655, 80, 70), {hand="glaze", tool={kind="filbert", width=10}, pile=gE, coverage=1, clip=true})
work(rect(350, 655, 80, 70), {hand="glaze", tool={kind="filbert", width=10}, pile=gE, coverage=1, clip=true})
work(rect(680, 655, 80, 70), {hand="glaze", tool={kind="filbert", width=10}, pile=gE, coverage=1, clip=true})

--@ chunk 3
wallDk = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.6}}
work(rect(20, 20, 960, 280), {hand="body", tool="filbert 12", pile=wallDk, coverage=2.5, fill=true, clip=rect(20, 20, 960, 280), angle=0})
sky = pile{{"lead white", 8}, {"Naples yellow", 1}, {"lemon chrome", 0.25}}
work(rect(500, 20, 200, 280), {hand="body", tool="filbert 10", pile=sky, coverage=2.5, fill=true, clip=rect(500, 20, 200, 280), angle=1.57})
print(wait(14 * 24 * 60))
print(drying(100, 100), drying(600, 100))

--@ chunk 4
smokeA = pile{{"lead white", 3}, {"raw umber", 0.3}, {"yellow ochre", 0.4}, medium=0.75}
smokeB = pile{{"lead white", 3}, {"raw umber", 0.3}, {"yellow ochre", 0.4}, thinner=0.7}
smokeC = pile{{"lead white", 3}, {"raw umber", 0.3}, {"yellow ochre", 0.4}, medium=0.85}
-- A: glaze veil, one pass
local m1 = ellipse(110, 160, 80, 110)
work(m1, {hand="glaze", pile=smokeA, coverage=1})
-- C: glaze veil more dilute, two passes
local m2 = ellipse(290, 160, 80, 110)
work(m2, {hand="glaze", pile=smokeC, coverage=1})
-- B: scumble with thinner, 3 light passes at coverage 0.6
local m3 = ellipse(450, 160, 60, 110)
for i = 1, 3 do work(m3, {hand="scumble", pile=smokeB, coverage=0.6, load=0.3}) end
-- A across the light/dark border
local m4 = ellipse(700, 160, 90, 90)
work(m4, {hand="glaze", pile=smokeA, coverage=1})
-- soft-masked glaze: does the glaze honour a soft mask?
local m5 = ellipse(880, 160, 80, 110):blur(30)
work(m5, {hand="glaze", pile=smokeA, coverage=1})

--@ chunk 5
wait(1)
local dk = rect(20, 330, 960, 300)
work(dk, {hand="body", tool="filbert 12", pile=wallDk, coverage=2.5, fill=true, clip=dk, angle=0})
work(rect(600, 330, 200, 300), {hand="body", tool="filbert 10", pile=sky, coverage=2.5, fill=true, clip=rect(600, 330, 200, 300), angle=1.57})
print(wait(14 * 24 * 60))

--@ chunk 6
smokeD = pile{{"lead white", 3}, {"raw umber", 0.25}, {"yellow ochre", 0.5}, medium=0.9}
-- a billow cloud
local function billows(cx, cy, n, seed)
  math.randomseed(seed)
  local m = nil
  for i = 1, n do
    local t = (i - 1) / (n - 1)
    local x = cx + t * 260 + rand(-15, 15)
    local y = cy - t * 60 + rand(-20, 20)
    local r = 18 + t * 40 + rand(-6, 6)
    local e = ellipse(x, y, r * rand(0.9, 1.3), r * rand(0.8, 1.1))
    m = m and (m + e) or e
  end
  return m
end
local c1 = billows(60, 500, 10, 3)
work(c1, {hand="glaze", pile=smokeD, coverage=1})
local c2 = billows(380, 520, 10, 5)
work(c2, {hand="glaze", pile=smokeD, coverage=1})
blend(c2:grow(10):blur(8), {angle=0.3})
local c3 = billows(560, 470, 10, 9)
work(c3, {hand="glaze", pile=smokeD, coverage=1})
local r = rag{width=12}
r:dip(0.5)
r:wipe({{580, 450}, {650, 430}, {720, 445}, {800, 420}}, {pressure=0.5})
r:refold()
r:wipe({{600, 500}, {680, 490}, {760, 470}}, {pressure=0.4})

--@ chunk 7
wait(1)
local dk = rect(20, 650, 960, 340)
work(dk, {hand="body", tool="filbert 12", pile=wallDk, coverage=2.5, fill=true, clip=dk, angle=0})
print(wait(14 * 24 * 60))
smokeE = pile{{"lead white", 3}, {"raw umber", 0.2}, {"yellow ochre", 0.7}, {"Naples yellow", 0.3}, medium=0.9}
local function billows(cx, cy, n, seed, len)
  math.randomseed(seed)
  local m = nil
  for i = 1, n do
    local t = (i - 1) / (n - 1)
    local x = cx + t * len + rand(-15, 15)
    local y = cy - t * 50 + rand(-20, 20)
    local r = 14 + t * 36 + rand(-6, 6)
    local e = ellipse(x, y, r * rand(0.9, 1.3), r * rand(0.8, 1.1))
    m = m and (m + e) or e
  end
  return m
end
-- V1: glaze, blend along drift x2, blend unclipped soft
local c = billows(60, 820, 12, 21, 300)
work(c, {hand="glaze", pile=smokeE, coverage=1})
blend(c:grow(8):blur(10), {angle=-0.15})
blend(c:grow(8):blur(10), {angle=-0.15})
blend(c:grow(16):blur(16), {angle=1.2, clip=false})
-- V2: glaze coverage 0.6 twice, with one blend
local c2 = billows(520, 820, 12, 22, 300)
work(c2, {hand="glaze", pile=smokeE, coverage=0.6})
work(c2:shrink(15), {hand="glaze", pile=smokeE, coverage=0.6})
blend(c2:grow(8):blur(10), {angle=-0.15})
