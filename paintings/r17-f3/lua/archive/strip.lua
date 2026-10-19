local R = LAND * rect(0, 484, 445, 30) - PWALL:grow(0.5) - FIGS:grow(1) - PATH:shrink(2)
local p = pile{{"lead white",1.2},{"green earth",1.8},{"yellow ochre",1.1},{"pale smalt",0.4},{"Prussian blue",0.06},{"raw umber",0.2}, medium=0.1}
local m = R * mask(function(x,y) return smoothstep(484, 488, y) * (1 - smoothstep(506, 514, y)) end)
work(m, {hand="hatch", pile=p, tool={kind="round", width=1.3, point=0.8}, angle=-math.pi/2, angle_jitter=0.35, length={2,5}, coverage=1.8, pressure={0.35,0.75}, ramps={0.1,0.6}, threshold=0.3, seed=3101})
print(wait(60*20))
print(drying(15,480), drying(262,480), drying(100,440))
