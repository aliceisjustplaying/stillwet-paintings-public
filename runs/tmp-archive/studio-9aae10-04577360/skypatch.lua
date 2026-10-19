skyS2 = pile{{"lead white",4},{"chrome yellow",0.3},{"yellow ochre",0.38},{"vermilion",0.04}, medium=0.2}
local ROCKS = (ROCKBAND + UPM + CAPM):grow(0.4)
local sky = above(function(x) return 461 end)
local m = (rect(508, 435, 46, 27) * sky - ROCKS):soften(2)
work(m, {hand="body", pile=skyS2, coverage=2.5, fill=true, angle=0, edge="soft", length={10,25}, tool={kind="filbert", width=3}})
-- the snow cap's dirtied left end
local c = CAPM * rect(545, 432, 32, 22)
work(c, {hand="detail", pile=capShade, coverage=4, fill=true, angle=0.3, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.3, point=0.5}})
