pfront = pile{{"raw umber",2.5},{"bone black",1},{"smalt",1}}
tfree = tablemask - objall
bottom = mask(function(x,y) return clamp((y-690)/115, 0, 1) end):soften(55) * tfree
work(bottom, {hand="broad", pile=pfront, clip=true, coverage=2.6, angle=0.03, seed=571})
leftlow = mask(function(x,y) return clamp(1 - x/330, 0, 1) end):soften(70) * tfree
work(leftlow, {hand="broad", pile=ptabDark2, clip=true, coverage=1.6, angle=0.03, seed=572})
wfree = wallmask - objall
topv = mask(function(x,y) return clamp(1 - y/280, 0, 1) end):soften(90) * wfree
work(topv, {hand="broad", pile=pwall4, clip=true, coverage=1.6, angle=0.12, seed=573})
