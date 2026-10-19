wait(60*24*4)
local halo = ((townM4:grow(5) + townM:grow(3) + townM2:grow(3)) - townM4) * rect(500,300,320,114)
local cMid = pile{{"lead white",7},{"pale smalt",1.3},{"red earth",0.18},{"yellow ochre",0.25},{"raw umber",0.1}, medium=0.1}
local cr = pile{{"lead white",10},{"yellow ochre",0.45},{"vermilion",0.05},{"pale smalt",0.3},{"raw umber",0.03}, medium=0.08}
work(halo * cloud2M:grow(8), {hand="detail", pile=cMid, tool={kind="round", width=1.4, point=0.3}, angle=math.pi/2, coverage=3, fill=true, clip=true, edge="found", pressure={0.5,0.8}, seed=1471})
work(halo - cloud2M:grow(8), {hand="detail", pile=cr, tool={kind="round", width=1.4, point=0.3}, angle=math.pi/2, coverage=3, fill=true, clip=true, edge="found", pressure={0.5,0.8}, seed=1472})
local lo = ((townM + townM2):grow(1.5) - townM4) * rect(500,414,320,26)
work(lo, {hand="detail", pile=cr, tool={kind="round", width=1.2, point=0.3}, angle=0, coverage=3, fill=true, clip=true, edge="found", pressure={0.5,0.8}, seed=1473})
