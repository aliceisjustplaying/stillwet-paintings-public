--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=100,width=1140,height=250, pressure=0.5}
wait(12)
local v2 = brush{name="veilB", width=40}
v2:load{water=4, pigments={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}}
v2:wash{x=-20,y=100,width=1140,height=250, pressure=0.5}
wait(15)
local mixes={
 {["paynes-gray"]=0.08, ["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.015},
 {["paynes-gray"]=0.15, ["french-ultramarine"]=0.08, ["quinacridone-rose"]=0.02},
 {["paynes-gray"]=0.25, ["french-ultramarine"]=0.12, ["burnt-sienna"]=0.03},
 {["buff-titanium"]=2.5, ["cerulean-blue"]=0.15, ["naples-yellow"]=0.5},
 {["buff-titanium"]=3.0, ["cerulean-blue"]=0.3},
 {["sap-green"]=0.15, ["yellow-ochre"]=0.1},
 {["sap-green"]=0.1, ["hansa-yellow"]=0.1},
}
for i,mm in ipairs(mixes) do
  local b=brush{name="m"..i, width=30}
  local x=50+(i-1)*150
  b:load{water=3, pigments=mm}
  b:stroke({{x,130},{x+100,130}},{pressure=0.5,duration=0.15})
  b:load{water=3, pigments=mm}
  b:stroke({{x,200},{x+100,200}},{pressure=0.5,duration=0.15})
end
wait(12) print(balance().dry)



local function ridgefill(br, ridge, depth, step, mix, fac, decay)
  local n = math.ceil(depth/step)
  for k=0,n do
    local pts={}
    for _,p in ipairs(ridge) do pts[#pts+1]={p[1], p[2]+k*step} end
    if k%2==1 then local r={} for i=#pts,1,-1 do r[#r+1]=pts[i] end pts=r end
    local f = fac * (1 - decay*k/math.max(n,1))
    local pig={} for kk,v in pairs(mix) do pig[kk]=v*f end
    br:load{water=1.8, pigments=pig}
    br:stroke(pts,{pressure=0.5, duration=0.2})
  end
end
local mix={["paynes-gray"]=0.08, ["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.015}
local m=brush{name="rf", width=18}
ridgefill(m, {{20,240},{100,230},{160,226},{220,232},{300,240},{360,246}}, 40, 8, mix, 0.5, 0.8)
ridgefill(m, {{380,250},{420,240},{460,228},{490,222},{520,226},{560,236},{600,250}}, 60, 8, mix, 1.0, 0.85)
ridgefill(m, {{620,250},{660,242},{700,238},{740,244}}, 60, 10, mix, 1.5, 0.9)
wait(12) print(balance().dry)



local function ridgefill(br, ridge, depth, step, mix, fac, decay, water)
  local n = math.ceil(depth/step)
  for k=0,n do
    local pts={}
    for _,p in ipairs(ridge) do pts[#pts+1]={p[1], p[2]+k*step} end
    if k%2==1 then local r={} for i=#pts,1,-1 do r[#r+1]=pts[i] end pts=r end
    local f = fac * (1 - decay*k/math.max(n,1))
    local pig={} for kk,v in pairs(mix) do pig[kk]=v*f end
    br:load{water=water or 1.8, pigments=pig}
    br:stroke(pts,{pressure=0.5, duration=0.12})
  end
end
local mix={["paynes-gray"]=0.08, ["french-ultramarine"]=0.03, ["burnt-sienna"]=0.01, ["quinacridone-rose"]=0.008}
local w=brush{name="wat", width=24}
local r1={{20,300},{100,290},{160,286},{220,292},{300,300},{360,306}}
local r2={{380,310},{420,300},{460,288},{490,282},{520,286},{560,296},{600,310}}
ridgefill(w, r2, 70, 12, {}, 0, 0, 3)
ridgefill(w, r1, 50, 12, {}, 0, 0, 3)
local m=brush{name="rf2", width=18}
ridgefill(m, r1, 30, 8, mix, 0.5, 0.9)
ridgefill(m, r2, 45, 8, mix, 1.0, 0.95)
wait(12) print(balance().dry)



local base={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}
local b=brush{name="mist", width=22}
local function band(x0,x1,y,f)
  local pig={} for k,v in pairs(base) do pig[k]=v*f end
  b:load{water=2.5, pigments=pig}
  b:stroke({{x0,y},{(x0+x1)/2,y+3},{x1,y}},{pressure=0.5,duration=0.12})
end
-- over left set (r1 bars y~286-330 left, 222-260 earlier top). use first set bars at y 226-280
for i,f in ipairs({0.4,0.6,0.8,1.0}) do band(370,610,250+i*10,f) end
for i,f in ipairs({0.6,0.9,1.2,1.5}) do band(10,370,240+i*10,f) end
wait(12) print(balance().dry)
