-- Haze the cream mass into the sky
cloudtone = pile{{"lead white", 2.0}, {"chrome yellow", 0.3}, {"vermilion", 0.15}, {"raw umber", 0.2}}
amber2 = pile{{"lead white", 1.0}, {"chrome yellow", 0.5}, {"vermilion", 0.25}, {"raw umber", 0.55}, {"cobalt blue", 0.1}}

topz = rect(460, 222, 540, 50):soften(18)
work(topz, {hand="scumble", pile=amber2, coverage=0.7, angle=0.02, edge=1})
blend(topz, {coverage=0.8})

leftz = rect(450, 255, 45, 215):soften(14)
work(leftz, {hand="scumble", pile=amber2, coverage=0.8, angle=0.02, edge=1})
blend(leftz, {coverage=0.8})

work(rect(455, 250, 80, 60), {hand="scumble", pile=amber2, coverage=0.9, angle=0.02, edge=1})
print("hazed")
