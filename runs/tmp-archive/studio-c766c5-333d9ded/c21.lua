clear = (ellipse(640,538,152,50) + ellipse(640,600,114,60)) - bottlemask
work(clear, {hand="body", pile=ptab, clip=true, coverage=3.2, fill=true, seed=161})
blend(clear:soften(6), {seed=162, coverage=1.5, pressure={0.3,0.3}})
bowlmask = ellipse(640,534,128,34) + poly({{512,534},{514,552},{520,572},{530,592},{544,608},{564,622},{586,632},{608,637},{672,637},{694,632},{716,622},{736,608},{750,592},{760,572},{766,552},{768,534}}, true)
work(bowlmask, {hand="body", pile=pbowl, clip=true, coverage=3.2, fill=true, angle=0.25, seed=163})
blend(bowlmask, {seed=164, coverage=1.5, pressure={0.3,0.3}})
