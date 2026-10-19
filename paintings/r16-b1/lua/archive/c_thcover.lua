local abv = above(function(x) return crestY(x) + 1 end)
local m1 = (ellipse(83, 531, 12, 13) + rect(74, 525, 20, 40)) * abv
work(m1, {hand="detail", pile=meadNearL, angle=0, coverage=3.5, fill=true, clip=true, length={3,8}})
work(m1 * rect(0, 537, 200, 30), {hand="detail", pile=meadNear, angle=0, coverage=1.5, clip=true, length={3,8}, pressure={0.3,0.6}})
blend(m1:grow(2) * abv, {angle=0, coverage=2, length={6,14}, tool="badger 12"})
local zone = (rect(0, 540, 170, 170):roughen(4, 20, 7101)) * bankM2
local upper = zone * above(function(x) return crestY(x) + 40 end)
local lower = zone - above(function(x) return crestY(x) + 32 end)
work(upper, {hand="body", pile=crestP, angle=-1.45, coverage=3.2, fill=true, clip=true, length={6,16}, tool="filbert 6"})
work(lower, {hand="body", pile=fgLow, angle=-1.45, coverage=3.2, fill=true, clip=true, length={8,20}, tool="filbert 8"})
work(lower * mask(function(x, y) return y < crestY(x) + 70 and 1 or 0 end), {hand="body", pile=fgUp, angle=-1.45, coverage=1.5, clip=true, length={8,20}, tool="filbert 8"})
blend(zone, {angle=-1.5, coverage=2.5, length={20,40}, tool="badger 20"})
