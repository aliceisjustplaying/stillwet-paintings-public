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
iL1 = pile{{"lead white",6},{"Naples yellow",0.14}}
iS1 = pile{{"lead white",2},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.15}}
iSw = pile{{"lead white",2.5},{"cobalt blue",0.55},{"smalt",0.4},{"Naples yellow",0.2},{"rose madder",0.05}}
pM = pile{{"lead white",6},{"Naples yellow",0.18},{"cobalt blue",0.03}}
work(rect(20,20,600,150), {hand="body", piles={{iS1,1},{iSw,1}}, clip=true, coverage=2, fill=true})
work(rect(20,200,600,150), {hand="body", pile=iL1, clip=true, coverage=2, fill=true})
work(rect(20,380,600,150), {hand="broad", pile=pM, clip=true, coverage=2, fill=true, angle=0})
wait(3*24*60)
g1 = pile{{"cobalt blue",1},{"rose madder",0.1}, medium=0.8}
g2 = pile{{"cobalt blue",1},{"smalt",1},{"raw umber",0.1}, medium=0.75}
g3 = pile{{"Prussian blue",0.3},{"cobalt blue",1},{"raw umber",0.15}, medium=0.8}
g4 = pile{{"smalt",1},{"cobalt blue",0.3},{"lead white",0.3}, medium=0.7}
local gs = {g1,g2,g3,g4}
for i,g in ipairs(gs) do
  for r=0,2 do
    work(rect(20+(i-1)*150, 20+r*180, 130, 150), {hand="glaze", pile=g, coverage=1, seed=i*10+r})
  end
end

--@ chunk 3
c = {
 pile{{"lead white",1.2},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.15}},
 pile{{"lead white",1},{"cobalt blue",0.8},{"smalt",0.5},{"rose madder",0.1},{"raw umber",0.2}},
 pile{{"lead white",1},{"cobalt blue",0.7},{"Prussian blue",0.06},{"green earth",0.3},{"raw umber",0.15}},
 pile{{"lead white",0.6},{"cobalt blue",1},{"Prussian blue",0.15},{"raw umber",0.4}},
 pile{{"lead white",1.6},{"cobalt blue",0.8},{"smalt",0.5},{"Naples yellow",0.15},{"rose madder",0.08},{"raw umber",0.1}},
 pile{{"lead white",0.8},{"cobalt blue",0.9},{"smalt",0.5},{"rose madder",0.15},{"raw umber",0.1}},
}
for i,p in ipairs(c) do work(rect(650+((i-1)%2)*170, 20+((i-1)//2)*180, 150, 150), {hand="body", pile=p, clip=true, coverage=2, fill=true, seed=50+i}) end
