ptab = pile{{"yellow ochre",3},{"red earth",1.5},{"raw umber",1.5},{"lead white",2}}
work(tablemask, {hand="broad", pile=ptab, clip=true, coverage=3.5, angle=0.06, fill=true, seed=51})
blend(tablemask, {seed=52, coverage=2, pressure={0.3,0.3}})
