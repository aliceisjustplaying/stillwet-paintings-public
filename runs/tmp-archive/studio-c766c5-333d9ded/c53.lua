sC = body.ellipsoid({126,644,0},{54,36,42})
fC = form{{sC,dist=0.3}, light={from={-1,-0.75}, front=0.55, ambient=0.22}}
work(lemC * fC:shadow{parts={1}}, {hand="body", pile=plDark, clip=true, coverage=2.4, seed=551})
work(lemC * fC:lit{parts={1}, soft=0.15}, {hand="body", pile=plLit, clip=true, coverage=2.2, seed=552})
rlC = grad(126,644,56,40, 0.7, 0.85, 0.5, 1.0)
work(lemC*rlC, {hand="body", pile=pile{{"yellow ochre",1.5},{"lead white",1.4},{"red earth",0.3}}, clip=true, coverage=1.4, seed=553})
b5 = brush{kind="round", width=8, point=0.7}
b5:load(pile{{"lead white",3}}, 0.8)
b5:touch(108,626,{pressure=0.5, drag={0.6,0.5}})
-- pear: highlight and blush
b5:wipe(0.4); b5:load(pile{{"lead white",3},{"chrome yellow",0.4}}, 0.7)
b5:touch(828,576,{pressure=0.45, drag={0.5,0.7}})
blush = grad(852,600,48,60, -0.8, -0.4, 0.45, 1.0) * pear
work(blush, {hand="body", pile=pile{{"red earth",1},{"yellow ochre",0.8},{"vermilion",0.2}}, clip=true, coverage=1.2, seed=554})
-- bowl rim highlight on the left
b6 = brush{kind="filbert", width=9, stiffness=0.5}
b6:load(pile{{"lead white",4},{"yellow ochre",0.3}}, 0.75)
b6:stroke({{524,556},{540,568},{562,576}}, {pressure={0.5,0.4}, ramps={0.15,0.3}})
