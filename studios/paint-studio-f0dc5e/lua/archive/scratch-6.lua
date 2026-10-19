-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
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
canvas{aspect=1.3347921225382933, ground={{apply="knife", pile={{"lead white", 6}, {"yellow ochre", 0.05}}, texture=0.25, um=70}, {apply="roller", pile={{"lead white", 1}}, um=35}}, linen={17, 15}, seed=2417, size=610}

--@ chunk 2
lw = pile{{"lead white", 1}, medium=0.45, name="liquid_white"}
mist_cool = pile{{"lead white", 4}, {"cobalt blue", 0.4}, {"vermilion", 0.12}, {"chrome yellow", 0.04}, blot=0.2, name="mist_cool"}
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
work(rect(0,0,1000,400), {hand="broad", pile=mist_cool, coverage=1.5, load=0.5, angle=0})
blend(rect(0,0,1000,400), {angle=0})
far_tree = pile{{"cobalt blue", 1}, {"Prussian blue", 0.35}, {"bone black", 0.35}, {"red earth", 0.3}, {"lead white", 0.7}, name="far_tree"}
function small_spruce(b, x, base, h, w, p)
  -- leader
  b:load(p, 0.7)
  b:stroke({{x, base - h}, {x, base}}, {pressure={0.05, 0.6}})
  local y = base - h + 2
  local i = 0
  while y < base do
    local t = (y - (base - h)) / h
    local half = w * (0.1 + 0.9 * t) * rand(0.7, 1.2)
    b:stroke({{x - half, y + half*0.25}, {x, y - 0.5}, {x + half, y + half*0.25}}, {pressure={0.25, 0.25}, ramps={0.3,0.3}})
    y = y + rand(1.5, 3.2)
    i = i + 1
    if i % 5 == 0 then b:load(p, 0.6) end
  end
end
local b = brush{kind="round", width=2.2, point=0.6}
math.randomseed(3)
for i = 1, 14 do
  local h = rand(14, 34)
  small_spruce(b, 100 + i * 25 + rand(-6, 6), 300, h, h * rand(0.18, 0.26), far_tree)
end
local b2 = brush{kind="filbert", width=3}
for i = 1, 14 do
  local x = 500 + i * 25 + rand(-6, 6)
  local h = rand(14, 34)
  b2:load(far_tree, 0.7)
  local base = 300
  b2:stroke({{x, base - h}, {x, base}}, {pressure={0.05, 0.6}})
  for j = 1, math.floor(h/3) do
    local y = base - h + j*3 + rand(-1,1)
    local half = h*0.22 * (j*3/h)
    b2:touch(x - half*0.5, y, {pressure=0.35, drag={-half*0.6, half*0.25}})
    b2:touch(x + half*0.5, y, {pressure=0.35, drag={half*0.6, half*0.25}})
  end
end

--@ chunk 3
math.randomseed(11)
function treeline_poly(x0, x1, base, hmin, hmax, density, seed)
  math.randomseed(seed)
  local pts = {{x0, base}}
  local x = x0
  while x < x1 do
    local h = rand(hmin, hmax)
    if rand(0,1) < 0.25 then h = h * rand(1.3, 1.7) end
    local w = h * rand(0.28, 0.4)
    -- left shoulder, tip, right shoulder; ragged tiers
    local tiers = math.max(2, math.floor(h / 6))
    for k = tiers, 1, -1 do
      local yy = base - h * (k - 0.5) / tiers
      local ww = w * (1 - (k - 0.5) / tiers)
      pts[#pts+1] = {x - ww * rand(0.7, 1.1), yy + rand(0, 2)}
      pts[#pts+1] = {x - ww * rand(0.2, 0.45), yy - h/tiers*0.35}
    end
    pts[#pts+1] = {x, base - h}
    for k = 1, tiers do
      local yy = base - h * (k - 0.5) / tiers
      local ww = w * (1 - (k - 0.5) / tiers)
      pts[#pts+1] = {x + ww * rand(0.2, 0.45), yy - h/tiers*0.35}
      pts[#pts+1] = {x + ww * rand(0.7, 1.1), yy + rand(0, 2)}
    end
    x = x + w * rand(0.6, 1.3) / density
  end
  pts[#pts+1] = {x1, base}
  pts[#pts+1] = {x1, base + 6}
  pts[#pts+1] = {x0, base + 6}
  return pts
end
local tl = poly(treeline_poly(100, 900, 370, 8, 22, 1.0, 5))
work(tl, {hand="detail", pile=far_tree, coverage=2.5, load=0.6, angle=math.pi/2, length={4,10}})

--@ chunk 4
function far_spruce(b, x, base, h, w, p)
  b:load(p, 0.75)
  local lean = rand(-0.04, 0.04)
  b:stroke({{x + lean*h, base - h}, {x, base}}, {pressure={0.05, 0.7}})
  local y = base - h + 1.5
  local i = 0
  while y < base do
    local t = (y - (base - h)) / h
    local half = w * (0.12 + 0.88 * t^0.9) * rand(0.55, 1.25)
    local xx = x + lean * (base - y)
    local sag = half * rand(0.15, 0.4)
    if rand(0,1) < 0.85 then b:stroke({{xx - half, y + sag}, {xx - half*0.4, y + sag*0.3}, {xx, y - 0.5}}, {pressure={0.15, 0.35}}) end
    if rand(0,1) < 0.85 then b:stroke({{xx, y - 0.5}, {xx + half*0.4, y + sag*0.3}, {xx + half, y + sag}}, {pressure={0.35, 0.15}}) end
    y = y + rand(1.2, 3.0) * (0.7 + 0.6*t)
    i = i + 1
    if i % 4 == 0 then b:load(p, 0.6) end
  end
end
math.randomseed(21)
local b = brush{kind="round", width=2.6, point=0.5}
-- clumps
local xs = uneven(30, 120, 600, 0.6, 0.6, 4)
for _, x in ipairs(xs) do
  local h = rand(10, 30)
  if rand(0,1) < 0.2 then h = h * 1.5 end
  far_spruce(b, x, 460 + rand(-2, 3), h, h * rand(0.2, 0.3), far_tree)
end
-- base band
work(rect(110, 452, 500, 12):roughen(2, 10, 3), {hand="body", tool={kind="filbert", width=5}, pile=far_tree, coverage=2, load=0.6, angle=0, length={8,20}, clip=true})
