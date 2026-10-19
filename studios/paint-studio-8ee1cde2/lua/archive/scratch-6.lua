--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


-- replicate: pale base + hard pills, dry
local w = brush{name="base", width=60}
w:load{water=6, pigments={["cobalt-blue"]=0.06, ["french-ultramarine"]=0.03, ["burnt-sienna"]=0.008}}
w:wash{x=20, y=20, width=600, height=260}
local d = brush{name="pill", width=26}
d:load{water=5, pigments={["cobalt-blue"]=0.06, ["french-ultramarine"]=0.03, ["burnt-sienna"]=0.008}}
for _,p in ipairs({{100,80},{200,120},{300,100},{400,150},{500,90}}) do d:stroke({{p[1],p[2]},{p[1]+25,p[2]-3}}, {pressure=0.4}) end
local lb = brush{name="liftbar", width=22}
lb:load{water=5}; 
wait(10)
-- repair pass
local t0=clock()
for gy=0,2 do for gx=0,5 do drop{x=60+gx*105+(gy%2)*50, y=50+gy*100, water=9, radius=80} end end
local r = brush{name="rewash", width=60}
r:load{water=6, pigments={["cobalt-blue"]=0.12, ["french-ultramarine"]=0.065, ["burnt-sienna"]=0.015, ["paynes-gray"]=0.008}}
r:wash{x=20, y=20, width=600, height=260, grade=0.5}
local L = brush{name="softlift", width=26}
local function tl(x0,y0,x1,y1,wat)
  L:load{water=wat}
  local pts = {}
  for i=0,10 do local t=i/10; pts[#pts+1]={x0+(x1-x0)*t, y0+(y1-y0)*t + math.sin(t*3.1)*-6, 0.15+0.45*math.sin(t*math.pi)} end
  L:lift(pts, {duration=0.3})
end
tl(60,120,400,90,2)
tl(150,200,560,170,3)
tl(300,60,600,40,1.5)
print("elapsed", clock()-t0)
wait(20)
