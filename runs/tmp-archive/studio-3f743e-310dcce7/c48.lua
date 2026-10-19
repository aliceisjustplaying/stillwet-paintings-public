-- Reed-bed tongue, mooring post, boat reflection, bank surface
spitdark  = pile{{"raw umber", 1}, {"bone black", 0.45}, {"green earth", 0.35}, {"cobalt blue", 0.2}, {"lead white", 0.25}}
hullpile  = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
postdark  = pile{{"bone black", 0.55}, {"raw umber", 0.75}, {"cobalt blue", 0.25}, {"lead white", 0.2}}

-- tongue of reeds reaching into the water around x 500-640
tongue = poly({{500, 1128}, {560, 1102}, {620, 1088}, {665, 1096}, {640, 1130}, {560, 1160}, {500, 1170}}, true)
work(tongue, {hand="body", pile=spitdark, coverage=2.4, fill=true, angle=0.05, pressure={0.7, 0.9}, edge=0.4})

-- mooring post at the bank edge, raking slightly
post = ribbon({{596, 1010}, {590, 952}}, 6)
work(post, {hand="body", pile=postdark, coverage=2.2, fill=true, angle=0.02, edge=0.3, clip=true})

-- boat reflection: soft broken smear below the hull
refl = ribbon({{398, 948}, {404, 992}, {408, 1032}}, {22, 30, 40})
work(refl, {hand="scumble", pile=hullpile, coverage=0.8, angle=0.02, edge=1})

-- bank surface: subtle variation
spitwarm = pile{{"lead white", 1}, {"yellow ochre", 0.3}, {"raw umber", 0.5}, {"green earth", 0.2}}
patches = ellipse(180, 1210, 90, 30) + ellipse(420, 1180, 70, 24) + ellipse(700, 1140, 80, 26) + ellipse(880, 1090, 70, 24)
work(patches, {hand="scumble", pile=spitwarm, coverage=0.5, angle=0.05, edge=1})
print("tongue, post, reflection in")
