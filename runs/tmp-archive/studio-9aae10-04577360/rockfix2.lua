plainP = pile{{"lead white",6},{"smalt",1.0},{"raw umber",0.12},{"yellow ochre",0.15},{"red earth",0.05}, medium=0.15}
local kn = below(function(x) return knollf(x) - 1 end)
local sky = above(function(x) return 461 end)
local ROCKS = (ROCKBAND + UPM + CAPM):grow(0.3)
local SM = SLAB:mask()
local L = rect(526, 442, 24, 46) - ROCKS
work(L * sky, {hand="detail", pile=sE, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
work(L - sky - kn, {hand="detail", pile=plainP, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
local G = rect(722, 452, 26, 38) - ROCKS - SM
work(G - kn, {hand="detail", pile=plainP, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
work(G * kn, {hand="detail", pile=crest, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
work(SM, {hand="detail", pile=rkBase, coverage=4, fill=true, angle=1.2, load=1, pressure={0.6,0.9}, tool={kind="round", width=2, point=0.5}})
local g = noise{seed=93, octaves=3, period=9, kind="fbm", stretch={1.2, 1.8}}
work(SM:shrink(1):times(function(x,y) return clamp(g(x,y)*1.5 - 0.25, 0, 1) end), {hand="detail", pile=rkGrain, coverage=1.2, fill=true, angle=1.2, load=0.7, pressure={0.35,0.55}, tool={kind="round", width=1.4, point=0.8}})
