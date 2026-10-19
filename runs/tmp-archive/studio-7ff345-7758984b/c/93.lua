-- let it be a low mist lying in the hollow: lose its left edge, draw it out level
local m = poly({{420, 455}, {700, 448}, {720, 500}, {420, 505}}):soften(8) - figM:grow(3)
work(m, {hand="blend", angle=0, coverage=2.5, clip=true, length={60, 160}})
