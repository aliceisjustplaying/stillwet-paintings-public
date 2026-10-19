-- Final sky: one smooth dusk gradient over everything above the headland
skA = pile{{"lead white", 1}, {"cobalt blue", 1.1}, {"raw umber", 0.5}, {"vermilion", 0.25}}
skB = pile{{"lead white", 1.4}, {"cobalt blue", 0.8}, {"raw umber", 0.4}, {"vermilion", 0.22}}
skC = pile{{"lead white", 1.3}, {"chrome yellow", 0.55}, {"vermilion", 0.22}, {"raw umber", 0.45}}
skD = pile{{"lead white", 2.2}, {"chrome yellow", 0.42}, {"vermilion", 0.2}, {"raw umber", 0.25}}
hz = function(x) return 512 + 4 * math.sin(x / 40) end

b1 = below(function(x) return 165 + 10 * math.sin(x / 80) end)
work(b1, {hand="broad", pile=skA, coverage=2.6, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b1, {coverage=0.8})

b2 = below(function(x) return 285 + 10 * math.sin(x / 75) end) * above(function(x) return 125 + 10 * math.sin(x / 80) end)
work(b2, {hand="broad", pile=skB, coverage=2.4, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b2, {coverage=0.8})

b3 = below(function(x) return 365 + 10 * math.sin(x / 70) end) * above(function(x) return 245 + 10 * math.sin(x / 75) end)
work(b3, {hand="broad", pile=skC, coverage=2.4, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b3, {coverage=0.8})

b4 = below(function(x) return 352 + 8 * math.sin(x / 70) end) * above(function(x) return 300 + 8 * math.sin(x / 70) end)
work(b4, {hand="broad", pile=skD, coverage=2.2, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b4, {coverage=0.8})

b5 = mask(function(x, y)
  if y > 444 or y < 352 then return 0 end
  if x > 440 and y > 348 then return 0 end
  return 1
end)
work(b5, {hand="broad", pile=skD, coverage=2.2, fill=true, angle=0.03, pressure={0.7, 0.9}, edge=1})
blend(b5, {coverage=0.8})

bigblend = above(function(x) return 345 end)
blend(bigblend, {coverage=1.0})
print("final sky laid")
