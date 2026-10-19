gap = (rect(330, 352, 110, 82) - trees:grow(1))
pGap = pile{{"lead white",7},{"chrome yellow",0.9},{"vermilion",0.08},{"yellow ochre",0.1}}
work(gap, {hand="body", tool="filbert 5", pile=pGap, angle=0, angle_jitter=0.1, coverage=3.5, load=0.8, fill=true, length={10,30}, clip=gap})
