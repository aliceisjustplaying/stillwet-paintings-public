-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
local a = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3}}
local b = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2}}
local c = pile{{"lead white",6},{"Naples yellow",2.5},{"chrome yellow",0.5}}
work(rect(0,0,1000,560), {hand="broad", piles={{a, function(x,y) return math.exp(-((y-50)/120)^2) end},{b, function(x,y) return math.exp(-((y-260)/90)^2) end},{c, function(x,y) return math.exp(-((y-470)/90)^2) end}}, angle=0, coverage=2, fill=true, clip=true})
blend(rect(0,0,1000,560), {angle=0})
local mi = pile{{"lead white",8},{"Naples yellow",1.2},{"pale smalt",0.8}}
local mt = pile{{"lead white",3},{"smalt",1.5},{"rose madder",0.2},{"raw umber",0.3}}
local rg = pile{{"raw umber",3},{"bone black",1.4},{"green earth",0.6},{"smalt",0.4}}
local mpts = {{-10,524},{90,513},{185,502},{262,496},{300,493},{356,497},{418,511},{475,521},{500,523},{560,518},{630,507},{705,499},{742,497},{805,502},{880,512},{970,521},{1010,524}}
local rpts = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
work(below(mpts) * above(function(x) return 560 end), {hand="body", pile=mt, coverage=2, fill=true, clip=true})
work(below(function(x) return 560 end) - below(rpts), {hand="body", pile=mi, coverage=2, fill=true, clip=true})
work(below(rpts), {hand="body", pile=rg, coverage=2, fill=true, clip=true})
wait(4*24*60)
function taperw(pts, w0, w1, pw)
  local ws = {}
  local n = #pts
  for i = 1, n do local t = (i-1)/(n-1); ws[i] = w0 + (w1 - w0) * (t ^ (pw or 0.8)) end
  return ws
end
trunk_spine = {{500,600},{499,580},{496,556},{497,534},{501,516}}
trunk_w = {62,52,48,47,46}
limbs = {
  A  = {pts={{486,524},{466,512},{452,494},{438,482},{414,478},{392,470},{374,452},{366,430},{352,414},{334,406},{316,392},{306,374}}, w={30,6}},
  A1 = {pts={{438,482},{412,488},{386,492},{360,488},{336,494},{316,486},{294,484},{272,474},{256,470}}, w={13,3}},
  A2 = {pts={{392,470},{398,440},{390,414},{396,388},{388,360},{392,334},{384,312}}, w={12,3}},
  A3 = {pts={{452,494},{444,476},{441,467}}, w={8,7}, dead=true},
  C  = {pts={{498,520},{494,492},{489,466},{492,440},{484,414},{480,388},{486,362},{481,336},{483,312}}, w={30,10}},
  C1 = {pts={{483,314},{478,286},{484,262},{478,236},{471,214},{474,196}}, w={10,3}, dead=true},
  C2 = {pts={{481,330},{498,310},{506,290},{518,276}}, w={6,2}, dead=true},
  C3 = {pts={{489,466},{470,444},{460,418},{446,396},{442,368},{430,344},{426,320}}, w={13,3}},
  C4 = {pts={{480,388},{500,374},{514,350},{530,334},{540,310}}, w={9,2.5}},
  B  = {pts={{508,520},{530,508},{546,490},{568,480},{590,474},{608,458},{618,438},{640,426},{664,420},{684,406},{702,396}}, w={28,6}},
  B1 = {pts={{568,480},{596,488},{626,486},{652,478},{674,482},{700,476},{722,466},{744,462}}, w={12,3}},
  B2 = {pts={{546,490},{552,460},{566,432},{562,402},{576,376},{580,346},{594,322},{598,298}}, w={13,3}},
  B3 = {pts={{618,438},{624,410},{640,386},{646,362},{662,344}}, w={8,2.5}},
  B4 = {pts={{590,474},{604,486},{611,492}}, w={7,6}, dead=true},
}
tree_order = {"A","A1","A2","A3","C","C1","C2","C3","C4","B","B1","B2","B3","B4"}
function build_tree_mask()
  local m = ribbon(trunk_spine, trunk_w)
  for _, k in ipairs(tree_order) do local L = limbs[k]; m = m + ribbon(L.pts, taperw(L.pts, L.w[1], L.w[2], 0.7)) end
  m = m + poly({{430,612},{458,604},{468,590},{532,590},{542,604},{574,613},{548,617},{500,614},{454,617}}, true)
  return m:roughen(1.0, 8, 7)
