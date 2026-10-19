-- Soften and break the light path
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
bright = pile{{"lead white", 2.2}, {"chrome yellow", 0.5}, {"vermilion", 0.25}}

wideR = ribbon({{640, 516}, {710, 650}, {670, 850}, {610, 1030}, {575, 1180}, {560, 1250}}, {70, 120, 200, 270, 330, 360})
coreR = ribbon({{640, 516}, {700, 640}, {660, 830}, {600, 1000}, {560, 1160}, {540, 1250}}, {26, 44, 70, 100, 130, 145})

blend(wideR, {coverage=1.0})
ring = wideR - coreR
work(ring, {hand="scumble", pile=watermid, coverage=0.9, angle=0.0, edge=1})
print("path softened and broken")
