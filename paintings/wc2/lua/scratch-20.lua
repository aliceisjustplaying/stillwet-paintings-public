paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(21)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local u = brush{name="under", width=50}
for y=480,704,26 do for x=0,500,60 do
  load(u,3,{["burnt-sienna"]=0.05,["french-ultramarine"]=0.03,["burnt-umber"]=0.03})
  u:stroke({{x,y},{x+60,y}},{pressure=0.55,duration=0.008})
end end
for k=1,10 do wait(1) end
-- graded dark glaze at bottom
local g = brush{name="glz", width=40}
for y=650,720,22 do
  local s=(y-640)/70
  for x=-20,520,50 do
    load(g, 2.5, {["burnt-umber"]=0.05*s+0.02,["french-ultramarine"]=0.04*s+0.01,["alizarin-crimson"]=0.008})
    g:stroke({{x,y},{x+52,y+math.random()*4-2}},{pressure=0.55,duration=0.008})
  end
end
for k=1,6 do wait(1) end
-- grass tufts: fans of thin blades
local gb = brush{name="blade", width=2}
local function tuft(cx, cy, n, H, col)
  for i=1,n do
    local a = (math.random()-0.5)*1.1
    local h = H*(0.5+0.6*math.random())
    local bx = cx + (math.random()-0.5)*H*0.35
    local tx = bx + math.sin(a)*h; local ty = cy - math.cos(a)*h
    local mx = bx + math.sin(a)*h*0.5 + a*h*0.15
    load(gb, 0.15, col)
    gb:stroke({{bx,cy,0.7},{mx,cy-h*0.5,0.5},{tx,ty,0.1}},{duration=0.02})
  end
end
local c1 = {["burnt-umber"]=0.8,["french-ultramarine"]=0.4,["sap-green"]=0.4}
local c2 = {["raw-sienna"]=0.9,["burnt-sienna"]=0.5,["sap-green"]=0.3}
tuft(60,690,18,60,c1)
tuft(140,700,14,45,c2)
tuft(220,695,12,35,c1)
tuft(300,690,10,25,c2)
print(clock())
for k=1,8 do wait(1) end print(balance().dry)



math.randomseed(22)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local c1 = {["burnt-umber"]=0.8,["french-ultramarine"]=0.4,["sap-green"]=0.4}
for i,cfg in ipairs({{2,0.15,0.7},{2,0.4,0.7},{3,0.4,0.9},{3,0.8,0.9},{4,0.6,1.0}}) do
  local gb = brush{name="bl"..i, width=cfg[1]}
  local s0 = gb:status()
  gb:load{water=cfg[2], pigments={["burnt-umber"]=0.8*cfg[2]*1.5,["french-ultramarine"]=0.4*cfg[2]*1.5}}
  gb:stroke({{600+i*60,690,cfg[3]},{605+i*60,640,cfg[3]*0.7},{615+i*60,600,0.15}},{duration=0.05})
  gb:stroke({{600+i*60,300,cfg[3]},{605+i*60,250,cfg[3]*0.7},{615+i*60,210,0.15}},{duration=0.05})
  print(i, gb:status().water)
end
for k=1,6 do wait(1) end



math.randomseed(23)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local function tuft(gb, cx, cy, n, H, col)
  for i=1,n do
    local a = (math.random()-0.5)*1.0
    local h = H*(0.5+0.6*math.random())
    local bx = cx + (math.random()-0.5)*H*0.4
    local tx = bx + math.sin(a)*h; local ty = cy - math.cos(a)*h
    local mx = bx + math.sin(a)*h*0.45 + a*h*0.12
    load(gb, 0.4, col)
    gb:stroke({{bx,cy,0.8},{mx,cy-h*0.5,0.55},{tx,ty,0.1}},{duration=0.03})
  end
end
local gb = brush{name="blade3", width=3}
local c1 = {["burnt-umber"]=2.2,["french-ultramarine"]=1.2,["sap-green"]=1.0}
local c2 = {["raw-sienna"]=2.0,["burnt-sienna"]=1.4,["sap-green"]=0.6}
local c3 = {["yellow-ochre"]=1.5,["raw-sienna"]=1.0,["burnt-sienna"]=0.6}
tuft(gb,60,700,18,60,c1)
tuft(gb,70,700,10,50,c2)
tuft(gb,150,705,14,45,c2)
tuft(gb,160,705,6,40,c1)
tuft(gb,230,700,12,35,c3)
tuft(gb,300,700,10,25,c1)
print(clock())
for k=1,8 do wait(1) end print(balance().dry)
