-- Light path on the water, wet into wet
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}

core = ribbon({{640, 516}, {700, 640}, {660, 830}, {600, 1000}, {560, 1160}, {540, 1250}}, {26, 44, 70, 100, 130, 145})
work(core, {hand="body", pile=bright, coverage=2.0, fill=true, angle=function(x, y) return 0.15 * math.sin(y / 60) end, pressure={0.6, 0.85}, edge=1})

wide = ribbon({{640, 516}, {710, 650}, {670, 850}, {610, 1030}, {575, 1180}, {560, 1250}}, {60, 110, 190, 260, 320, 350})
work(wide, {hand="broad", pile=flare, coverage=0.9, fill=false, angle=0.02, pressure={0.5, 0.7}, edge=1})

print("light path laid")
