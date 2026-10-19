paper{width=1056,height=704,kind="cold-press",seed=3117}


local u = brush{name="under", width=50}
for y=440,600,28 do for x=150,500,60 do
  local need = 3-(u:status().water or 0)
  if need>0 then u:load{water=need, pigments={["burnt-sienna"]=0.04*need,["french-ultramarine"]=0.03*need,["raw-umber"]=0.02*need}} end
  u:stroke({{x,y},{x+60,y}},{pressure=0.55,duration=0.008})
end end
for k=1,10 do wait(1) end
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 0; local oy = 0
local function sheer(x) local u=(x-232)/124; return oy+480 + 22*u - 14*u*u end
local function bottom(x)
  local u=(x-232)/124
  if u < 0.2 then local v=u/0.2; return oy+480 + 36*(1-(1-v)^2) end
  return oy + 516 + 0.5*u
end
local sh = brush{name="shadow4", width=9}
for x=240,382,9 do
  load(sh, 0.9, {["french-ultramarine"]=0.5,["burnt-umber"]=0.45,["alizarin-crimson"]=0.05})
  local yb = oy+517 + (x-246)*0.02
  sh:stroke({{x+ox,yb},{x+ox+10,yb+0.5}},{pressure=0.55,duration=0.01})
end
local hb = brush{name="hull4", width=4}
for x=233,356,2.5 do
  local uu=(x-232)/124
  load(hb, 0.5, {["burnt-umber"]=0.5,["alizarin-crimson"]=0.25,["burnt-sienna"]=0.25,["french-ultramarine"]=0.1+0.2*uu})
  local yt = sheer(x)+3.5
  local yb = bottom(x)
  if yb > yt+1 then hb:stroke({{x+ox,yt},{x+ox,yb}},{pressure=0.45,duration=0.01}) end
end
local tb = brush{name="strake4", width=3}
local pts={}
load(tb, 0.6, {["pyrrol-scarlet"]=0.3,["burnt-sienna"]=0.4,["quinacridone-burnt-orange"]=0.2})
for x=234,356,4 do pts[#pts+1]={x+ox,sheer(x)+1.5} end
tb:stroke(pts,{pressure=0.55})
for k=1,6 do wait(1) end
local m = brush{name="mast4", width=3}
load(m, 0.5, {["burnt-umber"]=0.9,["french-ultramarine"]=0.6})
m:stroke({{298+ox,oy+492},{307+ox,oy+440},{316+ox,oy+385}},{pressure=0.6,duration=0.1})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 0; local oy = 90
local L=130
local function sheer(x) local u=(x-230)/L; return oy+474 + 30*u - 22*u*u end
local function bottom(x)
  local u=(x-230)/L
  local yk = oy+514 - 6*u*u
  if u < 0.25 then local v=u/0.25; return (oy+474) + (yk-(oy+474))*math.sqrt(1-(1-v)^2) end
  return yk
end
local sh = brush{name="shadow5", width=8}
for x=244,385,8 do
  load(sh, 0.9, {["french-ultramarine"]=0.6,["burnt-umber"]=0.55,["alizarin-crimson"]=0.05})
  local yb = oy+514 + (x-244)*0.0
  sh:stroke({{x+ox,yb},{x+ox+9,yb+0.5}},{pressure=0.5,duration=0.01})
end
-- hull: horizontal rows
local hb = brush{name="hull5", width=4}
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
local tb = brush{name="strake5", width=3}
local pts={}
load(tb, 0.6, {["pyrrol-scarlet"]=0.6,["burnt-sienna"]=0.6,["quinacridone-burnt-orange"]=0.4})
for x=231,360,4 do pts[#pts+1]={x+ox,sheer(x)+1.2} end
tb:stroke(pts,{pressure=0.5})
-- transom
local tr = brush{name="transom5", width=3}
load(tr, 0.4, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
tr:stroke({{360+ox,sheer(360)},{361+ox,bottom(360)}},{pressure=0.5})
for k=1,6 do wait(1) end
local m = brush{name="mast5", width=3}
load(m, 0.5, {["burnt-umber"]=1.2,["french-ultramarine"]=0.8})
m:stroke({{298+ox,oy+492},{307+ox,oy+440},{316+ox,oy+380}},{pressure=0.65,duration=0.1})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)
