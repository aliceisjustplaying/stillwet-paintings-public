local zone = ((ellipse(300, 592, 72, 34):roughen(3, 12, 1201)) * bankM2) - (oakM2 * above(function(x) return 582 end)) - figM:grow(2)
zone = zone - above(function(x) return crestY(x) + 1 end)
work(zone * above(function(x) return crestY(x) + 22 end), {hand="body", pile=crestP, angle=-1.4, coverage=3, fill=true, clip=true, length={4,10}, tool="filbert 4"})
work(zone - above(function(x) return crestY(x) + 18 end), {hand="body", pile=fgUp, angle=-1.4, coverage=3, fill=true, clip=true, length={4,10}, tool="filbert 4"})
blend(zone, {angle=-1.5, coverage=2, length={8,20}, tool="badger 12"})
-- roots
rootM = poly({{276, 572}, {274, 586}, {266, 594}, {252, 600}, {262, 601}, {276, 597}, {284, 600}, {292, 598}, {300, 603}, {306, 599}, {316, 598}, {330, 604}, {344, 603}, {332, 596}, {322, 588}, {320, 572}}, true)
work(rootM, {hand="detail", pile=barkD, angle=-1.2, coverage=4, fill=true, clip=true, length={3,8}})
local rl = brush{kind="round", width=1.4, point=1}
rl:load(barkRim, 0.6)
rl:stroke({{318, 578}, {321, 588}, {330, 596}, {340, 601}}, {pressure={rl:pressure_for(0.8), rl:pressure_for(0.3)}})
rl:load(barkRim, 0.5)
rl:stroke({{303, 590}, {305, 597}}, {pressure={rl:pressure_for(0.6), rl:pressure_for(0.2)}})
