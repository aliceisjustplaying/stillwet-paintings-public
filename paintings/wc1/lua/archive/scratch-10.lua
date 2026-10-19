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
local top={cer=0.07, ult=0.07, nap=0, rose=0.0, iy=0}
local bot={cer=0.0, ult=0.0, nap=0.06, rose=0.012, iy=0.012}
local t0=clock()
local n=0
for y=5,335,40 do
  local f=(y-5)/330
  f = f^0.8
  local b=brush{name="row"..n, width=80}; n=n+1
  local pig={["cerulean-blue"]=top.cer*(1-f)+0.001, ["french-ultramarine"]=top.ult*(1-f)+0.001,
    ["naples-yellow"]=bot.nap*f+0.001, ["quinacridone-rose"]=bot.rose*f+0.003*(1-f), ["indian-yellow"]=bot.iy*f+0.0005}
  local dir = (n%2==0)
  local path = wobbly(y, 8)
  if dir then local r={} for i=#path,1,-1 do r[#r+1]=path[i] end path=r end
  steady(b, path, 25, 6, pig, {speed=2500})
end
print("laid", clock()-t0, balance().max_surface_water)
for i=1,30 do local t=wait(0.5); local s=balance(); if i%4==0 then print(t, s.max_surface_water, s.max_wetness, s.dry) end end