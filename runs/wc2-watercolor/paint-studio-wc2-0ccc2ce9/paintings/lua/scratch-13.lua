paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(9)
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
local function mmix(t, warm)
  local v = 0.35+0.75*t
  return {["burnt-sienna"]=(0.008+0.02*warm*t)*v, ["french-ultramarine"]=(0.026-0.006*warm)*v, ["raw-umber"]=0.010*v, ["quinacridone-rose"]=0.003*(1-t)}
end
local t0=clock()
local y=390; local i=0
while y<712 do
  i=i+1
  local t=math.min(1,(y-386)/318)
  local w = 10+44*t
  local cx,hw = chan(y)
  local b = brush{name="mud"..i, width=w}
  local segs = {{-30, cx-hw-w*0.5-2},{cx+hw+w*0.5+2, 1086}}
  for _,sg in ipairs(segs) do
    local xa=sg[1]
    while xa < sg[2]-1 do
      local Ls = math.min(120+math.random()*200, sg[2]-xa)
      local warm = math.random()
      local m = mmix(t,warm)
      local wl = (0.006+0.010*t)*Ls
      local pg={} for k,v in pairs(m) do pg[k]=v*wl end
      b:load{water=wl, pigments=pg}
      local pts={}
      local n=math.max(2,math.floor(Ls/20))
      local y0=y+math.random()*6-3
      for q=0,n do pts[#pts+1]={xa+Ls*q/n, y0+1.5*math.sin(q*0.9+i)} end
      b:stroke(pts,{pressure=0.55,duration=Ls/2500})
      xa = xa+Ls + (math.random()<0.25 and math.random()*20 or -w*0.2)
    end
  end
  y = y + w*0.6 + math.random()*4
end
print("rows", clock()-t0)
for k=1,12 do wait(1) end print(balance().dry)
