local m = mask(function(x, y) return (y > far(x) + 2 and y < 470) and 1 or 0 end)
blend(m, {angle=0, ruler=true, length={60,200}, coverage=1.3, seed=1901})
-- a veil of warm haze over the far half, wet into wet
local veil = pile{{"lead white", 4}, {"pale smalt", 1}, {"yellow ochre", 0.3}, {"green earth", 0.4}, medium=0.3}
local vm = mask(function(x, y) return (y > far(x) + 2 and y < 440) and 1 or 0 end)
work(vm, {hand="body", tool="flat 8", pile=veil, angle=0, angle_jitter=0.03, length={80,200}, coverage=1.0, pressure={0.25,0.4}, load=0.5, seed=1902})
blend(vm, {angle=0, ruler=true, length={100,300}, coverage=1, seed=1903})
