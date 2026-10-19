skyS = pile{{"lead white",4},{"chrome yellow",0.45},{"yellow ochre",0.45},{"vermilion",0.05}, medium=0.2}
local kn = below(function(x) return knollf(x) - 0.5 end)
local ROCKS = (ROCKBAND + UPM + CAPM):grow(0.2)
work(rect(511, 461, 43, 24) - ROCKS - kn, {hand="detail", pile=plainC, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
work(rect(538, 444, 7, 5) - ROCKS, {hand="detail", pile=skyS, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.5, point=0.5}})
