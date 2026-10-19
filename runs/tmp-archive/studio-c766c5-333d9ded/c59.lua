plL = pile{{"chrome yellow",2},{"lead white",2}}
plD = pile{{"yellow ochre",1.5},{"raw umber",1.4},{"green earth",0.9},{"smalt",0.5}}
sA = body.ellipsoid({600,498,0},{54,48,52})
sB = body.ellipsoid({700,504,0},{50,44,48})
fL = form{{sA,dist=0.3},{sB,dist=0.3}, light={from={-1,-0.75}, front=0.55, ambient=0.22}}
work(lemA * fL:shadow{parts={1}}, {hand="body", pile=plD, clip=true, coverage=3.0, seed=611})
work(lemA * fL:lit{parts={1}, soft=0.12}, {hand="body", pile=plL, clip=true, coverage=2.4, seed=612})
work(lemB * fL:shadow{parts={2}}, {hand="body", pile=plD, clip=true, coverage=3.0, seed=613})
work(lemB * fL:lit{parts={2}, soft=0.12}, {hand="body", pile=plL, clip=true, coverage=2.4, seed=614})
rlA = grad(600,498,62,50, 0.5, 1.0, 0.55, 1.0)
work(lemA*rlA, {hand="body", pile=pile{{"yellow ochre",1.6},{"lead white",1.2},{"vermilion",0.15}}, clip=true, coverage=1.6, seed=615})
b7 = brush{kind="round", width=10, point=0.8}
b7:load(pile{{"lead white",4}}, 0.85)
b7:touch(576,474,{pressure=0.55, drag={0.7,0.6}})
b7:wipe(0.3); b7:load(pile{{"lead white",4}}, 0.7)
b7:touch(680,482,{pressure=0.5, drag={0.6,0.5}})
