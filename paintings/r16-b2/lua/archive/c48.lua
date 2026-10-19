moonw = pile{{"lead white",10},{"chrome yellow",0.2}, medium=0.02}
local cx, cy, r = 742, 250, 8.6
local ang = 2.12
MOON2 = ellipse(cx, cy, r, r) - ellipse(cx - 3.6*math.cos(ang), cy - 3.6*math.sin(ang), r*1.03, r*1.03)
work(MOON2, {hand="detail", pile=moonw, tool={kind="round", width=1.1, point=0.6}, angle=ang+math.pi/2, coverage=6, fill=true, length={2,5}, pressure={0.6,0.9}, seed=481})
local sb = brush{kind="round", width=1.4, point=0.4}
sb:load(moonw, 0.8)
sb:touch(826, 296, {pressure=0.7})
sb:touch(826.2, 296.1, {pressure=0.5})
