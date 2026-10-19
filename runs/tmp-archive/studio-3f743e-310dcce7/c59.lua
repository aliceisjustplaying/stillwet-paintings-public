-- Rebuild the right treeline decisively
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end
stretch = rect(548, 388, 350, 140) * above(hz)

base = below(function(x) return 470 end) * stretch
work(base, {hand="body", pile=treedark3, coverage=3.2, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.15, clip=true})
work(base, {hand="scumble", pile=treedark3, coverage=2.0, angle=0.02, edge=0.2})

clumps3 = ellipse(596, 444, 42, 30) + ellipse(668, 436, 48, 42) + ellipse(748, 444, 40, 26) + ellipse(836, 438, 46, 38) + ellipse(886, 446, 28, 24)
work(clumps3 * stretch, {hand="body", pile=treedark3, coverage=3.0, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.2, clip=true})
work(clumps3 * stretch, {hand="scumble", pile=treedark3, coverage=1.8, angle=0.02, edge=0.25})

-- sparse glow flecks along the new silhouette
tltop = function(x) return 452 + 20 * math.sin(x / 31 + 2) + 14 * math.sin(x / 67) end
gapband = below(function(x) return tltop(x) + 14 end) * above(function(x) return tltop(x) - 6 end) * stretch
stipple(gapband, {pile=gold3, width=3, coverage=0.35, pressure={0.2, 0.45}, feather=1})
print("right treeline rebuilt")
