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
sky_mid = pile{{"Prussian blue", 0.25}, {"lead white", 3}, {"vermilion", 0.04}, name="sky_mid"}
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
work(rect(0,0,1000,749), {hand="broad", pile=sky_mid, coverage=1.6, load=0.4, angle=0.7})
blend(everywhere(), {angle=0})
tree_dark2 = pile{{"Prussian blue", 0.6}, {"raw umber", 1}, {"bone black", 0.5}, name="tree_dark2"}

function spruce(cx, top, base, halfw, pile_, seed, opts)
  opts = opts or {}
  math.randomseed(seed)
  local lean = opts.lean or 0
  local bw = opts.bw or 5
  local br = brush{kind="round", width=bw, point=0.5, lay=1.4}
  local fr = brush{kind="round", width=math.max(2, bw*0.5), point=0.7, lay=1.2}
  local function xc(y) return cx + lean * (base - y) end
  br:load(pile_, 1.0)
  -- leader
  local lead = brush{kind="round", width=math.max(2, bw*0.6), point=0.8}
  lead:load(pile_, 0.9)
  lead:gesture({{xc(top), top, 0.05}, {xc(top + (base-top)*0.3)+rand(-1,1), top + (base-top)*0.3, 0.5}, {xc(base), base, 0.9}})
  local y = top + 3
  local n = 0
  while y < base do
    local t = (y - top) / (base - top)
    local half = halfw * (0.06 + 0.94 * t^0.85)
    local nb = 1 + math.floor(rand(1, 3.2))
    for side = -1, 1, 2 do
      for j = 1, nb do
        if rand(0,1) > (opts.gap or 0.12) then
          local L = half * rand(0.55, 1.1)
          local x0 = xc(y) + side * rand(0, 2)
          local yy = y + rand(-2, 2)
          local droop = L * rand(0.18, 0.4)
          local pts = {{x0, yy}, {x0 + side*L*0.4, yy + droop*0.55}, {x0 + side*L*0.8, yy + droop}, {x0 + side*L, yy + droop*0.85}}
          br:stroke(pts, {pressure={rand(0.6,0.9), 0.08}, ramps={0.05, 0.5}})
          n = n + 1
          -- fringe hanging from the branch
          local nf = math.floor(rand(0, 3.5) * math.min(1, L/20))
          for f = 1, nf do
            local u = rand(0.35, 0.95)
            local fx = x0 + side*L*u
            local fy = yy + droop*u*0.9
            fr:stroke({{fx, fy}, {fx + side*rand(0,2), fy + rand(4, 9) * (0.5 + t)}}, {pressure={0.6, 0.05}})
            n = n + 1
            if n % 10 == 0 then fr:load(pile_, 0.8) end
          end
          if n % 5 == 0 then br:load(pile_, 0.85) end
        end
      end
    end
    y = y + (2.5 + 9 * t) * rand(0.6, 1.5)
  end
  return n
end
print(spruce(300, 120, 640, 70, tree_dark2, 11))

--@ chunk 3
function spruce2(cx, top, base, halfw, pile_, seed, opts)
  opts = opts or {}
  math.randomseed(seed)
  local lean = opts.lean or 0
  local bw = opts.bw or 4.5
  local br = brush{kind="round", width=bw, point=0.5, lay=1.4}
  local dab = brush{kind="filbert", width=bw*1.1, lay=1.3}
  local function xc(y) return cx + lean * (base - y) + 1.5*math.sin(y/37) end
  br:load(pile_, 1.0); dab:load(pile_, 1.0)
  local lead = brush{kind="round", width=math.max(2, bw*0.7), point=0.8}
  lead:load(pile_, 0.9)
  lead:gesture({{xc(top), top, 0.05}, {xc(top + (base-top)*0.3), top + (base-top)*0.3, 0.5}, {xc(base), base, 0.9}})
  local y = top + 2
  local n = 0
  while y < base do
    local t = (y - top) / (base - top)
    local wf = rand(0.6, 1.15)
    local half = halfw * (0.05 + 0.95 * t^0.8) * wf
    local nb = 1 + math.floor(rand(1, 3.5))
    for side = -1, 1, 2 do
      for j = 1, nb do
        if rand(0,1) > (opts.gap or 0.1) then
          local L = half * rand(0.6, 1.05)
          local x0 = xc(y) - side * 1
          local yy = y + rand(-2, 2)
          local droop = L * (rand(0.1, 0.3) + 0.25 * t)
          local up = L * rand(0.0, 0.12)
          local pts = {{x0, yy}, {x0 + side*L*0.45, yy + droop*0.6}, {x0 + side*L*0.85, yy + droop}, {x0 + side*L, yy + droop - up}}
          br:stroke(pts, {pressure={rand(0.55,0.85), 0.1}, ramps={0.05, 0.45}})
          n = n + 1
          local nf = math.floor(rand(1, 4) * math.min(1, L/18))
          for f = 1, nf do
            local u = rand(0.25, 0.9)
            local fx = x0 + side*L*u
            local fy = yy + droop*u*0.95 + rand(0, 2)
            dab:touch(fx, fy, {pressure=rand(0.25, 0.55), drag={side*rand(1,4), rand(2, 6)*(0.6+t)}, angle=side*rand(0.2,0.7)})
            n = n + 1
            if n % 8 == 0 then dab:load(pile_, 0.8) end
          end
          if n % 5 == 0 then br:load(pile_, 0.85) end
        end
      end
    end
    y = y + (2.5 + 8 * t) * rand(0.5, 1.6)
  end
  return n
