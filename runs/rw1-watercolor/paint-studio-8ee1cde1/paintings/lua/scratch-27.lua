--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


math.randomseed(7)
local base={["sap-green"]=0.35, ["hansa-yellow"]=0.1, ["paynes-gray"]=0.05}
for y=40,140,8 do local b=brush{name="d"..y, width=16} b:load{water=2,pigments=base} b:stroke({{0,y},{1100,y}},{pressure=0.5,duration=0.3}) end
local lit={["sap-green"]=0.35, ["hansa-yellow"]=0.15, ["buff-titanium"]=0.3}
local b=brush{name="l", width=10} b:load{water=1.5,pigments=lit} b:stroke({{0,90},{1100,90}},{pressure=0.5,duration=0.2})
wait(12)
local mixes={
 {["hookers-green"]=0.3, ["sap-green"]=0.2, ["paynes-gray"]=0.05},
 {["hookers-green"]=0.2, ["sap-green"]=0.25, ["burnt-sienna"]=0.03},
 {["sap-green"]=0.3, ["paynes-gray"]=0.1},
}
local n=0
for i=1,200 do
  local x=math.random()*1100 local y=40+math.random()*100
  local m=mixes[math.random(1,3)]
  local f=0.6+math.random()*0.6
  local pig={} for k,v in pairs(m) do pig[k]=v*f end
  local len=12+math.random()*22
  n=n+1 local br=brush{name="dab"..n, width=10+math.random()*10}
  br:load{water=1.2, pigments=pig}
  br:stroke({{x,y},{x+len*0.5,y-3+math.random()*6},{x+len,y+math.random()*4-2}},{pressure=0.5,duration=0.05})
end
wait(12) print(balance().dry)
