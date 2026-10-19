nearBank = (below(function(x) return 450 + 3*math.sin(x/40) end) * above(function(x) return 470 + 3*math.sin(x/55) - (x>400 and (x-400)*0.12 or 0) end) * rect(-10,0,478,714)):roughen(2, 15, 71, 0)
pNB = pile{{"raw umber",2},{"bone black",0.5},{"Prussian blue",0.2},{"yellow ochre",0.6},{"red earth",0.2}}
work(nearBank, {hand="body", tool="filbert 6", pile=pNB, angle=0, angle_jitter=0.3, coverage=3.5, load=0.9, fill=true, length={15,40}, edge="firm"})
