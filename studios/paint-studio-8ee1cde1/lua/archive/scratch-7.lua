--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


for y=25,300,80 do for x=30,600,105 do drop{x=x,y=y,water=13,radius=72} end end
local b = brush{name="sky", width=60}
b:load{water=6, pigments={["cobalt-blue"]=0.075, ["paynes-gray"]=0.06, ["burnt-sienna"]=0.012}}
b:wash{x=-20,y=-10,width=620,height=320, grade=0.5, pressure=0.5}
local C = brush{name="cum", width=20}
local function blob(cx,cy,r,w)
  local pts={}
  for i=0,14 do local a=i/14*2*math.pi*1.5 local rr=r*(0.4+0.6*(i/14)) pts[#pts+1]={cx+rr*math.cos(a), cy+rr*0.8*math.sin(a)} end
  C:load{water=w} C:lift(pts,{duration=0.15})
end
for _,p in ipairs({{130,205,18},{175,192,20},{225,186,22},{270,190,18},{310,178,22},{350,172,20},{385,190,18},{425,205,16},{465,212,14},{510,220,12},{220,212,20},{300,208,22},{390,218,18}}) do blob(p[1],p[2],p[3],2.5) end
wait(25) print(balance().dry)
