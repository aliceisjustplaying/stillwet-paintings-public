print(wait(36*60))
print(drying(300,420), drying(300,570))
trunkZ = oakM2 * rect(282, 360, 50, 250)
barkMid = pile{{"raw umber", 3}, {"bone black", 1.2}, {"green earth", 0.8}, {"lead white", 0.35}, {"red earth", 0.2}, medium=0.1}
work(trunkZ, {hand="body", pile=barkMid, angle=-1.5708, coverage=3, fill=true, clip=true, length={10,30}, tool="filbert 5"})
-- shadow side left, a slightly lighter warm column right-of-centre
local L = trunkZ * mask(function(x, y) local c = 305 + (y - 480) * 0.02; return x < c - 8 and 1 or 0 end)
work(L, {hand="body", pile=barkD, angle=-1.5708, coverage=2, fill=true, clip=true, length={10,30}, tool="filbert 4"})
blend(trunkZ, {angle=-1.5708, coverage=3, length={30, 80}, tool="badger 12"})
