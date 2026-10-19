mudOnly = (mudL2 + mudR2) - pools
gz = pile{{"raw umber",1.5},{"bone black",0.6},{"red earth",0.3}, medium=0.7}
work(mudOnly * rect(0,595,1000,130), {hand="glaze", pile=gz, angle=0, coverage=1.6, clip=mudOnly})
work(mudOnly * rect(0,650,1000,80), {hand="glaze", pile=gz, angle=0.02, coverage=1.4, clip=mudOnly})
blend(mudOnly, {angle=0})
blend(mudOnly, {angle=0.1})
