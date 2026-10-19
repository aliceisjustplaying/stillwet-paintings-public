local jb = jugBody:grow(1)
local zone = jb * mask(function(x,y) if y < 180 or y > 615 then return 0 end; return smoothstep(0.3, 0.45, jT(x,y)) + smoothstep(480,560,y) end):map(function(v) return math.min(v,1) end)
blend(zone, {angle=1.5708, tool={kind="badger", width=24}})
blend(zone, {angle=0.2, tool={kind="badger", width=24}})
