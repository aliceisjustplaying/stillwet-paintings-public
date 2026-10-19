plainC = pile{{"lead white",1.8},{"smalt",1.0},{"raw umber",0.28},{"red earth",0.05},{"yellow ochre",0.15}, medium=0.15}
local kn = below(function(x) return knollf(x) - 0.5 end)
local ROCKS = (ROCKBAND + UPM + CAPM):grow(0.2)
local SM = SLAB:mask():grow(0.2)
local P = (rect(512, 461, 42, 24) + rect(718, 461, 34, 22)) - ROCKS - SM - kn
work(P, {hand="detail", pile=plainC, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
