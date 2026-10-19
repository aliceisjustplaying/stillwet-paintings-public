wfree = wallmask - objall
pwmid = pile{{"raw umber",3.2},{"smalt",1.2},{"red earth",0.4},{"lead white",1.2}}
work(wfree, {hand="broad", pile=pwmid, clip=true, coverage=3.6, angle=0.1, fill=true, dips={3,0.9}, seed=811})
blend(wfree, {seed=812, coverage=3.0, pressure={0.32,0.32}})
blend(wfree, {seed=813, coverage=1.5, pressure={0.28,0.28}})
