local jb = jugBody:grow(1)
gCore = pile{{"raw umber",1},{"yellow ochre",0.3},{"bone black",0.1}, medium=0.88}
local C = jb * mask(function(x,y)
  if y < 196 then return 0 end
  local t = jT(x,y)
  return smoothstep(0.52, 0.7, t) * (1 - smoothstep(0.86, 0.97, t))
end)
work(C, {hand="glaze", pile=gCore, angle=1.5708, angle_jitter=0.08, coverage=1.5, threshold=0.25, clip=jb})
