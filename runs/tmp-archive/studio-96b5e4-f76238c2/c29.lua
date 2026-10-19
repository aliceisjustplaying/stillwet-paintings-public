wa_far = pile{{"lead white",5},{"chrome yellow",0.4},{"vermilion",0.1},{"raw umber",0.2}, medium=0.1}
wa_mid = pile{{"lead white",3},{"yellow ochre",0.25},{"cobalt blue",0.3},{"smalt",0.2},{"raw umber",0.35}, medium=0.1}
wa_near = pile{{"lead white",2},{"smalt",0.7},{"cobalt blue",0.4},{"raw umber",0.45},{"red earth",0.1}, medium=0.1}
local wm = creek:shrink(0.5)
local function band(a,b) return wm * rect(0,a,1000,b-a) end
work(band(436,505), {hand="detail", pile=wa_far, angle=0, coverage=2.5, length={6,20}, tool={kind="filbert", width=3}, fill=true, clip=true})
work(band(495,600), {hand="body", pile=wa_mid, angle=0, coverage=2.5, length={15,40}, tool="filbert 6", fill=true, clip=wm})
work(band(585,720), {hand="body", pile=wa_near, angle=0, coverage=2.5, length={20,60}, tool="filbert 9", fill=true, clip=wm})
blend(wm, {angle=0}); blend(wm, {angle=0.08})
