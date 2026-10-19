-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
s0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}}
s1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}}
s2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}}
s3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}}
s4 = pile{{"lead white",6},{"Naples yellow",2.5},{"chrome yellow",0.6}}
s5 = pile{{"lead white",7},{"Naples yellow",2},{"chrome yellow",1},{"vermilion",0.12}}
s6 = pile{{"lead white",6},{"Naples yellow",2},{"chrome yellow",0.8},{"vermilion",0.35}}
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function g(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
local P = {{s0, g(-10, 75)},{s1, g(110, 75)},{s2, g(220, 65)},{s3, g(310, 55)},{s4, g(400, 50)},{s5, g(485, 42)},{s6, g(550, 30)}}
local m = rect(0, 0, 1000, 578)
work(m, {hand="broad", piles=P, angle=0, coverage=2, clip=true, seed=31})
work(m, {hand="broad", piles=P, angle=0, coverage=1.5, fill=true, clip=true, seed=32})
blend(m, {angle=0})
blend(rect(0, 0, 1000, 340):soften(40), {angle=0.03, seed=5})
wait(3*24*60)
n0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}, medium=0.1}
n1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, medium=0.1}
n2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, medium=0.1}
n3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}, medium=0.1}
n4 = pile{{"lead white",6},{"Naples yellow",2.6},{"chrome yellow",0.3},{"yellow ochre",0.15}, medium=0.1}
n5 = pile{{"lead white",6.5},{"Naples yellow",2.4},{"chrome yellow",0.5},{"vermilion",0.18}, medium=0.1}
n6 = pile{{"lead white",6},{"Naples yellow",2.2},{"chrome yellow",0.35},{"vermilion",0.45},{"rose madder",0.06}, medium=0.1}
local P2 = {{n0, g(-10, 75)},{n1, g(110, 75)},{n2, g(220, 65)},{n3, g(310, 55)},{n4, g(400, 50)},{n5, g(480, 40)},{n6, g(545, 28)}}
work(m, {hand="broad", piles=P2, angle=0, angle_jitter=0.03, curve={0.02, 0}, coverage=2, fill=true, clip=true, seed=91})
blend(m, {angle=0, seed=92})
blend(m, {angle=0, seed=93})
wait(17*24*60)
local fade = function(x, y) return 1 - smoothstep(40, 330, y) end
local mm = rect(0, 0, 1000, 430)
gl93 = pile{{"smalt",2},{"cobalt blue",2},{"rose madder",0.5},{"bone black",0.25}, medium=0.93}
work(mm, {hand="glaze", pile=gl93, angle=0, load_at=function(x,y) return 0.03 + 0.6 * fade(x,y) end, clip=true, seed=111})
blend(mm, {angle=0, seed=112}); blend(mm, {angle=0.05, seed=113})
wait(5*24*60)
gH = pile{{"smalt",3},{"cobalt blue",1.2},{"rose madder",0.25},{"bone black",0.5}, medium=0.92}
local fade2 = function(x, y) return 1 - smoothstep(0, 420, y) end
local m2 = rect(0, 0, 1000, 470)
work(m2, {hand="glaze", pile=gH, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.6 * fade2(x,y)^1.4 end, clip=true, seed=161})
blend(m2, {angle=0, seed=162}); blend(m2, {angle=0, seed=163})
wait(4*24*60)
gH3 = pile{{"smalt",3},{"cobalt blue",1.2},{"rose madder",0.25},{"bone black",0.55}, medium=0.86}
local fade3 = function(x, y) return 1 - smoothstep(0, 400, y) end
work(m2, {hand="glaze", pile=gH3, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.7 * fade3(x,y)^1.5 end, clip=true, seed=171})
blend(m2, {angle=0, seed=172}); blend(m2, {angle=0, seed=173})
wait(6*24*60)
-- tests: L = many thin strokes of a neutralised glaze; R = same pile, scumble-thin body (thinner) of dusk grey-blue
gN = pile{{"Prussian blue",0.6},{"smalt",1},{"bone black",0.7},{"raw umber",0.5}, medium=0.93, name="gN"}
local fadeN = function(x, y) return 1 - smoothstep(0, 330, y) end
local L = rect(0, 0, 495, 470)
work(L, {hand="glaze", pile=gN, angle=0, ruler=true, length={350,600}, coverage=7, load_at=function(x,y) return 0.01 + 0.3 * fadeN(x,y)^1.5 end, clip=true, seed=1})
blend(L, {angle=0, seed=2}); blend(L, {angle=0, seed=3}); blend(L, {angle=0.02, seed=4})
print(drying(500,50))

