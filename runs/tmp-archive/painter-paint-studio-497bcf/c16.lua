-- short grass on the crest behind and around the pair, scaled by distance below the crest line
local cz = fore_m * mask(function(x,y) local d = crest_depth(x,y) return (d > 0.5 and d < 30) and 1 or 0 end) - figs:grow(1.5) - path_m:shrink(1) - elder2:grow(1) - fence:grow(1)
local up = function(x, y) return -math.pi/2 + 0.2 * math.sin(x / 13 + y / 5) end
work(cz, {hand="hatch", pile=fM, tool={kind="round", width=1.0, point=0.9}, angle=up, length={2,5}, coverage=0.7, pressure={0.35,0.6}, ramps={0.1,0.6}, clip=cz, clump=0.6})
work(cz, {hand="hatch", pile=grL, tool={kind="round", width=0.9, point=0.9}, angle=up, length={2,4}, coverage=0.25, pressure={0.3,0.5}, ramps={0.1,0.6}, clip=cz, clump=0.7})
work(cz, {hand="hatch", pile=grD, tool={kind="round", width=1.0, point=0.9}, angle=up, length={2,5}, coverage=0.25, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=cz, clump=0.8})
print(wait(0))
