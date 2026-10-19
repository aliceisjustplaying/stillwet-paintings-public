gz2 = pile{{"raw umber",1},{"bone black",0.8},{"cobalt blue",0.4}, medium=0.7}
work(mud4 * rect(0,615,1000,110), {hand="glaze", pile=gz2, angle=0, coverage=1.5, clip=mud4})
work(mud4 * rect(0,660,1000,70), {hand="glaze", pile=gz2, angle=0.03, coverage=1.5, clip=mud4})
blend(mud4, {angle=0})
blend(mud4, {angle=-0.08})
