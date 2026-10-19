band = rect(0,596,1000,120):soften(28) * tablemask
pwarm = pile{{"yellow ochre",1.5},{"raw umber",1},{"lead white",0.7}, medium=0.5}
work(band, {hand="glaze", pile=pwarm, clip=true, coverage=1.3, seed=121})
blend((shadows:soften(45) * tablemask), {seed=122, coverage=2.5, pressure={0.25,0.25}})
blend(band, {seed=123, coverage=1.5, pressure={0.3,0.3}})
