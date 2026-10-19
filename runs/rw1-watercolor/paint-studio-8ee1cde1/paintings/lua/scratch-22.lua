--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=40,width=1140,height=330, pressure=0.5}
wait(12)
local v2 = brush{name="veilB", width=40}
v2:load{water=4, pigments={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}}
v2:wash{x=-20,y=40,width=1140,height=100, pressure=0.5}
local h = brush{name="haze2", width=50}
for _,y in ipairs({140,165}) do
h:load{water=4, pigments={["paynes-gray"]=0.025, ["french-ultramarine"]=0.02, ["quinacridone-rose"]=0.01, ["cobalt-blue"]=0.01}}
h:wash{x=-20,y=y,width=1140,height=30, pressure=0.5}
end
wait(15)
local mixes={
 {["hookers-green"]=0.25, ["sap-green"]=0.2, ["burnt-sienna"]=0.03, ["hansa-yellow"]=0.05},
 {["sap-green"]=0.35, ["hansa-yellow"]=0.1, ["paynes-gray"]=0.04},
 {["sap-green"]=0.25, ["green-gold"]=0.15, ["burnt-umber"]=0.03},
 {["hookers-green"]=0.15, ["sap-green"]=0.15, ["buff-titanium"]=0.6, ["cerulean-blue"]=0.05},
 {["sap-green"]=0.2, ["yellow-ochre"]=0.1, ["buff-titanium"]=0.5},
}
for i,mm in ipairs(mixes) do
  local x=40+(i-1)*210
  for j,y in ipairs({60,90,150,180,230,260,300,330}) do
    local b=brush{name="f"..i.."_"..j, width=24}
    b:load{water=2.2, pigments=mm}
    b:stroke({{x,y},{x+170,y}},{pressure=0.5,duration=0.1})
  end
end
wait(12) print(balance().dry)



local b=brush{name="tt", width=20}
b:load{water=2, pigments={["sap-green"]=0.2}}
b:stroke({{100,450},{200,450}},{})
local s=b:status()
for k,v in pairs(s) do print(k,v) end
for k,v in pairs(s.pigments) do print(k,v) end
