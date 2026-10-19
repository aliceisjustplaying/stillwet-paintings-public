paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(4)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local u = brush{name="lav", width=40}
for y=500,700,20 do for x=600,1000,40 do
  load(u,3.2,{["french-ultramarine"]=0.028,["quinacridone-rose"]=0.007,["burnt-sienna"]=0.003})
  u:stroke({{x,y},{x+40,y}},{pressure=0.6,duration=0.005})
end end
for k=1,8 do wait(1) end
-- bank reflection: soft band along the left edge
local r = brush{name="bankrefl", width=16}
load(r, 1.6, {["burnt-umber"]=0.08,["french-ultramarine"]=0.08,["alizarin-crimson"]=0.01})
r:stroke({{640,520},{650,580},{670,640},{690,700}},{pressure=0.5,duration=0.05})
-- ripple lines stronger
local rp = brush{name="rip", width=3}
for i,c in ipairs({1.8,2.5}) do
  local y=540+i*50
  load(rp, 0.3, {["french-ultramarine"]=c,["quinacridone-rose"]=c*0.25,["burnt-umber"]=c*0.2})
  rp:stroke({{720,y,0.1},{760,y+0.3,0.55},{840,y,0.5},{880,y+0.4,0.08}},{duration=0.02})
end
-- lighter glint lifted? cannot lift dry; try opaque pale
local gl = brush{name="glint", width=3}
load(gl, 0.4, {["buff-titanium"]=1.5,["naples-yellow"]=0.5})
gl:stroke({{760,660,0.1},{800,660.3,0.5},{860,660,0.06}},{duration=0.02})
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(5)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- soft band: first clean water band wider, then pigment into it
local w = brush{name="wet", width=30}
local path = {{900,500},{910,560},{930,620},{950,690}}
w:load{water=6}
w:stroke({{915,500},{925,560},{945,620},{965,690}},{pressure=0.6,duration=0.03})
local r = brush{name="bankrefl2", width=14}
load(r, 1.6, {["burnt-umber"]=0.08,["french-ultramarine"]=0.08,["alizarin-crimson"]=0.01})
r:stroke(path,{pressure=0.5,duration=0.03})
-- short broken ripples
local rp = brush{name="rip2", width=2}
for i=1,10 do
  local x=700+math.random()*150; local y=600+math.random()*90
  local L=8+math.random()*20
  load(rp, 0.2, {["french-ultramarine"]=1.5,["quinacridone-rose"]=0.35,["burnt-umber"]=0.3})
  rp:stroke({{x,y,0.15},{x+L*0.5,y+0.3,0.5},{x+L,y,0.1}},{duration=0.01})
end
for k=1,8 do wait(1) end print(balance().dry)
