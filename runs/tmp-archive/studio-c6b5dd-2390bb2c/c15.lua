local tall = outline{{-10,200,"c"},{-10,110},{15,85},{40,62},{62,48},{85,52},{100,70},{112,95},{120,125},{110,150},{60,170}, closed=true, char="soft", seed=31, lobe=14, amount=1.3}
local small = outline{{380,462,"c"},{384,440},{392,420},{404,405},{418,398},{432,404},{442,420},{446,440},{450,458,"c"}, closed=true, char="soft", seed=32, lobe=8, amount=1.2}
crowns = tall:mask() + small:mask()
work(crowns, {hand="body", tool="filbert 8", pile=pDark, angle=function(x,y) return 0.6*math.sin(x/40+y/55) end, angle_jitter=0.5, coverage=3.5, load=0.9, fill=true, length={15,40}, edge="soft"})
trees = trees + crowns
