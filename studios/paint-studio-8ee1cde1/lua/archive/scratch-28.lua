--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


math.randomseed(9)
local mA={["indian-red"]=1.1, ["burnt-umber"]=0.55, ["buff-titanium"]=0.4, ["paynes-gray"]=0.03}
local mB={["indian-red"]=0.4, ["raw-umber"]=0.3, ["burnt-sienna"]=0.15, ["buff-titanium"]=0.7}
for y=400,640,15 do local b=brush{name="u"..y, width=28} b:load{water=3,pigments=(y%30==10) and mB or mA} b:stroke({{0,y},{1100,y+5}},{pressure=0.5,duration=0.2}) end
wait(15)
-- glaze trials in columns
local gz={
 {["paynes-gray"]=0.08, ["burnt-umber"]=0.08},
 {["paynes-gray"]=0.15, ["raw-umber"]=0.1},
 {["buff-titanium"]=1.0, ["paynes-gray"]=0.08, ["raw-umber"]=0.1},
 {["sepia"]=0.15, ["paynes-gray"]=0.05},
}
for i,m in ipairs(gz) do
  for y=410,500,12 do local b=brush{name="g"..i.."_"..y, width=26} b:load{water=2.5,pigments=m} b:stroke({{(i-1)*270+20,y},{(i-1)*270+250,y}},{pressure=0.5,duration=0.06}) end
end
wait(12)
-- stones and speckles in lower band
local light={["buff-titanium"]=2.0, ["paynes-gray"]=0.1, ["raw-umber"]=0.05}
local dk={["paynes-gray"]=0.4, ["sepia"]=0.3}
local n=0
for i=1,60 do
  local x=math.random()*1100 local y=540+math.random()*90
  local s=2+math.random()*4
  n=n+1 local b=brush{name="sp"..n, width=s} b:load{water=0.25,pigments=dk} b:stroke({{x,y},{x+s,y+math.random()*2}},{pressure=0.5,duration=0.03})
end
for i=1,15 do
  local x=40+math.random()*1000 local y=560+math.random()*60
  local w=10+math.random()*16
  n=n+1 local b=brush{name="sl"..n, width=w*0.6} b:load{water=0.6,pigments=light} b:stroke({{x,y},{x+w*0.4,y-w*0.25},{x+w,y}},{pressure=0.5,duration=0.04})
  n=n+1 local b2=brush{name="sd"..n, width=w*0.35} b2:load{water=0.4,pigments=dk} b2:stroke({{x-2,y+w*0.25},{x+w*0.5,y+w*0.35},{x+w+2,y+w*0.15}},{pressure=0.5,duration=0.04})
end
wait(12) print(balance().dry)
