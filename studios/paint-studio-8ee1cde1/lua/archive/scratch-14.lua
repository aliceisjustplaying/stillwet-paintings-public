--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local g = brush{name="land2", width=50}
g:load{water=5, pigments={["sap-green"]=0.04, ["hansa-yellow"]=0.025, ["cobalt-blue"]=0.01, ["buff-titanium"]=0.02}}
g:wash{x=0,y=20,width=1100,height=200, pressure=0.5}
wait(12)
local mixes={
 {["buff-titanium"]=0.8, ["paynes-gray"]=0.05, ["french-ultramarine"]=0.04, ["quinacridone-rose"]=0.012},
 {["buff-titanium"]=1.2, ["paynes-gray"]=0.06, ["french-ultramarine"]=0.06, ["quinacridone-rose"]=0.02},
 {["buff-titanium"]=1.6, ["paynes-gray"]=0.05, ["french-ultramarine"]=0.08, ["quinacridone-rose"]=0.025},
 {["buff-titanium"]=2.5, ["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.01},
 {["buff-titanium"]=4.0, ["french-ultramarine"]=0.04},
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
