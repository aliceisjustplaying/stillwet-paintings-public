-- boulder: calm the glyph-like marks
local bz = boulderM:shrink(2) * rect(770, 633, 95, 22)
work(bz, {hand="detail", pile=stoneMid, angle=-0.2, coverage=2.5, fill=true, clip=true, length={3,8}, pressure={0.4,0.7}})
work(boulderM:shrink(2) * rect(770, 645, 95, 12), {hand="detail", pile=stoneD, angle=-0.1, coverage=1.5, clip=true, length={3,8}, pressure={0.3,0.6}})
-- trunk sliver
local sl = (oakM2 - oakM2:shrink(2.2)) * rect(308, 432, 30, 45)
work(sl, {hand="detail", pile=barkD, angle=-1.5708, coverage=3, fill=true, clip=true, length={3,8}})
work((oakM2 - oakM2:shrink(1.0)) * rect(308, 432, 30, 45), {hand="detail", pile=barkRim, angle=-1.5708, coverage=1.0, clip=true, length={3,8}, pressure={0.2,0.4}})
-- warm lit lower edges on the cloud strata
cloudUnder = pile{{"lead white", 3}, {"vermilion", 0.25}, {"chrome yellow", 0.3}, {"yellow ochre", 0.2}, medium=0.1}
local under = mask(function(x, y) return (cloudM:at(x, y) > 0.5 and cloudM:at(x, y + 2.2) < 0.5) and 1 or 0 end)
print(under:area())
work(under, {hand="detail", pile=cloudUnder, angle=0, coverage=1.6, clip=true, length={8,25}, pressure={0.25,0.5}})
