local dk = pile{{"raw umber", 1}, {"green earth", 1.1}, {"yellow ochre", 0.6}, {"bone black", 0.05}, medium=0.45}
work(PATHM, {hand="scumble", tool="filbert 6", pile=dk, angle=-0.4, angle_jitter=0.3, length={10,25}, coverage=1.4, load_at=function(x, y) return clamp((y - 540)/90, 0.05, 0.8) end, clip=true, seed=3801})
local gr = pile{{"green earth", 2}, {"yellow ochre", 0.8}, {"raw umber", 0.6}, {"Prussian blue", 0.05}, medium=0.2}
lose(PATHM, {pile=gr, where=1, tool="filbert 3", reach={4, 5}, load=0.3, seed=3802})
blend(PATHM:grow(3), {angle=-0.45, length={8,20}, coverage=0.8, seed=3803})
