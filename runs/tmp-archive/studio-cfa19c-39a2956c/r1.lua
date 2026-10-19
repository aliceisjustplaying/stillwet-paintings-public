local R = riverM
work(R * mask(function(x,y) return smoothstep(640,560,x) end), {hand="body", tool="filbert 3", pile=rvA, angle=0.12, coverage=3, fill=true, clip=true, pressure={0.5,0.75}, seed=3001})
work(R * mask(function(x,y) return smoothstep(560,640,x)*smoothstep(860,780,x) end), {hand="body", tool="filbert 3", pile=rvB, angle=0.15, coverage=3, fill=true, clip=true, pressure={0.5,0.75}, seed=3002})
work(R * mask(function(x,y) return smoothstep(780,860,x) end), {hand="body", tool="filbert 4", pile=rvC, angle=0.15, coverage=3, fill=true, clip=true, pressure={0.5,0.75}, seed=3003})
blend(R:shrink(0.5), {tool={kind="badger", width=10}, angle=0.14, coverage=1.2, clip=true, seed=3004})
