paper{width=1056,height=704,kind="cold-press",seed=3117}


local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local u = brush{name="under", width=30}
for y=540,680,16 do for x=200,600,40 do
  load(u,2.2,{["burnt-umber"]=0.07,["french-ultramarine"]=0.055,["burnt-sienna"]=0.04,["alizarin-crimson"]=0.005})
  u:stroke({{x,y},{x+40,y}},{pressure=0.55,duration=0.005})
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
for k=1,8 do wait(1) end
-- trial: opaque upper strake (cad red + cad orange) on left half; buff rail line on top
local s1 = brush{name="cstrake", width=4}
for r=0,0.4,0.13 do
  local pts={}
  for x=232,358,3 do
    local yt=sheer(x)+2; local yb=bottom(x)
    if yb>yt then pts[#pts+1]={x+ox, yt+(yb-yt)*r} end
  end
  load(s1, 0.5, {["cadmium-red"]=1.4,["cadmium-orange"]=0.4,["burnt-sienna"]=0.2})
  s1:stroke(pts,{pressure=0.4,duration=0.04})
end
local rl = brush{name="rail", width=2}
local pts={}
for x=231,360,4 do pts[#pts+1]={x+ox,sheer(x)+0.6} end
load(rl, 0.4, {["buff-titanium"]=2.0,["naples-yellow"]=0.6,["quinacridone-rose"]=0.05})
rl:stroke(pts,{pressure=0.5})
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(3)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local u = brush{name="lav", width=40}
for y=200,330,20 do for x=600,1000,40 do
  load(u,3.2,{["french-ultramarine"]=0.026,["quinacridone-rose"]=0.007,["burnt-sienna"]=0.003})
  u:stroke({{x,y},{x+40,y}},{pressure=0.6,duration=0.005})
end end
for k=1,8 do wait(1) end
local rp = brush{name="ripple", width=2.5}
local y=215
local i=0
while y<325 do
  i=i+1
  local n = 2+math.floor(math.random()*2)
  for j=1,n do
    local x = 620+math.random()*340
    local L = 15+math.random()*40*(y/300)
    local c = 0.25+0.25*((i%3)/2)
    load(rp, 0.3, {["french-ultramarine"]=c,["quinacridone-rose"]=c*0.25,["burnt-umber"]=c*0.15})
    rp:stroke({{x,y,0.1},{x+L*0.3,y+0.3,0.5},{x+L*0.7,y,0.45},{x+L,y+0.4,0.08}},{duration=0.02})
  end
  y = y + 6 + (y-200)*0.08
end
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(4)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local rp = brush{name="ripple2", width=3}
for i,c in ipairs({0.6,0.9,1.3}) do
  local y = 220+i*30
  load(rp, 0.3, {["french-ultramarine"]=c,["quinacridone-rose"]=c*0.25,["burnt-umber"]=c*0.15})
  rp:stroke({{620,y,0.1},{640,y+0.3,0.5},{680,y,0.45},{700,y+0.4,0.08}},{duration=0.02})
  load(rp, 0.3, {["french-ultramarine"]=c,["quinacridone-rose"]=c*0.25,["burnt-umber"]=c*0.15})
  rp:stroke({{760,y,0.1},{790,y+0.3,0.6},{850,y,0.55},{880,y+0.4,0.08}},{duration=0.02})
end
for k=1,8 do wait(1) end print(balance().dry)
