-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 2}, {"red earth", 1}, {"yellow ochre", 1}}, texture=0.35, um=90}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.25}, {"raw umber", 0.08}}, texture=0.4, um=45}}, linen={15, 13}, seed=6, size=1050}

--@ chunk 2
horizon = 440
s1 = pile{{"lead white",2},{"cobalt blue",1},{"smalt",0.8}}
s2 = pile{{"lead white",4},{"cobalt blue",0.8},{"smalt",0.4}}
s3 = pile{{"lead white",7},{"cobalt blue",0.4},{"smalt",0.1}}
s4 = pile{{"lead white",8},{"Naples yellow",0.3},{"cobalt blue",0.12}}
local function wgt(c, w) return function(x,y) local t=y/horizon; return math.max(0, 1-math.abs(t-c)/w) end end
skypiles = {{s1, wgt(0,0.4)},{s2, wgt(0.33,0.4)},{s3, wgt(0.66,0.4)},{s4, wgt(1.0,0.4)}}
work(rect(0,0,250,440), {hand="broad", piles=skypiles, coverage=2, fill=true, angle=0})
blend(rect(0,0,250,440), {angle=0})
work(rect(250,0,250,440), {hand="body", piles=skypiles, coverage=2, fill=true, angle=0})
blend(rect(250,0,250,440), {angle=0})
blend(rect(250,0,250,440), {angle=0.3})

--@ chunk 3
z1 = pile{{"lead white",1},{"cobalt blue",1.5},{"Prussian blue",0.05}, name="z1"}
z2 = pile{{"lead white",1},{"cobalt blue",1},{"smalt",1}, name="z2"}
z3 = pile{{"lead white",1.5},{"cobalt blue",1},{"Prussian blue",0.1}, name="z3"}
z4 = pile{{"lead white",2},{"cobalt blue",1},{"Prussian blue",0.04},{"raw umber",0.03}, name="z4"}

--@ chunk 4
k1 = pile{{"lead white",1.2},{"cobalt blue",1.2},{"Prussian blue",0.08}, name="k1"}
k2 = pile{{"lead white",2.2},{"cobalt blue",1},{"Prussian blue",0.04}, name="k2"}
k3 = pile{{"lead white",5},{"cobalt blue",1},{"Prussian blue",0.02}, name="k3"}
k4 = pile{{"lead white",8},{"Naples yellow",0.35},{"cobalt blue",0.15}, name="k4"}
local function wgt(c, w) return function(x,y) local t=y/horizon; return math.max(0, 1-math.abs(t-c)/w) end end
local sp = {{k1, wgt(0,0.38)},{k2, wgt(0.3,0.38)},{k3, wgt(0.62,0.38)},{k4, wgt(1.0,0.4)}}
work(rect(520,0,250,440), {hand="body", piles=sp, coverage=2, fill=true, angle=0})
blend(rect(520,0,250,440), {angle=0})
blend(rect(520,0,250,440), {angle=0.3})
