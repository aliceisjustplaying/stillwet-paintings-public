--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local t0=clock()
for y=30,280,85 do for x=30,1100,105 do drop{x=x,y=y,water=20,radius=75} end end
local b = brush{name="sky", width=60}
b:load{water=6, pigments={["cobalt-blue"]=0.09, ["paynes-gray"]=0.05, ["burnt-sienna"]=0.008}}
b:wash{x=-20,y=-10,width=1140,height=300, grade=0.3, pressure=0.5}
print("after wash", clock()-t0)
local s=balance() print(s.max_surface_water, s.max_wetness)
local d = brush{name="streak", width=45}
local function streak(pts, amt)
  d:load{water=4, pigments={["cobalt-blue"]=0.08*amt, ["paynes-gray"]=0.07*amt}}
  d:stroke(pts, {pressure=0.5, duration=0.25})
end
streak({{-10,20},{150,10},{350,25},{550,10}},1)
streak({{-10,80},{120,70},{260,78},{420,65}},1)
streak({{-10,150},{100,140},{250,145},{400,132},{560,125}},1.2)
streak({{850,140},{950,125},{1110,115}},0.8)
print("after streaks", clock()-t0)
s=balance() print(s.max_surface_water, s.max_wetness)
local L = brush{name="lift", width=18}
local function lift(pts, w) L:load{water=w} L:lift(pts, {duration=0.25}) end
lift({{400,110},{550,95},{700,80},{850,60},{1000,45}},3)
lift({{300,170},{450,160},{600,150},{750,140}},3)
lift({{550,40},{700,30},{850,20}},3)
-- cumulus test
local C = brush{name="cum", width=26}
local function puff(x,y,w) C:load{water=w} C:lift({{x,y}}) end
for _,p in ipairs({{150,215},{190,200},{235,192},{280,198},{320,185},{350,178},{390,195},{430,205},{470,215}}) do puff(p[1],p[2],2) end
C:load{water=3}
C:lift({{120,235},{250,230},{380,235},{500,240}},{duration=0.3})
print("after lifts", clock()-t0)
wait(25) print(balance().dry)
