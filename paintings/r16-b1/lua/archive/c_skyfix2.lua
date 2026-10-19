function skyRepaint2(zone)
  local base = zone * (rect(0, 0, 1000, 240):roughen(4, 30, 556))
  local bands = {{skyTopS, -5, 70}, {skyMidS, 45, 90}, {skyMid2, 105, 80}, {skyMid3, 165, 90}}
  for _, b in ipairs(bands) do
    work(base * rect(0, b[2], 1000, b[3]):roughen(5, 40, 600 + b[2]), {hand="body", pile=b[1], angle=0, coverage=2.8, fill=true, clip=true, length={20,50}, tool="filbert 10"})
  end
  blend(base, {angle=0, coverage=3, ruler=true, length={80, 250}, tool="badger 20"})
  blend(base, {angle=1.5708, coverage=2, length={25, 70}, tool="badger 20"})
  blend(base, {angle=0, coverage=2, ruler=true, length={100, 300}, tool="badger 20"})
end
skyRepaint2(rect(0, 0, 1000, 260) - treeZone:grow(3))
work(moonM, {hand="detail", pile=moonP, coverage=4, fill=true, clip=true, length={2,5}})
