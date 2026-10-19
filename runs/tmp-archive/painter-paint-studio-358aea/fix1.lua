local band = rect(516, 446, 356, 24) * above(function(x) return 469.5 end)
local sk = band - TOWN:shrink(0.3) - LAND
local skyH = pile{{"lead white",12},{"yellow ochre",0.35},{"vermilion",0.05},{"pale smalt",0.3},{"raw umber",0.03}, medium=0.08}
work(sk, {hand="detail", pile=skyH, tool={kind="round", width=2.0, point=0.3}, angle=0, length={4,12}, coverage=3, clip=true, fill=true, load=0.85})
local tw = TOWN * rect(553, 446, 275, 24)
work(tw, {hand="detail", pile=townP3, tool={kind="round", width=1.3, point=0.5}, angle=math.pi/2, length={3,8}, coverage=3, fill=true, clip=true, edge="found", load=0.85})
print(wait(0))
