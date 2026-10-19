rkBase = pile{{"bone black",0.8},{"raw umber",1.2},{"smalt",0.35},{"lead white",0.35},{"red earth",0.08}, medium=0.08}
rkGrain = pile{{"bone black",0.6},{"raw umber",1.0},{"smalt",0.4},{"lead white",0.7},{"yellow ochre",0.08}, medium=0.08}
local R = ((ROCKBAND + UPM) - OPEN) * rect(540, 440, 205, 55)
work(R, {hand="detail", pile=rkBase, coverage=4, fill=true, angle=0.08, load=1, pressure={0.6,0.9}, tool={kind="round", width=2, point=0.5}})
local g = noise{seed=91, octaves=3, period=9, kind="fbm", stretch={0.1, 1.8}}
work(R:shrink(1):times(function(x,y) return clamp(g(x,y)*1.5 - 0.25, 0, 1) end), {hand="detail", pile=rkGrain, coverage=1.2, fill=true, angle=0.1, load=0.7, pressure={0.35,0.55}, tool={kind="round", width=1.4, point=0.8}})
-- the openings: misty plain above the knoll line, snow below
local kn = below(function(x) return knollf(x) - 1 end)
work(OPEN - kn, {hand="detail", pile=mist, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
work(OPEN * kn, {hand="detail", pile=crest, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
-- the spill to the left of the dolmen
local L = rect(526, 442, 24, 46) - (ROCKBAND + UPM + CAPM):grow(0.3)
work(L - kn, {hand="detail", pile=mist, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
work(L * kn, {hand="detail", pile=crest, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
