-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
t5 = pile{{"lead white",7},{"Naples yellow",2},{"chrome yellow",1},{"vermilion",0.12}}
t6 = pile{{"lead white",6},{"Naples yellow",2},{"chrome yellow",0.8},{"vermilion",0.35}}
local m = rect(0, 420, 420, 160)
work(m, {hand="broad", piles={{t5, function(x,y) return math.exp(-((y-485)/42)^2) end},{t6, function(x,y) return math.exp(-((y-550)/30)^2) end}}, angle=0, coverage=2, clip=true})
work(m, {hand="broad", piles={{t5, function(x,y) return math.exp(-((y-485)/42)^2) end},{t6, function(x,y) return math.exp(-((y-550)/30)^2) end}}, angle=0, coverage=1.5, fill=true, clip=true})
blend(m, {angle=0})
mtA = pile{{"lead white",3},{"smalt",1.2},{"rose madder",0.25},{"raw umber",0.35},{"Naples yellow",0.2}, name="mtA"}
mtB = pile{{"lead white",6},{"smalt",0.8},{"rose madder",0.12},{"Naples yellow",0.8}, name="mtB_foot"}
mistA = pile{{"lead white",8},{"Naples yellow",1.2},{"pale smalt",0.8},{"rose madder",0.05}, name="mist"}
local mp = {{0,522},{80,512},{160,502},{240,496},{300,494},{350,498},{410,510},{460,520}}
local mm = below(mp):roughen(1.5, 20, 4) * above(function(x) return 572 end)
work(mm, {hand="body", piles={{mtA, function(x,y) return 1 - smoothstep(505, 565, y) end},{mtB, function(x,y) return smoothstep(505, 565, y) end}}, angle=0, coverage=2, fill=true, edge={found=0.5, soft=0.5, period=60}})
local mist = rect(0, 555, 420, 110)
work(mist, {hand="body", pile=mistA, angle=0, coverage=2, fill=true, clip=true})
blend(rect(0,545,420,40), {angle=0})

--@ chunk 3
cv = pile{{"lead white",4},{"smalt",1},{"rose madder",0.35},{"raw umber",0.3},{"Naples yellow",1.2}, name="cloud_violet"}
cr = pile{{"lead white",5},{"Naples yellow",1.5},{"vermilion",0.3},{"rose madder",0.25}, name="cloud_rose"}
local c1 = poly({{10,452},{60,446},{120,444},{170,441},{205,443},{205,449},{160,453},{110,456},{60,458},{10,458}}, true):roughen(2.5, 25, 21)
local c2 = poly({{220,446},{270,442},{330,440},{380,441},{410,444},{410,450},{360,452},{300,454},{250,454},{220,452}}, true):roughen(2.5, 25, 22)
work(c1, {hand="body", tool={kind="filbert", width=5, stiffness=0.4}, pile=cv, angle=0, coverage=2, length={25,60}, clip=true})
work(c2, {hand="body", tool={kind="filbert", width=5, stiffness=0.4}, pile=cv, angle=0, coverage=2, length={25,60}, clip=true})
-- rose underside on both
local r1 = ribbon({{20,457},{100,455},{200,448}}, 2.5)
local r2 = ribbon({{230,453},{320,453},{405,449}}, 2.5)
work(r1 + r2, {hand="detail", pile=cr, angle=0, coverage=1.5})
-- blend only the right one
blend(c2:grow(5):soften(3), {angle=0})

--@ chunk 4
local b = brush{kind="filbert", width=4, stiffness=0.35}
b:load(cv, 0.35)
b:gesture({{5,478,0.05},{60,476,0.35},{150,473,0.6},{230,474,0.45},{300,471,0.3},{360,472,0.1},{400,471,0.0}}, {wobble=1.5})
b:load(cv, 0.25)
b:gesture({{90,489,0.0},{150,487,0.3},{210,488,0.4},{280,486,0.15},{320,487,0.0}}, {wobble=1.2})
local r = brush{kind="round", width=2.5, point=0.6, stiffness=0.35}
r:load(cr, 0.3)
r:gesture({{40,480,0.0},{120,477,0.4},{220,477,0.3},{300,474,0.1},{340,475,0.0}}, {wobble=1})
blend(rect(0, 465, 420, 32):soften(4), {angle=0})

