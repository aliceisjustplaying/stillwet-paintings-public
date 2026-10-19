skyTop = pile{{"lead white", 3}, {"smalt", 3}, {"cobalt blue", 0.6}, {"raw umber", 0.1}, medium=0.25}
skyMid = pile{{"lead white", 6}, {"pale smalt", 2}, {"smalt", 0.5}, medium=0.25}
skyLow = pile{{"lead white", 8}, {"pale smalt", 0.6}, {"chrome yellow", 0.25}, medium=0.25}
skyGlow = pile{{"lead white", 8}, {"chrome yellow", 0.9}, {"vermilion", 0.12}, {"yellow ochre", 0.2}, medium=0.25}
skyGlowHot = pile{{"lead white", 7}, {"chrome yellow", 1.4}, {"vermilion", 0.25}, medium=0.25}
local b1 = rect(0, 0, 1000, 130):soften(25)
local b2 = rect(0, 110, 1000, 150):soften(25)
local b3 = rect(0, 250, 1000, 110):soften(25)
local b4 = rect(0, 350, 1000, 100)
work(b1, {hand="broad", pile=skyTop, angle=0, coverage=2.5, fill=true, angle_jitter=0.05})
work(b2, {hand="broad", pile=skyMid, angle=0, coverage=2.5, fill=true, angle_jitter=0.05})
work(b3, {hand="broad", pile=skyLow, angle=0, coverage=2.5, fill=true, angle_jitter=0.05})
work(b4, {hand="broad", pile=skyGlow, angle=0, coverage=2.5, fill=true, angle_jitter=0.05})
work(ellipse(640, 415, 260, 45):soften(30), {hand="body", pile=skyGlowHot, angle=0, coverage=2, fill=true})
