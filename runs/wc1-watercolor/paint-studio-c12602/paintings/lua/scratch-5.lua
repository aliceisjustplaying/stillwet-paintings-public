paper{width=1056,height=704,kind="cold-press",seed=4127}

-- pressure-ramp release test on dry paper, lower part
local function ramp_stroke(b, y, p0, p1, dur)
  local pts={}
  for i=0,40 do local x=-10+i*27; pts[#pts+1]={x,y,p0+(p1-p0)*i/40, dur*i/40} end
  b:stroke(pts, {duration=dur})
end
local b=brush{name="r1", width=50}
b:load{water=40, pigments={["cerulean-blue"]=0.4}}
ramp_stroke(b, 450, 0.35, 0.35, 0.4)
print(b:status().water)
local b2=brush{name="r2", width=50}
b2:load{water=40, pigments={["cerulean-blue"]=0.4}}
ramp_stroke(b2, 540, 0.1, 1.0, 0.4)
print(b2:status().water)
local b3=brush{name="r3", width=50}
b3:load{water=40, pigments={["cerulean-blue"]=0.4}}
ramp_stroke(b3, 630, 0.05, 0.6, 0.4)
print(b3:status().water)
-- drop wetting test
local t0=clock()
for gx=0,6 do for gy=0,2 do drop{x=40+gx*163, y=40+gy*120, water=60, radius=90} end end
print("drops", clock()-t0)
for i=1,12 do local t=wait(0.5); local s=balance(); print(t, s.max_surface_water, s.max_wetness, s.dry) end

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
local t0=clock()
local bl=brush{name="bl", width=60}
for y=10,100,45 do seg_row(bl, y, -10, 1066, 70, 6, {["cerulean-blue"]=0.10, ["french-ultramarine"]=0.06}, 0.03, 10) end
local gl=brush{name="gl", width=60}
for y=200,300,45 do seg_row(gl, y, -10, 1066, 70, 6, {["naples-yellow"]=0.08, ["quinacridone-rose"]=0.015}, 0.03, 10) end
print(clock()-t0)
for i=1,40 do local t=wait(0.5); local s=balance(); if i%4==0 then print(t, s.max_surface_water, s.max_wetness, s.dry) end end