--@ chunk 5
rdT = pile{{"raw umber",2},{"green earth",2},{"bone black",0.6},{"smalt",0.5},{"yellow ochre",0.3}, name="ridge_top"}
rd1 = pile{{"raw umber",3},{"bone black",1},{"green earth",1.5},{"smalt",0.5}, name="ridge_mid"}
rd2 = pile{{"raw umber",2},{"bone black",1.6},{"smalt",0.8},{"rose madder",0.2}, name="ridge_low"}
local rp = {{0,640},{120,632},{250,618},{420,600}}
local rm = below(rp):roughen(1.2, 12, 5)
work(rm, {hand="body", piles={
  {rdT, function(x,y) return math.exp(-((y-610)/25)^2) end},
  {rd1, function(x,y) return math.exp(-((y-660)/35)^2) end},
  {rd2, function(x,y) return smoothstep(660, 720, y) end}}, angle=0.05, coverage=2.5, fill=true, clip=true})

--@ chunk 6
wait(48*60)
-- make a fresh glow patch elsewhere to test on dry sky: area x 450-1000, y 420-600 is bare. Use t5/t6 again
local m = rect(450, 420, 540, 170)
local P = {{t5, function(x,y) return math.exp(-((y-485)/42)^2) end},{t6, function(x,y) return math.exp(-((y-550)/30)^2) end}}
work(m, {hand="broad", piles=P, angle=0, coverage=2, clip=true})
work(m, {hand="broad", piles=P, angle=0, coverage=1.5, fill=true, clip=true})
blend(m, {angle=0})
wait(48*60)
print(drying(700, 500))

--@ chunk 7
wait(12*60)
print(drying(700, 500), drying(700,560))
mtA2 = pile{{"lead white",2.5},{"smalt",1.5},{"rose madder",0.3},{"raw umber",0.4},{"Naples yellow",0.2}, name="mtA2"}
mtB2 = pile{{"lead white",5},{"smalt",1},{"rose madder",0.15},{"Naples yellow",1.0}, name="mtB2_foot"}
local mp = {{450,530},{520,518},{600,508},{680,503},{760,506},{840,514},{920,522},{990,530}}
local mm = below(mp) * above(function(x) return 585 end)
work(mm, {hand="body", tool={kind="filbert", width=6}, piles={{mtA2, function(x,y) return 1 - smoothstep(520, 575, y) end},{mtB2, function(x,y) return smoothstep(520, 575, y) end}}, angle=0, coverage=2.5, fill=true, clip=true, length={20,50}})

--@ chunk 8
rgA = pile{{"raw umber",3},{"bone black",0.8},{"green earth",1},{"yellow ochre",0.4},{"smalt",0.3}, name="rgA_crest"}
rgB = pile{{"raw umber",3},{"bone black",1.4},{"green earth",0.6},{"smalt",0.4}, name="rgB_body"}
rgC = pile{{"raw umber",2.5},{"bone black",2},{"smalt",0.6},{"rose madder",0.15}, name="rgC_bottom"}
local m = below({{450,612},{700,604},{1000,612}}):roughen(1.0, 10, 9) * rect(450,0,550,741)
work(m, {hand="body", tool={kind="filbert", width=10}, piles={
  {rgA, function(x,y) return 1 - smoothstep(615, 660, y) end},
  {rgB, function(x,y) return math.exp(-((y-665)/30)^2) end},
  {rgC, function(x,y) return smoothstep(670, 730, y) end}}, angle=0.03, coverage=2.5, fill=true, clip=true, length={40,110}, seed=5})
blend(m:shrink(2), {angle=0})

