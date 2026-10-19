local notMud = -(mud4)
local o = {hand="detail", tool="round 3", angle=0, coverage=3, length={8,25}, fill=true, clip=notMud}
o.pile = c1; work(rect(690,564,170,24) * notMud, o)
local margin = (mud4:grow(9) - mud4) * rect(690,585,180,140)
o.pile = c1; work(margin * rect(0,585,1000,35), o)
o.pile = c2; work(margin * rect(0,618,1000,110), o)
local marginL = (mud4:grow(9) - mud4) * rect(380,570,150,150)
o.pile = c1; work(marginL * rect(0,570,1000,45), o)
o.pile = c2; work(marginL * rect(0,613,1000,110), o)
