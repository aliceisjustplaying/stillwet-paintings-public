--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local mix={["paynes-gray"]=0.05, ["french-ultramarine"]=0.03, ["cobalt-blue"]=0.02, ["burnt-sienna"]=0.008}
local m = brush{name="mtn", width=20}
for k=0,6 do
  local pig={} for kk,v in pairs(mix) do pig[kk]=v*0.9 end
  m:load{water=2, pigments=pig}
  m:stroke({{100,100+k*7},{700,100+k*7}},{pressure=0.5,duration=0.2})
end
local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.05, ["hansa-yellow"]=0.03, ["cobalt-blue"]=0.01, ["buff-titanium"]=0.03}}
g:wash{x=0,y=200,width=1100,height=100, pressure=0.5}
wait(12)
-- veils: vertical swatches crossing the mountain and green
local mixes={
 {["buff-titanium"]=1.2, ["paynes-gray"]=0.06, ["french-ultramarine"]=0.06, ["quinacridone-rose"]=0.02},
 {["buff-titanium"]=2.0, ["paynes-gray"]=0.05, ["french-ultramarine"]=0.06, ["quinacridone-rose"]=0.02},
 {["paynes-gray"]=0.04, ["french-ultramarine"]=0.03, ["quinacridone-rose"]=0.015},
 {["paynes-gray"]=0.02, ["cobalt-blue"]=0.03, ["ultramarine-violet"]=0.02},
}
for i,mm in ipairs(mixes) do
  local b=brush{name="v"..i, width=40}
  local x=150+(i-1)*150
  b:load{water=4, pigments=mm}
  b:stroke({{x,90},{x,290}},{pressure=0.5,duration=0.2})
end
wait(12) print(balance().dry)