--@ chunk 9
local specs = {{"round",16,0.7},{"round",6,0.8},{"rigger",2,1},{"rigger",1.2,1}}
for _, s in ipairs(specs) do
  local b = brush{kind=s[1], width=s[2], point=s[3]}
  local t = {}
  for _, p in ipairs({0.05,0.1,0.2,0.4,0.6,0.8,1}) do t[#t+1] = string.format("%.2f:%.2f", p, b:mark_width(p)) end
  print(s[1], s[2], table.concat(t, "  "))
end

--@ chunk 10
tr1 = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}, name="tree_dark"}
tw1 = pile{{"bone black",2},{"raw umber",1},{"smalt",1}, medium=0.15, name="twig"}
function taper_gesture(b, pts, w0, w1, opts)
  local g = {}
  local n = #pts
  for i, p in ipairs(pts) do
    local t = (i-1)/(n-1)
    local w = (type(w0)=="table") and w0[i] or lerp(w0, w1, t)
    g[#g+1] = {p[1], p[2], b:pressure_for(w)}
  end
  b:gesture(g, opts)
end
function shoot(b, pile, x, y, ang, len, w, depth, up, st)
  st = st or {n=0}
  local pts = {{x,y}}
  local segs = math.max(2, math.floor(len / 9))
  local a = ang
  local cx, cy = x, y
  for i = 1, segs do
    a = a + randn(0, 0.32)
    -- gentle upward pull
    a = a + (up or 0.08) * math.sin(-math.pi/2 - a)
    cx = cx + math.cos(a) * len / segs; cy = cy + math.sin(a) * len / segs
    pts[#pts+1] = {cx, cy}
  end
  st.n = st.n + 1
  if st.n % 6 == 1 then b:load(pile, 0.6) end
  local g = {}
  for i, p in ipairs(pts) do
    local t = (i-1)/(#pts-1)
    g[#g+1] = {p[1], p[2], math.max(0.02, b:pressure_for(math.max(0.4, w * (1 - 0.75*t))))}
  end
  g[#g][3] = 0.02
  b:gesture(g, {wobble=0.3})
  if depth > 0 then
    local nk = math.random(2, 3)
    for k = 1, nk do
      local idx = math.random(math.max(2, #pts - 2), #pts)
      local p = pts[idx]
      local side = (k % 2 == 0) and 1 or -1
      shoot(b, pile, p[1], p[2], a + side * rand(0.35, 0.95), len * rand(0.5, 0.72), w * 0.62, depth - 1, up, st)
    end
  end
  return pts
end
local B = brush{kind="round", width=16, point=0.7}
B:load(tr1, 0.9)
taper_gesture(B, {{420,400},{450,370},{470,330},{500,300},{520,262}}, 14, 6)
local r = brush{kind="rigger", width=2, point=1}
math.randomseed(5)
shoot(r, tw1, 520, 262, -1.3, 55, 2.4, 3)
shoot(r, tw1, 500, 300, -0.3, 50, 2.2, 3)
shoot(r, tw1, 470, 330, -2.2, 45, 2.2, 3)

--@ chunk 11
local m = ribbon({{600,400},{625,370},{640,335},{665,300},{680,265}}, {15,12,10,8,6}):roughen(0.8, 8, 3)
work(m, {hand="detail", pile=tr1, coverage=4, fill=true, angle=function(x,y) return -1.0 end, length={6,14}})
function shoot2(b, pile, x, y, ang, len, w, depth, st)
  st = st or {n=0}
  local pts = {{x,y}}
  local segs = math.max(2, math.floor(len / 6))
  local a = ang
  local cx, cy = x, y
  local kink = (math.random() < 0.5) and 1 or -1
  for i = 1, segs do
    kink = -kink
    local aa = a + kink * rand(0.15, 0.45)
    local sl = len / segs * rand(0.7, 1.3)
    cx = cx + math.cos(aa) * sl; cy = cy + math.sin(aa) * sl
    pts[#pts+1] = {cx, cy}
    a = a + randn(0, 0.12) + 0.06 * math.sin(-math.pi/2 - a)
  end
  st.n = st.n + 1
  if st.n % 5 == 1 then b:load(pile, 0.7) end
  local g = {}
  for i, p in ipairs(pts) do
    local t = (i-1)/(#pts-1)
    g[#g+1] = {p[1], p[2], b:pressure_for(math.max(0.45, w * (1 - 0.5*t)))}
  end
  g[#g][3] = b:pressure_for(0.45)
  b:gesture(g, {wobble=0.2})
  if depth > 0 then
    local nk = math.random(2, 4)
    for k = 1, nk do
      local idx = math.random(math.max(2, math.floor(#pts * 0.4)), #pts)
      local p = pts[idx]
      local side = (math.random() < 0.5) and 1 or -1
      local ca = a + side * rand(0.4, 1.1)
      shoot2(b, pile, p[1], p[2], ca, len * rand(0.45, 0.7), w * 0.7, depth - 1, st)
    end
  end
end
local r = brush{kind="rigger", width=2, point=1}
math.randomseed(11)
shoot2(r, tw1, 680, 265, -1.2, 60, 2.4, 3)
shoot2(r, tw1, 665, 300, -0.2, 50, 2.2, 3)
shoot2(r, tw1, 640, 335, -2.4, 45, 2.0, 3)
