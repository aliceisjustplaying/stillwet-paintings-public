pV1 = pile{{"lead white",2.2},{"smalt",1},{"red earth",0.4},{"raw umber",0.3},{"vermilion",0.05}}
pV2 = pile{{"lead white",2.8},{"smalt",0.9},{"red earth",0.35},{"raw umber",0.2},{"vermilion",0.1}}
pV3 = pile{{"lead white",3.5},{"smalt",0.6},{"vermilion",0.25},{"red earth",0.2},{"chrome yellow",0.1}}
local cut = K1 - trees
local o = function(p) return {hand="body", tool="filbert 10", pile=p, angle=0, angle_jitter=0.04, coverage=3, load=0.85, fill=true, length={50,140}, edge="soft"} end
work(cut, o(pV1))
work(K2, o(pV2))
work(K3, o(pV3))
