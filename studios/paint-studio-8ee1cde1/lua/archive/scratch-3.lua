--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local t0=clock()
for y=30,280,85 do for x=30,1100,105 do drop{x=x,y=y,water=8,radius=72} end end
local b = brush{name="sky", width=60}
b:load{water=6, pigments={["cobalt-blue"]=0.10, ["paynes-gray"]=0.05, ["raw-umber"]=0.01}}
b:wash{x=0,y=0,width=1100,height=290, grade=0.25, pressure=0.5}
print("after wash", clock()-t0)
-- charge darker streaks
local d = brush{name="streak", width=30}
local function streak(pts, amt)
  d:load{water=3, pigments={["cobalt-blue"]=0.10*amt, ["paynes-gray"]=0.08*amt}}
  d:stroke(pts, {pressure=0.5})
end
streak({{0,20},{150,10},{350,25},{550,10}},1)
streak({{0,70},{120,60},{260,70},{420,55}},1)
streak({{0,150},{100,140},{250,145},{400,130},{600,120}},1.2)
streak({{0,215},{200,205},{350,200}},0.8)
streak({{850,140},{950,125},{1100,115}},0.8)
print("after streaks", clock()-t0)
local s=balance() print(s.max_surface_water, s.max_wetness)
-- cirrus lifts
local L = brush{name="lift", width=18}
local function lift(pts, w) L:load{water=w} L:lift(pts) end
lift({{400,110},{550,95},{700,80},{850,60},{1000,45}},4)
lift({{300,170},{450,160},{600,150},{750,140}},3)
lift({{550,40},{700,30},{850,20}},3)
lift({{650,180},{800,175},{950,165},{1050,150}},3)
print("after lifts", clock()-t0)
wait(20) print(balance().dry)
