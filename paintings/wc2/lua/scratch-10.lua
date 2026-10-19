paper{width=1056,height=704,kind="cold-press",seed=3117}


local K = {{386,450,250},{392,470,190},{402,520,70},{418,478,46},{445,468,40},{490,560,55},{560,700,85},{630,785,128},{710,790,195}}
local function chan(y)
  if y<=K[1][1] then return K[1][2],K[1][3] end
  for i=1,#K-1 do
    if y<=K[i+1][1] then
      local u=(y-K[i][1])/(K[i+1][1]-K[i][1]); u=u*u*(3-2*u)
      return K[i][2]+(K[i+1][2]-K[i][2])*u, K[i][3]+(K[i+1][3]-K[i][3])*u
    end
  end
  return K[#K][2],K[#K][3]
end
local function wmix(t)
  t=math.min(1,math.max(0,t))
  return {["french-ultramarine"]=0.004+0.024*t^1.3, ["quinacridone-rose"]=0.005+0.002*t, ["raw-sienna"]=0.012*(1-t)^1.5+0.0001, ["burnt-sienna"]=0.003*t+0.0001}
end
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
for side=-1,1,2 do
  local bb = brush{name="bank"..side, width=24}
  local y=387
  while y<706 do
    local t=(y-386)/318
    local cx,hw=chan(y); local cx2,hw2=chan(y+6)
    local p = 0.15+0.6*t
    local inset = (4+18*t)
    load(bb,1.0,wmix(t))
    bb:stroke({{cx+side*(hw-inset), y, p},{cx2+side*(hw2-inset), y+6, p}},{duration=0.006})
    y=y+6
  end
end
local y=388; local i=0
while y<712 do
  i=i+1
  local t=(y-386)/318
  local w = 6+40*math.min(1,t)
  local cx,hw = chan(y)
  local b = brush{name="ch"..i, width=w}
  local m = wmix(t)
  local x0 = cx-hw+w*0.5; local x1 = cx+hw-w*0.5
  if x1>x0 then
  local n = math.max(1, math.ceil((x1-x0)/50))
  local dir = (i%2==1) and 1 or -1
  for k=0,n-1 do
    load(b, 0.5+3.0*t, m)
    local L=(x1-x0)/n
    local xa = dir==1 and (x0+k*L) or (x1-k*L)
    b:stroke({{xa,y},{xa+L*dir,y}},{pressure=0.6,duration=0.01})
  end end
  y = y + w*0.45
end
local L = brush{name="lifter", width=3}
L:load{water=1} L:lift({{720,610},{790,611}})
L:load{water=1} L:lift({{680,655},{760,656},{830,655}})
L:load{water=1} L:lift({{880,688},{940,689}})
print("water laid", clock())
wait(8) print(balance().dry)



math.randomseed(7)
local K = {{386,450,250},{392,470,190},{402,520,70},{418,478,46},{445,468,40},{490,560,55},{560,700,85},{630,785,128},{710,790,195}}
local function chan(y)
  if y<=K[1][1] then return K[1][2],K[1][3] end
  for i=1,#K-1 do
    if y<=K[i+1][1] then
      local u=(y-K[i][1])/(K[i+1][1]-K[i][1]); u=u*u*(3-2*u)
      return K[i][2]+(K[i+1][2]-K[i][2])*u, K[i][3]+(K[i+1][3]-K[i][3])*u
    end
  end
  return K[#K][2],K[#K][3]
end
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function mmix(t, warm)
  local v = 0.35+0.65*t   -- value strength
  return {["burnt-sienna"]=(0.012+0.02*warm)*v, ["french-ultramarine"]=(0.026-0.008*warm)*v, ["raw-umber"]=0.012*v}
end
local t0=clock()
-- bank strokes just outside channel (mud side), y from 400 down
for side=-1,1,2 do
  local bb = brush{name="mbank"..side, width=30}
  local y=398
  while y<706 do
    local t=(y-386)/318
    local cx,hw=chan(y); local cx2,hw2=chan(y+6)
    local p = 0.15+0.55*t
    local r = 30*(0.3+0.75*p)/2
    load(bb,1.2,mmix(t,0.6))
    bb:stroke({{cx+side*(hw+r+1), y, p},{cx2+side*(hw2+r+1), y+6, p}},{duration=0.006})
    y=y+6
  end
end
print("banks", clock()-t0)
-- rows
local y=388; local i=0
while y<712 do
  i=i+1
  local t=math.min(1,(y-386)/318)
  local w = 8+46*t
  local cx,hw = chan(y)
  local b = brush{name="mud"..i, width=w}
  local warm = 0.5+0.5*math.sin(i*1.9)
  local m = mmix(t,warm)
  local segs = {}
  local a1 = cx-hw-w*0.5-2
  if y<398 then a1 = cx-hw-w*0.5-2 end
  segs[1]={-20, a1}; segs[2]={cx+hw+w*0.5+2, 1076}
  for _,sg in ipairs(segs) do
    local xa=sg[1]
    while xa < sg[2]-1 do
      local Ls = math.min(30+math.random()*40, sg[2]-xa)
      load(b, 0.8+3.0*t, m)
      b:stroke({{xa,y+math.random()*4-2},{xa+Ls,y+math.random()*4-2}},{pressure=0.6,duration=0.008})
      xa = xa+Ls
    end
  end
  y = y + w*0.5 + math.random()*3
end
print("rows", clock()-t0)
wait(12) print(balance().dry)
