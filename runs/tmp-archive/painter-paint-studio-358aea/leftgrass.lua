local R = LAND * rect(0, 486, 445, 125) - PWALL:grow(0.5) - FIGS:grow(1) - PATH:shrink(2)
local nz = noise{seed=909, period=140, octaves=3}
local function z(a,b,s) return R * mask(function(x,y) local yy = y + 6*nz(x,y*2); return smoothstep(a-s,a+s,yy)*(1-smoothstep(b-s,b+s,yy)) end) end
local mixP = pile{{"yellow ochre",1.3},{"green earth",1.5},{"Prussian blue",0.22},{"lead white",0.9},{"raw umber",0.25},{"pale smalt",0.15}, medium=0.1}
mpass(z(486, 510, 3), G.far, 498, 1.5, 3001)
mpass(z(506, 540, 4), gP.lit, 522, 1.4, 3002)
mpass(z(536, 572, 5), mixP, 555, 1.4, 3003)
mpass(z(568, 600, 6), gP.sh, 585, 1.5, 3004)
mpass(z(595, 625, 6), gP.mid, 610, 1.2, 3005)
local nb = noise{seed=931, period=90, octaves=3, stretch={0, 3}}
local patchy = mask(function(x,y) return smoothstep(0.45, 0.62, nb:at01(x,y)) end)
mpass(z(500, 600, 6) * patchy, gP.lit, 550, 0.7, 3006)
print(wait(0))
