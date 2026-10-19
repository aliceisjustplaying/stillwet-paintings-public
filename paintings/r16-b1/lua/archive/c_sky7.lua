local midB = pile{{"lead white", 3.5}, {"smalt", 2.4}, {"pale smalt", 0.8}, {"cobalt blue", 0.6}, medium=0.2}
stipple(skyStip * rect(0, 20, 1000, 140), {pile=midB, width=3, coverage=function(x, y) return 1.4 * math.exp(-((y - 80) / 28)^2) end, cluster=0, pressure={0.4, 0.8}, dips={40, 0.6, 0}})
blend(skyStip * rect(0, 0, 1000, 200), {angle=0, coverage=3, tool="badger 30"})
