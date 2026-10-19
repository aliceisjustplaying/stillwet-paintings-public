local town = (townM + townM2):grow(0.5)
local cut = rect(0,0,1000,413)
local lit = (cloud2F:lit{soft=0.18} * cut - town)
local heads = lit:map(function(v) return smoothstep(0.62, 0.92, v) end) * cloud2M:shrink(1)
local warm = pile{{"lead white",14},{"yellow ochre",0.35},{"vermilion",0.04}, medium=0.04}
local half = pile{{"lead white",10},{"pale smalt",0.5},{"yellow ochre",0.35},{"red earth",0.08}, medium=0.05}
local mid = lit:map(function(v) return smoothstep(0.35, 0.6, v) * smoothstep(0.85, 0.6, v) end) * cloud2M:shrink(1)
work(mid, {hand="body", tool="filbert 6", pile=half, angle=cloud2F:field("across"), coverage=1.2, clip=true, pressure={0.35,0.6}, seed=1051})
work(heads, {hand="body", tool="filbert 5", pile=warm, angle=cloud2F:field("across"), coverage=2.0, clip=true, pressure={0.45,0.7}, load=0.9, seed=1052})
