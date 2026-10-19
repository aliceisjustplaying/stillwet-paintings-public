-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
work(rect(0,0,1000,667), {hand="broad", pile=pile{{"Prussian blue",0.23},{"ultramarine blue",0.2},{"bone black",0.21},{"lead white",0.32},{"raw umber",0.03}}, coverage=2.2, fill=true, angle=0.03})
work(rect(100,100,200,200), {hand="body", pile=pile{{"Prussian blue",0.23},{"ultramarine blue",0.2},{"bone black",0.25},{"lead white",0.30},{"raw umber",0.05}}, coverage=2.2, fill=true})
wait(15*24*60)
skyglaze = pile{{"bone black",0.5},{"Prussian blue",0.3},{"ultramarine blue",0.4}, medium=0.82, name="skyglaze"}
work(ellipse(200,200,70,70):soften(25), {hand="glaze", pile=skyglaze, coverage=1.0, fill=true, angle=0.05})

--@ chunk 3
skyglaze2 = pile{{"bone black",0.4},{"raw umber",0.15},{"Prussian blue",0.08},{"ultramarine blue",0.1}, medium=0.9, name="skyglaze2"}
local m = ellipse(600,200,70,70):soften(25)
work(m, {hand="glaze", pile=skyglaze2, coverage=0.8, fill=true, angle=0.05})
blend(ellipse(600,200,85,85), {angle=0.05})
local m2 = ellipse(600,450,70,70):soften(25)
work(m2, {hand="glaze", pile=skyglaze2, coverage=0.8, fill=true, angle=0.05})

--@ chunk 4
coat_moon = pile{{"raw umber",0.6},{"lead white",0.45},{"Prussian blue",0.1},{"bone black",0.2},{"yellow ochre",0.1}, name="coat_moon"}
coat_moonM = pile{{"raw umber",0.6},{"lead white",0.45},{"Prussian blue",0.1},{"bone black",0.2},{"yellow ochre",0.1}, medium=0.25, name="coat_moonM"}
local tent2 = poly({{600,200},{640,200},{700,480},{460,480}}, true)
local function edge(M, dx, dy, d) return mask(function(x,y) if M:at(x,y) < 0.5 then return 0 end; return clamp((1-M:at(x+dx*d,y+dy*d)) + 0.6*(1-M:at(x+dx*d*2,y+dy*d*2)),0,1) end) end
local e = edge(tent2, 0.89, -0.45, 3)
-- A: detail hand with medium paint, fill
local eA = e * mask(function(x,y) return y < 340 and 1 or 0 end)
work(eA, {hand="detail", tool={kind="round", width=2.5}, pile=coat_moonM, coverage=2.5, fill=true, clip=tent2, length={6,16}, angle=1.35})
-- B: a few gestures with a soft filbert along the edge
local b = brush{kind="filbert", width=4, stiffness=0.3}
b:load(coat_moonM, 0.6)
b:gesture({{667,350,0.2},{676,390,0.6},{686,430,0.6},{694,470,0.3}}, {clip=tent2, wobble=1})
b:load(coat_moonM, 0.5)
b:gesture({{662,352,0.1},{670,395,0.3},{680,440,0.3}}, {clip=tent2, wobble=1})

--@ chunk 5
coat_dk = pile{{"raw umber",1},{"bone black",1},{"red earth",0.15},{"ultramarine blue",0.15},{"lead white",0.08}, name="coat_dk"}
coat_m = pile{{"raw umber",1},{"bone black",0.45},{"red earth",0.2},{"yellow ochre",0.15},{"lead white",0.1}, name="coat_m"}
local T = poly({{180,340},{240,340},{320,630},{60,630}}, true)
TENT = T
work(T, {hand="body", tool="filbert 8", piles={{coat_dk,1.2},{coat_m,0.6}}, coverage=2.2, fill=true, clip=T, length={20,50}, angle=1.65})
wait(12*24*60)
cglaze = pile{{"bone black",0.6},{"raw umber",0.8},{"ultramarine blue",0.3}, medium=0.78, name="cglaze"}
local b = brush{kind="filbert", width=10, stiffness=0.25}
local function V(pts) b:load(cglaze, 0.7); b:gesture(pts, {clip=T, wobble=2}) end
V({{190,400,0.1},{160,500,0.6},{120,625,0.9}})
V({{205,420,0.1},{196,520,0.6},{180,628,0.9}})
V({{222,430,0.1},{232,530,0.5},{246,628,0.8}})
V({{236,460,0.1},{262,550,0.5},{290,628,0.7}})

