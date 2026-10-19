pwdark = pile{{"raw umber",3},{"smalt",1.4},{"bone black",0.6},{"lead white",0.5}}
pwlight = pile{{"lead white",2},{"yellow ochre",1},{"raw umber",1.2}}
wdark = mask(function(x,y) return clamp(0.2 + 0.8*(x/1000) + 0.55*(1 - y/455), 0, 1) end):soften(70)
wlight = mask(function(x,y) return clamp(1 - ((x-220)/430)^2 - ((y-370)/270)^2, 0, 1) end):soften(100)
work(wdark * wallmask, {hand="glaze", pile=pwdark, clip=true, coverage=2.4, seed=331})
work(wlight * wallmask, {hand="glaze", pile=pwlight, clip=true, coverage=1.7, seed=332})
