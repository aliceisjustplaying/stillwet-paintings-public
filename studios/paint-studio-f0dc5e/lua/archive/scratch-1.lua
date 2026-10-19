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
lw = pile{{"lead white", 1}, medium=0.45, name="liquid_white"}
print(lw)
-- liquid white over left half
work(rect(0, 0, 500, 749), {hand="broad", pile=lw, coverage=1.5, load=0.5, angle=0})
print(drying(250, 300))

--@ chunk 3
sky_deep = pile{{"Prussian blue", 1}, {"raw umber", 0.25}, {"lead white", 1.2}, name="sky_deep"}
glow = pile{{"vermilion", 1}, {"chrome yellow", 1.5}, {"lead white", 3}, name="glow"}
-- crisscross top band on both halves
local top = rect(0, 0, 1000, 200)
work(top, {hand="broad", pile=sky_deep, coverage=1.0, load=0.35, angle=0.75, length={60,120}})
work(top, {hand="broad", pile=sky_deep, coverage=1.0, load=0.35, angle=-0.75, length={60,120}})
local low = rect(0, 260, 1000, 140)
work(low, {hand="broad", pile=glow, coverage=1.0, load=0.35, angle=0.75, length={60,120}})
work(low, {hand="broad", pile=glow, coverage=1.0, load=0.35, angle=-0.75, length={60,120}})

--@ chunk 4
blend(rect(0, 0, 1000, 220), {angle=0})
blend(rect(0, 240, 1000, 180), {angle=0})
