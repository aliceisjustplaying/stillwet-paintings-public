openW = (below(function(x) return 474 + 2*math.sin(x/33) end) - refl2) * rect(380, 0, 700, 800)
local c1 = function(x) return 530 + 4*math.sin(x/90) end
local c2 = function(x) return 560 + 5*math.sin(x/120+1) end
local c3 = function(x) return 604 + 4*math.sin(x/100+2) end
local c4 = function(x) return 632 + 5*math.sin(x/80+3) end
local c5 = function(x) return 672 + 4*math.sin(x/110+4) end
local w1 = openW * above(c1)
local w2 = openW * below(c1) * above(c2)
local w3 = openW * below(c2) * above(c3)
local w4 = openW * below(c3) * above(c4)
local w5 = openW * below(c4) * above(c5)
local w6 = openW * below(c5)
gw1 = pile{{"lead white",4},{"chrome yellow",1.0},{"vermilion",0.3},{"raw umber",0.1}}
gw2 = pile{{"lead white",5},{"chrome yellow",0.4},{"vermilion",0.25},{"pale smalt",0.3}}
gw3 = pile{{"lead white",3},{"smalt",0.8},{"red earth",0.35},{"vermilion",0.12},{"raw umber",0.15}}
gw4 = pile{{"lead white",4},{"smalt",1.0},{"yellow ochre",0.1},{"raw umber",0.2}}
gw5 = pile{{"lead white",3},{"smalt",0.9},{"red earth",0.3},{"raw umber",0.25}}
gw6 = pile{{"lead white",3},{"smalt",1.4},{"Prussian blue",0.04},{"raw umber",0.4}}
local o = function(p) return {hand="body", tool="filbert 14", pile=p, angle=0, angle_jitter=0.02, coverage=3, load=0.85, fill=true, length={80,200}, clip=openW} end
work(w1, o(gw1)); work(w2, o(gw2)); work(w3, o(gw3)); work(w4, o(gw4)); work(w5, o(gw5)); work(w6, o(gw6))
