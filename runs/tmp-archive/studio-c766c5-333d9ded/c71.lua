pjl = pile{{"raw umber",2},{"smalt",1.2},{"bone black",0.4}, medium=0.4}
pjh = pile{{"lead white",2},{"yellow ochre",1.2},{"raw umber",0.5}}
bj = brush{kind="round", width=7, point=0.3, stiffness=0.5}
bj:load(pjl, 0.5)
bj:stroke({{0,446},{120,448},{250,451},{380,453},{500,455},{620,458},{740,461},{860,464},{1000,468}}, {pressure={0.4,0.35}, ramps={0.05,0.1}})
bj:wipe(0.55); bj:load(pjh, 0.45)
bj:stroke({{0,451},{120,453},{250,456},{380,458},{500,460},{620,463},{740,466},{860,469},{1000,473}}, {pressure={0.35,0.3}, ramps={0.05,0.1}})
-- cool the shadows, warm the light pool
tfree = tablemask - objall
shm = (sh_bot + sh_bowl + sh_lem + sh_pear2):soften(16) * tfree
work(shm, {hand="glaze", pile=pile{{"smalt",1},{"red earth",0.25},{"lead white",0.5}, medium=0.5}, clip=true, coverage=1.2, seed=711})
pool = ellipse(300,600,330,155):soften(105) * tfree
work(pool, {hand="glaze", pile=pile{{"yellow ochre",2},{"vermilion",0.15},{"lead white",0.5}, medium=0.5}, clip=true, coverage=1.1, seed=712})
