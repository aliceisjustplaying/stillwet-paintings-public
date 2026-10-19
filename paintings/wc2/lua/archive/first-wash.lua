paper{width=1056,height=704,kind="cold-press",seed=4127}
local w = brush{name="wet1", width=90}
w:load{water=100}
w:load{water=100}
w:wash{x=0,y=0,width=520,height=330, pressure=0.5}
print(w:status().water)
local s=balance(); print(clock(), s.max_surface_water, s.max_wetness)
local b = brush{name="sky1", width=80}
b:load{water=60, pigments={["cerulean-blue"]=1.5, ["french-ultramarine"]=1}}
b:wash{x=0,y=0,width=520,height=150, grade=0.3, pressure=0.5}
print(clock(), b:status().water)
local g = brush{name="glow1", width=80}
g:load{water=50, pigments={["naples-yellow"]=1.0, ["quinacridone-rose"]=0.3}}
g:wash{x=0,y=200,width=520,height=120, pressure=0.5}
print(clock())
for i=1,10 do local t=wait(0.5); local s=balance(); print(t, s.max_surface_water, s.max_wetness, s.dry) end