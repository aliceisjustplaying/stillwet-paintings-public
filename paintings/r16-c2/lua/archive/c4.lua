skyTop = pile{{"lead white",2},{"cobalt blue",1},{"smalt",0.4},{"red earth",0.15},{"raw umber",0.15}}
skyMid = pile{{"lead white",3},{"cobalt blue",0.5},{"red earth",0.3},{"raw umber",0.05}}
local n = noise{seed=5, period=260, octaves=3}
local function band(y0, y1) return mask(function(x,y) local w = n(x,y)*20; return (y > y0 + w and y < y1 + w) and 1 or 0 end) end
work(band(-20, 110), {hand="body", tool="filbert 14", pile=skyTop, angle=0.03, coverage=2.5, length={50,120}, fill=true})
work(band(95, 215), {hand="body", tool="filbert 14", pile=skyMid, angle=-0.03, coverage=2.2, length={50,120}, fill=true})
skyM = rect(0,0,1000,401)
blend(skyM, {angle=0})
blend(skyM, {angle=0.25})
