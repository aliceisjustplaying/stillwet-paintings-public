g_brown = pile{{"raw umber",1},{"red earth",0.3},{"yellow ochre",0.6},{"green earth",0.4}, medium=0.1}
local fg = marsh * below(function(x) return 548 + 10*math.sin(x/47) + 6*math.sin(x/13) end)
local N = noise{seed=81, period=90, octaves=3}
local A = fg * mask(function(x,y) return N:at01(x,y) > 0.5 and 1 or 0 end)
local B = fg - A
local ang = function(x,y) return 0.05*math.sin(x/60) - 0.25*smoothstep(600,714,y)*math.sin(x/37) end
work(A, {hand="body", pile=g_brown, angle=ang, coverage=1.8, length={20,60}, tool="filbert 9", clip=marsh, fill=true, dips={3,0.8,0.3}})
work(B, {hand="body", pile=g_lmid, angle=ang, coverage=1.8, length={20,60}, tool="filbert 9", clip=marsh, fill=true, dips={3,0.8,0.3}})
local deep = marsh * below(function(x) return 640 + 12*math.sin(x/53) end)
work(deep, {hand="body", pile=g_near, angle=ang, coverage=1.5, length={25,70}, tool="filbert 11", clip=marsh, dips={3,0.8,0.3}})
