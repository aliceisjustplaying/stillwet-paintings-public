--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


for y=25,300,80 do for x=30,600,105 do drop{x=x,y=y,water=13,radius=72} end end
local b = brush{name="sky", width=60}
b:load{water=6, pigments={["cobalt-blue"]=0.075, ["paynes-gray"]=0.06, ["burnt-sienna"]=0.012}}
b:wash{x=-20,y=-10,width=620,height=320, grade=0.5, pressure=0.5}
local C = brush{name="cum", width=16}
local function blob(cx,cy,r,w)
  local pts={}
  for i=0,12 do local a=i/12*2*math.pi*1.3 local rr=r*(0.3+0.7*(i/12)) pts[#pts+1]={cx+rr*math.cos(a), cy+rr*0.8*math.sin(a)} end
  C:load{water=w} C:lift(pts,{duration=0.12})
end
local list={{130,205,12},{175,194,14},{225,188,15},{270,192,12},{310,180,15},{350,174,14},{385,190,12},{425,205,10},{465,212,9},{510,220,8}}
wait(1.5)
for _,p in ipairs(list) do blob(p[1],p[2]-100,p[3],1.0) end
wait(1.0)
for _,p in ipairs(list) do blob(p[1],p[2]+40,p[3],1.0) end
wait(25) print(balance().dry)
