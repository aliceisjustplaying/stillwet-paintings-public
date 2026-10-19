paper{width=1056, height=704, kind="cold-press", seed=3117}
print(table.concat(palette(), ", "))


math.randomseed(11)
local t0=clock()
for y=30,340,90 do for x=40,1056,118 do drop{x=x,y=y,water=10,radius=85} end end
local function mix(t, x)
  local p = {}
  local g = math.exp(-((x-260)/380)^2)   -- glow on the left
  local u = 0.034*(1-t)^1.3 * (1-0.35*g*t)
  if u>0.0005 then p["french-ultramarine"]=u end
  local r = (0.007+0.004*g)*math.exp(-((t-0.62)/0.22)^2)
  if r>0.0003 then p["quinacridone-rose"]=r end
  local s = (0.008+0.008*g)*math.max(0,(t-0.5)/0.5)
  if s>0.0003 then p["quinacridone-burnt-orange"]=s*0.6; p["raw-sienna"]=s*0.5 end
  if t<0.5 then p["burnt-sienna"]=0.003 end
  return p
end
local i=0
for y=10,350,40 do
  i=i+1
  local t=(y-10)/335
  local b = brush{name="skyrow"..i, width=70}
  local dir = (i%2==1) and 1 or -1
  for k=0,17 do
    local x = dir==1 and (-20+k*62) or (1076-k*62)
    local m = mix(t, x+31*dir)
    local s=b:status(); local need = 5 - (s.water or 0)
    if need>0 then local pg={} for kk,v in pairs(m) do pg[kk]=v*need end b:load{water=need,pigments=pg} end
    b:stroke({{x,y+3*math.sin(k+i)},{x+62*dir,y+3*math.sin(k+1+i)}},{pressure=0.65,duration=0.012})
  end
end
print("rows", clock()-t0)
local c = brush{name="cloudA", width=34}
local function streak(pts, wtarget, m, pr)
  for j=1,#pts-1 do
    local s=c:status(); local need = wtarget-(s.water or 0)
    if need>0 then local pg={} for kk,v in pairs(m) do pg[kk]=v*need end c:load{water=need,pigments=pg} end
    c:stroke({pts[j],pts[j+1]},{pressure=pr or 0.5,duration=0.02})
  end
end
local cm = {["french-ultramarine"]=0.035,["burnt-sienna"]=0.012,["quinacridone-rose"]=0.008}
streak({{560,70},{640,62},{720,58},{800,64},{880,60},{960,68},{1060,64}}, 3, cm, 0.6)
streak({{620,100},{700,94},{790,98},{860,108}}, 2.5, cm, 0.45)
streak({{-10,120},{60,112},{140,116},{220,128}}, 2.5, cm, 0.5)
streak({{380,165},{450,158},{530,160},{610,168},{680,166}}, 2.5, cm, 0.45)
streak({{760,200},{840,194},{920,198},{1000,192},{1070,196}}, 2.5, cm, 0.45)
local cw = {["french-ultramarine"]=0.02,["quinacridone-rose"]=0.012,["burnt-sienna"]=0.006}
streak({{80,262},{160,258},{250,262},{330,268}}, 2.0, cw, 0.3)
streak({{520,288},{600,284},{690,288},{760,292},{840,290}}, 2.0, cw, 0.3)
streak({{900,250},{970,246},{1060,250}}, 2.0, cw, 0.3)
print("clouds", clock()-t0)
for i=1,8 do wait(1); local s=balance(); print(clock()-t0, s.max_surface_water, s.dry) end



math.randomseed(21)
local function top(x)
  -- headland silhouette
  if x<590 then return 380 end
  local y
  if x<820 then local u=(x-590)/230; y = 378 - 50*(u*u*(3-2*u))
  else y = 328 - 6*math.sin((x-820)/60) - (x-820)*0.03 end
  return y + 2*math.sin(x/9) + 1.5*math.sin(x/4.3)
end
local b = brush{name="head", width=18}
local m = {["french-ultramarine"]=0.035,["quinacridone-rose"]=0.012,["burnt-sienna"]=0.010}
for x=590,1070,10 do
  local s=b:status(); local need = 2.2-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end
  local yt = top(x)+6
  b:stroke({{x,yt},{x+2,(yt+384)/2},{x,384}},{pressure=0.55,duration=0.012})
end
print(clock())
-- darker foot band wet into wet
local d = brush{name="headfoot", width=12}
local md = {["french-ultramarine"]=0.05,["burnt-sienna"]=0.03,["quinacridone-rose"]=0.01}
for x=640,1070,40 do
  local s=d:status(); local need = 1.5-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(md) do pg[k]=v*need end d:load{water=need,pigments=pg} end
  d:stroke({{x,377+math.random()*3},{x+42,376+math.random()*3}},{pressure=0.5,duration=0.02})
end
-- far pale strip left
local f = brush{name="farstrip", width=8}
local mf = {["french-ultramarine"]=0.02,["quinacridone-rose"]=0.01,["burnt-sienna"]=0.004}
for x=-10,600,50 do
  local s=f:status(); local need = 1.0-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(mf) do pg[k]=v*need end f:load{water=need,pigments=pg} end
  local y0 = 374 - 3*math.exp(-((x-150)/120)^2)
  f:stroke({{x,y0},{x+52,y0+math.random()*1.5}},{pressure=0.5,duration=0.02})
end
print(clock())
for i=1,8 do wait(1) end
print(balance().dry)



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
  local bb = brush{name="wbank"..side, width=24}
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
  local b = brush{name="wrow"..i, width=w}
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
print("water laid", clock())
for k=1,10 do wait(1) end print(balance().dry)



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
  local v = 0.5+1.0*t
  return {["burnt-sienna"]=(0.008+0.02*warm*t)*v, ["french-ultramarine"]=(0.026-0.006*warm)*v, ["raw-umber"]=0.010*v, ["quinacridone-rose"]=0.004*(1-t)}
end
for y=490,700,95 do for x=40,1056,118 do
  local cx,hw=chan(y)
  if math.abs(x-cx) > hw+85 then drop{x=x,y=y,water=8,radius=70} end
end end
local t0=clock()
local y=389; local i=0
while y<712 do
  i=i+1
  local t=math.min(1,(y-386)/318)
  local w = 9+45*t
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
      b:stroke({{xa,y+math.random()*3-1.5},{xa+Ls,y+math.random()*3-1.5}},{pressure=0.6,duration=0.008})
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
    load(bb,1.2,mmix(t,0.7))
    bb:stroke({{cx+side*(hw+r+1), y, p},{cx2+side*(hw2+r+1), y+6, p}},{duration=0.006})
    y=y+6
  end
