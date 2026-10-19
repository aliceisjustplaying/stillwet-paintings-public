local gm = mud4 - (hull + inner + contact):grow(3)
gz3 = pile{{"raw umber",1},{"bone black",0.9},{"cobalt blue",0.35},{"red earth",0.1}, medium=0.65}
work(gm * rect(0,622,1000,110), {hand="glaze", pile=gz3, angle=0, coverage=1.6, clip=gm})
work(gm * rect(0,660,1000,70), {hand="glaze", pile=gz3, angle=0.02, coverage=1.6, clip=gm})
work(gm * (rect(0,640,180,90) + rect(880,640,130,90)), {hand="glaze", pile=gz3, angle=-0.03, coverage=1.4, clip=gm})
blend(gm, {angle=0})
blend(gm, {angle=0.07})
