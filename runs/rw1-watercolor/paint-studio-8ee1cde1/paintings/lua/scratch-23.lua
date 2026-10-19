--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=40,width=1140,height=200, pressure=0.5}
wait(12)
local v2 = brush{name="veilB", width=40}
v2:load{water=4, pigments={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}}
v2:wash{x=-20,y=40,width=1140,height=200, pressure=0.5}
wait(15)
local mid={["sap-green"]=0.4, ["hansa-yellow"]=0.1, ["paynes-gray"]=0.05}
for y=140,230,8 do local b=brush{name="fo"..y, width=16} b:load{water=2,pigments=mid} b:stroke({{0,y},{1100,y}},{pressure=0.5,duration=0.3}) end
wait(12)
local mixes={
 {["buff-titanium"]=0.8, ["sap-green"]=0.15, ["hansa-yellow"]=0.1, ["cerulean-blue"]=0.03},
 {["buff-titanium"]=1.2, ["sap-green"]=0.2, ["hansa-yellow"]=0.15},
 {["naples-yellow"]=0.5, ["sap-green"]=0.15, ["cerulean-blue"]=0.05, ["buff-titanium"]=0.5},
 {["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02},
 {["buff-titanium"]=0.9, ["cerulean-blue"]=0.06, ["french-ultramarine"]=0.06, ["quinacridone-rose"]=0.012, ["paynes-gray"]=0.012},
}
for i,mm in ipairs(mixes) do
  local x=40+(i-1)*210
  for j,y in ipairs({120,150,200}) do
    local b=brush{name="m"..i.."_"..j, width=22}
    b:load{water=2.2, pigments=mm}
    b:stroke({{x,y},{x+170,y}},{pressure=0.5,duration=0.1})
  end
end
wait(12) print(balance().dry)
