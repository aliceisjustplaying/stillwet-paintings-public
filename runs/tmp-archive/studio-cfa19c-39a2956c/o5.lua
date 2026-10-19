print(wait(60*6))
local nz = noise{seed=2041, octaves=3, period=6}
-- leaf sprays reaching into the openings from their rims, so they read as gaps in foliage, not holes
local inner = (oakHoles:grow(1) - oakHoles:shrink(5)) * mask(function(x,y) return clamp(0.5 + 1.2*nz(x,y), 0, 1) end)
stipple(inner, {pile=fd, width=2.2, coverage=0.9, pressure={0.3,0.7}, drag={1.4,-1.1}, twist=0.7, cluster={0.7,3}, feather=0.6, seed=2042})
-- small scattered leaves on the outer edge, reaching out into the sky
local nz2 = noise{seed=2043, octaves=3, period=8}
local out = (oakNew:grow(9) - oakNew:grow(1)) * mask(function(x,y) return clamp(1.4*nz2(x,y), 0, 1) end) - oakFork
stipple(out, {pile=fd, width=2.2, coverage=0.5, pressure={0.3,0.7}, drag={1.4,-1.1}, twist=0.7, cluster={0.75,4}, feather=0.7, seed=2044})
-- a dead limb breaking out of the crown at the upper right, grey and bare
local dead = pile{{"raw umber",1.5},{"lead white",1.2},{"bone black",0.3},{"yellow ochre",0.3}, medium=0.05}
local b = brush{kind="round", width=2.6, point=0.6}
b:load(dead, 0.8)
b:stroke({{322,168},{334,150},{343,132},{356,116},{366,104}}, {pressure={0.8,0.25}, ramps={0.05,0.4}, shake=0.6})
b:load(dead, 0.6)
b:stroke({{343,132},{334,118},{331,104}}, {pressure={0.55,0.1}, ramps={0.05,0.5}, shake=0.6})
b:stroke({{356,116},{368,114},{378,106}}, {pressure={0.5,0.1}, ramps={0.05,0.5}, shake=0.6})
b:stroke({{366,104},{366,94},{370,88}}, {pressure={0.4,0.05}, ramps={0.05,0.5}, shake=0.6})
b:stroke({{334,150},{346,146},{352,140}}, {pressure={0.4,0.05}, ramps={0.05,0.5}, shake=0.6})
-- a thin dark underside to the dead limb
local dk = pile{{"raw umber",1.5},{"bone black",0.5}, medium=0.05}
local r = brush{kind="rigger", width=1.0, point=1}
r:load(dk, 0.5)
r:stroke({{325,170},{337,152},{346,134},{358,118},{367,106}}, {pressure={0.45,0.1}, shake=0.4})
