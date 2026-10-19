-- Deepen treeline, add taller irregular clumps
treedark2 = pile{{"lead white", 0.4}, {"cobalt blue", 0.55}, {"green earth", 0.3}, {"raw umber", 0.6}, {"bone black", 0.65}}

tl = function(x)
  return 448 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2)
end
hz = function(x) return 512 + 4 * math.sin(x / 40) end

clumps = ellipse(497, 424, 30, 36) + ellipse(638, 418, 46, 44) + ellipse(798, 426, 36, 28) + ellipse(938, 420, 33, 38)
band = below(tl) * above(hz) * mask(function(x) return x > 370 and 1 or 0 end)
work(band + clumps, {hand="body", pile=treedark2, coverage=2.0, fill=true, angle=0.02, pressure={0.6, 0.85}, edge=0.45})

shoreL = below(function(x) return 500 + 6 * math.sin(x / 30) end) * above(hz) * mask(function(x) return x <= 420 and 1 or 0 end)
work(shoreL, {hand="body", pile=treedark2, coverage=1.6, fill=true, angle=0.02, pressure={0.5, 0.7}, edge=0.6})
print("treeline deepened")
