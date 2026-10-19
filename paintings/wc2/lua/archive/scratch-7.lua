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
local skip = {[6]=true,[10]=true,[15]=true}
local y=387; local i=0
while y<712 do
  i=i+1
  local t=(y-386)/318
  local w = 8+50*t
  local cx,hw = chan(y)
  if not skip[i] then
    local b = brush{name="ch"..i, width=w}
    local m = {["french-ultramarine"]=0.004+0.022*t^1.2, ["quinacridone-rose"]=0.004+0.002*t, ["raw-sienna"]=0.008*(1-t)}
    local x0 = cx-hw+w*0.35; local x1 = cx+hw-w*0.35
    local n = math.max(1, math.ceil((x1-x0)/50))
    local dir = (i%2==1) and 1 or -1
    for k=0,n-1 do
      local s=b:status(); local need = (0.6+3.5*t)-(s.water or 0)
      if need>0 then local pg={} for kk,v in pairs(m) do pg[kk]=v*need end b:load{water=need,pigments=pg} end
      local L=(x1-x0)/n
      local xa = dir==1 and (x0+k*L) or (x1-k*L)
      b:stroke({{xa,y},{xa+L*dir,y}},{pressure=0.6,duration=0.01})
    end
  end
  y = y + w*0.6
end
print(clock())
wait(8) print(balance().dry)
