plb = pile{{"lead white",2},{"green earth",0.8},{"pale smalt",0.5},{"raw umber",0.5}}
pmb = pile{{"lead white",1},{"green earth",1.5},{"bone black",0.5},{"pale smalt",0.5}}
pdb = pile{{"bone black",1},{"green earth",1},{"smalt",0.5}}
b2 = brush{kind="filbert", width=16, stiffness=0.5}
b2:load(plb, 0.7)
b2:stroke({{278,392},{271,440},{267,500},{269,560},{273,600}}, {pressure={0.55,0.22}, ramps={0.2,0.35}})
b2:stroke({{294,326},{282,360},{275,392}}, {pressure={0.5,0.3}, ramps={0.2,0.3}})
b2:wipe(0.5); b2:load(plb, 0.55)
b2:stroke({{297,228},{294,262},{293,298}}, {pressure={0.45,0.4}})
b3 = brush{kind="round", width=7, point=0.5}
b3:load(pile{{"lead white",3},{"pale smalt",0.25}}, 0.8)
b3:stroke({{280,404},{281,444},{283,486}}, {pressure={0.5,0.28}})
b2:wipe(0.8); b2:load(pmb, 0.45)
b2:stroke({{345,460},{343,520},{341,566}}, {pressure={0.3,0.25}})
b2:load(pdb, 0.8)
b2:stroke({{340,600},{300,612},{262,600}}, {pressure={0.5,0.4}})
blend(bottlemask, {seed=511, coverage=0.7, pressure={0.25,0.25}})
