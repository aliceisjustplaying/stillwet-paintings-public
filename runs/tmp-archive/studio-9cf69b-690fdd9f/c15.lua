churchP = pile{{"lead white",2},{"pale smalt",2},{"smalt",0.7},{"raw umber",0.6},{"vermilion",0.05}, medium=0.15}
local tower = poly({{785,472},{785,436},{797,436},{797,472}})
local spire = poly({{784.5,437},{791,410},{797.5,437}})
local nave = poly({{797,472},{797,452},{808,443},{824,443},{824,472}})
churchM = tower + spire + nave
work(churchM, {hand="detail", pile=churchP, angle=-math.pi/2, coverage=4, pressure={0.6,0.9}, load=1, fill=true})
-- snow on the nave roof, lit from the west glow
local roof = poly({{797.5,452},{808,443.5},{824,443.5},{824,447},{809,447},{799,455}})
work(roof, {hand="detail", pile=snowLit, angle=0, coverage=3, pressure={0.5,0.8}, load=0.8, tool={kind="round", width=1.2}})
-- snowfield strip in front of the woods
local strip = rect(555,471,455,8)
work(strip, {hand="detail", pile=snowFar, angle=0, coverage=3, pressure={0.5,0.8}, load=0.8, length={8,20}, fill=true})
