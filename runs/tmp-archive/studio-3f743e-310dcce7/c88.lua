-- Re-establish treeline and headland over the veil
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end

tlband = below(function(x) return 452 + 20 * math.sin(x / 31 + 2) + 12 * math.sin(x / 67) + 8 * math.sin(x / 13) end) * above(hz)
work(tlband, {hand="body", pile=treedark3, coverage=2.8, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.35, clip=true})
work(tlband, {hand="scumble", pile=treedark3, coverage=1.6, angle=0.02, edge=0.4})

headz = below(function(x) return 356 + 14 * math.sin(x / 61 + 2) end) * above(hz) * rect(440, 330, 560, 220)
work(headz, {hand="body", pile=treedark3, coverage=2.8, fill=true, angle=0.02, pressure={0.8, 0.95}, edge=0.2, clip=true})
work(headz, {hand="scumble", pile=treedark3, coverage=1.4, angle=0.02, edge=0.25})

tope = below(function(x) return 362 + 14 * math.sin(x / 61 + 2) end) * above(function(x) return 344 + 14 * math.sin(x / 61 + 2) end) * rect(440, 330, 560, 40)
stipple(tope, {pile=treedark3, width=4, coverage=1.0, pressure={0.3, 0.6}, feather=1})
print("treeline and headland back")
