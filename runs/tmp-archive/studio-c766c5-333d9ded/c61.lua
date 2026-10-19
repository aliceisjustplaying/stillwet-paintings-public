b8 = brush{kind="filbert", width=11, stiffness=0.55}
b8:load(pile{{"lead white",2.5},{"green earth",0.5},{"pale smalt",0.6}}, 0.8)
b8:stroke({{272,398},{268,450},{266,510},{268,560},{272,594}}, {pressure={0.4,0.3}, ramps={0.2,0.3}})
b9 = brush{kind="round", width=4, point=0.5}
b9:load(pile{{"lead white",4}}, 0.9)
b9:stroke({{276,420},{274,470},{274,520},{276,560}}, {pressure={0.3,0.25}})
b9:wipe(0.5); b9:load(pile{{"lead white",3.5},{"pale smalt",0.3}}, 0.8)
b9:stroke({{295,240},{293,270},{292,296}}, {pressure={0.3,0.3}})
b9:touch(296,222,{pressure=0.4})
-- bowl rim highlight, front-left
rimhl = ribbon({{522,543},{532,550},{549,556},{572,561},{599,565}}, {9,9,8,7,6}) * bowlmask
work(rimhl, {hand="body", pile=pile{{"lead white",4},{"yellow ochre",0.4}}, clip=true, coverage=2.4, seed=651})
-- left lemon highlight + nub
b10 = brush{kind="round", width=9, point=0.7}
b10:load(pile{{"lead white",3.2},{"chrome yellow",0.5}}, 0.85)
b10:touch(106,626,{pressure=0.5, drag={0.6,0.5}})
b10:load(pile{{"yellow ochre",2},{"raw umber",0.6}}, 0.6)
b10:touch(72,642,{pressure=0.35})
