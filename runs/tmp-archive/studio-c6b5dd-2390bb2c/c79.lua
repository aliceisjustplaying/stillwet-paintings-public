glowM = (ellipse(560, 408, 150, 30):soften(18) * above(function(x) return 424 end)) - trees:grow(2) - K3 
pGlow = pile{{"lead white",6},{"chrome yellow",1.1},{"vermilion",0.12}}
pGlow2 = pile{{"lead white",8},{"chrome yellow",0.8},{"vermilion",0.05}}
work(glowM, {hand="body", tool="filbert 10", pile=pGlow, angle=0, angle_jitter=0.05, coverage=2.5, load=0.7, pressure={0.35,0.6}, length={40,100}, fill=true})
local core = (ellipse(555, 412, 55, 12):soften(8)) - trees:grow(2)
work(core, {hand="body", tool="filbert 8", pile=pGlow2, angle=0, angle_jitter=0.05, coverage=2.5, load=0.7, pressure={0.4,0.6}, length={20,60}})
blend(glowM:grow(10) - trees:grow(3) - hills, {angle=0, angle_jitter=0.04, tool="badger 24", length={40,120}, clip=true})
