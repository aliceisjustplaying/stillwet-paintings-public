local z = fieldA * rect(200, 466, 90, 58) - river2:grow(1.2) - fieldB:grow(0.3)
blend(z, {angle=0, coverage=2.0, clip=true, tool={kind="badger", width=20}, pressure={0.45,0.6}})
-- continue a thin scumble of the same mid green leftward over the dry older pasture to match
local lft = fieldA * rect(0, 474, 250, 50) - river2:grow(1.2) - fore_m
work(lft, {hand="scumble", pile=gG, angle=0, coverage=1.2, length={15,40}, pressure={0.3,0.5}, load=0.35, clip=lft, threshold=0.3})
blend(lft + z, {angle=0, coverage=1.2, clip=true, tool={kind="badger", width=16}, pressure={0.3,0.45}})
print(wait(0))
