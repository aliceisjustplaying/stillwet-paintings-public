plainP2 = pile{{"lead white",5},{"smalt",1.1},{"raw umber",0.15},{"yellow ochre",0.12},{"red earth",0.05}, medium=0.15}
local kn = below(function(x) return knollf(x) - 1 end)
local sky = above(function(x) return 461 end)
local ROCKS = (ROCKBAND + UPM + CAPM):grow(0.3)
local SM = SLAB:mask():grow(0.3)
local G = rect(720, 440, 30, 21) - ROCKS - SM
work(G * sky, {hand="detail", pile=sE, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
local P = (rect(514, 461, 38, 21) + rect(718, 461, 34, 20)) - ROCKS - SM - kn
work(P, {hand="body", pile=plainP2, coverage=2.5, fill=true, angle=0, edge="soft", length={8,20}, tool={kind="filbert", width=3}})
blend((rect(512, 455, 42, 30) + rect(716, 440, 38, 45)) - ROCKS - SM, {angle=0})
