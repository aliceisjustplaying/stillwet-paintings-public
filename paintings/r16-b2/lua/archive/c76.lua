mist2 = pile{{"lead white",5},{"pale smalt",1.1},{"vermilion",0.05},{"yellow ochre",0.15}, medium=0.45}
local nz = noise{seed=761, period=90, octaves=3}
local band = rect(-10,462,470,44)
work(band, {hand="scumble", pile=mist2, tool={kind="filbert", width=7}, angle=0, angle_jitter=0.08, coverage=1.6, fill=false, length={20,50}, pressure={0.25,0.45},
  load_at=function(x,y) return clamp(0.35*smoothstep(466, 494, y)*(1-smoothstep(499, 506, y))*(0.8+0.4*nz(x,y)), 0.0, 0.5) end, seed=762})
blend(band, {angle=0, length={40,120}, tool={kind="badger", width=20}, seed=763})
