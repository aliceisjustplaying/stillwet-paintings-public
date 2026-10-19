water = below(function(x) return 446 end)
local function cut(y0, amp, s) return function(x) return y0 + amp*math.sin(x/110 + s) + 0.4*amp*math.sin(x/37 + 2*s) end end
local c1 = above(cut(520, 5, 4))
local c2 = above(cut(610, 6, 5))
wA = water * c1
wB = water * c2 - c1
wC = water - c2
pwA = pile{{"lead white",4},{"chrome yellow",0.8},{"vermilion",0.3},{"raw umber",0.15}}
pwB = pile{{"lead white",4},{"smalt",0.9},{"vermilion",0.15},{"raw umber",0.25}}
pwC = pile{{"lead white",3},{"smalt",1.5},{"Prussian blue",0.12},{"raw umber",0.4}}
local opt = function(p) return {hand="body", tool="filbert 14", pile=p, angle=0, angle_jitter=0.03, coverage=3, fill=true, length={80,200}} end
work(wA, opt(pwA))
work(wB, opt(pwB))
work(wC, opt(pwC))
blend(water, {angle=0, angle_jitter=0.02})
