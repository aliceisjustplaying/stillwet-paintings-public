-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
sk1 = pile{{"smalt",3},{"cobalt blue",2},{"lead white",2},{"bone black",0.15}, name="sky_top"}
sk2 = pile{{"lead white",5},{"cobalt blue",1},{"smalt",1}, name="sky_upper"}
sk3 = pile{{"lead white",8},{"pale smalt",1},{"Naples yellow",1}, name="sky_mid"}
sk4 = pile{{"lead white",6},{"Naples yellow",3},{"chrome yellow",0.3}, name="sky_low"}
sk5 = pile{{"lead white",6},{"Naples yellow",3},{"vermilion",0.35},{"rose madder",0.2}, name="sky_horiz"}
print(palette())

--@ chunk 3
sk0 = pile{{"smalt",4},{"cobalt blue",2},{"lead white",1},{"rose madder",0.3},{"bone black",0.1}, name="sky_zenith"}
local function wband(y, c, w) return function(x, yy) return math.exp(-((yy-c)/w)^2) end end
local m = rect(40, 0, 300, 520)
work(m, {hand="broad", piles={
  {sk0, function(x,y) return math.exp(-((y-0)/90)^2) end},
  {sk1, function(x,y) return math.exp(-((y-110)/80)^2) end},
  {sk2, function(x,y) return math.exp(-((y-220)/80)^2) end},
  {sk3, function(x,y) return math.exp(-((y-320)/70)^2) end},
  {sk4, function(x,y) return math.exp(-((y-420)/60)^2) end},
  {sk5, function(x,y) return math.exp(-((y-500)/40)^2) end},
 }, angle=0, coverage=2, clip=true})
print(drying(200, 200))

--@ chunk 4
local m = rect(40, 0, 300, 520)
work(m, {hand="broad", piles={
  {sk0, function(x,y) return math.exp(-((y-0)/90)^2) end},
  {sk1, function(x,y) return math.exp(-((y-110)/80)^2) end},
  {sk2, function(x,y) return math.exp(-((y-220)/80)^2) end},
  {sk3, function(x,y) return math.exp(-((y-320)/70)^2) end},
  {sk4, function(x,y) return math.exp(-((y-420)/60)^2) end},
  {sk5, function(x,y) return math.exp(-((y-500)/40)^2) end},
 }, angle=0, coverage=1.5, fill=true, clip=true, seed=7})
blend(rect(40,0,300,520), {angle=0})

--@ chunk 5
z0 = pile{{"smalt",5},{"cobalt blue",1},{"lead white",1.2},{"rose madder",0.4},{"bone black",0.25}, name="z_zenith"}
z1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.1},{"rose madder",0.15}, name="z_blue"}
z2 = pile{{"lead white",6},{"smalt",1.2},{"cobalt blue",0.3},{"Naples yellow",0.3}, name="z_paleblue"}
z3 = pile{{"lead white",8},{"pale smalt",0.8},{"Naples yellow",0.9},{"green earth",0.4}, name="z_green"}
z4 = pile{{"lead white",8},{"Naples yellow",2.2},{"chrome yellow",0.15}, name="z_yellow"}
z5 = pile{{"lead white",10},{"Naples yellow",1.6},{"chrome yellow",0.25},{"vermilion",0.06}, name="z_glow"}
local m = rect(380, 0, 300, 520)
local P = {
  {z0, function(x,y) return math.exp(-((y-0)/80)^2) end},
  {z1, function(x,y) return math.exp(-((y-120)/75)^2) end},
  {z2, function(x,y) return math.exp(-((y-230)/65)^2) end},
  {z3, function(x,y) return math.exp(-((y-320)/55)^2) end},
  {z4, function(x,y) return math.exp(-((y-410)/50)^2) end},
  {z5, function(x,y) return math.exp(-((y-500)/45)^2) end},
 }
