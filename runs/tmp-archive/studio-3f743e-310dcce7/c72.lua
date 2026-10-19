-- Re-grade the lower water; re-cut the light path
deep2 = pile{{"lead white", 0.75}, {"cobalt blue", 0.95}, {"raw umber", 0.6}, {"bone black", 0.5}, {"green earth", 0.35}, {"vermilion", 0.1}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
waterdeep = pile{{"lead white", 0.7}, {"cobalt blue", 0.9}, {"raw umber", 0.6}, {"bone black", 0.55}, {"green earth", 0.35}, {"vermilion", 0.08}}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
notbank = mask(function(x, y) return y < spit_edge(x) and 1 or 0 end)

bandA = below(function(x) return 875 + 18 * math.sin(x / 80) end) * above(function(x) return 1075 + 15 * math.sin(x / 70) end) * notbank
work(bandA, {hand="body", pile=deep2, coverage=2.4, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
blend(bandA, {coverage=0.7})

bandB2 = below(function(x) return 1260 end) * above(function(x) return 1075 + 15 * math.sin(x / 70) end)
work(bandB2, {hand="body", pile=deep3, coverage=2.4, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1, clip=true})
work(bandB2, {hand="scumble", pile=deep3, coverage=1.0, angle=0.02, edge=1})
blend(bandB2, {coverage=0.7})

lowpath = ribbon({{612, 1000}, {572, 1130}, {505, 1250}}, {150, 215, 260})
work(lowpath, {hand="body", pile=bright, coverage=1.6, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=1})
wide2 = ribbon({{620, 1000}, {580, 1140}, {520, 1250}}, {230, 320, 380})
work(wide2, {hand="broad", pile=flare, coverage=0.8, fill=false, angle=0.02, pressure={0.5, 0.7}, edge=1})

rimb = rect(0, 1218, 1000, 34)
work(rimb, {hand="scumble", pile=waterdeep, coverage=0.8, angle=0.02, edge=1})
blend(rimb, {coverage=0.7})
print("lower water re-graded")
