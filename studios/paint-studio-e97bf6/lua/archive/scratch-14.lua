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
litW = pile{{"lead white",6},{"Naples yellow",0.14}}
work(rect(20,20,960,200), {hand="body", pile=litW, clip=true, coverage=2, fill=true, angle=0})
wait(5*24*60)
print(drying(500,100))
csA = pile{{"cobalt blue",1},{"smalt",0.5},{"rose madder",0.05}, medium=0.7}
csB = pile{{"cobalt blue",1},{"smalt",0.6},{"rose madder",0.08},{"raw umber",0.08}, medium=0.55}
sC2 = pile{{"lead white",1.6},{"cobalt blue",0.8},{"smalt",0.5},{"Naples yellow",0.15},{"rose madder",0.08},{"raw umber",0.1}}
mB = pile{{"lead white",2.5},{"cobalt blue",0.5},{"smalt",0.3},{"Naples yellow",0.2},{"rose madder",0.05}}
csC = pile{{"lead white",2},{"cobalt blue",0.65},{"smalt",0.4},{"Naples yellow",0.15},{"rose madder",0.06},{"raw umber",0.05}}
csD = pile{{"lead white",2},{"cobalt blue",0.65},{"smalt",0.4},{"Naples yellow",0.15},{"rose madder",0.06},{"raw umber",0.05}, thinner=0.5}
work(poly({{40,40},{180,40},{120,200},{40,200}}), {hand="glaze", pile=csA, coverage=1, clip=true, seed=1})
work(poly({{240,40},{380,40},{320,200},{240,200}}), {hand="glaze", pile=csB, coverage=1, clip=true, seed=2})
work(poly({{440,40},{580,40},{520,200},{440,200}}), {hand="body", pile=csC, coverage=2, fill=true, clip=true, tool="filbert 4", seed=3})
work(poly({{640,40},{780,40},{720,200},{640,200}}), {hand="body", pile=csD, coverage=2, fill=true, clip=true, tool="filbert 4", seed=4})
work(poly({{820,40},{960,40},{900,200},{820,200}}), {hand="glaze", pile=csA, coverage=1, clip=true, seed=5})
work(poly({{820,40},{960,40},{900,200},{820,200}}), {hand="glaze", pile=csA, coverage=1, clip=true, seed=6})

--@ chunk 3
csB2 = pile{{"cobalt blue",1},{"smalt",0.6},{"rose madder",0.1},{"raw umber",0.1}, medium=0.4}
work(poly({{40,260},{180,260},{120,420},{40,420}}), {hand="glaze", pile=csB, coverage=1, clip=true, seed=11})
work(poly({{40,260},{180,260},{120,420},{40,420}}), {hand="glaze", pile=csB, coverage=1, clip=true, seed=12})
work(poly({{240,260},{380,260},{320,420},{240,420}}), {hand="glaze", pile=csB2, coverage=1, clip=true, seed=13})
work(poly({{440,260},{580,260},{520,420},{440,420}}), {hand="body", pile=csB2, coverage=1.5, fill=true, clip=true, tool="filbert 5", seed=14})
work(rect(20,240,960,200), {hand="body", pile=litW, clip=true, coverage=0.001, fill=false})
