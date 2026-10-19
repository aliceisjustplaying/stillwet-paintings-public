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
work(everywhere(), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
work(everywhere(), {hand="broad", pile=sky_mid, coverage=2, load=0.45, angle=0})
blend(everywhere(), {angle=0})
tree_dark = pile{{"Prussian blue", 0.6}, {"raw umber", 1}, {"bone black", 0.5}, name="tree_dark"}
function big_spruce(cx, top, base, halfw, pile_, seed, opts)
  opts = opts or {}
  math.randomseed(seed)
  local lean = opts.lean or 0
  local fw = opts.fw or 16
  local f = brush{kind="fan", width=fw, lay=2.5}
  local fs = brush{kind="fan", width=fw*0.55, lay=2}
  local wob = noise{seed=seed, period=90, octaves=2}
  local env = noise{seed=seed + 7, period=opts.envp or 70, octaves=2}
  local function xc(y) return cx + lean * (base - y) + 2.5*wob(cx, y) end
  local tw = opts.trunk or 6
  local lead = brush{kind="round", width=tw, point=0.7}
  lead:load(pile_, 1.0)
  lead:gesture({{xc(top), top, 0.03}, {xc(top + (base-top)*0.25), top + (base-top)*0.25, 0.35}, {xc(base - (base-top)*0.3), base - (base-top)*0.3, 0.8}, {xc(base), base, 1.0}})
  f:load(pile_, 1.0); fs:load(pile_, 1.0)
  local y = top + 3
  local n = 0
  local br = {}
  while y < base - (opts.skirt or 0) do
    local t = (y - top) / (base - top)
    local half = halfw * (0.04 + 0.96 * t^0.85) * (0.82 + 0.4 * env(0, y))
    local b = (t < 0.12) and fs or f
    local skip = (t > 0.3 and rand(0,1) < (opts.skip or 0.08))
    if not skip then
      for side = -1, 1, 2 do
        if rand(0,1) > (opts.gap or 0.1) then
          local L = half * rand(0.65, 1.05)
          if rand(0,1) < 0.1 then L = L * rand(1.15, 1.35) end
          local x0 = xc(y)
          local droop = L * (0.12 + 0.35 * t) * rand(0.7, 1.3)
          local lift = L * rand(-0.05, 0.14)
          b:stroke({{x0, y}, {x0 + side*L*0.45, y + droop*0.65}, {x0 + side*L*0.85, y + droop}, {x0 + side*L, y + droop - lift}}, {pressure={rand(0.6, 0.9), 0.05}, orient="across", ramps={0.05, 0.6}})
          br[#br+1] = {x0, y, side, L, droop, lift}
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
    end
    y = y + (2.5 + 11 * t) * rand(0.6, 1.4)
  end
  return br
end
B1 = big_spruce(200, 60, 700, 70, tree_dark, 11, {fw=15, trunk=5})
B2 = big_spruce(500, 60, 700, 70, tree_dark, 12, {fw=15, trunk=5})
B3 = big_spruce(800, 60, 700, 70, tree_dark, 13, {fw=15, trunk=5})
print(#B1)

--@ chunk 3
tree_hi_cool = pile{{"Prussian blue", 0.3}, {"raw umber", 0.5}, {"lead white", 1.0}, {"cobalt blue", 0.3}, {"yellow ochre", 0.3}, blot=0.15, name="tree_hi_cool"}
tree_hi_warm = pile{{"yellow ochre", 0.6}, {"raw umber", 0.5}, {"lead white", 0.7}, {"Prussian blue", 0.15}, {"vermilion", 0.05}, blot=0.15, name="tree_hi_warm"}
function tree_highlights(br, p, opts)
  opts = opts or {}
  local f = brush{kind="fan", width=opts.fw or 8, lay=1.5}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift = table.unpack(b)
    local want = (side == -1) and (opts.left or 0.7) or (opts.right or 0.15)
    if rand(0,1) < want then
      if n % 2 == 0 then f:wipe(0.6); f:load(p, opts.load or 0.4) end
      local u0 = rand(0.35, 0.6)
      local u1 = rand(0.8, 1.0)
      local xa, ya = x0 + side*L*u0, y + droop*u0*0.8 - 1.5
      local xb, yb = x0 + side*L*u1, y + droop*u1 - lift*u1 - 1.5
      f:stroke({{xa, ya}, {xb, yb}}, {pressure={opts.p0 or 0.35, 0.05}, orient="across"})
      n = n + 1
    end
  end
  return n
end
math.randomseed(1)
print(tree_highlights(B1, tree_hi_cool, {}))
print(tree_highlights(B2, tree_hi_warm, {}))
print(tree_highlights(B3, tree_hi_cool, {left=0.5, right=0.1}))
print(tree_highlights(B3, tree_hi_warm, {left=0.3, right=0.0, fw=6}))

--@ chunk 4
B4 = big_spruce(350, 60, 700, 55, tree_dark, 14, {fw=13, trunk=4})
B5 = big_spruce(650, 60, 700, 55, tree_dark, 15, {fw=13, trunk=4})
tree_hi_dim = pile{{"Prussian blue", 0.3}, {"raw umber", 0.6}, {"bone black", 0.1}, {"lead white", 0.7}, {"cobalt blue", 0.3}, {"yellow ochre", 0.35}, blot=0.15, name="tree_hi_dim"}
function tree_touches(br, p, opts)
  opts = opts or {}
  local f = brush{kind="fan", width=opts.fw or 6, lay=1.3}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift = table.unpack(b)
    local want = (side == -1) and (opts.left or 0.7) or (opts.right or 0.1)
    if rand(0,1) < want then
      local k = math.floor(rand(1, 3.99))
      for j = 1, k do
        if n % 4 == 0 then f:wipe(0.6); f:load(p, opts.load or 0.35) end
        local u = rand(0.4, 1.0)
        local xa, ya = x0 + side*L*u, y + droop*u*0.85 - lift*u*u - 1.2
        local a = math.atan(droop/L, side)
        f:touch(xa, ya, {pressure=rand(0.2, 0.4), drag={side*rand(2,5), droop/L*3}, angle=a + math.pi/2})
        n = n + 1
      end
    end
  end
  return n
end
math.randomseed(2)
print(tree_touches(B4, tree_hi_dim, {}))
print(tree_touches(B5, tree_hi_cool, {left=0.5}))

--@ chunk 5
function tree_highlights2(br, p, opts)
  opts = opts or {}
  local f = brush{kind="fan", width=opts.fw or 7, lay=1.4}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift = table.unpack(b)
    local want = (side == -1) and (opts.left or 0.7) or (opts.right or 0.1)
    if rand(0,1) < want then
      local k = (L > 30) and math.floor(rand(1, 2.99)) or 1
      for j = 1, k do
        if n % 2 == 0 then f:wipe(0.6); f:load(p, opts.load or 0.4) end
        local u0 = rand(0.3, 0.7)
        local u1 = math.min(0.95, u0 + rand(0.15, 0.3))
        local xa, ya = x0 + side*L*u0, y + droop*u0*0.8 - 1.5
        local xb, yb = x0 + side*L*u1, y + droop*u1*0.9 - lift*u1 - 1.5
        f:stroke({{xa, ya}, {xb, yb}}, {pressure={opts.p0 or 0.32, 0.08}, orient="across"})
        n = n + 1
      end
    end
  end
  return n
end
B6 = big_spruce(110, 60, 700, 45, tree_dark, 16, {fw=12, trunk=4})
B7 = big_spruce(920, 60, 700, 45, tree_dark, 17, {fw=12, trunk=4})
math.randomseed(3)
print(tree_highlights2(B6, tree_hi_dim, {}))
print(tree_highlights2(B7, tree_hi_dim, {left=0.5}))
print(tree_highlights2(B7, tree_hi_cool, {left=0.3, fw=5}))

--@ chunk 6
math.randomseed(5); local a = rand(0,1)
math.randomseed(5)
local f = brush{kind="fan", width=8}
f:load(tree_dark, 0.5)
f:stroke({{50,50},{80,60}}, {pressure={0.5,0.1}, orient="across"})
local b = rand(0,1)
print(a, b)

--@ chunk 7
function cover_branches(br, p, fw)
  local f = brush{kind="fan", width=fw, lay=2.2}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift = table.unpack(b)
    if n % 3 == 0 then f:reload(p, 0.85) end
    local function pt(u) return {x0 + side*L*u, y + droop*u*0.85 - lift*u*u} end
    f:stroke({pt(0.2), pt(0.5), pt(0.8), pt(1.0)}, {pressure={0.75, 0.15}, orient="across", ramps={0.05, 0.5}})
    n = n + 1
  end
  return n
end
print(cover_branches(B1, tree_dark, 15))

--@ chunk 8
cover_branches(B2, tree_dark, 15)
cover_branches(B3, tree_dark, 15)
tree_mid = mix{{tree_dark, 0.5}, {tree_hi_cool, 0.5}, name="tree_mid"}
function tree_rim(br, p, pd, opts)
  opts = opts or {}
  local f = brush{kind="fan", width=opts.fw or 10, lay=1.6}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift, t = table.unpack(b)
    t = t or 0.5
    local want = (side == -1) and (opts.left or 0.6) or (opts.right or 0.15)
    if rand(0,1) < want then
      f:reload(pd, 0.6)
      f:load(p, opts.load or 0.5, {side=-1, share=opts.share or 0.35})
      local function pt(u) return {x0 + side*L*u, y + droop*u*0.85 - lift*u*u - 1} end
      local u0 = rand(0.3, 0.55)
      f:stroke({pt(u0), pt((u0 + 1)/2), pt(0.98)}, {pressure={0.55, 0.1}, orient="across", ramps={0.1, 0.5}})
      n = n + 1
    end
  end
  return n
end
math.randomseed(7)
print(tree_rim(B1, tree_hi_cool, tree_dark, {fw=12}))
print(tree_rim(B2, tree_mid, tree_dark, {fw=12}))
print(tree_rim(B3, tree_hi_cool, tree_dark, {fw=12, share=0.2, load=0.4}))

--@ chunk 9
tree_sky = pile{{"Prussian blue", 0.25}, {"raw umber", 0.5}, {"cobalt blue", 0.6}, {"lead white", 0.7}, {"yellow ochre", 0.12}, blot=0.15, name="tree_sky"}
function tree_lights(br, p, opts)
  opts = opts or {}
  local f = brush{kind="fan", width=opts.fw or 8, lay=1.5}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift, t = table.unpack(b)
    t = t or 0.5
    local want = (side == -1) and (opts.left or 0.6) or (opts.right or 0.2)
    if opts.tmax and t > opts.tmax then want = want * 0.3 end
    if rand(0,1) < want then
      if n % 2 == 0 then f:wipe(0.7); f:load(p, opts.load or 0.45) end
      local function pt(u) return {x0 + side*L*u, y + droop*u*0.85 - lift*u*u - 1.5} end
      local u0 = rand(0.25, 0.5)
      f:stroke({pt(u0), pt((u0 + 0.95)/2), pt(0.95)}, {pressure={opts.p0 or 0.4, 0.08}, orient="across", ramps={0.15, 0.5}})
      n = n + 1
    end
  end
  return n
end
math.randomseed(8)
print(tree_lights(B2, tree_sky, {fw=8}))
print(tree_lights(B3, tree_sky, {fw=10, p0=0.3}))

--@ chunk 10
cover_branches(B1, tree_dark, 15)
cover_branches(B2, tree_dark, 15)
tree_mid2 = pile{{"Prussian blue", 0.4}, {"raw umber", 0.8}, {"bone black", 0.25}, {"cobalt blue", 0.5}, {"lead white", 0.35}, blot=0.1, name="tree_mid2"}
function tree_planes(br, p, opts)
  opts = opts or {}
  local f = brush{kind="fan", width=opts.fw or 12, lay=1.6}
  local n = 0
  for i, b in ipairs(br) do
    local x0, y, side, L, droop, lift, t = table.unpack(b)
    local want = (side == -1) and (opts.left or 0.55) or (opts.right or 0.25)
    if rand(0,1) < want then
      if n % 2 == 0 then f:wipe(0.5); f:load(p, opts.load or 0.5) end
      local function pt(u) return {x0 + side*L*u, y + droop*u*0.85 - lift*u*u - 2} end
      local u0 = rand(0.1, 0.35)
      f:stroke({pt(u0), pt(0.55), pt(0.8), pt(1.0)}, {pressure={opts.p0 or 0.5, 0.1}, orient="across", ramps={0.2, 0.5}})
      n = n + 1
    end
  end
  return n
end
math.randomseed(9)
print(tree_planes(B1, tree_mid2, {fw=13}))
print(tree_planes(B2, tree_mid2, {fw=10, p0=0.4}))
