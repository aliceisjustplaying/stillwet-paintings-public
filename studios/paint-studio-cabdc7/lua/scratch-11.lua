-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 3}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.35, um=45}, {apply="knife", pile={{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 0.5}}, texture=0.5, um=40}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.3}}, um=55}}, linen={14, 16}, seed=11, size=1200}

--@ chunk 2
-- scratch rehearsal 10: sky as large soft horizontal bands, big soft filbert
local sDeep  = pile{{"smalt", 2}, {"Prussian blue", 0.2}, {"bone black", 0.35}, {"lead white", 0.6}, {"raw umber", 0.25}, turps=0.55}
local sMid   = pile{{"pale smalt", 2}, {"smalt", 0.5}, {"Prussian blue", 0.12}, {"lead white", 1.0}, {"raw umber", 0.25}, turps=0.5}
local sPale  = pile{{"pale smalt", 1.5}, {"lead white", 1.5}, {"Naples yellow", 0.1}, {"raw umber", 0.1}, turps=0.45}
local sGlow  = pile{{"lead white", 3}, {"Naples yellow", 1}, {"red earth", 0.22}, turps=0.4}
local sGlowG = pile{{"lead white", 2}, {"Naples yellow", 1}, {"red earth", 0.15}, medium=0.45}

local function sw(a, b, x) return smoothstep(a, b, x) end
local function glowX(x) return 0.5 + 0.5 * math.exp(-((x - 500) / 260) ^ 2) end
local skyM = above(function(x) return 468 end)
local wDeep = function(x, y) return 1 - sw(30, 190, y) end
local wMid  = function(x, y) return sw(50, 170, y) * (1 - sw(300, 400, y)) end
local wPale = function(x, y) return sw(300, 380, y) * (1 - sw(400, 432, y)) end
local wGlow = function(x, y) return sw(375, 442, y) * glowX(x) end

local bigsky = brush{kind="filbert", width=64, point=0, stiffness=0.35}
work(skyM, {hand="body", tool=bigsky, ruler=true,
  piles={{sDeep, wDeep}, {sMid, wMid}, {sPale, wPale}, {sGlow, wGlow}},
  angle=0, length={280, 420}, coverage=1.15, fill=true, pressure={0.55, 0.8},
  ramps={0.25, 0.25}, mix_jitter=0.25, seed=3})

-- soft cloud bands on top
local cD1 = ellipse(280, 110, 400, 26):soften(16)
work(cD1, {hand="body", piles={{sDeep, 0.45}, {sMid, 0.55}}, angle=0, length={90, 170},
  coverage=0.9, pressure={0.35, 0.55}, seed=4})
blend(cD1:soften(6), {angle=0.1})
local cL1 = ellipse(660, 250, 360, 22):soften(18)
work(cL1, {hand="body", piles={{sPale, 0.7}, {sGlow, 0.3}}, angle=0, length={90, 170},
  coverage=0.8, pressure={0.3, 0.5}, seed=5})
blend(cL1:soften(6), {angle=-0.05})
local cL2 = ellipse(240, 340, 220, 16):soften(16)
work(cL2, {hand="body", piles={{sPale, 0.7}, {sGlow, 0.3}}, angle=0, length={70, 130},
  coverage=0.7, pressure={0.28, 0.45}, seed=14})
blend(cL2:soften(6), {angle=0.05})
local cD2 = ellipse(820, 300, 200, 14):soften(16)
work(cD2, {hand="body", piles={{sDeep, 0.35}, {sMid, 0.65}}, angle=0, length={70, 130},
  coverage=0.7, pressure={0.3, 0.5}, seed=15})
blend(cD2:soften(6), {angle=-0.08})
local band = rect(0, 404, 1000, 66):soften(18)
work(band, {hand="glaze", pile=sGlowG, coverage=1.0, angle=0, length={150, 260},
  load=0.8, load_at=function(x, y) return 0.6 + 0.55 * glowX(x) end, pressure={0.22, 0.35}, seed=6})
print("scratch rehearsal 10 (sky only) laid")

--@ chunk 3
-- continue on rehearsal 10 scratch: smooth the wet sky with a clean badger, horizontal passes
local sm = brush("badger", 40)
for i = 0, 13 do
  local y = 20 + i * 34
  sm:stroke({{0, y}, {1000, y}}, {pressure=0.3, orient="across", ramps={0.12, 0.12}})
  sm:wipe(0.92)
end
print("badger smoothing passes done; fullness:", sm:fullness())
-- a second, lighter round offset between the first
for i = 0, 13 do
  local y = 37 + i * 34
  sm:stroke({{0, y}, {1000, y}}, {pressure=0.22, orient="across", ramps={0.15, 0.15}})
  sm:wipe(0.92)
end
print("second round done")
