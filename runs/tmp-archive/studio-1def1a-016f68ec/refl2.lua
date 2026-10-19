reflP2 = pile{{"red earth",1},{"raw umber",1.2},{"lead white",0.3},{"smalt",0.25}}
local rip = noise{seed=61, octaves=3, period=35, stretch={0, 7}}
local main_r = poly({{305,468},{392,466},{387,540},{378,620},{368,680},{318,680},{306,600}}, true)
local fore_r = poly({{296,468},{236,468},{258,530},{280,600},{296,640}}, true)
local miz_r = poly({{396,464},{411,464},{409,515},{398,518}})
local breakm = mask(function(x,y) local fade = clamp(1 - (y-468)/230, 0, 1); return clamp((rip(x,y)*0.9 + fade*1.0 - 0.2)*3, 0, 1) end)
reflM2 = (main_r + fore_r + miz_r) * breakm * rect(0,462,1000,220) - spit:shrink(6)
work(reflM2, {hand="hatch", pile=reflP2, angle=0, angle_jitter=0.03, length={8,26}, coverage=2, pressure={0.35,0.7}, clip=true})
blend(reflM2:grow(2), {angle=0})
