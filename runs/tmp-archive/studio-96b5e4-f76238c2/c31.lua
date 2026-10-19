f_d1 = pile{{"raw umber",1.4},{"green earth",0.9},{"bone black",0.35},{"yellow ochre",0.3}, medium=0.12}
f_d2 = pile{{"raw umber",1},{"green earth",0.6},{"red earth",0.25},{"yellow ochre",0.4},{"bone black",0.15}, medium=0.12}
local fgm = (marsh - creek:grow(1)) * below(function(x) return 565 + 12*math.sin(x/71) + 6*math.sin(x/23) end)
local N = noise{seed=101, period=70, octaves=3}
local A = fgm * mask(function(x,y) return N:at01(x,y) > 0.45 and 1 or 0 end)
local B = fgm - A
local ang = function(x,y) return -0.08 + 0.1*math.sin(x/40+y/25) end
work(A, {hand="body", pile=f_d1, angle=ang, coverage=1.6, length={15,45}, tool="filbert 7", clip=marsh-creek, edge="loose", dips={3,0.75,0.3}, load=0.7})
work(B, {hand="body", pile=f_d2, angle=ang, coverage=1.4, length={15,45}, tool="filbert 7", clip=marsh-creek, edge="loose", dips={3,0.75,0.3}, load=0.7})
