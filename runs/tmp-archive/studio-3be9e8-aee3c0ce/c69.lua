local jb = jugBody:grow(1)
gCore2 = pile{{"raw umber",1},{"bone black",0.25},{"green earth",0.2}, medium=0.85}
local C = jb * mask(function(x,y)
  if y < 196 then return 0 end
  local t = jT(x,y)
  return smoothstep(0.58, 0.72, t) * (1 - smoothstep(0.84, 0.94, t))
end)
work(C, {hand="glaze", pile=gCore2, angle=1.5708, angle_jitter=0.05, coverage=2, threshold=0.4, clip=jb})
local Z = jb * mask(function(x,y) if y < 196 then return 0 end; return smoothstep(0.42, 0.55, jT(x,y)) end)
blend(Z, {angle=0.05, tool={kind="badger", width=24}})
blend(Z, {angle=1.5708, tool={kind="badger", width=24}})
blend(Z, {angle=0.05, tool={kind="badger", width=30}})
