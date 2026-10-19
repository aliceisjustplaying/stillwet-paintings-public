--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local g = brush{name="land2", width=50}
for y=40,140,25 do g:load{water=5, pigments={["sap-green"]=0.05, ["hansa-yellow"]=0.03, ["cobalt-blue"]=0.008, ["yellow-ochre"]=0.01}} g:stroke({{20,y},{1080,y}},{pressure=0.5,duration=0.3}) end
wait(12)
local mixes={
 {["buff-titanium"]=0.4, ["cerulean-blue"]=0.15, ["paynes-gray"]=0.02},
 {["buff-titanium"]=0.6, ["cerulean-blue"]=0.25, ["paynes-gray"]=0.03},
 {["buff-titanium"]=0.6, ["cerulean-blue"]=0.15, ["cobalt-violet"]=0.05},
 {["cerulean-blue"]=0.3, ["paynes-gray"]=0.03, ["buff-titanium"]=0.2},
 {["buff-titanium"]=1.0, ["cerulean-blue"]=0.35, ["paynes-gray"]=0.04},
}
for i,m in ipairs(mixes) do
  local b=brush{name="h"..i, width=40}
  b:load{water=3, pigments=m}
  local x=40+(i-1)*210
  b:stroke({{x,30},{x+150,30}},{pressure=0.5,duration=0.15})
  b:load{water=3, pigments=m}
  b:stroke({{x,70},{x+150,70}},{pressure=0.5,duration=0.15})
  b:load{water=3, pigments=m}
  b:stroke({{x,210},{x+150,210}},{pressure=0.5,duration=0.15})
end
wait(12) print(balance().dry)
