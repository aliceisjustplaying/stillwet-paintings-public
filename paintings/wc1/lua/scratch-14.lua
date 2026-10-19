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
local n=0
for y=100,400,13 do
  local b=brush{name="m"..n, width=34}; n=n+1
  steady(b, {{-15,y},{1071,y}}, 25, 5, {["burnt-umber"]=0.05, ["french-ultramarine"]=0.04, ["quinacridone-rose"]=0.02, ["burnt-sienna"]=0.02, ["raw-umber"]=0.01}, {speed=5000})
end
wait(12)
local tests={
 {["naples-yellow"]=0.15},
 {["buff-titanium"]=0.15},
 {["naples-yellow"]=0.08, ["buff-titanium"]=0.08, ["cerulean-blue"]=0.02},
 {["cerulean-blue"]=0.1, ["buff-titanium"]=0.08},
}
for i,m in ipairs(tests) do
  local b=brush{name="t"..i, width=14}
  steady(b, {{40+(i-1)*250,160},{220+(i-1)*250,160}}, 20, 3, m, {speed=4000})
  local b2=brush{name="tt"..i, width=14}
  steady(b2, {{40+(i-1)*250,240},{220+(i-1)*250,240}}, 20, 3, {}, {speed=4000})
  for k,v in pairs(m) do m[k]=v*2.5 end
  local b3=brush{name="t3"..i, width=14}
  steady(b3, {{40+(i-1)*250,320},{220+(i-1)*250,320}}, 20, 3, m, {speed=4000})
end
wait(10)

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
local tests={
 {["naples-yellow"]=0.4, ["buff-titanium"]=0.3, ["indian-yellow"]=0.03},
 {["naples-yellow"]=0.8, ["buff-titanium"]=0.6, ["indian-yellow"]=0.05},
 {["cadmium-yellow"]=0.3, ["buff-titanium"]=0.5, ["naples-yellow"]=0.3},
 {["buff-titanium"]=1.0, ["naples-yellow"]=0.6},
}
for i,m in ipairs(tests) do
  local b=brush{name="h"..i, width=14}
  steady(b, {{40+(i-1)*250,200},{220+(i-1)*250,200}}, 20, 3, m, {speed=4000})
  local b2=brush{name="hh"..i, width=14}
  steady(b2, {{40+(i-1)*250,280},{220+(i-1)*250,280}}, 10, 1.5, m, {speed=4000})
end
wait(10)

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
local veils={
 {["buff-titanium"]=0.15, ["naples-yellow"]=0.08, ["quinacridone-rose"]=0.01},
 {["buff-titanium"]=0.3, ["naples-yellow"]=0.15, ["quinacridone-rose"]=0.02, ["cerulean-blue"]=0.03},
 {["buff-titanium"]=0.5, ["naples-yellow"]=0.25, ["quinacridone-rose"]=0.03, ["cerulean-blue"]=0.05},
}
for i,m in ipairs(veils) do
  local b=brush{name="v"..i, width=34}
  for y=330,390,13 do steady(b, {{20+(i-1)*340,y},{320+(i-1)*340,y}}, 25, 5, m, {speed=5000}) end
end
wait(10)

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
local pools={
 {["cerulean-blue"]=0.4, ["buff-titanium"]=0.4, ["quinacridone-rose"]=0.08, ["french-ultramarine"]=0.1},
 {["cerulean-blue"]=0.6, ["buff-titanium"]=0.3, ["quinacridone-rose"]=0.15, ["naples-yellow"]=0.1},
 {["buff-titanium"]=0.5, ["naples-yellow"]=0.3, ["quinacridone-rose"]=0.12, ["cerulean-blue"]=0.15},
}
for i,m in ipairs(pools) do
  local b=brush{name="pl"..i, width=16}
  for r=0,2 do steady(b, {{40+(i-1)*250+r*10,560+r*12,0.2},{120+(i-1)*250,560+r*12,0.5},{230+(i-1)*250-r*15,561+r*12,0.15}}, 10, 2, m, {speed=4000}) end
end
local ridge={["french-ultramarine"]=0.08, ["burnt-sienna"]=0.04, ["quinacridone-rose"]=0.015}
for r=0,4 do
  local b=brush{name="rg"..r, width=6+r*2}
  steady(b, {{780,540+r*30,0.15},{850,541+r*30,0.5},{1000,539+r*30,0.1}}, 8, 1.5, ridge, {speed=4000})
