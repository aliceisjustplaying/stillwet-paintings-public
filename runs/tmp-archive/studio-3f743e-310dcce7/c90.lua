-- Path dies into the bank; gold band veil; sparkles
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.5}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
amber2 = pile{{"lead white", 1.0}, {"chrome yellow", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.55}, {"cobalt blue", 0.1}}
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}

spit_edge = function(x) return 1150 + 26 * math.sin(x / 90 + 1) + 14 * math.sin(x / 38 + 2) - 0.28 * x end
bank = below(spit_edge)
lowpath = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}, {560, 1250}}, {30, 60, 110, 180, 230})
wide2 = ribbon({{640, 516}, {705, 650}, {665, 850}, {605, 1040}, {565, 1250}}, {70, 130, 220, 300, 360})
work(bank * (lowpath + wide2), {hand="body", pile=spitdark, coverage=2.4, fill=true, angle=0.05, pressure={0.75, 0.9}, edge=0.4, clip=true})

goldz = rect(300, 150, 700, 120)
work(goldz, {hand="scumble", pile=amber2, coverage=1.1, angle=0.02, edge=1})
work(goldz, {hand="scumble", pile=cloudtone, coverage=0.4, angle=0.02, edge=1})
blend(goldz, {coverage=0.8})

sparkz = ribbon({{640, 516}, {700, 640}, {660, 830}, {610, 1000}}, {26, 50, 100, 170})
stipple(sparkz, {pile=bright, width=3.5, coverage=0.4, pressure={0.3, 0.6}, drag={7, 0}, feather=1})
print("path dies into bank, gold veiled")
