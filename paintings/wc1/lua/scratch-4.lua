paper{width=1056,height=704,kind="cold-press",seed=4127}

local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
local function seg_row(b, y, x0, x1, seglen, water, pigs, dur, jit)
  local x=x0
  while x < x1 do
    topup(b, water, pigs)
    local dy = jit and (math.random()-0.5)*jit or 0
    b:stroke({{x,y+dy},{x+seglen+10,y-dy}}, {pressure=0.5, duration=dur})
    x = x + seglen
  end
end
math.randomseed(3)
local t0=clock()
local w=brush{name="wet", width=60}
for y=10,330,42 do seg_row(w, y, -10, 1066, 70, 9, {}, 0.03) end
print("wet", clock()-t0, balance().max_surface_water)
local bl=brush{name="bl", width=60}
for y=10,100,42 do seg_row(bl, y, -10, 1066, 70, 8, {["cerulean-blue"]=0.10, ["french-ultramarine"]=0.06}, 0.03, 10) end
local md=brush{name="md", width=60}
for y=142,184,42 do seg_row(md, y, -10, 1066, 70, 7, {["cerulean-blue"]=0.04, ["naples-yellow"]=0.02}, 0.03, 10) end
local gl=brush{name="gl", width=60}
for y=226,330,42 do seg_row(gl, y, -10, 1066, 70, 8, {["naples-yellow"]=0.08, ["quinacridone-rose"]=0.015}, 0.03, 10) end
print("color", clock()-t0, balance().max_surface_water)
for i=1,10 do local t=wait(0.5); local s=balance(); print(t, s.max_surface_water, s.max_wetness, s.dry) end