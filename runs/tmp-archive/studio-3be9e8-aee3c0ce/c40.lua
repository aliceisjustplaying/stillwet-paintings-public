gz1 = pile{{"raw umber",1},{"green earth",1},{"bone black",0.25}, medium=0.6}
local jb = jugBody:grow(1)
local G1 = jb * mask(function(x,y)
  if y < 185 or y > 612 then return 0 end
  local t = jT(x,y)
  return math.max(smoothstep(0.5, 0.62, t), smoothstep(545, 590, y) * smoothstep(0.05, 0.3, t))
end)
work(G1, {hand="glaze", pile=gz1, clip=jb, angle=1.5708, angle_jitter=0.1, length={40,90}, coverage=3, threshold=0.5})
local Z = jb * mask(function(x,y) if y < 180 then return 0 end; return math.max(smoothstep(0.3, 0.42, jT(x,y)), smoothstep(500,540,y)) end)
blend(Z, {angle=1.5708, tool={kind="badger", width=18}})
