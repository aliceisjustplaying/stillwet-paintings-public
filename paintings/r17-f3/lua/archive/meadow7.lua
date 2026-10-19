local R = LAND * rect(0, 492, 445, 100) - PWALL:grow(0.5) - FIGS:grow(1.5) - PATH:shrink(1)
MREP = R
local nz = noise{seed=701, period=120, octaves=3}
local function z(a,b) return R * mask(function(x,y) local yy = y + 5*nz(x,y*3); return smoothstep(a-6,a+6,yy)*(1-smoothstep(b-6,b+6,yy)) end) end
local farC  = pile{{"lead white",1.5},{"green earth",1.7},{"yellow ochre",1.0},{"pale smalt",0.4},{"Prussian blue",0.05},{"raw umber",0.15}, medium=0.1}
local litC  = pile{{"lead white",1.2},{"yellow ochre",1.7},{"chrome yellow",0.45},{"green earth",0.9},{"Prussian blue",0.12}, medium=0.1}
local midC  = pile{{"lead white",0.9},{"yellow ochre",1.5},{"chrome yellow",0.2},{"green earth",1.2},{"Prussian blue",0.2},{"raw umber",0.15}, medium=0.1}
work(z(488,512), {hand="body", pile=farC, tool="filbert 5", clip=R, angle=0, length={8,20}, coverage=2.4, fill=true, load=0.85, threshold=0.4})
work(z(508,548), {hand="body", pile=litC, tool="filbert 6", clip=R, angle=0, length={10,26}, coverage=2.4, fill=true, load=0.85, threshold=0.4})
work(z(544,600), {hand="body", pile=midC, tool="filbert 7", clip=R, angle=0, length={10,30}, coverage=2.4, fill=true, load=0.85, threshold=0.4})
print(wait(0))
