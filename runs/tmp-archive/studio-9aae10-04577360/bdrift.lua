fgVeil = pile{{"lead white",1.2},{"smalt",1.0},{"raw umber",0.22},{"red earth",0.06}, medium=0.55}
local bd = poly({{744,694},{760,684},{775,679},{790,681},{805,678},{822,682},{840,679},{858,683},{875,679},{893,682},{905,684},{920,682},{935,685},{952,686},{968,693},{940,697},{780,697}}, true)
work(bd:soften(2), {hand="body", pile=fgVeil, coverage=1.6, fill=true, angle=0, edge="soft", length={10,25}, tool={kind="filbert", width=3}})
-- the snow cap: a cool shadowed lower part so the top stays lit
local capLow = BOULDER:mask():grow(1) * below(function(x) return 641 + math.abs(x-835)*0.12 + 1.5*math.sin(x/7) end) * above(function(x) return 648 + math.abs(x-835)*0.1 end)
work(capLow, {hand="detail", pile=fgMid, coverage=3, fill=true, angle=0.1, load=0.8, pressure={0.4,0.7}, tool={kind="round", width=1.5, point=0.5}})