end
tree_main = build_tree_mask()
tr1 = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}, name="tree_dark"}
work(tree_main, {hand="detail", pile=tr1, coverage=3, fill=true, length={6,16}, angle=function(x,y) return -math.pi/2 end})
wait(2*24*60)

--@ chunk 3
tw1 = pile{{"bone black",2},{"raw umber",1.5},{"smalt",0.8}, medium=0.15, name="twig"}
twig_count = 0
-- one crooked oak shoot and its side shoots
function sprig(b, pile, x, y, ang, len, w, depth, up)
  local pts = {{x, y}}
  local segs = math.max(2, math.floor(len / 7 + 0.5))
  local a, cx, cy = ang, x, y
  for i = 1, segs do
    a = a + randn(0, 0.38) + (up or 0.12) * math.sin(-math.pi/2 - a)
    local sl = len / segs * rand(0.75, 1.25)
    cx = cx + math.cos(a) * sl; cy = cy + math.sin(a) * sl
    pts[#pts+1] = {cx, cy}
  end
  twig_count = twig_count + 1
  if twig_count % 5 == 1 then b:load(pile, 0.75) end
  local g = {}
  for i, p in ipairs(pts) do
    local t = (i-1)/(#pts-1)
    local ww = w * (1 - 0.55 * t)
    g[#g+1] = {p[1], p[2], b:pressure_for(math.max(0.45, ww))}
  end
  g[#g][3] = math.min(g[#g][3], b:pressure_for(0.5))
  b:gesture(g, {wobble=0.2})
  if depth > 0 then
    local nk = math.random(2, 3)
    for k = 1, nk do
      local idx = (k == 1) and #pts or math.random(2, #pts)
      local p = pts[idx]
      local side = (math.random() < 0.5) and 1 or -1
      sprig(b, pile, p[1], p[2], a + side * rand(0.3, 0.95), len * rand(0.5, 0.72), w * 0.68, depth - 1, up)
    end
  end
end
-- point and direction along a limb at fraction t
function along(pts, t)
  local L, segs = 0, {}
  for i = 1, #pts-1 do local d = math.sqrt((pts[i+1][1]-pts[i][1])^2 + (pts[i+1][2]-pts[i][2])^2); segs[i] = d; L = L + d end
  local s = t * L
  for i = 1, #pts-1 do
    if s <= segs[i] or i == #pts-1 then
      local f = math.min(1, s / segs[i])
      local x = lerp(pts[i][1], pts[i+1][1], f); local y = lerp(pts[i][2], pts[i+1][2], f)
      return x, y, math.atan(pts[i+1][2]-pts[i][2], pts[i+1][1]-pts[i][1])
    end
    s = s - segs[i]
  end
end
local r = brush{kind="rigger", width=2, point=1}
-- trial on limb B2 only: tip and sides
local L = limbs.B2.pts
local x, y, a = along(L, 1.0)
sprig(r, tw1, x, y, a, 34, 2.0, 3)
for _, t in ipairs({0.45, 0.6, 0.75, 0.88}) do
  local x, y, a = along(L, t)
  local side = (math.random() < 0.5) and 1 or -1
  sprig(r, tw1, x, y, a + side * rand(0.5, 1.1), rand(22, 32), 1.8, 2)
end
print(twig_count)

--@ chunk 4
function sprig(b, pile, x, y, ang, len, w, depth, up, jit)
  jit = jit or 0.22
  local pts = {{x, y}}
  local segs = math.max(2, math.floor(len / 9 + 0.5))
  local a, cx, cy = ang, x, y
  for i = 1, segs do
    local elbow = (math.random() < 0.18) and randn(0, 0.5) or 0
    a = a + randn(0, jit) + elbow + (up or 0.08) * math.sin(-math.pi/2 - a)
    local sl = len / segs * rand(0.8, 1.2)
    cx = cx + math.cos(a) * sl; cy = cy + math.sin(a) * sl
    pts[#pts+1] = {cx, cy}
  end
  twig_count = twig_count + 1
  if twig_count % 3 == 1 then b:load(pile, 0.9) end
  local g = {}
  for i, p in ipairs(pts) do
    local t = (i-1)/(#pts-1)
    local ww = w * (1 - 0.6 * t)
    g[#g+1] = {p[1], p[2], b:pressure_for(math.max(0.45, ww))}
  end
  b:gesture(g, {wobble=0.15})
  if depth > 0 then
    local nk = (math.random() < 0.6) and 2 or 3
    for k = 1, nk do
      local idx
      if k == 1 then idx = #pts else idx = math.random(math.max(2, #pts // 2), #pts) end
      local p = pts[idx]
      local side = (k % 2 == 0) and 1 or -1
      if math.random() < 0.3 then side = -side end
      local ca = a + side * rand(0.3, 0.8)
      sprig(b, pile, p[1], p[2], ca, len * rand(0.6, 0.78), w * 0.7, depth - 1, up, jit)
    end
  end
end
local r = brush{kind="rigger", width=2, point=1}
local function limb_twigs(L, tipw, tiplen, sides)
  local x, y, a = along(L.pts, 1.0)
  sprig(r, tw1, x, y, a, tiplen, tipw, 3)
  for _, s in ipairs(sides) do
    local x, y, a = along(L.pts, s[1])
    sprig(r, tw1, x, y, a + s[2], s[3], s[4], s[5] or 2)
  end
end
limb_twigs(limbs.B3, 2.6, 55, {{0.35, -0.9, 40, 2.2}, {0.55, 0.8, 38, 2.0}, {0.75, -0.7, 34, 1.8}})
limb_twigs(limbs.A2, 2.6, 55, {{0.35, 0.9, 42, 2.2}, {0.5, -0.8, 40, 2.0}, {0.7, 0.7, 36, 1.8}, {0.85, -0.6, 30, 1.6}})
print(twig_count)

--@ chunk 5
function sprig2(br, pile, x, y, ang, len, w, depth, opts)
  opts = opts or {}
  local jit = opts.jit or 0.2
  local up = opts.up or 0.08
  local b = (w > 2.3 and br.round) or br.rigger
  local pts = {{x, y}}
  local segs = math.max(2, math.floor(len / 9 + 0.5))
  local a, cx, cy = ang, x, y
  for i = 1, segs do
    local elbow = (math.random() < 0.2) and randn(0, 0.45) or 0
    a = a + randn(0, jit) + elbow + up * math.sin(-math.pi/2 - a)
    local sl = len / segs * rand(0.8, 1.2)
    cx = cx + math.cos(a) * sl; cy = cy + math.sin(a) * sl
    pts[#pts+1] = {cx, cy}
  end
  twig_count = twig_count + 1
  if b.fullness and b:fullness() < 0.5 then b:load(pile, 0.9) end
  local g = {}
  for i, p in ipairs(pts) do
    local t = (i-1)/(#pts-1)
    local ww = w * (1 - 0.55 * t)
    g[#g+1] = {p[1], p[2], b:pressure_for(math.max(0.45, ww))}
  end
  b:gesture(g, {wobble=0.15})
  if depth > 0 then
    local nk = (math.random() < 0.55) and 2 or 3
    for k = 1, nk do
      local idx
      if k == 1 then idx = #pts else idx = math.random(math.max(2, #pts // 2), #pts) end
      local p = pts[idx]
      local side = (k % 2 == 0) and 1 or -1
      if math.random() < 0.3 then side = -side end
      sprig2(br, pile, p[1], p[2], a + side * rand(0.3, 0.85), len * rand(0.58, 0.75), w * 0.66, depth - 1, opts)
    end
  end
end
BR = {round=brush{kind="round", width=6, point=0.8}, rigger=brush{kind="rigger", width=2, point=1}}
BR.round:load(tw1, 0.9); BR.rigger:load(tw1, 0.9)
twig_count = 0
local L = limbs.B1.pts
local x, y, a = along(L, 1.0)
sprig2(BR, tw1, x, y, a - 0.2, 60, 3.6, 3)
for _, s in ipairs({{0.4, -0.9, 48, 3.2}, {0.62, -0.6, 42, 3.0}, {0.8, 0.7, 36, 2.6}}) do
  local x, y, a = along(L, s[1])
  sprig2(BR, tw1, x, y, a + s[2], s[3], s[4], 3)
end
print(twig_count, BR.rigger:fullness())
