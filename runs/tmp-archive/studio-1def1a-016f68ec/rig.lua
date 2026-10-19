glowP = pile{{"red earth",0.6},{"vermilion",0.4},{"chrome yellow",0.5},{"lead white",0.6}}
foldP = pile{{"raw umber",1},{"red earth",0.5},{"bone black",0.15}}
lineP = pile{{"bone black",1},{"raw umber",0.6}}
-- leech glow: a band inside the right edge of the mainsail
local leech = mainsail:mask() - mainsail:mask():offset(-9)
local rightside = mask(function(x,y) return clamp((x - 360)/12, 0, 1) end)
work(leech*rightside, {hand="scumble", tool="filbert 3", pile=glowP, angle=-1.5, coverage=1.2, pressure={0.2,0.45}, clip=mainsail:mask()})
-- topsail catches more light
work(topsail:mask():shrink(3), {hand="scumble", tool="filbert 3", pile=glowP, angle=-1.2, coverage=0.7, pressure={0.15,0.35}, clip=topsail:mask()})
-- crease along the sprit, peak to tack
local fb = brush("filbert", 5)
fb:reload(foldP, 0.5)
fb:stroke({{368,195},{350,260},{330,340},{312,420}}, {pressure={0.5,0.2}, ramps={0.1,0.4}, clip=mainsail:mask()})
fb:reload(foldP, 0.35)
fb:stroke({{372,200},{365,290},{352,380},{345,436}}, {pressure={0.4,0.15}, ramps={0.2,0.5}, clip=mainsail:mask()})
-- mast, topmast
local r = brush{kind="rigger", width=2.2, point=1}
r:reload(lineP, 0.8)
r:stroke({{301,446},{301.5,300},{302,190},{302.5,132}}, {pressure={0.75,0.35}, ramps={0.02,0.2}})
-- sprit spar
r:reload(lineP, 0.7)
r:stroke({{305,425},{330,340},{352,260},{373,184}}, {pressure={0.6,0.35}})
-- forestay to the stem, shrouds, vang
local t = brush{kind="rigger", width=1.2, point=1}
t:reload(lineP, 0.5)
t:stroke({{302,150},{258,300},{217,440}}, {pressure={0.35,0.4}})
t:reload(lineP, 0.4)
t:stroke({{302,205},{318,445}}, {pressure={0.3,0.35}})
t:reload(lineP, 0.4)
t:stroke({{373,186},{392,300},{410,442}}, {pressure={0.25,0.3}})
-- pennant
local pen = poly({{303,134},{322,137},{303,142}})
work(pen, {hand="detail", pile=pile{{"vermilion",1},{"red earth",0.3}}, coverage=2, fill=true})
