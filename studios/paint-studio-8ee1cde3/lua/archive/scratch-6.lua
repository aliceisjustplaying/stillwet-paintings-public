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
for x=50,500,80 do for y=50,250,80 do drop{x=x,y=y,water=8,radius=55} end end
local b = brush{name="sky", width=50}
for y=20,290,28 do local x=10 while x<540 do topup(b,5,{["french-ultramarine"]=0.2, ["cobalt-blue"]=0.11, ["cerulean-blue"]=0.05}); b:stroke({{x,y},{x+70,y}},{pressure=0.5,duration=0.02}); x=x+70 end end
wait(10)
local tests = {
 {w=12, water=2, m={["buff-titanium"]=0.8, ["paynes-gray"]=0.03}},
 {w=12, water=1.5, m={["buff-titanium"]=1.5, ["paynes-gray"]=0.04}},
 {w=12, water=1.5, m={["buff-titanium"]=1.0, ["naples-yellow"]=0.4}},
 {w=3, water=0.4, m={["paynes-gray"]=0.3, ["sepia"]=0.15}},
 {w=2, water=0.3, m={["paynes-gray"]=0.3, ["sepia"]=0.2}},
 {w=2, water=0.3, m={["lamp-black"]=0.3}},
}
for i,t in ipairs(tests) do
  local bb = brush{name="t"..i, width=t.w}
  local x = 40 + i*70
  if t.w > 5 then
    for y=10,280,40 do topup(bb,t.water,t.m); bb:stroke({{x,y},{x,y+40}},{pressure=0.5,duration=0.05}) end
  else
    local yy = 30 + i*30
    local x0=20
    while x0<560 do topup(bb,t.water,t.m); bb:stroke({{x0,yy+(x0/560)*40},{x0+60,yy+((x0+60)/560)*40}},{pressure=0.4,duration=0.05}); x0=x0+60 end
  end
end
wait(5)
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
 {w=3, water=0.4, m={["lamp-black"]=0.8, ["paynes-gray"]=0.4}},
 {w=2.5, water=0.3, m={["lamp-black"]=1.2}},
 {w=4, water=0.5, m={["paynes-gray"]=0.8, ["sepia"]=0.4}},
}
for i,t in ipairs(tests) do
  local bb = brush{name="u"..i, width=t.w}
  local yy = 20 + i*25
  local x0=20
  while x0<560 do topup(bb,t.water,t.m); bb:stroke({{x0,yy+(x0/560)*40},{x0+60,yy+((x0+60)/560)*40}},{pressure=0.4,duration=0.05}); x0=x0+60 end
end
wait(5)
