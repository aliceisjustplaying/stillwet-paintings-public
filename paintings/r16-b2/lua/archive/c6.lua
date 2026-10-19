LAND = below(function(x) return 446 + 1.2*math.sin(x/70) + 0.8*math.sin(x/23) end)
under = pile{{"raw umber",3},{"red earth",1},{"yellow ochre",1.5}, medium=0.55}
underfar = pile{{"raw umber",1},{"pale smalt",2},{"lead white",1}, medium=0.5}
work(LAND * rect(0,440,1000,40), {hand="body", pile=underfar, angle=0, coverage=1.8, fill=true, clip=true, length={40,90}, pressure={0.4,0.7}, seed=81})
work(LAND * rect(0,478,1000,240), {hand="broad", pile=under, angle=function(x,y) return 0.1*math.sin(x/200) end, coverage=1.6, fill=true, length={80,200}, pressure={0.4,0.7}, seed=82})
