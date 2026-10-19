paper{width=1056,height=704,kind="cold-press",seed=3117}


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
  local v = 0.35+0.75*t
  return {["burnt-sienna"]=(0.008+0.02*warm*t)*v, ["french-ultramarine"]=(0.026-0.006*warm)*v, ["raw-umber"]=0.010*v, ["quinacridone-rose"]=0.003*(1-t)}
end
for y=440,700,95 do for x=40,1056,118 do
  local cx,hw=chan(y)
  if math.abs(x-cx) > hw+85 then drop{x=x,y=y,water=8,radius=75} end
end end
local t0=clock()
local y=390; local i=0
while y<712 do
  i=i+1
  local t=math.min(1,(y-386)/318)
  local w = 10+44*t
  local cx,hw = chan(y)
  local b = brush{name="mud"..i, width=w}
  local warm = 0.5+0.5*math.sin(i*1.9)
  local m = mmix(t,warm)
  local segs = {{-20, cx-hw-w*0.5-2},{cx+hw+w*0.5+2, 1076}}
  for _,sg in ipairs(segs) do
    local xa=sg[1]
    while xa < sg[2]-1 do
      local Ls = math.min(40+math.random()*40, sg[2]-xa)
      load(b, 0.8+2.8*t, m)
      b:stroke({{xa,y+math.random()*4-2},{xa+Ls,y+math.random()*4-2}},{pressure=0.6,duration=0.008})
      xa = xa+Ls
    end
  end
  y = y + w*0.55 + math.random()*3
end
print("rows", clock()-t0)
for side=-1,1,2 do
  local bb = brush{name="mbank"..side, width=30}
  local y=396
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
for k=1,12 do wait(1) end print(balance().dry)
