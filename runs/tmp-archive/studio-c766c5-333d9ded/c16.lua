psh = pile{{"raw umber",1.5},{"smalt",1},{"bone black",0.25}, medium=0.4}
sb = brush{kind="filbert", width=44, stiffness=0.35, splay=0.25}
sb:load(psh, 0.35)
sb:stroke({{300,612},{420,628},{540,644},{640,656}}, {pressure={0.6,0.05}, ramps={0.12,0.6}})
sb:wipe(0.5); sb:load(psh, 0.25)
sb:stroke({{640,646},{760,660},{900,670}}, {pressure={0.5,0.05}, ramps={0.15,0.6}})
sb:stroke({{130,652},{230,664},{330,674}}, {pressure={0.5,0.08}, ramps={0.15,0.55}})
sb:stroke({{845,650},{920,660},{990,666}}, {pressure={0.45,0.08}, ramps={0.15,0.55}})
blend(shadows:soften(30), {seed=111, coverage=1.6, pressure={0.25,0.25}})
