-- Headland: low treeline right, thin far shore left
treedark = pile{{"lead white", 0.5}, {"cobalt blue", 0.6}, {"green earth", 0.35}, {"raw umber", 0.6}, {"bone black", 0.5}}

tl = function(x)
  return 448 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2)
end
hz = function(x) return 512 + 4 * math.sin(x / 40) end

headR = below(tl) * above(hz) * mask(function(x) return x > 370 and 1 or 0 end)
shoreL = below(function(x) return 498 + 8 * math.sin(x / 30) end) * above(hz) * mask(function(x) return x <= 420 and 1 or 0 end)

work(headR, {hand="body", pile=treedark, coverage=2.6, fill=true, angle=0.02, pressure={0.6, 0.85}, edge=0.5})
work(shoreL, {hand="body", pile=treedark, coverage=2.0, fill=true, angle=0.02, pressure={0.5, 0.7}, edge=0.6})
print("headland in")
