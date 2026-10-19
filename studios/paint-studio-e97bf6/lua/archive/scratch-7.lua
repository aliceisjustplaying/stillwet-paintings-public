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
uS = pile{{"lead white",1},{"cobalt blue",1},{"smalt",0.6},{"raw umber",0.3}, turps=0.5}
uM = pile{{"lead white",3},{"cobalt blue",0.5},{"smalt",0.5},{"raw umber",0.1}, turps=0.5}
uH = pile{{"raw umber",2},{"bone black",0.5},{"red earth",0.3}, turps=0.5}
uW = pile{{"Prussian blue",1},{"bone black",1},{"raw umber",0.3}, turps=0.5}
uP = pile{{"lead white",3},{"cobalt blue",0.4},{"smalt",0.3}, turps=0.6}
local ps = {uS,uM,uH,uW,uP}
for i,p in ipairs(ps) do work(rect(20+(i-1)*120, 20, 100, 150), {hand="body", pile=p, clip=true, coverage=1.5, fill=true}) end
