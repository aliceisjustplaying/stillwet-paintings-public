-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_top  = pile{{"lead white",1.5},{"smalt",1.2},{"cobalt blue",0.8},{"raw umber",0.08}, name="s_top"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
local sky = rect(0,0,1000,470)
work(sky, {hand="broad", piles={{s_top,function(x,y) return clamp(1-y/400,0,1) end},{s_glow,function(x,y) return clamp(y/400,0,1) end}}, angle=0, coverage=2.2, fill=true, clip=sky, seed=3})
blend(sky, {angle=0})
local land = pile({{"raw umber",2},{"bone black",0.5},{"Prussian blue",0.12}, turps=0.6})
hill_pts = {{0,575},{100,561},{200,546},{300,539},{380,543},{450,556},{520,579},{600,603},{700,614},{850,619},{1000,623}}
work(below(hill_pts) + rect(0,470,1000,244), {hand="broad", pile=land, angle=0, coverage=2, fill=true, clip=rect(0,468,1000,250), seed=5})
print(wait(3*24*60))
print(drying(300,300), drying(300,600))

--@ chunk 3
oak = {
  {{{305,548},{304,520},{301,490},{299,455},{300,425},{305,405}}, {58,46,40,37,35,33}},  -- trunk
  {{{292,418},{270,388},{248,372},{224,340},{206,302},{180,283},{161,246},{150,216},{141,188},{147,163}}, {22,18,16,13,11,9,7,5,3.5,2}}, -- L1
  {{{224,340},{190,346},{161,336},{136,343},{111,331},{91,335}}, {9,7,5.5,4,2.8,1.6}}, -- L1a
  {{{206,302},{216,267},{206,236},{221,202},{213,172}}, {7.5,6,4.5,3,1.8}}, -- L1b
  {{{161,246},{132,240},{116,216},{96,206}}, {5,3.8,2.6,1.4}}, -- L1c
  {{{305,412},{312,372},{305,332},{318,292},{314,252},{326,217},{323,186}}, {25,21,18,15,13,12,11}}, -- L2 (broken top)
  {{{305,334},{281,302},{272,271},{255,246},{258,216},{246,190}}, {9,7.5,6,4.5,3,1.8}}, -- L2a
  {{{318,292},{345,266},{352,236},{372,216},{378,186}}, {8,6.5,5,3.5,2}}, -- L2b
  {{{323,192},{335,167},{331,142}}, {4,2.8,1.4}}, -- L2 dead sprig
  {{{316,412},{350,393},{381,388},{411,371},{441,362},{469,341},{501,332},{531,316},{561,311}}, {23,18,15.5,13,10.5,8.5,6,4,2}}, -- L3
  {{{381,388},{403,404},{430,410},{448,425}}, {6,4.5,3,1.6}}, -- L3a (drooping)
  {{{411,371},{419,336},{411,301},{426,269},{421,241}}, {8,6.5,5,3.5,2}}, -- L3b
  {{{469,341},{479,311},{501,291},{506,263}}, {5.5,4,3,1.6}}, -- L3c
  {{{501,332},{521,345},{546,346}}, {3.5,2.5,1.3}}, -- L3d
  {{{318,404},{344,361},{360,321},{385,291},{391,251},{410,226},{416,196}}, {16,13,11,9,7,5,3}}, -- L5
  {{{385,291},{361,266},{356,236}}, {4.5,3.2,1.8}}, -- L5a
  {{{300,457},{276,448},{266,451}}, {15,12,11}}, -- stub
}
function oak_mask(sk)
  local tm = nil
  for _, br in ipairs(sk) do
    local r = ribbon(br[1], br[2])
    tm = tm and (tm + r) or r
  end
  -- root flare
  tm = tm + poly({{258,556},{270,546},{283,530},{292,512},{318,512},{326,530},{340,546},{356,557}}, true)
  return tm
end
oakm = oak_mask(oak):roughen(1.0, 5, 3)
t_dark = pile{{"raw umber",1.3},{"bone black",0.8},{"Prussian blue",0.1},{"red earth",0.1}, name="t_dark"}
work(oakm, {hand="detail", pile=t_dark, coverage=2.5, fill=true, angle=-math.pi/2, seed=201})

--@ chunk 4
rg = brush{kind="rigger", width=3, point=1}
for _,w in ipairs({0.4,0.8,1.2,2,3}) do print(w, rg:pressure_for(w)) end
rg2 = brush{kind="round", width=5, point=1}
for _,w in ipairs({1,2,3,4,5}) do print(w, rg2:pressure_for(w)) end

--@ chunk 5
rg_s = brush{kind="rigger", width=1.6, point=1}
rg_m = brush{kind="rigger", width=3.2, point=1}
for _,w in ipairs({0.3,0.5,0.8,1.2,1.6}) do print(w, rg_s:pressure_for(w)) end
function twig(x, y, ang, len, w, depth, pl)
  local br = (w > 1.4) and rg_m or rg_s
  local n = math.random(3,5)
  local pts = {}
  local cx, cy, a = x, y, ang
  local nodes = {}
  for i=0,n do
    local t = i/n
    local ww = w*(1 - 0.85*t)
    local p = (i==n) and 0 or math.max(0.02, br:pressure_for(math.max(ww, 0.35)))
    pts[#pts+1] = {cx, cy, p}
    nodes[#nodes+1] = {cx, cy, a, ww}
    if i < n then
      local seg = len/n * rand(0.7, 1.3)
      a = a + randn(0, 0.38)
      -- slight upward tendency for oak twigs, but crooked
      a = a + 0.12*(( -math.pi/2) - a)
      cx = cx + seg*math.cos(a); cy = cy + seg*math.sin(a)
    end
  end
  if br:fullness() < 0.35 then br:reload(pl, 0.7) end
  br:gesture(pts, {wobble=0.3})
  if depth > 0 then
    local k = math.random(1, 3)
    for j=1,k do
      local nd = nodes[math.random(2, #nodes-1)]
      local side = (math.random() < 0.5) and -1 or 1
      twig(nd[1], nd[2], nd[3] + side*rand(0.35, 0.95), len*rand(0.45,0.7), nd[4]*0.8, depth-1, pl)
    end
  end
end
t_twig = pile{{"raw umber",1.2},{"bone black",0.8},{"Prussian blue",0.08}, medium=0.15, name="t_twig"}
rg_s:load(t_twig, 0.7); rg_m:load(t_twig, 0.7)
-- tips of L1, L1b, L2b, L3b, L5 in test
twig(147,163,-1.4, 40, 1.6, 2, t_twig)
twig(213,172,-1.6, 38, 1.6, 2, t_twig)
twig(378,186,-1.3, 40, 1.8, 2, t_twig)
twig(421,241,-1.7, 40, 1.8, 2, t_twig)
twig(561,311,-0.2, 40, 1.6, 2, t_twig)
twig(91,335,-2.9, 35, 1.4, 2, t_twig)

--@ chunk 6
for _,p in ipairs({0.05,0.15,0.25,0.4,0.6,0.8}) do print(p, rg_s:mark_width(p), rg_m:mark_width(p)) end

--@ chunk 7
function twig(x, y, ang, len, w, depth, pl)
  local br = (w > 1.5) and rg_m or rg_s
  local n = math.random(3,5)
  local pts = {}
  local cx, cy, a = x, y, ang
  local nodes = {}
  for i=0,n do
    local t = i/n
    local ww = w*(1 - 0.7*t)
    local p = (i==n) and 0.15 or math.max(0.32, br:pressure_for(ww))
    pts[#pts+1] = {cx, cy, p}
    nodes[#nodes+1] = {cx, cy, a, ww}
    if i < n then
      local seg = len/n * rand(0.7, 1.3)
      a = a + randn(0, 0.4)
      a = a + 0.1*((-math.pi/2) - a)
      cx = cx + seg*math.cos(a); cy = cy + seg*math.sin(a)
    end
  end
  if br:fullness() < 0.4 then br:reload(pl, 0.75) end
  br:gesture(pts, {wobble=0.3})
  if depth > 0 then
    local k = math.random(1, 3)
    for j=1,k do
      local nd = nodes[math.random(2, #nodes-1)]
      local side = (math.random() < 0.5) and -1 or 1
      twig(nd[1], nd[2], nd[3] + side*rand(0.35, 0.95), len*rand(0.5,0.75), nd[4]*0.85, depth-1, pl)
    end
  end
end
rg_s:reload(t_twig, 0.75); rg_m:reload(t_twig, 0.75)
twig(141,188,-1.5, 55, 2.2, 2, t_twig)
twig(323,186,-1.9, 50, 2.5, 2, t_twig)
twig(416,196,-1.5, 55, 2.2, 2, t_twig)
twig(506,263,-1.2, 50, 2, 2, t_twig)
twig(546,346,0.2, 40, 1.6, 2, t_twig)

--@ chunk 8
function sprout(limb, pl, opts)
  opts = opts or {}
  local pts, ws = limb[1], limb[2]
  local spacing = opts.spacing or 30
  local acc = rand(0, spacing)
  for i=1,#pts-1 do
    local x0,y0,x1,y1 = pts[i][1],pts[i][2],pts[i+1][1],pts[i+1][2]
    local dx,dy = x1-x0, y1-y0
    local d = math.sqrt(dx*dx+dy*dy)
    local la = math.atan(dy, dx)
    local s = 0
    while true do
      local step = spacing*rand(0.6,1.4)
      if acc + (d - s) < step then acc = acc + (d - s); break end
      s = s + (step - acc); acc = 0
      local t = s/d
      local wl = lerp(ws[i], ws[i+1], t)
      if wl < (opts.minw or 3) then goto cont end
      do
        local x, y = x0 + dx*t, y0 + dy*t
        local side = (math.random() < 0.5) and -1 or 1
        local a = la + side*rand(0.5, 1.2)
        -- bias upward
        a = a + 0.25*((-math.pi/2) - a)
        local bw = math.min(4.5, wl*rand(0.3, 0.5))
        local ln = (opts.len or 45) * rand(0.6, 1.3) * math.min(1.4, 0.6 + wl/15)
        -- start slightly inside the limb
        local ox, oy = x + math.cos(a)*wl*0.3, y + math.sin(a)*wl*0.3
        twig(ox, oy, a, ln, bw, opts.depth or 2, pl)
      end
      ::cont::
    end
  end
end
-- apply to a few limbs of oak table
sprout(oak[2], t_twig, {spacing=35, len=50})   -- L1
sprout(oak[10], t_twig, {spacing=35, len=50})  -- L3
sprout(oak[15], t_twig, {spacing=35, len=50})  -- L5

--@ chunk 9
rd_m = brush{kind="round", width=4, point=1}
function zig(x, y, ang, len, w, depth, pl)
  local br = (w > 1.6) and rd_m or rg_s
  local n = math.random(2,4)
  local cx, cy, a = x, y, ang
  local nodes = {}
  if br:fullness() < 0.45 then br:reload(pl, 0.75) end
  for i=1,n do
    local seg = len/n * rand(0.7, 1.3)
    a = a + randn(0, 0.45)
    a = a + 0.15*((-math.pi/2) - a)
    local nx, ny = cx + seg*math.cos(a), cy + seg*math.sin(a)
    local w0 = w*(1 - 0.75*(i-1)/n); local w1 = w*(1 - 0.75*i/n)
    local p0 = math.max(0.3, br:pressure_for(w0))
    local p1 = (i==n) and 0.12 or math.max(0.3, br:pressure_for(w1))
    br:stroke({{cx,cy},{nx,ny}}, {pressure={p0,p1}, ramps={0.02, (i==n) and 0.5 or 0.02}})
    nodes[#nodes+1] = {nx, ny, a, w1}
    cx, cy = nx, ny
  end
  if depth > 0 then
    -- oak: clustered shoots near the tip
    local k = math.random(1, 3)
    for j=1,k do
      local nd = nodes[math.random(math.max(1,#nodes-2), #nodes)]
      local side = (math.random() < 0.5) and -1 or 1
      zig(nd[1], nd[2], nd[3] + side*rand(0.3, 1.0), len*rand(0.45,0.7), math.max(0.8, nd[4]*0.9), depth-1, pl)
    end
  end
end
function sprout2(limb, pl, opts)
  opts = opts or {}
  local pts, ws = limb[1], limb[2]
  local spacing = opts.spacing or 30
  local acc = rand(0, spacing)
  for i=1,#pts-1 do
    local x0,y0,x1,y1 = pts[i][1],pts[i][2],pts[i+1][1],pts[i+1][2]
    local dx,dy = x1-x0, y1-y0
    local d = math.sqrt(dx*dx+dy*dy)
    local la = math.atan(dy, dx)
    local s = 0
    while true do
      local step = spacing*rand(0.6,1.4)
      if acc + (d - s) < step then acc = acc + (d - s); break end
      s = s + (step - acc); acc = 0
      local t = s/d
      local wl = lerp(ws[i], ws[i+1], t)
      if wl >= (opts.minw or 3) then
        local x, y = x0 + dx*t, y0 + dy*t
        -- prefer the upper side of the limb
        local up1 = la - math.pi/2; local up2 = la + math.pi/2
        local side = (math.sin(up1) < math.sin(up2)) and -1 or 1
        if math.random() < 0.25 then side = -side end
        local a = la + side*rand(0.5, 1.1)
        a = a + 0.2*((-math.pi/2) - a)
        local bw = math.min(3.2, wl*rand(0.3, 0.45))
        local ln = (opts.len or 30) * rand(0.6, 1.3)
        local ox, oy = x + math.cos(a)*wl*0.35, y + math.sin(a)*wl*0.35
        zig(ox, oy, a, ln, bw, opts.depth or 1, pl)
      end
    end
  end
end
rd_m:load(t_twig, 0.75); rg_s:reload(t_twig, 0.75)
test_limb = {{{620,420},{680,380},{740,360},{800,330},{860,320},{920,300},{960,296}}, {16,13,11,9,7,5,3}}
local m = ribbon(test_limb[1], test_limb[2]):roughen(1.0,5,3)
work(m, {hand="detail", pile=t_dark, coverage=2.5, fill=true, seed=301})
sprout2(test_limb, t_twig, {spacing=28, len=30, depth=1})
zig(960,296,-0.5, 40, 2.2, 2, t_twig)
zig(700,220,-1.4, 60, 2.6, 2, t_twig)

--@ chunk 10
function zig2(x, y, ang, len, w, depth, pl)
  local br = (w > 1.7) and rd_m or rg_s
  local n = math.random(3,4)
  local cx, cy, a = x, y, ang
  local nodes = {}
  local pts = {}
  if br:fullness() < 0.45 then br:reload(pl, 0.75) end
  pts[1] = {cx, cy, math.max(0.32, br:pressure_for(w))}
  for i=1,n do
    local seg = len/n * rand(0.7, 1.3)
    a = a + randn(0, 0.5)
    a = a + 0.15*((-math.pi/2) - a)
    cx, cy = cx + seg*math.cos(a), cy + seg*math.sin(a)
    local wi = w*(1 - 0.75*i/n)
    pts[#pts+1] = {cx, cy, (i==n) and 0.1 or math.max(0.32, br:pressure_for(wi))}
    nodes[#nodes+1] = {cx, cy, a, wi}
  end
  br:gesture(pts, {wobble=0.2, ramps={0.03, 0.3}})
  if depth > 0 then
    local k = math.random(1, 3)
    for j=1,k do
      local nd = nodes[math.random(math.max(1,#nodes-2), #nodes-1)]
      local side = (math.random() < 0.5) and -1 or 1
      zig2(nd[1], nd[2], nd[3] + side*rand(0.35, 1.0), len*rand(0.4,0.65), math.max(0.8, nd[4]*0.9), depth-1, pl)
    end
  end
end
function sprout3(limb, pl, opts)
  opts = opts or {}
  local pts, ws = limb[1], limb[2]
  local spacing = opts.spacing or 30
  local acc = rand(0, spacing)
  for i=1,#pts-1 do
    local x0,y0,x1,y1 = pts[i][1],pts[i][2],pts[i+1][1],pts[i+1][2]
    local dx,dy = x1-x0, y1-y0
    local d = math.sqrt(dx*dx+dy*dy)
    local la = math.atan(dy, dx)
    local s = 0
    while true do
      local step = spacing*rand(0.6,1.4)
      if acc + (d - s) < step then acc = acc + (d - s); break end
      s = s + (step - acc); acc = 0
      local t = s/d
      local wl = lerp(ws[i], ws[i+1], t)
      if wl >= (opts.minw or 3) then
        local x, y = x0 + dx*t, y0 + dy*t
        local up1 = la - math.pi/2; local up2 = la + math.pi/2
        local side = (math.sin(up1) < math.sin(up2)) and -1 or 1
        if math.random() < 0.25 then side = -side end
        local a = la + side*rand(0.5, 1.1)
        a = a + 0.2*((-math.pi/2) - a)
        local bw = math.min(3.0, wl*rand(0.3, 0.45))
        local ln = (opts.len or 30) * rand(0.6, 1.3)
        local ox, oy = x + math.cos(a)*wl*0.35, y + math.sin(a)*wl*0.35
        zig2(ox, oy, a, ln, bw, opts.depth or 1, pl)
      end
    end
  end
end
rd_m:reload(t_twig, 0.75); rg_s:reload(t_twig, 0.75)
local L2 = {{{620,470},{680,440},{740,425},{800,410},{860,400},{920,395},{975,385}}, {16,13,11,9,7,5,3}}
local m = ribbon(L2[1], L2[2]):roughen(1.0,5,3) * above(function(x) return 468 end)
work(m, {hand="detail", pile=t_dark, coverage=2.5, fill=true, seed=302})
sprout3(L2, t_twig, {spacing=26, len=28, depth=1})
zig2(975,385,-0.6, 30, 2.2, 2, t_twig)
zig2(820,120,-1.4, 60, 2.8, 2, t_twig)
zig2(920,120,-1.6, 50, 2.4, 2, t_twig)
