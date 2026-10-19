paper{width=1056,height=704,kind="cold-press",seed=4127}

math.randomseed(21)
local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
local function steady(b, path, step, water, pigs, opt)
  opt = opt or {}
  local pr = opt.pressure or 0.5
  local speed = opt.speed or 1500
  for i=1,#path-1 do
    local a,c = path[i], path[i+1]
    local dx,dy = c[1]-a[1], c[2]-a[2]
    local L = math.sqrt(dx*dx+dy*dy)
    local n = math.max(1, math.floor(L/step+0.5))
    for k=0,n-1 do
      local x0,y0 = a[1]+dx*k/n, a[2]+dy*k/n
      local x1,y1 = a[1]+dx*(k+1)/n, a[2]+dy*(k+1)/n
      topup(b, water, pigs)
      b:stroke({{x0,y0},{x1,y1}}, {pressure=pr, duration=math.max(0.005, (L/n)/speed)})
    end
  end
end
local function wobbly(y, amp)
  local pts={}
  for x=-20,1080,110 do pts[#pts+1]={x, y+(math.random()-0.5)*amp} end
  return pts
end
for gx=0,9 do for gy=0,3 do drop{x=math.min(1055, gx*118+math.random()*20), y=math.min(275, gy*90+math.random()*15), water=8, radius=80} end end
local t0=clock()
local sky=brush{name="sky", width=90}
steady(sky, wobbly(10,10), 25, 6, {["cerulean-blue"]=0.07, ["french-ultramarine"]=0.07}, {speed=2500})
steady(sky, wobbly(75,16), 25, 6, {["cerulean-blue"]=0.06, ["french-ultramarine"]=0.04}, {speed=2500})
local cl=brush{name="cloud", width=70}
steady(cl, wobbly(150,30), 25, 5, {["french-ultramarine"]=0.05, ["burnt-sienna"]=0.025, ["quinacridone-rose"]=0.02}, {speed=2500})
local gl=brush{name="glow", width=80}
steady(gl, wobbly(215,12), 25, 5, {["naples-yellow"]=0.04, ["quinacridone-rose"]=0.015}, {speed=2500})
local gl2=brush{name="glow2", width=80}
steady(gl2, wobbly(275,8), 25, 5, {["naples-yellow"]=0.05, ["indian-yellow"]=0.01, ["quinacridone-rose"]=0.008}, {speed=2500})
steady(gl2, wobbly(325,4), 25, 4, {["naples-yellow"]=0.05, ["indian-yellow"]=0.01, ["quinacridone-rose"]=0.008}, {speed=2500})
print("laid", clock()-t0, balance().max_surface_water)
for i=1,30 do local t=wait(0.5); local s=balance(); if i%4==0 then print(t, s.max_surface_water, s.max_wetness, s.dry) end end