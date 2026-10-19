-- a thin cool glaze over the town so it stands a half-step darker than the cloud behind
local tg = pile{{"smalt",1},{"raw umber",0.5},{"red earth",0.15},{"lead white",0.6}, medium=0.7}
work(townM4:shrink(0.3), {hand="detail", pile=tg, tool={kind="round", width=1.0, point=0.5}, angle=math.pi/2, coverage=2.5, fill=true, clip=true, edge="found", pressure={0.35,0.55}, seed=3921})
