--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


for y=25,300,80 do for x=30,1100,105 do drop{x=x,y=y,water=13,radius=72} end end
local b = brush{name="sky", width=60}
b:load{water=6, pigments={["cobalt-blue"]=0.075, ["paynes-gray"]=0.06, ["burnt-sienna"]=0.012}}
b:wash{x=-20,y=-10,width=1140,height=250, grade=0.4, pressure=0.5}
local h = brush{name="haze", width=60}
h:load{water=6, pigments={["cobalt-blue"]=0.02, ["paynes-gray"]=0.02, ["raw-umber"]=0.012}}
h:wash{x=-20,y=235,width=1140,height=80, pressure=0.5}
wait(0.8)
local C = brush{name="cum", width=16}
local function blob(cx,cy,r,w)
  local pts={}
  for i=0,12 do local a=i/12*2*math.pi*1.3 local rr=r*(0.3+0.7*(i/12)) pts[#pts+1]={cx+rr*math.cos(a), cy+rr*0.8*math.sin(a)} end
  C:load{water=w} C:lift(pts,{duration=0.12})
end
for _,p in ipairs({{130,222,12},{180,212,14},{235,206,14},{290,208,12},{330,196,15},{370,192,13},{405,206,11},{450,218,10},{500,214,9},{535,228,8}}) do blob(p[1],p[2],p[3],1.0) end
for _,p in ipairs({{640,236,6},{700,248,7},{930,282,10},{985,290,11},{1040,300,12},{1080,318,12}}) do blob(p[1],p[2],p[3],1.0) end
local L = brush{name="lift", width=20}
local function lift(pts, w) L:load{water=w} L:lift(pts, {duration=0.2}) end
lift({{430,112},{520,104},{620,92},{720,82},{850,66},{1000,52}},2.5)
lift({{620,150},{760,140},{900,128}},2.2)
lift({{560,40},{700,30},{850,22}},2.2)
local d = brush{name="streak", width=45}
local function streak(pts, amt)
  d:load{water=4, pigments={["cobalt-blue"]=0.08*amt, ["paynes-gray"]=0.08*amt}}
  d:stroke(pts, {pressure=0.5, duration=0.25})
end
streak({{-10,20},{150,10},{350,25},{500,10}},1.2)
streak({{-10,85},{120,75},{260,80},{380,72}},1.1)
streak({{-10,145},{100,138},{250,142},{360,136}},1.0)
wait(25) print(balance().dry)
