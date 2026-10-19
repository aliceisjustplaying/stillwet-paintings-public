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
local function lerp(a,b,f) return a+(b-a)*f end
for gx=0,9 do for gy=0,3 do drop{x=math.min(1055, gx*118+math.random()*20), y=math.min(290, 10+gy*90+math.random()*15), water=4, radius=80} end end
print("wet", balance().max_surface_water)
local t0=clock()
local n=0
for y=5,335,40 do
  local f=(y-5)/330
  local b=brush{name="row"..n, width=80}; n=n+1
  local blue = math.max(0, 1-f*1.4)
  local warm = math.max(0, (f-0.3)/0.7)
  local mid = math.max(0, 1-math.abs(f-0.45)/0.35)
  local pig={["cerulean-blue"]=0.07*blue+0.0001, ["french-ultramarine"]=0.07*blue+0.012*mid+0.0001,
    ["naples-yellow"]=0.06*warm+0.0001, ["quinacridone-rose"]=0.012*warm+0.014*mid+0.0001, ["cadmium-orange"]=0.006*warm^2+0.0001}
  local path = wobbly(y, 8)
  if n%2==0 then local r={} for i=#path,1,-1 do r[#r+1]=path[i] end path=r end
  steady(b, path, 25, 6, pig, {speed=2500})
end
print("laid", clock()-t0, balance().max_surface_water)
for i=1,30 do local t=wait(0.5); local s=balance(); if i%4==0 then print(t, s.max_surface_water, s.max_wetness, s.dry) end end