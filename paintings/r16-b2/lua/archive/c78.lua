local seam = rect(0,448,470,22) * below(function(x) return 449 + 4*math.sin(x/17) end)
blend(seam, {angle=-math.pi/2, angle_jitter=0.35, length={6,16}, clip=false, tool={kind="badger", width=10}, seed=781})
blend(seam, {angle=-math.pi/2+0.4, angle_jitter=0.35, length={6,14}, clip=false, tool={kind="badger", width=8}, seed=782})
