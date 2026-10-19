-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
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
canvas{aspect=1.3347921225382933, ground={{apply="knife", pile={{"lead white", 6}, {"yellow ochre", 0.05}}, texture=0.25, um=70}, {apply="roller", pile={{"lead white", 1}}, um=35}}, linen={17, 15}, seed=2417, size=610}

--@ chunk 2
local a = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 1.8}, medium=0.15, name="a"}
local b = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 2.4}, medium=0.15, name="b"}
local c = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 3.0}, medium=0.15, name="c"}
work(rect(50, 50, 200, 200), {hand="body", pile=a, coverage=2, load=0.6, clip=true})
work(rect(300, 50, 200, 200), {hand="body", pile=b, coverage=2, load=0.6, clip=true})
work(rect(550, 50, 200, 200), {hand="body", pile=c, coverage=2, load=0.6, clip=true})

--@ chunk 3
local d = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 0.8}, name="d"}
local e = pile{{"cobalt blue", 1}, {"Prussian blue", 0.3}, {"vermilion", 0.08}, {"lead white", 1.2}, name="e"}
work(rect(50, 300, 200, 200), {hand="body", pile=d, coverage=2.5, load=0.7, clip=true})
work(rect(300, 300, 200, 200), {hand="body", pile=e, coverage=2.5, load=0.7, clip=true})
