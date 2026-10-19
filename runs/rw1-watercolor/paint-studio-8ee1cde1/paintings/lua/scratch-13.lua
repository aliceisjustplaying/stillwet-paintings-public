--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local g = brush{name="land2", width=50}
for y=40,240,30 do g:load{water=4, pigments={["sap-green"]=0.05, ["hansa-yellow"]=0.03, ["cobalt-blue"]=0.008, ["buff-titanium"]=0.02}} g:stroke({{20,y},{1080,y}},{pressure=0.5,duration=0.3}) end
wait(12)
local mixes={
 {["buff-titanium"]=0.5, ["paynes-gray"]=0.04, ["ultramarine-violet"]=0.03},
 {["buff-titanium"]=0.8, ["paynes-gray"]=0.05, ["french-ultramarine"]=0.04, ["quinacridone-rose"]=0.01},
 {["buff-titanium"]=1.0, ["cobalt-blue"]=0.08, ["cobalt-violet"]=0.05, ["paynes-gray"]=0.03},
 {["buff-titanium"]=1.4, ["cobalt-blue"]=0.10, ["paynes-gray"]=0.05,["quinacridone-rose"]=0.015},
 {["buff-titanium"]=2.0, ["cobalt-blue"]=0.12, ["paynes-gray"]=0.06,["quinacridone-rose"]=0.02},
}
for i,m in ipairs(mixes) do
  local b=brush{name="h"..i, width=40}
  local x=40+(i-1)*210
  for _,y in ipairs({60,100,300}) do
    b:load{water=3, pigments=m}
    b:stroke({{x,y},{x+150,y}},{pressure=0.5,duration=0.15})
  end
end
wait(12) print(balance().dry)