end
wait(10)

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
local n=0
for y=440,704,13 do
  local b=brush{name="mm"..n, width=34}; n=n+1
  steady(b, {{-15,y},{1071,y}}, 25, 5, {["burnt-umber"]=0.06, ["french-ultramarine"]=0.045, ["quinacridone-rose"]=0.02, ["burnt-sienna"]=0.02, ["raw-umber"]=0.01}, {speed=5000})
end
wait(12)
local pools={
 {["cobalt-blue"]=0.4, ["buff-titanium"]=0.3, ["quinacridone-rose"]=0.12},
 {["cerulean-blue"]=0.4, ["buff-titanium"]=0.25, ["quinacridone-rose"]=0.2, ["cobalt-violet"]=0.1},
 {["cobalt-violet"]=0.3, ["cerulean-blue"]=0.3, ["buff-titanium"]=0.2},
 {["buff-titanium"]=0.5, ["naples-yellow"]=0.2, ["quinacridone-rose"]=0.15, ["cobalt-violet"]=0.15},
}
for i,m in ipairs(pools) do
  local b=brush{name="pq"..i, width=16}
  for r=0,2 do steady(b, {{40+(i-1)*250+r*10,500+r*12,0.2},{120+(i-1)*250,500+r*12,0.5},{210+(i-1)*250-r*15,501+r*12,0.15}}, 10, 2, m, {speed=4000}) end
end
local ridge={["french-ultramarine"]=0.08, ["burnt-sienna"]=0.04, ["quinacridone-rose"]=0.015}
for r=0,3 do
  local b=brush{name="rq"..r, width=6+r*3}
  steady(b, {{40+r*250,620,0.15},{110+r*250,621,0.5},{230+r*250,619,0.1}}, 8, 1.5, ridge, {speed=4000})
  local b2=brush{name="rr"..r, width=6+r*3}
  steady(b2, {{40+r*250,660,0.15},{110+r*250,661,0.5},{230+r*250,659,0.1}}, 8, 1.5, {["sepia"]=0.08, ["french-ultramarine"]=0.06}, {speed=4000})
end
wait(10)

