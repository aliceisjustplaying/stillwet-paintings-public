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
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
birch = pile{{"lead white",8},{"yellow ochre",0.25},{"chrome yellow",0.05}, name="birch"}
work(rect(0,0,1000,600), {hand="broad", coverage=3, fill=true, angle=0.3, piles={{amber, 0.5},{deeprust, 1}}})
for i, x in ipairs({100, 300, 500, 700, 900}) do
  work(rect(x - 20, 50, 40, 500), {hand="body", pile=birch, tool={kind="flat", width=8}, angle=-math.pi/2, length={30,60}, coverage=3, fill=true, clip=true})
end
wait(28 * 24 * 60)
print(drying(100, 300), drying(200, 300))

--@ chunk 3
g1 = pile{{"raw umber",1},{"smalt",0.6}, medium=0.8, name="g1"}
g2 = pile{{"raw umber",1},{"smalt",0.6}, medium=0.9, name="g2"}
g3 = pile{{"raw umber",1},{"red earth",0.3},{"green earth",0.6}, medium=0.85, name="g3"}
g4 = pile{{"lead white",1},{"raw umber",0.6},{"smalt",0.6},{"yellow ochre",0.2}, medium=0.75, name="g4"}
-- glaze the right 70% of each trunk (keeping a left rim)
local glz = {g1, g2, g3, g4}
for i, x in ipairs({100, 300, 500, 700}) do
  work(rect(x - 12, 60, 34, 480), {hand="glaze", pile=glz[i], coverage=1})
end
-- column 5: g2 twice
work(rect(900 - 12, 60, 34, 480), {hand="glaze", pile=g2, coverage=1})

--@ chunk 4
h1 = pile{{"raw umber",1},{"smalt",0.6}, medium=0.6, name="h1"}
h2 = pile{{"raw umber",1},{"smalt",0.6}, medium=0.45, name="h2"}
h3 = pile{{"raw umber",1},{"smalt",0.5},{"yellow ochre",0.3}, medium=0.6, name="h3"}
work(rect(100 - 12, 60, 34, 230), {hand="glaze", pile=h1, coverage=1})
work(rect(300 - 12, 60, 34, 230), {hand="glaze", pile=h2, coverage=1})
work(rect(500 - 12, 60, 34, 230), {hand="glaze", pile=h3, coverage=1})
work(rect(500 - 12, 60, 34, 230), {hand="glaze", pile=h3, coverage=1})
-- scumble over dark: thinned haze
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
hazeT = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, thinner=0.5, name="hazeT"}
work(rect(620, 300, 140, 250), {hand="scumble", pile=hazeT, coverage=0.8})
work(rect(620, 300, 140, 250), {hand="scumble", pile=hazeT, coverage=0.8})
work(rect(800, 300, 140, 250), {hand="glaze", pile=pile{{"lead white",4},{"yellow ochre",1},{"smalt",0.6}, medium=0.7, name="hazeG"}, coverage=1})

--@ chunk 5
work(rect(100 - 8, 300, 30, 240), {hand="glaze", pile=h1, coverage=1, angle=-math.pi/2})
work(rect(300 - 8, 300, 30, 240), {hand="glaze", pile=h1, coverage=1, angle=-math.pi/2, tool={kind="filbert", width=12, stiffness=0.3}})
blend(rect(300 - 8, 300, 30, 240):soften(3), {angle=-math.pi/2})
