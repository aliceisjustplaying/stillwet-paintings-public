local town = (townM + townM2):grow(0.5)
local m = cloud2M:shrink(1.5) - town
blend(m, {tool={kind="badger", width=9}, angle=cloud2F:field("across"), coverage=0.9, pressure={0.2,0.4}, seed=1061})
