local m = ellipse(662, 592, 50, 36):soften(8)
blend(m, {tool="badger 12", angle=0, angle_jitter=0.1, length={20,45}, pressure={0.3,0.5}, coverage=1.5})
local e = rect(585, 556, 160, 80) - rect(605, 566, 120, 60)
blend(e, {tool="badger 12", angle=0, length={20,40}, pressure={0.25,0.4}})
