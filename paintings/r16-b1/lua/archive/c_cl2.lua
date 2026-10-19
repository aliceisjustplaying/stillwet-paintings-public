local under = mask(function(x, y) return (cloudM:at(x, y) > 0.5 and cloudM:at(x, y + 2.2) < 0.5) and 1 or 0 end)
local z = under:grow(4)
blend(z, {angle=1.5708, coverage=3, length={6, 12}, tool="badger 12"})
blend(z, {angle=0, coverage=2, length={20, 50}, tool="badger 12"})
