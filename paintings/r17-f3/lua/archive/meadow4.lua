local nb = noise{seed=31, period=90, octaves=3, stretch={0, 3}}
local patchy = mask(function(x,y) return smoothstep(0.45, 0.62, nb:at01(x,y)) end)
local band = function(a,b) return MEAD * zoneN(a, b, 10, 10) end
local mixP = pile{{"yellow ochre",1.3},{"green earth",1.5},{"Prussian blue",0.22},{"lead white",0.9},{"raw umber",0.25},{"pale smalt",0.15}, medium=0.1}
mpass(band(500, 540) * patchy, mixP, 520, 0.7, 21)
mpass(band(540, 580), mixP, 560, 0.5, 22)
mpass(band(575, 612), mixP, 592, 0.9, 23)
mpass(band(575, 612) * patchy, gP.sh, 592, 0.6, 24)
mpass(band(605, 640), gP.sh, 620, 0.6, 25)
print(wait(0))
