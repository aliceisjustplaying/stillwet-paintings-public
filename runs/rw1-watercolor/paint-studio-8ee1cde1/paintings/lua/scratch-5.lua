--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local t0=clock()
for y=25,300,80 do for x=30,1100,105 do drop{x=x,y=y,water=13,radius=72} end end
local b = brush{name="sky", width=60}
b:load{water=6, pigments={["cobalt-blue"]=0.09, ["paynes-gray"]=0.05, ["burnt-sienna"]=0.008}}
b:wash{x=-20,y=-10,width=1140,height=250, grade=0.35, pressure=0.5}
local h = brush{name="haze", width=60}
h:load{water=6, pigments={["cobalt-blue"]=0.025, ["paynes-gray"]=0.02, ["raw-umber"]=0.01}}
h:wash{x=-20,y=235,width=1140,height=80, pressure=0.5}
print("after wash", clock()-t0)
local d = brush{name="streak", width=45}
local function streak(pts, amt)
  d:load{water=4, pigments={["cobalt-blue"]=0.08*amt, ["paynes-gray"]=0.08*amt}}
  d:stroke(pts, {pressure=0.5, duration=0.25})
end
streak({{-10,20},{150,10},{350,25},{550,10}},1.2)
streak({{-10,85},{120,75},{260,80},{420,68}},1.1)
streak({{-10,150},{100,142},{250,146},{400,135},{560,128}},1.2)
streak({{850,135},{950,122},{1110,112}},0.7)
-- distant mountains charged into wet
local m = brush{name="mtn", width=22}
m:load{water=5, pigments={["cobalt-blue"]=0.10, ["paynes-gray"]=0.08, ["ultramarine-violet"]=0.03}}
m:stroke({{-10,280},{80,272},{180,266},{260,270},{330,272},{400,276},{440,270},{480,262},{510,258},{540,262},{570,264},{605,252},{640,262},{680,276},{720,288}}, {pressure=0.55, duration=0.5})
m:load{water=4, pigments={["cobalt-blue"]=0.06, ["paynes-gray"]=0.05}}
m:stroke({{700,285},{780,280},{860,283},{940,286},{1000,290},{1110,292}}, {pressure=0.5, duration=0.3})
print("after mtn", clock()-t0)
local L = brush{name="lift", width=18}
local function lift(pts, w) L:load{water=w} L:lift(pts, {duration=0.2}) end
lift({{420,108},{560,95},{700,80},{850,62},{1000,48}},2.5)
lift({{620,150},{760,140},{900,128}},2)
lift({{560,40},{700,30},{850,20}},2)
local C = brush{name="cum", width=24}
local function puff(x,y,w) C:load{water=w} C:lift({{x,y}}) end
for _,p in ipairs({{130,205},{170,196},{215,190},{255,193},{300,182},{335,174},{370,180},{385,198},{420,208},{455,214},{490,205},{520,222},{410,228},{345,215},{260,215},{180,222}}) do puff(p[1],p[2],1.3) end
for _,p in ipairs({{630,225},{690,238},{725,250},{915,268},{960,275},{1010,282},{1060,300},{1080,320}}) do puff(p[1],p[2],1.2) end
print("after lifts", clock()-t0)
wait(25) print(balance().dry)
