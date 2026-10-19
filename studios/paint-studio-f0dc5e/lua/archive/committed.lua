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
print(W, H)
sky_mid = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, name="sky_mid"}
refl_dark = pile{{"cobalt blue", 0.33962008}, {"Prussian blue", 0.10685215}, {"red earth", 0.1392857}, {"bone black", 0.06964285}, {"lead white", 0.3235793}, {"raw umber", 0.013953487}, {"vermilion", 0.007066382}, name="refl_dark"}
A = refl_dark
B = mix{{refl_dark, 0.7}, {sky_mid, 0.3}, name="B"}
C = mix{{refl_dark, 0.55}, {sky_mid, 0.45}, name="C"}
D = mix{{refl_dark, 0.45}, {sky_mid, 0.55}, name="D"}
local P = {A, B, C, D}
for i, p in ipairs(P) do
  work(rect(40 + (i-1)*230, 40, 200, 150), {hand="body", pile=p, coverage=2.5, load=0.7, angle=0, seed=10+i})
end

--@ chunk 3
for i = 1, 4 do
  -- probe not available in lua? try
end
print("done")

--@ chunk 4
print(wait(4*24*60))
print(drying(140,110))
ripple_c = mix{{sky_mid, 0.7}, {refl_dark, 0.3}, name="ripple_c"}
local rg = brush{kind="rigger", width=2.5, point=1}
for k = 0, 3 do
  local y = 70 + k*25
  rg:reload(ripple_c, 0.4)
  rg:stroke({{50, y}, {120, y+0.3}, {200, y}}, {pressure={0.15, 0.03}, ramps={0.35, 0.5}})
end
print(wait(4*24*60))
print(drying(100,70))

--@ chunk 5
local rb = brush{kind="round", width=3.5, point=0.4}
rb:reload(refl_dark, 0.5)
rb:stroke({{48, 70}, {120, 70.3}, {202, 70}}, {pressure={0.45, 0.45}, ramps={0.1, 0.1}})
print(rb:mark_width(0.45))
local fb = brush{kind="filbert", width=4}
local x = 48
fb:reload(refl_dark, 0.5)
local n = 0
while x < 204 do
  fb:stroke({{x, 95 - 3}, {x + rand(-0.3,0.3), 95 + 3}}, {pressure={0.4, 0.35}})
  x = x + rand(2.5, 3.5)
  n = n + 1
  if n % 8 == 0 then fb:reload(refl_dark, 0.5) end
end
work(ribbon({{46,120},{204,120}}, 6), {hand="scumble", pile=refl_dark, coverage=1, seed=31})

--@ chunk 6
refl_lt = mix{{refl_dark, 0.88}, {sky_mid, 0.12}, name="refl_lt"}
local fb = brush{kind="filbert", width=4}
local function cover(x0, x1, y0)
  local x = x0
  local n = 0
  fb:reload(refl_dark, 0.5)
  while x < x1 do
    local h = rand(2.8, 3.6)
    fb:stroke({{x, y0 - h}, {x + rand(-0.3, 0.3), y0 + h}}, {pressure={0.4, 0.35}})
    x = x + rand(2.5, 3.5)
    n = n + 1
    if n % 8 == 0 then fb:reload(refl_dark, 0.5) end
  end
end
local function redab(x0, x1, y0)
  local x = x0 + rand(0, 3)
  while x < x1 do
    local p = (rand(0,1) < 0.6) and refl_lt or refl_dark
    fb:reload(p, rand(0.3, 0.45))
    local up, dn = rand(2.5, 6.5), rand(2.5, 6.5)
    fb:stroke({{x, y0 - up}, {x + rand(-0.4, 0.4), y0 + dn}}, {pressure={rand(0.3,0.45), 0.2}, ramps={0.15, 0.4}})
    x = x + rand(3, 7)
  end
end
cover(46, 206, 145)
redab(46, 206, 145)
-- left half: blend vertical once; right half: twice
local m1 = ribbon({{40,145},{125,145}}, 18):soften(4)
local m2 = ribbon({{125,145},{210,145}}, 18):soften(4)
blend(m1, {angle=math.pi/2, seed=41})
blend(m2, {angle=math.pi/2, seed=42})
blend(m2, {angle=math.pi/2, seed=43})

--@ chunk 7
far_tree = pile{{"cobalt blue", 1}, {"Prussian blue", 0.35}, {"bone black", 0.35}, {"red earth", 0.3}, {"lead white", 0.7}, name="far_tree"}
F2 = mix{{far_tree, 0.8}, {sky_mid, 0.2}, name="F2"}
F3 = mix{{far_tree, 0.65}, {sky_mid, 0.35}, name="F3"}
F4 = mix{{far_tree, 0.5}, {sky_mid, 0.5}, name="F4"}
local P = {far_tree, F2, F3, F4}
for i, p in ipairs(P) do
  work(rect(40 + (i-1)*230, 260, 200, 120), {hand="body", pile=p, coverage=2.5, load=0.7, angle=0, seed=50+i})
