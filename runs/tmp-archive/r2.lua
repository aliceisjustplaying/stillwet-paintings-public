BOULDER = outline{{768,676,"c"},{772,655},{785,636},{808,624},{835,620},{862,626},{884,640},{897,660},{900,677,"c"}, closed=true, char="broken", seed=611, amount=0.7}
BOULDER2 = outline{{905,680,"c"},{909,668},{920,661},{934,662},{944,671},{946,682,"c"}, closed=true, char="broken", seed=612, amount=0.7}
local bm = BOULDER:mask() + BOULDER2:mask()
work(bm, {hand="detail", pile=rkA, coverage=3.5, fill=true, angle=0.3, load=1, pressure={0.6,0.9}, tool={kind="round", width=3, point=0.4}})
local n = noise{seed=13, period=20, octaves=3}
stipple(bm, {pile=rkB, width=4, coverage=function(x,y) return 0.6*clamp(n(x,y)+0.2,0,1) end, pressure={0.4,0.7}})
-- stump, lower left
STUMP = poly({{48,652},{52,640},{53,626},{55,618},{60,621},{64,614},{69,619},{74,612},{78,618},{84,616},{86,626},{88,640},{94,652},{101,656},{84,658},{62,658},{42,657}}, true)
work(STUMP, {hand="detail", pile=barkK, coverage=4, fill=true, angle=math.pi/2, load=1, pressure={0.6,0.9}, tool={kind="round", width=2.5, point=0.4}})
