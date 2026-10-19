moonP = pile{{"lead white", 8}, {"chrome yellow", 0.25}, {"yellow ochre", 0.05}}
local cx, cy, r = 835, 172, 7.5
local dx, dy = 195, -285
local l = math.sqrt(dx*dx + dy*dy); dx, dy = dx/l, dy/l
moonM = ellipse(cx, cy, r, r) - ellipse(cx + dx*r*0.5, cy + dy*r*0.5, r*1.02, r*1.02)
local b = brush{kind="round", width=3, point=0.6}
b:load(moonP, 0.9)
work(moonM, {hand="detail", pile=moonP, tool=b, coverage=4, fill=true, clip=true, length={2,5}})
print(moonM:area())
