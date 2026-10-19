oldbowl = bowlmask
bowlmask = ellipse(640,534,128,34) + ellipse(640,598,92,46)
gap = oldbowl - bowlmask
print("gap", gap:area())
work(gap, {hand="body", pile=ptab, clip=true, coverage=3, fill=true, seed=151})
blend(gap:soften(8), {seed=152, coverage=1.5, pressure={0.3,0.3}})
work(bowlmask, {hand="body", pile=pbowl, clip=true, coverage=3.5, fill=true, angle=0.25, seed=153})
blend(bowlmask, {seed=154, coverage=1.5, pressure={0.3,0.3}})
