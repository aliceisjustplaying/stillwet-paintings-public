local z = shad2:grow(10):soften(6) * mid_m
blend(z, {angle=0, coverage=2.5, clip=true, tool={kind="badger", width=24}, pressure={0.45,0.65}})
blend(z, {angle=0.05, coverage=2.0, clip=true, tool={kind="badger", width=30}, pressure={0.4,0.6}})
blend(z, {angle=-0.05, coverage=1.5, clip=true, tool={kind="badger", width=18}, pressure={0.3,0.5}})
print(wait(0))
