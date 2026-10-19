wait(60*24*3)
local keep = oakSil:shrink(2.5)
local m = ellipse(165,152,19,7) - keep
work(m, {hand="body", pile=d1, tool={kind="filbert", width=4}, angle=0.05, coverage=2.5, fill=true, edge="soft", pressure={0.45,0.7}, seed=1161})
