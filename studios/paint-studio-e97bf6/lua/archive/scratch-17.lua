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
fs1 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.45},{"rose madder",0.06},{"raw umber",0.06}}
fsDeep = pile{{"lead white",1.7},{"cobalt blue",0.65},{"smalt",0.45},{"rose madder",0.08},{"raw umber",0.14}}
work(rect(20,500,960,180), {hand="broad", piles={{fs1,1},{fsDeep,1}}, clip=true, coverage=2, fill=true, angle=0.04})
wait(6*24*60)
ga = pile{{"cobalt blue",1},{"rose madder",0.25},{"raw umber",0.25}, medium=0.55}
gb = pile{{"cobalt blue",0.6},{"rose madder",0.3},{"raw umber",0.5}, medium=0.6}
gc = pile{{"cobalt blue",1},{"rose madder",0.2},{"raw umber",0.3},{"smalt",0.5}, medium=0.45}
work(rect(40,490,250,200), {hand="glaze", pile=ga, coverage=1, angle=0.05, seed=1})
work(rect(360,490,250,200), {hand="glaze", pile=gb, coverage=1, angle=0.05, seed=2})
work(rect(680,490,250,200), {hand="glaze", pile=gc, coverage=1, angle=0.05, seed=3})

--@ chunk 3
fg1 = pile{{"lead white",1.6},{"cobalt blue",0.6},{"smalt",0.4},{"raw umber",0.22},{"Naples yellow",0.12},{"rose madder",0.04}}
fg2 = pile{{"lead white",1.2},{"cobalt blue",0.55},{"smalt",0.4},{"raw umber",0.3},{"red earth",0.05},{"Naples yellow",0.1}}
fg3 = pile{{"lead white",1},{"cobalt blue",0.5},{"smalt",0.35},{"raw umber",0.4},{"red earth",0.06},{"yellow ochre",0.1}}
work(rect(20,300,300,150), {hand="body", pile=fg1, clip=true, coverage=2, fill=true, angle=0})
work(rect(340,300,300,150), {hand="body", pile=fg2, clip=true, coverage=2, fill=true, angle=0})
work(rect(660,300,300,150), {hand="body", pile=fg3, clip=true, coverage=2, fill=true, angle=0})
