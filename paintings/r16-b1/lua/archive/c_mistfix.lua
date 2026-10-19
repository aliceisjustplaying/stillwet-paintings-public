local tb = oakM2 * rect(255, 420, 90, 70)
work(tb, {hand="detail", pile=barkD, angle=-1.5708, coverage=4, fill=true, clip=true, length={6,16}})
work(tb * rect(255, 420, 40, 70), {hand="detail", pile=barkDark, angle=-1.5708, coverage=1.5, clip=true, length={6,16}, pressure={0.3,0.6}})
blend(oakM2 * rect(255, 410, 90, 90), {angle=-1.5708, coverage=2, length={15,40}, tool="badger 12", clip=true})
local rim = (tb - oakM2:shrink(2.5)) * rect(306, 420, 40, 70)
work(rim, {hand="detail", pile=barkRim, angle=-1.5708, coverage=1.4, clip=true, length={6,16}, pressure={0.3,0.55}})
-- the hanging clump
local hc = foliM * rect(125, 415, 70, 55)
work(hc, {hand="detail", pile=foliDark, coverage=3.5, fill=true, clip=true, length={2,5}})