end
print(wait(4*24*60))

--@ chunk 8
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
-- hump band
local mb = brush{kind="filbert", width=6}
for i = 1, 12 do
  local x = 780 + i * 14
  mb:load(far_tree, 0.5)
  mb:stroke({{x - 10, 375}, {x, 368}, {x + 10, 375}}, {pressure={0.4, 0.4}})
end
work(rect(770, 372, 200, 8), {hand="body", tool={kind="filbert", width=5}, pile=far_tree, coverage=2, load=0.6, angle=0, length={8,20}, clip=true, seed=61})
print(wait(2*24*60))
print(drying(850, 375))

--@ chunk 9
print(wait(5*24*60))
print(drying(850, 375), drying(800, 370))

--@ chunk 10
F3 = F3 or mix{{far_tree, 0.65}, {sky_mid, 0.35}, name="F3"}
local b = brush{kind="round", width=2.0, point=0.6}
-- back row lighter, taller, sparse
local xs = uneven(8, 775, 965, 0.7, 0.6, 71)
for _, x in ipairs(xs) do
  local h = rand(8, 16)
  far_spruce(b, x, 373 + rand(-1,1), h, h * rand(0.25, 0.32), F3)
end
-- front row dense
local xs2 = uneven(36, 772, 968, 0.8, 0.7, 72)
for _, x in ipairs(xs2) do
  local h = rand(4, 11)
  if rand(0,1) < 0.15 then h = h * 1.5 end
  far_spruce(b, x, 375 + rand(-1,1.5), h, h * rand(0.25, 0.38), far_tree)
end

--@ chunk 11
local dummy = {load=function() end, stroke=function() end}
function far_spruce_d(b, x, base, h, w, p)
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
math.randomseed(911)
local xs = uneven(40, 560, 998, 0.7, 0.8, 912)
for _, x in ipairs(xs) do
  local s = 0.6 + 0.5 * (x - 560) / 440
  local h = rand(6, 15) * s
  local base = 474 + rand(-1, 2)
  far_spruce_d(dummy, x, base, h, h * rand(0.25, 0.35), 0)
end
mounds_d = {}
local out = {}
for i = 1, 30 do
  local x = rand(400, 1000)
  local y = 472 - rand(0, 3)
  local a, top, c = rand(6, 14), rand(1, 3), rand(6, 14)
  mounds_d[i] = {x, y, a, top, c}
  out[#out+1] = string.format("%.0f:%.1f(%0.f..%0.f)", x, y - top, x - a, x + c)
end
print(table.concat(out, "  "))

--@ chunk 12
mist_cool = pile{{"lead white", 4}, {"cobalt blue", 0.4}, {"vermilion", 0.12}, {"chrome yellow", 0.04}, blot=0.2, name="mist_cool"}
work(rect(40, 420, 520, 90), {hand="body", pile=mist_cool, coverage=2.5, load=0.6, angle=0, seed=81})
blend(rect(40, 420, 520, 90):shrink(3):soften(4), {angle=0, seed=82})
print(wait(3*24*60))
local mb = brush{kind="filbert", width=6}
math.randomseed(83)
for i = 1, 24 do
  local x = rand(60, 540)
  mb:load(far_tree, 0.5)
  local y = 472 - rand(0, 3)
  mb:stroke({{x - rand(6, 14), y + 3}, {x, y - rand(1, 3)}, {x + rand(6, 14), y + 3}}, {pressure={0.4, 0.4}})
end
local shore = poly({{50,477},{550,474},{550,481},{50,481}}):roughen(1.5, 10, 84)
work(shore, {hand="body", tool={kind="filbert", width=5}, pile=far_tree, coverage=2, load=0.6, angle=0, length={8,20}, clip=true, seed=85})
print(wait(8*24*60))
print(drying(300, 470), drying(300, 478))

--@ chunk 13
F3 = mix{{far_tree, 0.65}, {sky_mid, 0.35}, name="F3"}
function treeline(b, x0, x1, base0, p_back, p_front, seed)
  math.randomseed(seed)
  -- back row: lighter misty spires, taller, sparse
  local x = x0
  while x < x1 do
    local h = rand(9, 17)
    if rand(0,1) < 0.2 then h = h * 1.3 end
    far_spruce(b, x, base0 - 2 + rand(-1, 1), h, h * rand(0.22, 0.3), p_back)
    x = x + rand(3, 9)
  end
  -- front row: dark, dense, spiky
  x = x0
  while x < x1 do
    local h = rand(6, 14)
    if rand(0,1) < 0.12 then h = h * 1.4 end
    far_spruce(b, x, base0 + rand(-0.5, 1.5), h, h * rand(0.24, 0.34), p_front)
    x = x + rand(1.8, 4.2)
  end
end
local b = brush{kind="round", width=2.0, point=0.6}
treeline(b, 60, 300, 475, F3, far_tree, 91)
