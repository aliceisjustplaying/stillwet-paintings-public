wglaze = pile{{"pale smalt", 2}, {"smalt", 0.6}, {"lead white", 1.2}, {"raw umber", 0.2}, {"green earth", 0.3}, medium=0.55}
local rv = river2:shrink(0.3)
-- the nearer water, darker toward the near side of each reach
work(rv, {hand="detail", pile=wglaze, angle=0, coverage=1.6, length={6,16}, pressure={0.35,0.55}, load=0.45, fill=true, clip=true})
blend(rv, {angle=0, coverage=1.5, clip=true, tool={kind="badger", width=8}, pressure={0.2,0.35}})
print(wait(0))
