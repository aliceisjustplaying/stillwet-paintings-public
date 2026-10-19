reflO = outline{{-10,470,"c"},{458,466,"c"},{452,480},{438,500},{420,512},{398,520},{388,540},{370,560},{352,580},{345,605},{330,630},{318,650},{300,668},{285,690},{275,720,"c"},{-10,720,"c"}, closed=true, char="soft", seed=51, lobe=14, amount=1.0}
refl = reflO:mask()
pRefl = pile{{"Prussian blue",0.35},{"yellow ochre",1},{"raw umber",1.5},{"bone black",0.3},{"lead white",0.5},{"smalt",0.4}}
work(refl, {hand="body", tool="filbert 10", pile=pRefl, angle=math.pi/2, angle_jitter=0.15, coverage=3.2, load=0.9, fill=true, length={25,70}, edge="soft"})
blend(refl, {angle=0, angle_jitter=0.03, tool="badger 30", clip=true})
