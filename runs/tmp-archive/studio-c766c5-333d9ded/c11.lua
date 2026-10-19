pdark2 = pile{{"raw umber",4},{"smalt",1.5},{"lead white",0.9},{"bone black",0.6}}
work(wallmask, {hand="broad", pile=pdark2, clip=true, coverage=3, angle=0.1, fill=true, seed=71})
blend(wallmask, {seed=72, coverage=2, pressure={0.3,0.3}})
