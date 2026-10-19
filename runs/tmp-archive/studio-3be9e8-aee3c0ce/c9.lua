tTop = pile{{"lead white",2},{"yellow ochre",1},{"raw umber",1.2},{"bone black",0.15}}
tBack = pile{{"lead white",1.2},{"yellow ochre",0.8},{"raw umber",1.6},{"bone black",0.3}}
tFront = pile{{"raw umber",2},{"yellow ochre",0.6},{"bone black",0.6},{"lead white",0.5}}
local objs = (jug + lemons):grow(1)
local top = table_top - objs
work(top, {hand="body", tool="filbert 12", pile=tTop, coverage=2, angle=0, angle_jitter=0.05, length={50,120}, edge="firm", fill=true})
local backband = rect(0, 521, 1000, 50):soften(20) * top
work(backband, {hand="body", tool="filbert 10", pile=tBack, coverage=1.2, angle=0, length={40,100}, threshold=0.35, edge="soft"})
work(front, {hand="body", tool="filbert 12", pile=tFront, coverage=2, angle=0, angle_jitter=0.04, length={60,140}, edge="firm", fill=true})
