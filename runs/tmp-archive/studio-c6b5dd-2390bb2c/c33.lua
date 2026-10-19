blend((litM + shM):grow(8) * trees:shrink(3), {tool="badger 16", angle=function(x,y) return 0.8*math.sin(x/30 + y/40) end, angle_jitter=0.6, length={10,25}})
