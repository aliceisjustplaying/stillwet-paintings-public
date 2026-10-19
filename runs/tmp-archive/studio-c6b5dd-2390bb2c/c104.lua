local ft = farTrees * above(function(x) return 452 end)
work(ft, {hand="body", tool="filbert 4", pile=pFar, angle=0, angle_jitter=0.4, coverage=3.5, load=0.9, fill=true, length={8,25}, clip=ft:grow(1)})