end
print("banks", clock()-t0)
for k=1,12 do wait(1) end print(balance().dry)



math.randomseed(31)
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
local function mmix(t, warm, x)
  local edge = 1 + 0.5*math.exp(-(x/250)^2) + 0.3*math.exp(-((1056-x)/200)^2)
  local v = (0.25+1.2*t^1.3)*edge
  return {["burnt-sienna"]=(0.010+0.018*warm)*v, ["french-ultramarine"]=(0.022-0.006*warm)*v, ["raw-umber"]=0.012*v}
end
local t0=clock()
local y=404; local i=0
while y<720 do
  i=i+1
  local t=math.min(1,(y-386)/318)
  local w = 8+46*t
  local cx,hw = chan(y)
  local b = brush{name="mudg"..i, width=w}
  local warm = 0.5+0.5*math.sin(i*2.3)
  local segs = {{-20, cx-hw-w*0.5-6},{cx+hw+w*0.5+6, 1076}}
  for _,sg in ipairs(segs) do
    local xa=sg[1]
    while xa < sg[2]-1 do
      local Ls = math.min(35+math.random()*45, sg[2]-xa)
      if math.random() < 0.88 then
        load(b, 0.7+2.6*t, mmix(t,warm,xa))
        b:stroke({{xa,y+math.random()*3-1.5},{xa+Ls,y+math.random()*3-1.5}},{pressure=0.55,duration=0.008})
      else
        xa = xa + 6
      end
      xa = xa+Ls
    end
  end
  y = y + w*0.6 + math.random()*3
end
print("rows", clock()-t0)
-- tributary runnels lifted while wet
local L = brush{name="runlift", width=7}
local runs = {
  {{40,690},{140,662},{260,640},{360,618},{450,596},{540,578},{590,566}},
  {{870,700},{900,668},{950,640},{1010,622},{1070,612}},
  {{200,560},{290,548},{380,540},{455,530}},
}
for _,r in ipairs(runs) do L:load{water=3}; L:lift(r,{pressure=0.5}) end
print("lift", clock()-t0)
for k=1,12 do wait(1) end print(balance().dry)



math.randomseed(41)
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
local t0=clock()
local y=585; local i=0
while y<730 do
  i=i+1
  local s=math.min(1,(y-585)/100)
  local w = 50
  local cx,hw = chan(y)
  local b = brush{name="fg"..i, width=w}
  local segs = {{-20, cx-hw-w*0.5-4},{cx+hw+w*0.5+4, 1076}}
  for _,sg in ipairs(segs) do
    local xa=sg[1]
    while xa < sg[2]-1 do
      local Ls = math.min(40+math.random()*50, sg[2]-xa)
      local edge = 1 + 0.6*math.exp(-(xa/300)^2)
      local v = (0.15+0.9*s^1.5)*edge
      local warm = math.random()
      if math.random() < 0.93 then
        load(b, 3.0, {["burnt-sienna"]=(0.012+0.012*warm)*v, ["french-ultramarine"]=(0.02-0.005*warm)*v, ["burnt-umber"]=0.012*v})
        b:stroke({{xa,y+math.random()*4-2},{xa+Ls,y+math.random()*4-2}},{pressure=0.55,duration=0.008})
      end
      xa = xa+Ls
    end
  end
  y = y + 26 + math.random()*4
end
print("fg", clock()-t0)
for k=1,12 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 70; local oy = 108
local L=130
local function sheer(x) local u=(x-230)/L; return oy+474 + 30*u - 22*u*u end
local function bottom(x)
  local u=(x-230)/L
  local yk = oy+514 - 6*u*u
  if u < 0.25 then local v=u/0.25; return (oy+474) + (yk-(oy+474))*math.sqrt(1-(1-v)^2) end
  return yk
