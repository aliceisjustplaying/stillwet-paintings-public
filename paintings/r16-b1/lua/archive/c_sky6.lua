skyTopS = pile{{"lead white", 2.5}, {"smalt", 3}, {"cobalt blue", 1}, medium=0.15}
skyMidS = pile{{"lead white", 4.5}, {"smalt", 1.8}, {"pale smalt", 1}, {"cobalt blue", 0.35}, medium=0.15}
stipple(skyStip * rect(0, 0, 1000, 150), {pile=skyTopS, width=4.5, coverage=function(x, y) return 1.3 * clamp((140 - y) / 110, 0, 1) end, cluster=0.1, pressure={0.35, 0.7}, feather=0.6, dips={40, 0.6, 0}})
stipple(skyStip * rect(0, 40, 1000, 190), {pile=skyMidS, width=4.5, coverage=function(x, y) return 1.1 * math.exp(-((y - 125) / 55)^2) end, cluster=0.1, pressure={0.35, 0.7}, feather=0.6, dips={40, 0.6, 0}})
