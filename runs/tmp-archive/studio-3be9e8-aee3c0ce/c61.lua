local jb = jugBody:grow(1)
local Z = jb * mask(function(x,y) if y < 200 then return 0 end; return smoothstep(0.4, 0.52, jT(x,y)) end)
blend(Z, {angle=1.5708, tool={kind="badger", width=20}})
blend(Z, {angle=0.1, tool={kind="badger", width=20}})
