local gz = pile{{"lead white",2},{"pale smalt",1.4},{"smalt",0.3},{"red earth",0.2},{"raw umber",0.3}, medium=0.55}
local m = (haloW:shrink(1.5):blur(3)) - townM4:grow(0.2)
local ang = cloud2F:field("across")
work(m, {hand="detail", tool={kind="filbert", width=3, stiffness=0.2}, pile=gz, angle=ang, coverage=2.0, fill=true, clip=m, pressure={0.3,0.5}, seed=3891})
blend(m, {tool={kind="badger", width=6}, angle=ang, coverage=1.2, clip=m, pressure={0.2,0.3}, seed=3892})
