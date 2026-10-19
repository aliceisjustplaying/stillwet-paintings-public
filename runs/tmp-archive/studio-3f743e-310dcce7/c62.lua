-- Sky glow re-carves the slab; spires remain
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

hz = function(x) return 512 + 4 * math.sin(x / 40) end
glowtop = function(x) return 452 + 8 * math.sin(x / 57) end
glowzone = below(glowtop) * above(function(x) return 400 end) * mask(function(x) return x > 548 and 1 or 0 end)
work(glowzone, {hand="body", pile=gold3, coverage=2.6, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.15, clip=true})
blend(glowzone, {coverage=0.8})

spires = ellipse(628, 442, 13, 24) + ellipse(776, 438, 11, 28) + ellipse(862, 446, 13, 22) + ellipse(700, 448, 10, 16)
work(spires, {hand="detail", pile=treedark3, coverage=2.2, fill=true, angle=0.02, edge=0.2, clip=true})

ruff = below(function(x) return glowtop(x) + 6 end) * above(function(x) return glowtop(x) - 8 end) * mask(function(x) return x > 548 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=3.5, coverage=0.7, pressure={0.25, 0.5}, feather=1})
print("glow recarved")
