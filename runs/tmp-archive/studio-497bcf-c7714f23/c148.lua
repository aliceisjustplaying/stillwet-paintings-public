print(drying(450,660), drying(400,700))
trackSh = pile{{"raw umber", 1.2}, {"yellow ochre", 1.2}, {"green earth", 0.8}, {"lead white", 0.5}, {"pale smalt", 0.3}, medium=0.2}
local near = path_m * mask(function(x,y) return smoothstep(625, 700, y) end)
stipple(near, {pile=trackSh, width=2.4, coverage=function(x,y) return 0.6 + 1.4 * smoothstep(625, 705, y) end, pressure={0.4,0.7}, clip=path_m, cluster=0.3, feather=0.5})
print(wait(0))
