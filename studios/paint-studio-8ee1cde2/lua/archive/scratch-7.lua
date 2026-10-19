--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local w = brush{name="base", width=60}
w:load{water=6, pigments={["cobalt-blue"]=0.06, ["french-ultramarine"]=0.03, ["burnt-sienna"]=0.008}}
w:wash{x=20, y=20, width=440, height=220}
local d = brush{name="pill", width=26}
d:load{water=5, pigments={["cobalt-blue"]=0.06, ["french-ultramarine"]=0.03, ["burnt-sienna"]=0.008}}
for _,p in ipairs({{100,80},{200,120},{300,100}}) do d:stroke({{p[1],p[2]},{p[1]+25,p[2]-3}}, {pressure=0.4}) end
wait(10)
local t0 = clock()
for gy=0,2 do for gx=0,4 do drop{x=40+gx*100+(gy%2)*45, y=40+gy*90, water=4, radius=78} end end
local s = brush{name="even", width=50}
local mix = {["cobalt-blue"]=0.020, ["french-ultramarine"]=0.010, ["burnt-sienna"]=0.003, ["paynes-gray"]=0.002} -- per uL
local function top(target)
  local need = target - s:status().water
  if need > 0 then local p={} for k,v in pairs(mix) do p[k]=v*need end; s:load{water=need, pigments=p} end
end
local n=0
for row=0,6 do
  local y = 25 + row*32
  for x=20, 440, 30 do
    top(3)
    s:stroke({{x,y},{x+34,y-1}}, {pressure=0.5, duration=0.03})
    n=n+1
  end
end
print("strokes", n, "time", clock()-t0)
local L = brush{name="sl", width=24}
L:load{water=1.8}
local pts={} for i=0,10 do local t=i/10; pts[#pts+1]={60+300*t, 160-40*t-math.sin(t*3.1)*5, 0.12+0.4*math.sin(t*math.pi)} end
L:lift(pts,{duration=0.25})
wait(15)



local m = brush{name="ridgeT", width=22}
m:load{water=5, pigments={["cobalt-blue"]=0.07, ["paynes-gray"]=0.045, ["quinacridone-rose"]=0.006, ["terre-verte"]=0.015}}
local pts = {}
for x=40,640,20 do pts[#pts+1] = {x, 400 + 10*math.sin(x/50) + 4*math.sin(x/13)} end
m:stroke(pts, {pressure=0.5, duration=0.3})
local w = brush{name="ridgeW", width=30}
w:load{water=6}
local p2 = {}
for x=40,640,20 do p2[#p2+1] = {x, 420 + 10*math.sin(x/50)} end
w:stroke(p2, {pressure=0.5, duration=0.25})
wait(12)



local m = brush{name="ridgeT2", width=24}
local mix = {["cobalt-blue"]=0.05, ["paynes-gray"]=0.03, ["quinacridone-rose"]=0.004, ["terre-verte"]=0.01}
local function top(target)
  local need = target - m:status().water
  if need > 0 then local p={} for k,v in pairs(mix) do p[k]=v*need end; m:load{water=need, pigments=p} end
end
for x=40,620,30 do
  top(3)
  local y1 = 520 + 10*math.sin(x/50) + 4*math.sin(x/13)
  local y2 = 520 + 10*math.sin((x+34)/50) + 4*math.sin((x+34)/13)
  m:stroke({{x,y1},{x+34,y2}}, {pressure=0.5, duration=0.04})
end
local w = brush{name="ridgeW2", width=30}
for x=40,620,40 do
  w:load{water=2}
  local y1 = 545 + 10*math.sin(x/50)
  w:stroke({{x,y1},{x+44,y1}}, {pressure=0.5, duration=0.04})
end
wait(12)



local m = brush{name="ridgeV", width=16}
local mix = {["cobalt-blue"]=0.035, ["paynes-gray"]=0.022, ["quinacridone-rose"]=0.003, ["terre-verte"]=0.008}
local function top(target)
  local need = target - m:status().water
  if need > 0 then local p={} for k,v in pairs(mix) do p[k]=v*need end; m:load{water=need, pigments=p} end
end
for x=40,620,10 do
  top(1.2)
  local y1 = 640 + 10*math.sin(x/50) + 4*math.sin(x/13)
  m:stroke({{x,y1,0.5},{x+3,y1+14,0.45},{x+5,y1+30,0.15}}, {duration=0.03})
end
wait(12)
