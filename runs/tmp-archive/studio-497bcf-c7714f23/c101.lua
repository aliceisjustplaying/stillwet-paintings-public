local near = fg_grass * mask(function(x,y) return crest_depth(x,y) > 50 and 1 or 0 end)
local midz = fg_grass * mask(function(x,y) local d = crest_depth(x,y) return (d > 12 and d <= 50) and 1 or 0 end)
local up = function(x,y) return -math.pi/2 + 0.3*math.sin(x/19 + y/27) end
work(near, {hand="hatch", pile=grM, tool={kind="round", width=2.0, point=1}, angle=up, length={10,24}, coverage=0.9, pressure={0.45,0.75}, ramps={0.05,0.75}, clip=fg_grass})
work(near, {hand="hatch", pile=grL, tool={kind="rigger", width=1.6, point=1}, angle=up, length={10,22}, coverage=0.35, pressure={0.5,0.8}, ramps={0.05,0.75}, clip=fg_grass})
work(midz, {hand="hatch", pile=grL, tool={kind="rigger", width=1.2, point=1}, angle=up, length={5,11}, coverage=0.35, pressure={0.5,0.8}, ramps={0.05,0.75}, clip=fg_grass})
print(wait(0))
