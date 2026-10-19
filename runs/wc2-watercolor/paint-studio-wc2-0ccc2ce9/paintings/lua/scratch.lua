paper{width=1056,height=704,kind="cold-press",seed=3117}


local function load(b, target, m) local s=b:status(); local need=target-(s.water or 0)
  if need>0 then local pg={} for k,v in pairs(m) do pg[k]=v*need end b:load{water=need,pigments=pg} end end
-- dark maroon-brown underlayer like the glazed hull
local u = brush{name="under", width=30}
for y=560,640,14 do for x=250,520,40 do
  load(u,2.2,{["burnt-umber"]=0.14,["french-ultramarine"]=0.1,["alizarin-crimson"]=0.04,["burnt-sienna"]=0.04})
  u:stroke({{x,y},{x+40,y}},{pressure=0.55,duration=0.005})
end end
for k=1,10 do wait(1) end
-- red trial: three concentrations of cad red/orange
for i,c in ipairs({1.0, 1.8, 2.8}) do
  local b = brush{name="red"..i, width=4}
  for r=0,2 do
    load(b, 0.5, {["cadmium-red"]=1.2*c,["cadmium-orange"]=0.3*c,["burnt-sienna"]=0.2*c})
    b:stroke({{270+(i-1)*80,580+r*3},{335+(i-1)*80,580+r*3}},{pressure=0.4,duration=0.02})
  end
end
for k=1,6 do wait(1) end print(balance().dry)
