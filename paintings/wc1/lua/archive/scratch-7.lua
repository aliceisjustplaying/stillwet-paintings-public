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
for gx=0,9 do for gy=0,3 do drop{x=math.min(1055, gx*118+math.random()*20), y=math.min(300, gy*95+math.random()*20), water=8, radius=80} end end
print(balance().max_surface_water)
local t0=clock()
local bl=brush{name="bl", width=60}
for y=0,120,40 do seg_row(bl, y, -10, 1066, 70, 5, {["cerulean-blue"]=0.08, ["french-ultramarine"]=0.06}, 0.03, 14) end
local gl=brush{name="gl", width=60}
for y=230,320,40 do seg_row(gl, y, -10, 1066, 70, 5, {["naples-yellow"]=0.07, ["quinacridone-rose"]=0.02}, 0.03, 14) end
print("laid", clock()-t0, balance().max_surface_water)
local cl=brush{name="cl", width=40}
local clouds={{{80,170},{260,150},{420,165}}, {{560,120},{760,105},{950,125}}, {{300,230},{480,215},{620,225}}}
for _,c in ipairs(clouds) do
  topup(cl, 10, {["french-ultramarine"]=0.08, ["burnt-sienna"]=0.05, ["quinacridone-rose"]=0.02})
  cl:stroke(c, {pressure=0.4, duration=0.15})
end
print("clouds", clock()-t0, balance().max_surface_water)
for i=1,40 do local t=wait(0.5); local s=balance(); if i%4==0 then print(t, s.max_surface_water, s.max_wetness, s.dry) end end

math.randomseed(5)
local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
-- A: mud on dry paper, segments
local m=brush{name="mud", width=30}
local mud={["raw-umber"]=0.12, ["french-ultramarine"]=0.06, ["burnt-sienna"]=0.04}
for i=0,3 do
  local y=420+i*14
  local x=40
  while x<460 do topup(m, 4, mud); m:stroke({{x,y},{x+60,y+ (math.random()-0.5)*4}}, {pressure=0.45, duration=0.04}); x=x+50 end
end
-- B: mud into damp: drop water then mud
for gx=0,3 do drop{x=600+gx*100, y=450, water=6, radius=60} end
wait(0.3)
for i=0,3 do
  local y=420+i*14
  local x=560
  while x<960 do topup(m, 4, mud); m:stroke({{x,y},{x+60,y+ (math.random()-0.5)*4}}, {pressure=0.45, duration=0.04}); x=x+50 end
end
-- C: post: dark
local p=brush{name="post", width=10}
for i=0,4 do topup(p, 2, {["burnt-umber"]=0.15, ["french-ultramarine"]=0.12}); p:stroke({{100+i*60,560},{101+i*60,640}}, {pressure=0.5, duration=0.1}) end
-- D: dry brush mud texture
local d=brush{name="drybr", width=30}
d:load{water=3, pigments=mud}
d:stroke({{450,600},{700,605},{950,598}}, {dry=true, pressure=0.6})
wait(10); print(balance().dry)