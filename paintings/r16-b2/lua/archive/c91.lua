tglz = pile{{"smalt",1},{"raw umber",1.2},{"bone black",0.3}, medium=0.65}
local nz = noise{seed=911, period=40, octaves=2}
work(TOWN2, {hand="scumble", pile=tglz, tool={kind="filbert", width=4}, angle=0, angle_jitter=0.05, coverage=1.6, fill=false, length={8,20}, pressure={0.3,0.5},
  load_at=function(x,y) return clamp(0.45*smoothstep(400, 440, y), 0, 0.45) end, seed=912})
