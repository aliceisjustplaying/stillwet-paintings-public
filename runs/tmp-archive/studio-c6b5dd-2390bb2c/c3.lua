sky = above(function(x) return 452 end)
local function cut(y0, amp, s) return function(x) return y0 + amp*math.sin(x/130 + s) + 0.5*amp*math.sin(x/47 + 2*s) end end
local b1 = above(cut(150, 14, 1))
local b2 = above(cut(270, 12, 2))
local b3 = above(cut(370, 8, 3))
skyA = sky * b1
skyB = sky * b2 - b1
skyC = sky * b3 - b2
skyD = sky - b3
pA = pile{{"lead white",5},{"smalt",2},{"Prussian blue",0.08}}
pB = pile{{"lead white",7},{"pale smalt",1.2},{"yellow ochre",0.15}}
pC = pile{{"lead white",7},{"chrome yellow",0.35},{"vermilion",0.06},{"pale smalt",0.2}}
pD = pile{{"lead white",6},{"chrome yellow",0.8},{"vermilion",0.2}}
local opt = function(p) return {hand="body", tool="filbert 14", pile=p, angle=0.03, angle_jitter=0.12, coverage=3, fill=true, length={60,160}} end
work(skyA, opt(pA))
work(skyB, opt(pB))
work(skyC, opt(pC))
work(skyD, opt(pD))
