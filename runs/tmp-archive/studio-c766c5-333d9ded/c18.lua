pbot = pile{{"bone black",1},{"green earth",1.2},{"raw umber",0.3},{"Prussian blue",0.08}}
work(bottlemask, {hand="body", pile=pbot, clip=true, coverage=3.5, angle=1.5, fill=true, seed=131})
blend(bottlemask, {seed=132, coverage=1.2, pressure={0.3,0.3}})
