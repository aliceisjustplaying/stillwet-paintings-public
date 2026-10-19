local mzone = (meadowM - bankM2:grow(1) - riverAll - oakM2:grow(1)) * rect(0, 452, 1000, 150)
meadFarL = pile{{"green earth", 2}, {"yellow ochre", 1.2}, {"lead white", 1.4}, {"raw umber", 0.7}, {"smalt", 0.3}, medium=0.15}
meadFarD = pile{{"green earth", 2}, {"raw umber", 1.2}, {"lead white", 0.6}, {"smalt", 0.4}, medium=0.15}
meadNearL = pile{{"green earth", 2}, {"yellow ochre", 1.6}, {"lead white", 0.8}, {"raw umber", 0.7}, medium=0.15}
meadNearD = pile{{"green earth", 2.2}, {"raw umber", 1.4}, {"yellow ochre", 0.5}, {"Prussian blue", 0.05}, medium=0.15}
local far = mzone * rect(0, 450, 1000, 45)
local near = mzone - rect(0, 450, 1000, 45)
local fn = noise{seed=101, octaves=3, period=60, stretch={0, 4}}
local farL = far * mask(function(x, y) return fn(x, y) > 0 and 1 or 0 end)
local nearL = near * mask(function(x, y) return fn(x, y) > -0.1 and 1 or 0 end)
work(farL, {hand="hatch", pile=meadFarL, angle=0, coverage=1.2, length={4,9}, pressure={0.2,0.4}, clip=true, angle_jitter=0.04})
work(far - farL, {hand="hatch", pile=meadFarD, angle=0, coverage=1.2, length={4,9}, pressure={0.2,0.4}, clip=true, angle_jitter=0.04})
work(nearL, {hand="hatch", pile=meadNearL, angle=0, coverage=1.1, length={6,14}, pressure={0.25,0.5}, clip=true, angle_jitter=0.06})
work(near - nearL, {hand="hatch", pile=meadNearD, angle=0, coverage=1.1, length={6,14}, pressure={0.25,0.5}, clip=true, angle_jitter=0.06})
