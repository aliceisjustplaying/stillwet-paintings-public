-- Clean sky over the upper zone; then re-fleck the tree edge
skyfixp = pile{{"lead white", 2.6}, {"chrome yellow", 0.5}, {"vermilion", 0.22}, {"raw umber", 0.1}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

fillz = rect(548, 355, 355, 92)
work(fillz, {hand="body", pile=skyfixp, coverage=3.0, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.2, clip=true})
work(fillz, {hand="scumble", pile=skyfixp, coverage=1.6, angle=0.02, edge=0.25})
blend(fillz, {coverage=0.9})

-- re-fleck the treeline top against the clean sky
glowtop = function(x) return 452 + 10 * math.sin(x / 47 + 1) + 6 * math.sin(x / 23) end
ruff = above(function(x) return glowtop(x) + 10 end) * below(function(x) return glowtop(x) - 8 end) * mask(function(x) return x > 548 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=4, coverage=0.8, pressure={0.25, 0.55}, feather=1})
print("sky clean")
