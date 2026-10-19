paper{width=1056,height=704,kind="cold-press",seed=3117}


math.randomseed(5)
local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local u = brush{name="under", width=30}
for y=500,700,16 do for x=0,700,40 do
  load(u,2.2,{["burnt-umber"]=0.09,["french-ultramarine"]=0.07,["burnt-sienna"]=0.04,["alizarin-crimson"]=0.005})
  u:stroke({{x,y},{x+40,y}},{pressure=0.55,duration=0.005})
end end
for k=1,10 do wait(1) end
local mixes = {
  {["buff-titanium"]=0.8,["cerulean-blue"]=0.1},
  {["buff-titanium"]=1.5,["cerulean-blue"]=0.2,["quinacridone-rose"]=0.03},
  {["buff-titanium"]=2.5,["naples-yellow"]=0.5,["cerulean-blue"]=0.2},
  {["cerulean-blue"]=1.0,["buff-titanium"]=1.0},
}
for i,m in ipairs(mixes) do
  local y = 500 + i*40
  local b = brush{name="sheen"..i, width=6}
  load(b, 0.6, m)
  b:stroke({{30,y,0.2},{100,y,0.6},{200,y+1,0.5},{260,y,0.1}},{duration=0.05})
  local d = brush{name="sheend"..i, width=10}
  d:load{water=0.6, pigments={}}
  for k,v in pairs(m) do d:load{water=0, pigments={[k]=v*0.6}} end
  d:stroke({{320,y,0.3},{480,y+1,0.6},{620,y,0.2}},{dry=true,duration=0.05})
end
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
local mixes = {
  {["buff-titanium"]=2.0,["french-ultramarine"]=0.12,["quinacridone-rose"]=0.06},
  {["buff-titanium"]=2.5,["naples-yellow"]=0.6,["quinacridone-rose"]=0.05},
  {["buff-titanium"]=1.2,["french-ultramarine"]=0.1,["quinacridone-rose"]=0.05},
}
for i,m in ipairs(mixes) do
  local y = 515 + i*40
  local b = brush{name="sh2"..i, width=5}
  load(b, 0.6, m)
  b:stroke({{30,y,0.15},{100,y,0.5},{200,y+1,0.45},{260,y,0.08}},{duration=0.05})
  local d = brush{name="sh2d"..i, width=12}
  load(d, 0.6, m)
  d:stroke({{320,y,0.3},{480,y+1,0.6},{620,y,0.2}},{dry=true,duration=0.05})
end
for k=1,8 do wait(1) end print(balance().dry)



local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- streak mix1 at y=555 (x30-260 wet, 320-620 dry)
local cs = {0.3, 0.6, 1.0}
for i,c in ipairs(cs) do
  local b = brush{name="kn"..i, width=10}
  load(b, 0.5, {["burnt-umber"]=0.5*c,["french-ultramarine"]=0.4*c,["burnt-sienna"]=0.15*c,["alizarin-crimson"]=0.05*c})
  local x0 = 20 + (i-1)*80
  b:stroke({{x0,555},{x0+75,555}},{pressure=0.5,duration=0.02})
  local d = brush{name="knd"..i, width=16}
  load(d, 0.5, {["burnt-umber"]=0.5*c,["french-ultramarine"]=0.4*c,["burnt-sienna"]=0.15*c,["alizarin-crimson"]=0.05*c})
  local x1 = 320 + (i-1)*100
  d:stroke({{x1,555},{x1+95,555}},{pressure=0.5,duration=0.02})
end
for k=1,8 do wait(1) end print(balance().dry)
