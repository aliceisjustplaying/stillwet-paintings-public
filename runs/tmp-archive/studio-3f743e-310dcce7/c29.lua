-- Water fields (correct masks: water lies below the horizon curve)
glowwater = pile{{"lead white", 1.2}, {"chrome yellow", 0.4}, {"vermilion", 0.2}, {"cobalt blue", 0.3}, {"raw umber", 0.3}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}

hz = function(x) return 512 + 4 * math.sin(x / 40) end
wg = below(hz) * above(function(x) return 615 + 15 * math.sin(x / 70) end)
work(wg, {hand="broad", pile=glowwater, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

wm = below(hz) * above(function(x) return 985 + 25 * math.sin(x / 80) end)
work(wm, {hand="broad", pile=watermid, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

wd = below(function(x) return 985 + 25 * math.sin(x / 80) end)
work(wd, {hand="broad", pile=waterdeep, coverage=2.6, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})

print("water fields on")
