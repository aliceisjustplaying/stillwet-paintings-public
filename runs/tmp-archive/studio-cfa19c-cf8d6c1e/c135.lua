wait(60*24*2)
local R = mask(function(x,y) return smoothstep(368, 335, y) end)
local nz = noise{seed=133, octaves=3, period=22}
work(oakSil:shrink(6) * R, {hand="body", tool="filbert 6", pile=fd, angle=function(x,y) return oakF:across(x,y) end, coverage=2, fill=true, clip=true, pressure={0.45,0.7}, seed=1491})
stipple(oakSil:grow(1) * R, {pile=fd, width=5, coverage=1.4, pressure={0.4,0.8}, cluster={0.5, 6}, feather=0.5, dips={20,0.7,0.2}, seed=1492})
local fringe = (oakSil:grow(10) - oakSil:shrink(3)) * R
stipple(fringe, {pile=fd, width=3.5, coverage=function(x,y) local d = oakSil:at(x,y); return clamp(0.25 + 0.9*d + 0.6*nz(x,y), 0, 1.6) end, pressure={0.35,0.75}, cluster={0.6, 5}, feather=0.8, dips={18,0.6,0.2}, seed=1493})
