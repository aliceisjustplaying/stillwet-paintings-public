paper{width=1056,height=704,kind="cold-press",seed=4127}

math.randomseed(11)
local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
local function seg_row(b, y, x0, x1, seglen, water, pigs, dur, jit)
  local x=x0 - math.random()*seglen
  while x < x1 do
    topup(b, water, pigs)
    local L = seglen*(0.7+0.6*math.random())
    local dy = (math.random()-0.5)*(jit or 0)
    b:stroke({{x,y+dy},{x+L+10,y-dy}}, {pressure=0.5, duration=dur})
    x = x + L
  end
end
for gx=0,9 do for gy=0,3 do drop{x=math.min(1055, gx*118+math.random()*20), y=math.min(703, gy*100+math.random()*20), water=22, radius=85} end end
print(balance().max_surface_water)
local t0=clock()
local bl=brush{name="bl", width=60}
for y=0,120,40 do seg_row(bl, y, -10, 1066, 70, 6, {["cerulean-blue"]=0.09, ["french-ultramarine"]=0.07}, 0.03, 14) end
local gl=brush{name="gl", width=60}
for y=230,330,40 do seg_row(gl, y, -10, 1066, 70, 6, {["naples-yellow"]=0.07, ["quinacridone-rose"]=0.02}, 0.03, 14) end
print("laid", clock()-t0, balance().max_surface_water)
local cl=brush{name="cl", width=40}
local clouds={{{80,170},{260,150},{420,165}}, {{560,120},{760,105},{950,125}}, {{300,230},{480,215},{620,225}}}
for _,c in ipairs(clouds) do
  topup(cl, 10, {["french-ultramarine"]=0.08, ["burnt-sienna"]=0.05, ["quinacridone-rose"]=0.02})
  cl:stroke(c, {pressure=0.4, duration=0.15})
end
print("clouds", clock()-t0, balance().max_surface_water)
for i=1,40 do local t=wait(0.5); local s=balance(); if i%4==0 then print(t, s.max_surface_water, s.max_wetness, s.dry) end end