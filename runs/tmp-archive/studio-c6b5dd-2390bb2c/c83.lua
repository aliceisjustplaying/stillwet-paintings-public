local zone = trees * rect(285, 330, 200, 128)
local w = zone * warmPart:grow(2)
local c = zone - w
local ang = function(x,y) return 0.9*math.sin(x/35 + y/50) end
work(c, {hand="body", tool="filbert 7", pile=pTC, angle=ang, angle_jitter=0.6, coverage=3.5, load=0.95, fill=true, length={10,28}, clip=zone})
work(w, {hand="body", tool="filbert 7", pile=pTW, angle=ang, angle_jitter=0.6, coverage=3.5, load=0.95, fill=true, length={10,28}, clip=zone})
