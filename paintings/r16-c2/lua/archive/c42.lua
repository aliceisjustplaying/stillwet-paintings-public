chanM = rect(0,562,1000,160) - mud4
local o = {hand="body", tool="filbert 9", angle=0, coverage=3.2, length={25,80}, fill=true, clip=chanM, angle_jitter=0.02, load=0.9}
o.pile=c1; work(chanM * rect(0,560,1000,40), o)
o.pile=c2; work(chanM * rect(0,595,1000,55), o)
o.pile=c3; work(chanM * rect(0,645,1000,80), o)
blend(chanM, {angle=0})
blend(chanM, {angle=0.1})
