--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=100,width=1140,height=250, pressure=0.5}
wait(12)
local h = brush{name="haze2", width=50}
local function row(y, f)
  h:load{water=4, pigments={["paynes-gray"]=0.025*f, ["french-ultramarine"]=0.02*f, ["quinacridone-rose"]=0.01*f, ["cobalt-blue"]=0.01*f}}
  h:wash{x=-20,y=y,width=1140,height=30, pressure=0.5}
end
row(160,0.8) row(185,0.9) row(210,0.9) row(235,1.0)
wait(15)
local mixes={
 {["sap-green"]=0.3, ["hansa-yellow"]=0.15},
 {["sap-green"]=0.5, ["hansa-yellow"]=0.3},
 {["green-gold"]=0.4, ["sap-green"]=0.2},
 {["sap-green"]=0.4, ["yellow-ochre"]=0.3},
 {["hookers-green"]=0.3, ["hansa-yellow"]=0.3},
 {["sap-green"]=0.6, ["cadmium-yellow"]=0.6},
}
for i,mm in ipairs(mixes) do
  local b=brush{name="f"..i, width=40}
  local x=60+(i-1)*170
  b:load{water=4, pigments=mm}
  b:stroke({{x,140},{x,300}},{pressure=0.5,duration=0.2})
end
wait(12) print(balance().dry)
