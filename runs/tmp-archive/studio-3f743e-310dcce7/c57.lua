-- Break the smooth domes into foliage; tie the stretch to the rest
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}

-- new clumps to vary the silhouette
clumps2 = ellipse(585, 470, 34, 26) + ellipse(660, 458, 30, 30) + ellipse(742, 472, 36, 24) + ellipse(828, 462, 30, 28)
work(clumps2, {hand="body", pile=treedark3, coverage=2.6, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.35, clip=true})

-- flecks to roughen the top edges
tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end
edgeband = below(function(x) return tltop(x) + 16 end) * above(function(x) return tltop(x) - 12 end) * mask(function(x) return x > 555 and x < 870 and 1 or 0 end)
stipple(edgeband, {pile=treedark3, width=4, coverage=0.9, pressure={0.3, 0.6}, feather=1})

-- unify tone across the whole right treeline
unif = below(tltop) * above(function(x) return 512 + 4 * math.sin(x / 40) end) * mask(function(x) return x > 540 and 1 or 0 end)
work(unif, {hand="scumble", pile=treedark3, coverage=0.8, angle=0.02, edge=0.5})
print("treeline re-carved")
