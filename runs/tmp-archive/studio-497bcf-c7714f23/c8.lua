local seams = (ribbon(b_far, 10) + ribbon(b_mid, 18) + ribbon(b_shad, 20) + ribbon(rise_top, 18)):soften(6) * land_m
blend(seams, {angle=0.9, coverage=1.5, clip=true, tool={kind="badger", width=16}})
blend(seams, {angle=-0.8, coverage=1.0, clip=true, tool={kind="badger", width=16}})
blend(land_m, {angle=0, coverage=0.8, clip=true, pressure={0.2,0.35}})
print(wait(0))
