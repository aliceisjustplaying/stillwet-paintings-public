wfree = wallmask - objall
tfree = tablemask - objall
pcool = pile{{"smalt",1},{"lead white",1.2},{"raw umber",0.6}, medium=0.6}
pwarmt = pile{{"yellow ochre",2},{"red earth",0.5},{"lead white",0.6}, medium=0.5}
work(wfree, {hand="glaze", pile=pcool, clip=true, coverage=1.3, seed=581})
work(tfree, {hand="glaze", pile=pwarmt, clip=true, coverage=1.3, seed=582})
