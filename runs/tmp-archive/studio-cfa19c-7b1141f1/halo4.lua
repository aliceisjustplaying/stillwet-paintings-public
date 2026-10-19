local gz = pile{{"lead white",2},{"pale smalt",1.4},{"smalt",0.3},{"red earth",0.2},{"raw umber",0.3}, medium=0.55}
work(haloZ, {hand="detail", tool={kind="round", width=1.4, point=0.3}, pile=gz, angle=math.pi/2, coverage=2.0, fill=true, clip=true, edge="found", pressure={0.35,0.55}, seed=3861})
blend(haloZ:shrink(0.4), {tool={kind="badger", width=4}, angle=math.pi/2, coverage=1.0, clip=true, pressure={0.2,0.3}, seed=3862})
