local ex = treeZone:grow(1) + oakM2:grow(1) + willowZone + hullM:grow(2) + sailM:grow(2) + figM:grow(2)
local z = rect(0, 440, 1000, 42) - ex
local z2 = rect(262, 440, 738, 42) - ex
work(z2, {hand="glaze", pile=mistP, angle=0, coverage=1.0, ruler=true, clip=true, load_at=function(x, y) return clamp(1 - math.abs(y - 452) / 22, 0, 1) * 0.6 end})
for i = 1, 2 do
  blend(z, {angle=0, coverage=3, ruler=true, length={100, 250}, tool="badger 40", clip=true})
  blend(z, {angle=1.5708, coverage=1.5, length={20, 40}, tool="badger 40", clip=true})
end
