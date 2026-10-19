glowP = pile{{"lead white",8},{"chrome yellow",0.7},{"vermilion",0.04}, medium=0.35}
local core = ellipse(385, 382, 150, 20) * rect(0,0,1000,396)
work(core, {hand="body", tool="filbert 8", pile=glowP, angle=0, coverage=1.5, length={40,110}, load=0.5, clip=rect(0,0,1000,396) - farShore:grow(1)})
local bm = ellipse(385, 378, 200, 34):soften(12) * rect(0,0,1000,395)
blend(bm, {angle=0, tool={kind="badger", width=30}})
blend(bm, {angle=0.1, tool={kind="badger", width=30}})
