paper{width=1056,height=704,kind="cold-press",seed=4127}

local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
local function steady(b, path, step, water, pigs, opt)
  opt = opt or {}
  local speed = opt.speed or 1500
  for i=1,#path-1 do
    local a,c = path[i], path[i+1]
    local dx,dy = c[1]-a[1], c[2]-a[2]
    local L = math.sqrt(dx*dx+dy*dy)
    local n = math.max(1, math.floor(L/step+0.5))
    local pa, pc = a[3] or 0.5, c[3] or 0.5
    for k=0,n-1 do
      topup(b, water, pigs)
      b:stroke({{a[1]+dx*k/n, a[2]+dy*k/n, pa+(pc-pa)*k/n},{a[1]+dx*(k+1)/n, a[2]+dy*(k+1)/n, pa+(pc-pa)*(k+1)/n}}, {duration=math.max(0.005, (L/n)/speed)})
    end
  end
end
local u=brush{name="u1", width=80}
for y=40,300,40 do steady(u, {{-20,y},{1076,y}}, 25, 6, {["naples-yellow"]=0.015, ["pyrrol-scarlet"]=0.02}, {speed=3500}) end
local u2=brush{name="u2", width=80}
for y=380,680,40 do steady(u2, {{-20,y},{1076,y}}, 25, 6, {["quinacridone-rose"]=0.015, ["french-ultramarine"]=0.035, ["cerulean-blue"]=0.03}, {speed=3500}) end
wait(12)
print(balance().dry)
local mixes={
 {["raw-umber"]=0.08, ["burnt-sienna"]=0.03, ["french-ultramarine"]=0.05},
 {["raw-umber"]=0.05, ["burnt-sienna"]=0.05, ["french-ultramarine"]=0.03, ["quinacridone-rose"]=0.01},
 {["burnt-umber"]=0.06, ["french-ultramarine"]=0.07, ["quinacridone-rose"]=0.015},
 {["raw-umber"]=0.03, ["french-ultramarine"]=0.025, ["quinacridone-rose"]=0.015},
}
for i,m in ipairs(mixes) do
  local b=brush{name="mud"..i, width=50}
  for y=100,240,20 do steady(b, {{20+(i-1)*260, y},{230+(i-1)*260, y}}, 25, 5, m, {speed=5000}) end
  local b2=brush{name="mudb"..i, width=50}
  for y=440,580,20 do steady(b2, {{20+(i-1)*260, y},{230+(i-1)*260, y}}, 25, 5, m, {speed=5000}) end
end
wait(12)