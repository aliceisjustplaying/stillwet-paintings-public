local nn = noise{seed=83, period=25, octaves=2}
local FARB = LAND * mask(function(x,y) return y < 500 and 1 or 0 end) - MILL:grow(0.5) - TOWN:grow(0.5) - FARTREES - RIVER:grow(0.5) - poly{{88,462},{88,449},{114,449},{114,462}} - CROWNS_ALL:grow(0.5) - TRUNKS
local g2 = pile{{"lead white",1.3},{"green earth",2},{"yellow ochre",0.6},{"pale smalt",0.8},{"raw umber",0.25}, medium=0.1}
local g3 = pile{{"lead white",2.2},{"green earth",1.6},{"yellow ochre",0.6},{"pale smalt",0.9},{"raw umber",0.12}, medium=0.1}
local left = FARB * mask(function(x,y) return 1 - smoothstep(340, 470, x + 40*nn(x,y)) end)
local right = FARB * mask(function(x,y) return smoothstep(340, 470, x + 40*nn(x,y)) end)
work(left, {hand="hatch", pile=g2, tool={kind="round", width=1.2, point=0.7}, angle=0.03, angle_jitter=0.1, length={4,12}, coverage=0.9, clip=true, seed=71, threshold=0.5, load=0.6})
work(right, {hand="hatch", pile=g3, tool={kind="round", width=1.2, point=0.7}, angle=0, angle_jitter=0.1, length={4,14}, coverage=1.3, clip=true, seed=72, threshold=0.5, load=0.6})
print(wait(0))
