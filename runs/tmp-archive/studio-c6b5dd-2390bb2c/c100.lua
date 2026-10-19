lowBand = (rect(300, 346, 710, 98) - trees:grow(1) - hills) 
local b1 = lowBand * above(function(x) return 372 + 4*math.sin(x/80) end)
local b2 = lowBand * below(function(x) return 372 + 4*math.sin(x/80) end) * above(function(x) return 404 + 3*math.sin(x/60) end)
local b3 = lowBand * below(function(x) return 404 + 3*math.sin(x/60) end)
lb1 = pile{{"lead white",6},{"chrome yellow",0.5},{"vermilion",0.18},{"pale smalt",0.25}}
lb2 = pile{{"lead white",7},{"chrome yellow",0.8},{"vermilion",0.12}}
lb3 = pile{{"lead white",9},{"chrome yellow",0.9},{"vermilion",0.06}}
local o = function(p) return {hand="body", tool="filbert 10", pile=p, angle=0, angle_jitter=0.03, coverage=3.2, load=0.85, fill=true, length={50,140}, clip=lowBand} end
work(b1, o(lb1)); work(b2, o(lb2)); work(b3, o(lb3))
blend(lowBand, {angle=0, angle_jitter=0.02, tool="badger 24", length={60,180}})
