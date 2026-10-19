function jT(x, y)
  local xl, xr = edgeX(jugL, y), edgeX(jugR, y)
  return (x - xl) / math.max(1, xr - xl)
end
local jb = jugBody:grow(2)
gzA = pile{{"raw umber",1},{"bone black",0.5},{"green earth",0.8},{"lead white",0.7}, medium=0.45}
local g1 = jb * mask(function(x,y)
  if y < 180 or y > 615 then return 0 end
  local t = jT(x,y)
  local s = smoothstep(0.40, 0.58, t)
  local b = smoothstep(500, 600, y) * 0.8
  return math.max(s, b * smoothstep(0.1, 0.4, t))
end)
work(g1, {hand="glaze", pile=gzA, clip=g1, angle=1.5708, angle_jitter=0.08, length={60,160}, coverage=1.6})
