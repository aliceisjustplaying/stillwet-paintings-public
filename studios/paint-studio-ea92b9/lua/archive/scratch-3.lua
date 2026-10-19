-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_zen  = pile{{"lead white",0.6},{"smalt",1.5},{"cobalt blue",0.8},{"Prussian blue",0.1},{"raw umber",0.15},{"bone black",0.04}, name="s_zen"}
s_top  = pile{{"lead white",1.5},{"smalt",1.2},{"cobalt blue",0.8},{"raw umber",0.08}, name="s_top"}
s_mid  = pile{{"lead white",3},{"cobalt blue",0.6},{"smalt",0.6},{"Naples yellow",0.2}, name="s_mid"}
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.6}, name="s_grn"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
s_low  = pile{{"lead white",4},{"Naples yellow",1.4},{"yellow ochre",0.3},{"vermilion",0.2},{"rose madder",0.1}, name="s_low"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local sky = rect(0,0,500,470)
work(sky, {hand="broad", piles={{s_zen,wgt(0,100)},{s_top,wgt(100,100)},{s_mid,wgt(200,100)},{s_grn,wgt(300,100)},{s_glow,wgt(390,90)},{s_low,wgt(470,80)}}, angle=0, coverage=2.6, fill=true, clip=sky, seed=31})
blend(sky, {angle=0})
blend(sky, {angle=0.05})

--@ chunk 3
print(wait(3*24*60))
g_smalt = pile{{"smalt",2},{"cobalt blue",0.3},{"rose madder",0.12},{"raw umber",0.05}, medium=0.8, name="g_smalt"}
local m = rect(0,0,250,320)
work(m, {hand="glaze", pile=g_smalt, angle=0, coverage=1.5, clip=rect(0,0,250,470), load_at=function(x,y) return clamp(1 - y/280, 0, 1)^1.3 end, seed=41})
blend(rect(0,0,250,330), {angle=0})
-- second variant: stipple glaze
local m2 = rect(250,0,250,320)
stipple(m2, {pile=g_smalt, width=6, coverage=function(x,y) return 3*clamp(1-y/280,0,1) end, feather=0.5, seed=42})
blend(rect(250,0,250,330), {angle=0})

--@ chunk 4
s_zen  = pile{{"lead white",0.6},{"smalt",1.5},{"cobalt blue",0.8},{"Prussian blue",0.1},{"raw umber",0.15},{"bone black",0.04}, name="s_zen"}
s_top  = pile{{"lead white",1.5},{"smalt",1.2},{"cobalt blue",0.8},{"raw umber",0.08}, name="s_top"}
s_mid  = pile{{"lead white",3},{"cobalt blue",0.6},{"smalt",0.6},{"Naples yellow",0.2}, name="s_mid"}
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.6}, name="s_grn"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
s_low  = pile{{"lead white",4},{"Naples yellow",1.4},{"yellow ochre",0.3},{"vermilion",0.2},{"rose madder",0.1}, name="s_low"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local sky = rect(520,0,480,470)
work(sky, {hand="broad", piles={{s_zen,wgt(0,150)},{s_top,wgt(120,120)},{s_mid,wgt(235,110)},{s_grn,wgt(325,100)},{s_glow,wgt(400,80)},{s_low,wgt(465,70)}}, angle=0, coverage=2.6, fill=true, clip=sky, seed=111})
blend(rect(522,0,476,468), {angle=0})
blend(rect(522,0,476,468), {angle=0.04})
-- darker land below for context
local land = pile({{"raw umber",2},{"bone black",0.5},{"Prussian blue",0.12}, turps=0.6})
work(rect(0,470,1000,244), {hand="broad", pile=land, angle=0, coverage=2, fill=true, clip=rect(0,470,1000,244), seed=5})
print(wait(3*24*60))

--@ chunk 5
g_smalt2 = pile{{"smalt",2},{"cobalt blue",0.4},{"rose madder",0.15},{"raw umber",0.08}, medium=0.7, name="g_smalt2"}
-- stronger glaze on 520-760
work(rect(520,0,240,330), {hand="glaze", pile=g_smalt2, angle=0, coverage=2.0, clip=rect(520,0,240,470), load_at=function(x,y) return clamp(1 - y/300, 0, 1)^1.2 end, seed=51})
blend(rect(520,0,240,340), {angle=0})
blend(rect(520,0,240,340), {angle=0.03})
-- stratus band test on 760-1000 around y 380: violet-gray, thin, horizontal
cl = pile{{"lead white",2},{"smalt",0.6},{"rose madder",0.25},{"raw umber",0.15},{"Naples yellow",0.3}, name="cl"}
local b = brush{kind="filbert", width=7, stiffness=0.4}
local ys = {372, 381, 388, 394}
for i,y in ipairs(ys) do
  b:reload(cl, 0.5)
  b:stroke({{770+i*8,y},{850,y-1},{930,y+1},{995,y}}, {pressure={0.35,0.15}, ramps={0.2,0.5}})
end
local m = rect(765,360,235,45)
blend(m, {angle=0})

--@ chunk 6
-- same tree skeleton on scratch, shifted to sit on the sky test area (scratch sky 0..500 & 520..1000)
tree = {
  trunk = {{{300,552},{304,500},{299,450},{297,415},{305,382}}, {40,30,28,27,25}},
  A  = {{{303,384},{272,334},{232,302},{192,252},{170,203},{150,170}}, {18,13,10,7,4.5,2}},
  A1 = {{{232,302},{192,306},{152,291},{122,296},{100,284}}, {7,4.5,3,1.8,0.8}},
  A2 = {{{192,252},{206,202},{199,160},{214,120}}, {6,4,2.4,0.9}},
  A3 = {{{170,203},{131,191},{114,164}}, {4,2.4,1}},
  B  = {{{306,382},{318,322},{311,262},{325,202},{321,158}}, {18,14,11,9.5,8.5}},
  B1 = {{{311,262},{281,222},{270,172},{251,131},{255,96}}, {7,5,3.5,2,0.8}},
  B2 = {{{325,202},{356,171},{371,131},{396,110}}, {6,4,2.2,0.8}},
  C  = {{{306,388},{346,361},{391,346},{431,321},{471,311},{511,291},{542,281}}, {16,12,10,7,5,3,1}},
  C1 = {{{391,346},{421,369},{451,376},{470,396}}, {5,3,2,0.8}},
  C2 = {{{431,321},{441,281},{431,241},{451,201}}, {6,4,2.5,0.9}},
  C3 = {{{471,311},{491,331},{521,336}}, {3,2,0.8}},
  C4 = {{{511,291},{516,261},{541,241}}, {3,2,0.8}},
  S  = {{{299,442},{274,431}}, {13,10}},
}
print(wait(2*24*60))
t_dark = pile{{"raw umber",1.5},{"bone black",0.6},{"Prussian blue",0.08},{"red earth",0.15}, name="t_dark"}
local tm = nil
for k, br in pairs(tree) do
  local r = ribbon(br[1], br[2])
  tm = tm and (tm + r) or r
end
tm = tm + poly({{278,556},{285,530},{292,505},{312,505},{318,530},{330,556}}, true)
tree_mask = tm:roughen(1.2, 6, 3)
work(tree_mask, {hand="detail", pile=t_dark, coverage=2.5, fill=true, angle=function(x,y) return -math.pi/2 end, seed=201})
