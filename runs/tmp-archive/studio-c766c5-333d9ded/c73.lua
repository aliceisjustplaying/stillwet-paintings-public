plemon = pile{{"chrome yellow",3},{"lead white",1.5},{"yellow ochre",0.6}}
plL = pile{{"chrome yellow",2},{"lead white",2}}
plD = pile{{"yellow ochre",1.5},{"raw umber",1.4},{"green earth",0.9},{"smalt",0.5}}
work(lemA + lemB, {hand="body", pile=plemon, clip=true, coverage=3.2, fill=true, angle=0.3, seed=751})
sA = body.ellipsoid({600,498,0},{54,48,52})
sB = body.ellipsoid({700,504,0},{50,44,48})
fL = form{{sA,dist=0.3},{sB,dist=0.3}, light={from={-1,-0.75}, front=0.55, ambient=0.22}}
work(lemA*fL:shadow{parts={1}}, {hand="body", pile=plD, clip=true, coverage=2.6, seed=752})
work(lemA*fL:lit{parts={1}, soft=0.15}, {hand="body", pile=plL, clip=true, coverage=2.2, seed=753})
work(lemB*fL:shadow{parts={2}}, {hand="body", pile=plD, clip=true, coverage=2.6, seed=754})
work(lemB*fL:lit{parts={2}, soft=0.15}, {hand="body", pile=plL, clip=true, coverage=2.2, seed=755})
pin3 = pile{{"raw umber",2.2},{"lead white",1.6},{"smalt",1}}
pin_dark = pile{{"raw umber",2.5},{"smalt",1.2},{"lead white",0.8}}
work(open_in, {hand="body", pile=pin3, clip=true, coverage=3.2, fill=true, angle=0.2, seed=756})
blend(open_in, {seed=757, coverage=1.5, pressure={0.3,0.3}})
floor = ((ellipse(600,556,72,16) + ellipse(700,562,60,15)):soften(10)) * open_in
work(floor, {hand="body", pile=pin_dark, clip=true, coverage=2.2, seed=758})
b4 = brush{kind="round", width=8, point=0.75}
b4:load(pile{{"lead white",4}}, 0.9)
b4:touch(578,472,{pressure=0.5, drag={0.6,0.5}})
b4:wipe(0.4); b4:load(pile{{"lead white",4}}, 0.85)
b4:touch(680,480,{pressure=0.45, drag={0.5,0.4}})
