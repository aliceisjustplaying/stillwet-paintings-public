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
local function rect(name,x0,y0,x1,y1,w,water,m,wet)
  if wet then for x=x0+50,x1-50,80 do for y=y0+50,y1-50,80 do drop{x=x,y=y,water=6,radius=45} end end end
  local b = brush{name=name,width=w}
  for y=y0+10,y1-10,w*0.6 do local x=x0+10 while x<x1-10 do topup(b,water,m); b:stroke({{x,y},{math.min(x1-10,x+50),y}},{pressure=0.5,duration=0.02}); x=x+50 end end
end
rect("c1",20,20,520,300,34,5,{["paynes-gray"]=0.1, ["raw-umber"]=0.12, ["yellow-ochre"]=0.03},true)
wait(10)
rect("c2",20,20,520,300,34,4,{["buff-titanium"]=0.35, ["cobalt-violet"]=0.09},true)
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
local b = brush{name="c3",width=30}
for y=30,290,18 do local x=30 while x<250 do topup(b,3.5,{["terre-verte"]=0.08, ["paynes-gray"]=0.05, ["raw-umber"]=0.02}); b:stroke({{x,y},{x+50,y}},{pressure=0.5,duration=0.02}); x=x+50 end end
wait(8)
local d = brush{name="drytex", width=10}
for k=0,12 do
  d:load{water=0.6, pigments={["paynes-gray"]=0.3, ["raw-umber"]=0.15}}
  local y = 30 + k*20
  d:stroke({{30,y},{130,y+2}},{pressure=0.4,dry=true})
  d:stroke({{290,y},{390,y+2}},{pressure=0.4,dry=true})
end
wait(4)
print(clock())
