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
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}}
fs1 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.45},{"rose madder",0.06},{"raw umber",0.06}}
edge = {{0,500},{200,503},{206,507},{400,511},{406,515},{600,519},{606,523},{1000,530}}
work(above(edge) * below(function(x) return 440 end), {hand="broad", pile=pl2, clip=true, coverage=2.5, fill=true, angle=0})
work(below(edge) * above(function(x) return 600 end), {hand="broad", pile=fs1, clip=true, coverage=2.5, fill=true, angle=0})
wait(6*24*60)
mid = mix{{pl2,0.5},{fs1,0.5}}
-- A: lose with mid pile into shadow
lose(below(edge) * rect(0,440,330,160), {pile=mid, where=1, reach={4,6}, load=0.25, pressure={0.35,0.05}, tool="filbert 4"})
-- B: thin ribbon of mid along the edge with detail hand, edge soft
local rib = ribbon({{340,509},{400,511},{406,515},{600,519},{606,523},{660,524}}, 4)
work(rib, {hand="detail", pile=mid, clip=true, coverage=2, fill=true, angle=0, tool={kind="filbert", width=2}})
-- C: lose from the shadow side outward into the light with shadow pile
lose(above(edge) * rect(670,440,330,160), {pile=fs1, where=1, reach={4,4}, load=0.2, pressure={0.3,0.05}, tool="filbert 3"})
