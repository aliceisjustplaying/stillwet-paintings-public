plLit = pile{{"lead white",3.5},{"chrome yellow",1.6}}
plDark = pile{{"yellow ochre",1.6},{"raw umber",1.3},{"green earth",0.8},{"smalt",0.4}}
sA = body.ellipsoid({600,498,0},{54,48,52})
sB = body.ellipsoid({700,504,0},{50,44,48})
fL = form{{sA,dist=0.3},{sB,dist=0.3}, light={from={-1,-0.75}, front=0.55, ambient=0.22}}
work(lemA * fL:shadow{parts={1}}, {hand="body", pile=plDark, clip=true, coverage=2.4, seed=521})
work(lemA * fL:lit{parts={1}, soft=0.15}, {hand="body", pile=plLit, clip=true, coverage=2.2, seed=522})
work(lemB * fL:shadow{parts={2}}, {hand="body", pile=plDark, clip=true, coverage=2.4, seed=523})
work(lemB * fL:lit{parts={2}, soft=0.15}, {hand="body", pile=plLit, clip=true, coverage=2.2, seed=524})
b4 = brush{kind="round", width=9, point=0.7}
b4:load(pile{{"lead white",3}}, 0.8)
b4:touch(578,478,{pressure=0.5, drag={0.6,0.5}})
b4:touch(682,486,{pressure=0.45, drag={0.5,0.4}})
rlA = grad(600,498,62,50, 0.7, 0.8, 0.5, 1.0)
work(lemA*rlA, {hand="body", pile=pile{{"yellow ochre",1.5},{"lead white",1.5},{"red earth",0.3}}, clip=true, coverage=1.4, seed=525})
