paper{width=1056,height=704,kind="cold-press",seed=3117}


local u = brush{name="under", width=50}
for y=440,600,28 do for x=150,500,60 do
  local need = 3-(u:status().water or 0)
  if need>0 then u:load{water=need, pigments={["burnt-sienna"]=0.04*need,["french-ultramarine"]=0.035*need,["raw-umber"]=0.02*need}} end
  u:stroke({{x,y},{x+60,y}},{pressure=0.55,duration=0.008})
end end
for k=1,10 do wait(1) end
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local x0, x1 = 240, 352
local function cl(u) return math.max(0,math.min(1,u)) end
local function gun(x) local u=cl((x-x0)/(x1-x0)); return 499 + 6*u - 5*math.sin(u*math.pi) end
local function keel(x) local u=cl((x-x0)/(x1-x0)); return gun(x) + 2 + 20*math.sin(math.min(1,u*1.15)*math.pi*0.5)^0.8 end
local sh = brush{name="shadow", width=10}
for x=236,372,8 do
  load(sh, 1.0, {["french-ultramarine"]=0.10,["burnt-umber"]=0.08,["alizarin-crimson"]=0.01})
  local yb = keel(math.min(x,x1))+2
  sh:stroke({{x,yb},{x+9,yb+1}},{pressure=0.6,duration=0.01})
end
local inn = brush{name="inner", width=5}
for x=246,348,4 do
  local uu=cl((x-x0)/(x1-x0))
  local h = 1+9*math.sin(uu*math.pi)^0.7
  load(inn, 0.35, {["yellow-ochre"]=0.10,["raw-sienna"]=0.04,["burnt-sienna"]=0.02})
  inn:stroke({{x,gun(x)-h},{x,gun(x)-1}},{pressure=0.5,duration=0.01})
end
local hb = brush{name="hull", width=5}
for x=x0,x1,3 do
  load(hb, 0.4, {["indian-red"]=0.18,["alizarin-crimson"]=0.03,["burnt-umber"]=0.05})
  hb:stroke({{x,gun(x)+1},{x,keel(x)}},{pressure=0.5,duration=0.01})