math.randomseed(5)
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
local mud={["burnt-umber"]=0.08, ["french-ultramarine"]=0.06, ["quinacridone-rose"]=0.025, ["burnt-sienna"]=0.03}
local refl={["sepia"]=0.05, ["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.01}
-- pools at x 40..215, y 494-520 (first one, cobalt). and 290..465
-- A: reflection band along top
local b=brush{name="rf1", width=6}
steady(b, {{50,499,0.1},{80,500,0.5},{180,500,0.5},{210,501,0.1}}, 8, 1.2, refl, {speed=4000})
-- B: tongues on pool 2
for i=1,4 do
  local x=300+i*35+math.random()*10
  local t=brush{name="tg"..i, width=10}
  steady(t, {{x,488,0.5},{x+12+math.random()*10, 505+math.random()*10,0.1}}, 6, 1.5, mud, {speed=3000})
end
local t2=brush{name="tge", width=12}
steady(t2, {{455,500,0.5},{420,512,0.15}}, 6, 1.5, mud, {speed=3000})
-- C: sheen on pool 3
local s=brush{name="sh", width=4}
steady(s, {{560,515,0.1},{600,515,0.5},{680,516,0.1}}, 8, 1.2, {["buff-titanium"]=0.4, ["naples-yellow"]=0.2, ["quinacridone-rose"]=0.05}, {speed=4000})
wait(10)

math.randomseed(6)
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
local mud={["burnt-umber"]=0.07, ["french-ultramarine"]=0.055, ["quinacridone-rose"]=0.025, ["burnt-sienna"]=0.03}
-- pool 3 at x 535..715, y 494-520 ; spits from the ends inward
local function spit(name, x0, x1, y, w)
  local b=brush{name=name, width=w}
  steady(b, {{x0,y,0.55},{x0+(x1-x0)*0.6,y+0.5,0.35},{x1,y+1,0.05}}, 6, 1.4, mud, {speed=3000})
end
spit("sp1", 530, 600, 506, 9)
spit("sp2", 720, 640, 497, 7)
spit("sp3", 720, 670, 516, 8)
spit("sp4", 580, 620, 522, 6)
wait(10)

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
-- curves as functions of u in [0,1] from bow(left) to stern(right), local coords
local function lerp(a,b,t) return a+(b-a)*t end
local function near(u) return -6 + 10*math.sin(math.pi*u)*0.9 + 4*u end      -- near gunwale y
local function far(u) return -6 - 18*math.sin(math.pi*math.min(1,u*1.1)) + (u>0.9 and (u-0.9)*-40 or 0) end
local function keel(u) return -4 + 20*math.sin(math.pi*(0.15+0.75*u)) end
local L=130
local function X(u) return -65 + L*u end
local function paintboat(cx, cy)
  -- interior
  local ib=brush{name="inside", width=6}
  local inmix={["buff-titanium"]=0.35, ["naples-yellow"]=0.1, ["cobalt-violet"]=0.06}
  for u=0.06,0.95,0.035 do
    steady(ib, {{cx+X(u), cy+far(u)+2},{cx+X(u)+1, cy+near(u)-1}}, 6, 1.2, inmix, {speed=3000})
  end
  -- hull side
  local hb=brush{name="hull", width=6}
  local hmix={["indian-red"]=0.25, ["burnt-sienna"]=0.08, ["french-ultramarine"]=0.04}
  for u=0.02,0.98,0.03 do
    steady(hb, {{cx+X(u), cy+near(u)+1},{cx+X(u)+1, cy+keel(u)-1}}, 6, 1.2, hmix, {speed=3000})
  end
  wait(3)
  -- dark accents: gunwales, keel shadow
  local d=brush{name="dark", width=3}
  local dmix={["sepia"]=0.12, ["french-ultramarine"]=0.08}
  local p1,p2,p3={}, {}, {}
  for u=0,1.0001,0.05 do p1[#p1+1]={cx+X(u), cy+near(u), 0.4}; p2[#p2+1]={cx+X(u), cy+far(u), 0.3}; p3[#p3+1]={cx+X(u), cy+keel(u)+2, 0.6} end
  steady(d, p1, 6, 1.0, dmix, {speed=3000})
  steady(d, p2, 6, 1.0, dmix, {speed=3000})
  local sh=brush{name="shadow", width=8}
  steady(sh, p3, 6, 1.4, {["french-ultramarine"]=0.1, ["sepia"]=0.08, ["quinacridone-rose"]=0.02}, {speed=3000})
  -- thwart and transom
  steady(d, {{cx+X(0.45), cy+far(0.45)+1},{cx+X(0.47), cy+near(0.47)-1}}, 4, 0.8, dmix, {speed=3000})
  steady(d, {{cx+X(0.98), cy+far(0.98)},{cx+X(1.0), cy+keel(1.0)}}, 4, 0.8, dmix, {speed=3000})
end
paintboat(700, 620)
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
local function curve(tbl) return function(x)
  if x<=tbl[1][1] then return tbl[1][2] end
  for i=1,#tbl-1 do local a,b=tbl[i],tbl[i+1]; if x>=a[1] and x<=b[1] then local t=(x-a[1])/(b[1]-a[1]); t=t*t*(3-2*t); return a[2]+(b[2]-a[2])*t end end
  return tbl[#tbl][2] end end
local near=curve{{-66,-17},{-40,-6},{-10,-1},{25,0},{60,-4}}
local far =curve{{-66,-17},{-45,-20},{-10,-21},{25,-19},{58,-15}}
local keel=curve{{-66,-17},{-58,-4},{-38,7},{0,12},{35,11},{58,5}}
local function paintboat(cx, cy, s)
  s = s or 1
  local ib=brush{name="inside2", width=5}
  local inmix={["buff-titanium"]=0.35, ["naples-yellow"]=0.1, ["cobalt-violet"]=0.06}
  for x=-60,56,3.5 do
    steady(ib, {{cx+x*s, cy+(far(x)+1.5)*s},{cx+x*s+1, cy+(near(x)-1)*s}}, 5, 1.0, inmix, {speed=3000})
  end
  local hb=brush{name="hull2", width=5}
  local hmix={["indian-red"]=0.25, ["burnt-sienna"]=0.08, ["french-ultramarine"]=0.04}
  for x=-64,58,3 do
    steady(hb, {{cx+x*s, cy+(near(x)+1)*s},{cx+x*s+1, cy+(keel(x)-1)*s}}, 5, 1.0, hmix, {speed=3000})
  end
  -- transom
  local tb=brush{name="transom2", width=5}
  local tmix={["indian-red"]=0.2, ["sepia"]=0.08, ["french-ultramarine"]=0.06}
  for x=56,63,2.5 do steady(tb, {{cx+x*s, cy+(far(58)+1)*s},{cx+x*s, cy+(keel(58))*s}}, 5, 1.0, tmix, {speed=3000}) end
  wait(3)
  local d=brush{name="dark2", width=3}
  local dmix={["sepia"]=0.12, ["french-ultramarine"]=0.08}
  local p1,p2,p3={}, {}, {}
  for x=-66,60,5 do p1[#p1+1]={cx+x*s, cy+near(x)*s, 0.4}; p2[#p2+1]={cx+x*s, cy+far(x)*s, 0.3}; p3[#p3+1]={cx+x*s, cy+(keel(x)+2)*s, 0.6} end
  steady(d, p1, 5, 1.0, dmix, {speed=3000})
  steady(d, p2, 5, 1.0, dmix, {speed=3000})
  local sh=brush{name="shadow2", width=9}
  local p4={}
  for x=-60,75,6 do p4[#p4+1]={cx+x*s, cy+(keel(math.min(x,58))+4)*s, 0.5} end
  steady(sh, p4, 6, 1.4, {["french-ultramarine"]=0.1, ["sepia"]=0.08, ["quinacridone-rose"]=0.02}, {speed=3000})
  steady(d, {{cx-8*s, cy+(far(-8)+1)*s},{cx-6*s, cy+(near(-6)-1)*s}}, 4, 0.8, dmix, {speed=3000})
  steady(d, {{cx+30*s, cy+(far(30)+1)*s},{cx+31*s, cy+(near(31)-1)*s}}, 4, 0.8, dmix, {speed=3000})
end
paintboat(450, 640, 1)
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
local dark={["sepia"]=0.12, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.015}
local rim={["naples-yellow"]=0.5, ["buff-titanium"]=0.3, ["cadmium-orange"]=0.05}
local c=0
local function post(x, ybase, h, w, lean)
  c=c+1
  local b=brush{name="post"..c, width=math.max(2, math.floor(w))}
  local top={x+lean, ybase-h}
  -- two vertical passes side by side for body
  steady(b, {{x, ybase, 0.6},{x+lean*0.5, ybase-h*0.5, 0.5},{top[1], top[2], 0.45}}, 4, 1.0, dark, {speed=2500})
  -- shadow on mud base
  local sb=brush{name="pshadow"..c, width=math.max(2, math.floor(w*0.8))}
  steady(sb, {{x-w*0.3, ybase+1, 0.2},{x-w*0.5-h*0.12, ybase+h*0.08, 0.5},{x-w*0.6-h*0.25, ybase+h*0.15, 0.1}}, 4, 0.8, dark, {speed=2500})
  wait(1.5)
  local rb=brush{name="prim"..c, width=math.max(1, math.floor(w*0.35))}
  steady(rb, {{top[1]-w*0.15, top[2]+1, 0.4},{top[1]+w*0.15, top[2]+1, 0.4}}, 3, 0.5, rim, {speed=2500})
  steady(rb, {{top[1]+w*0.25, top[2]+2, 0.3},{x+w*0.3+lean*0.3, ybase-h*0.3, 0.2}}, 4, 0.5, rim, {speed=2500})
end
post(100, 690, 90, 14, -3)
post(170, 640, 64, 11, 2)
post(230, 600, 46, 9, -1)
post(280, 570, 34, 7, 1)
post(320, 548, 25, 5, 0)
post(350, 533, 18, 4, -1)
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
local dark={["sepia"]=0.25, ["french-ultramarine"]=0.2, ["quinacridone-rose"]=0.03}
local rim={["naples-yellow"]=0.6, ["buff-titanium"]=0.3, ["cadmium-orange"]=0.08}
local c=10
local function post(x, ybase, h, w, lean)
  c=c+1
  local bw=math.max(2, math.floor(w*0.6))
  local b=brush{name="post"..c, width=bw}
  local tx=x+lean
  for off=-w*0.25, w*0.25+0.01, math.max(1, w*0.25) do
    steady(b, {{x+off, ybase+1, 0.6},{tx+off*0.9, ybase-h, 0.5}}, 4, 1.0, dark, {speed=2500})
  end
  local sb=brush{name="pbase"..c, width=math.max(2, math.floor(w*0.7))}
  steady(sb, {{x-w*1.0, ybase+w*0.25, 0.2},{x, ybase+w*0.35, 0.55},{x+w*1.4, ybase+w*0.3, 0.1}}, 4, 0.8, dark, {speed=2500})
  wait(1.5)
  local rb=brush{name="prim"..c, width=math.max(1, math.floor(w*0.3))}
  steady(rb, {{tx-w*0.25, ybase-h+1, 0.4},{tx+w*0.25, ybase-h+1, 0.4}}, 3, 0.5, rim, {speed=2500})
end
post(500, 690, 90, 14, -3)
post(570, 640, 64, 11, 2)
post(630, 600, 46, 9, -1)
post(680, 570, 34, 7, 1)
post(720, 548, 25, 5, 0)
post(750, 533, 18, 4, -1)
wait(8)