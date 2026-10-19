reflP = pile{{"red earth",1},{"raw umber",1},{"lead white",0.5},{"smalt",0.2}}
reflDark = pile{{"raw umber",1},{"bone black",0.4},{"smalt",0.3},{"lead white",0.3}}
local rip = noise{seed=51, octaves=3, period=40, stretch={0, 6}}
local main_r = poly({{306,470},{390,468},{384,560},{374,640},{362,700},{314,700}}, true)
local fore_r = poly({{297,468},{230,468},{262,560},{290,660},{297,660}}, true)
local miz_r = poly({{395,466},{412,466},{410,520},{397,522}})
local breakm = mask(function(x,y) local fade = clamp(1 - (y-470)/260, 0, 1); return clamp((rip(x,y)*0.8 + fade*0.9 - 0.15)*3, 0, 1) end)
reflM = (main_r + fore_r + miz_r) * breakm * rect(0,462,1000,220)
local hullR = outline{{232,461,"c"},{320,462},{408,460,"c"},{400,474},{320,480},{240,474}, closed=true, char="soft", amount=0.6, seed=52}:mask()
work(reflM, {hand="hatch", pile=reflP, angle=0, angle_jitter=0.03, length={6,22}, coverage=1.8, pressure={0.3,0.6}})
work(hullR, {hand="detail", pile=reflDark, angle=0, coverage=2, fill=true})
blend(reflM:grow(6):soften(4) + hullR:grow(4), {angle=0, clip=false})
