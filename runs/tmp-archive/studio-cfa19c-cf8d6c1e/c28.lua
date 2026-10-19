rv1 = pile{{"lead white",8},{"pale smalt",1.2},{"yellow ochre",0.15}, medium=0.08}
rv2 = pile{{"lead white",6},{"pale smalt",1.5},{"cobalt blue",0.35}, medium=0.08}
work(riverM * rect(300,430,380,80), {hand="body", tool="filbert 3", pile=rv1, angle=0.08, coverage=2.5, fill=true, clip=true, pressure={0.4,0.6}, seed=171})
work(riverM * rect(680,430,340,140), {hand="body", tool="filbert 5", pile=rv2, angle=0.15, coverage=2.5, fill=true, clip=true, pressure={0.4,0.6}, seed=172})
blend(riverM, {angle=0.12, coverage=1.5, seed=173})
