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
for gx=0,9 do for gy=0,3 do drop{x=math.min(1055, gx*118+math.random()*20), y=math.min(300, 10+gy*95+math.random()*15), water=5, radius=80} end end
print("wet", balance().max_surface_water)
local t0=clock()
local n=0
for y=5,335,40 do
  local f=(y-5)/330
  local b=brush{name="row"..n, width=80}; n=n+1
  local blue = math.max(0, 1-f*1.5)
  local warm = math.max(0, (f-0.35)/0.65)
  local mid = math.max(0, 1-math.abs(f-0.45)/0.3)
  local pig={["cerulean-blue"]=0.07*blue+0.0001, ["french-ultramarine"]=0.07*blue+0.02*mid+0.0001,
    ["naples-yellow"]=0.035*warm+0.0001, ["quinacridone-rose"]=0.018*warm+0.018*mid+0.0001, ["cadmium-orange"]=0.012*warm^1.5+0.0001}
  local path = wobbly(y, 8)
  if n%2==0 then local r={} for i=#path,1,-1 do r[#r+1]=path[i] end path=r end
  steady(b, path, 25, 6, pig, {speed=3500})
end
print("laid", clock()-t0, balance().max_surface_water)
for i=1,30 do local t=wait(0.5); local s=balance(); if i%4==0 then print(t, s.max_surface_water, s.max_wetness, s.dry) end end

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
      topup(b, water, pigs)
      b:stroke({{a[1]+dx*k/n, a[2]+dy*k/n},{a[1]+dx*(k+1)/n, a[2]+dy*(k+1)/n}}, {pressure=pr, duration=math.max(0.005, (L/n)/speed)})
    end
  end
end
local mixes={
 {["naples-yellow"]=0.02, ["cadmium-orange"]=0.015, ["quinacridone-rose"]=0.01},
 {["naples-yellow"]=0.01, ["cadmium-orange"]=0.008, ["quinacridone-rose"]=0.025},
 {["french-ultramarine"]=0.02, ["quinacridone-rose"]=0.02},
 {["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.03, ["burnt-sienna"]=0.02},
 {["french-ultramarine"]=0.09, ["quinacridone-rose"]=0.04, ["burnt-sienna"]=0.04},
}
for i,m in ipairs(mixes) do
  local b=brush{name="mx"..i, width=50}
  steady(b, {{30+(i-1)*200,420},{170+(i-1)*200,420}}, 25, 6, m, {speed=2000})
  steady(b, {{30+(i-1)*200,470},{170+(i-1)*200,470}}, 25, 3, m, {speed=2000})
end
wait(8)

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
      topup(b, water, pigs)
      b:stroke({{a[1]+dx*k/n, a[2]+dy*k/n},{a[1]+dx*(k+1)/n, a[2]+dy*(k+1)/n}}, {pressure=pr, duration=math.max(0.005, (L/n)/speed)})
    end
  end
end
local mixes={
 {["quinacridone-rose"]=0.08},
 {["quinacridone-rose"]=0.05, ["cadmium-orange"]=0.02},
 {["pyrrol-scarlet"]=0.03, ["naples-yellow"]=0.02},
 {["quinacridone-rose"]=0.04, ["french-ultramarine"]=0.02},
 {["indian-yellow"]=0.03, ["quinacridone-rose"]=0.04},
}
for i,m in ipairs(mixes) do
  local b=brush{name="my"..i, width=50}
  steady(b, {{30+(i-1)*200,560},{170+(i-1)*200,560}}, 25, 6, m, {speed=2000})
  steady(b, {{30+(i-1)*200,610},{170+(i-1)*200,610}}, 25, 3, m, {speed=2000})
end
wait(8)

math.randomseed(8)
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
local grey={["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.03, ["burnt-sienna"]=0.025}
-- A: wet streak first then charge
local w=brush{name="cw", width=40}
steady(w, {{80,200,0.3},{250,192,0.6},{450,196,0.5},{560,205,0.2}}, 25, 4, {}, {speed=3000})
local c=brush{name="cc", width=22}
steady(c, {{110,198,0.2},{260,192,0.6},{430,197,0.5},{530,203,0.1}}, 20, 3, grey, {speed=3000})
-- B: direct on dry, tapered
local c2=brush{name="cc2", width=22}
steady(c2, {{600,250,0.1},{720,244,0.6},{900,248,0.5},{1040,256,0.1}}, 20, 3, grey, {speed=3000})
wait(8)

math.randomseed(9)
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
local grey={["french-ultramarine"]=0.035, ["quinacridone-rose"]=0.025, ["burnt-sienna"]=0.015}
local function cloud(x0, x1, y, thick, seedname)
  local w=brush{name="cw"..seedname, width=thick}
  steady(w, {{x0,y},{(x0+x1)/2,y-4},{x1,y+3}}, 25, 5, {}, {speed=3500})
  local c=brush{name="cc"..seedname, width=math.floor(thick*0.5)}
  local x=x0+20
  while x < x1-30 do
    local L=30+math.random()*60
    local yy=y+(math.random()-0.5)*thick*0.4
    steady(c, {{x,yy},{math.min(x1-10,x+L),yy+(math.random()-0.5)*6}}, 20, 3, grey, {speed=3500})
    x = x + L*0.7
  end
end
cloud(60, 520, 300, 50, "a")
cloud(560, 1000, 330, 36, "b")
wait(8)

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
local prof={{-10,232},{40,226},{90,236},{150,251},{200,247},{250,262},{300,283},{360,301},{410,319},{450,333},{500,343},{540,346}}
local function topy(x)
  for i=1,#prof-1 do local a,b=prof[i],prof[i+1]; if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return 400
end
local function rightx(y)
  -- largest x where topy(x) <= y
  local x=540; while x>-10 and topy(x)>y do x=x-2 end; return x
end
local hl={["french-ultramarine"]=0.06, ["quinacridone-rose"]=0.04, ["burnt-sienna"]=0.015}
local b=brush{name="hl", width=10}
steady(b, prof, 8, 2, hl, {speed=2500})
local f=brush{name="hlf", width=22}
for y=238,346,12 do
  local xr=rightx(y-4)
  local t=(y-238)/108
  local pig={["french-ultramarine"]=0.06*(1-0.4*t), ["quinacridone-rose"]=0.04*(1-0.3*t), ["burnt-sienna"]=0.015*(1-0.5*t)}
  if xr>0 then steady(f, {{-10,y},{xr,y}}, 18, 4, pig, {speed=3000}) end
end
wait(8)

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
local prof={{1066,262},{1010,258},{960,268},{900,280},{850,276},{800,292},{750,312},{700,330},{660,343},{620,350}}
local function topy(x)
  for i=1,#prof-1 do local a,b=prof[i+1],prof[i]; if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return 400
end
local function leftx(y) local x=620; while x<1066 and topy(x)>y do x=x+2 end; return x end
local hl={["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.03, ["cerulean-blue"]=0.01, ["raw-umber"]=0.006}
local b=brush{name="hill2", width=26}
-- edge first, same mix, then fill rows immediately (same brush)
steady(b, prof, 10, 4, hl, {speed=4000})
for y=272,352,10 do
  local xl=leftx(y-6)
  steady(b, {{1066,y},{xl,y}}, 18, 4, hl, {speed=5000})
end
wait(8)