work(m, {hand="broad", piles=P, angle=0, coverage=2, clip=true, seed=3})
work(m, {hand="broad", piles=P, angle=0, coverage=1.5, fill=true, clip=true, seed=8})
blend(m, {angle=0})

--@ chunk 6
y0 = pile{{"smalt",5},{"cobalt blue",1.5},{"lead white",1.2},{"rose madder",0.12},{"bone black",0.15}, name="y_zenith"}
y1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.05}, name="y_blue"}
y2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, name="y_paleblue"}
y3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.3}, name="y_green"}
y4 = pile{{"lead white",6},{"Naples yellow",2.5},{"chrome yellow",0.6}, name="y_yellow"}
y5 = pile{{"lead white",5},{"Naples yellow",2},{"chrome yellow",1},{"vermilion",0.2}, name="y_glow"}
local m = rect(710, 0, 280, 520)
local P = {
  {y0, function(x,y) return math.exp(-((y-0)/80)^2) end},
  {y1, function(x,y) return math.exp(-((y-120)/75)^2) end},
  {y2, function(x,y) return math.exp(-((y-230)/65)^2) end},
  {y3, function(x,y) return math.exp(-((y-320)/55)^2) end},
  {y4, function(x,y) return math.exp(-((y-410)/50)^2) end},
  {y5, function(x,y) return math.exp(-((y-500)/40)^2) end},
 }
work(m, {hand="broad", piles=P, angle=0, coverage=2, clip=true, seed=3})
work(m, {hand="broad", piles=P, angle=0, coverage=1.5, fill=true, clip=true, seed=8})
blend(m, {angle=0})
-- a dark land strip below, to judge the glow against
local d = pile{{"raw umber",3},{"bone black",1},{"smalt",1}, name="landdark"}
work(rect(40, 520, 950, 120), {hand="body", pile=d, coverage=2, fill=true, clip=true})

--@ chunk 7
print(drying(850, 300), drying(850, 450))
cl = pile{{"lead white",3},{"smalt",1},{"rose madder",0.5},{"raw umber",0.3},{"Naples yellow",0.5}, name="cloud_violet"}
clr = pile{{"lead white",5},{"Naples yellow",1.5},{"vermilion",0.35},{"rose madder",0.2}, name="cloud_rose"}
local b = brush{kind="filbert", width=7, stiffness=0.4}
b:load(cl, 0.5)
b:gesture({{715,392,0.3},{780,388,0.5},{860,391,0.6},{940,386,0.4},{985,389,0.1}}, {wobble=2})
b:load(cl, 0.4)
b:gesture({{740,405,0.2},{820,402,0.4},{900,404,0.3},{960,401,0.1}}, {wobble=2})
local r = brush{kind="round", width=3, stiffness=0.4}
r:load(clr, 0.5)
r:gesture({{725,396,0.2},{800,394,0.5},{880,396,0.4},{950,392,0.1}}, {wobble=1})
r:load(clr, 0.4)
r:gesture({{760,409,0.2},{840,407,0.4},{930,408,0.1}}, {wobble=1})

--@ chunk 8
local c1 = poly({{45,380},{90,372},{150,370},{210,366},{260,368},{300,364},{338,367},{338,378},{290,382},{240,386},{180,385},{120,390},{70,391},{45,389}}, true):roughen(4, 30, 11):soften(3)
local c2 = poly({{80,404},{140,399},{200,400},{250,397},{300,399},{338,398},{338,404},{280,408},{210,410},{150,411},{100,410}}, true):roughen(3, 25, 12):soften(2)
cl2 = pile{{"lead white",4},{"smalt",1},{"rose madder",0.3},{"raw umber",0.25},{"Naples yellow",1}, thinner=0.4, name="cloud_v2"}
work(c1 + c2, {hand="scumble", pile=cl2, angle=0, coverage=1.5, clip=true, length={20,50}})
blend(c1:grow(6) + c2:grow(6), {angle=0})