end
print(clock())
for k=1,6 do wait(1) end
local dk = brush{name="dark", width=2}
load(dk, 0.3, {["burnt-umber"]=0.2,["french-ultramarine"]=0.15})
local pts={} for x=x0,x1,6 do pts[#pts+1]={x,gun(x)} end
dk:stroke(pts,{pressure=0.5})
local pts2={} for x=x0+8,x1,6 do pts2[#pts2+1]={x,keel(x)} end
load(dk, 0.3, {["burnt-umber"]=0.2,["french-ultramarine"]=0.15})
dk:stroke(pts2,{pressure=0.7})
load(dk, 0.2, {["burnt-umber"]=0.15,["french-ultramarine"]=0.1})
dk:stroke({{300,gun(300)-1},{303,gun(300)-8}},{pressure=0.6})
local m = brush{name="mast", width=3}
load(m, 0.4, {["burnt-umber"]=0.15,["french-ultramarine"]=0.08,["raw-sienna"]=0.05})
m:stroke({{300,500},{312,440},{324,380}},{pressure=0.5,duration=0.1})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 0; local oy = 60   -- test lower on the scratch
local function sheer(x) local u=(x-232)/124; return oy+488 + 14*u - 12*u*u + 0*u end -- bow high, falls, then rises slightly
local function sheer2(x) local u=(x-232)/124; return oy + 489 + 18*u - 14*u*u end
local function bottom(x)
  if x < 254 then return sheer2(232) + (x-232)/22*26 end
  return oy + 515 + (x-254)*0.01
end
-- shadow under hull
local sh = brush{name="shadow2", width=9}
for x=246,380,9 do
  load(sh, 0.9, {["french-ultramarine"]=0.35,["burnt-umber"]=0.30,["alizarin-crimson"]=0.03})
  local yb = oy+516 + (x-246)*0.02
  sh:stroke({{x,yb},{x+10,yb+0.5}},{pressure=0.55,duration=0.01})
end
-- hull fill
local hb = brush{name="hull2", width=4}
for x=233,356,2.5 do
  load(hb, 0.35, {["indian-red"]=0.55,["alizarin-crimson"]=0.10,["burnt-umber"]=0.20})
  local yt = sheer2(x)+1
  local yb = bottom(x)
  if yb > yt+1 then hb:stroke({{x,yt},{x,yb}},{pressure=0.45,duration=0.01}) end
end
for k=1,6 do wait(1) end
-- dark lower plank shade (wet on dry) along bottom third
local ds = brush{name="dshade", width=4}
for x=252,354,3 do
  load(ds, 0.3, {["burnt-umber"]=0.4,["french-ultramarine"]=0.3,["alizarin-crimson"]=0.05})
  local yb=bottom(x); ds:stroke({{x,yb-7},{x,yb}},{pressure=0.45,duration=0.01})
end
-- gunwale: pale rail line via opaque buff
local gl = brush{name="rail", width=2}
load(gl, 0.5, {["buff-titanium"]=0.9,["naples-yellow"]=0.3})
local pts={} for x=232,356,4 do pts[#pts+1]={x,sheer2(x)} end
gl:stroke(pts,{pressure=0.6})
-- mast
local m = brush{name="mast2", width=3}
load(m, 0.6, {["burnt-umber"]=0.4,["french-ultramarine"]=0.25,["raw-sienna"]=0.1})
m:stroke({{296,oy+497},{306,oy+440},{316,oy+385}},{pressure=0.55,duration=0.1})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local ox = 260; local oy = -10
local function sheer(x) local u=(x-232)/124; return oy+480 + 22*u - 14*u*u end
local function bottom(x)
  local u=(x-232)/124
  if u < 0.2 then local v=u/0.2; return oy+480 + 36*(1-(1-v)^2) end
  return oy + 516 + 0.5*u
end
local sh = brush{name="shadow3", width=9}
for x=240,382,9 do
  load(sh, 0.9, {["french-ultramarine"]=0.35,["burnt-umber"]=0.30,["alizarin-crimson"]=0.03})
  local yb = oy+517 + (x-246)*0.02
  sh:stroke({{x+ox,yb},{x+ox+10,yb+0.5}},{pressure=0.55,duration=0.01})
end
local hb = brush{name="hull3", width=4}
for x=233,356,2.5 do
  load(hb, 0.35, {["indian-red"]=0.5,["burnt-umber"]=0.35,["french-ultramarine"]=0.15})
  local yt = sheer(x)+3.5
  local yb = bottom(x)
  if yb > yt+1 then hb:stroke({{x+ox,yt},{x+ox,yb}},{pressure=0.45,duration=0.01}) end
end
local tb = brush{name="strake3", width=3}
for x=234,356,3 do
  load(tb, 0.25, {["indian-red"]=0.45,["cadmium-red"]=0.1,["burnt-sienna"]=0.1})
  local yt = sheer(x)
  tb:stroke({{x+ox,yt},{x+ox,yt+4}},{pressure=0.4,duration=0.01})
end
for k=1,6 do wait(1) end
local m = brush{name="mast3", width=3}
load(m, 0.5, {["burnt-umber"]=0.9,["french-ultramarine"]=0.6})
m:stroke({{298+ox,oy+492},{307+ox,oy+440},{316+ox,oy+385}},{pressure=0.7,duration=0.1})
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



local loads = {{1,0.3},{1,1},{1,3},{0.5,1},{0.5,3},{2,3},{2,8}}
for i,l in ipairs(loads) do
  local b = brush{name="cal"..i, width=6}
  b:load{water=l[1], pigments={["burnt-umber"]=l[2]*0.6, ["french-ultramarine"]=l[2]*0.4}}
  b:stroke({{40+i*60,560},{40+i*60,680}},{pressure=0.6})
  local s=b:status()
  print(i, l[1], l[2], s.water, s.pigments and (s.pigments["burnt-umber"] or 0))
end
for k=1,8 do wait(1) end print(balance().dry)
