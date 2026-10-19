local inner = trees:shrink(10)
nz = noise{seed=77, octaves=4, period=90, persistence=0.55}
warmPart = inner * mask(function(x,y) return nz(x,y) > 0.05 and 1 or 0 end)
coolPart = inner - warmPart
pTW = pile{{"Prussian blue",0.3},{"yellow ochre",1.3},{"raw umber",1.6},{"bone black",0.35},{"green earth",0.4}}
pTC = pile{{"Prussian blue",0.5},{"yellow ochre",0.8},{"raw umber",1.4},{"bone black",0.55}}
local ang = function(x,y) return 0.9*math.sin(x/35 + y/50) end
work(coolPart, {hand="body", tool="filbert 9", pile=pTC, angle=ang, angle_jitter=0.6, coverage=3.2, load=0.9, fill=true, length={12,35}, edge="soft"})
work(warmPart, {hand="body", tool="filbert 9", pile=pTW, angle=ang, angle_jitter=0.6, coverage=3.2, load=0.9, fill=true, length={12,35}, edge="soft"})
