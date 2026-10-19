blend(meadow, {angle=0, coverage=2.0, clip=true})
blend(meadow * below({{0,445},{1000,445}}) - below({{0,520},{1000,520}}), {angle=0.02, coverage=1.5, clip=true, tool={kind="badger", width=24}})
print(wait(0))
