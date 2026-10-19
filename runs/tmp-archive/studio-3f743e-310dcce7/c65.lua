-- Soft edges for the sky patch; marry the tone
skyfixp2 = pile{{"lead white", 2.2}, {"chrome yellow", 0.42}, {"vermilion", 0.2}, {"raw umber", 0.25}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

soft = rect(548, 350, 355, 100):soften(14)
work(soft, {hand="body", pile=skyfixp2, coverage=2.0, fill=true, angle=0.02, pressure={0.7, 0.85}, edge=1})
work(soft, {hand="scumble", pile=skyfixp2, coverage=0.9, angle=0.02, edge=1})

glowtop = function(x) return 452 + 10 * math.sin(x / 47 + 1) + 6 * math.sin(x / 23) end
ruff = above(function(x) return glowtop(x) + 10 end) * below(function(x) return glowtop(x) - 8 end) * mask(function(x) return x > 548 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=4, coverage=0.85, pressure={0.25, 0.55}, feather=1})
print("sky married")
