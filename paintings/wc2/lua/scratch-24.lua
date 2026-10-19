paper{width=1056,height=704,kind="cold-press",seed=3117}


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
local b = brush{name="headb", width=18}
local m = {["french-ultramarine"]=0.035,["quinacridone-rose"]=0.012,["burnt-sienna"]=0.010}
for x=590,1070,10 do
  load(b,2.2,m)
  local yt = top(x)+6
  b:stroke({{x,yt},{x+2,(yt+384)/2},{x,384}},{pressure=0.55,duration=0.012})
end
for k=1,8 do wait(1) end
local d1 = brush{name="tree9", width=9}
local d2 = brush{name="tree13", width=13}
local x=632
while x<1066 do
  local d = (math.random()<0.4) and d2 or d1
  local yt = top(x)
  local h = 3+math.random()*7
  if math.random()<0.12 then h = h+7 end
  local depth = 16 + 8*math.random()
  local f = math.min(1,(x-632)/120)
  load(d, 0.7, {["french-ultramarine"]=0.10*f+0.04,["burnt-sienna"]=0.045*f+0.015,["quinacridone-rose"]=0.015,["raw-umber"]=0.015})
  d:stroke({{x,yt+8-h,0.3},{x+1,yt+8,0.6},{x+1,yt+8+depth,0.55}},{duration=0.01})
  x = x+4+math.random()*8
end
for k=1,8 do wait(1) end
-- NEW: clump crowns, round contacts, clustered, darker, varying
local c = brush{name="clump", width=16}
math.randomseed(99)
local x=700
while x<1060 do
  local cw = 20+math.random()*40     -- clump width
  local ch = 6+math.random()*14      -- extra height
  local f = math.min(1,(x-700)/80)
  local n = math.floor(cw/5)
  for j=1,n do
    local px = x + math.random()*cw
    local base = top(px)+10
    local hump = ch*math.sin(((px-x)/cw)*math.pi)
    local py = base - hump*math.random()^0.5 + math.random()*14
    load(c, 0.5, {["french-ultramarine"]=0.16*f+0.05,["burnt-sienna"]=0.07*f+0.02,["quinacridone-rose"]=0.02,["raw-umber"]=0.02})
    c:stroke({{px,py}},{pressure=0.2+0.4*math.random()})
  end
  x = x + cw*0.8 + math.random()*10
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(101)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function top(x)
  if x<590 then return 380 end
  local y
  if x<820 then local u=(x-590)/230; y = 378 - 50*(u*u*(3-2*u))
  else y = 328 - 6*math.sin((x-820)/60) - (x-820)*0.03 end
  return y + 2*math.sin(x/9) + 1.5*math.sin(x/4.3)
end
-- bumpy crown outline
local outline = {}
local x=640
while x<1070 do
  local cw = 14+math.random()*34
  local ch = 3+math.random()*10
  for q=0,cw,3 do
    local u=q/cw
    outline[#outline+1]={x+q, top(x+q)+2 - ch*math.sin(u*math.pi)^0.6}
  end
  x = x+cw
end
local function mixf(xx) local f=math.min(1,(xx-640)/120); return {["french-ultramarine"]=0.09*f+0.03,["burnt-sienna"]=0.04*f+0.01,["quinacridone-rose"]=0.014,["raw-umber"]=0.012} end
local t0=clock()
-- crown edge: short strokes along outline, brush center 5 below outline
local e = brush{name="edge", width=10}
for i=1,#outline-1,3 do
  local a=outline[i]; local b2=outline[math.min(#outline,i+3)]
  load(e, 0.7, mixf(a[1]))
  e:stroke({{a[1],a[2]+5},{b2[1],b2[2]+5}},{pressure=0.55,duration=0.004})
end
-- body rows
local r = brush{name="body", width=16}
for row=1,2 do
  local xx=640
  while xx<1070 do
    load(r, 1.3, mixf(xx))
    r:stroke({{xx, top(xx)+4+row*9},{xx+26, top(xx+26)+4+row*9}},{pressure=0.55,duration=0.004})
    xx=xx+26
  end
end
print(clock()-t0)
for k=1,8 do wait(1) end print(balance().dry)
