-- Lose the hard cream top edge into the sky; break the dark edge with glow flecks
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end

-- soften the straight cream top edge upward into the glow
aboveband = below(function(x) return 425 end) * above(function(x) return 395 end) * mask(function(x) return x > 560 and x < 865 and 1 or 0 end)
work(aboveband, {hand="scumble", pile=gold3, coverage=0.7, angle=0.02, edge=1})

-- glow flecks eating into the dark top edge
gapband = below(function(x) return tltop(x) + 18 end) * above(function(x) return tltop(x) - 8 end) * mask(function(x) return x > 555 and x < 875 and 1 or 0 end)
stipple(gapband, {pile=gold3, width=3, coverage=0.5, pressure={0.2, 0.5}, feather=1})

-- more dark flecks above, to ruffle the silhouette
ruff = below(function(x) return tltop(x) - 2 end) * above(function(x) return tltop(x) - 22 end) * mask(function(x) return x > 555 and x < 875 and 1 or 0 end)
stipple(ruff, {pile=treedark3, width=4, coverage=0.8, pressure={0.25, 0.55}, feather=1})
print("edges broken")
