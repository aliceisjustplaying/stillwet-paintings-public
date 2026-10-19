--@ watercolor-engine 2

paper{width=1100,height=650,kind="cold-press",seed=4127}


math.randomseed(5)
local g = brush{name="g", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=380,width=1140,height=200, pressure=0.5}
local dark={["hookers-green"]=0.5, ["sap-green"]=0.4, ["burnt-sienna"]=0.08, ["hansa-yellow"]=0.08}
for y=410,520,8 do local b=brush{name="d"..y, width=16} b:load{water=2,pigments=dark} b:stroke({{0,y},{400,y}},{pressure=0.5,duration=0.2}) end
wait(15)
local tb={{-20,462},{100,468},{250,480},{380,494},{495,500},{600,508},{715,517},{800,530},{880,545},{960,560},{1045,578},{1120,592}}
local function topB(x) for i=1,#tb-1 do local a,b=tb[i],tb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 600 end
local mA={["indian-red"]=1.2, ["burnt-umber"]=0.5, ["buff-titanium"]=0.4}
local mB={["indian-red"]=0.4, ["raw-umber"]=0.3, ["burnt-sienna"]=0.2, ["buff-titanium"]=0.6}
local mC={["indian-red"]=0.8, ["burnt-umber"]=0.4, ["quinacridone-burnt-orange"]=0.1}
local mixes={mA,mB,mC}
local n=0
for y=466,665,16 do
  local x=-20
  while x<1110 and n<200 do
    local len=120+math.random()*120
    local x1=math.min(x+len,1125)
    local pts={}
    for i=0,6 do local xx=x+(x1-x)*i/6 local yy=y+math.random()*6-3 local t=topB(xx) if yy<t+2 then yy=t+2+math.random()*3 end pts[#pts+1]={xx,yy} end
    local b=brush{name="sc"..n, width=28}
    local m=mixes[math.random(1,3)]
    local f=0.7+math.random()*0.5
    local pig={} for k,v in pairs(m) do pig[k]=v*f end
    b:load{water=3, pigments=pig}
    b:stroke(pts,{pressure=0.5,duration=0.08})
    n=n+1
    if x1>=1120 then break end
    x=x1-10
  end
end
print(n, clock())
wait(15) print(balance().dry)



math.randomseed(3)
local darkS={["paynes-gray"]=0.5, ["burnt-umber"]=0.4, ["indian-red"]=0.2}
local lightS={["buff-titanium"]=3.0, ["paynes-gray"]=0.12, ["french-ultramarine"]=0.05}
local grass={["sap-green"]=0.6, ["hansa-yellow"]=0.25, ["hookers-green"]=0.1}
local function stone(x,y,r,mix,water)
  local b=brush{name="st"..x.."_"..y, width=math.max(2,r)}
  b:load{water=water, pigments=mix}
  local pts={{x-r*0.6,y},{x,y-r*0.3},{x+r*0.6,y+r*0.1}}
  b:stroke(pts,{pressure=0.5,duration=0.05})
end
for i=1,40 do stone(40+math.random()*500, 480+math.random()*160, 3+math.random()*8, darkS, 0.6) end
for i=1,30 do stone(560+math.random()*500, 480+math.random()*160, 3+math.random()*8, lightS, 0.7) end
-- shaded stone: light top + dark bottom
for i=1,8 do local x,y=100+i*110, 600 stone(x,y,12,lightS,0.8) stone(x+2,y+6,10,darkS,0.5) end
-- grass tufts: short upward flicks
for i=1,30 do local x,y=600+math.random()*400, 500+math.random()*60
  local b=brush{name="gr"..i, width=4}
  b:load{water=0.5, pigments=grass}
  for j=1,4 do local dx=math.random()*16-8 b:stroke({{x+dx,y},{x+dx*1.5+math.random()*6-3,y-8-math.random()*8}},{pressure=0.6,duration=0.04}) end
end
wait(10) print(balance().dry)
