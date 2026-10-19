local jb = jugBody:grow(1)
local Z = jb * mask(function(x,y) if y < 180 then return 0 end; return math.max(smoothstep(0.22, 0.4, jT(x,y)), smoothstep(520,560,y)) end)
blend(Z, {angle=0.15, tool={kind="badger", width=18}})
blend(Z, {angle=1.5708, tool={kind="badger", width=18}})
