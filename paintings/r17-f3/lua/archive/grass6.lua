local R = (COVREG + HREG) * mask(function(x,y) return y > 488 and 1 or 0 end)
local nb = noise{seed=131, period=90, octaves=3, stretch={0, 3}}
local patchy = mask(function(x,y) return smoothstep(0.42, 0.6, nb:at01(x,y)) end)
local mixP = pile{{"yellow ochre",1.3},{"green earth",1.5},{"Prussian blue",0.22},{"lead white",0.9},{"raw umber",0.25},{"pale smalt",0.15}, medium=0.1}
local function zz(a,b) return R * zoneN(a,b,8,6) end
mpass(zz(488, 512), G.far, 500, 1.3, 2001)
mpass(zz(505, 535), gP.lit, 520, 1.4, 2002)
mpass(zz(530, 578), gP.sh, 552, 1.5, 2003)
mpass(zz(575, 610), gP.lit, 592, 1.4, 2004)
mpass(zz(495, 610) * patchy, mixP, 550, 0.8, 2005)
print(wait(0))
