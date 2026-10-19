local botP = {{350,490},{460,500},{560,516},{660,538},{760,560},{880,586},{1010,612}}
local keep = trunk2M:grow(1) + rect(316,510,44,72) + rect(420,530,40,28) + rect(496,548,46,24) + oakSil:grow(1) + oakM:grow(1)
local meadow = (below(botP) - riseM - keep) * rect(0,470,1000,250)
local mA = pile{{"yellow ochre",2.4},{"Prussian blue",0.32},{"lead white",1.4},{"green earth",0.6}, medium=0.05}
local mB = pile{{"yellow ochre",2.4},{"Prussian blue",0.45},{"raw umber",0.3},{"lead white",0.9},{"green earth",0.4}, medium=0.05}
-- small far strokes near the hay, larger ones nearer
work(meadow * mask(function(x,y) return smoothstep(interp(botP,x)+45, interp(botP,x)+15, y) end), {hand="hatch", pile=mA, tool={kind="round", width=1.2, point=0.6}, angle=-math.pi/2+0.1, length={2,5}, coverage=1.0, pressure={0.3,0.6}, seed=981})
work(meadow * mask(function(x,y) return smoothstep(interp(botP,x)+15, interp(botP,x)+45, y) end), {hand="hatch", pile=mB, tool={kind="round", width=1.5, point=0.6}, angle=-math.pi/2+0.15, length={3,8}, coverage=1.1, pressure={0.3,0.65}, seed=982})
