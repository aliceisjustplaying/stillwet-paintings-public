local town = (townM + townM2):grow(0.5)
local m = cloud2M:shrink(2) - town
blend(m, {tool={kind="badger", width=16}, angle=cloud2F:field("across"), coverage=1.8, seed=1041})
blend(m, {tool={kind="badger", width=12}, angle=0.4, coverage=1.2, seed=1042})
