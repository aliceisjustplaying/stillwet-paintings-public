owym = bowlmask - open
pin2 = pile{{"raw umber",2},{"lead white",2},{"smalt",1.2}}
work(owym, {hand="body", pile=pbowl, clip=true, coverage=3.2, fill=true, angle=0.3, seed=541})
gright2 = grad(640,600,128,95, 0.95, 0.15, 0.28, 1.0) * owym
work(gright2, {hand="body", pile=pbd, clip=true, coverage=2.0, angle=1.1, seed=542})
blend(owym, {seed=543, coverage=1.3, pressure={0.3,0.3}})
grefl2 = grad(640,628,128,80, 0.1, 0.95, 0.45, 1.0) * owym
work(grefl2, {hand="body", pile=pbr, clip=true, coverage=1.5, angle=0.1, seed=544})
work(open_in, {hand="body", pile=pin2, clip=true, coverage=3.0, fill=true, angle=0.2, seed=545})
blend(open_in, {seed=546, coverage=1.2, pressure={0.3,0.3}})
sring = ((open_in - open_in:shrink(9)):soften(4)) * bowlmask
work(sring, {hand="body", pile=pin2, clip=true, coverage=1.6, seed=547})
