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
sky_mid = pile{{"lead white", 4}, {"cobalt blue", 0.45}, {"vermilion", 0.22}, name="sky_mid"}
sky_top = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 0.8}, name="sky_top"}
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
work(everywhere(), {hand="broad", piles={{sky_top, function(x,y) return 1 - y/749 end}, {sky_mid, function(x,y) return y/749 end}}, coverage=2, load=0.45, angle=0.7})
blend(everywhere(), {angle=0})
tree_dark = pile{{"Prussian blue", 0.6}, {"raw umber", 1}, {"bone black", 0.5}, name="tree_dark"}
function big_spruce(cx, top, base, halfw, pile_, seed, opts)
  opts = opts or {}
  math.randomseed(seed)
  local lean = opts.lean or 0
  local fw = opts.fw or 16
  local f = brush{kind="fan", width=fw, lay=2.5}
  local fs = brush{kind="fan", width=fw*0.55, lay=2}
  local function xc(y) return cx + lean * (base - y) + 2*math.sin(y/53 + seed) end
  local tw = opts.trunk or 6
  local lead = brush{kind="round", width=tw, point=0.7}
  lead:load(pile_, 1.0)
  lead:gesture({{xc(top), top, 0.03}, {xc(top + (base-top)*0.25), top + (base-top)*0.25, 0.35}, {xc(base - (base-top)*0.3), base - (base-top)*0.3, 0.8}, {xc(base), base, 1.0}})
  f:load(pile_, 1.0); fs:load(pile_, 1.0)
  local y = top + 3
  local n = 0
  while y < base - (opts.skirt or 0) do
    local t = (y - top) / (base - top)
    local half = halfw * (0.04 + 0.96 * t^0.85) * rand(0.6, 1.15)
    local b = (t < 0.12) and fs or f
    for side = -1, 1, 2 do
      if rand(0,1) > (opts.gap or 0.1) then
        local L = half * rand(0.75, 1.05)
        local x0 = xc(y)
        local droop = L * (0.12 + 0.35 * t) * rand(0.7, 1.3)
        local lift = L * rand(-0.05, 0.12)
        b:stroke({{x0, y}, {x0 + side*L*0.45, y + droop*0.65}, {x0 + side*L*0.85, y + droop}, {x0 + side*L, y + droop - lift}}, {pressure={rand(0.6, 0.9), 0.05}, orient="across", ramps={0.05, 0.6}})
        n = n + 1
        if t > 0.15 and rand(0,1) < 0.75 then
          local L2 = L * rand(0.35, 0.7)
          local yy = y + rand(3, 7) * (0.5 + t)
          b:stroke({{x0, yy}, {x0 + side*L2*0.6, yy + droop*0.6}, {x0 + side*L2, yy + droop*0.9}}, {pressure={0.75, 0.1}, orient="across"})
          n = n + 1
        end
        if n % 3 == 0 then f:load(pile_, 0.85); fs:load(pile_, 0.8) end
      end
    end
    y = y + (2.5 + 11 * t) * rand(0.6, 1.4)
  end
  return n
end
print(big_spruce(300, 20, 740, 75, tree_dark, 31, {fw=16, trunk=6}))

