mudArea = (mudL2 + mudR2) - pools:grow(1)
mG = pile{{"raw umber",1.5},{"green earth",0.6},{"bone black",0.2},{"lead white",0.3}}
local nn = noise{seed=91, period=90, octaves=3, stretch={0,4}}
work(mudArea, {hand="body", tool="flat 5", pile=mA, angle=0.02, coverage=0.9, load_at=function(x,y) return 0.25 + 0.4*nn:at01(x,y) end, length={10,35}, clip=mudArea, angle_jitter=0.05})
work(mudArea, {hand="body", tool="flat 4", pile=mG, angle=0.0, coverage=0.4, length={8,25}, load=0.4, clip=mudArea, angle_jitter=0.05})
work(mudArea * rect(0,560,1000,70), {hand="body", tool="flat 3", pile=mC, angle=0.0, coverage=0.5, length={8,30}, load=0.35, clip=mudArea, angle_jitter=0.04})
