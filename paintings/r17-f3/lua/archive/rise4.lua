local nn = noise{seed=91, period=30, octaves=2}
FARB = LAND * mask(function(x,y) return y < 502 and 1 or 0 end) - MILL:grow(0.5) - TOWN:grow(0.5) - FARTREES - RIVER:grow(0.3) - poly{{88,462},{88,449},{114,449},{114,462}} - CROWNS_ALL:grow(0.5) - TRUNKS
local farG = pile{{"lead white",1.6},{"green earth",2},{"yellow ochre",0.7},{"pale smalt",0.7},{"Prussian blue",0.04},{"raw umber",0.15}, medium=0.1}
local farG2 = pile{{"lead white",2.6},{"green earth",1.6},{"yellow ochre",0.5},{"pale smalt",1.0},{"Prussian blue",0.03}, medium=0.1}
local a = FARB * mask(function(x,y) return (1 - smoothstep(420, 640, x + 60*nn(x,y))) end)
local b = FARB * mask(function(x,y) return smoothstep(420, 640, x + 60*nn(x,y)) end)
work(a, {hand="hatch", pile=farG, tool={kind="round", width=1.3, point=0.7}, angle=0.02, angle_jitter=0.12, length={5,14}, coverage=1.7, clip=true, seed=81, threshold=0.5, load=0.7})
work(b, {hand="hatch", pile=farG2, tool={kind="round", width=1.2, point=0.7}, angle=0, angle_jitter=0.12, length={5,14}, coverage=1.7, clip=true, seed=82, threshold=0.5, load=0.7})
print(wait(0))
