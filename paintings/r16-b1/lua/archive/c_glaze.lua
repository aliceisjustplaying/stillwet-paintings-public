skyGlazeP = pile{{"smalt", 1}, {"cobalt blue", 0.6}, {"lead white", 0.3}, medium=0.9}
local z = rect(680, 0, 320, 225) - treeZone:grow(2) - moonM:grow(1.2)
work(z, {hand="glaze", pile=skyGlazeP, angle=0, coverage=1.2, load_at=function(x, y) return clamp(lerp(0.75, 0.0, (y - 20) / 200), 0, 1) end, ruler=true})
