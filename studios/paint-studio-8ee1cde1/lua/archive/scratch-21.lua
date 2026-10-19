--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=40,width=1140,height=280, pressure=0.5}
wait(12)
local v2 = brush{name="veilB", width=40}
v2:load{water=4, pigments={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}}
v2:wash{x=-20,y=40,width=1140,height=280, pressure=0.5}
wait(15)
-- fake bar
local m=brush{name="bar", width=18}
for k=0,5 do m:load{water=1.8, pigments={["paynes-gray"]=0.07, ["french-ultramarine"]=0.03, ["burnt-sienna"]=0.01}} m:stroke({{100,140+k*8},{400,140+k*8}},{pressure=0.5,duration=0.12}) end
wait(12)
local function mtn(br, ridge, depth, step, mix, fac, decay)
  local n = math.ceil(depth/step)
  for k=0,n do
    local pts={}
    for _,p in ipairs(ridge) do pts[#pts+1]={p[1], p[2]+k*step} end
    if k%2==1 then local r={} for i=#pts,1,-1 do r[#r+1]=pts[i] end pts=r end
    local f = fac * (1 - decay*k/math.max(n,1))
    local pig={} for kk,v in pairs(mix) do pig[kk]=v*f end
    br:load{water=2.2, pigments=pig}
    br:stroke(pts,{pressure=0.5, duration=0.1})
  end
end
local mix={["paynes-gray"]=0.12, ["french-ultramarine"]=0.06, ["quinacridone-rose"]=0.015, ["buff-titanium"]=0.6}
local b=brush{name="mt", width=20}
mtn(b, {{60,170},{120,150},{180,128},{220,112},{250,118},{290,108},{330,124},{380,145},{440,165}}, 90, 7, mix, 1.0, 0.5)
local mix2={["paynes-gray"]=0.10, ["french-ultramarine"]=0.08, ["quinacridone-rose"]=0.02, ["buff-titanium"]=1.0, ["cerulean-blue"]=0.05}
mtn(b, {{560,170},{620,150},{680,128},{720,112},{750,118},{790,108},{830,124},{880,145},{940,165}}, 90, 7, mix2, 1.0, 0.5)
wait(12) print(balance().dry)



local mixes={
 {["paynes-gray"]=0.2, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["buff-titanium"]=0.3},
 {["paynes-gray"]=0.3, ["french-ultramarine"]=0.12, ["quinacridone-rose"]=0.03, ["buff-titanium"]=0.4},
 {["paynes-gray"]=0.2, ["cobalt-blue"]=0.15, ["burnt-sienna"]=0.03, ["buff-titanium"]=0.2},
 {["paynes-gray"]=0.15, ["french-ultramarine"]=0.08, ["sap-green"]=0.05, ["buff-titanium"]=0.25},
 {["paynes-gray"]=0.35, ["french-ultramarine"]=0.15, ["burnt-sienna"]=0.04, ["buff-titanium"]=0.3},
}
for i,mm in ipairs(mixes) do
  local b=brush{name="q"..i, width=26}
  local x=40+(i-1)*210
  for _,y in ipairs({255,280}) do
    b:load{water=2.5, pigments=mm}
    b:stroke({{x,y},{x+170,y}},{pressure=0.5,duration=0.12})
  end
end
local b=brush{name="q2"}
b:load{water=2.5, pigments=mixes[2]}
b:stroke({{120,135},{390,135}},{pressure=0.5,duration=0.12})
wait(12) print(balance().dry)
