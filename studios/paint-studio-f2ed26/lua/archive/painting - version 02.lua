-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{size=700, aspect=1.35, linen={15,13}, seed=1822,
  ground={
    {pile={{"red earth",2},{"yellow ochre",2},{"lead white",1}}, um=60, apply="knife", texture=0.4},
    {pile={{"lead white",10},{"yellow ochre",0.7},{"raw umber",0.25}}, um=35, apply="brush"},
  }}
print(W, H)
print(table.concat(tubes(), ", "))

--@ chunk 2
-- saved geometry
ridge_pts = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
mount_pts = {{0,522},{80,512},{160,502},{240,496},{300,494},{350,498},{410,510},{460,520},{500,524},{540,522},{600,514},{660,506},{720,500},{770,499},{830,505},{900,514},{1000,524}}
local h = pencil("HB")
h:sketch(ridge_pts, {pressure=0.25, passes=2})
h:sketch(mount_pts, {pressure=0.2, passes=2})
-- axis and trunk
h:rule({500, 20}, {500, 720}, {pressure=0.12})
h:line({{480,598},{484,560},{486,520},{488,485}}, {pressure=0.3})
h:line({{522,598},{517,560},{514,520},{512,485}}, {pressure=0.3})
-- main boughs
h:line({{492,488},{440,470},{380,455},{330,430},{290,400},{262,385}}, {pressure=0.25})
h:line({{495,478},{470,420},{445,360},{430,300},{410,250},{395,215}}, {pressure=0.25})
h:line({{502,475},{508,410},{500,340},{510,270},{505,200},{512,150}}, {pressure=0.25})
h:line({{508,480},{545,430},{575,370},{600,310},{630,250},{650,210}}, {pressure=0.25})
h:line({{510,490},{570,478},{630,460},{680,430},{720,405},{745,395}}, {pressure=0.25})

--@ chunk 3
s0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}, name="s0_zenith"}
s1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, name="s1_blue"}
s2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, name="s2_paleblue"}
s3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}, name="s3_neutral"}
s4 = pile{{"lead white",6},{"Naples yellow",2.5},{"chrome yellow",0.6}, name="s4_yellow"}
s5 = pile{{"lead white",7},{"Naples yellow",2},{"chrome yellow",1},{"vermilion",0.12}, name="s5_glow"}
s6 = pile{{"lead white",6},{"Naples yellow",2},{"chrome yellow",0.8},{"vermilion",0.35}, name="s6_horizon"}
print(palette())

