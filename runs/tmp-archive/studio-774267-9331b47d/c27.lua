local m = mask(function(x, y) return (y > far(x) + 2 and y < 468) and 1 or 0 end)
blend(m, {angle=0, ruler=true, length={60,160}, coverage=1.2, seed=2701})
blend(m, {angle=math.pi/2, length={6,14}, coverage=0.6, seed=2702})
