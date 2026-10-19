cgl = pile{{"lead white",2},{"smalt",2},{"red earth",0.3},{"raw umber",0.3}, medium=0.5}
local grad = mask(function(x,y) return smoothstep(290, 395, y) end)
local sh = (cloudF:shadow{soft=0.35} + grad:map(function(v) return v*0.8 end)) * cloudM * rect(540,250,470,152)
local shm = sh:map(function(v) return v > 0.45 and 1 or 0 end):soften(4)
work(shm, {hand="glaze", tool={kind="filbert", width=9, stiffness=0.3}, length={25,60}, pile=cgl, angle=function(x,y) return cloudF:across(x,y) end, coverage=1.3, pressure={0.25,0.45}, edge="soft", seed=141})
blend(shm:grow(4) * cloudM, {angle=0.2, coverage=1.2, seed=142})
