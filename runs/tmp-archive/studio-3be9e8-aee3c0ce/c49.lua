tTop2 = pile{{"lead white",1.5},{"yellow ochre",0.8},{"raw umber",1.3},{"bone black",0.2},{"green earth",0.3}}
tShad = pile{{"raw umber",1.5},{"bone black",0.45},{"lead white",0.6},{"yellow ochre",0.4},{"green earth",0.3}}
local objs = (jug + lemons):grow(1)
local top = table_top - objs
work(top, {hand="body", tool="filbert 12", pile=tTop2, coverage=2.2, angle=0, angle_jitter=0.04, length={50,130}, edge="firm", fill=true, clip=table_top})
jugTabShadow = poly({{300,606},{425,603},{570,521},{345,521}}) - objs
lemShadow = (ellipse(655, 606, 72, 30) + ellipse(768, 566, 55, 20)) - objs
local sh = (jugTabShadow + lemShadow) * table_top
work(sh, {hand="body", tool="filbert 8", pile=tShad, coverage=2, angle=0, angle_jitter=0.1, length={20,60}, edge="soft", fill=true, clip=table_top - objs})
