reflRuss = pile{{"raw umber",1},{"red earth",0.9},{"bone black",0.15},{"lead white",0.12}}
reflHull = pile{{"bone black",1},{"raw umber",1},{"smalt",0.4},{"lead white",0.1}}
local rip = noise{seed=77, octaves=3, period=30, stretch={0, 8}}
-- the sails seen upside down in the water, drawn freshly as shapes
local main_r3 = poly({{304,474},{391,473},{388,520},{383,580},{376,640},{360,690},{312,690},{305,600}}, true)
local fore_r3 = poly({{296,474},{234,474},{250,515},{268,570},{286,630},{296,660}}, true)
local miz_r3 = poly({{395,470},{411,470},{410,515},{397,517}})
local brk = mask(function(x,y) local fade = clamp(1.1 - (y-474)/200, 0, 1); return clamp((rip(x,y)*0.8 + fade - 0.25)*3, 0, 1) end)
reflM3 = (main_r3 + fore_r3 + miz_r3) * brk * rect(0,470,1000,210) - spit2:grow(2)
work(reflM3, {hand="hatch", pile=reflRuss, angle=0, angle_jitter=0.02, length={10,30}, coverage=2.2, pressure={0.4,0.75}})
-- hull reflection: a dark band right under the hull
local hr = outline{{224,462,"c"},{320,466},{410,461,"c"},{402,471},{320,477},{238,471}, closed=true, char="soft", amount=0.5, seed=78}:mask()
work(hr, {hand="hatch", pile=reflHull, angle=0, length={8,24}, coverage=2.5, pressure={0.5,0.8}})
