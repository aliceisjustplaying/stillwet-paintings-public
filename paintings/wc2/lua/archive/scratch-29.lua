paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(23)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local u = brush{name="under", width=30}
for y=520,704,16 do for x=0,500,40 do
  load(u,2.2,{["burnt-umber"]=0.09,["french-ultramarine"]=0.075,["burnt-sienna"]=0.04,["alizarin-crimson"]=0.005})
  u:stroke({{x,y},{x+40,y}},{pressure=0.55,duration=0.005})
end end
for k=1,10 do wait(1) end
local function tuft(gb, cx, cy, n, H, col, load_)
  for i=1,n do
    local a = (math.random()-0.5)*1.0 + 0.15
    local h = H*(0.5+0.6*math.random())
    local bx = cx + (math.random()-0.5)*H*0.4
    local tx = bx + math.sin(a)*h; local ty = cy - math.cos(a)*h
    local mx = bx + math.sin(a)*h*0.45 + a*h*0.12
    load(gb, load_, col)
    gb:stroke({{bx,cy,0.8},{mx,cy-h*0.5,0.55},{tx,ty,0.1}},{duration=0.03})
  end
end
local dark = {["burnt-umber"]=2.4,["french-ultramarine"]=1.6,["sap-green"]=0.6}
local lit  = {["raw-sienna"]=1.6,["naples-yellow"]=1.6,["burnt-sienna"]=0.5,["buff-titanium"]=0.6}
local g1 = brush{name="gd", width=3}
local g2 = brush{name="gl", width=2}
tuft(g1, 80, 700, 16, 70, dark, 0.4)
tuft(g2, 85, 700, 12, 60, lit, 0.3)
tuft(g1, 200, 704, 10, 45, dark, 0.4)
tuft(g2, 205, 704, 8, 40, lit, 0.3)
tuft(g2, 330, 704, 10, 50, lit, 0.3)
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(8)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- add stripes to simulate
local s = brush{name="stripes", width=10}
for y=600,700,22 do load(s,0.6,{["burnt-umber"]=0.4,["french-ultramarine"]=0.32}); s:stroke({{20,y},{180,y}},{pressure=0.5}) end
for k=1,6 do wait(1) end
for x=40,480,90 do drop{x=x,y=680,water=6,radius=55} end
local i=0
for y=650,712,16 do
  i=i+1
  local b = brush{name="wg"..i, width=34}
  local sgr=(y-640)/70
  for x=-20,500,40 do
    load(b, 2.0, {["burnt-umber"]=0.06*sgr,["french-ultramarine"]=0.05*sgr,["alizarin-crimson"]=0.008*sgr})
    b:stroke({{x,y+math.random()*6-3},{x+40,y+math.random()*6-3}},{pressure=0.55,duration=0.004})
  end
end
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local g = brush{name="gull", width=1.6}
local function gull(x,y,s,tilt)
  load(g, 0.15, {["paynes-gray"]=1.2,["burnt-umber"]=0.4})
  g:stroke({{x-7*s,y-2*s+tilt,0.15},{x-3.5*s,y-3*s+tilt*0.5,0.5},{x,y,0.6}},{duration=0.01})
  load(g, 0.15, {["paynes-gray"]=1.2,["burnt-umber"]=0.4})
  g:stroke({{x,y,0.6},{x+3.5*s,y-3.2*s-tilt*0.5,0.5},{x+7.5*s,y-1.5*s-tilt,0.15}},{duration=0.01})
end
gull(600,250,1.0,0); gull(630,262,0.8,1); gull(660,245,1.3,-1); gull(700,260,0.6,0)
for k=1,4 do wait(1) end



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local g = brush{name="gull2", width=2.4}
local function gull(x,y,s,tilt)
  load(g, 0.2, {["paynes-gray"]=2.0,["burnt-umber"]=0.8})
  g:stroke({{x-7*s,y-1*s+tilt,0.1},{x-3.5*s,y-3*s+tilt*0.5,0.45},{x,y,0.6}},{duration=0.01})
  load(g, 0.2, {["paynes-gray"]=2.0,["burnt-umber"]=0.8})
  g:stroke({{x,y,0.6},{x+3.5*s,y-3.2*s-tilt*0.5,0.45},{x+7.5*s,y-0.8*s-tilt,0.1}},{duration=0.01})
end
gull(600,300,1.6,0); gull(640,315,1.2,1); gull(680,295,2.0,-1); gull(720,310,1.0,0)
for k=1,4 do wait(1) end