--@ chunk 6
local T2 = TENT:offset(0)
-- second tent to the right for comparison
local T = poly({{580,340},{640,340},{720,630},{460,630}}, true)
work(T, {hand="body", tool="filbert 8", piles={{coat_dk,1.2},{coat_m,0.6}}, coverage=2.2, fill=true, clip=T, length={20,50}, angle=1.65})
wait(12*24*60)
local folds = {
 {{590,400},{560,500},{520,625}},
 {{605,420},{596,520},{580,628}},
 {{622,430},{632,530},{646,628}},
 {{636,460},{662,550},{690,628}},
}
for i, f in ipairs(folds) do
  local rb = ribbon(f, {4, 14, 26}):soften(6) * T
  work(rb, {hand="glaze", tool={kind="filbert", width=12, stiffness=0.25}, pile=cglaze, coverage=1.6, fill=true, clip=T, angle=1.7, length={30,80}, seed=100+i})
end

--@ chunk 7
local T = poly({{180,340},{240,340},{320,630},{60,630}}, true)
-- the gestured glaze folds on tent 1 are still wet? blend them along their length
print(drying(160,500), drying(196,520))
blend(T:shrink(4), {angle=1.7})

--@ chunk 8
local T = poly({{780,340},{840,340},{920,630},{660,630}}, true)
work(T, {hand="body", tool="filbert 8", piles={{coat_dk,1.2},{coat_m,0.6}}, coverage=2.2, fill=true, clip=T, length={20,50}, angle=1.65})
wait(12*24*60)
local b = brush{kind="filbert", width=12, stiffness=0.25}
local function V(pts) b:load(cglaze, 0.7); b:gesture(pts, {clip=T, wobble=2}) end
V({{790,400,0.1},{760,500,0.6},{720,625,0.9}})
V({{805,420,0.1},{796,520,0.6},{780,628,0.9}})
V({{822,430,0.1},{832,530,0.5},{846,628,0.8}})
V({{836,460,0.1},{862,550,0.5},{890,628,0.7}})
work(T:shrink(3), {hand="blend", angle=0.1, coverage=1})
work(T:shrink(3), {hand="blend", angle=1.7, coverage=1})

--@ chunk 9
coat_rim = pile{{"raw umber",0.5},{"lead white",0.5},{"Prussian blue",0.1},{"bone black",0.15},{"yellow ochre",0.12}, name="coat_rim"}
coat_lit2 = pile{{"raw umber",0.5},{"yellow ochre",0.6},{"red earth",0.3},{"orange vermilion",0.1},{"lead white",0.3}, name="coat_lit2"}
local T = poly({{780,340},{840,340},{920,630},{660,630}}, true)
local r = brush{kind="round", width=3, point=0.7, stiffness=0.4}
r:load(coat_rim, 0.6)
r:gesture({{840,345,0.2},{855,400,0.45},{872,460,0.5},{888,520,0.45},{905,590,0.3},{914,625,0.1}}, {clip=T, wobble=1})
local f = brush{kind="filbert", width=5, stiffness=0.3}
f:load(coat_lit2, 0.5)
f:gesture({{838,350,0.3},{846,380,0.5},{852,410,0.3},{856,430,0.0}}, {clip=T, wobble=1})
