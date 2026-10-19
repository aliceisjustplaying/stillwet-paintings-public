--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


math.randomseed(3)
local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=100,width=1140,height=200, pressure=0.5}
wait(12)
local v2 = brush{name="veilB", width=40}
v2:load{water=4, pigments={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}}
v2:wash{x=-20,y=100,width=1140,height=200, pressure=0.5}
wait(15)
local n=0
local function st(pts,w,water,m,dur) n=n+1 local b=brush{name="t"..n, width=w} b:load{water=water,pigments=m} b:stroke(pts,{pressure=0.5,duration=dur or 0.06}) end
-- A: distant forest bands, hazy blue-green, varying
local A1={["hookers-green"]=0.1, ["paynes-gray"]=0.05, ["buff-titanium"]=0.6, ["cerulean-blue"]=0.05}
local A2={["hookers-green"]=0.15, ["paynes-gray"]=0.08, ["buff-titanium"]=0.5, ["french-ultramarine"]=0.03}
local A3={["sap-green"]=0.12, ["buff-titanium"]=0.9, ["hansa-yellow"]=0.05, ["cerulean-blue"]=0.04}
local A4={["sap-green"]=0.08, ["buff-titanium"]=1.2, ["naples-yellow"]=0.3, ["cerulean-blue"]=0.03}
for i,m in ipairs({A1,A2,A3,A4}) do
  for k=1,10 do local x=(i-1)*270+20+math.random()*150 local y=130+math.random()*120 local len=30+math.random()*80
    st({{x,y},{x+len*0.5,y+math.random()*4-2},{x+len,y+math.random()*3}}, 6+math.random()*8, 0.8, m) end
end
wait(12) print(balance().dry)



local w=brush{name="gzA", width=50}
w:load{water=4, pigments={["raw-sienna"]=0.02, ["quinacridone-rose"]=0.004, ["sap-green"]=0.01}}
w:wash{x=0,y=120,width=360,height=160,pressure=0.5}
local w2=brush{name="gzB", width=50}
w2:load{water=4, pigments={["raw-sienna"]=0.04, ["sap-green"]=0.03, ["paynes-gray"]=0.01}}
w2:wash{x=380,y=120,width=360,height=160,pressure=0.5}
local w3=brush{name="gzC", width=50}
w3:load{water=4, pigments={["yellow-ochre"]=0.03, ["sap-green"]=0.02, ["quinacridone-rose"]=0.006,["paynes-gray"]=0.01}}
w3:wash{x=760,y=120,width=340,height=160,pressure=0.5}
wait(15) print(balance().dry)
