--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


-- underlayers: slab y40-140, navy y140-200, yellow-green y200-320
local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=40,width=1140,height=280, pressure=0.5}
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
 {["sap-green"]=0.5, ["hansa-yellow"]=0.2, ["paynes-gray"]=0.05},
 {["hookers-green"]=0.4, ["sap-green"]=0.3, ["burnt-sienna"]=0.05},
 {["sap-green"]=0.6, ["yellow-ochre"]=0.2, ["paynes-gray"]=0.1},
 {["hookers-green"]=0.3, ["green-gold"]=0.3},
 {["sap-green"]=0.3, ["hansa-yellow"]=0.15},
}
for i,mm in ipairs(mixes) do
  local b=brush{name="f"..i, width=30}
  local x=40+(i-1)*210
  for y=60,300,30 do
    b:load{water=2.5, pigments=mm}
    b:stroke({{x,y},{x+170,y}},{pressure=0.5,duration=0.12})
  end
end
wait(12) print(balance().dry)
