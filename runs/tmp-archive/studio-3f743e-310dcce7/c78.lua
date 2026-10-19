-- Broad glow field on the water; dark left rim; boat reflection
flare  = pile{{"lead white", 1.6}, {"chrome yellow", 0.35}, {"vermilion", 0.2}, {"cobalt blue", 0.12}}
deep3 = pile{{"lead white", 0.6}, {"cobalt blue", 1.0}, {"raw umber", 0.7}, {"bone black", 0.6}, {"green earth", 0.4}, {"vermilion", 0.08}}
hullc = pile{{"bone black", 0.55}, {"raw umber", 0.65}, {"cobalt blue", 0.3}, {"lead white", 0.3}}

-- glow field: soft feathered pale wash around the path, edges feathered out
glowz = rect(280, 730, 290, 300):soften(30)
work(glowz, {hand="broad", pile=flare, coverage=0.55, angle=0.0, pressure={0.45, 0.65}, edge=1})
blend(glowz, {coverage=0.7})

-- left rim dark
work(rect(0, 516, 16, 630), {hand="body", pile=deep3, coverage=2.2, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=1})
blend(rect(0, 516, 30, 630), {coverage=0.7})

-- boat reflection, a touch stronger
stipple(rect(355, 934, 120, 92), {pile=hullc, width=4.5, coverage=0.3, pressure={0.25, 0.5}, drag={10, 0}, feather=1})
print("glow field, rim, reflection")
