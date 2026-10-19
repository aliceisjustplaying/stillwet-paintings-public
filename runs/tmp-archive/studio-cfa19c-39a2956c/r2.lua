local R = riverM
rvD = pile{{"lead white",4.5},{"pale smalt",1.6},{"cobalt blue",0.9},{"smalt",0.3},{"raw umber",0.05}, medium=0.06}
rvE = pile{{"lead white",6},{"pale smalt",1.5},{"cobalt blue",0.5},{"yellow ochre",0.05}, medium=0.06}
work(R * mask(function(x,y) return smoothstep(640,760,x)*smoothstep(900,820,x) end), {hand="body", tool="filbert 3", pile=rvE, angle=0.15, coverage=2.4, fill=true, clip=true, pressure={0.5,0.75}, seed=3011})
work(R * mask(function(x,y) return smoothstep(800,900,x) end), {hand="body", tool="filbert 4", pile=rvD, angle=0.15, coverage=2.6, fill=true, clip=true, pressure={0.5,0.75}, seed=3012})
blend(R:shrink(0.5) * rect(600,440,420,130), {tool={kind="badger", width=10}, angle=0.14, coverage=1.2, clip=true, seed=3013})
