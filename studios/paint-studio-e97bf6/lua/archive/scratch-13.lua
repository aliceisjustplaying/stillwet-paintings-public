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
horizon=440
k1 = pile{{"lead white",1.2},{"cobalt blue",1.2},{"Prussian blue",0.08}}
k2 = pile{{"lead white",2.2},{"cobalt blue",1},{"Prussian blue",0.04}}
k3 = pile{{"lead white",5},{"cobalt blue",1},{"Prussian blue",0.02}}
k4 = pile{{"lead white",8},{"Naples yellow",0.35},{"cobalt blue",0.15}}
local function band(c, w) return function(x,y) local t=y/horizon; return math.max(0, 1-math.abs(t-c)/w) end end
work(rect(0,0,1000,440), {hand="body", piles={{k1, band(0,0.38)},{k2, band(0.3,0.38)},{k3, band(0.62,0.38)},{k4, band(1,0.4)}}, clip=true, coverage=2, fill=true, angle=0})
blend(rect(0,0,1000,440), {angle=0})
wait(7*24*60)
gz1 = pile{{"cobalt blue",1},{"raw umber",0.08}, medium=0.75}
gz2 = pile{{"cobalt blue",1},{"Prussian blue",0.04},{"raw umber",0.06}, medium=0.8}
clear = pile{{"lead white",0.3},{"cobalt blue",0.05}, medium=0.95}
local function wt(y0, y1) return function(x,y) return clamp(1-(y-y0)/(y1-y0),0,1) end end
local function wc(y0, y1) return function(x,y) return clamp((y-y0)/(y1-y0),0,1)+0.02 end end
work(rect(0,0,480,300), {hand="glaze", piles={{gz1, wt(0,260)},{clear, wc(0,260)}}, coverage=1, angle=0, seed=1})
work(rect(520,0,480,300), {hand="glaze", piles={{gz2, wt(0,260)},{clear, wc(0,260)}}, coverage=1, angle=0, seed=2})

--@ chunk 3
blend(rect(0,0,480,300), {angle=0, seed=5})
blend(rect(520,0,480,300), {angle=0.2, seed=6})
blend(rect(520,0,480,300), {angle=-0.2, seed=7})
