jHalf = pile{{"lead white",4},{"yellow ochre",0.45},{"raw umber",0.35},{"green earth",0.3}}
jShadow = pile{{"lead white",2},{"raw umber",1},{"yellow ochre",0.4},{"bone black",0.2},{"green earth",0.5}}
jLight = pile{{"lead white",6},{"yellow ochre",0.35}}
local jb = jugBody + spout
local val = mask(function(x,y) return jf:value(x,y) end)
jShadowM = jb * val:map(function(v) return clamp((0.42 - v)/0.1, 0, 1) end)
jLightM = jb * val:map(function(v) return clamp((v - 0.6)/0.1, 0, 1) end)
local across = function(x,y) return 0.12*math.sin((y-420)/300) end
work(jb, {hand="body", tool="filbert 10", pile=jHalf, coverage=2.2, angle=0, angle_jitter=0.15, curve={0.3,0.1}, length={25,60}, edge="firm", fill=true})
work(jShadowM, {hand="body", tool="filbert 9", pile=jShadow, coverage=1.8, angle=0.2, angle_jitter=0.2, curve={0.3,0.1}, length={20,50}, edge="soft", threshold=0.4})
work(jLightM, {hand="body", tool="filbert 9", pile=jLight, coverage=2.0, angle=-0.1, angle_jitter=0.2, curve={0.3,0.1}, length={20,50}, edge="soft", threshold=0.4})
