sky0 = pile{{"lead white", 1.5}, {"cobalt blue", 1.2}, {"smalt", 1.2}, medium=0.08}
work(rect(-10,-10,1020,75):soften(15), {hand="broad", pile=sky0, angle=0.02, coverage=1.6, length={120,220}, pressure={0.4,0.7}, edge="soft"})
blend(sky_m, {angle=0, coverage=1.6, clip=true})
blend(sky_m, {angle=0.03, coverage=1.0, clip=true})
print(wait(0), drying(500,100))
