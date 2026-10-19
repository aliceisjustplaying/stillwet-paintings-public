wait(6 * 60)
-- Sky palette trials on the spare rect, light pressure so I can compare
sk1 = pile{{"lead white", 1}, {"cobalt blue", 2.5}, {"vermilion", 2}, {"chrome yellow", 2}}
sk2 = pile{{"lead white", 1.5}, {"cobalt blue", 2}, {"vermilion", 1}, {"chrome yellow", 1}}
sk3 = pile{{"lead white", 1}, {"smalt", 2}, {"vermilion", 0.5}}
sk4 = pile{{"lead white", 1.5}, {"yellow ochre", 1}, {"vermilion", 0.4}}
trial = rect(0, 1266, 900, 180)
work(trial, {hand="detail", pile=sk1, coverage=1.6, edge=0.4, ruler=true, clip=true})

