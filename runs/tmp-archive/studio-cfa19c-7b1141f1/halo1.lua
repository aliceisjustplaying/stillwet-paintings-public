-- test: kill the cream halo along the tall spire by veiling its rim with the cloud's own grey
haloR = (townM4:grow(5) - townM4:grow(0.4)) * cloud2M:grow(6) * rect(500,300,320,104)
local hv = pile{{"lead white",5},{"pale smalt",1.5},{"smalt",0.25},{"red earth",0.2},{"raw umber",0.2},{"yellow ochre",0.1}, medium=0.35}
work(haloR * rect(588,318,32,86), {hand="detail", pile=hv, tool={kind="round", width=1.2, point=0.3}, angle=math.pi/2, coverage=2.5, fill=true, clip=true, edge="found", pressure={0.4,0.6}, seed=3721})
