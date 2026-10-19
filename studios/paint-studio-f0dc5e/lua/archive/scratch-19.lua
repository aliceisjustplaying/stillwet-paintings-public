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
land_dark = pile{{"raw umber", 1}, {"Prussian blue", 0.25}, {"bone black", 0.3}, {"red earth", 0.25}, {"lead white", 0.15}, name="land_dark"}
work(rect(0, 600, 300, 149), {hand="body", pile=land_dark, coverage=2.5, load=0.7, clip=true})
sig = pile{{"red earth", 1}, {"yellow ochre", 0.3}, {"lead white", 0.5}, medium=0.15, name="sig"}
local rg = brush{kind="rigger", width=1.6, point=1}
rg:load(sig, 0.6)
-- "C" open curve
rg:gesture({{40, 727, 0.3}, {33, 725, 0.5}, {28, 731, 0.6}, {30, 739, 0.55}, {38, 741, 0.3}})
rg:load(sig, 0.5)
-- small dot, then a short flourish underline
rg:touch(45, 740, {pressure=0.4})
rg:load(sig, 0.5)
rg:gesture({{27, 745, 0.15}, {40, 744.5, 0.4}, {56, 744, 0.05}})
