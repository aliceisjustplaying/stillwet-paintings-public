pgl = pile{{"lead white",2.2},{"green earth",0.6},{"pale smalt",0.7}}
b11 = brush{kind="round", width=9, point=0.45, stiffness=0.6}
b11:load(pgl, 0.85)
b11:stroke({{276,398},{270,450},{267,510},{269,560},{273,592}}, {pressure={0.5,0.35}, ramps={0.15,0.2}})
b11:stroke({{298,322},{285,352},{276,388}}, {pressure={0.5,0.42}, ramps={0.15,0.2}})
b11:wipe(0.4); b11:load(pgl, 0.7)
b11:stroke({{297,232},{294,266},{292,300}}, {pressure={0.4,0.4}})
b11:touch(299,223,{pressure=0.45})
b12 = brush{kind="round", width=3.5, point=0.6}
b12:load(pile{{"lead white",4}}, 0.9)
b12:stroke({{275,420},{271,480},{271,540},{274,580}}, {pressure={0.3,0.25}})
b12:wipe(0.5); b12:load(pile{{"lead white",2},{"pale smalt",0.6},{"green earth",0.4}}, 0.8)
b12:stroke({{347,472},{344,520},{343,566}}, {pressure={0.3,0.3}})
b13 = brush{kind="flat", width=20, stiffness=0.6}
b13:load(pile{{"bone black",1},{"green earth",0.5}}, 0.75)
b13:stroke({{262,596},{300,604},{340,596}}, {pressure={0.6,0.6}})
