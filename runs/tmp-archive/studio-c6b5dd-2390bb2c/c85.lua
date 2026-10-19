local r = (rect(420, 345, 40, 90) + rect(330, 340, 130, 22)) - trees:grow(3)
blend(r, {angle=0.3, angle_jitter=0.6, tool="badger 12", length={15,40}, pressure={0.25,0.4}, clip=false})
