shadows = (ellipse(430,636,185,40) + ellipse(200,660,95,28) + ellipse(900,662,75,24) + ellipse(755,656,130,34)):soften(22)
psh = pile{{"raw umber",2},{"smalt",1},{"bone black",0.6}, medium=0.25}
m = shadows * tablemask
work(m, {hand="glaze", pile=psh, clip=true, coverage=2.0, seed=91})
blend(m:soften(25), {seed=92, coverage=1.5, pressure={0.25,0.25}})
