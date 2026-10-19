skyDeep = pile{{"lead white", 2}, {"smalt", 3}, {"cobalt blue", 1.2}, medium=0.2}
work(rect(0, 0, 1000, 110):soften(30), {hand="broad", pile=skyDeep, angle=0, coverage=2, fill=true, angle_jitter=0.04})
skyGreenish = pile{{"lead white", 8}, {"pale smalt", 1}, {"chrome yellow", 0.35}, medium=0.2}
work(rect(0, 230, 1000, 90):soften(25), {hand="broad", pile=skyGreenish, angle=0, coverage=1.5, fill=true})
blend(rect(0, 0, 1000, 200), {angle=0, coverage=2})
blend(rect(0, 190, 1000, 180):soften(10), {angle=0, coverage=2.5})
