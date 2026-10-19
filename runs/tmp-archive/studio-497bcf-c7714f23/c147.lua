local towers = spJ + rect(262,389,10,52) + spN1 + rect(322,377,9,64) + rect(420,371,26,70)
local band = rect(224, 427, 370, 14) - towers:grow(0.5)
blend(band, {angle=0, coverage=1.5, clip=true, tool={kind="badger", width=6}, pressure={0.3,0.45}})
print(wait(0))
