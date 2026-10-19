oldpear = pear
pear = ellipse(852,600,46,54) + ellipse(852,538,27,32) + ribbon({{852,520},{860,500},{866,490}}, {6,4,2.5})
fix = (oldpear:grow(5) - pear) * tablemask
work(fix, {hand="body", pile=ptabLight, clip=true, coverage=3.4, fill=true, seed=401})
work(pear, {hand="body", pile=ppear, clip=true, coverage=3.5, fill=true, seed=402})
s_pear = body.ellipsoid({852,600,0},{48,56,48})
f2 = form{{s_pear,dist=0.3}, light={from={-1,-0.75}, front=0.55, ambient=0.25}}
litp = f2:lit{parts={1}, soft=0.2}
shp = f2:shadow{parts={1}}
plightp = pile{{"lead white",3},{"chrome yellow",1.5},{"yellow ochre",0.5}}
pdarkp = pile{{"yellow ochre",1.6},{"green earth",1.6},{"raw umber",1},{"smalt",0.4}}
work(pear*litp, {hand="body", pile=plightp, clip=true, coverage=1.9, seed=403})
work(pear*shp, {hand="body", pile=pdarkp, clip=true, coverage=1.8, seed=404})
