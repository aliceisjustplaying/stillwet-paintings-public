wait(60*24)
local cr = pile{{"lead white",10},{"yellow ochre",0.42},{"vermilion",0.05},{"pale smalt",0.25}, medium=0.08}
local smear = (ellipse(92,414,14,6) - oakSil:grow(1)) - oakM:grow(1)
work(smear, {hand="detail", pile=cr, tool={kind="filbert", width=3}, angle=0, coverage=3, fill=true, clip=true, edge="found", pressure={0.5,0.7}, seed=1601})
blend(smear:shrink(1), {tool={kind="badger", width=6}, angle=0, coverage=1.2, clip=true, pressure={0.2,0.35}, seed=1602})
-- hanging bough under the lowest clump
local bough = ellipse(150,446,40,9):roughen(3, 10, 3)
local nz = noise{seed=188, octaves=3, period=8}
stipple(bough, {pile=fd, width=3.5, coverage=function(x,y) return clamp(0.9 + 0.5*nz(x,y), 0, 1.4) end, pressure={0.35,0.75}, cluster={0.6,5}, feather=0.7, seed=1603})
stipple(bough:grow(4) - bough:shrink(2), {pile=fd, width=2.2, coverage=function(x,y) return clamp(0.3+0.8*nz(x,y),0,1) end, pressure={0.35,0.75}, drag={1,-0.8}, cluster={0.6,4}, feather=0.8, seed=1604})
local top = bough * mask(function(x,y) return smoothstep(452, 440, y) * smoothstep(195, 120, x) end)
stipple(top, {pile=fm, width=2.5, coverage=function(x,y) return clamp(0.8*top:at(x,y)+0.4*nz(x,y),0,1.1) end, pressure={0.35,0.7}, cluster={0.6,4}, feather=0.7, seed=1605})
