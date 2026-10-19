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
pl1 = pile{{"lead white",6},{"cobalt blue",0.9},{"rose madder",0.1},{"Naples yellow",0.15},{"raw umber",0.08}}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}}
pl3 = pile{{"lead white",6},{"cobalt blue",0.55},{"Naples yellow",0.45},{"raw umber",0.08}}
work(rect(400,500,150,90), {hand="broad", pile=pl1, clip=true, coverage=1.6, fill=true, angle=0})
work(rect(560,500,150,90), {hand="broad", pile=pl2, clip=true, coverage=1.6, fill=true, angle=0})
work(rect(720,500,150,90), {hand="broad", pile=pl3, clip=true, coverage=1.6, fill=true, angle=0})
