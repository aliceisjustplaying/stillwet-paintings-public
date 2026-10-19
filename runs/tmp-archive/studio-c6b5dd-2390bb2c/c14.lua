treeO = outline{{-10,480,"c"},{-10,190,"c"},{20,172},{45,150},{75,128},{105,122},{130,138},{150,150},{175,142},{200,158},{222,178},{240,200},{262,215},{280,240},{290,268},{305,285},{318,310},{326,335},{340,360},{345,385},{356,405},{368,425},{385,440},{395,452},{400,466,"c"},{200,478},{60,484}, closed=true, char="soft", seed=21, lobe=18, amount=1.2}
trees = treeO:mask()
pDark = pile{{"Prussian blue",0.4},{"yellow ochre",1.2},{"raw umber",1.5},{"bone black",0.4}}
work(trees, {hand="body", tool="filbert 10", pile=pDark, angle=function(x,y) return 0.6*math.sin(x/40+y/55) end, angle_jitter=0.5, coverage=3.5, load=0.9, fill=true, length={20,50}, edge="soft"})
