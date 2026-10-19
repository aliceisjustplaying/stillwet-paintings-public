work(wallmask - objall, {hand="broad", pile=pdark2, clip=true, coverage=4.0, angle=0.1, fill=true, seed=351})
wlight2 = mask(function(x,y) return clamp(1 - ((x-200)/520)^2 - ((y-330)/330)^2, 0, 1) end):soften(140)
work(wlight2 * (wallmask - objall), {hand="glaze", pile=pwlight, clip=true, coverage=1.2, seed=352})
