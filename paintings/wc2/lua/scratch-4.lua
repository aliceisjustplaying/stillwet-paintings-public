paper{width=1056,height=704,kind="cold-press",seed=3117}


local t0=clock()
for y=30,330,90 do for x=40,1056,118 do drop{x=x,y=y,water=10,radius=85} end end
local function mix(t)
  local p = {}
  local u = 0.022*(1-t)^1.4
  if u>0.0005 then p["french-ultramarine"]=u end
  local r = 0.005*math.exp(-((t-0.6)/0.25)^2)
  if r>0.0003 then p["quinacridone-rose"]=r end
  local s = 0.012*math.max(0,(t-0.45)/0.55)
  if s>0.0003 then p["raw-sienna"]=s end
  if t<0.5 then p["burnt-sienna"]=0.002 end
  return p
end
local i=0
for y=10,345,40 do
  i=i+1
  local t=(y-10)/335
  local b = brush{name="row"..i, width=70}
  local m = mix(t)
  local dir = (i%2==1) and 1 or -1
  for k=0,17 do
    local s=b:status(); local need = 5 - (s.water or 0)
    if need>0 then local pg={} for kk,v in pairs(m) do pg[kk]=v*need end b:load{water=need,pigments=pg} end
    local x = dir==1 and (-20+k*62) or (1076-k*62)
    b:stroke({{x,y+3*math.sin(k+i)},{x+62*dir,y+3*math.sin(k+1+i)}},{pressure=0.65,duration=0.012})
  end
end
print(clock()-t0)
for i=1,10 do wait(0.5); local s=balance(); print(clock()-t0, s.max_surface_water, s.dry) end
