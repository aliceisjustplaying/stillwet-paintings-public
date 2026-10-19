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

--@ chunk 42
for _, p in ipairs({{475,200},{380,300},{600,300},{330,450},{700,420}}) do print(p[1], p[2], drying(p[1], p[2])) end
local n = 0
for i, tp in ipairs(twig_paths) do local q = tp.pts[#tp.pts]; if drying(q[1], q[2]) ~= "dry" then n = n + 1 end end
print("twig tips not dry:", n, "of", #twig_paths)

--@ chunk 43
print(wait(7*24*60))
for _, p in ipairs({{475,200},{380,300},{600,300},{330,450},{700,420},{100,50}}) do print(p[1], p[2], drying(p[1], p[2])) end
local n = 0
for i, tp in ipairs(twig_paths) do local q = tp.pts[#tp.pts]; if drying(q[1], q[2]) ~= "dry" then n = n + 1 end end
print("twig tips not dry:", n, "of", #twig_paths)

--@ chunk 44
f0c = pile{{"smalt",5},{"cobalt blue",2},{"lead white",0.6},{"rose madder",0.2},{"bone black",0.6}, medium=0.1, name="f0c_top"}
f1c = pile{{"smalt",3},{"cobalt blue",1.2},{"lead white",1.4},{"bone black",0.25},{"rose madder",0.12}, medium=0.1, name="f1c"}
f2c = pile{{"lead white",4},{"smalt",1.2},{"cobalt blue",0.5},{"bone black",0.07},{"rose madder",0.05}, medium=0.1, name="f2c"}
local function ylo(x) return lerp(120, 210, smoothstep(200, 330, math.abs(x - 500))) end
local function fadev(x, y) return 1 - smoothstep(ylo(x), ylo(x) + 70, y) end
local function g(c, w) return function(x, y) return math.exp(-((y - c) / w)^2) end end
local P = {{f0c, g(-10, 90)},{f1c, g(120, 75)},{f2c, g(220, 50)}}
local prot = tree_main:grow(1)
local zone = mask(function(x, y) return fadev(x, y) end)
local clipm = rect(0, 0, 1000, 300) - prot
print(zone:at(500, 100), zone:at(500, 200), zone:at(100, 230), zone:at(100, 290))
work(zone - prot, {hand="broad", piles=P, angle=0, angle_jitter=0.03, coverage=2.4, fill=true, clip=clipm,
  load_at=function(x,y) return 0.2 + 0.7 * fadev(x, y) end, seed=181})
blend(clipm, {angle=0, seed=182})
blend(clipm, {angle=0, seed=183})

--@ chunk 45
for _, p in ipairs({{420,600},{500,598},{580,602},{300,615},{700,615},{450,585},{550,585},{100,640},{900,640}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 46
print(palette())

--@ chunk 47
rgA = pile{{"raw umber",3},{"bone black",0.8},{"green earth",1},{"yellow ochre",0.4},{"smalt",0.3}, name="rgA_crest"}
rgB = pile{{"raw umber",3},{"bone black",1.4},{"green earth",0.6},{"smalt",0.4}, name="rgB_body"}
local function d(x, y) return y - ridgeY(x) end
crest_band = ridge_mask * mask(function(x,y) return 1 - smoothstep(28, 55, d(x,y)) end)
work(crest_band, {hand="body", tool={kind="filbert", width=7}, piles={
   {rgA, function(x,y) return 1 - smoothstep(6, 40, d(x,y)) end},
   {rgB, function(x,y) return smoothstep(20, 50, d(x,y)) end}},
   angle=function(x,y) return math.atan(ridgeY(x+5)-ridgeY(x-5), 10) end,
   coverage=2.6, fill=true, clip=ridge_mask, length={30,80}, load_at=function(x,y) return 0.3 + 0.6 * (1 - smoothstep(20, 50, d(x,y))) end, seed=191})
blend(crest_band * ridge_mask:shrink(1.5), {angle=0, seed=192})

--@ chunk 48
local function d(x, y) return y - ridgeY(x) end
local tz = ridge_mask:shrink(2) * mask(function(x,y) local v = d(x,y); return smoothstep(15, 30, v) * (1 - smoothstep(55, 75, v)) end)
blend(tz, {angle=0.02, seed=201})
-- roots: buttresses and surface roots, drawn by hand
trD = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}, name="tree_dark2"}
root_mask = poly({{474,548},{469,566},{461,580},{450,590},{436,597},{424,601},{446,603},{470,601},{490,600},{500,598},{512,600},{532,601},{556,603},{578,602},{566,597},{550,590},{537,580},{527,566},{521,548}}, true)
  + ribbon({{430,600},{412,602},{394,605},{378,607}}, {6,4.5,3,1.5})
  + ribbon({{570,601},{588,603},{604,606},{618,609}}, {6,4.5,3,1.5})
  + ribbon({{498,599},{492,604},{486,607}}, {5,3,1.5})
root_mask = root_mask:roughen(1.0, 7, 33)
print(root_mask:at(450, 595), root_mask:at(560, 598), root_mask:at(400, 604), root_mask:at(500, 590))
work(root_mask, {hand="detail", pile=trD, coverage=3, fill=true, length={5,12}, angle=function(x,y) return x < 500 and 2.6 or 0.5 end, seed=202})

--@ chunk 49
local k = knife{width=8}
for y = 551, 594, 5 do
  local yl = math.min(y, ridgeY(440) - 3)
  k:scrape({{469, y}, {440, y}, {412, y}}, {pressure=1})
  k:wipe()
  k:scrape({{525, y}, {555, y}, {590, y}}, {pressure=1})
  k:wipe()
end
print(drying(440, 590), drying(560, 590), drying(500, 570))

--@ chunk 50
local r = rag{width=9}
local function wipe_line(pts, p)
  r:dip(0.9)
  r:wipe(pts, {pressure=p or 0.7})
  r:refold()
end
-- left flank, outer to inner, rows above the crest
for _, y in ipairs({594, 589, 584, 579, 574, 568, 562, 556}) do
  wipe_line({{418, y}, {446, y}, {471, y}}, 0.7)
end
-- right flank
for _, y in ipairs({594, 589, 584, 579, 574, 568, 562, 556}) do
  wipe_line({{582, y}, {552, y}, {525, y}}, 0.7)
end
print(r)

--@ chunk 51
local r = rag{width=6}
for _, y in ipairs({592, 587, 582, 577, 572, 567, 562, 557, 552}) do
  r:dip(0.9); r:wipe({{440, y}, {458, y}, {471, y}}, {pressure=0.6}); r:refold()
  r:dip(0.9); r:wipe({{560, y}, {540, y}, {524, y}}, {pressure=0.6}); r:refold()
end
print(r)

--@ chunk 52
print(wait(3*24*60))
for _, p in ipairs({{465,575},{530,575},{500,570},{450,598},{550,600},{300,615},{700,620},{420,603}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 53
print(wait(4*24*60))
for _, p in ipairs({{465,575},{530,575},{500,570},{450,598},{550,600},{300,615},{700,620},{420,603}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 54
print(wait(4*24*60))
for _, p in ipairs({{500,570},{450,598},{550,600},{420,603},{490,590}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 55
trunk_only = ribbon(trunk_spine, trunk_w):roughen(1.0, 8, 7)
local strip = (rect(426, 544, 148, 58) * mask(function(x,y) return y < ridgeY(x) - 0.5 and 1 or 0 end)) - trunk_only
local soft = mask(function(x,y) return 1 - smoothstep(16, 30, math.abs(x - 499) - 25) end)
base_strip = strip * soft
print(base_strip:at(460, 570), base_strip:at(440, 570), base_strip:at(420, 570), base_strip:at(500, 570), base_strip:at(540, 590))
work(base_strip, {hand="body", tool={kind="filbert", width=5}, piles={
  {mz1, function(x,y) return 1 - smoothstep(568, 594, y) end},
  {mz2, function(x,y) return smoothstep(575, 600, y) end}}, angle=0, coverage=2.4, fill=true, clip=strip, length={12,30}, seed=211})
blend(strip * mask(function(x,y) return 1 - smoothstep(26, 34, math.abs(x - 499) - 25) end), {angle=0, seed=212})

--@ chunk 56
local r = rag{width=12}
for _, y in ipairs({551, 559, 567, 575, 583, 591}) do
  r:dip(0.9); r:wipe({{428, y}, {450, y}, {472, y}}, {pressure=0.75}); r:refold()
  r:dip(0.9); r:wipe({{572, y}, {548, y}, {526, y}}, {pressure=0.75}); r:refold()
end
print(r)

--@ chunk 57
local top_soft = mask(function(x, y) return smoothstep(536, 560, y) end)
mist_band = (-ridge_mask) * top_soft - trunk_only
print(mist_band:at(300, 530), mist_band:at(300, 550), mist_band:at(300, 580), mist_band:at(300, 612), mist_band:at(300, 620), mist_band:at(500, 570), mist_band:at(460, 590))
work(mist_band, {hand="body", tool={kind="filbert", width=7}, piles={
  {mz1, function(x,y) return 1 - smoothstep(570, 598, y) end},
  {mz2, function(x,y) return math.exp(-((y-604)/14)^2) end},
  {mz3, function(x,y) return smoothstep(604, 636, y) end}}, angle=0, coverage=2.4, fill=true, clip=mist_band, length={40,100}, seed=221})
blend(mist_band * (-trunk_only:grow(1.5)), {angle=0, seed=222})

--@ chunk 58
local function d(x, y) return ridgeY(x) - y end  -- distance above the crest
work(mist_band, {hand="body", tool={kind="filbert", width=7}, piles={
  {mz2, function(x,y) return 1 end},
  {mz3, function(x,y) return 1 - smoothstep(8, 30, d(x,y)) end}}, angle=0, coverage=1.6, fill=false, clip=mist_band, length={40,100},
  load_at=function(x,y) return 0.25 + 0.5 * smoothstep(565, 600, y) end, seed=231})
blend(mist_band * (-trunk_only:grow(1.5)), {angle=0, seed=232})
blend(rect(0, 526, 1000, 42):soften(8) - trunk_only:grow(1.5) - tree_main:grow(1.5), {angle=0, seed=233})

--@ chunk 59
for _, p in ipairs({{100,650},{300,620},{500,610},{700,630},{900,660},{500,700},{450,600},{560,600}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 60
gG = pile{{"raw umber",2},{"bone black",1.2},{"smalt",0.5},{"green earth",0.4}, medium=0.85, name="ground_glaze"}
local function d(x,y) return y - ridgeY(x) end
local gm = ridge_mask - trunk_only
work(gm, {hand="glaze", pile=gG, angle=0, load_at=function(x,y) return 0.07 + 0.7 * smoothstep(3, 100, d(x,y)) end, clip=ridge_mask, seed=241})
blend(ridge_mask:shrink(1), {angle=0, seed=242})

--@ chunk 61
local function by(x) return ridgeY(x) + 3 end
flare_mask = poly({{477,552},{475,568},{470,581},{461,591},{449,597},{436,by(436)-1.5},{436,by(436)},{470,by(470)},{500,by(500)},{530,by(530)},{566,by(566)},{566,by(566)-1.5},{552,596},{540,590},{531,580},{526,567},{524,552}}, true)
  + ribbon({{440,by(440)-2},{424,by(424)-1.5},{406,by(406)-1},{392,by(392)-0.5}}, {5,3.5,2.2,1})
  + ribbon({{560,by(560)-2},{578,by(578)-1.5},{596,by(596)-1},{612,by(612)-0.5}}, {5,3.5,2.2,1})
flare_mask = flare_mask:roughen(0.8, 6, 41)
local edges = (trunk_only:grow(2.5) - trunk_only:shrink(3)) * rect(440, 500, 120, 110)
local m = flare_mask + edges + ellipse(510, 521, 4, 4)
print(m:at(450, 597), m:at(500, 590), m:at(400, by(400)-1), m:at(471, 570), m:at(500, 560))
work(m, {hand="detail", pile=trD, coverage=3, fill=true, length={4,10}, angle=function(x,y) return -math.pi/2 end, seed=251})

--@ chunk 62
print(palette())
for _, p in ipairs({{460,590},{535,590},{470,570},{500,570}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 63
print(wait(5*24*60))
for _, p in ipairs({{460,590},{535,590},{470,570},{500,570},{300,580},{700,590},{510,521}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 64
print(wait(5*24*60))
for _, p in ipairs({{460,590},{535,590},{470,570},{500,570},{510,521},{475,560},{525,560}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 65
local m = (trunk_only + flare_mask):roughen(0.6, 5, 43)
trunk_full = m
work(m, {hand="detail", pile=trD, coverage=3.5, fill=true, length={5,14}, angle=function(x,y) return -math.pi/2 + 0.04 * (x - 500) / 30 end, seed=261})

--@ chunk 66
local k = knife{width=7}
-- below the crest: take the new trunk paint off down to the dry ridge
for y = 648, 600, -5 do
  local pts = {}
  for x = 455, 545, 15 do
    local yy = math.max(y, ridgeY(x) + 5)
    pts[#pts+1] = {x, yy}
  end
  k:scrape(pts, {pressure=1}); k:wipe()
end
-- the dome where the new paint ran up over the old trunk top
for y = 486, 526, 5 do
  k:scrape({{466, y}, {500, y}, {534, y}}, {pressure=1}); k:wipe()
end
print(drying(500, 620), drying(500, 505), drying(500, 560))

--@ chunk 67
local r = rag{width=8}
for y = 602, 650, 6 do
  local pts = {}
  for x = 452, 548, 12 do pts[#pts+1] = {x, math.max(y, ridgeY(x) + 6)} end
  r:dip(0.9); r:wipe(pts, {pressure=0.75}); r:refold()
  r:dip(0.9); r:wipe(pts, {pressure=0.75}); r:refold()
end
print(r, drying(500, 620))

--@ chunk 68
print(wait(10*24*60))
for _, p in ipairs({{500,610},{500,505},{500,560},{470,600},{530,600}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 69
pA = mix{{rgA, 0.75}, {rgB, 0.25}, name="crest_patch"}
local function d(x, y) return y - ridgeY(x) end
base_patch = ridge_mask * mask(function(x, y)
  local dx = math.abs(x - 500)
  return (1 - smoothstep(45, 75, dx)) * (1 - smoothstep(26, 40, d(x, y)))
end)
print(base_patch:at(500, 605), base_patch:at(500, 625), base_patch:at(560, 605), base_patch:at(590, 610))
work(base_patch, {hand="body", tool={kind="filbert", width=5}, piles={{pA, function(x,y) return 1 end},{rgB, function(x,y) return smoothstep(10, 35, d(x,y)) end}},
  angle=function(x,y) return math.atan(ridgeY(x+5)-ridgeY(x-5), 10) end, coverage=2.5, fill=true, clip=ridge_mask, length={15,40}, seed=271})
blend(base_patch:shrink(1), {angle=0, seed=272})

--@ chunk 70
print(wait(10*24*60))
for _, p in ipairs({{500,605},{480,610},{530,610},{500,620}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 71
local function d(x, y) return y - ridgeY(x) end
local gzone = ridge_mask * mask(function(x, y)
  local dx = math.abs(x - 500)
  return (1 - smoothstep(50, 85, dx)) * (1 - smoothstep(30, 48, d(x, y)))
end)
work(gzone, {hand="glaze", tool={kind="filbert", width=12, stiffness=0.2}, pile=gG, angle=0, length={30,60}, coverage=2, load_at=function(x,y) return 0.35 * gzone:at(x, y) end, clip=ridge_mask, seed=281})
blend(gzone, {angle=0, seed=282})

--@ chunk 72
local edge = (trunk_full:grow(2) - trunk_full:shrink(3)) * rect(455, 515, 90, 65)
local notch = poly({{521,544},{528,543},{529,560},{522,560}})
work(edge + notch, {hand="detail", pile=trD, coverage=3, fill=true, length={4,10}, angle=-math.pi/2, seed=291})

--@ chunk 73
tw2 = pile{{"bone black",2},{"raw umber",1.5},{"smalt",0.8}, medium=0.3, name="twig2"}
fine_paths = {}
function sprig5(b, pile, x, y, ang, len, w, depth, opts)
  opts = opts or {}
  local jit = opts.jit or 0.25
  local up = opts.up or 0.12
  local pts = {{x - math.cos(ang) * 1.5, y - math.sin(ang) * 1.5}, {x, y}}
  local segs = math.max(2, math.floor(len / 8 + 0.5))
  local a, cx, cy = ang, x, y
  for i = 1, segs do
    local elbow = (math.random() < 0.2) and randn(0, 0.4) or 0
    a = a + randn(0, jit) + elbow + up * math.sin(-math.pi/2 - a)
    local sl = len / segs * rand(0.8, 1.2)
    cx = cx + math.cos(a) * sl; cy = cy + math.sin(a) * sl
    pts[#pts+1] = {cx, cy}
  end
  if opts.maxy and cy > opts.maxy then return end
  if b:fullness() < (opts.refill or 0.7) then b:load(pile, 1.0) end
  local g = {}
  for i, p in ipairs(pts) do local t = math.max(0, (i-2)/(#pts-2)); g[#g+1] = {p[1], p[2], b:pressure_for(math.max(opts.wmin or 0.5, w * (1 - 0.5 * t)))} end
  b:gesture(g, {wobble=0.1, ramps={0.0, 0.08}})
  fine_paths[#fine_paths+1] = pts
  if depth > 0 then
    local nk = (math.random() < 0.5) and 2 or 3
    for k = 1, nk do
      local idx = (k == 1) and #pts or math.random(math.max(3, #pts // 2), #pts)
      local p = pts[idx]
      local side = (k % 2 == 0) and 1 or -1
      if math.random() < 0.3 then side = -side end
      sprig5(b, pile, p[1], p[2], a + side * rand(0.3, 0.8), len * rand(0.6, 0.78), w * 0.72, depth - 1, opts)
    end
  end
end
FR = brush{kind="rigger", width=1.6, point=1}
FR:load(tw2, 1.0)
local O = {refill=0.7, wmin=0.5, maxy=505}
local function fine(k, t, da, len, w, d) local x, y, a = along(limbs[k].pts, t); sprig5(FR, tw2, x, y, a + da, len, w, d or 3, O) end
local plan = {
  A  = {{0.62, 0.9, 24, 1.5}, {0.75, -0.8, 24, 1.5}, {0.88, 0.7, 22, 1.4}, {1.0, 0.2, 28, 1.6}},
  A1 = {{0.55, 0.9, 22, 1.4}, {0.7, -0.6, 22, 1.4}, {0.85, 1.0, 22, 1.4}, {1.0, -0.2, 28, 1.6}},
  A2 = {{0.5, -0.9, 24, 1.5}, {0.66, 0.8, 24, 1.5}, {0.82, -0.6, 22, 1.4}, {0.94, 0.5, 22, 1.4}, {1.0, 0.1, 28, 1.6}},
  A4 = {{0.6, 0.8, 20, 1.4}, {1.0, -0.2, 24, 1.5}},
}
for _, k in ipairs({"A","A1","A2","A4"}) do for _, s in ipairs(plan[k]) do fine(k, s[1], s[2], s[3], s[4]) end end
print(#fine_paths)

--@ chunk 74
local O = {refill=0.7, wmin=0.5, maxy=505}
local function fine(k, t, da, len, w, d) local x, y, a = along(limbs[k].pts, t); sprig5(FR, tw2, x, y, a + da, len, w, d or 3, O) end
local plan = {
  C3 = {{0.55, 0.9, 24, 1.5}, {0.72, -0.8, 22, 1.4}, {0.88, 0.6, 22, 1.4}, {1.0, -0.1, 28, 1.6}},
  C4 = {{0.6, -0.8, 22, 1.4}, {0.82, 0.8, 22, 1.4}, {1.0, 0.15, 26, 1.5}},
  C  = {{0.7, 0.9, 20, 1.4}, {0.85, -0.9, 20, 1.4}},
  B  = {{0.6, -0.9, 22, 1.4}, {0.74, 0.8, 22, 1.4}, {0.87, -0.7, 24, 1.5}, {1.0, 0.1, 28, 1.6}},
  B1 = {{0.5, -0.9, 22, 1.4}, {0.66, 0.9, 20, 1.4}, {0.82, -0.6, 22, 1.4}, {1.0, -0.2, 26, 1.5}},
  B2 = {{0.55, 0.9, 26, 1.5}, {0.7, -0.8, 24, 1.5}, {0.85, 0.6, 22, 1.4}, {0.95, -0.4, 26, 1.5}, {1.0, 0.2, 30, 1.6}},
  B3 = {{0.5, 0.8, 22, 1.4}, {0.75, -0.7, 22, 1.4}, {1.0, -0.1, 28, 1.6}},
}
for _, k in ipairs({"C3","C4","C","B","B1","B2","B3"}) do for _, s in ipairs(plan[k]) do fine(k, s[1], s[2], s[3], s[4]) end end
print(#fine_paths)

--@ chunk 75
xfix = pile{{"lead white",6},{"smalt",1.1},{"cobalt blue",0.45},{"bone black",0.05},{"rose madder",0.06}, medium=0.1, name="xfix"}
for _, p in ipairs({{520,195},{500,200},{540,190}}) do print(drying(p[1], p[2])) end

--@ chunk 76
xfix:add{{"smalt",0.5},{"cobalt blue",0.2}}
print(xfix)

--@ chunk 77
gW1 = pile{{"rose madder",1},{"vermilion",0.15},{"chrome yellow",0.4}, medium=0.93, name="gW1_afterglow"}
local function w(x, y) return smoothstep(410, 505, y) * (1 - 0.6 * smoothstep(80, 450, math.abs(x - 500))) end
local skyband = sky2_mask * rect(0, 330, 1000, 200)
local zone = skyband * mask(function(x,y) return smoothstep(380, 440, y) end)
print(zone:at(500, 500), zone:at(500, 530), zone:at(300, 495), zone:at(300, 480))
work(zone, {hand="glaze", pile=gW1, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.01 + 0.12 * w(x,y) end, clip=skyband, seed=301})
blend(skyband, {angle=0, seed=302})

--@ chunk 78
for _, p in ipairs({{300,420},{560,250},{700,200},{500,500},{250,460}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 79
local r = rag{width=34}
local area = rect(180, 150, 840, 385) * above(function(x) return 532 end)
for y0 = 150, 500, 45 do
  local strip = area * rect(170, y0, 860, 50)
  r:dip(0.9)
  r:wipe(strip, {pressure=0.6, angle=0, passes=1, refold=0.35})
  r:refold()
end
print(r)
for _, p in ipairs({{300,420},{500,500},{250,460},{430,300},{650,350}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 80
local area = rect(180, 150, 840, 385) * above(function(x) return 532 end)
for round = 1, 2 do
  local r = rag{width=30}
  for y0 = 150 + round * 20, 520, 40 do
    local strip = area * rect(170, y0, 860, 46)
    r:dip(0.95)
    r:wipe(strip, {pressure=0.75, angle=(round == 1) and 0.25 or -0.2, passes=1, refold=0.25})
    r:refold()
  end
end
for _, p in ipairs({{300,420},{500,500},{250,460},{650,350},{260,360}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 81
local area = rect(0, 320, 200, 215) * above(function(x) return 532 end)
for round = 1, 3 do
  local r = rag{width=30}
  for y0 = 320 + round * 10, 520, 40 do
    local strip = area * rect(0, y0, 210, 46)
    r:dip(0.95)
    r:wipe(strip, {pressure=0.75, angle=(round == 2) and 0.25 or -0.15, passes=1, refold=0.25})
    r:refold()
  end
end
print(drying(100, 450))

--@ chunk 82
print(wait(6*24*60))
for _, p in ipairs({{300,420},{500,500},{250,460},{650,350},{100,450},{500,260}}) do print(p[1], p[2], drying(p[1], p[2])) end
