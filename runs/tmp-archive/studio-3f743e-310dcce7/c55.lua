-- Erase the flare letters: warm glow over sky part, tree dark over tree part
gold3  = pile{{"lead white", 3}, {"chrome yellow", 0.6}, {"vermilion", 0.2}}
treedark2 = pile{{"lead white", 0.4}, {"cobalt blue", 0.55}, {"green earth", 0.3}, {"raw umber", 0.6}, {"bone black", 0.65}}

skyfix = rect(565, 425, 270, 24)
work(skyfix, {hand="body", pile=gold3, coverage=2.2, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=1})
blend(skyfix, {coverage=0.8})

treefix = rect(560, 443, 280, 74)
tltop = function(x) return 452 + 24 * math.sin(x / 23 + 1) + 16 * math.sin(x / 61) + 9 * math.sin(x / 13 + 2) end
work(below(tltop) * treefix, {hand="body", pile=treedark2, coverage=2.4, fill=true, angle=0.02, pressure={0.7, 0.9}, edge=0.3, clip=true})
print("flare fixed")
