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
k1 = pile{{"lead white",1.2},{"cobalt blue",1.2},{"Prussian blue",0.08}}
sC1 = pile{{"lead white",1},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.2}}
mA = pile{{"lead white",2},{"cobalt blue",0.6},{"smalt",0.4},{"Naples yellow",0.1},{"raw umber",0.08}}
work(rect(20,20,960,120), {hand="body", pile=k1, clip=true, coverage=2, fill=true, angle=0})
work(rect(20,180,960,120), {hand="body", pile=sC1, clip=true, coverage=2, fill=true, angle=0})
work(rect(20,340,960,120), {hand="body", pile=mA, clip=true, coverage=2, fill=true, angle=0})
wait(6*24*60)
print(drying(500,80), drying(500,240), drying(500,400))
g = {
 pile{{"cobalt blue",1},{"Prussian blue",0.05}, medium=0.6},
 pile{{"cobalt blue",1},{"Prussian blue",0.05}, medium=0.4},
 pile{{"cobalt blue",1},{"raw umber",0.2},{"smalt",0.5}, medium=0.6},
 pile{{"cobalt blue",1},{"raw umber",0.3},{"rose madder",0.15}, medium=0.5},
 pile{{"cobalt blue",1},{"lead white",0.4},{"Prussian blue",0.05}, medium=0.5},
}
for i,p in ipairs(g) do
  work(rect(30+(i-1)*190, 10, 150, 470), {hand="glaze", pile=p, coverage=1, angle=1.57, seed=i})
end