--@ chunk 3
wait(5*24*60)
-- build the tree in the scratch as on the painting (limbs, mask, twigs)
function taperw(pts, w0, w1, pw) local ws = {}; local n = #pts; for i = 1, n do local t = (i-1)/(n-1); ws[i] = w0 + (w1 - w0) * (t ^ (pw or 0.8)) end; return ws end
function along(pts, t)
  local L, segs = 0, {}
  for i = 1, #pts-1 do local d = math.sqrt((pts[i+1][1]-pts[i][1])^2 + (pts[i+1][2]-pts[i][2])^2); segs[i] = d; L = L + d end
  local s = t * L
  for i = 1, #pts-1 do
    if s <= segs[i] or i == #pts-1 then local f = math.min(1, s / segs[i]); return lerp(pts[i][1], pts[i+1][1], f), lerp(pts[i][2], pts[i+1][2], f), math.atan(pts[i+1][2]-pts[i][2], pts[i+1][1]-pts[i][1]) end
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
tree_main = m:roughen(1.0, 8, 7)
local trD = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}}
work(tree_main, {hand="detail", pile=trD, coverage=3, fill=true, length={6,16}, angle=-math.pi/2})
tw1 = pile{{"bone black",2},{"raw umber",1.5},{"smalt",0.8}, medium=0.15}
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
  for i, p in ipairs(pts) do local t = (i-1)/(#pts-1); g[#g+1] = {p[1], p[2], b:pressure_for(math.max(0.45, w * (1 - 0.55 * t)))} end
  b:gesture(g, {wobble=0.15})
  if depth > 0 then
    local nk = (math.random() < 0.55) and 2 or 3
    for k = 1, nk do
      local idx = (k == 1) and #pts or math.random(math.max(2, #pts // 2), #pts)
      local p = pts[idx]
      local side = (k % 2 == 0) and 1 or -1
      if math.random() < 0.3 then side = -side end
      sprig2(br, pile, p[1], p[2], a + side * rand(0.3, 0.85), len * rand(0.58, 0.75), w * 0.66, depth - 1, opts)
    end
  end
end
BR = {round=brush{kind="round", width=6, point=0.8}, rigger=brush{kind="rigger", width=2, point=1}}
BR.round:load(tw1, 0.9); BR.rigger:load(tw1, 0.9)
local function tip(k, da, len, w, d) local x, y, a = along(limbs[k].pts, 1.0); sprig2(BR, tw1, x, y, a + (da or 0), len, w, d or 3) end
local function side(k, t, da, len, w, d) local x, y, a = along(limbs[k].pts, t); sprig2(BR, tw1, x, y, a + da, len, w, d or 3) end
tip("A2", 0.05, 58, 3.6); side("A2", 0.4, -0.85, 42, 3.0); side("A2", 0.62, 0.8, 40, 3.0)
tip("C3", -0.1, 54, 3.4); side("C3", 0.45, -0.9, 40, 3.0)
tip("C4", 0.15, 50, 3.2); tip("B2", -0.1, 58, 3.6); side("B2", 0.6, -0.9, 40, 3.0); tip("B3", 0.0, 46, 3.2)
wait(12*24*60)
print(twig_count, drying(500,300))

--@ chunk 4
f0 = pile{{"smalt",5},{"cobalt blue",2},{"lead white",0.7},{"rose madder",0.12},{"bone black",0.4}, medium=0.1, name="f0"}
f1 = pile{{"smalt",3},{"cobalt blue",1.2},{"lead white",1.5},{"bone black",0.18},{"rose madder",0.06}, medium=0.1, name="f1"}
f2 = pile{{"lead white",4},{"smalt",1.2},{"cobalt blue",0.5},{"bone black",0.07}, medium=0.1, name="f2"}
f3 = pile{{"lead white",7},{"smalt",0.7},{"pale smalt",0.5},{"cobalt blue",0.2},{"Naples yellow",0.5}, medium=0.1, name="f3"}
local function g(c, w) return function(x, y) return math.exp(-((y - c) / w)^2) end end
local P = {{f0, g(-10, 90)},{f1, g(120, 75)},{f2, g(220, 50)},{f3, g(290, 35)}}
local region = rect(0, 0, 1000, 340) * mask(function(x,y) return 1 - smoothstep(250, 330, y) end)
local clipm = rect(0, 0, 1000, 360) - tree_main
work(region - tree_main, {hand="broad", piles=P, angle=0, angle_jitter=0.03, coverage=2.4, fill=true, clip=clipm, load_at=function(x,y) return 0.2 + 0.7 * (1 - smoothstep(200, 320, y)) end, seed=4})
blend(rect(0, 0, 1000, 350) - tree_main:grow(1), {angle=0, seed=5})
blend(rect(0, 0, 1000, 350) - tree_main:grow(1), {angle=0, seed=6})

--@ chunk 5
wait(6*24*60)
print(drying(500,100), drying(300,250))
local function tip(k, da, len, w, d) local x, y, a = along(limbs[k].pts, 1.0); sprig2(BR, tw1, x, y, a + (da or 0), len, w, d or 3) end
local function side(k, t, da, len, w, d) local x, y, a = along(limbs[k].pts, t); sprig2(BR, tw1, x, y, a + da, len, w, d or 3) end
BR.round:load(tw1, 0.9); BR.rigger:load(tw1, 0.9)
tip("A2", 0.15, 56, 3.4); side("A2", 0.5, 0.85, 40, 3.0); side("A2", 0.8, -0.7, 34, 2.6, 2)
tip("C3", 0.05, 52, 3.4); side("C3", 0.6, 0.8, 36, 2.8)
tip("C4", -0.1, 48, 3.2); tip("B2", 0.1, 56, 3.4); side("B2", 0.75, 0.8, 36, 2.8); tip("B3", 0.15, 44, 3.0)
tip("C2", 0.0, 30, 2.4, 2)

--@ chunk 6
local function g(c, w) return function(x, y) return math.exp(-((y - c) / w)^2) end end
local P = {{f0, g(-10, 90)},{f1, g(120, 75)},{f2, g(220, 50)},{f3, g(290, 35)}}
local half = rect(520, 0, 480, 360)
local region = half * mask(function(x,y) return 1 - smoothstep(250, 330, y) end)
work(region - tree_main, {hand="broad", piles=P, angle=0, angle_jitter=0.03, coverage=2.4, fill=true, clip=half - tree_main, load_at=function(x,y) return 0.2 + 0.7 * (1 - smoothstep(200, 320, y)) end, seed=14})
blend(half - tree_main:grow(1), {angle=0, seed=15})
blend(half - tree_main:grow(1), {angle=0, seed=16})

--@ chunk 7
wait(6*24*60)
f0b = pile{{"smalt",5},{"cobalt blue",2},{"lead white",0.6},{"rose madder",0.15},{"bone black",0.6}, medium=0.1, name="f0b"}
f1b = pile{{"smalt",3},{"cobalt blue",1.2},{"lead white",1.4},{"bone black",0.25},{"rose madder",0.08}, medium=0.1, name="f1b"}
local function g(c, w) return function(x, y) return math.exp(-((y - c) / w)^2) end end
local P = {{f0b, g(-10, 90)},{f1b, g(120, 75)},{f2, g(220, 50)}}
local area = rect(0, 0, 260, 250)
work(area * mask(function(x,y) return 1 - smoothstep(150, 230, y) end), {hand="broad", piles=P, angle=0, angle_jitter=0.03, coverage=2.4, fill=true, clip=area, load_at=function(x,y) return 0.2 + 0.7 * (1 - smoothstep(130, 220, y)) end, seed=24})
blend(area, {angle=0, seed=25}); blend(area, {angle=0, seed=26})

--@ chunk 8
wait(5*24*60)
function sprig4(b, pile, x, y, ang, len, w, depth, opts)
  opts = opts or {}
  local jit = opts.jit or 0.2
  local up = opts.up or 0.1
  local pts = {{x, y}}
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
  for i, p in ipairs(pts) do local t = (i-1)/(#pts-1); g[#g+1] = {p[1], p[2], b:pressure_for(math.max(opts.wmin or 0.5, w * (1 - 0.5 * t)))} end
  b:gesture(g, {wobble=0.1})
  if depth > 0 then
    local nk = (math.random() < 0.5) and 2 or 3
    for k = 1, nk do
      local idx = (k == 1) and #pts or math.random(math.max(2, #pts // 2), #pts)
      local p = pts[idx]
      local side = (k % 2 == 0) and 1 or -1
      if math.random() < 0.3 then side = -side end
      sprig4(b, pile, p[1], p[2], a + side * rand(0.3, 0.8), len * rand(0.6, 0.78), w * 0.72, depth - 1, opts)
    end
  end
end
tw2 = pile{{"bone black",2},{"raw umber",1.5},{"smalt",0.8}, medium=0.3, name="twig2"}
local r = brush{kind="rigger", width=1.6, point=1}
r:load(tw2, 1.0)
-- test row: left, refill .7 / wmin .5 ; right, refill .9 / wmin .7
for i = 1, 4 do sprig4(r, tw2, 120 + i * 40, 420, -1.4, 40, 1.6, 3, {refill=0.7, wmin=0.5}) end
for i = 1, 4 do sprig4(r, tw2, 720 + i * 40, 420, -1.4, 40, 1.6, 3, {refill=0.9, wmin=0.7}) end

--@ chunk 9
local old = sprig4
function sprig5(b, pile, x, y, ang, len, w, depth, opts)
  opts = opts or {}
  local jit = opts.jit or 0.2
  local up = opts.up or 0.1
  -- start 1.5 units back along the incoming direction so the shoot grows out of its parent
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
local r = brush{kind="rigger", width=1.6, point=1}
r:load(tw2, 1.0)
for i = 1, 4 do sprig5(r, tw2, 120 + i * 40, 520, -1.4, 40, 1.6, 3, {refill=0.7, wmin=0.5}) end
for i = 1, 4 do sprig5(r, tw2, 720 + i * 40, 520, -1.4, 40, 1.6, 3, {refill=0.7, wmin=0.6}) end

--@ chunk 10
rgA = pile{{"raw umber",3},{"bone black",0.8},{"green earth",1},{"yellow ochre",0.4},{"smalt",0.3}}
rgB = pile{{"raw umber",3},{"bone black",1.4},{"green earth",0.6},{"smalt",0.4}}
rgC = pile{{"raw umber",2.5},{"bone black",2},{"smalt",0.6},{"rose madder",0.15}}
rpts = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
function ryS(x) for i=1,#rpts-1 do local a,b=rpts[i],rpts[i+1]; if x>=a[1] and x<=b[1] then return lerp(a[2],b[2],(x-a[1])/(b[1]-a[1])) end end return 646 end
local mi = pile{{"lead white",7},{"Naples yellow",1.1},{"pale smalt",0.8},{"rose madder",0.08}}
work(rect(0,578,1000,80) - below(rpts), {hand="body", pile=mi, coverage=2, fill=true, clip=true})
rmS = below(rpts):roughen(1.0, 10, 19)
local function d(x,y) return y - ryS(x) end
work(rmS, {hand="body", tool={kind="filbert", width=9}, piles={
  {rgA, function(x,y) return 1 - smoothstep(8, 40, d(x,y)) end},
  {rgB, function(x,y) return math.exp(-((d(x,y)-55)/30)^2) end},
  {rgC, function(x,y) return smoothstep(60, 120, d(x,y)) end}}, angle=0, coverage=2.5, fill=true, clip=true, length={40,110}})
blend(rmS:shrink(2), {angle=0})
wait(14*24*60)
print(drying(500,650), drying(200, 700))

--@ chunk 11
gG = pile{{"raw umber",2},{"bone black",1.2},{"smalt",0.5},{"green earth",0.4}, medium=0.85, name="ground_glaze"}
local function d(x,y) return y - ryS(x) end
local L = rmS * rect(0, 0, 500, 741)
work(L, {hand="glaze", pile=gG, angle=0, load_at=function(x,y) return 0.05 + 0.6 * smoothstep(5, 110, d(x,y)) end, clip=rmS, seed=1})
blend(L:shrink(1), {angle=0, seed=2})
local R = rmS * rect(500, 0, 500, 741)
work(R, {hand="glaze", pile=gG, angle=0, load_at=function(x,y) return 0.1 + 0.8 * smoothstep(0, 90, d(x,y)) end, clip=rmS, seed=3})
blend(R:shrink(1), {angle=0, seed=4})

--@ chunk 12
tw2 = pile{{"bone black",2},{"raw umber",1.5},{"smalt",0.8}, medium=0.3, name="twig2"}
local r = brush{kind="rigger", width=1.6, point=1}
r:load(tw2, 1.0)
local function fine(k, t, da, len, w, d) local x, y, a = along(limbs[k].pts, t); sprig5(r, tw2, x, y, a + da, len, w, d or 3, {refill=0.7, wmin=0.5, jit=0.25, up=0.12}) end
-- B2 and B3 (right) get a fine layer; A2 left as is for comparison
for _, s in ipairs({{0.55, 0.9, 26, 1.5}, {0.7, -0.8, 24, 1.5}, {0.85, 0.6, 22, 1.4}, {0.95, -0.4, 26, 1.5}, {1.0, 0.2, 30, 1.6}}) do fine("B2", s[1], s[2], s[3], s[4]) end
for _, s in ipairs({{0.5, 0.8, 22, 1.4}, {0.75, -0.7, 22, 1.4}, {1.0, -0.1, 28, 1.6}}) do fine("B3", s[1], s[2], s[3], s[4]) end

--@ chunk 13
xfix = pile{{"lead white",6},{"smalt",1.6},{"cobalt blue",0.65},{"bone black",0.05},{"rose madder",0.06}, medium=0.09, name="xfix"}
xfix2 = pile{{"lead white",6},{"smalt",1.6},{"cobalt blue",0.65},{"bone black",0.05},{"rose madder",0.06}, thinner=0.4, name="xfix_thin"}
local b = brush{kind="filbert", width=6, stiffness=0.4}
b:load(xfix, 0.4)
b:gesture({{560,200,0.4},{620,215,0.5},{680,228,0.3}}, {wobble=1})
b:reload(xfix2, 0.6)
b:gesture({{560,240,0.4},{620,255,0.5},{680,268,0.3}}, {wobble=1})
b:reload(xfix2, 0.6)
b:gesture({{560,170,0.4},{620,175,0.5},{680,180,0.3}}, {wobble=1})
b:gesture({{560,173,0.4},{620,178,0.5},{680,183,0.3}}, {wobble=1})

--@ chunk 14
local m1 = mix{{f1, 0.5}, {f2, 0.5}, name="m12"}
local m2 = mix{{f1, 0.3}, {f2, 0.7}, name="m12b"}
local b = brush{kind="filbert", width=8, stiffness=0.3}
b:load(m1, 0.3)
b:gesture({{720,190,0.3},{790,200,0.4},{860,206,0.2}}, {wobble=1})
b:reload(m2, 0.3)
b:gesture({{720,225,0.3},{790,235,0.4},{860,241,0.2}}, {wobble=1})

--@ chunk 15
gW1 = pile{{"rose madder",1},{"chrome yellow",0.6}, medium=0.9, name="gW1"}
gW2 = pile{{"rose madder",0.6},{"yellow ochre",1},{"vermilion",0.2}, medium=0.9, name="gW2"}
local function w(x, y) return smoothstep(400, 500, y) * (1 - 0.5 * smoothstep(100, 450, math.abs(x - 500))) end
local L = rect(0, 380, 495, 170)
work(L, {hand="glaze", pile=gW1, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.5 * w(x,y) end, clip=true, seed=31})
blend(L, {angle=0, seed=32})
local R = rect(505, 380, 495, 170)
work(R, {hand="glaze", pile=gW2, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.5 * w(x,y) end, clip=true, seed=33})
blend(R, {angle=0, seed=34})
