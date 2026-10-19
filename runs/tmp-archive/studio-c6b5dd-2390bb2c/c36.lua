local seam = (warmPart:grow(6) - warmPart:shrink(6)) * trees:shrink(10)
blend(seam, {tool="badger 12", angle=function(x,y) return 0.9*math.sin(x/35 + y/50) end, angle_jitter=0.7, length={8,20}, pressure={0.25,0.45}})
