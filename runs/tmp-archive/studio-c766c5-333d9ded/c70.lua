rimhl = ribbon({{522,543},{532,550},{549,556},{572,561},{599,565}}, {9,9,8,7,6}) * bowlmask
work(rimhl, {hand="body", pile=pile{{"lead white",4},{"yellow ochre",0.35}}, clip=true, coverage=2.4, seed=701})
rimhr = ribbon({{681,565},{708,561},{731,556},{748,550},{758,543}}, {6,7,8,9,9}) * bowlmask
work(rimhr, {hand="body", pile=pbd, clip=true, coverage=1.8, seed=702})
b4 = brush{kind="round", width=8, point=0.75}
b4:load(pile{{"lead white",4}}, 0.9)
b4:touch(578,472,{pressure=0.5, drag={0.6,0.5}})
b4:wipe(0.4); b4:load(pile{{"lead white",4}}, 0.85)
b4:touch(680,480,{pressure=0.45, drag={0.5,0.4}})
b4:wipe(0.4); b4:load(pile{{"lead white",3.5}}, 0.85)
b4:touch(108,624,{pressure=0.45, drag={0.5,0.5}})
b4:wipe(0.4); b4:load(pile{{"lead white",3}}, 0.8)
b4:touch(828,570,{pressure=0.4, drag={0.4,0.6}})
