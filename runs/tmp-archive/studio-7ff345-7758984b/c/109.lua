-- a hard-edged box has shown up round the oak's foot (an old passage's edges, sharpened by the glazes).
-- bury it under a broader drift: lit along its crest, cool on its face, lost at its edges
driftShade = pile{{"lead white",3},{"smalt",1.4},{"pale smalt",1},{"Prussian blue",0.05},{"bone black",0.15},{"red earth",0.06}, medium=0.3}
driftLit = pile{{"lead white",5},{"pale smalt",0.8},{"yellow ochre",0.08},{"vermilion",0.03}, medium=0.2}
local mound = poly({{140, 482}, {150, 462}, {178, 448}, {205, 444}, {290, 444}, {330, 452}, {350, 466}, {345, 484}, {300, 490}, {220, 489}}, true):roughen(2, 12, 1091)
local face = mound - oakLive:grow(0.5) - fallenM:grow(2)
work(face, {hand="body", pile=driftShade, load=0.6, pressure={0.4, 0.6}, coverage=2.2, angle=0.05, angle_jitter=0.2, edge={soft=0.5, lost=0.5, period=30, seed=1092}})
local crest = mound * below(function(x) return 446 + 0.0003 * (x - 240)^2 end) * above(function(x) return 455 + 0.0006 * (x - 240)^2 end) - oakLive:grow(0.5)
work(crest:soften(1.5), {hand="body", tool="filbert 4", pile=driftLit, load=0.5, pressure={0.35, 0.5}, coverage=1.5, angle=0, edge="soft"})
blend(mound:grow(4) - oakLive:grow(0.5) - fallenM:grow(2), {angle=0.02})
