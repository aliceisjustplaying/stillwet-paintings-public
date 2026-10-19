local z = rect(640, 0, 360, 240) - treeZone:grow(2) - moonM:grow(1.2)
for i = 1, 3 do
  blend(z, {angle=0, coverage=3, ruler=true, length={150, 400}, tool="badger 40"})
  blend(z, {angle=1.5708, coverage=2, length={40, 120}, tool="badger 40"})
end
blend(z, {angle=0, coverage=3, ruler=true, length={200, 400}, tool="badger 40"})
