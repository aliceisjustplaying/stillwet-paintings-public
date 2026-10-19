function grass(m, p, len, cov, w, jit, seed)
  work(m, {hand="hatch", pile=p, tool={kind="round", width=w, point=0.8}, angle=-math.pi/2 + 0.0, angle_jitter=jit or 0.25, length=len, coverage=cov, pressure={0.35,0.7}, ramps={0.1,0.6}, seed=seed})
end
function hgrass(m, p, len, cov, w, seed)
  work(m, {hand="hatch", pile=p, tool={kind="round", width=w, point=0.6}, angle=0, angle_jitter=0.08, length=len, coverage=cov, pressure={0.4,0.7}, seed=seed})
end
M_rise = LAND * mask(function(x,y) return (y < 492 - 0.02*x) and (1-smoothstep(330,380,x)) or 0 end)
riseP = pile{{"lead white",4},{"yellow ochre",1.6},{"green earth",0.8},{"chrome yellow",0.3},{"Prussian blue",0.05}, medium=0.1}
riseD = pile{{"lead white",2.5},{"green earth",1.4},{"yellow ochre",0.8},{"pale smalt",0.5},{"raw umber",0.2}, medium=0.1}
hgrass(M_rise, riseP, {6,16}, 1.4, 1.6, 1)
hgrass(M_rise * mask(function(x,y) return smoothstep(0.2,0.8,noise{seed=7,period=60}:at01(x,y)) end), riseD, {5,12}, 0.8, 1.4, 2)
M_far = LAND * mask(function(x,y) return (x > 330 and y < rtop(x) + 1) and 1 or 0 end) - TOWN - FARTREES
farP = pile{{"lead white",4},{"green earth",1.2},{"pale smalt",0.7},{"yellow ochre",0.7}, medium=0.1}
hgrass(M_far, farP, {5,14}, 1.5, 1.2, 3)
print(wait(0))
