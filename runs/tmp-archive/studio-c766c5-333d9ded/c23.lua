ring = ellipse(640,548,205,98) - bowlmask
work(ring, {hand="body", pile=ptab, clip=true, coverage=3.0, fill=true, seed=181})
blend(ring:soften(8), {seed=182, coverage=1.0, pressure={0.3,0.3}})
work(ring, {hand="body", pile=ptab, clip=true, coverage=3.0, fill=true, seed=183})
