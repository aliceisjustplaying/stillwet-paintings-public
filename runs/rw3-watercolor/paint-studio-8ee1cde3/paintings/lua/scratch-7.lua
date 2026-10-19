--@ watercolor-engine 2

paper{width=1100,height=660,kind="cold-press",seed=2023}


function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function rect(name, x0,y0,x1,y1, width, water, mix, wet)
  if wet then for x=x0+50,x1-50,80 do for y=y0+50,y1-50,80 do drop{x=x,y=y,water=5,radius=45} end end end
  local b = brush{name=name, width=width}
  for y=y0+10,y1-10,width*0.6 do
    local x=x0+10
    while x < x1-10 do topup(b,water,mix); b:stroke({{x,y},{math.min(x1-10,x+70),y}},{pressure=0.5,duration=0.02}); x=x+70 end
  end
end
rect("beige",20,20,560,200,40,6,{["yellow-ochre"]=0.09, ["raw-umber"]=0.13, ["paynes-gray"]=0.02}, true)
wait(10)
rect("v1",20,20,560,200,30,4,{["ultramarine-violet"]=0.07, ["burnt-sienna"]=0.025, ["raw-umber"]=0.03}, true)
wait(10)
rect("v2",20,20,560,200,30,4,{["cobalt-violet"]=0.07, ["raw-umber"]=0.02}, false)
wait(10)
print(clock())



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local tests = {
 {["terre-verte"]=0.1},
 {["terre-verte"]=0.06, ["paynes-gray"]=0.03},
 {["paynes-gray"]=0.05, ["raw-umber"]=0.03},
 {["viridian"]=0.03, ["raw-umber"]=0.03},
 {["cerulean-blue"]=0.06, ["raw-umber"]=0.03},
}
for i,m in ipairs(tests) do
  local b = brush{name="tt"..i, width=30}
  local x = 60 + (i-1)*100
  for k=0,1 do
    for y=10,200,50 do topup(b,3.5,m); b:stroke({{x+k*25,y},{x+k*25,y+50}},{pressure=0.5,duration=0.02}) end
  end
end
local b = brush{name="gate", width=20}
for y=250,400,12 do local x=20 while x<560 do topup(b,3.2,{["sepia"]=0.3, ["burnt-umber"]=0.1, ["french-ultramarine"]=0.08}); b:stroke({{x,y},{x+70,y}},{pressure=0.5,duration=0.02}); x=x+70 end end
wait(10)
local gt = {
 {["paynes-gray"]=0.15, ["terre-verte"]=0.05},
 {["paynes-gray"]=0.25},
 {["neutral-tint"]=0.15},
}
for i,m in ipairs(gt) do
  local b = brush{name="gg"..i, width=30}
  local x = 60 + (i-1)*100
  for y=245,400,50 do topup(b,3.5,m); b:stroke({{x,y},{x,y+50}},{pressure=0.5,duration=0.02}) end
end
local sl = brush{name="slat", width=3}
for x=350,540,20 do topup(sl,0.5,{["sepia"]=0.5,["paynes-gray"]=0.4}); sl:stroke({{x,245},{x,400}},{pressure=0.5,duration=0.1}) end
local sl2 = brush{name="slat2", width=3}
for x=360,540,20 do topup(sl2,0.5,{["buff-titanium"]=0.8,["raw-umber"]=0.1}); sl2:stroke({{x,245},{x,400}},{pressure=0.5,duration=0.1}) end
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local tests = {
 {["terre-verte"]=0.25, ["paynes-gray"]=0.05},
 {["terre-verte"]=0.15, ["paynes-gray"]=0.08, ["yellow-ochre"]=0.03},
 {["sap-green"]=0.04, ["paynes-gray"]=0.06},
}
for i,m in ipairs(tests) do
  local b = brush{name="hh"..i, width=30}
  local y = 50 + (i-1)*55
  for x=20,500,60 do topup(b,3.5,m); b:stroke({{x,y},{x+60,y}},{pressure=0.5,duration=0.02}) end
end
wait(8)
