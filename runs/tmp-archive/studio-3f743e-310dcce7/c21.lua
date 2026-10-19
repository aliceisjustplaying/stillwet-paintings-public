-- Sky rebuild: three solid fields, dark to light, then blend
slate3 = pile{{"lead white", 1}, {"cobalt blue", 0.9}, {"bone black", 0.45}, {"raw umber", 0.55}, {"vermilion", 0.15}}
mauve  = pile{{"lead white", 1.6}, {"cobalt blue", 0.5}, {"vermilion", 0.5}, {"chrome yellow", 0.4}, {"raw umber", 0.15}}
goldpale = pile{{"lead white", 2.2}, {"chrome yellow", 0.55}, {"vermilion", 0.2}}

t1 = above(function(x) return 205 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(t1, {hand="broad", pile=slate3, coverage=3.0, fill=true, angle=0.05, dips={70, 0.95, 0}, edge=1})

t2 = below(function(x) return 355 + 35 * math.sin(x / 130 + 1) + 16 * math.sin(x / 47) end)
work(t2, {hand="broad", pile=mauve, coverage=2.6, fill=true, angle=0.05, dips={70, 0.95, 0}, edge=1})

t3 = below(function(x) return 530 + 30 * math.sin(x / 110 + 3) + 14 * math.sin(x / 43 + 2) end)
work(t3, {hand="broad", pile=goldpale, coverage=2.6, fill=true, angle=0.05, dips={70, 0.95, 0}, edge=1})

print("three fields down")
