phl = pile{{"lead white",4},{"pale smalt",0.35},{"green earth",0.25}}
phl2 = pile{{"lead white",2},{"pale smalt",0.8},{"green earth",0.5}}
b = brush{kind="round", width=10, point=0.4, stiffness=0.7}
b:load(phl2, 0.9)
b:stroke({{277,398},{271,450},{268,505},{269,555},{273,590}}, {pressure={0.5,0.3}, ramps={0.12,0.18}})
b:stroke({{299,322},{288,350},{279,386}}, {pressure={0.5,0.4}, ramps={0.12,0.15}})
b:wipe(0.4); b:load(phl, 0.8)
b:stroke({{298,232},{295,264},{293,298}}, {pressure={0.35,0.4}})
b:touch(300,224,{pressure=0.4, drag={0.4,-0.2}})
b2 = brush{kind="round", width=4, point=0.7}
b2:load(pile{{"lead white",4}}, 0.95)
b2:stroke({{276,424},{272,470},{271,520},{273,560}}, {pressure={0.28,0.22}})
b2:wipe(0.4); b2:load(pile{{"lead white",1.6},{"pale smalt",1},{"green earth",0.5}}, 0.85)
b2:stroke({{347,470},{345,520},{344,566}}, {pressure={0.25,0.25}})
b3 = brush{kind="flat", width=22, stiffness=0.6}
b3:load(pile{{"bone black",1},{"green earth",0.4}}, 0.7)
b3:stroke({{264,598},{300,606},{338,598}}, {pressure={0.6,0.55}})
