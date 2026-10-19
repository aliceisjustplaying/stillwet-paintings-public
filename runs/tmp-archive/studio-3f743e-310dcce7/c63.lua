-- Glow ABOVE the treeline top (y < 452), i.e. above(glowtop) * below(400-line)
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

glowtop = function(x) return 452 + 8 * math.sin(x / 57) end
glowzone = above(glowtop) * below(function(x) return 402 end) * mask(function(x) return x > 548 and 1 or 0 end)
work(glowzone, {hand="body", pile=gold3, coverage=2.6, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.15, clip=true})
blend(glowzone, {coverage=0.8})

ruff = above(function(x) return glowtop(x) + 8 end) * below(function(x) return glowtop(x) - 6 end) * mask(function(x) return x > 548 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=3.5, coverage=0.7, pressure={0.25, 0.5}, feather=1})
print("glow recarved for real")
