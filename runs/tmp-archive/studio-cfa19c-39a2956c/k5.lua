local S2 = cloudV:map(function(v) return smoothstep(0.44, 0.34, v) end) * cloudC
local edgeZ = (S2:grow(9) - S2:shrink(5)) * cloudC:shrink(1)
blend(edgeZ, {tool={kind="badger", width=10}, angle=cloud2F:field("across"), coverage=1.6, clip=cloudC:shrink(1), pressure={0.25,0.4}, seed=3331})
blend(S2:shrink(4) * cloudC:shrink(1), {tool={kind="badger", width=14}, angle=0.1, coverage=0.8, clip=true, pressure={0.2,0.35}, seed=3332})