--@ chunk 3
function big_spruce2(cx, top, base, halfw, pile_, seed, opts)
  opts = opts or {}
  math.randomseed(seed)
  local lean = opts.lean or 0
  local fw = opts.fw or 16
  local f = brush{kind="fan", width=fw, lay=2.5}
  local fs = brush{kind="fan", width=fw*0.55, lay=2}
  local fr = brush{kind="fan", width=fw*0.5, lay=2}
  local wob = noise{seed=seed, period=90, octaves=2}
  local function xc(y) return cx + lean * (base - y) + 3*wob(cx, y) end
  local tw = opts.trunk or 6
  local lead = brush{kind="round", width=tw, point=0.7}
  lead:load(pile_, 1.0)
  lead:gesture({{xc(top), top, 0.03}, {xc(top + (base-top)*0.25), top + (base-top)*0.25, 0.35}, {xc(base - (base-top)*0.3), base - (base-top)*0.3, 0.8}, {xc(base), base, 1.0}})
  f:load(pile_, 1.0); fs:load(pile_, 1.0); fr:load(pile_, 1.0)
  local env = noise{seed=seed + 7, period=60, octaves=2}
  local y = top + 3
  local n = 0
  while y < base - (opts.skirt or 0) do
    local t = (y - top) / (base - top)
    -- the silhouette swells and pinches irregularly
    local half = halfw * (0.04 + 0.96 * t^0.85) * (0.85 + 0.35 * env(0, y))
    local b = (t < 0.12) and fs or f
    for side = -1, 1, 2 do
      local nb = (t < 0.1) and 1 or (1 + math.floor(rand(0, 2.2)))
      for j = 1, nb do
        if rand(0,1) > (opts.gap or 0.12) then
          local L = half * rand(0.45, 1.05)
          if rand(0,1) < 0.12 then L = L * rand(1.15, 1.4) end
          local x0 = xc(y)
          local yy = y + (j - 1) * rand(2, 5)
          local droop = L * (0.1 + 0.4 * t) * rand(0.6, 1.4)
          local lift = L * rand(-0.05, 0.15)
          b:stroke({{x0, yy}, {x0 + side*L*0.45, yy + droop*0.65}, {x0 + side*L*0.85, yy + droop}, {x0 + side*L, yy + droop - lift}}, {pressure={rand(0.55, 0.9), 0.05}, orient="across", ramps={0.05, 0.6}})
          n = n + 1
          -- hanging fringe under the branch
          if t > 0.2 then
            local nf = math.floor(rand(0, 3) * math.min(1, L / 30))
            for k = 1, nf do
              local u = rand(0.3, 0.85)
              local fx = x0 + side * L * u
              local fy = yy + droop * u
              fr:stroke({{fx, fy}, {fx + side * rand(0, 3), fy + rand(5, 12) * (0.6 + t)}}, {pressure={0.6, 0.05}, orient="across"})
              n = n + 1
            end
          end
          if n % 3 == 0 then f:load(pile_, 0.85); fs:load(pile_, 0.8); fr:load(pile_, 0.7) end
        end
      end
    end
    -- whorl spacing: irregular; occasional bigger gap
    local step = (3 + 12 * t) * rand(0.6, 1.4)
    if t > 0.25 and rand(0,1) < 0.15 then step = step * 1.8 end
    y = y + step
  end
  return n
end
print(big_spruce2(700, 20, 740, 80, tree_dark, 32, {fw=16, trunk=6}))

--@ chunk 4
cloud_pink = pile{{"lead white", 4}, {"vermilion", 0.35}, {"chrome yellow", 0.12}, {"cobalt blue", 0.05}, blot=0.1, name="cloud_pink"}
cloud_body = pile{{"lead white", 3}, {"cobalt blue", 0.5}, {"vermilion", 0.15}, {"red earth", 0.08}, name="cloud_body"}
math.randomseed(77)
local fb = brush{kind="filbert", width=10}
-- A (x 780-1000, y 60-200): long wisps, body then pink underside, then blend
for i = 1, 6 do
  local y = 70 + i * 22 + rand(-5, 5)
  local x0 = rand(780, 830); local x1 = rand(930, 1000)
  fb:load(cloud_body, 0.5)
  fb:stroke({{x0, y}, {(x0+x1)/2, y - rand(2, 6)}, {x1, y + rand(-3, 3)}}, {pressure={0.15, 0.4}, ramps={0.3, 0.3}})
  fb:load(cloud_pink, 0.5)
  fb:stroke({{x0 + 10, y + 5}, {(x0+x1)/2, y + 2}, {x1 - 10, y + 6}}, {pressure={0.1, 0.3}, ramps={0.3, 0.4}})
end
blend(rect(770, 50, 230, 180):soften(10), {angle=0, pressure={0.15, 0.3}})
-- B (x 20-250, y 400-650): fan taps, small arcs, then blend up
local fan = brush{kind="fan", width=18}
for i = 1, 30 do
  fan:load(cloud_pink, 0.35)
  local x = rand(30, 240); local y = 520 + rand(-40, 40)
  fan:touch(x, y, {pressure=0.4, drag={rand(-12, 12), rand(-4, 2)}, angle=rand(-0.3, 0.3)})
end
blend(rect(20, 440, 240, 160):soften(10), {angle=-math.pi/2 + 0.2, pressure={0.1, 0.25}})