end
-- tapered cast shadow, falling slightly right/forward
local sh = brush{name="bshadow", width=8}
local pts={}
for x=246,392,6 do
  local u=(x-246)/146
  local p = 0.25+0.55*math.sin(u*math.pi)^0.6
  pts[#pts+1]={x+ox, oy+514+2*math.sin(u*math.pi), p}
end
load(sh, 1.2, {["french-ultramarine"]=0.55,["burnt-umber"]=0.5,["alizarin-crimson"]=0.06})
sh:stroke(pts,{duration=0.08})
local hb = brush{name="bhull", width=4}
for r=0,1,0.09 do
  local pts={}
  for x=230,360,3 do
    local yt=sheer(x)+2.5; local yb=bottom(x)
    if yb>yt then pts[#pts+1]={x+ox, yt+(yb-yt)*r} end
  end
  local dark = r
  load(hb, 0.6, {["burnt-umber"]=0.9+0.5*dark,["alizarin-crimson"]=0.5,["burnt-sienna"]=0.5*(1-dark),["french-ultramarine"]=0.2+0.6*dark})
  hb:stroke(pts,{pressure=0.4,duration=0.05})
end
local tb = brush{name="bstrake", width=3}
local p2={}
load(tb, 0.6, {["pyrrol-scarlet"]=0.6,["burnt-sienna"]=0.6,["quinacridone-burnt-orange"]=0.4})
for x=231,360,4 do p2[#p2+1]={x+ox,sheer(x)+1.2} end
tb:stroke(p2,{pressure=0.5})
local tr = brush{name="btransom", width=3}
load(tr, 0.4, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
tr:stroke({{360+ox,sheer(360)},{361+ox,bottom(360)}},{pressure=0.5})
for k=1,6 do wait(1) end
local m = brush{name="bmast", width=3}
load(m, 0.5, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
m:stroke({{298+ox,oy+492},{306+ox,oy+440},{316+ox,oy+370},{322+ox,oy+330}},{pressure=0.6,duration=0.12})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(77)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local n=10
local A={1010,692}; local B={742,428}
for i=0,n-1 do
  -- perspective spacing
  local f = 1-(1-i/(n-1))^0.55
  f = i/(n-1); f = f^0.6
  local x = A[1]+(B[1]-A[1])*f + (math.random()-0.5)*6
  local y = A[2]+(B[2]-A[2])*f
  local s = (y-400)/292     -- scale 0..1
  local h = 6 + 70*s^1.3 * (0.75+0.5*math.random())
  local w = 2 + 6*s
  local lean = (math.random()-0.5)*0.15*h
  if not (i==3) then
    local b = brush{name="post"..i, width=w}
    -- soft wet shadow/reflection under the post
    local r = brush{name="prefl"..i, width=w*1.1}
    load(r, 0.4, {["french-ultramarine"]=0.25,["burnt-umber"]=0.2})
    r:stroke({{x+1,y+1},{x+1.5,y+3+h*0.35}},{pressure=0.4,duration=0.02})
    load(b, 0.5, {["burnt-umber"]=1.1,["french-ultramarine"]=0.7,["burnt-sienna"]=0.2})
    b:stroke({{x,y,0.55},{x+lean*0.5,y-h*0.5,0.5},{x+lean,y-h,0.4}},{duration=0.03})
  end
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(77)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local n=10
local A={1010,692}; local B={742,428}
local P={}
for i=0,n-1 do
  local f = (i/(n-1))^0.6
  local x = A[1]+(B[1]-A[1])*f + (math.random()-0.5)*6
  local y = A[2]+(B[2]-A[2])*f
  local s = (y-400)/292
  local h = 6 + 70*s^1.3 * (0.75+0.5*math.random())
  local w = 2 + 6*s
  local lean = (math.random()-0.5)*0.15*h
  P[#P+1]={x=x,y=y,s=s,h=h,w=w,lean=lean,i=i}
end
math.randomseed(1234)
for _,p in ipairs(P) do
  -- darken existing post core
  if p.i ~= 3 then
    local b = brush{name="pd"..p.i, width=math.max(1.5,p.w*0.6)}
    load(b, 0.4, {["burnt-umber"]=1.4,["french-ultramarine"]=1.1})
    b:stroke({{p.x+p.w*0.15,p.y},{p.x+p.lean*0.5+p.w*0.15,p.y-p.h*0.5},{p.x+p.lean,p.y-p.h*0.95}},{pressure=0.5,duration=0.03})
  end
  -- companion posts
  local k = (p.i==3) and 3 or (math.random()<0.6 and 1 or 0)
  for c=1,k do
    local dx = (math.random()<0.5 and -1 or 1)*(p.w*1.2 + math.random()*p.w*1.5)
    local x = p.x+dx; local y = p.y + (math.random()-0.3)*p.s*6
    local h = p.h*(0.35+0.6*math.random())
    local w = p.w*(0.8+0.5*math.random())
    local lean = (math.random()-0.5)*0.2*h
    local r = brush{name="cr"..p.i.."_"..c, width=w*1.1}
    load(r, 0.4, {["french-ultramarine"]=0.3,["burnt-umber"]=0.25})
    r:stroke({{x+1,y+1},{x+1.5,y+3+h*0.3}},{pressure=0.4,duration=0.02})
    local b = brush{name="cp"..p.i.."_"..c, width=w}
    load(b, 0.5, {["burnt-umber"]=1.5,["french-ultramarine"]=1.0,["burnt-sienna"]=0.2})
    b:stroke({{x,y,0.55},{x+lean*0.5,y-h*0.5,0.5},{x+lean,y-h,0.45}},{duration=0.03})
  end
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 70; local oy = 108
local L=130
local function sheer(x) local u=(x-230)/L; return oy+474 + 30*u - 22*u*u end
local inn = brush{name="binner", width=3}
for x=238,352,3 do
  local uu=(x-230)/L
  local h = 7*math.sin(math.min(1,(uu-0.06)/0.86)*math.pi)
  if h>1 then
    load(inn, 0.3, {["yellow-ochre"]=1.2,["raw-sienna"]=0.6,["burnt-sienna"]=0.3,["naples-yellow"]=0.6})
    inn:stroke({{x+ox,sheer(x)-h},{x+ox,sheer(x)}},{pressure=0.4,duration=0.01})
  end
end
for k=1,4 do wait(1) end
local fg = brush{name="bfargun", width=2}
local pts={}
for x=236,356,4 do
  local uu=(x-230)/L
  local h = 7*math.sin(math.min(1,math.max(0,(uu-0.06)/0.86))*math.pi)
  pts[#pts+1]={x+ox, sheer(x)-h}
end
load(fg, 0.3, {["burnt-umber"]=1.4,["french-ultramarine"]=0.8,["alizarin-crimson"]=0.3})
fg:stroke(pts,{pressure=0.45})
local st = brush{name="bstay", width=1.5}
load(st, 0.2, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
st:stroke({{322+ox,oy+332},{262+ox,oy+420},{232+ox,sheer(232)}},{pressure=0.4,duration=0.1})
load(st, 0.2, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
st:stroke({{232+ox,sheer(232)+4},{218+ox,oy+505},{200+ox,oy+514},{175+ox,oy+519}},{pressure=0.6,duration=0.1})
-- re-touch the mast over the interior
local m = brush{name="bmast2", width=3}
load(m, 0.4, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
m:stroke({{298+ox,oy+493},{302+ox,oy+470}},{pressure=0.6,duration=0.03})
print(clock())
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
-- low spit to the left, tapered
local s = brush{name="spit", width=5}
load(s, 0.8, {["french-ultramarine"]=0.12,["burnt-sienna"]=0.06,["quinacridone-rose"]=0.02})
local pts={}
for xx=650,540,-10 do local u=(650-xx)/110; pts[#pts+1]={xx, 380.5+u*1.0, 0.55*(1-u)+0.08} end
s:stroke(pts,{duration=0.06})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(51)
local K = {{386,450,250},{392,470,190},{402,520,70},{418,478,46},{445,468,40},{490,560,55},{560,700,85},{630,785,128},{710,790,195}}
local function chan(y)
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
local t0=clock()
local i=0
for y=596,724,18 do
  i=i+1
  local s = math.max(0,(y-596)/110)^1.4
  local cx,hw = chan(y)
  local b = brush{name="vig"..i, width=44}
  local x=-20
  while x<1076 do
    local inch = (x > cx-hw+6 and x < cx+hw-6)
    local m
    if inch then m = {["french-ultramarine"]=0.035*s+0.001,["quinacridone-rose"]=0.008*s,["burnt-umber"]=0.006*s}
    else
      local edge = 1+0.5*math.exp(-(x/260)^2)
      m = {["burnt-umber"]=(0.03*s+0.001)*edge,["french-ultramarine"]=0.025*s*edge,["alizarin-crimson"]=0.005*s}
    end
    load(b, 3.0, m)
    local L = 34
    b:stroke({{x,y+math.random()*4-2},{x+L,y+math.random()*4-2}},{pressure=0.55,duration=0.006})
    x=x+L
  end
end
print("vig", clock()-t0)
for k=1,10 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- soft broad shadow glaze around the bar
local g = brush{name="shglaze", width=16}
local pts={}
for x=296,482,8 do
  local u=(x-296)/186
  pts[#pts+1]={x, 623+3*u, 0.6*(1-u)^0.7+0.12}
end
load(g, 2.0, {["french-ultramarine"]=0.12,["burnt-umber"]=0.08,["alizarin-crimson"]=0.03})
g:stroke(pts,{duration=0.08})
-- fill gap between hull and shadow at keel
local k = brush{name="keelgap", width=3}
local p2={}
for x=310,428,5 do p2[#p2+1]={x, 619.5} end
load(k, 0.3, {["burnt-umber"]=1.0,["french-ultramarine"]=0.8,["alizarin-crimson"]=0.15})
k:stroke(p2,{pressure=0.5})
print(clock())
for i=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local cover = {
 {103,146,450,17},{104,168,463,19},{45,90,488,23},{73,116,538,30},{125,192,577,36},
 {888,950,411,12},{872,919,441,16},{887,937,450,17},{957,1019,538,30},{705,756,411,12},{40,104,463,19}
}
local pools = {
 {-20,65,404,11},{59,129,419,13},{93,178,441,16},{-20,37,475,21},{89,144,503,25},{136,183,556,33},
 {353,419,429,14},{277,327,475,21},{425,472,503,25},{450,511,538,30},{549,598,556,33},
 {638,693,404,11},{762,833,404,11},{885,938,404,11},{1021,1062,411,12},{898,977,429,14},{1025,1082,429,14},
 {636,685,441,16},{755,815,450,17},{953,1006,463,19},{748,798,488,23},{957,1034,519,27},{875,948,577,36},{584,603,577,36}
}
for i,g in ipairs(cover) do
  local x0,x1,y,w = g[1],g[2],g[3],g[4]
  local t=math.min(1,(y-386)/318)
  local edge = 1 + 0.5*math.exp(-(x0/250)^2) + 0.3*math.exp(-((1056-x0)/200)^2)
  local v = (0.25+1.2*t^1.3)*edge
  local c = brush{name="cov"..i, width=w}
  load(c, 0.7+2.6*t, {["burnt-sienna"]=0.019*v, ["french-ultramarine"]=0.019*v, ["raw-umber"]=0.012*v})
  c:stroke({{x0-3,y,0.35},{(x0+x1)/2,y+0.5,0.55},{x1+3,y,0.35}},{duration=0.01})
end
for i,g in ipairs(pools) do
  local x0,x1,y,w = g[1],g[2],g[3],g[4]
  local t=math.min(1,(y-400)/200)
  local p = brush{name="pool"..i, width=w*0.95}
  local pts={}
  local n=8
  for q=0,n do
    local uu=q/n
    pts[#pts+1]={x0-2+(x1-x0+4)*uu, y+(uu-0.5)*1.5, 0.2+0.4*math.sin(uu*math.pi)^0.5}
  end
  load(p, 0.8, {["french-ultramarine"]=0.008+0.02*t,["quinacridone-rose"]=0.006+0.004*t,["raw-sienna"]=0.010*(1-t)+0.001})
  p:stroke(pts,{duration=0.03})
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(61)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function top(x)
  if x<590 then return 380 end
  local y
  if x<820 then local u=(x-590)/230; y = 378 - 50*(u*u*(3-2*u))
  else y = 328 - 6*math.sin((x-820)/60) - (x-820)*0.03 end
  return y + 2*math.sin(x/9) + 1.5*math.sin(x/4.3)
end
-- unify the treeline: two horizontal glaze rows, quick, so they merge
local g = brush{name="treeglz", width=14}
for row=0,1 do
  local x=640
  while x<1070 do
    local yy = top(x)+16+row*12
    local f = math.min(1,(x-640)/100)
    load(g, 1.4, {["french-ultramarine"]=0.045*f+0.01,["burnt-sienna"]=0.02*f+0.005,["quinacridone-rose"]=0.01})
    g:stroke({{x,yy},{x+30,top(x+30)+16+row*12}},{pressure=0.55,duration=0.006})
    x=x+30
  end
end
-- break up the boat shadow bar with irregular dark-mud rag strokes
local r = brush{name="bshrag", width=12}
for i=1,24 do
  local x = 300+math.random()*190; local y=616+math.random()*20
  local L = 10+math.random()*30
  local d = math.exp(-((x-370)/90)^2)
  load(r, 1.2, {["burnt-umber"]=0.08+0.12*d,["french-ultramarine"]=0.06+0.1*d,["burnt-sienna"]=0.05})
  r:stroke({{x,y,0.3+0.4*math.random()},{x+L,y+math.random()*4-2,0.2}},{duration=0.01})
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
local function mixf(xx) local f=math.min(1,(xx-640)/120); return {["french-ultramarine"]=0.065*f+0.02,["burnt-sienna"]=0.028*f+0.008,["quinacridone-rose"]=0.011,["raw-umber"]=0.009} end
local e = brush{name="tedge", width=10}
for i=1,#outline-1,3 do
  local a=outline[i]; local b2=outline[math.min(#outline,i+3)]
  load(e, 0.7, mixf(a[1]))
  e:stroke({{a[1],a[2]+5},{b2[1],b2[2]+5}},{pressure=0.55,duration=0.004})
end
local r = brush{name="tbody", width=16}
for row=1,2 do
  local xx=640
  while xx<1070 do
    load(r, 1.3, mixf(xx))
    r:stroke({{xx, top(xx)+4+row*9},{xx+26, top(xx+26)+4+row*9}},{pressure=0.55,duration=0.004})
    xx=xx+26
  end
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(71)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- soft unifying mud-dark glaze over the shadow area, rows laid quickly so they merge
local g = brush{name="shunify", width=22}
for row=0,2 do
  local y = 613 + row*12
  local x = 262 - row*10
  while x < 540 - row*20 do
    local u = (x-262)/280
    local d = math.exp(-((x-380)/120)^2)
    load(g, 2.0, {["burnt-umber"]=0.05+0.05*d,["french-ultramarine"]=0.04+0.05*d,["burnt-sienna"]=0.03,["alizarin-crimson"]=0.006})
    g:stroke({{x,y+math.random()*3-1.5,0.5},{x+28,y+math.random()*3-1.5,0.5}},{duration=0.005})
    x = x+28
  end
end
-- left end of the headland: tapered descending strokes
local t = brush{name="htaper", width=12}
local function top(x)
  local u=(x-590)/230; return 378 - 50*(u*u*(3-2*u))
end
for i=0,5 do
  local x = 604 + i*7
  local yt = top(x)+6 + (5-i)*1.5
  load(t, 0.7, {["french-ultramarine"]=0.05,["burnt-sienna"]=0.022,["quinacridone-rose"]=0.011,["raw-umber"]=0.008})
  t:stroke({{x,yt,0.25},{x+10,yt+2,0.45},{x+18,384,0.5}},{duration=0.006})
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(81)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- dark foreground mud band left of channel, irregular top, laid quickly to merge
local K = {{560,700,85},{630,785,128},{710,790,195}}
local function chanL(y)
  for i=1,#K-1 do
    if y<=K[i+1][1] then
      local u=(y-K[i][1])/(K[i+1][1]-K[i][1]); u=u*u*(3-2*u)
      return (K[i][2]+(K[i+1][2]-K[i][2])*u) - (K[i][3]+(K[i+1][3]-K[i][3])*u)
    end
  end
  return K[#K][2]-K[#K][3]
end
local t0=clock()
local i=0
for y=600,716,16 do
  i=i+1
  local b = brush{name="fgd"..i, width=30}
  local xe = chanL(y) - 30
  local x = -20
  while x < xe do
    local L = math.min(30+math.random()*25, xe-x)
    local s = math.min(1,(y-596)/40)
    local d = math.exp(-((x-380)/170)^2)
    load(b, 2.2, {["burnt-umber"]=(0.035+0.03*d)*s+0.005,["french-ultramarine"]=(0.025+0.03*d)*s+0.004,["burnt-sienna"]=0.02*s+0.004,["alizarin-crimson"]=0.004})
    local yy = y + ((i==1) and (math.random()*10-5) or (math.random()*4-2))
    b:stroke({{x,yy},{x+L,yy+math.random()*3-1.5}},{pressure=0.55,duration=0.005})
    x = x+L
  end
end
print(clock()-t0)
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(91)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local m1 = {["buff-titanium"]=2.0,["french-ultramarine"]=0.12,["quinacridone-rose"]=0.06}
local streaks = {
  {40,652,150,1},{210,664,120,0},{90,684,200,1},{330,648,90,0},{470,676,110,1},{20,632,70,0},{520,640,60,0},{300,694,140,1},
  {150,622,50,0},{560,694,70,0}
}
for i,s in ipairs(streaks) do
  local x,y,L,dry = s[1],s[2],s[3],s[4]
  if dry==1 then
    local d = brush{name="sheenD"..i, width=12}
    load(d, 0.6, m1)
    d:stroke({{x,y,0.25},{x+L*0.5,y+1,0.55},{x+L,y,0.15}},{dry=true,duration=0.05})
  else
    local b = brush{name="sheenW"..i, width=4}
    load(b, 0.5, m1)
    b:stroke({{x,y,0.12},{x+L*0.35,y,0.45},{x+L*0.7,y+0.6,0.4},{x+L,y,0.06}},{duration=0.04})
  end
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(93)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local K = {{560,700,85},{630,785,128},{710,790,195}}
local function chanL(y)
  for i=1,#K-1 do
    if y<=K[i+1][1] then
      local u=(y-K[i][1])/(K[i+1][1]-K[i][1]); u=u*u*(3-2*u)
      return (K[i][2]+(K[i+1][2]-K[i][2])*u) - (K[i][3]+(K[i+1][3]-K[i][3])*u)
    end
  end
  return K[#K][2]-K[#K][3]
end
-- ragged dark top edge around the shadow box ends, merging with band
local r = brush{name="ragtop", width=14}
local x=-10
while x<590 do
  if not (x>300 and x<430) then
    local yt = 594 + math.random()*10
    local L = 14+math.random()*22
    load(r, 0.9, {["burnt-umber"]=0.07,["french-ultramarine"]=0.055,["burnt-sienna"]=0.035,["alizarin-crimson"]=0.005})
    r:stroke({{x,yt,0.3},{x+L*0.5,yt+3,0.6},{x+L,yt+8,0.5}},{duration=0.005})
    x = x + L*0.8
  else x = x + 10 end
end
-- broad transparent glaze over lower foreground, quick rows
local i=0
for y=622,712,18 do
  i=i+1
  local b = brush{name="fgglz"..i, width=30}
  local xe = chanL(y) - 25
  local xx = -20
  while xx < xe do
    local L = math.min(40, xe-xx)
    load(b, 2.0, {["burnt-umber"]=0.025,["french-ultramarine"]=0.022,["alizarin-crimson"]=0.004})
    b:stroke({{xx,y},{xx+L,y+math.random()*2-1}},{pressure=0.55,duration=0.004})
    xx = xx+L
  end
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local streaks = {
  {40,652,150,1},{210,664,120,0},{90,684,200,1},{330,648,90,0},{470,676,110,1},{20,632,70,0},{520,640,60,0},{300,694,140,1},
  {150,622,50,0},{560,694,70,0}
}
for i,s in ipairs(streaks) do
  local x,y,L,dry = s[1],s[2],s[3],s[4]
  local b = brush{name="knock"..i, width= dry==1 and 16 or 10}
  local c = dry==1 and 0.7 or 1.2
  load(b, 1.2, {["burnt-umber"]=0.06*c,["french-ultramarine"]=0.05*c,["burnt-sienna"]=0.02*c,["alizarin-crimson"]=0.006*c})
  b:stroke({{x-6,y,0.5},{x+L*0.5,y+1,0.55},{x+L+6,y,0.5}},{duration=0.02})
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local streaks = {
  {40,652,150,1},{210,664,120,0},{90,684,200,1},{330,648,90,0},{470,676,110,1},{20,632,70,0},{520,640,60,0},{300,694,140,1},
  {150,622,50,0},{560,694,70,0}
}
local c=0.8
for i,s in ipairs(streaks) do
  local x,y,L,dry = s[1],s[2],s[3],s[4]
  local b = brush{name="cover"..i, width= dry==1 and 18 or 10}
  local pts={}
  local n=math.max(2,math.floor(L/25))
  for q=0,n do pts[#pts+1]={x-6+(L+12)*q/n, y+(q%2)*0.8} end
  for pass=1,(dry==1 and 1 or 1) do
    load(b, 0.6, {["burnt-umber"]=0.5*c,["french-ultramarine"]=0.4*c,["burnt-sienna"]=0.15*c,["alizarin-crimson"]=0.05*c})
    b:stroke(pts,{pressure=0.5,duration=0.03})
  end
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(103)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local K = {{490,560,55},{560,700,85},{630,785,128},{710,790,195}}
local function chan(y)
  for i=1,#K-1 do
    if y<=K[i+1][1] then
      local u=(y-K[i][1])/(K[i+1][1]-K[i][1]); u=u*u*(3-2*u)
      return K[i][2]+(K[i+1][2]-K[i][2])*u, K[i][3]+(K[i+1][3]-K[i][3])*u
    end
  end
  return K[#K][2],K[#K][3]
end
-- transition band left: y 540-600, broken strokes, strength rising downward
local i=0
for y=544,600,12 do
  i=i+1
  local s=(y-540)/60
  local b = brush{name="trans"..i, width=18}
  local cx,hw = chan(y)
  local xe = cx-hw-16
  local x=-20
  while x<xe do
    local L = math.min(20+math.random()*40, xe-x)
    if math.random() < 0.55+0.4*s then
      local edge = 1+0.4*math.exp(-(x/200)^2)
      load(b, 1.4, {["burnt-umber"]=(0.02+0.035*s)*edge,["french-ultramarine"]=(0.016+0.028*s)*edge,["burnt-sienna"]=0.018,["alizarin-crimson"]=0.003})
      local yy=y+math.random()*6-3
      b:stroke({{x,yy,0.35},{x+L*0.5,yy+1,0.55},{x+L,yy+math.random()*2,0.35}},{duration=0.004})
    end
    x = x+L+math.random()*8
  end
end
-- right foreground darkening (x from channel right edge to edge), y 600-710
local j=0
for y=604,716,14 do
  j=j+1
  local s=math.min(1,(y-600)/80)
  local b = brush{name="rfg"..j, width=26}
  local cx,hw = chan(y)
  local x0 = cx+hw+18
  local x = x0
  while x<1076 do
    local L = 22+math.random()*30
    if math.random() < 0.6+0.4*s then
      local edge = 1+0.5*math.exp(-((1056-x)/150)^2)
      load(b, 1.8, {["burnt-umber"]=(0.015+0.04*s)*edge,["french-ultramarine"]=(0.012+0.032*s)*edge,["burnt-sienna"]=0.015,["alizarin-crimson"]=0.003})
      local yy=y+math.random()*4-2
      b:stroke({{x,yy,0.35},{x+L*0.5,yy+1,0.55},{x+L,yy,0.4}},{duration=0.004})
    end
    x = x+L
  end
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 70; local oy = 108
local L=130
local function sheer(x) local u=(x-230)/L; return oy+474 + 30*u - 22*u*u end
local function bottom(x)
  local u=(x-230)/L
  local yk = oy+514 - 6*u*u
  if u < 0.25 then local v=u/0.25; return (oy+474) + (yk-(oy+474))*math.sqrt(1-(1-v)^2) end
  return yk
end
local s1 = brush{name="cstrakeP", width=4}
for r=0,0.36,0.12 do
  local pts={}
  for x=232,358,3 do
    local yt=sheer(x)+2; local yb=bottom(x)
    if yb>yt then pts[#pts+1]={x+ox, yt+(yb-yt)*r} end
  end
  load(s1, 0.5, {["cadmium-red"]=1.2,["cadmium-orange"]=0.3,["burnt-sienna"]=0.4})
  s1:stroke(pts,{pressure=0.4,duration=0.04})
end
for k=1,4 do wait(1) end
local rl = brush{name="railP", width=2}
local pts={}
for x=231,360,4 do pts[#pts+1]={x+ox,sheer(x)+0.6} end
load(rl, 0.4, {["buff-titanium"]=2.0,["naples-yellow"]=0.6,["quinacridone-rose"]=0.05})
rl:stroke(pts,{pressure=0.5})
-- redraw mast foot over rail
local m = brush{name="bmast3", width=3}
load(m, 0.4, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
m:stroke({{368,601},{371,575}},{pressure=0.6,duration=0.03})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(133)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function bar(name, xa, xb, ytop, depth, c, w, rise)
  local b = brush{name=name, width=w}
  local function top(x) local u=(x-xa)/(xb-xa); return ytop - rise*math.sin(u*math.pi) + 1.5*math.sin(x/23) end
  local step = w*0.55
  local rows = math.ceil(depth/step)
  for r=0,rows do
    local x=xa+ r*3
    local fade = 1 - r/(rows+1)
    local L = w*2
    while x < xb - r*4 do
      load(b, 0.1*w, {["burnt-sienna"]=0.03*c*fade,["french-ultramarine"]=0.028*c*fade,["raw-umber"]=0.015*c*fade})
      b:stroke({{x,top(x)+w*0.4+r*step},{x+L,top(x+L)+w*0.4+r*step}},{pressure=0.5,duration=0.003})
      x=x+L
    end
  end
end
-- left midground (distance -> near)
bar("lb1", -10, 200, 418, 8, 0.7, 6, 2)
bar("lb2", 120, 400, 436, 10, 0.75, 7, 3)
bar("lb3", -10, 260, 470, 16, 0.85, 9, 5)
bar("lb4", 200, 470, 500, 18, 0.9, 10, 6)
bar("lb5", -10, 330, 528, 24, 1.0, 12, 7)
-- right midground
bar("rb1", 640, 860, 412, 8, 0.7, 6, 2)
bar("rb2", 760, 1060, 446, 12, 0.8, 8, 4)
bar("rb3", 620, 860, 480, 14, 0.85, 9, 4)
bar("rb4", 900, 1066, 520, 18, 0.95, 11, 6)
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(141)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function top(x)
  if x<590 then return 380 end
  local y
  if x<820 then local u=(x-590)/230; y = 378 - 50*(u*u*(3-2*u))
  else y = 328 - 6*math.sin((x-820)/60) - (x-820)*0.03 end
  return y
end
local g = brush{name="hmid", width=14}
local x=650
while x<1070 do
  local y0 = top(x)+30
  if y0 < 376 then
    load(g, 1.3, {["french-ultramarine"]=0.035,["quinacridone-rose"]=0.012,["burnt-sienna"]=0.012})
    local y1 = top(x+28)+30
    g:stroke({{x,math.min(y0,372)},{x+28,math.min(y1,372)}},{pressure=0.5,duration=0.003})
    if y0 < 362 then
      g:stroke({{x+28,math.min(y1+9,376)},{x,math.min(y0+9,376)}},{pressure=0.5,duration=0.003})
    end
  end
  x=x+28
end
-- a few taller tree tops breaking the line
local t = brush{name="talltree", width=8}
for _,tx in ipairs({712, 768, 905, 990, 1032}) do
  local yt = top(tx) + 2
  local h = 10+math.random()*8
  load(t, 0.5, {["french-ultramarine"]=0.09,["burnt-sienna"]=0.04,["quinacridone-rose"]=0.014,["raw-umber"]=0.012})
  t:stroke({{tx,yt-h,0.25},{tx+1,yt-h*0.5,0.55},{tx+1,yt+6,0.6}},{duration=0.008})
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(141)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function top(x)
  local u=(x-590)/230
  if x<820 then return 378 - 50*(u*u*(3-2*u)) end
  return 328 - 6*math.sin((x-820)/60) - (x-820)*0.03
end
-- crowns: round dabs over the stubs, darker, to make them read as tree crowns
local t = brush{name="crownD", width=9}
for _,tx in ipairs({712, 768, 905, 990, 1032}) do
  local yt = top(tx)
  for j=1,3 do
    load(t, 0.4, {["french-ultramarine"]=0.18,["burnt-sienna"]=0.07,["quinacridone-rose"]=0.025,["raw-umber"]=0.02})
    t:stroke({{tx+math.random()*4-2, yt-6-j*3}},{pressure=0.25+0.15*math.random()})
  end
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function top(x)
  local u=(x-590)/230
  if x<820 then return 378 - 50*(u*u*(3-2*u)) end
  return 328 - 6*math.sin((x-820)/60) - (x-820)*0.03
end
local t = brush{name="crownE", width=7}
local hs = {16,13,15,17,12}
for i,tx in ipairs({712, 768, 905, 990, 1032}) do
  local yt = top(tx)
  load(t, 0.4, {["french-ultramarine"]=0.25,["burnt-sienna"]=0.1,["quinacridone-rose"]=0.03,["raw-umber"]=0.03})
  t:stroke({{tx,yt-hs[i]+2,0.3},{tx+1,yt-hs[i]*0.5,0.6},{tx+1,yt+4,0.6}},{duration=0.02})
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(151)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local K = {{490,560,55},{560,700,85},{630,785,128},{710,790,195}}
local function chan(y)
  for i=1,#K-1 do
    if y<=K[i+1][1] then
      local u=(y-K[i][1])/(K[i+1][1]-K[i][1]); u=u*u*(3-2*u)
      return K[i][2]+(K[i+1][2]-K[i][2])*u, K[i][3]+(K[i+1][3]-K[i][3])*u
    end
  end
  return K[#K][2],K[#K][3]
end
local rp = brush{name="ripP", width=2}
local n=0
for i=1,40 do
  local y = 560+ (math.random()^0.7)*140
  local cx,hw = chan(y)
  local s = (y-540)/160
  local x = cx-hw*0.75 + math.random()*hw*1.5
  local L = (6+math.random()*18)*(0.6+s)
  load(rp, 0.2, {["french-ultramarine"]=1.3,["quinacridone-rose"]=0.3,["burnt-umber"]=0.25})
  rp:stroke({{x,y,0.12},{x+L*0.5,y+0.3,0.3+0.25*s},{x+L,y,0.08}},{duration=0.01})
  n=n+1
end
print(n, clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(161)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function tuft(gb, cx, cy, n, H, col, load_)
  for i=1,n do
    local a = (math.random()-0.5)*1.1 + 0.12
    local h = H*(0.45+0.65*math.random())
    local bx = cx + (math.random()-0.5)*H*0.45
    local tx = bx + math.sin(a)*h; local ty = cy - math.cos(a)*h
    local mx = bx + math.sin(a)*h*0.45 + a*h*0.12
    load(gb, load_, col)
    gb:stroke({{bx,cy,0.8},{mx,cy-h*0.5,0.55},{tx,ty,0.1}},{duration=0.03})
  end
end
local dark = {["burnt-umber"]=2.4,["french-ultramarine"]=1.6,["sap-green"]=0.6}
local lit  = {["raw-sienna"]=1.6,["naples-yellow"]=1.6,["burnt-sienna"]=0.5,["buff-titanium"]=0.6}
local g1 = brush{name="grassD", width=3}
local g2 = brush{name="grassL", width=2}
local clumps = {
  {40,712,28,95},{120,712,22,80},{190,714,14,55},{255,712,10,40},{10,690,10,60},
  {565,712,10,38},{1040,712,14,60},{985,714,8,35}
}
for _,c in ipairs(clumps) do
  tuft(g1, c[1], c[2], c[3], c[4], dark, 0.4)
  tuft(g2, c[1]+4, c[2], math.floor(c[3]*0.7), c[4]*0.9, lit, 0.3)
end
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(171)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local K = {{560,700,85},{630,785,128},{710,790,195}}
local function chanL(y)
  for i=1,#K-1 do
    if y<=K[i+1][1] then
      local u=(y-K[i][1])/(K[i+1][1]-K[i][1]); u=u*u*(3-2*u)
      return (K[i][2]+(K[i+1][2]-K[i][2])*u) - (K[i][3]+(K[i+1][3]-K[i][3])*u)
    end
  end
  return K[#K][2]-K[#K][3]
end
for x=40,520,95 do drop{x=x,y=684,water=6,radius=55} end
for x=40,420,95 do drop{x=x,y=650,water=4,radius=45} end
local i=0
for y=640,716,15 do
  i=i+1
  local b = brush{name="fgw"..i, width=32}
  local sgr=math.min(1,(y-630)/70)
  local xe = chanL(y)-30
  local x=-20
  while x<xe do
    local L=math.min(38,xe-x)
    local edge = 1+0.5*math.exp(-(x/220)^2)
    load(b, 2.0, {["burnt-umber"]=0.055*sgr*edge,["french-ultramarine"]=0.045*sgr*edge,["alizarin-crimson"]=0.007*sgr})
    b:stroke({{x,y+math.random()*8-4},{x+L,y+math.random()*8-4}},{pressure=0.55,duration=0.004})
    x=x+L
  end
end
print(clock())
for k=1,10 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 70; local oy = 108
local L=130
local function sheer(x) local u=(x-230)/L; return oy+474 + 30*u - 22*u*u end
local function bottom(x)
  local u=(x-230)/L
  local yk = oy+514 - 6*u*u
  if u < 0.25 then local v=u/0.25; return (oy+474) + (yk-(oy+474))*math.sqrt(1-(1-v)^2) end
  return yk
end
local s1 = brush{name="restrake", width=4}
for r=0,0.5,0.1 do
  local pts={}
  for x=232,358,3 do
    local yt=sheer(x)+2; local yb=bottom(x)
    if yb>yt then pts[#pts+1]={x+ox, yt+(yb-yt)*r} end
  end
  local c = 1.8*(1-0.5*r)
  load(s1, 0.5, {["cadmium-red"]=1.2*c,["cadmium-orange"]=0.3*c,["burnt-sienna"]=0.2*c})
  s1:stroke(pts,{pressure=0.4,duration=0.04})
end
for k=1,4 do wait(1) end
local rl = brush{name="rerail", width=2}
local pts={}
for x=231,360,4 do pts[#pts+1]={x+ox,sheer(x)+0.6} end
load(rl, 0.4, {["buff-titanium"]=2.2,["naples-yellow"]=0.7,["quinacridone-rose"]=0.05})
rl:stroke(pts,{pressure=0.5})
-- interior sliver again (opaque light) so the boat reads as open boat
local inn = brush{name="reinner", width=3}
for x=240,350,3 do
  local uu=(x-230)/L
  local h = 6*math.sin(math.min(1,(uu-0.06)/0.86)*math.pi)
  if h>1.2 then
    load(inn, 0.3, {["naples-yellow"]=1.2,["yellow-ochre"]=0.8,["buff-titanium"]=0.6,["burnt-sienna"]=0.2})
    inn:stroke({{x+ox,sheer(x)-h},{x+ox,sheer(x)-0.5}},{pressure=0.4,duration=0.01})
  end
end
for k=1,4 do wait(1) end
local fg = brush{name="refargun", width=2}
local p2={}
for x=236,356,4 do
  local uu=(x-230)/L
  local h = 6*math.sin(math.min(1,math.max(0,(uu-0.06)/0.86))*math.pi)
  p2[#p2+1]={x+ox, sheer(x)-h}
end
load(fg, 0.3, {["burnt-umber"]=1.4,["french-ultramarine"]=0.8,["alizarin-crimson"]=0.3})
fg:stroke(p2,{pressure=0.45})
local m = brush{name="remast", width=3}
load(m, 0.4, {["burnt-umber"]=1.3,["french-ultramarine"]=0.9})
m:stroke({{368,601},{371,575}},{pressure=0.6,duration=0.03})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 70; local oy = 108
local L=130
local function sheer(x) local u=(x-230)/L; return oy+474 + 30*u - 22*u*u end
local function h(x) local uu=(x-230)/L; return 6*math.sin(math.min(1,math.max(0,(uu-0.06)/0.86))*math.pi) end
local b = brush{name="intshade", width=3}
for _,f in ipairs({0.35, 0.7}) do
  local pts={}
  for x=240,350,4 do if h(x)>1.5 then pts[#pts+1]={x+ox, sheer(x)-h(x)*f} end end
  load(b, 0.4, {["burnt-umber"]=0.9,["raw-sienna"]=0.5,["french-ultramarine"]=0.25,["alizarin-crimson"]=0.1})
  b:stroke(pts,{pressure=0.45,duration=0.03})
end
print(clock())
for k=1,6 do wait(1) end print(balance().dry)



math.randomseed(181)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local d = brush{name="samph", width=5}
local x=0
while x<580 do
  if not (x>292 and x<436) then
    local y = 552 + math.random()*14 + (x>440 and 6 or 0)
    local warm = math.random()
    load(d, 0.3, {["burnt-sienna"]=0.5+0.4*warm,["alizarin-crimson"]=0.15+0.2*warm,["raw-sienna"]=0.3*(1-warm)})
    d:stroke({{x,y,0.3},{x+1,y-3-math.random()*4,0.2}},{duration=0.01})
  end
  x = x + 5 + math.random()*9
end
print(clock())
for k=1,6 do wait(1) end print(balance().dry)



math.randomseed(191)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function tuft(gb, cx, cy, n, H, col, load_)
  for i=1,n do
    local a = (math.random()-0.5)*1.1 + 0.15
    local h = H*(0.45+0.65*math.random())
    local bx = cx + (math.random()-0.5)*H*0.45
    local tx = bx + math.sin(a)*h; local ty = cy - math.cos(a)*h
    local mx = bx + math.sin(a)*h*0.45 + a*h*0.12
    load(gb, load_, col)
    gb:stroke({{bx,cy,0.8},{mx,cy-h*0.5,0.55},{tx,ty,0.1}},{duration=0.03})
  end
end
local lit  = {["naples-yellow"]=2.0,["raw-sienna"]=1.0,["buff-titanium"]=1.0,["burnt-sienna"]=0.3}
local lit2 = {["naples-yellow"]=1.4,["yellow-ochre"]=1.2,["buff-titanium"]=0.6,["quinacridone-rose"]=0.1}
local dark = {["burnt-umber"]=2.4,["french-ultramarine"]=1.8,["sap-green"]=0.5}
local g2 = brush{name="litgrass", width=2}
local g3 = brush{name="litgrass3", width=2.6}
local g1 = brush{name="darkgrass2", width=3}
local clumps = {
  {40,712,26,105},{125,712,20,85},{195,714,12,60},{262,712,9,42},{8,700,10,70},{570,712,8,36},{1040,712,12,62},{990,714,6,34}
}
for _,c in ipairs(clumps) do
  tuft(g3, c[1], c[2], math.floor(c[3]*0.5), c[4], lit, 0.35)
  tuft(g2, c[1]+5, c[2], math.floor(c[3]*0.6), c[4]*0.85, lit2, 0.3)
end
for _,c in ipairs({{1040,712,12,62},{990,714,6,34}}) do tuft(g1, c[1]-4, c[2], c[3], c[4], dark, 0.4) end
print(clock())
for k=1,6 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local g = brush{name="gullP", width=2.4}
local function gull(x,y,s,tilt)
  load(g, 0.2, {["paynes-gray"]=2.0,["burnt-umber"]=0.8})
  g:stroke({{x-7*s,y-1*s+tilt,0.1},{x-3.5*s,y-3*s+tilt*0.5,0.45},{x,y,0.6}},{duration=0.01})
  load(g, 0.2, {["paynes-gray"]=2.0,["burnt-umber"]=0.8})
  g:stroke({{x,y,0.6},{x+3.5*s,y-3.2*s-tilt*0.5,0.45},{x+7.5*s,y-0.8*s-tilt,0.1}},{duration=0.01})
end
gull(452,292,1.5,0.5); gull(486,306,1.1,-1); gull(424,312,0.9,1)
-- signature: small "C" lower right on the mud
local s = brush{name="sig", width=1.8}
load(s, 0.2, {["sepia"]=1.6,["french-ultramarine"]=0.5})
s:stroke({{968,684},{963,681},{958,683},{957,688},{960,692},{966,692}},{pressure=0.5,duration=0.03})
print(clock())
for k=1,6 do wait(1) end print(balance().dry)
