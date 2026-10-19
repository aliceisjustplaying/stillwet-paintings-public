--@ watercolor-engine 2

paper{width=1180,height=700,kind="cold-press",seed=2013}


local s = brush{name="g", width=44}
local mx = {["paynes-gray"]=0.012, ["terre-verte"]=0.03, ["sap-green"]=0.02, ["cobalt-blue"]=0.008}
local function top(b, mx, target, f)
  local need = target - b:status().water
  if need > 0 then local p={} for k,v in pairs(mx) do p[k]=v*need*(f or 1) end; b:load{water=need, pigments=p} end
end
for y=40,300,26 do for x=20,700,30 do top(s,mx,3); s:stroke({{x,y},{x+34,y}},{pressure=0.5,duration=0.03}) end end
wait(15)
local recipes = {
 {["buff-titanium"]=0.03, ["cerulean-blue"]=0.01},
 {["buff-titanium"]=0.06, ["cerulean-blue"]=0.02},
 {["buff-titanium"]=0.12, ["cerulean-blue"]=0.03, ["cobalt-blue"]=0.01},
 {["cerulean-blue"]=0.04, ["naples-yellow"]=0.02},
}
for i,r in ipairs(recipes) do
  local b = brush{name="h"..i, width=40}
  local x0 = 20 + (i-1)*170
  for y=60,260,28 do for x=x0, x0+120, 30 do top(b, r, 3); b:stroke({{x,y},{x+34,y}},{pressure=0.5,duration=0.03}) end end
end
wait(15)
