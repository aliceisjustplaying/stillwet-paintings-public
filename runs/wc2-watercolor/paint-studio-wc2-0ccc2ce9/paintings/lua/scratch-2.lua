paper{width=1056,height=704,kind="cold-press",seed=3117}


local t0=clock()
for y=40,330,95 do for x=40,1056,118 do drop{x=x,y=y,water=20,radius=85} end end
local bands = {
 {y=0,  h=90, p={["french-ultramarine"]=0.12, ["burnt-sienna"]=0.02}},
 {y=90, h=80, p={["french-ultramarine"]=0.07, ["quinacridone-rose"]=0.015}},
 {y=170,h=70, p={["quinacridone-rose"]=0.03, ["french-ultramarine"]=0.02}},
 {y=240,h=100,p={["raw-sienna"]=0.05, ["quinacridone-rose"]=0.015}},
}
for i,bd in ipairs(bands) do
  local b = brush{name="band"..i, width=60}
  b:load{water=8, pigments=bd.p}
  b:wash{x=-10,y=bd.y,width=1076,height=bd.h, pressure=0.6}
  print(i, clock()-t0)
end
for i=1,12 do wait(1); local s=balance(); print(clock()-t0, s.max_surface_water, s.dry) end
