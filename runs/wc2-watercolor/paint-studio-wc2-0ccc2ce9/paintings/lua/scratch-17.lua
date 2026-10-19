paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(3)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- recreate headland underlayer roughly
local function top(x)
  if x<590 then return 380 end
  local y
  if x<820 then local u=(x-590)/230; y = 378 - 50*(u*u*(3-2*u))
  else y = 328 - 6*math.sin((x-820)/60) - (x-820)*0.03 end
  return y + 2*math.sin(x/9) + 1.5*math.sin(x/4.3)
end
local b = brush{name="head", width=18}
local m = {["french-ultramarine"]=0.035,["quinacridone-rose"]=0.012,["burnt-sienna"]=0.010}
for x=590,1070,10 do
  load(b,2.2,m)
  local yt = top(x)+6
  b:stroke({{x,yt},{x+2,(yt+384)/2},{x,384}},{pressure=0.55,duration=0.012})
end
for k=1,8 do wait(1) end
-- trial: tree crowns as stipple dabs
local d = brush{name="crown", width=12}
local mc = {["french-ultramarine"]=0.06,["burnt-sienna"]=0.025,["quinacridone-rose"]=0.012, ["raw-umber"]=0.01}
local x=650
while x<1060 do
  local yt = top(x)+4
  local n = 2+math.floor(math.random()*3)
  for j=1,n do
    load(d, 0.7, mc)
    local px = x + (math.random()-0.5)*14
    local py = yt + math.random()*16 - 4
    d:stroke({{px,py},{px+math.random()*6-3,py+4+math.random()*8}},{pressure=0.3+0.4*math.random(),duration=0.01})
  end
  x = x + 8 + math.random()*10
end
-- shore line tapering into a spit
local s = brush{name="shore", width=6}
local pts={}
for xx=1060,520,-15 do
  local u = math.max(0,math.min(1,(xx-520)/200))
  pts[#pts+1]={xx, 382+ (1-u)*2 + math.random()*1.2, 0.1+0.5*u}
end
load(s, 1.2, {["french-ultramarine"]=0.12,["burnt-sienna"]=0.07,["quinacridone-rose"]=0.02})
s:stroke(pts,{duration=0.15})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(5)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function top(x)
  local y
  if x<820 then local u=(x-590)/230; y = 378 - 50*(u*u*(3-2*u))
  else y = 328 - 6*math.sin((x-820)/60) - (x-820)*0.03 end
  return y + 2*math.sin(x/9) + 1.5*math.sin(x/4.3)
end
local oy = 200
local d = brush{name="crown2", width=7}
local mc = {["french-ultramarine"]=0.09,["burnt-sienna"]=0.04,["quinacridone-rose"]=0.015, ["raw-umber"]=0.015}
local x=640
while x<1060 do
  local yt = top(x)+5+oy
  load(d, 0.35, mc)
  local px = x + (math.random()-0.5)*6
  local h = 4+math.random()*8
  d:stroke({{px,yt-h*0.3,0.2},{px+1,yt+h*0.5,0.5},{px,yt+h+6,0.35}},{duration=0.01})
  x = x + 5 + math.random()*9
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(8)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function top(x)
  local y
  if x<820 then local u=(x-590)/230; y = 378 - 50*(u*u*(3-2*u))
  else y = 328 - 6*math.sin((x-820)/60) - (x-820)*0.03 end
  return y + 2*math.sin(x/9) + 1.5*math.sin(x/4.3)
end
local oy = 120
-- underlayer copy at oy
local b = brush{name="head2", width=18}
local m = {["french-ultramarine"]=0.035,["quinacridone-rose"]=0.012,["burnt-sienna"]=0.010}
for x=590,1070,10 do
  load(b,2.2,m)
  local yt = top(x)+6+oy
  b:stroke({{x,yt},{x+2,(yt+384+oy)/2},{x,384+oy}},{pressure=0.55,duration=0.012})
end
for k=1,8 do wait(1) end
local r = brush{name="ridge", width=9}
local mc = {["french-ultramarine"]=0.07,["burnt-sienna"]=0.03,["quinacridone-rose"]=0.012, ["raw-umber"]=0.012}
local x=660
while x<1066 do
  local pts={}
  local seg = 40+math.random()*40
  for q=0,seg,4 do
    local xx = x+q
    local bump = math.abs(math.sin((xx)/7.3+math.random()*0.6))*5
    pts[#pts+1]={xx, top(xx)+7+oy - bump + math.random()*2, 0.35+0.35*math.random()}
  end
  load(r, 1.2, mc)
  r:stroke(pts,{duration=0.05})
  x = x+seg
end
-- slightly wet second band, lower, softer to fuse
local r2 = brush{name="ridge2", width=14}
x=640
while x<1066 do
  load(r2, 1.5, {["french-ultramarine"]=0.04,["burnt-sienna"]=0.02,["quinacridone-rose"]=0.008})
  r2:stroke({{x,top(x)+18+oy},{x+60,top(x+60)+18+oy}},{pressure=0.5,duration=0.02})
  x=x+60
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)
