--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


-- pre-wet sky region 0..600 x 0..260
for y=40,240,90 do for x=40,600,110 do drop{x=x,y=y,water=8,radius=75} end end
local b = brush{name="sky", width=60}
b:load{water=6, pigments={["cobalt-blue"]=0.12, ["paynes-gray"]=0.03}}
b:wash{x=0,y=0,width=600,height=260, grade=0.4, pressure=0.5}
print(b:status().water)
local s=balance() print(s.max_surface_water, s.max_wetness)
-- lift clouds
local L = brush{name="lift", width=40}
L:load{water=10}
L:lift({{100,200},{160,185},{230,190},{300,175},{380,195},{450,205}})
L:load{water=6}
L:lift({{200,215},{280,220},{360,222}})
wait(15)
print(balance().dry)
