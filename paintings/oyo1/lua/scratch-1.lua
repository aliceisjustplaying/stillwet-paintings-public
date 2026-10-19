-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 0.35}}, texture=0.35, um=90}}, linen={18, 16}, seed=7, size=900}

--@ chunk 2
gold = pile{{"yellow ochre",3},{"lead-tin yellow",2},{"Naples yellow",1},{"cadmium yellow",1},{"burnt sienna",0.3},{"lead white",0.6}, name="gold"}
shad = pile{{"raw umber",2.2},{"yellow ochre",1.6},{"ultramarine blue",0.7},{"cobalt violet",0.4},{"lead white",0.5}, name="shad"}
lit = pile{{"Naples yellow",2.5},{"lead-tin yellow",2},{"cadmium yellow",0.7},{"yellow ochre",1},{"lead white",0.5}, name="lit"}
work(rect(0,300,1000,441), {hand="broad", pile=gold, angle=-0.18, coverage=1.4, fill=true})
print(wait(5*24*60)); print(drying(500,500))

--@ chunk 3
-- shadow glaze pile, transparent
shad_glaze = pile{{"raw umber",2},{"ultramarine blue",0.8},{"yellow ochre",0.8}, medium=0.5, name="shad_glaze"}
midgold = pile{{"yellow ochre",3},{"Naples yellow",1.5},{"lead-tin yellow",1},{"burnt sienna",0.4}, name="midgold"}

-- Variant A at x~250: WIDER cones (w~44 h~40), lower contrast: shadow face midgold+shad, lit face midgold+lit
work(ellipse(218,505,52,8), {hand="glaze", pile=shad_glaze, coverage=0.7, edge="lost"})
work(poly({{232,506},{250,466},{254,506}}, true), {hand="detail", coverage=1.6, fill=true, tool="filbert 5",
 piles={{midgold,0.7},{shad,0.6}}})
work(poly({{250,466},{254,506},{278,506},{262,470}}, true), {hand="detail", coverage=1.6, fill=true, tool="filbert 5",
 piles={{midgold,0.8},{lit,0.5}}})

-- Variant B at x~520: sheaf of gesture strokes fanning from apex, filbert 7 blunt
work(ellipse(488,505,52,8), {hand="glaze", pile=shad_glaze, coverage=0.7, edge="lost"})
b = brush("filbert", 7)
b:load(midgold, 0.9)
b:gesture({{522,468,0.25},{512,488,0.7},{504,506,0.55}})
b:gesture({{523,467,0.25},{520,488,0.75},{517,507,0.55}})
b:reload(lit, 0.85)
b:gesture({{524,467,0.25},{530,487,0.75},{534,507,0.55}})
b:gesture({{525,468,0.2},{538,486,0.7},{546,505,0.5}})
b:reload(shad, 0.7)
b:gesture({{521,469,0.2},{508,486,0.6},{500,503,0.45}})

-- Variant C at x~780: two leaning sheaves = inverted V pair of touches/short strokes, body hand in two narrow ribbons
work(ellipse(748,505,52,8), {hand="glaze", pile=shad_glaze, coverage=0.7, edge="lost"})
work(ribbon({{782,468},{768,488},{760,506}}, {7,11,14}), {hand="body", coverage=1.3, fill=true, tool="filbert 6", angle=2.75,
 piles={{midgold,0.7},{shad,0.5}}})
work(ribbon({{784,468},{796,488},{804,506}}, {7,11,14}), {hand="body", coverage=1.3, fill=true, tool="filbert 6", angle=0.4,
 piles={{midgold,0.8},{lit,0.5}}})
print("variants done")
