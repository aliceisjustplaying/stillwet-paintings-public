paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(12)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
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
local t0=clock()
-- band: horizontal strokes following the top, wet
local band = brush{name="band", width=16}
local mb = {["french-ultramarine"]=0.05,["burnt-sienna"]=0.025,["quinacridone-rose"]=0.012,["raw-umber"]=0.008}
for x=630,1066,24 do
  load(band, 1.6, mb)
  band:stroke({{x,top(x)+12},{x+26,top(x+26)+12}},{pressure=0.5,duration=0.008})
end
-- dabs into its top edge while wet, varied heights
local d = brush{name="dab", width=10}
local md = {["french-ultramarine"]=0.06,["burnt-sienna"]=0.03,["quinacridone-rose"]=0.012,["raw-umber"]=0.01}
local x=640
while x<1066 do
  load(d, 0.6, md)
  local h = 3+math.random()*9
  if math.random()<0.15 then h = h+8 end
  local yb = top(x)+10
  d:stroke({{x,yb-h,0.25},{x+2,yb,0.55}},{duration=0.006})
  x = x+6+math.random()*8
end
print("laid", clock()-t0)
-- lower softer foot: lighter, wider, to merge into flat
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(13)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function top(x)
  if x<590 then return 380 end
  local y
  if x<820 then local u=(x-590)/230; y = 378 - 50*(u*u*(3-2*u))
  else y = 328 - 6*math.sin((x-820)/60) - (x-820)*0.03 end
  return y + 2*math.sin(x/9) + 1.5*math.sin(x/4.3)
end
local oy=150
local b = brush{name="headb", width=18}
local m = {["french-ultramarine"]=0.035,["quinacridone-rose"]=0.012,["burnt-sienna"]=0.010}
for x=590,1070,10 do
  load(b,2.2,m)
  local yt = top(x)+6+oy
  b:stroke({{x,yt},{x+2,(yt+384+oy)/2},{x,384+oy}},{pressure=0.55,duration=0.012})
end
for k=1,8 do wait(1) end
local t0=clock()
-- tree mass: short vertical dabs, irregular tops, dense, quickly so they merge
local d = brush{name="dab2", width=9}
local x=632
while x<1066 do
  local yt = top(x)+oy
  local h = 4+math.random()*7
  if math.random()<0.12 then h = h+7 end
  local depth = 18 + 6*math.random()
  local f = math.min(1,(x-632)/120)
  load(d, 0.7, {["french-ultramarine"]=0.10*f+0.04,["burnt-sienna"]=0.045*f+0.015,["quinacridone-rose"]=0.015,["raw-umber"]=0.015})
  d:stroke({{x,yt+8-h,0.3},{x+1,yt+8,0.6},{x+1,yt+8+depth,0.55}},{duration=0.01})
  x = x+5+math.random()*5
end
print("laid", clock()-t0)
for k=1,8 do wait(1) end print(balance().dry)
