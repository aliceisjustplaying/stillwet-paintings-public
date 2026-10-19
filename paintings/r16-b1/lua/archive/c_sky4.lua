skyMid2 = pile{{"lead white", 5}, {"smalt", 1.6}, {"pale smalt", 1}, {"cobalt blue", 0.3}, medium=0.2}
work(rect(0, 95, 1000, 90):soften(35), {hand="broad", pile=skyMid2, angle=0, coverage=1.8, fill=true, angle_jitter=0.04})
skyMid3 = pile{{"lead white", 7}, {"pale smalt", 1.4}, {"chrome yellow", 0.08}, medium=0.2}
work(rect(0, 175, 1000, 70):soften(30), {hand="broad", pile=skyMid3, angle=0, coverage=1.5, fill=true, angle_jitter=0.04})
blend(rect(0, 40, 1000, 250), {angle=0, coverage=3})
