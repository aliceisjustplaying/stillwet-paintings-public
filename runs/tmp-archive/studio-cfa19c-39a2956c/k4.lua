print(wait(60*24*2))
print(drying(700,300), drying(800,390))
local S2 = cloudV:map(function(v) return smoothstep(0.44, 0.34, v) end) * cloudC
local D = cloudV:map(function(v) return smoothstep(0.24, 0.15, v) end) * cloudC
local S2o = S2 - D
print(S2o:area(), D:area())
kS2 = pile{{"lead white",3.5},{"pale smalt",1.6},{"smalt",0.35},{"red earth",0.22},{"raw umber",0.3},{"yellow ochre",0.08}, medium=0.06}
kD = pile{{"lead white",2.6},{"pale smalt",1.5},{"smalt",0.45},{"red earth",0.28},{"raw umber",0.45}, medium=0.06}
local ang = cloud2F:field("across")
work(S2o:grow(1.5) * cloudC, {hand="body", tool="filbert 5", pile=kS2, angle=ang, length={10,26}, coverage=2.6, fill=true, clip=cloudC, pressure={0.5,0.75}, seed=3321})
work(D:grow(1.5) * cloudC, {hand="body", tool="filbert 5", pile=kD, angle=ang, length={10,26}, coverage=2.6, fill=true, clip=cloudC, pressure={0.5,0.75}, seed=3322})
