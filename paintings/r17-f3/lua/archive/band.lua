local R = LAND * rect(0, 481, 440, 34) - PWALL:grow(0.3) - FIGS:grow(1) - PATH:shrink(2)
local m = R * mask(function(x,y) return smoothstep(481, 485, y) * (1 - smoothstep(508, 514, y)) end)
local p = pile{{"lead white",1.1},{"green earth",1.9},{"yellow ochre",1.2},{"pale smalt",0.35},{"Prussian blue",0.06},{"raw umber",0.2}, medium=0.1}
work(m, {hand="body", pile=p, tool="filbert 4", clip=R, angle=0, length={8,20}, coverage=2.6, fill=true, load=0.85, threshold=0.3})
blend(m, {angle=0, coverage=1.5, tool={kind="badger", width=12}, clip=true, pressure={0.3,0.5}})
local p2 = pile{{"lead white",0.8},{"green earth",1.7},{"yellow ochre",1.4},{"chrome yellow",0.15},{"Prussian blue",0.1},{"raw umber",0.2}, medium=0.1}
work(m, {hand="hatch", pile=p2, tool={kind="round", width=1.1, point=0.8}, angle=-math.pi/2, angle_jitter=0.35, length={2,5}, coverage=0.9, pressure={0.35,0.7}, ramps={0.1,0.6}, threshold=0.3, seed=3201})
print(wait(0))
