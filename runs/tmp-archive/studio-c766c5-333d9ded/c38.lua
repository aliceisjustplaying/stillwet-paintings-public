pwdark2 = pile{{"raw umber",3.5},{"smalt",1.2},{"lead white",1.6},{"bone black",0.3}}
work(bottlemask, {hand="body", pile=pbot, clip=true, coverage=3.5, angle=1.5, fill=true, seed=341})
blend(bottlemask, {seed=342, coverage=0.8, pressure={0.3,0.3}})
work(wallmask - objall, {hand="broad", pile=pwdark2, clip=true, coverage=3.0, angle=0.1, fill=true, seed=343})
blend((wallmask - objall):soften(10), {seed=344, coverage=1.2, pressure={0.3,0.3}})
