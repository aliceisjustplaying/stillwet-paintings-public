ptab = pile{{"raw umber",3},{"yellow ochre",2},{"lead white",2},{"smalt",0.5}}
work(tablemask, {hand="broad", pile=ptab, clip=true, coverage=3.5, angle=0.06, fill=true, seed=61})
blend(tablemask, {seed=62, coverage=2, pressure={0.3,0.3}})
