owym = bowlmask - open
pbd = pile{{"raw umber",1.5},{"smalt",1.5},{"lead white",1.2}}
pbr = pile{{"yellow ochre",1.2},{"lead white",1.5},{"red earth",0.25}}
rimshadow = ((open:grow(11) - open):soften(7)) * owym
work(rimshadow, {hand="body", pile=pbd, clip=true, coverage=1.8, angle=0.3, seed=321})
gright = grad(640,600,128,90, 0.9, 0.25, 0.35, 1.0) * owym
work(gright, {hand="body", pile=pbd, clip=true, coverage=1.6, angle=1.1, seed=322})
grefl = grad(640,626,128,80, 0.15, 0.9, 0.4, 1.0) * owym
work(grefl, {hand="body", pile=pbr, clip=true, coverage=1.5, angle=0.1, seed=323})
rim_lit = grad(640,538,126,32, -0.9, -0.35, 0.25, 1.0) * rimband
work(rim_lit, {hand="body", pile=pile{{"lead white",4},{"yellow ochre",0.6}}, clip=true, coverage=1.6, angle=0.15, seed=324})
