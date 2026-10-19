pRefl2 = pile{{"Prussian blue",0.35},{"yellow ochre",0.9},{"raw umber",1.5},{"bone black",0.35},{"smalt",0.3},{"lead white",0.08}}
local r = refl * below(function(x) return 482 end)
work(r, {hand="body", tool="filbert 12", pile=pRefl2, angle=math.pi/2, angle_jitter=0.12, coverage=3.5, load=0.9, fill=true, length={30,80}, edge="soft"})
blend(r, {angle=0, angle_jitter=0.03, tool="badger 30"})
