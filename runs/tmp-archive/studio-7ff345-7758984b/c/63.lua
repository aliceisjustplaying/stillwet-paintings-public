-- the young moon low over the glow, lit from below right; the evening star
moonP = pile{{"lead white",6},{"yellow ochre",0.25},{"chrome yellow",0.05}, medium=0.1}
local mx, my, mr = 752, 196, 8.5
moonM = (ellipse(mx, my, mr, mr) - ellipse(mx - 2.6, my - 2.4, mr * 0.93, mr * 0.93)):soften(0.3)
work(moonM, {hand="detail", tool={kind="round", width=1, point=0.8}, pile=moonP, load=1, pressure={0.6, 0.9}, coverage=4, fill=true, clip=true, angle=2.4})
-- earthshine: the dark of the disc just paler than the sky
local es = pile{{"lead white",4},{"pale smalt",1.2},{"smalt",0.3},{"yellow ochre",0.1}, medium=0.6}
work(ellipse(mx, my, mr - 0.3, mr - 0.3) - moonM:grow(0.3), {hand="detail", tool={kind="round", width=1.5, point=0.5}, pile=es, load=0.3, pressure={0.3, 0.5}, coverage=1.5, clip=true, angle=0})
local r = brush{kind="round", width=1.2, point=0.6}
r:load(moonP, 0.9)
r:touch(662, 292, {pressure=0.45})
