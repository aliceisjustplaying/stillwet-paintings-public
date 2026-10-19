-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
s0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}, name="s0_zenith"}
s1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, name="s1_blue"}
s2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, name="s2_paleblue"}
s3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}, name="s3_neutral"}
s4 = pile{{"lead white",6},{"Naples yellow",2.5},{"chrome yellow",0.6}, name="s4_yellow"}
s5 = pile{{"lead white",7},{"Naples yellow",2},{"chrome yellow",1},{"vermilion",0.12}, name="s5_glow"}
s6 = pile{{"lead white",6},{"Naples yellow",2},{"chrome yellow",0.8},{"vermilion",0.35}, name="s6_horizon"}
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function g(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
local P = {{s0, g(-10, 75)},{s1, g(110, 75)},{s2, g(220, 65)},{s3, g(310, 55)},{s4, g(400, 50)},{s5, g(485, 42)},{s6, g(550, 30)}}
local m = rect(0, 0, 1000, 578)
work(m, {hand="broad", piles=P, angle=0, coverage=2, clip=true, seed=31})
work(m, {hand="broad", piles=P, angle=0, coverage=1.5, fill=true, clip=true, seed=32})
blend(m, {angle=0})
blend(rect(0, 0, 1000, 340):soften(40), {angle=0.03, seed=5})
wait(3*24*60)
print(drying(500,100), drying(500,500))

--@ chunk 3
u0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}, thinner=0.3, name="u0"}
u1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, thinner=0.3, name="u1"}
u2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, thinner=0.3, name="u2"}
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function wgt(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
local fade = function(x, y) return 1 - smoothstep(170, 270, y) end
local ws = {{u0, wgt(-10, 75)}, {u1, wgt(110, 75)}, {u2, wgt(220, 65)}}
local area = rect(0, 0, 500, 290)
for i, pw in ipairs(ws) do
  local p, wf = pw[1], pw[2]
  local function cov(x, y)
    local tot = 0
    for _, q in ipairs(ws) do tot = tot + q[2](x, y) end
    return 2.4 * wf(x, y) / math.max(tot, 1e-3) * fade(x, y)
  end
  stipple(area, {pile=p, width=6, coverage=cov, pressure={0.3,0.55}, feather=0.5, seed=10+i})
end
blend(area, {angle=0, seed=20})

--@ chunk 4
n0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}, medium=0.1, name="n0"}
n1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, medium=0.1, name="n1"}
n2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, medium=0.1, name="n2"}
n3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}, medium=0.1, name="n3"}
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function g(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
local P = {{n0, g(-10, 75)},{n1, g(110, 75)},{n2, g(220, 65)},{n3, g(310, 55)}}
local area = rect(510, 0, 490, 300)
work(area, {hand="broad", piles=P, angle=0, angle_jitter=0.03, curve={0.02, 0}, coverage=2, fill=true, clip=true, seed=41})
blend(area, {angle=0, seed=42})
blend(area, {angle=0, seed=43})

--@ chunk 5
n4 = pile{{"lead white",6},{"Naples yellow",2.6},{"chrome yellow",0.3},{"yellow ochre",0.15}, medium=0.1, name="n4_yellow"}
n5 = pile{{"lead white",6.5},{"Naples yellow",2.4},{"chrome yellow",0.5},{"vermilion",0.18}, medium=0.1, name="n5_glow"}
n6 = pile{{"lead white",6},{"Naples yellow",2.2},{"chrome yellow",0.35},{"vermilion",0.45},{"rose madder",0.06}, medium=0.1, name="n6_horizon"}
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function g(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
local P = {{n0, g(-10, 75)},{n1, g(110, 75)},{n2, g(220, 65)},{n3, g(310, 55)},{n4, g(400, 50)},{n5, g(480, 40)},{n6, g(545, 28)}}
local area = rect(0, 290, 500, 288)
work(area, {hand="broad", piles=P, angle=0, angle_jitter=0.03, curve={0.02, 0}, coverage=2, fill=true, clip=true, seed=51})
blend(area, {angle=0, seed=52})
blend(area, {angle=0, seed=53})

--@ chunk 6
wait(3*24*60)
-- ridge + mountains quickly so the tree trial is judged in context
mtA = pile{{"lead white",2},{"smalt",2},{"cobalt blue",0.3},{"rose madder",0.25},{"raw umber",0.45}}
mtB = pile{{"lead white",5},{"smalt",1},{"rose madder",0.12},{"Naples yellow",1.0}}
mi = pile{{"lead white",8},{"Naples yellow",1.2},{"pale smalt",0.8},{"rose madder",0.06}}
rg = pile{{"raw umber",3},{"bone black",1.4},{"green earth",0.6},{"smalt",0.4}}
local mpts = {{-10,524},{40,519},{90,513},{140,507},{185,502},{225,499},{262,496},{300,493},{330,494},{356,497},{385,503},{418,511},{448,517},{475,521},{500,523},{528,522},{560,518},{596,512},{630,507},{668,503},{705,499},{742,497},{775,498},{805,502},{840,507},{880,512},{925,517},{970,521},{1010,524}}
local rpts = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
work(below(mpts) * above(function(x) return 560 end), {hand="body", piles={{mtA, function(x,y) return 1 - smoothstep(512,560,y) end},{mtB, function(x,y) return smoothstep(512,560,y) end}}, coverage=2, fill=true, clip=true})
work(below(function(x) return 560 end) - below(rpts), {hand="body", pile=mi, coverage=2, fill=true, clip=true})
work(below(rpts), {hand="body", pile=rg, coverage=2, fill=true, clip=true})
wait(3*24*60)
print(drying(500,300), drying(500, 540), drying(500, 650))

--@ chunk 7
function taperw(pts, w0, w1, pw)
  local ws = {}
  local n = #pts
  for i = 1, n do local t = (i-1)/(n-1); ws[i] = w0 + (w1 - w0) * (t ^ (pw or 0.8)) end
  return ws
end
trunk_spine = {{500,606},{499,580},{497,555},{498,530},{501,508},{503,492}}
limbs = {
  L1 = {pts={{494,505},{462,496},{425,491},{392,478},{360,468},{328,460},{298,444},{272,436},{250,433}}, w={22,5}},
  L2 = {pts={{493,492},{477,455},{466,418},{450,382},{440,346},{426,312},{414,280},{404,252}}, w={24,6}},
  L3 = {pts={{503,490},{507,445},{501,400},{499,360},{506,320},{502,280},{506,240},{503,205},{498,178}}, w={26,7}},
  L4 = {pts={{507,490},{530,456},{551,420},{570,385},{582,350},{600,316},{622,282},{640,255},{652,236}}, w={22,5}},
  L5 = {pts={{510,505},{546,500},{588,489},{626,480},{662,466},{696,450},{724,440},{752,434}}, w={20,5}},
}
local order = {"L1","L2","L3","L4","L5"}
local m = ribbon(trunk_spine, {50,42,38,36,36,36})
for _, k in ipairs(order) do local L = limbs[k]; m = m + ribbon(L.pts, taperw(L.pts, L.w[1], L.w[2])) end
-- root flare
m = m + poly({{448,612},{470,600},{478,585},{522,585},{530,600},{556,613},{540,616},{500,614},{460,616}}, true)
tree_main = m:roughen(1.2, 9, 7)
local h = pencil("2B")
for _, k in ipairs(order) do h:line(limbs[k].pts, {pressure=0.4}) end
h:line(trunk_spine, {pressure=0.4})

--@ chunk 8
for _, k in ipairs({"L1","L2","L3","L4","L5"}) do erase(limbs[k].pts, {strength=0.95, width=8}) end
erase(trunk_spine, {strength=0.95, width=8})
trunk_spine = {{500,608},{498,585},{496,560},{497,535},{500,510},{502,490},{501,472}}
limbs = {
  L1 = {pts={{494,524},{462,516},{428,517},{398,509},{372,492},{352,470},{328,454},{300,446},{276,432}}, w={22,5}},
  L5 = {pts={{506,507},{538,495},{570,490},{600,476},{628,454},{660,441},{698,427},{734,420}}, w={20,5}},
  L2 = {pts={{497,474},{482,442},{471,406},{454,376},{444,341},{431,306},{424,276},{410,246}}, w={24,6}},
  L4 = {pts={{505,474},{520,437},{528,401},{547,366},{561,331},{582,302},{601,272}}, w={24,6}},
  L3 = {pts={{528,404},{523,352},{527,302},{519,256},{522,216},{515,180}}, w={14,5}},
  S1 = {pts={{452,376},{428,364},{413,362}}, w={8,6}},
}
tree_order = {"L1","L5","L2","L4","L3","S1"}
local h = pencil("2B")
for _, k in ipairs(tree_order) do h:line(limbs[k].pts, {pressure=0.5}) end
h:line(trunk_spine, {pressure=0.5})

--@ chunk 9
tr1 = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}, name="tree_dark"}
function build_tree_mask()
  local m = ribbon(trunk_spine, {54,44,40,38,38,40,36})
  for _, k in ipairs(tree_order) do local L = limbs[k]; m = m + ribbon(L.pts, taperw(L.pts, L.w[1], L.w[2], 0.7)) end
  m = m + poly({{444,614},{466,603},{476,588},{524,588},{534,602},{560,614},{540,618},{500,615},{462,618}}, true)
  return m:roughen(1.0, 8, 7)
end
tree_main = build_tree_mask()
work(tree_main, {hand="detail", pile=tr1, coverage=3, fill=true, length={6,16}, angle=function(x,y) return -math.pi/2 end})
