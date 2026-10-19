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
local base = {["paynes-gray"]=0.4, ["raw-umber"]=0.22, ["french-ultramarine"]=0.06}
local conc = {["paynes-gray"]=0.1, ["raw-umber"]=0.12, ["yellow-ochre"]=0.03}
local b = brush{name="base", width=34}
local c = brush{name="conc", width=34}
for k=0,8 do
  for s=0,9 do topup(b,5,base); b:stroke({{40+s*50,60+k*20},{90+s*50,60+k*20}},{pressure=0.5,duration=0.02}) end
  for s=0,9 do topup(c,5,conc); b:stroke({{40+s*50,300+k*20},{90+s*50,300+k*20}},{pressure=0.5,duration=0.02}) end
end
wait(10)
local gl = {
 {["burnt-sienna"]=0.08},
 {["quinacridone-rose"]=0.03, ["burnt-sienna"]=0.03},
 {["cobalt-violet"]=0.12},
 {["ultramarine-violet"]=0.08},
}
for i,g in ipairs(gl) do
  local x = 40 + (i-1)*130
  local gb = brush{name="g"..i, width=30}
  for k=0,1 do
    topup(gb, 4, g); gb:stroke({{x+10, 30+k*22},{x+10,500}},{pressure=0.5,duration=0.2})
  end
end
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
local gl = {
 {["burnt-sienna"]=0.25},
 {["quinacridone-rose"]=0.08, ["burnt-sienna"]=0.1},
 {["cobalt-violet"]=0.35},
 {["indian-red"]=0.2},
}
for i,g in ipairs(gl) do
  local y = 90 + (i-1)*30
  local gb = brush{name="h"..i, width=24}
  for s=0,7 do
    topup(gb, 4, g); gb:stroke({{30+s*70, y},{100+s*70,y}},{pressure=0.5,duration=0.03})
  end
  local y2 = 320 + (i-1)*30
  for s=0,7 do
    topup(gb, 4, g); gb:stroke({{30+s*70, y2},{100+s*70,y2}},{pressure=0.5,duration=0.03})
  end
end
wait(8)
print(balance().dry)
