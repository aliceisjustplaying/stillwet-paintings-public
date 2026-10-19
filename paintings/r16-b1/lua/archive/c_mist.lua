mistP = pile{{"lead white", 2}, {"pale smalt", 0.3}, {"chrome yellow", 0.05}, medium=0.85}
local z = rect(0, 440, 272, 42) - treeZone:grow(1) - oakM2:grow(1)
work(z, {hand="glaze", pile=mistP, angle=0, coverage=1.0, ruler=true, load_at=function(x, y) return clamp(1 - math.abs(y - 452) / 22, 0, 1) * 0.6 end})
for i = 1, 2 do
  blend(z, {angle=0, coverage=3, ruler=true, length={100, 250}, tool="badger 40"})
  blend(z, {angle=1.5708, coverage=1.5, length={20, 40}, tool="badger 40"})
end
