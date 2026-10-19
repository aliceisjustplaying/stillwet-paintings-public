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
wD = pile{{"bone black",1},{"Prussian blue",0.35},{"raw umber",0.4},{"lead white",0.7},{"green earth",0.3}}
fs1 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.45},{"rose madder",0.06},{"raw umber",0.06}}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}}
work(rect(20,20,600,100), {hand="body", pile=wD, clip=true, coverage=2, fill=true, angle=0})
wait(5*24*60)
work(rect(40,10,140,120), {hand="broad", pile=fs1, clip=true, coverage=1.6, fill=true, angle=0.04})
work(rect(200,10,140,120), {hand="broad", pile=pl2, clip=true, coverage=1.6, fill=true, angle=0.04})
work(rect(360,10,140,120), {hand="broad", pile=pl2, clip=true, coverage=2.5, fill=true, angle=0.04})
work(rect(360,10,140,120), {hand="body", pile=pl2, clip=true, coverage=1.5, fill=true, angle=0.3})
