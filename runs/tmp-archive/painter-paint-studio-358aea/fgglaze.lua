local g = pile{{"green earth",1},{"Prussian blue",0.25},{"raw umber",0.6},{"yellow ochre",0.3}, medium=0.6}
local nz = noise{seed=1901, period=150, octaves=2}
local m = LAND * mask(function(x,y) local yy = y + 10*nz(x, y); return smoothstep(650, 690, yy) end) - PATH:grow(1)
work(m, {hand="detail", pile=g, tool={kind="filbert", width=6}, angle=-math.pi/2, angle_jitter=0.3, length={10,25}, coverage=1.1, clip=true, load=0.3, threshold=0.2})
print(wait(0))
