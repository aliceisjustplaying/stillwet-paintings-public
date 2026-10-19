vs2 = pile{{"lead white",3},{"cobalt blue",0.5},{"red earth",0.3},{"raw umber",0.3}, medium=0.3}
md2 = pile{{"raw umber",1.5},{"bone black",0.3},{"cobalt blue",0.35},{"lead white",0.9},{"red earth",0.2}, medium=0.35}
work(mud4 * rect(0,558,1000,36), {hand="scumble", pile=vs2, angle=0, coverage=1.1, load=0.35, clip=mud4})
work(mud4 * rect(0,592,1000,50), {hand="scumble", pile=md2, angle=0, coverage=1.0, load=0.35, clip=mud4})
