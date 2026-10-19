hullpile = pile{{"bone black", 0.6}, {"raw umber", 0.7}, {"cobalt blue", 0.35}, {"lead white", 0.35}, {"vermilion", 0.06}}
hull = body_of{spine = {{352, 912}, {398, 916}, {442, 910}, {474, 902}}, widths = 26, char="firm"}
work(hull:mask(), {hand="body", pile=hullpile, coverage=2.2, fill=true, angle=0.02, pressure={0.6, 0.8}, edge=0.5})
print("hull ok")
