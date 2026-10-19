local town = (townM + townM2):grow(0.8)
local m = (cloud2M:shrink(1)) - town
blend(m, {tool={kind="badger", width=14}, angle=cloud2F:field("across"), coverage=1.6, seed=921})
blend(m, {tool={kind="badger", width=10}, angle=-0.5, coverage=1.0, seed=922})
