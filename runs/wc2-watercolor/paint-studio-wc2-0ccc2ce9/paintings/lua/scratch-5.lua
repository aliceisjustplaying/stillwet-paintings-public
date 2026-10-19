paper{width=1056,height=704,kind="cold-press",seed=3117}


local t0=clock()
for y=30,330,90 do for x=40,1056,118 do drop{x=x,y=y,water=10,radius=85} end end
local function mix(t)
  local p = {}
  local u = 0.032*(1-t)^1.3
  if u>0.0005 then p["french-ultramarine"]=u end
  local r = 0.008*math.exp(-((t-0.62)/0.22)^2)
  if r>0.0003 then p["quinacridone-rose"]=r end
  local s = 0.010*math.max(0,(t-0.5)/0.5)
  if s>0.0003 then p["quinacridone-burnt-orange"]=s*0.5; p["raw-sienna"]=s*0.6 end
  if t<0.5 then p["burnt-sienna"]=0.003 end
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
print("rows", clock()-t0)
-- clouds: gray-violet, less water, horizontal drifting lenses
local c = brush{name="cloud", width=40}
local clouds = {
  {{120,150},{260,140},{420,148},{520,160}},
  {{600,95},{760,85},{900,92},{1000,104}},
  {{300,215},{430,205},{560,212}},
  {{760,190},{880,182},{1060,188}},
  {{-10,60},{120,52},{260,62}},
}
for _,p in ipairs(clouds) do
  c:load{water=3, pigments={["french-ultramarine"]=0.10,["burnt-sienna"]=0.04,["quinacridone-rose"]=0.02}}
  c:stroke(p,{pressure=0.55,duration=0.1})
end
print("clouds", clock()-t0)
for i=1,10 do wait(0.5); local s=balance(); print(clock()-t0, s.max_surface_water, s.dry) end



local function rowband(name, y0, y1, x0, x1, m, target, w)
  local b = brush{name=name, width=w}
  local i=0
  for y=y0,y1,w*0.55 do
    i=i+1
    local dir = (i%2==1) and 1 or -1
    local n = math.ceil((x1-x0)/50)
    for k=0,n-1 do
      local s=b:status(); local need = target - (s.water or 0)
      if need>0 then local pg={} for kk,v in pairs(m) do pg[kk]=v*need end b:load{water=need,pigments=pg} end
      local xa = dir==1 and (x0+k*50) or (x1-k*50)
      b:stroke({{xa,y},{xa+50*dir,y+1}},{pressure=0.6,duration=0.01})
    end
  end
end
rowband("m1", 420, 520, 20, 330, {["burnt-sienna"]=0.03,["french-ultramarine"]=0.015}, 4, 50)
rowband("m2", 420, 520, 370, 680, {["raw-umber"]=0.03,["french-ultramarine"]=0.01,["burnt-sienna"]=0.01}, 4, 50)
rowband("m3", 420, 520, 720, 1040, {["burnt-umber"]=0.025,["cobalt-blue"]=0.012,["raw-sienna"]=0.01}, 4, 50)
-- darker stronger version below
rowband("m4", 560, 680, 20, 500, {["burnt-sienna"]=0.06,["french-ultramarine"]=0.035}, 4, 50)
rowband("m5", 560, 680, 540, 1040, {["sepia"]=0.03,["french-ultramarine"]=0.02,["burnt-sienna"]=0.02}, 4, 50)
print(clock())
wait(10) print(balance().dry)
