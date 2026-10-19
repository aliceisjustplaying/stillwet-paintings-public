pwm = pile{{"raw umber",3.5},{"smalt",1.3},{"red earth",0.5},{"lead white",1.0}}
wfree = wallmask - objall
work(wfree, {hand="broad", pile=pwm, clip=true, coverage=3.4, angle=0.08, fill=true, dips={3,0.85}, seed=601})
blend(wfree, {seed=602, coverage=2.5, pressure={0.32,0.32}})
blend(wfree, {seed=603, coverage=1.5, pressure={0.28,0.28}})
