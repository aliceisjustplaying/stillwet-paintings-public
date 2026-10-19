print(wait(60*24*3))
print(drying(700,300), drying(800,390), drying(650,330))
local function Z(lo, hi, s) return cloudV:map(function(v) return smoothstep(lo - s, lo + s, v) * smoothstep(hi + s, hi - s, v) end) * cloudC end
local ang = cloud2F:field("across")
kH = pile{{"lead white",8},{"pale smalt",1.1},{"red earth",0.1},{"yellow ochre",0.2},{"raw umber",0.08}, medium=0.06}
kQ = pile{{"lead white",5.5},{"pale smalt",1.4},{"smalt",0.2},{"red earth",0.16},{"raw umber",0.16},{"yellow ochre",0.1}, medium=0.06}
local zH = Z(0.47, 0.58, 0.015)
local zQ = Z(0.36, 0.47, 0.015)
local zS = Z(0.24, 0.36, 0.015)
local zD = Z(-1, 0.24, 0.015)
work(zD:grow(1) * cloudC, {hand="body", tool="filbert 4", pile=kD, angle=ang, length={8,22}, coverage=2.6, fill=true, clip=cloudC, pressure={0.5,0.75}, seed=3341})
work(zS:grow(1) * cloudC, {hand="body", tool="filbert 4", pile=kS2, angle=ang, length={8,22}, coverage=2.6, fill=true, clip=cloudC, pressure={0.5,0.75}, seed=3342})
work(zQ:grow(1) * cloudC, {hand="body", tool="filbert 4", pile=kQ, angle=ang, length={8,22}, coverage=2.6, fill=true, clip=cloudC, pressure={0.5,0.75}, seed=3343})
work(zH:grow(1) * cloudC, {hand="body", tool="filbert 4", pile=kH, angle=ang, length={8,22}, coverage=2.6, fill=true, clip=cloudC, pressure={0.5,0.75}, seed=3344})
