paper{width=1056,height=704,kind="cold-press",seed=4127}

math.randomseed(21)
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
local function wobbly(y, amp)
  local pts={}
  for x=-20,1080,110 do pts[#pts+1]={x, y+(math.random()-0.5)*amp} end
  return pts
end
for gx=0,9 do for gy=0,3 do drop{x=math.min(1055, gx*118+math.random()*20), y=math.min(300, 10+gy*95+math.random()*15), water=5, radius=80} end end
local n=0
for y=5,335,40 do
  local f=(y-5)/330
  local b=brush{name="skyrow"..n, width=80}; n=n+1
  local blue = math.max(0, 1-f*1.5)
  local mid = math.max(0, 1-math.abs(f-0.45)/0.25)
  local peach = math.max(0, 1-math.abs(f-0.7)/0.25)
  local gold = math.max(0, (f-0.7)/0.3)
  local pig={["cerulean-blue"]=0.07*blue+0.0001,
    ["french-ultramarine"]=0.07*blue+0.025*mid+0.0001,
    ["quinacridone-rose"]=0.05*mid+0.0001,
    ["pyrrol-scarlet"]=0.03*peach+0.015*gold+0.0001,
    ["naples-yellow"]=0.02*peach+0.015*gold+0.0001,
    ["indian-yellow"]=0.03*gold+0.0001}
  local path = wobbly(y, 8)
  if n%2==0 then local r={} for i=#path,1,-1 do r[#r+1]=path[i] end path=r end
  steady(b, path, 25, 6, pig, {speed=3500})
end
for i=1,24 do wait(0.5) end
print(balance().dry)
-- streak trials on glow
local mixes={
 {["french-ultramarine"]=0.04, ["quinacridone-rose"]=0.04, ["burnt-sienna"]=0.01},
 {["cobalt-violet"]=0.08, ["french-ultramarine"]=0.03},
 {["quinacridone-rose"]=0.04, ["pyrrol-scarlet"]=0.02, ["french-ultramarine"]=0.015},
}
for i,m in ipairs(mixes) do
  local b=brush{name="st"..i, width=16}
  local y=200+(i-1)*40
  steady(b, {{80,y,0.1},{200,y-2,0.5},{420,y,0.4},{520,y+2,0.05}}, 10, 2.5, m, {speed=3000})
  local b2=brush{name="su"..i, width=26}
  steady(b2, {{560,y,0.1},{680,y-3,0.6},{900,y,0.4},{1000,y+3,0.05}}, 10, 1.5, m, {speed=3000})
end
wait(8)

math.randomseed(44)
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
local cnum=0
local function cloud(x0, x1, y, thick, mix, wet)
  cnum=cnum+1
  local w=brush{name="cwet"..cnum, width=thick}
  local L=x1-x0
  steady(w, {{x0,y,0.15},{x0+L*0.2,y-thick*0.15,0.55},{x0+L*0.7,y-thick*0.1,0.5},{x1,y+2,0.1}}, 12, wet, {}, {speed=4000})
  local x=x0+L*0.05
  local k=0
  while x < x1-L*0.08 do
    k=k+1
    local seg=L*(0.12+math.random()*0.18)
    local yy=y+thick*(0.05+math.random()*0.2)
    local db=brush{name="cd"..cnum.."_"..k, width=math.floor(thick*(0.35+math.random()*0.25))}
    steady(db, {{x,yy,0.1},{x+seg*0.3,yy-1,0.5},{x+seg,yy+(math.random()-0.5)*4,0.1}}, 8, 1.8, mix, {speed=4000})
    x = x + seg*(0.6+math.random()*0.3)
  end
end
local m1={["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.045, ["burnt-sienna"]=0.012}
cloud(60, 500, 380, 30, m1, 3)
cloud(560, 1000, 380, 40, m1, 4)
cloud(80, 450, 460, 22, m1, 2)
cloud(560, 900, 460, 22, {["quinacridone-rose"]=0.04, ["pyrrol-scarlet"]=0.02, ["french-ultramarine"]=0.02}, 2)
wait(8)