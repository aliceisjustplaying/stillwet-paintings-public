print(wait(36*60)); print(drying(340,300), drying(340,200))
glazeU2 = pile{{"raw umber",1},{"red earth",0.7},{"smalt",0.15}, medium=0.7}
work(sailsM, {hand="glaze", tool="filbert 10", pile=glazeU2, angle=-1.5, coverage=1.2, clip=true})
blend(sailsM:shrink(2), {angle=-1.5})
