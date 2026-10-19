paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(4)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local u = brush{name="under", width=50}
for y=560,680,26 do for x=250,560,60 do
  load(u,3,{["burnt-sienna"]=0.05,["french-ultramarine"]=0.03,["burnt-umber"]=0.03})
  u:stroke({{x,y},{x+60,y}},{pressure=0.55,duration=0.008})
end end
for k=1,8 do wait(1) end
local sh = brush{name="sh", width=8}
load(sh, 1.2, {["french-ultramarine"]=0.55,["burnt-umber"]=0.5,["alizarin-crimson"]=0.06})
local pts={} for x=316,462,6 do local uu=(x-316)/146; pts[#pts+1]={x,622+2*math.sin(uu*math.pi),0.25+0.55*math.sin(uu*math.pi)^0.6} end
sh:stroke(pts,{duration=0.08})
local g = brush{name="shglaze", width=16}
local p2={}
for x=296,482,8 do local uu=(x-296)/186; p2[#p2+1]={x, 623+3*uu, 0.6*(1-uu)^0.7+0.12} end
load(g, 2.0, {["french-ultramarine"]=0.12,["burnt-umber"]=0.08,["alizarin-crimson"]=0.03})
g:stroke(p2,{duration=0.08})
for k=1,8 do wait(1) end
-- break with opaque mud-light dabs: two strengths
local o = brush{name="opq", width=5}
for i=1,14 do
  local x = 380+math.random()*100; local y=618+math.random()*16
  local strong = x>430
  load(o, 0.5, {["buff-titanium"]=strong and 0.9 or 0.5,["raw-sienna"]=0.15,["burnt-sienna"]=0.08})
  o:stroke({{x,y},{x+6+math.random()*10,y+math.random()*2-1}},{pressure=0.5,duration=0.01})
end
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(6)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local r = brush{name="rag", width=12}
for i=1,26 do
  local x = 290+math.random()*210; local y=616+math.random()*22
  local L = 10+math.random()*30
  local d = math.exp(-((x-380)/110)^2)
  load(r, 1.2, {["burnt-umber"]=0.10+0.12*d,["french-ultramarine"]=0.08+0.1*d,["burnt-sienna"]=0.05})
  r:stroke({{x,y,0.3+0.4*math.random()},{x+L,y+math.random()*4-2,0.2}},{duration=0.01})
end
for k=1,8 do wait(1) end print(balance().dry)
