skyTop = pile{{"lead white",2},{"smalt",1.6},{"cobalt blue",0.3},{"raw umber",0.2}}
horizGold = pile{{"lead white",3},{"yellow ochre",0.8},{"chrome yellow",0.6},{"vermilion",0.15}}
core = pile{{"lead white",6},{"chrome yellow",1}}
local top = mask(function(x,y) return clamp((110 - y)/50 + 0.5,0,1) end) - wisps:grow(6)
work(top, {hand="broad", pile=skyTop, angle=0.02, coverage=2, fill=true})
local hb = rect(0,412,1000,34):roughen(5,60,3)
work(hb, {hand="body", pile=horizGold, angle=0, coverage=2.5, length={40,120}, fill=true})
local c = ellipse(610,392,190,38):soften(20)
work(c, {hand="body", pile=core, angle=0, coverage=2, length={40,110}, fill=true})
blend(rect(0,0,1000,140):soften(20), {angle=0.02})
blend(rect(0,300,1000,146), {angle=0})
