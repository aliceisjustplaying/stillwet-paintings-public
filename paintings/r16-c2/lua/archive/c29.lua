mudL2 = poly({{-10,566},{80,561},{170,566},{240,569},{300,574},{338,580},{346,589},{400,596},{428,606},{440,620},{468,630},{488,648},{503,670},{518,690},{532,720},{-10,720}}):roughen(2.5, 18, 81)
mudR2 = poly({{1010,578},{950,581},{900,586},{880,594},{862,601},{852,618},{846,640},{836,660},{828,690},{824,720},{1010,720}}):roughen(2.5, 18, 82)
local cut = ((mudL - mudL2) + (mudR - mudR2)):grow(3)
local wc = -(mudL2 + mudR2)
local o = {hand="body", tool="filbert 8", angle=0, coverage=3, length={25,70}, fill=true, clip=wc, angle_jitter=0.02}
o.pile = w3; work(cut * rect(0,520,1000,78), o)
o.pile = wat3; work(cut * rect(0,592,1000,130), o)
