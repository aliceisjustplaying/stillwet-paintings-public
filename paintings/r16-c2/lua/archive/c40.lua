local chan = -(mud4)
local rem = (mudAll2 - mud4):grow(3) * rect(0,560,1000,170)
local o = {hand="body", tool="filbert 7", angle=0, coverage=3, length={20,60}, fill=true, clip=chan * rect(0,560,1000,170), angle_jitter=0.02}
o.pile=c2; work(rem * rect(0,560,1000,80), o)
o.pile=c3; work(rem * rect(0,635,1000,90), o)
