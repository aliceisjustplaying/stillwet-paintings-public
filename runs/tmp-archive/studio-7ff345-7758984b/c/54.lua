-- the mere: neutralise the cyan toward a violet-grey ice, and bring the bright near rim down into the snow
iceNeutral = pile{{"smalt",1},{"red earth",0.25},{"bone black",0.25},{"lead white",1.2},{"vermilion",0.05}, medium=0.75}
work(merem, {hand="glaze", tool="filbert 10", pile=iceNeutral, angle=0, angle_jitter=0.01, clip=true,
   load_at=function(x, y) return 0.25 + 0.35 * smoothstep(555, 600, y) end,
   pressure={0.3, 0.5}, coverage=1.5, length={60, 160}, seed=541})
blend(merem, {angle=0})
rimGlaze = pile{{"smalt",1.5},{"pale smalt",1},{"bone black",0.15},{"lead white",1.5},{"vermilion",0.05}, medium=0.75}
local rim = mask(function(x, y)
  if x < 400 or x > 930 then return 0 end
  local e = nearEdge(x)
  if y > e - 5 and y < e + 16 then return 1 end
  return 0
end) - merem:shrink(3)
rimM = rim
work(rim, {hand="glaze", tool="filbert 6", pile=rimGlaze, angle=0, angle_jitter=0.05, clip=true, load=0.45,
   pressure={0.3, 0.5}, coverage=1.6, length={30, 80}, seed=542})
blend(rim:grow(4) - merem:shrink(3), {angle=0})
