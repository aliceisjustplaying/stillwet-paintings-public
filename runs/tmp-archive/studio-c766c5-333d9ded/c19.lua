pbowl = pile{{"lead white",5},{"pale smalt",0.8},{"yellow ochre",0.4}}
work(bowlmask, {hand="body", pile=pbowl, clip=true, coverage=3.5, fill=true, angle=0.25, seed=141})
blend(bowlmask, {seed=142, coverage=1.5, pressure={0.3,0.3}})
