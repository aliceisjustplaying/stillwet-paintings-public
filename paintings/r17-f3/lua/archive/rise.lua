local RISE = LAND * mask(function(x,y) return (y < 486 and x < 380) and 1 or 0 end) - MILL:grow(0.5)
local r1 = pile{{"lead white",3},{"green earth",1.5},{"yellow ochre",0.9},{"pale smalt",0.5},{"raw umber",0.12}, medium=0.1}
local r2 = pile{{"lead white",2},{"green earth",1.5},{"yellow ochre",0.8},{"pale smalt",0.6},{"raw umber",0.25}, medium=0.1}
local r3 = pile{{"lead white",4},{"yellow ochre",1.2},{"green earth",0.8},{"chrome yellow",0.15}, medium=0.1}
work(RISE, {hand="hatch", pile=r1, tool={kind="round", width=1.2, point=0.7}, angle=0, angle_jitter=0.1, length={4,12}, coverage=1.6, clip=true, seed=41})
local shade = RISE * mask(function(x,y) return smoothstep(470, 484, y) end)
work(shade, {hand="hatch", pile=r2, tool={kind="round", width=1.1, point=0.7}, angle=0, angle_jitter=0.1, length={4,10}, coverage=1.2, clip=true, seed=42, threshold=0.4})
local crest = RISE * mask(function(x,y) return 1 - smoothstep(0, 8, y - hzc(x)) end)
work(crest, {hand="hatch", pile=r3, tool={kind="round", width=1.0, point=0.7}, angle=0, angle_jitter=0.1, length={3,9}, coverage=1.2, clip=true, seed=43, threshold=0.4})
-- a hedge running down the slope
local hedge = pile{{"green earth",1.5},{"raw umber",0.5},{"pale smalt",0.8},{"lead white",1.2}, medium=0.1}
local hb = ribbon({{250,461},{275,467},{300,474},{322,480},{345,485}}, {2.2,2.5,2.8,3,3.2}):roughen(1,4,51)
stipple(hb * above(function(x) return hzc(x) - 3 end), {pile=hedge, width=1.4, coverage=3, pressure={0.5,0.8}, cluster=0.4})
-- a farmstead near the mill
local wall = pile{{"lead white",3},{"yellow ochre",0.6},{"raw umber",0.2},{"pale smalt",0.3}, medium=0.08}
local roof = pile{{"red earth",1},{"raw umber",0.7},{"lead white",1.2},{"pale smalt",0.4}, medium=0.08}
local treeF = pile{{"green earth",1.5},{"raw umber",0.4},{"pale smalt",0.9},{"lead white",1.3}, medium=0.08}
local trees = (ellipse(92,452,11,8) + ellipse(106,449,9,9) + ellipse(80,455,8,6)):roughen(1.5,5,52)
stipple(trees, {pile=treeF, width=1.5, coverage=3, pressure={0.5,0.8}, cluster=0.4})
local w1 = poly{{90,462},{90,455},{112,455},{112,462}}
local r1m = poly{{88,455.5},{94,449.5},{108,449.5},{114,455.5}}
work(r1m, {hand="detail", pile=roof, tool={kind="round", width=1, point=0.5}, angle=0, length={2,5}, coverage=3, clip=true, fill=true, edge="found"})
work(w1, {hand="detail", pile=wall, tool={kind="round", width=1, point=0.5}, angle=math.pi/2, length={2,5}, coverage=3, clip=true, fill=true, edge="found"})
local dk = pile{{"raw umber",1},{"bone black",0.3},{"lead white",0.8}, medium=0.08}
local r = brush{kind="round", width=0.8, point=0.6}
r:load(dk, 0.4)
r:touch(96, 459, {pressure=0.5}); r:touch(104, 459, {pressure=0.5}); r:touch(100.5, 460, {pressure=0.5})
print(wait(0))
