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
k2 = pile{{"lead white",2.2},{"cobalt blue",1},{"Prussian blue",0.04}}
k3 = pile{{"lead white",5},{"cobalt blue",1},{"Prussian blue",0.02}}
k4 = pile{{"lead white",8},{"Naples yellow",0.35},{"cobalt blue",0.15}}
k5 = pile{{"lead white",8},{"Naples yellow",0.5},{"rose madder",0.08}}
local function band(c, w) return function(x,y) local t=y/horizon; return math.max(0, 1-math.abs(t-c)/w) end end
work(rect(0,100,1000,340), {hand="body", piles={{k2, band(0.3,0.38)},{k3, band(0.62,0.38)},{k4, band(1,0.4)},{k5, function(x,y) return band(1,0.38)(x,y)*clamp(1-x/700,0,1) end}}, clip=true, coverage=2, fill=true, angle=0})
blend(rect(0,100,1000,340), {angle=0})
wait(8*24*60)
ga = pile{{"cobalt blue",1},{"rose madder",0.3}, medium=0.8}
gb = pile{{"cobalt blue",1},{"rose madder",0.25},{"smalt",0.5}, medium=0.7}
gc = pile{{"cobalt blue",1},{"raw umber",0.1}, medium=0.8}
clr = pile{{"lead white",0.3},{"cobalt blue",0.05}, medium=0.95}
local function wg(x,y) return clamp((y-180)/120,0,1) * clamp(1-(y-380)/60,0,1) end
local function wc(x,y) return 1 - wg(x,y) + 0.02 end
work(rect(0,150,320,290), {hand="glaze", piles={{ga,wg},{clr,wc}}, coverage=1, angle=0, clip=true, seed=1})
work(rect(340,150,320,290), {hand="glaze", piles={{gb,wg},{clr,wc}}, coverage=1, angle=0, clip=true, seed=2})
work(rect(680,150,320,290), {hand="glaze", piles={{gc,wg},{clr,wc}}, coverage=1, angle=0, clip=true, seed=3})
blend(rect(0,150,1000,290), {angle=0.2})
blend(rect(0,150,1000,290), {angle=-0.2})
blend(rect(0,150,1000,290), {angle=0})
