gHz2 = pile{{"green earth", 2.2}, {"yellow ochre", 2}, {"lead white", 2}, {"pale smalt", 0.8}, {"raw umber", 0.3}, medium=0.1}
local below440 = below({{-10,440.5},{1010,440.5}})
local zone = mask(function(x,y) if y < 446 then return 0 end return smoothstep(446, 462, y) * (1 - smoothstep(484, 496, y)) end)
work(zone, {hand="body", pile=gHz2, angle=0, coverage=2.0, length={20,60}, pressure={0.4,0.7}, fill=true, clip=below440, threshold=0.3, edge="soft"})
local bz = below440 * mask(function(x,y) return 1 - smoothstep(492, 505, y) end)
blend(bz, {angle=0, coverage=2.0, clip=true, tool={kind="badger", width=20}})
blend(bz, {angle=0.35, coverage=1.0, clip=true, tool={kind="badger", width=14}, pressure={0.25,0.4}})
blend(bz, {angle=0, coverage=1.0, clip=true, tool={kind="badger", width=30}, pressure={0.2,0.35}})
print(wait(0))
