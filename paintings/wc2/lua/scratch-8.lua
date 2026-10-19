paper{width=1056,height=704,kind="cold-press",seed=3117}


local K = {{386,560,20},{410,505,26},{450,470,38},{500,555,56},{560,690,85},{630,785,128},{710,790,195}}
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
  return {["french-ultramarine"]=0.004+0.03*t^1.3, ["quinacridone-rose"]=0.005+0.002*t, ["raw-sienna"]=0.012*(1-t)^1.5+0.0001}
end
local pb = brush{name="ptest", width=30}
for i,p in ipairs({0.1,0.2,0.35,0.5,0.7,0.9,1.0}) do pb:load{water=1.5,pigments={["french-ultramarine"]=0.05}}; pb:stroke({{60+i*70,100}},{pressure=p}) end
for side=-1,1,2 do
  local bb = brush{name="bank"..side, width=24}
  local y=386
  while y<706 do
    local t=(y-386)/318
    local cx,hw=chan(y)
    local cx2,hw2=chan(y+12)
    local p = 0.15+0.6*t
    local inset = (6+18*t)
    local s=bb:status(); local need=1.2-(s.water or 0)
    if need>0 then local pg={} for k,v in pairs(wmix(t)) do pg[k]=v*need end bb:load{water=need,pigments=pg} end
    bb:stroke({{cx+side*(hw-inset), y, p},{cx2+side*(hw2-inset), y+12, p}},{duration=0.01})
    y=y+12
  end
end
local y=388; local i=0
while y<712 do
  i=i+1
  local t=(y-386)/318
  local w = 8+40*math.min(1,t)
  local cx,hw = chan(y)
  local b = brush{name="ch"..i, width=w}
  local m = wmix(t)
  local x0 = cx-hw+w*0.5; local x1 = cx+hw-w*0.5
  if x1>x0 then
  local n = math.max(1, math.ceil((x1-x0)/50))
  local dir = (i%2==1) and 1 or -1
  for k=0,n-1 do
    local s=b:status(); local need = (0.6+3.0*t)-(s.water or 0)
    if need>0 then local pg={} for kk,v in pairs(m) do pg[kk]=v*need end b:load{water=need,pigments=pg} end
    local L=(x1-x0)/n
    local xa = dir==1 and (x0+k*L) or (x1-k*L)
    b:stroke({{xa,y},{xa+L*dir,y}},{pressure=0.6,duration=0.01})
  end end
  y = y + w*0.45
end
print(clock())
wait(8) print(balance().dry)
