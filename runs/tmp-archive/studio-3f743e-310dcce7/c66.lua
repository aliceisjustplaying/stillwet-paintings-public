-- Wisps in the glow; bridge the left seam
wisp = pile{{"lead white", 1.6}, {"vermilion", 0.25}, {"chrome yellow", 0.2}, {"raw umber", 0.2}, medium=0.35}
treedark3 = pile{{"lead white", 0.3}, {"cobalt blue", 0.5}, {"green earth", 0.3}, {"raw umber", 0.65}, {"bone black", 0.75}}

wispz = rect(570, 366, 320, 70)
work(wispz, {hand="scumble", pile=wisp, coverage=0.5, angle=0.02, edge=1})

bridge = ellipse(560, 428, 30, 42) + ellipse(545, 470, 26, 30)
work(bridge, {hand="body", pile=treedark3, coverage=2.4, fill=true, angle=0.02, pressure={0.75, 0.9}, edge=0.25, clip=true})

notch = ellipse(516, 410, 22, 18)
work(notch, {hand="detail", pile=treedark3, coverage=2.0, fill=true, edge=0.25, clip=true})
print("wisps and bridge")
print("boat dryness:", drying(420, 910), drying(600, 1150))