end
print(spruce2(620, 120, 640, 75, tree_dark2, 12))

--@ chunk 4
local f = brush{kind="fan", width=16, lay=3}
local tests = {
  {orient="across", p={0.8,0.3}},
  {orient="along", p={0.8,0.3}},
  {orient=0, p={0.8,0.3}},
  {orient="across", p={0.4,0.1}},
}
for i,t in ipairs(tests) do
  f:reload(tree_dark2, 1.0)
  local x = 780 + (i-1)*50
  f:stroke({{x, 150}, {x+20, 175}, {x+35, 190}}, {pressure=t.p, orient=t.orient})
  f:reload(tree_dark2, 1.0)
  f:touch(x+10, 260, {pressure=0.8, drag={15, 12}, angle=0.6})
  f:reload(tree_dark2, 1.0)
  f:touch(x+10, 320, {pressure=0.5, drag={8, 14}, angle=0})
end
local fl = brush{kind="filbert", width=9, lay=2}
for i=1,4 do
  fl:reload(tree_dark2, 1.0)
  local x = 780 + (i-1)*50
  fl:stroke({{x, 400}, {x+15, 412}, {x+30, 425}, {x+38, 424}}, {pressure={0.9 - i*0.1, 0.05}, ramps={0.05, 0.6}})
end

--@ chunk 5
function spruce3(cx, top, base, halfw, pile_, seed, opts)
  opts = opts or {}
  math.randomseed(seed)
  local lean = opts.lean or 0
  local fw = opts.fw or 12
  local f = brush{kind="fan", width=fw, lay=2.5}
  local fs = brush{kind="fan", width=fw*0.6, lay=2}
  local function xc(y) return cx + lean * (base - y) + 1.2*math.sin(y/41 + seed) end
  local lead = brush{kind="round", width=math.max(2, fw*0.25), point=0.8}
  lead:load(pile_, 0.9)
  lead:gesture({{xc(top), top, 0.05}, {xc(top + (base-top)*0.3), top + (base-top)*0.3, 0.5}, {xc(base), base, 0.9}})
  f:load(pile_, 1.0); fs:load(pile_, 1.0)
  local y = top + 2
  local n = 0
  while y < base do
    local t = (y - top) / (base - top)
    local half = halfw * (0.05 + 0.95 * t^0.8) * rand(0.65, 1.15)
    local b = (t < 0.25) and fs or f
    for side = -1, 1, 2 do
      if rand(0,1) > (opts.gap or 0.08) then
        local L = half * rand(0.75, 1.05)
        local x0 = xc(y)
        local droop = L * (0.15 + 0.3 * t) * rand(0.7, 1.3)
        -- stroke from the trunk outward, pressure falling: thick near trunk, feathered tip
        b:stroke({{x0, y}, {x0 + side*L*0.5, y + droop*0.6}, {x0 + side*L, y + droop}}, {pressure={rand(0.6, 0.9), 0.05}, orient="across", ramps={0.05, 0.6}})
        n = n + 1
        -- a second, shorter stroke beneath for fullness
        if t > 0.2 and rand(0,1) < 0.7 then
          local L2 = L * rand(0.4, 0.75)
          b:stroke({{x0, y + 3}, {x0 + side*L2, y + 3 + droop*0.9}}, {pressure={0.7, 0.1}, orient="across"})
          n = n + 1
        end
        if n % 4 == 0 then f:load(pile_, 0.8); fs:load(pile_, 0.8) end
      end
    end
    y = y + (2 + 7 * t) * rand(0.6, 1.5)
  end
  return n
end
print(spruce3(140, 140, 640, 70, tree_dark2, 13))

--@ chunk 6
tree_hi = pile{{"chrome yellow", 1}, {"yellow ochre", 1}, {"Prussian blue", 0.12}, {"lead white", 0.6}, blot=0.15, name="tree_hi"}
tree_hi2 = pile{{"yellow ochre", 1}, {"vermilion", 0.2}, {"lead white", 1}, {"Prussian blue", 0.05}, blot=0.2, name="tree_hi2"}
math.randomseed(5)
local f = brush{kind="fan", width=8, lay=2}
f:load(tree_hi, 0.5)
local y = 200
local n = 0
while y < 620 do
  local t = (y-140)/500
  local half = 70 * (0.05 + 0.95 * t^0.8)
  local x0 = 140 - half*rand(0.3, 0.9)
  f:stroke({{x0, y}, {x0 - half*0.25, y + half*0.12}}, {pressure={0.35, 0.05}, orient="across"})
  n = n + 1
  if n % 3 == 0 then f:wipe(0.5); f:load(tree_hi, 0.4) end
  y = y + rand(10, 22)
end
-- on the right tree spruce2 at x=620: try with pressure higher
local f2 = brush{kind="fan", width=8, lay=2}
f2:load(tree_hi2, 0.5)
y = 200
while y < 620 do
  local t = (y-120)/520
  local half = 75 * (0.05 + 0.95 * t^0.8)
  local x0 = 620 - half*rand(0.3, 0.9)
  f2:touch(x0, y, {pressure=0.5, drag={-6, 5}, angle=0.4})
  f2:touch(x0+4, y+3, {pressure=0.4, drag={-5, 5}, angle=0.3})
  n = n + 1
  if n % 3 == 0 then f2:wipe(0.5); f2:load(tree_hi2, 0.4) end
  y = y + rand(10, 22)
end
