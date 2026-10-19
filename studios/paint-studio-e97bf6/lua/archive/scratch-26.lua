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
sDeep = pile{{"lead white",0.6},{"cobalt blue",1},{"Prussian blue",0.12},{"raw umber",0.4}}
sDeepG = pile{{"lead white",0.7},{"cobalt blue",0.8},{"Prussian blue",0.12},{"green earth",0.4},{"raw umber",0.25}}
for i=0,2 do
  work(poly({{60+i*300,420},{60+i*300,60},{140+i*300,60},{140+i*300,420}}), {hand="body", piles={{sDeep,1},{sDeepG,0.5}}, clip=true, coverage=2, fill=true, angle=1.5, tool="filbert 4"})
end
wait(8*24*60)
turq = pile{{"Prussian blue",0.25},{"cobalt blue",0.6},{"green earth",0.6}, medium=0.75}
turq2 = pile{{"Prussian blue",0.15},{"green earth",0.8},{"lead white",0.15}, medium=0.7}
clr = pile{{"lead white",0.2},{"cobalt blue",0.05}, medium=0.95}
local function wt(x,y) return clamp(1-(y-60)/220,0,1) end
local function wc(x,y) return clamp((y-60)/220,0,1)+0.02 end
work(rect(60,60,80,360), {hand="glaze", piles={{turq,wt},{clr,wc}}, coverage=1, clip=true, angle=1.5, seed=1})
work(rect(360,60,80,360), {hand="glaze", piles={{turq2,wt},{clr,wc}}, coverage=1, clip=true, angle=1.5, seed=2})