--@ chunk 4
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function g(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
sky_piles = {
  {s0, g(-10, 75)},
  {s1, g(110, 75)},
  {s2, g(220, 65)},
  {s3, g(310, 55)},
  {s4, g(400, 50)},
  {s5, g(485, 42)},
  {s6, g(550, 30)},
}
sky_mask = rect(0, 0, 1000, 578)
work(sky_mask, {hand="broad", piles=sky_piles, angle=0, coverage=2, clip=true, seed=31})
work(sky_mask, {hand="broad", piles=sky_piles, angle=0, coverage=1.5, fill=true, clip=true, seed=32})
print(drying(500, 100), drying(500, 500))

--@ chunk 5
blend(sky_mask, {angle=0})
print(drying(500, 100), drying(500, 500))

--@ chunk 6
blend(rect(0, 0, 1000, 340):soften(40), {angle=0.03, seed=5})

--@ chunk 7
mi1 = pile{{"lead white",8},{"Naples yellow",1.4},{"pale smalt",0.6},{"rose madder",0.05}, name="mist_top"}
mi2 = pile{{"lead white",7},{"pale smalt",1.2},{"Naples yellow",0.8},{"raw umber",0.15},{"rose madder",0.08}, name="mist_low"}
local function ridge_y(x)
  for i = 1, #ridge_pts - 1 do
    local a, b = ridge_pts[i], ridge_pts[i+1]
    if x >= a[1] and x <= b[1] then return lerp(a[2], b[2], (x - a[1]) / (b[1] - a[1])) end
  end
  return ridge_pts[#ridge_pts][2]
end
ridgeY = ridge_y
mist_mask = below(function(x) return 556 end) * above(function(x) return ridge_y(x) + 10 end)
work(mist_mask, {hand="body", piles={
   {mi1, function(x,y) return 1 - smoothstep(565, 625, y) end},
   {mi2, function(x,y) return smoothstep(565, 625, y) end}}, angle=0, coverage=2.2, fill=true, clip=true, length={40,90}, seed=41})
blend(rect(0, 540, 1000, 40):soften(6), {angle=0, seed=42})
print(drying(500, 570), drying(100, 620))

--@ chunk 8
print(wait(20*60))
for _, p in ipairs({{500,50},{500,300},{500,500},{500,570},{100,620}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 9
print(wait(14*60))
for _, p in ipairs({{500,50},{500,300},{500,500},{500,570},{100,620},{900,630}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 10
print(wait(12*60))
for _, p in ipairs({{500,50},{500,300},{500,500},{500,570},{100,620},{900,630}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 11
print(wait(8*60))
for _, p in ipairs({{500,300},{500,500},{500,530},{500,570},{100,620},{900,630},{300,560}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 12
print(wait(16*60))
for _, p in ipairs({{500,500},{200,520},{800,515},{500,570},{300,560},{100,620},{900,630}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 13
mtA = pile{{"lead white",2},{"smalt",2},{"cobalt blue",0.3},{"rose madder",0.25},{"raw umber",0.45}, name="mount_top"}
mtB = pile{{"lead white",5},{"smalt",1},{"rose madder",0.12},{"Naples yellow",1.0}, name="mount_foot"}
mount_pts = {{-10,524},{40,519},{90,513},{140,507},{185,502},{225,499},{262,496},{300,493},{330,494},{356,497},{385,503},{418,511},{448,517},{475,521},{500,523},{528,522},{560,518},{596,512},{630,507},{668,503},{705,499},{742,497},{775,498},{805,502},{840,507},{880,512},{925,517},{970,521},{1010,524}}
mount_mask = (below(mount_pts):roughen(1.3, 10, 77)) * above(function(x) return 592 end)
work(mount_mask, {hand="body", tool={kind="filbert", width=6}, piles={
   {mtA, function(x,y) return 1 - smoothstep(512, 575, y) end},
   {mtB, function(x,y) return smoothstep(512, 575, y) end}}, angle=0, coverage=2.5, fill=true, clip=true, length={20,50}, seed=51})

--@ chunk 14
local inner = mount_mask:shrink(3)
blend(inner, {angle=0, seed=61})
blend(rect(0, 572, 1000, 30):soften(8), {angle=0, seed=62})
print(drying(500, 540), drying(500, 600))

--@ chunk 15
rgA = pile{{"raw umber",3},{"bone black",0.8},{"green earth",1},{"yellow ochre",0.4},{"smalt",0.3}, name="rgA_crest"}
rgB = pile{{"raw umber",3},{"bone black",1.4},{"green earth",0.6},{"smalt",0.4}, name="rgB_body"}
rgC = pile{{"raw umber",2.5},{"bone black",2},{"smalt",0.6},{"rose madder",0.15}, name="rgC_bottom"}
ridge_mask = below(ridge_pts):roughen(1.0, 10, 19)
local function dcrest(x, y) return y - ridgeY(x) end
work(ridge_mask, {hand="body", tool={kind="filbert", width=10}, piles={
  {rgA, function(x,y) return 1 - smoothstep(10, 45, dcrest(x,y)) end},
  {rgB, function(x,y) return math.exp(-((dcrest(x,y)-55)/30)^2) end},
  {rgC, function(x,y) return smoothstep(60, 120, dcrest(x,y)) end}}, angle=function(x,y) local a=(ridgeY(x+5)-ridgeY(x-5))/10; return math.atan(a) * (1 - smoothstep(0, 80, y - ridgeY(x))) end,
  coverage=2.5, fill=true, clip=true, length={40,110}, seed=71})
blend(ridge_mask:shrink(2), {angle=0, seed=72})

--@ chunk 16
local fixm = (ellipse(478, 603, 30, 8) + ellipse(560, 605, 16, 6) + ellipse(335, 612, 8, 5)) * ridge_mask
work(fixm, {hand="body", tool={kind="filbert", width=5}, pile=rgA, angle=0, coverage=3, fill=true, clip=ridge_mask, length={10,25}, seed=81})

--@ chunk 17
n0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}, medium=0.1, name="n0"}
n1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, medium=0.1, name="n1"}
n2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, medium=0.1, name="n2"}
n3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}, medium=0.1, name="n3"}
n4 = pile{{"lead white",6},{"Naples yellow",2.6},{"chrome yellow",0.3},{"yellow ochre",0.15}, medium=0.1, name="n4_yellow"}
n5 = pile{{"lead white",6.5},{"Naples yellow",2.4},{"chrome yellow",0.5},{"vermilion",0.18}, medium=0.1, name="n5_glow"}
n6 = pile{{"lead white",6},{"Naples yellow",2.2},{"chrome yellow",0.35},{"vermilion",0.45},{"rose madder",0.06}, medium=0.1, name="n6_horizon"}
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function g(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
sky2_piles = {{n0, g(-10, 75)},{n1, g(110, 75)},{n2, g(220, 65)},{n3, g(310, 55)},{n4, g(400, 50)},{n5, g(480, 40)},{n6, g(545, 28)}}
sky2_mask = above(mount_pts) - mount_mask:grow(1.5)
print(sky2_mask:at(500, 515), sky2_mask:at(500, 530), sky2_mask:at(300, 490), sky2_mask:at(300, 500))
work(sky2_mask, {hand="broad", piles=sky2_piles, angle=0, angle_jitter=0.03, curve={0.02, 0}, coverage=2, fill=true, clip=true, seed=91})
blend(sky2_mask, {angle=0, seed=92})
blend(sky2_mask, {angle=0, seed=93})

--@ chunk 18
print(wait(3*24*60))
for _, p in ipairs({{500,50},{500,250},{500,450},{300,500},{500,540},{500,580},{200,620},{500,680}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 19
print(wait(2*24*60))
for _, p in ipairs({{300,500},{500,540},{480,560},{520,575},{500,580},{500,600},{500,680}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 20
function taperw(pts, w0, w1, pw)
  local ws = {}
  local n = #pts
  for i = 1, n do local t = (i-1)/(n-1); ws[i] = w0 + (w1 - w0) * (t ^ (pw or 0.8)) end
  return ws
end
function along(pts, t)
  local L, segs = 0, {}
  for i = 1, #pts-1 do local d = math.sqrt((pts[i+1][1]-pts[i][1])^2 + (pts[i+1][2]-pts[i][2])^2); segs[i] = d; L = L + d end
  local s = t * L
  for i = 1, #pts-1 do
    if s <= segs[i] or i == #pts-1 then
      local f = math.min(1, s / segs[i])
      return lerp(pts[i][1], pts[i+1][1], f), lerp(pts[i][2], pts[i+1][2], f), math.atan(pts[i+1][2]-pts[i][2], pts[i+1][1]-pts[i][1])
    end
    s = s - segs[i]
  end
end
trunk_spine = {{500,612},{499,588},{496,562},{497,538},{501,516}}
trunk_w = {64,52,48,48,50}
limbs = {
  A  = {pts={{484,522},{468,508},{455,490},{446,470},{428,462},{406,458},{388,446},{378,426},{360,414},{338,410},{318,398},{304,380},{296,360}}, w={30,6}},
  A1 = {pts={{446,470},{420,476},{394,482},{370,480},{348,488},{326,486},{304,478},{282,480},{262,472}}, w={14,3}},
  A2 = {pts={{388,446},{394,420},{386,394},{392,368},{384,342},{388,318},{380,296}}, w={12,3}},
  A4 = {pts={{318,398},{296,394},{280,382},{268,370}}, w={7,2.5}},
  C  = {pts={{498,518},{493,490},{488,464},{492,438},{484,412},{481,386},{487,360},{482,334},{484,312}}, w={30,10}},
  C1 = {pts={{484,314},{479,288},{485,262},{479,238},{472,216},{475,198}}, w={10,3}, dead=true},
  C2 = {pts={{482,332},{498,312},{506,294},{516,282}}, w={6,2}, dead=true},
  C3 = {pts={{488,464},{470,444},{460,420},{448,398},{444,370},{432,346},{428,322}}, w={13,3}},
  C4 = {pts={{481,386},{500,372},{512,350},{528,334},{536,312}}, w={9,2.5}},
  B  = {pts={{510,518},{530,506},{546,490},{566,480},{590,474},{606,458},{616,438},{638,428},{662,422},{684,408},{702,398},{716,384}}, w={28,6}},
  B1 = {pts={{566,480},{594,488},{624,488},{650,480},{674,484},{700,478},{722,468},{742,464}}, w={12,3}},
  B2 = {pts={{546,490},{552,460},{566,434},{562,404},{576,378},{580,350},{594,326},{598,302}}, w={13,3}},
  B3 = {pts={{616,438},{622,412},{638,388},{644,364},{660,346}}, w={8,2.5}},
  B4 = {pts={{590,474},{604,486},{611,492}}, w={7,6}, dead=true},
  T1 = {pts={{497,560},{478,552},{470,549}}, w={10,8}, dead=true},
}
tree_order = {"A","A1","A2","A4","C","C1","C2","C3","C4","B","B1","B2","B3","B4","T1"}
local m = ribbon(trunk_spine, trunk_w)
for _, k in ipairs(tree_order) do local L = limbs[k]; m = m + ribbon(L.pts, taperw(L.pts, L.w[1], L.w[2], 0.7)) end
m = m + poly({{430,616},{458,606},{468,592},{532,592},{542,606},{574,615},{548,619},{500,616},{454,619}}, true)
tree_main = m:roughen(1.0, 8, 7)
print(tree_main:at(500, 560), tree_main:at(296, 360), tree_main:at(475, 200), tree_main:at(600, 300), tree_main:at(560, 250))

--@ chunk 21
trD = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}, name="tree_dark"}
trU = pile{{"raw umber",2},{"bone black",1.5},{"smalt",0.8},{"lead white",0.25}, name="tree_upper"}
work(tree_main, {hand="detail", piles={{trD, function(x,y) return smoothstep(300, 520, y) + 0.2 end},{trU, function(x,y) return 1 - smoothstep(300, 520, y) end}},
  coverage=3, fill=true, length={6,16}, angle=function(x,y) return -math.pi/2 end, seed=101})

--@ chunk 22
for _, p in ipairs({{500,630},{470,625},{530,625},{500,600},{460,612},{540,612}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 23
local k = knife{width=14}
for _, y in ipairs({648, 640, 632, 625}) do
  k:scrape({{452, y}, {500, y + 0.5}, {548, y}}, {pressure=1})
  k:wipe()
end
print(drying(500, 630), drying(500, 640))

--@ chunk 24
local r = rag{width=16}
local m = ellipse(500, 636, 38, 13) * mask(function(x,y) return y > 623 and 1 or 0 end)
r:dip(0.9)
r:wipe(m, {pressure=0.75, angle=0, passes=2, refold=0.5})
r:refold(); r:dip(0.9)
r:wipe(m, {pressure=0.85, angle=0.4, passes=1, refold=0.5})
print(r)

--@ chunk 25
tw1 = pile{{"bone black",2},{"raw umber",1.5},{"smalt",0.8}, medium=0.15, name="twig"}
twig_count = 0
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
  if b:fullness() < 0.5 then b:load(pile, 0.9) end
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
-- left bough A and its branches
local function tip(k, da, len, w, d) local x, y, a = along(limbs[k].pts, 1.0); sprig2(BR, tw1, x, y, a + (da or 0), len, w, d or 3) end
local function side(k, t, da, len, w, d) local x, y, a = along(limbs[k].pts, t); sprig2(BR, tw1, x, y, a + da, len, w, d or 3) end
tip("A", 0.1, 58, 3.6)
side("A", 0.72, 0.9, 46, 3.2)
side("A", 0.86, -0.8, 40, 3.0)
side("A", 0.6, -1.0, 36, 2.8, 2)
tip("A1", -0.25, 56, 3.4)
side("A1", 0.45, 0.85, 44, 3.0)
side("A1", 0.65, 1.1, 40, 3.0)
side("A1", 0.82, -0.5, 34, 2.6, 2)
side("A1", 0.3, -0.7, 30, 2.4, 2)
tip("A2", 0.05, 58, 3.6)
side("A2", 0.4, -0.85, 42, 3.0)
side("A2", 0.62, 0.8, 40, 3.0)
side("A2", 0.82, -0.6, 34, 2.6, 2)
tip("A4", -0.1, 44, 3.0)
side("A4", 0.5, 0.9, 30, 2.6, 2)
print(twig_count)

--@ chunk 26
local function tip(k, da, len, w, d) local x, y, a = along(limbs[k].pts, 1.0); sprig2(BR, tw1, x, y, a + (da or 0), len, w, d or 3) end
local function side(k, t, da, len, w, d) local x, y, a = along(limbs[k].pts, t); sprig2(BR, tw1, x, y, a + da, len, w, d or 3) end
-- centre: C3 and C4 living, C1/C2 dead and bare
tip("C3", -0.1, 54, 3.4)
side("C3", 0.45, -0.9, 40, 3.0)
side("C3", 0.7, 0.7, 36, 2.8, 2)
tip("C4", 0.15, 50, 3.2)
side("C4", 0.5, -0.8, 36, 2.8, 2)
side("C4", 0.75, 0.9, 32, 2.6, 2)
side("C", 0.78, 0.9, 34, 2.8, 2)
-- right bough
tip("B", 0.05, 56, 3.6)
side("B", 0.78, -0.95, 44, 3.2)
side("B", 0.9, 0.6, 36, 2.8, 2)
side("B", 0.62, 0.9, 34, 2.8, 2)
tip("B1", 0.2, 54, 3.4)
side("B1", 0.35, -0.9, 46, 3.2)
side("B1", 0.58, -0.7, 42, 3.0)
side("B1", 0.78, 0.8, 32, 2.6, 2)
tip("B2", -0.1, 58, 3.6)
side("B2", 0.42, 0.85, 42, 3.0)
side("B2", 0.6, -0.9, 40, 3.0)
side("B2", 0.8, 0.6, 34, 2.6, 2)
tip("B3", 0.0, 46, 3.2)
side("B3", 0.5, -0.9, 34, 2.8, 2)
print(twig_count)

--@ chunk 27
twig_paths = twig_paths or {}
function sprig3(br, pile, x, y, ang, len, w, depth, opts)
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
  if opts.maxy and cy > opts.maxy then return end
  twig_count = twig_count + 1
  if b:fullness() < 0.5 then b:load(pile, 0.9) end
  local g = {}
  for i, p in ipairs(pts) do
    local t = (i-1)/(#pts-1)
    local ww = w * (1 - 0.55 * t)
    g[#g+1] = {p[1], p[2], b:pressure_for(math.max(0.45, ww))}
  end
  b:gesture(g, {wobble=0.15})
  twig_paths[#twig_paths+1] = {pts=pts, w=w}
  if depth > 0 then
    local nk = (math.random() < 0.55) and 2 or 3
    for k = 1, nk do
      local idx
      if k == 1 then idx = #pts else idx = math.random(math.max(2, #pts // 2), #pts) end
      local p = pts[idx]
      local side = (k % 2 == 0) and 1 or -1
      if math.random() < 0.3 then side = -side end
      sprig3(br, pile, p[1], p[2], a + side * rand(0.3, 0.85), len * rand(0.58, 0.75), w * 0.66, depth - 1, opts)
    end
  end
end
local O = {maxy=490}
local function side(k, t, da, len, w, d) local x, y, a = along(limbs[k].pts, t); sprig3(BR, tw1, x, y, a + da, len, w, d or 3, O) end
-- fill the crown: new shoots at new places along the limbs, mostly rising
side("C", 0.62, -0.8, 40, 3.0)
side("C", 0.9, -0.7, 34, 2.6, 2)
side("C1", 0.3, 0.8, 30, 2.4, 2)
side("C3", 0.25, 0.9, 38, 2.8)
side("C3", 0.85, -0.6, 30, 2.4, 2)
side("A", 0.42, 0.8, 40, 3.0)
side("A", 0.52, -0.6, 30, 2.6, 2)
side("A2", 0.25, 0.8, 38, 2.8)
side("A2", 0.72, -0.9, 32, 2.4, 2)
side("A4", 0.3, -0.8, 26, 2.2, 2)
side("B", 0.5, -0.9, 40, 3.0)
side("B", 0.7, 0.8, 30, 2.6, 2)
side("B2", 0.28, -0.8, 40, 3.0)
side("B2", 0.7, 0.8, 34, 2.6, 2)
side("B3", 0.3, 0.8, 30, 2.6, 2)
side("B3", 0.8, -0.6, 28, 2.4, 2)
side("C4", 0.3, -0.9, 30, 2.4, 2)
print(twig_count, #twig_paths)

--@ chunk 28
print(wait(4*24*60))
for _, p in ipairs({{500,560},{499,520},{480,300},{475,200},{380,330},{600,300},{300,380},{500,630},{470,625},{300,560},{500,540}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 29
print(wait(5*24*60))
for _, p in ipairs({{500,560},{499,520},{480,300},{475,200},{300,380},{500,540},{540,310},{430,330}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 30
print(wait(3*24*60))
for _, p in ipairs({{499,520},{300,380},{350,300},{420,250},{560,250},{620,330},{700,380},{250,400}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 31
gl93 = pile{{"smalt",2},{"cobalt blue",2},{"rose madder",0.5},{"bone black",0.25}, medium=0.93, name="gl93_dusk"}
local fade = function(x, y) return 1 - smoothstep(40, 330, y) end
local m = rect(0, 0, 1000, 430)
work(m, {hand="glaze", pile=gl93, angle=0, load_at=function(x,y) return 0.03 + 0.6 * fade(x,y) end, clip=true, seed=111})
blend(m, {angle=0, seed=112})
blend(m, {angle=0.05, seed=113})

--@ chunk 32
for _, p in ipairs({{500,630},{470,612},{530,612},{450,605},{200,650},{800,650},{500,700}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 33
local function dcrest(x, y) return y - ridgeY(x) end
-- central repaint only, soft sides, to bury the root blob and the rag smear
local fixzone = ridge_mask * mask(function(x, y) return 1 - smoothstep(95, 140, math.abs(x - 500)) end) * mask(function(x,y) return 1 - smoothstep(90, 120, y - ridgeY(x)) end)
work(fixzone, {hand="body", tool={kind="filbert", width=8}, piles={
  {rgA, function(x,y) return 1 - smoothstep(8, 40, dcrest(x,y)) end},
  {rgB, function(x,y) return math.exp(-((dcrest(x,y)-55)/30)^2) end},
  {rgC, function(x,y) return smoothstep(60, 120, dcrest(x,y)) end}},
  angle=function(x,y) return math.atan(ridgeY(x+5)-ridgeY(x-5), 10) end,
  coverage=2.5, fill=true, clip=ridge_mask, length={25,70}, seed=121})
blend(fixzone:shrink(3), {angle=0, seed=122})

--@ chunk 34
local function dcrest(x, y) return y - ridgeY(x) end
work(ridge_mask, {hand="body", tool={kind="filbert", width=9}, piles={
  {rgA, function(x,y) return 1 - smoothstep(8, 40, dcrest(x,y)) end},
  {rgB, function(x,y) return math.exp(-((dcrest(x,y)-55)/30)^2) end},
  {rgC, function(x,y) return smoothstep(60, 120, dcrest(x,y)) end}},
  angle=function(x,y) return math.atan(ridgeY(x+5)-ridgeY(x-5), 10) * (1 - smoothstep(0, 90, dcrest(x,y))) end,
  coverage=2.5, fill=true, clip=true, length={40,110}, seed=131})
blend(ridge_mask:shrink(2), {angle=0, seed=132})

--@ chunk 35
for _, p in ipairs({{100,570},{500,575},{900,600},{300,500},{700,500},{480,300},{500,100}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 36
mz1 = pile{{"lead white",7},{"Naples yellow",1.1},{"pale smalt",0.8},{"rose madder",0.08}, medium=0.05, name="mz1"}
mz2 = pile{{"lead white",5},{"pale smalt",1.2},{"smalt",0.3},{"rose madder",0.2},{"raw umber",0.22},{"Naples yellow",0.45}, medium=0.05, name="mz2"}
mz3 = pile{{"lead white",4},{"smalt",0.7},{"pale smalt",0.8},{"rose madder",0.25},{"raw umber",0.45},{"Naples yellow",0.3}, medium=0.05, name="mz3"}
mist2_mask = below(function(x) return 572 end):soften(6) * above(function(x) return ridgeY(x) + 6 end) - tree_main:grow(2)
work(mist2_mask, {hand="body", piles={
  {mz1, function(x,y) return 1 - smoothstep(570, 596, y) end},
  {mz2, function(x,y) return math.exp(-((y-602)/14)^2) end},
  {mz3, function(x,y) return smoothstep(602, 634, y) end}}, angle=0, coverage=2.4, fill=true, clip=true, length={40,90}, seed=141})
blend(mist2_mask:shrink(2), {angle=0, seed=142})

--@ chunk 37
blend(rect(0, 560, 1000, 26):soften(5) - tree_main:grow(3), {angle=0, seed=151})
blend(rect(0, 562, 1000, 20):soften(4) - tree_main:grow(3), {angle=0.02, seed=152})

--@ chunk 38
print(wait(5*24*60))
for _, p in ipairs({{500,50},{300,200},{700,300},{500,580},{200,600},{500,620},{500,700}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 39
gH = pile{{"smalt",3},{"cobalt blue",1.2},{"rose madder",0.25},{"bone black",0.5}, medium=0.92, name="gH_dusk2"}
local fade = function(x, y) return 1 - smoothstep(0, 420, y) end
local m = rect(0, 0, 1000, 470)
work(m, {hand="glaze", pile=gH, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.6 * fade(x,y)^1.4 end, clip=true, seed=161})
blend(m, {angle=0, seed=162}); blend(m, {angle=0, seed=163})

--@ chunk 40
print(wait(4*24*60))
for _, p in ipairs({{500,50},{300,200},{700,300},{500,620},{500,700},{200,700},{850,680}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 41
gH3 = pile{{"smalt",3},{"cobalt blue",1.2},{"rose madder",0.25},{"bone black",0.55}, medium=0.86, name="gH3_dusk3"}
local fade = function(x, y) return 1 - smoothstep(0, 400, y) end
local m = rect(0, 0, 1000, 470)
work(m, {hand="glaze", pile=gH3, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.7 * fade(x,y)^1.5 end, clip=true, seed=171})
blend(m, {angle=0, seed=172}); blend(m, {angle=0, seed=173})
