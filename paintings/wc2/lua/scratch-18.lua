paper{width=1056,height=704,kind="cold-press",seed=3117}


local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- rebuild boat setup as on painting (mud underlayer + hull)
local u = brush{name="under", width=50}
for y=500,660,28 do for x=200,560,60 do
  load(u,3,{["burnt-sienna"]=0.04,["french-ultramarine"]=0.03,["raw-umber"]=0.02})
  u:stroke({{x,y},{x+60,y}},{pressure=0.55,duration=0.008})
end end
for k=1,10 do wait(1) end
local ox = 70; local oy = 108
local L=130
local function sheer(x) local u=(x-230)/L; return oy+474 + 30*u - 22*u*u end
local function bottom(x)
  local u=(x-230)/L
  local yk = oy+514 - 6*u*u
  if u < 0.25 then local v=u/0.25; return (oy+474) + (yk-(oy+474))*math.sqrt(1-(1-v)^2) end
  return yk
end
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
for k=1,8 do wait(1) end
-- NEW: interior sliver + far gunwale
local inn = brush{name="inner", width=3}
for x=238,352,3 do
  local uu=(x-230)/L
  local h = 7*math.sin(math.min(1,(uu-0.06)/0.86)*math.pi)
  if h>1 then
    load(inn, 0.3, {["yellow-ochre"]=0.5,["raw-sienna"]=0.3,["quinacridone-rose"]=0.05})
    inn:stroke({{x+ox,sheer(x)-h},{x+ox,sheer(x)}},{pressure=0.4,duration=0.01})
  end
end
for k=1,4 do wait(1) end
local fg = brush{name="fargun", width=2}
local pts={}
for x=236,356,4 do
  local uu=(x-230)/L
  local h = 7*math.sin(math.min(1,math.max(0,(uu-0.06)/0.86))*math.pi)
  pts[#pts+1]={x+ox, sheer(x)-h}
end
load(fg, 0.3, {["burnt-umber"]=0.9,["french-ultramarine"]=0.5,["alizarin-crimson"]=0.2})
fg:stroke(pts,{pressure=0.45})
-- thwart & seat
load(fg, 0.3, {["burnt-umber"]=0.9,["french-ultramarine"]=0.5})
fg:stroke({{318+ox, sheer(318)-1},{315+ox, sheer(318)-6.5}},{pressure=0.5})
-- forestay
local st = brush{name="stay", width=1}
load(st, 0.2, {["burnt-umber"]=0.6,["french-ultramarine"]=0.4})
st:stroke({{322+ox,oy+332},{262+ox,oy+420},{232+ox,sheer(232)}},{pressure=0.4,duration=0.1})
-- mooring rope from bow to mud
load(st, 0.2, {["burnt-umber"]=0.6,["french-ultramarine"]=0.4})
st:stroke({{232+ox,sheer(232)+4},{218+ox,oy+505},{200+ox,oy+514},{175+ox,oy+519}},{pressure=0.6,duration=0.1})
local m = brush{name="bmast", width=3}
load(m, 0.5, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
m:stroke({{298+ox,oy+492},{306+ox,oy+440},{316+ox,oy+370},{322+ox,oy+330}},{pressure=0.6,duration=0.12})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 70; local oy = 108
local L=130
local function sheer(x) local u=(x-230)/L; return oy+474 + 30*u - 22*u*u end
local inn = brush{name="inner2", width=3}
for x=238,352,3 do
  local uu=(x-230)/L
  local h = 7*math.sin(math.min(1,(uu-0.06)/0.86)*math.pi)
  if h>1 then
    load(inn, 0.3, {["yellow-ochre"]=1.2,["raw-sienna"]=0.6,["burnt-sienna"]=0.3,["naples-yellow"]=0.6})
    inn:stroke({{x+ox,sheer(x)-h},{x+ox,sheer(x)}},{pressure=0.4,duration=0.01})
  end
end
for k=1,4 do wait(1) end
local fg = brush{name="fargun2", width=2}
local pts={}
for x=236,356,4 do
  local uu=(x-230)/L
  local h = 7*math.sin(math.min(1,math.max(0,(uu-0.06)/0.86))*math.pi)
  pts[#pts+1]={x+ox, sheer(x)-h}
end
load(fg, 0.3, {["burnt-umber"]=1.4,["french-ultramarine"]=0.8,["alizarin-crimson"]=0.3})
fg:stroke(pts,{pressure=0.45})
local st = brush{name="stay2", width=1.5}
load(st, 0.2, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
st:stroke({{322+ox,oy+332},{262+ox,oy+420},{232+ox,sheer(232)}},{pressure=0.4,duration=0.1})
load(st, 0.2, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
st:stroke({{232+ox,sheer(232)+4},{218+ox,oy+505},{200+ox,oy+514},{175+ox,oy+519}},{pressure=0.6,duration=0.1})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)
