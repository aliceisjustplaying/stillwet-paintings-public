wait(60*24*3)
local tw4 = pile{{"lead white",2.2},{"smalt",2},{"raw umber",0.6},{"red earth",0.35},{"Prussian blue",0.06}, medium=0.06}
work(townM4, {hand="detail", pile=tw4, tool={kind="round", width=1.0, point=0.5}, angle=math.pi/2, coverage=4, fill=true, clip=true, edge="found", pressure={0.5,0.8}, seed=1481})
local cSh = pile{{"lead white",5},{"pale smalt",1.5},{"smalt",0.3},{"red earth",0.25},{"raw umber",0.18}, medium=0.3}
local around = ((townM4:grow(14) - townM4:grow(0.5)) * cloud2M) * rect(500,300,320,114)
work(around, {hand="glaze", pile=cSh, tool={kind="filbert", width=6, stiffness=0.2}, angle=0.1, coverage=1.0, clip=true, edge="found", pressure={0.25,0.45}, seed=1482})
