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
iL1 = pile{{"lead white",6},{"Naples yellow",0.25}}
iL2 = pile{{"lead white",6},{"Naples yellow",0.1},{"cobalt blue",0.08}}
iM1 = pile{{"lead white",4},{"cobalt blue",0.35},{"smalt",0.4},{"rose madder",0.05},{"raw umber",0.06}}
iS1 = pile{{"lead white",2},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.15}}
iS2 = pile{{"lead white",1},{"cobalt blue",0.8},{"Prussian blue",0.15},{"green earth",0.3},{"raw umber",0.2}}
uS = pile{{"lead white",1},{"cobalt blue",1},{"smalt",0.6},{"raw umber",0.3}, turps=0.5}
uM = pile{{"lead white",3},{"cobalt blue",0.5},{"smalt",0.5},{"raw umber",0.1}, turps=0.5}
-- underpaint like the painting
local A = poly({{60,400},{90,150},{120,60},{140,70},{150,400}})
local Ae = poly({{140,70},{152,82},{172,170},{200,405},{150,400}})
local Cm = poly({{230,400},{260,120},{380,300},{340,420}})
work(Ae, {hand="body", pile=uS, clip=true, coverage=1.3, fill=true})
work(Cm, {hand="body", pile=uS, clip=true, coverage=1.3, fill=true})
wait(24*60)
-- body
work(A, {hand="body", piles={{iL1, function(x,y) return 1-(y-60)/340 end},{iL2, function(x,y) return (y-60)/340 end}}, clip=true, coverage=2, fill=true, angle=-1.35, tool="filbert 6"})
work(Ae, {hand="body", piles={{iS2, function(x,y) return 1-(y-70)/335 end},{iS1, function(x,y) return (y-70)/335 end}}, clip=true, coverage=2, fill=true, angle=-1.4, tool="filbert 4"})
work(Cm, {hand="body", piles={{iS1, function(x,y) return 1-(y-120)/300 end},{iM1, function(x,y) return (y-120)/300 end}}, clip=true, coverage=2, fill=true, angle=0.9, tool="filbert 7"})
