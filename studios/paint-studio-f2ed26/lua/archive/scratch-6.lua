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
print(drying(500,300), drying(500, 540), drying(500, 650))

--@ chunk 3
function taperw(pts, w0, w1, pw)
  local ws = {}
  local n = #pts
  for i = 1, n do local t = (i-1)/(n-1); ws[i] = w0 + (w1 - w0) * (t ^ (pw or 0.8)) end
  return ws
end
trunk_spine = {{500,612},{498,582},{497,552},{499,528},{500,515}}
trunk_w = {70,54,50,50,46}
limbs = {
  A  = {pts={{490,528},{470,512},{456,492},{445,470},{425,456},{400,447},{384,430},{372,405},{352,390},{330,384},{310,372}}, w={30,7}},
  A1 = {pts={{445,470},{418,474},{390,472},{362,478},{338,472},{312,466},{290,458},{268,456}}, w={13,3}},
  A2 = {pts={{400,447},{404,418},{396,392},{402,362},{394,332},{398,306},{390,282}}, w={11,3}},
  A3 = {pts={{372,405},{360,375},{342,352},{334,330}}, w={7,2.5}},
  C  = {pts={{498,522},{492,492},{486,462},{489,432},{480,402},{477,372},{484,342},{478,312},{480,282}}, w={30,9}},
  C1 = {pts={{480,284},{476,252},{482,222},{476,195},{470,178}}, w={9,3}, dead=true},
  C2 = {pts={{479,300},{500,276},{510,248},{522,232}}, w={6,2}, dead=true},
  C3 = {pts={{486,462},{466,436},{455,405},{440,380},{436,350},{424,325},{420,300}}, w={12,3}},
  C4 = {pts={{477,372},{500,352},{512,330},{530,310},{542,286}}, w={9,2.5}},
  B  = {pts={{506,522},{530,508},{548,486},{566,472},{590,465},{612,450},{625,428},{645,412},{672,402},{696,390}}, w={28,7}},
  B1 = {pts={{566,472},{596,482},{628,480},{660,470},{690,466},{718,456},{740,452}}, w={12,3}},
  B2 = {pts={{548,486},{552,452},{566,420},{564,388},{578,360},{582,330},{596,305},{600,280}}, w={13,3}},
  B3 = {pts={{625,428},{630,398},{646,372},{652,346},{668,326}}, w={8,2.5}},
  B4 = {pts={{612,450},{624,436},{631,429}}, w={6,5}, dead=true},
}
tree_order = {"A","A1","A2","A3","C","C1","C2","C3","C4","B","B1","B2","B3","B4"}
function build_tree_mask()
  local m = ribbon(trunk_spine, trunk_w)
  for _, k in ipairs(tree_order) do local L = limbs[k]; m = m + ribbon(L.pts, taperw(L.pts, L.w[1], L.w[2], 0.7)) end
  m = m + poly({{440,616},{462,606},{470,592},{530,592},{538,606},{564,616},{544,620},{500,617},{456,620}}, true)
  return m:roughen(1.0, 8, 7)
end
tree_main = build_tree_mask()
tr1 = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}, name="tree_dark"}
work(tree_main, {hand="detail", pile=tr1, coverage=3, fill=true, length={6,16}, angle=function(x,y) return -math.pi/2 end})
