local skyLow = (ellipse(590, 425, 170, 26):soften(10)) * above(function(x) return 436 end) - trees:grow(4) - hills:grow(2)
pGlow3 = pile{{"lead white",9},{"chrome yellow",0.7},{"vermilion",0.04}}
work(skyLow, {hand="body", tool="filbert 6", pile=pGlow3, angle=0, angle_jitter=0.04, coverage=2.2, load=0.7, pressure={0.35,0.6}, length={30,80}, clip=skyLow})
blend(skyLow:grow(6) - trees:grow(5) - hills:grow(2), {angle=0, angle_jitter=0.03, tool="badger 16", length={40,100}, clip=true})
