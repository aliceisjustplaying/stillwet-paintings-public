-- Full-cover repaint of the three sky fields
slate3 = pile{{"lead white", 1}, {"cobalt blue", 0.9}, {"bone black", 0.45}, {"raw umber", 0.55}, {"vermilion", 0.15}}
mauve2 = pile{{"lead white", 1.2}, {"cobalt blue", 0.7}, {"vermilion", 0.35}, {"raw umber", 0.3}, {"chrome yellow", 0.2}}
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}

t1 = above(function(x) return 205 + 30 * math.sin(x / 150) + 14 * math.sin(x / 57 + 2) end)
work(t1, {hand="broad", pile=slate3, coverage=3.2, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=1})

t2 = below(function(x) return 365 + 35 * math.sin(x / 130 + 1) + 16 * math.sin(x / 47) end)
work(t2, {hand="broad", pile=mauve2, coverage=3.0, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=1})

t3 = below(function(x) return 545 + 30 * math.sin(x / 110 + 3) + 14 * math.sin(x / 43 + 2) end)
work(t3, {hand="broad", pile=gold3, coverage=2.8, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=1})

print("fields repainted")
