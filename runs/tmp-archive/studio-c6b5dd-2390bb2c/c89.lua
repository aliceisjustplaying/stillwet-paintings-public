work(crown2M, {hand="body", tool="filbert 6", pile=pTC, angle=function(x,y) return 0.9*math.sin(x/20+y/25) end, angle_jitter=0.7, coverage=3.5, load=0.95, fill=true, length={8,20}, clip=crown2M})
local fringe = (crown2M:grow(6) - crown2M:shrink(2)) * above(function(x) return 436 end)
stipple(fringe, {pile=pTC, width=3.5, coverage=0.9, pressure={0.5,0.9}, dips={12,0.9,0.2}, drag={2, 0.8}, twist=0.6, cluster={0.7,4}, feather=0.4})
trees = trees + crown2M
