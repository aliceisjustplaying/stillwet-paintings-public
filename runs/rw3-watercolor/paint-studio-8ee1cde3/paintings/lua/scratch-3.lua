--@ watercolor-engine 2

paper{width=1100,height=660,kind="cold-press",seed=2023}


local mixes = {
 {name="cream", m={["yellow-ochre"]=0.05, ["raw-umber"]=0.02}},
 {name="cream2", m={["yellow-ochre"]=0.04, ["paynes-gray"]=0.01, ["raw-sienna"]=0.02}},
 {name="beigeL", m={["yellow-ochre"]=0.15, ["raw-umber"]=0.08, ["burnt-sienna"]=0.02}},
 {name="pillar", m={["yellow-ochre"]=0.1, ["raw-umber"]=0.03}},
 {name="road", m={["paynes-gray"]=0.12, ["burnt-umber"]=0.05}},
 {name="road2", m={["neutral-tint"]=0.15, ["raw-umber"]=0.04}},
 {name="concrete", m={["paynes-gray"]=0.06, ["raw-umber"]=0.05}},
 {name="gate", m={["sepia"]=0.6, ["paynes-gray"]=0.3}},
 {name="net", m={["lamp-black"]=0.5, ["paynes-gray"]=0.3}},
 {name="hedge", m={["hookers-green"]=0.5, ["paynes-gray"]=0.2, ["sap-green"]=0.2}},
 {name="hedgeL", m={["sap-green"]=0.3, ["yellow-ochre"]=0.1}},
 {name="shadowW", m={["paynes-gray"]=0.05, ["french-ultramarine"]=0.03}},
}
for i,mm in ipairs(mixes) do
  local b = brush{name="sw"..i, width=40}
  local col = (i-1)%6; local row = math.floor((i-1)/6)
  local x = 40 + col*175; local y = 60 + row*120
  for k=0,1 do
    b:load{water=6, pigments=mm.m}
    b:stroke({{x,y+k*30},{x+130,y+k*30}}, {pressure=0.6, duration=0.1})
  end
end
wait(6)
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
local mixes = {
 {["paynes-gray"]=0.3, ["burnt-umber"]=0.12},
 {["paynes-gray"]=0.25, ["raw-umber"]=0.15, ["french-ultramarine"]=0.05},
 {["neutral-tint"]=0.25, ["burnt-umber"]=0.1},
}
for i,m in ipairs(mixes) do
  local b = brush{name="rd"..i, width=40}
  local x = 40 + (i-1)*250
  for k=0,3 do
    topup(b, 5, m)
    b:stroke({{x,330+k*25},{x+200,330+k*25}}, {pressure=0.5, duration=0.05})
  end
end
wait(6)
-- markings test
local w1 = brush{name="mk1", width=8}
local w2 = brush{name="mk2", width=8}
local w3 = brush{name="mk3", width=8}
for i=0,2 do
  local x = 60 + i*250
  w1:load{water=1.5, pigments={["buff-titanium"]=0.8}}
  w1:stroke({{x,345},{x+150,345}}, {pressure=0.6})
  w2:load{water=1.5, pigments={["buff-titanium"]=0.6, ["naples-yellow"]=0.2}}
  w2:stroke({{x,370},{x+150,370}}, {pressure=0.6})
  w3:load{water=1.0, pigments={["buff-titanium"]=1.5}}
  w3:stroke({{x,395},{x+150,395}}, {pressure=0.6})
end
wait(5)
print(balance().dry)
