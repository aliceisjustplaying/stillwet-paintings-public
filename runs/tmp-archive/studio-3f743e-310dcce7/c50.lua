-- Decisive cover of pale patches; water over the reflection smear
spitvery = pile{{"raw umber", 1}, {"bone black", 0.5}, {"green earth", 0.3}, {"cobalt blue", 0.25}, {"lead white", 0.3}}
watermid  = pile{{"lead white", 0.9}, {"cobalt blue", 1.0}, {"raw umber", 0.45}, {"bone black", 0.35}, {"green earth", 0.3}, {"vermilion", 0.1}}
postdark  = pile{{"bone black", 0.55}, {"raw umber", 0.75}, {"cobalt blue", 0.25}, {"lead white", 0.2}}

patches = ellipse(180, 1210, 96, 30) + ellipse(420, 1180, 76, 25) + ellipse(700, 1140, 86, 26) + ellipse(880, 1090, 76, 25)
work(patches, {hand="broad", pile=spitvery, coverage=2.2, fill=true, angle=0.05, pressure={0.8, 0.95}, edge=1})
work(patches, {hand="scumble", pile=spitvery, coverage=1.6, angle=0.05, edge=1})

rpale = rect(380, 940, 60, 100)
work(rpale, {hand="body", pile=watermid, coverage=2.0, fill=true, angle=0.02, pressure={0.7, 0.85}, edge=1})

-- one quiet dark hint of reflection
rb = brush{kind="round", width=6, point=1, stiffness=0.5}
rb:load(postdark, 0.9)
rb:stroke({{399, 948}, {403, 982}, {406, 1012}}, {pressure={0.5, 0.1}, ramps={0.15, 0.5}})
print("patches settled")
