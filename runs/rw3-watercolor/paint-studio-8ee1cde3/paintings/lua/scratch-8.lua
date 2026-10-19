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
local b = brush{name="net", width=30}
for y=30,250,18 do local x=20 while x<520 do topup(b,5,{["lamp-black"]=0.4, ["paynes-gray"]=0.2, ["french-ultramarine"]=0.08}); b:stroke({{x,y},{x+50,y}},{pressure=0.5,duration=0.02}); x=x+50 end end
wait(10)
local t = {
 {w=8, water=1.2, m={["buff-titanium"]=1.2, ["paynes-gray"]=0.1}},
 {w=8, water=1.2, m={["buff-titanium"]=2.0, ["paynes-gray"]=0.1}},
 {w=5, water=0.8, m={["buff-titanium"]=2.5}},
 {w=12, water=1.5, m={["cerulean-blue"]=0.8, ["buff-titanium"]=1.0}},
}
for i,tt in ipairs(t) do
  local bb = brush{name="f"..i, width=tt.w}
  local x = 40 + (i-1)*120
  for k=0,3 do topup(bb,tt.water,tt.m); bb:stroke({{x,40+k*50},{x+25,90+k*50}},{pressure=0.5,duration=0.05}) end
end
-- dry brush test
local db = brush{name="dry", width=14}
db:load{water=1, pigments={["buff-titanium"]=2}}
db:stroke({{60,230},{460,200}},{pressure=0.5,dry=true})
wait(6)



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
local mixes = {
 {["lamp-black"]=0.25, ["paynes-gray"]=0.1},
 {["lamp-black"]=0.5, ["paynes-gray"]=0.2},
}
for i,m in ipairs(mixes) do
  local b = brush{name="gl"..i, width=30}
  local x0 = 20 + (i-1)*120 + 10
  for y=20,260,16 do topup(b,4,m); b:stroke({{x0,y},{x0+90,y}},{pressure=0.5,duration=0.02}) end
end
wait(8)



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
local b = brush{name="shadowbase", width=20}
for y=320,420,11 do local x=20 while x<520 do topup(b,4,{["paynes-gray"]=0.05, ["french-ultramarine"]=0.035, ["raw-umber"]=0.01}); b:stroke({{x,y},{x+40,y}},{pressure=0.5,duration=0.02}); x=x+40 end end
wait(8)
local ms = {
 {["raw-umber"]=0.03, ["yellow-ochre"]=0.01, ["paynes-gray"]=0.01},
 {["raw-umber"]=0.05, ["burnt-sienna"]=0.01},
 {["buff-titanium"]=0.2, ["raw-umber"]=0.03},
}
for i,m in ipairs(ms) do
  local g = brush{name="ws"..i, width=20}
  local x = 40 + (i-1)*160
  for y=300,440,35 do topup(g,3,m); g:stroke({{x,y},{x,y+35}},{pressure=0.5,duration=0.02}) end
  for y=300,440,35 do topup(g,3,m); g:stroke({{x+16,y},{x+16,y+35}},{pressure=0.5,duration=0.02}) end
end
wait(6)
