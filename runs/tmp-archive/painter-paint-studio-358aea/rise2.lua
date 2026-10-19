RISE = LAND * mask(function(x,y) return (y < 487 and x < 385) and 1 or 0 end) - MILL:grow(0.5) - poly{{86,463},{86,445},{118,445},{118,463}}
local g1 = pile{{"lead white",1.4},{"green earth",2},{"yellow ochre",0.8},{"pale smalt",0.6},{"raw umber",0.15}, medium=0.1}
local g2 = pile{{"lead white",1.0},{"green earth",2},{"yellow ochre",0.5},{"pale smalt",0.8},{"raw umber",0.3}, medium=0.1}
work(RISE, {hand="hatch", pile=g1, tool={kind="round", width=1.3, point=0.7}, angle=0.03, angle_jitter=0.1, length={4,12}, coverage=1.5, clip=true, seed=61, load=0.7})
local low = RISE * mask(function(x,y) return smoothstep(468, 482, y) * (0.6 + 0.4*smoothstep(150, 300, x)) end)
work(low, {hand="hatch", pile=g2, tool={kind="round", width=1.3, point=0.7}, angle=0.03, angle_jitter=0.1, length={4,12}, coverage=1.3, clip=true, seed=62, threshold=0.35, load=0.7})
print(wait(0))
