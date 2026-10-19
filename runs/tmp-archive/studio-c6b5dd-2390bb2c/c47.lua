local c = (K1 - trees:grow(4)) + K2 + K3
blend(c, {angle=0, angle_jitter=0.03, tool="badger 24", length={40,120}, clip=c:soften(4)})
blend(c, {angle=0, angle_jitter=0.02, tool="badger 30", length={60,160}, pressure={0.25,0.4}, clip=c:soften(4)})
