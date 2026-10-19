paper{width=1056, height=704, kind="cold-press", seed=4127}
print(table.concat(palette(), ", "))

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
      topup(b, water, pigs)
      b:stroke({{a[1]+dx*k/n, a[2]+dy*k/n},{a[1]+dx*(k+1)/n, a[2]+dy*(k+1)/n}}, {pressure=pr, duration=math.max(0.005, (L/n)/speed)})
    end
  end
end
local function wobbly(y, amp)
  local pts={}
  for x=-20,1080,110 do pts[#pts+1]={x, y+(math.random()-0.5)*amp} end
  return pts
end
for gx=0,9 do for gy=0,3 do drop{x=math.min(1055, gx*118+math.random()*20), y=math.min(300, 10+gy*95+math.random()*15), water=5, radius=80} end end
local t0=clock()
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
print("laid", clock()-t0, balance().max_surface_water)
for i=1,24 do local t=wait(0.5) end
print(balance().dry)

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
-- headland, left, profile drawn freely
local prof={{-12,236},{30,230},{75,238},{120,233},{170,248},{215,255},{255,272},{300,290},{345,307},{390,324},{430,337},{470,346},{510,352}}
local function topy(x)
  for i=1,#prof-1 do local a,b=prof[i],prof[i+1]; if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return 400
end
local function rightx(y) local x=510; while x>-12 and topy(x)>y do x=x-2 end; return x end
local hl={["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.04, ["cerulean-blue"]=0.006, ["raw-umber"]=0.006}
local b=brush{name="headland", width=26}
steady(b, prof, 10, 4, hl, {speed=4000})
for y=244,360,10 do
  local xr=rightx(y-6)
  steady(b, {{-12,y},{xr,y}}, 18, 4, hl, {speed=5000})
end
wait(10)
print(balance().dry)

math.randomseed(33)
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
for gx=0,9 do for gy=0,3 do drop{x=math.min(1055, gx*118+math.random()*20), y=math.min(700, 390+gy*95+math.random()*15), water=5, radius=80} end end
local n=0
for y=372,704,40 do
  local f=(y-372)/332
  local b=brush{name="flatrow"..n, width=80}; n=n+1
  local gold = math.max(0, 1-f/0.3)
  local peach = math.max(0, 1-math.abs(f-0.3)/0.3)
  local mid = math.max(0, 1-math.abs(f-0.6)/0.3)
  local blue = math.max(0, (f-0.55)/0.45)
  local pig={["indian-yellow"]=0.025*gold+0.0001,
    ["naples-yellow"]=0.015*gold+0.015*peach+0.0001,
    ["pyrrol-scarlet"]=0.012*gold+0.025*peach+0.0001,
    ["quinacridone-rose"]=0.035*mid+0.0001,
    ["french-ultramarine"]=0.02*mid+0.045*blue+0.0001,
    ["cerulean-blue"]=0.04*blue+0.0001}
  local path = wobbly(y, 6)
  if n%2==0 then local r={} for i=#path,1,-1 do r[#r+1]=path[i] end path=r end
  steady(b, path, 25, 6, pig, {speed=3500})
end
for i=1,24 do wait(0.5) end
print(balance().dry)

math.randomseed(77)
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
local ch={{430,580,640},{445,545,602},{460,520,585},{480,538,622},{500,578,682},{530,598,732},{560,558,742},{600,468,702},{640,378,662},{680,298,642},{720,240,640}}
local function edges(y)
  for i=1,#ch-1 do local a,b=ch[i],ch[i+1]
    if y>=a[1] and y<=b[1] then local t=(y-a[1])/(b[1]-a[1]); return a[2]+(b[2]-a[2])*t, a[3]+(b[3]-a[3])*t end end
  return ch[#ch][2], ch[#ch][3]
end
local function lerp(a,b,t) return a+(b-a)*t end
local n=0
for y=434,712,13 do
  local f=(y-434)/278
  local xl,xr=edges(y)
  local warm = 0.5+0.5*math.sin(y*0.05+1.3)
  local pig={["burnt-umber"]=lerp(0.03,0.07,f), ["french-ultramarine"]=lerp(0.03,0.05,f),
    ["quinacridone-rose"]=lerp(0.018,0.02,f), ["burnt-sienna"]=0.012+0.02*warm, ["raw-umber"]=0.01}
  local b=brush{name="mudL"..n, width=34}
  steady(b, {{-15,y+(math.random()-0.5)*3},{xl+(math.random()-0.5)*8,y+(math.random()-0.5)*3}}, 25, 5, pig, {speed=5000})
  local b2=brush{name="mudR"..n, width=34}
  steady(b2, {{1071,y+(math.random()-0.5)*3},{xr+(math.random()-0.5)*8,y+(math.random()-0.5)*3}}, 25, 5, pig, {speed=5000})
  n=n+1
end
for i=1,24 do wait(0.5) end
print(balance().dry)

math.randomseed(101)
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
-- glow shine streaks on the far mud: thin, long, tapered
local shine={["naples-yellow"]=0.12, ["buff-titanium"]=0.10, ["indian-yellow"]=0.015, ["pyrrol-scarlet"]=0.008}
local streaks={
 {30,428,260,4},{300,431,540,3},{620,427,900,4},{930,430,1060,3},
 {-10,441,180,5},{220,446,470,4},{640,444,820,5},{860,439,1050,4},
 {60,458,330,6},{380,462,520,4},{700,460,980,6},
 {-10,478,150,6},{180,481,420,7},{740,484,1060,7},
}
for i,s in ipairs(streaks) do
  local b=brush{name="shineA"..i, width=s[4]*2}
  local x0,y,x1=s[1],s[2],s[3]
  local mid=(x0+x1)/2
  steady(b, {{x0,y,0.15},{mid,y+(math.random()-0.5)*2,0.6},{x1,y+(math.random()-0.5)*2,0.15}}, 15, 2.5, shine, {speed=4000})
end
wait(8)
print(balance().dry)

math.randomseed(202)
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
local glow={["naples-yellow"]=0.8, ["buff-titanium"]=0.6, ["indian-yellow"]=0.05, ["pyrrol-scarlet"]=0.01}
-- a pool: list of rows {xstart, xend} stacked at dy spacing; each row a tapered stroke
local function pool(name, y, rows, wid, mix, dy)
  dy = dy or wid*0.8
  for i,r in ipairs(rows) do
    local b=brush{name=name..i, width=wid}
    local yy=y+(i-1)*dy
    steady(b, {{r[1],yy,0.15},{r[1]+(r[2]-r[1])*0.15,yy,0.5},{r[1]+(r[2]-r[1])*0.85,yy+1,0.5},{r[2],yy+1,0.12}}, 10, 1.5, mix, {speed=4000})
  end
end
-- far: thin long streaks just under the bank edge, broken
pool("pa", 424, {{-10,150},{40,300}}, 6, glow, 5)
pool("pb", 427, {{340,560}}, 6, glow)
pool("pc", 425, {{640,760},{610,880}}, 6, glow, 5)
pool("pd", 428, {{920,1065}}, 6, glow)
pool("pe", 444, {{200,420},{150,470},{230,440}}, 8, glow, 5)
pool("pf", 446, {{700,980},{760,1000}}, 8, glow, 6)
pool("pg", 462, {{-10,90},{-10,140}}, 8, glow, 6)
pool("ph", 470, {{820,940},{780,1010},{850,980}}, 9, glow, 6)
pool("pi", 486, {{260,460},{220,500},{300,430}}, 10, glow, 7)
wait(8)
print(balance().dry)

math.randomseed(303)
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
local ch={{430,580,640},{445,545,602},{460,520,585},{480,538,622},{500,578,682},{530,598,732},{560,558,742},{600,468,702},{640,378,662},{680,298,642},{720,240,640}}
local function edges(y)
  for i=1,#ch-1 do local a,b=ch[i],ch[i+1]
    if y>=a[1] and y<=b[1] then local t=(y-a[1])/(b[1]-a[1]); return a[2]+(b[2]-a[2])*t, a[3]+(b[3]-a[3])*t end end
  return ch[#ch][2], ch[#ch][3]
end
local n=0
for y=420,530,12 do
  local f=(y-420)/110
  local k=(1-f)^1.4*0.9+0.08
  local pig={["buff-titanium"]=0.16*k, ["naples-yellow"]=0.06*k, ["quinacridone-rose"]=0.015*k, ["french-ultramarine"]=0.006*k}
  local xl,xr=edges(y)
  local b=brush{name="veilL"..n, width=30}
  steady(b, {{-15,y+(math.random()-0.5)*4},{xl+2,y+(math.random()-0.5)*4}}, 25, 5, pig, {speed=5000})
  local b2=brush{name="veilR"..n, width=30}
  steady(b2, {{1071,y+(math.random()-0.5)*4},{xr-2,y+(math.random()-0.5)*4}}, 25, 5, pig, {speed=5000})
  n=n+1
end
for i=1,20 do wait(0.5) end
print(balance().dry)

math.randomseed(404)
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
local skyp={["cobalt-blue"]=0.4, ["buff-titanium"]=0.3, ["quinacridone-rose"]=0.12}
local warmp={["buff-titanium"]=0.5, ["naples-yellow"]=0.2, ["quinacridone-rose"]=0.15, ["cobalt-violet"]=0.1}
local lip={["french-ultramarine"]=0.12, ["burnt-umber"]=0.08, ["quinacridone-rose"]=0.02}
-- pool: x0..x1 at y, thickness h; strokes stacked with variable insets
local cnt=0
local function pool(x0, x1, y, h, mix, w)
  w = w or 12
  local rows = math.max(1, math.floor(h / (w*0.6)))
  for r=0,rows-1 do
    local t = (r+0.5)/rows
    local inset = (x1-x0) * 0.5 * (1 - math.sqrt(1-(2*t-1)^2)) * 0.9 + math.random()*10
    local a = x0 + inset + math.random()*8
    local c = x1 - inset*0.7 - math.random()*8
    local yy = y + r*w*0.6
    cnt=cnt+1
    local b=brush{name="pool"..cnt, width=w}
    steady(b, {{a,yy,0.15},{a+(c-a)*0.2,yy,0.5},{a+(c-a)*0.8,yy+1,0.5},{c,yy+1,0.12}}, 10, 2, mix, {speed=4000})
  end
  cnt=cnt+1
  local lb=brush{name="lip"..cnt, width=4}
  steady(lb, {{x0+10,y-w*0.45,0.1},{x0+(x1-x0)*0.3,y-w*0.5,0.5},{x1-(x1-x0)*0.25,y-w*0.45,0.4},{x1-5,y-w*0.4,0.1}}, 8, 1.2, lip, {speed=4000})
end
-- left bank
pool(30, 290, 600, 22, skyp, 12)
pool(110, 360, 655, 34, skyp, 16)
pool(370, 470, 562, 10, warmp, 9)
pool(-10, 90, 690, 14, skyp, 14)
-- right bank
pool(760, 990, 612, 24, skyp, 13)
pool(850, 1070, 668, 34, skyp, 16)
pool(690, 790, 572, 10, warmp, 9)
pool(930, 1060, 560, 12, warmp, 10)
wait(10)
print(balance().dry)

math.randomseed(505)
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
local refl={["sepia"]=0.05, ["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.01}
local sheen={["buff-titanium"]=0.4, ["naples-yellow"]=0.2, ["quinacridone-rose"]=0.05}
local c=0
local function spit(x0, x1, y, w)
  c=c+1; local b=brush{name="spit"..c, width=w}
  steady(b, {{x0,y,0.55},{x0+(x1-x0)*0.6,y+0.5,0.35},{x1,y+1,0.05}}, 6, 1.4, mud, {speed=3000})
end
local function band(x0, x1, y, w, mix)
  c=c+1; local b=brush{name="band"..c, width=w}
  steady(b, {{x0,y,0.1},{x0+(x1-x0)*0.2,y,0.5},{x0+(x1-x0)*0.8,y+0.5,0.5},{x1,y+0.5,0.1}}, 8, 1.2, mix, {speed=4000})
end
-- left pool 1: ~ x 40..280, y 593..618
band(55, 250, 598, 6, refl)
spit(25, 95, 608, 9); spit(290, 215, 603, 8); spit(285, 230, 615, 7); spit(120,175,620,6)
band(110, 200, 611, 3, sheen)
-- left pool 2: ~ x 110..355, y 647..690
band(130, 330, 652, 7, refl)
spit(100, 175, 668, 10); spit(365, 290, 660, 9); spit(360, 250, 680, 8); spit(190, 240, 690, 7)
band(200, 300, 670, 3, sheen)
-- left tiny pool at bottom-left
spit(-10, 45, 690, 8)
-- right pool 1: ~ x 765..985, y 605..630
band(780, 960, 610, 6, refl)
spit(750, 820, 618, 9); spit(995, 930, 613, 8); spit(990, 900, 627, 7)
band(840, 920, 622, 3, sheen)
-- right pool 2: ~ x 850..1070, y 660..704
band(870, 1060, 666, 7, refl)
spit(840, 920, 682, 10); spit(1066, 1010, 690, 8); spit(940, 990, 700, 7)
band(950, 1030, 684, 3, sheen)
wait(10)
print(balance().dry)

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
local near=curve{{-66,-19},{-44,-7},{-10,-1},{25,0},{60,-4}}
local far =curve{{-66,-19},{-48,-21},{-10,-21},{25,-19},{58,-15}}
local keel=curve{{-66,-19},{-58,-5},{-38,7},{0,12},{35,11},{58,5}}
local function paintboat(cx, cy, s)
  local ib=brush{name="b_inside", width=5}
  local inmix={["buff-titanium"]=0.35, ["naples-yellow"]=0.1, ["cobalt-violet"]=0.06}
  for x=-60,56,3.5 do
    steady(ib, {{cx+x*s, cy+(far(x)+1.5)*s},{cx+x*s+1, cy+(near(x)-1)*s}}, 5, 1.0, inmix, {speed=3000})
  end
  local hb=brush{name="b_hull", width=5}
  local hmix={["indian-red"]=0.25, ["burnt-sienna"]=0.08, ["french-ultramarine"]=0.04}
  for x=-64,58,3 do
    steady(hb, {{cx+x*s, cy+(near(x)+1)*s},{cx+x*s+1, cy+(keel(x)-1)*s}}, 5, 1.0, hmix, {speed=3000})
  end
  local tb=brush{name="b_transom", width=5}
  local tmix={["indian-red"]=0.2, ["sepia"]=0.08, ["french-ultramarine"]=0.06}
  for x=56,63,2.5 do steady(tb, {{cx+x*s, cy+(far(58)+1)*s},{cx+x*s, cy+(keel(58))*s}}, 5, 1.0, tmix, {speed=3000}) end
  wait(3)
  local d=brush{name="b_dark", width=3}
  local dmix={["sepia"]=0.12, ["french-ultramarine"]=0.08}
  local p1,p2={}, {}
  for x=-66,60,5 do p1[#p1+1]={cx+x*s, cy+near(x)*s, 0.4}; p2[#p2+1]={cx+x*s, cy+far(x)*s, 0.3} end
  steady(d, p1, 5, 1.0, dmix, {speed=3000})
  steady(d, p2, 5, 1.0, dmix, {speed=3000})
  local sh=brush{name="b_shadow", width=9}
  local p4={}
  for x=-60,72,6 do p4[#p4+1]={cx+x*s, cy+(keel(math.min(x,58))+4)*s, 0.5} end
  steady(sh, p4, 6, 1.4, {["french-ultramarine"]=0.1, ["sepia"]=0.08, ["quinacridone-rose"]=0.02}, {speed=3000})
  steady(d, {{cx-8*s, cy+(far(-8)+1)*s},{cx-6*s, cy+(near(-6)-1)*s}}, 4, 0.8, dmix, {speed=3000})
  steady(d, {{cx+30*s, cy+(far(30)+1)*s},{cx+31*s, cy+(near(31)-1)*s}}, 4, 0.8, dmix, {speed=3000})
end
paintboat(812, 532, 0.95)
wait(8)
print(balance().dry)

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
local c=0
local function post(x, ybase, h, w, lean, slant)
  c=c+1
  slant = slant or 0
  local bw=math.max(2, math.floor(w*0.6))
  local b=brush{name="P"..c, width=bw}
  local tx=x+lean
  for off=-w*0.25, w*0.25+0.01, math.max(1, w*0.25) do
    local frac = (off + w*0.25)/(w*0.5+0.001)
    steady(b, {{x+off, ybase+1, 0.6},{tx+off*0.9, ybase-h + slant*(frac-0.5), 0.5}}, 4, 1.0, dark, {speed=2500})
  end
  local sb=brush{name="PB"..c, width=math.max(2, math.floor(w*0.7))}
  steady(sb, {{x-w*1.0, ybase+w*0.25, 0.2},{x, ybase+w*0.35, 0.55},{x+w*1.4, ybase+w*0.3, 0.1}}, 4, 0.8, dark, {speed=2500})
  wait(1.5)
  local rb=brush{name="PR"..c, width=math.max(1, math.floor(w*0.3))}
  steady(rb, {{tx-w*0.25, ybase-h+1 - slant*0.5, 0.4},{tx+w*0.25, ybase-h+1 + slant*0.5, 0.4}}, 3, 0.5, rim, {speed=2500})
end
post(212, 696, 104, 16, -4, 4)
post(296, 640, 72, 12, 2, -3)
post(370, 597, 44, 9, -1, 2)   -- shorter, broken
post(426, 566, 38, 7, 3, 0)
post(476, 540, 27, 6, 0, 1)
post(540, 506, 17, 4, 0, 0)
post(558, 495, 11, 3, -1, 0)
wait(8)
print(balance().dry)

math.randomseed(606)
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
  local w=brush{name="SCwet"..cnum, width=thick}
  local L=x1-x0
  steady(w, {{x0,y,0.15},{x0+L*0.2,y-thick*0.15,0.55},{x0+L*0.7,y-thick*0.1,0.5},{x1,y+2,0.1}}, 12, wet, {}, {speed=4000})
  local x=x0+L*0.05
  local k=0
  while x < x1-L*0.08 do
    k=k+1
    local seg=L*(0.12+math.random()*0.18)
    local yy=y+thick*(0.05+math.random()*0.2)
    local db=brush{name="SCd"..cnum.."_"..k, width=math.floor(thick*(0.35+math.random()*0.25))}
    steady(db, {{x,yy,0.1},{x+seg*0.3,yy-1,0.5},{x+seg,yy+(math.random()-0.5)*4,0.1}}, 8, 1.8, mix, {speed=4000})
    x = x + seg*(0.6+math.random()*0.3)
  end
end
local m1={["french-ultramarine"]=0.055, ["quinacridone-rose"]=0.045, ["burnt-sienna"]=0.012}
local rosy={["quinacridone-rose"]=0.04, ["pyrrol-scarlet"]=0.02, ["french-ultramarine"]=0.02}
cloud(140, 640, 186, 34, m1, 3)
cloud(660, 1050, 202, 30, m1, 3)
cloud(30, 290, 204, 16, m1, 2)
cloud(560, 880, 256, 20, rosy, 2)
cloud(780, 1060, 287, 14, rosy, 2)
wait(8)
print(balance().dry)

math.randomseed(707)
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
-- far spit right: top profile, base y=362
local prof={{790,361},{830,357},{870,354},{905,351},{940,352},{975,346},{1010,343},{1040,345},{1066,342}}
local mix={["french-ultramarine"]=0.025, ["quinacridone-rose"]=0.025, ["cerulean-blue"]=0.004, ["naples-yellow"]=0.01}
local b=brush{name="farspit", width=6}
steady(b, prof, 6, 1.4, mix, {speed=4000})
for y=350,362,4 do
  local x0=790
  for i=1,#prof do if prof[i][2] <= y-2 then x0=prof[i][1]; break end end
  steady(b, {{1066,y},{x0,y}}, 10, 1.6, mix, {speed=5000})
end
wait(6)
print(balance().dry)

print(clock(), balance().dry)

math.randomseed(808)
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
-- trial glaze: only the bottom-left corner left of x=200, rows y 640..704
local n=0
for y=650,704,13 do
  local f=(y-560)/144
  local pig={["french-ultramarine"]=0.035*f, ["quinacridone-rose"]=0.018*f}
  local b=brush{name="Gtrial"..n, width=34}; n=n+1
  steady(b, {{-15,y},{120,y+(math.random()-0.5)*4}}, 25, 5, pig, {speed=5000})
end
wait(8); print(balance().dry)

math.randomseed(909)
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
local ch={{430,580,640},{445,545,602},{460,520,585},{480,538,622},{500,578,682},{530,598,732},{560,558,742},{600,468,702},{640,378,662},{680,298,642},{720,240,640}}
local function edges(y)
  for i=1,#ch-1 do local a,b=ch[i],ch[i+1]
    if y>=a[1] and y<=b[1] then local t=(y-a[1])/(b[1]-a[1]); return a[2]+(b[2]-a[2])*t, a[3]+(b[3]-a[3])*t end end
  return ch[#ch][2], ch[#ch][3]
end
local n=0
for y=548,620,12 do
  local f=((y-530)/174)^1.2
  local pig={["french-ultramarine"]=0.045*f, ["quinacridone-rose"]=0.022*f, ["burnt-sienna"]=0.004*f}
  local xl,xr=edges(y)
  local b=brush{name="GL"..n, width=30}
  steady(b, {{-15,y+(math.random()-0.5)*4},{xl-4,y+(math.random()-0.5)*3}}, 25, 5, pig, {speed=5000})
  local b2=brush{name="GR"..n, width=30}
  steady(b2, {{1071,y+(math.random()-0.5)*4},{xr+4,y+(math.random()-0.5)*3}}, 25, 5, pig, {speed=5000})
  n=n+1
end
wait(8); print(balance().dry)

math.randomseed(910)
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
local ch={{430,580,640},{445,545,602},{460,520,585},{480,538,622},{500,578,682},{530,598,732},{560,558,742},{600,468,702},{640,378,662},{680,298,642},{720,240,640}}
local function edges(y)
  for i=1,#ch-1 do local a,b=ch[i],ch[i+1]
    if y>=a[1] and y<=b[1] then local t=(y-a[1])/(b[1]-a[1]); return a[2]+(b[2]-a[2])*t, a[3]+(b[3]-a[3])*t end end
  return ch[#ch][2], ch[#ch][3]
end
local n=20
for y=632,708,12 do
  local f=math.min(1,((y-530)/174))^1.2
  local pig={["french-ultramarine"]=0.045*f, ["quinacridone-rose"]=0.022*f, ["burnt-sienna"]=0.004*f}
  local xl,xr=edges(y)
  local b=brush{name="GL"..n, width=30}
  steady(b, {{-15,y+(math.random()-0.5)*4},{xl-4,y+(math.random()-0.5)*3}}, 25, 5, pig, {speed=5000})
  local b2=brush{name="GR"..n, width=30}
  steady(b2, {{1071,y+(math.random()-0.5)*4},{xr+4,y+(math.random()-0.5)*3}}, 25, 5, pig, {speed=5000})
  n=n+1
end
wait(8); print(balance().dry)

math.randomseed(1001)
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
local ch={{430,580,640},{445,545,602},{460,520,585},{480,538,622},{500,578,682},{530,598,732},{560,558,742},{600,468,702},{640,378,662},{680,298,642},{720,240,640}}
local function edges(y)
  for i=1,#ch-1 do local a,b=ch[i],ch[i+1]
    if y>=a[1] and y<=b[1] then local t=(y-a[1])/(b[1]-a[1]); return a[2]+(b[2]-a[2])*t, a[3]+(b[3]-a[3])*t end end
  return ch[#ch][2], ch[#ch][3]
end
-- left mid bank, top profile hand drawn
local prof={{-15,497},{40,493},{95,499},{150,495},{205,490},{262,496},{318,494},{372,501},{430,499},{490,505},{545,512}}
local mix={["burnt-umber"]=0.035, ["french-ultramarine"]=0.03, ["quinacridone-rose"]=0.016, ["burnt-sienna"]=0.008}
local b=brush{name="MB_edge", width=10}
steady(b, prof, 8, 2, mix, {speed=4000})
local function profy(x) for i=1,#prof-1 do local a,c=prof[i],prof[i+1]; if x>=a[1] and x<=c[1] then return a[2]+(c[2]-a[2])*(x-a[1])/(c[1]-a[1]) end end return 520 end
local n=0
for y=503,562,10 do
  local f=1-math.max(0,(y-530)/40)
  local pig={}; for k,v in pairs(mix) do pig[k]=v*(0.35+0.65*f) end
  local xl=edges(y)
  -- left end clipped to where profile is above y
  local x1 = math.min(xl-3, 545)
  local rb=brush{name="MB_row"..n, width=24}; n=n+1
  steady(rb, {{-15,y+(math.random()-0.5)*3},{x1,y+(math.random()-0.5)*3}}, 25, 4.5, pig, {speed=5000})
end
wait(8); print(balance().dry)

math.randomseed(1002)
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
local ch={{430,580,640},{445,545,602},{460,520,585},{480,538,622},{500,578,682},{530,598,732},{560,558,742},{600,468,702},{640,378,662},{680,298,642},{720,240,640}}
local function edges(y)
  for i=1,#ch-1 do local a,b=ch[i],ch[i+1]
    if y>=a[1] and y<=b[1] then local t=(y-a[1])/(b[1]-a[1]); return a[2]+(b[2]-a[2])*t, a[3]+(b[3]-a[3])*t end end
  return ch[#ch][2], ch[#ch][3]
end
local prof={{1071,476},{1020,481},{965,478},{915,486},{860,484},{800,492},{745,497},{700,500}}
local mix={["burnt-umber"]=0.03, ["french-ultramarine"]=0.028, ["quinacridone-rose"]=0.015, ["burnt-sienna"]=0.006}
local b=brush{name="RB_edge", width=10}
steady(b, prof, 8, 2, mix, {speed=4000})
local n=0
for y=483,548,10 do
  local f=1-math.max(0,(y-510)/40)
  local pig={}; for k,v in pairs(mix) do pig[k]=v*(0.35+0.65*f) end
  local _,xr=edges(y)
  local x0 = 700
  for i=1,#prof do if prof[i][2] >= y-3 then x0=prof[i][1]; break end end
  x0 = math.max(x0, xr+3)
  local rb=brush{name="RB_row"..n, width=24}; n=n+1
  steady(rb, {{1071,y+(math.random()-0.5)*3},{x0,y+(math.random()-0.5)*3}}, 25, 4.5, pig, {speed=5000})
end
wait(8); print(balance().dry)

math.randomseed(1101)
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
local gl={["quinacridone-rose"]=0.03, ["french-ultramarine"]=0.012}
local c=0
local function g(x0,x1,y,w)
  c=c+1; local b=brush{name="PG"..c, width=w}
  steady(b, {{x0,y,0.2},{x0+(x1-x0)*0.15,y,0.5},{x1-(x1-x0)*0.15,y,0.5},{x1,y,0.2}}, 12, 2.2, gl, {speed=4000})
end
-- left pool 1
g(60,270,599,10); g(50,280,609,10)
-- left pool 2
g(140,345,652,12); g(120,355,664,12); g(130,350,676,12)
-- right pool 1
g(780,975,610,10); g(770,985,620,10)
-- right pool 2
g(870,1060,666,12); g(860,1066,678,12); g(870,1066,690,12)
wait(8); print(balance().dry)

math.randomseed(1201)
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
local ch={{430,580,640},{445,545,602},{460,520,585},{480,538,622},{500,578,682},{530,598,732},{560,558,742},{600,468,702},{640,378,662},{680,298,642},{720,240,640}}
local function edges(y)
  for i=1,#ch-1 do local a,b=ch[i],ch[i+1]
    if y>=a[1] and y<=b[1] then local t=(y-a[1])/(b[1]-a[1]); return a[2]+(b[2]-a[2])*t, a[3]+(b[3]-a[3])*t end end
  return ch[#ch][2], ch[#ch][3]
end
-- reflection of post at x=296
local dark={["sepia"]=0.12, ["french-ultramarine"]=0.12, ["quinacridone-rose"]=0.02}
local r=brush{name="postrefl", width=6}
steady(r, {{298,648,0.5},{296,656,0.45},{300,664,0.4},{297,672,0.3},{301,680,0.15}}, 4, 0.9, dark, {speed=2000})
-- channel ripples: dark-blue thin lines and pale lines
local blue={["french-ultramarine"]=0.06, ["cerulean-blue"]=0.03, ["quinacridone-rose"]=0.01}
local pale={["buff-titanium"]=0.35, ["naples-yellow"]=0.12, ["quinacridone-rose"]=0.02}
local c=0
for y=560,700,9+math.floor(math.random()*6) do
  local xl,xr=edges(y)
  local w=xr-xl
  local ny = 1 + math.floor(math.random()*2)
  for k=1,ny do
    c=c+1
    local a=xl+w*(0.08+math.random()*0.5)
    local L=w*(0.12+math.random()*0.25)*(0.6+0.6*(y-560)/140)
    local mix = (math.random()<0.6) and blue or pale
    local bw = math.max(2, math.floor(2+ (y-560)/50))
    local b=brush{name="rip"..c, width=bw}
    steady(b, {{a,y,0.15},{a+L*0.4,y+0.5,0.5},{a+L,y,0.1}}, 6, 0.9, mix, {speed=3000})
  end
end
wait(8); print(balance().dry)

math.randomseed(1301)
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
local mix={["burnt-umber"]=0.03, ["french-ultramarine"]=0.026, ["quinacridone-rose"]=0.014, ["burnt-sienna"]=0.007}
-- bank nose: rounded end from x 546 toward the channel, its top following the bank edge down
local rows={{512,546,566},{520,546,578},{528,546,586},{536,546,590},{544,546,586},{552,546,575}}
for i,r in ipairs(rows) do
  local b=brush{name="nose"..i, width=11}
  steady(b, {{r[2],r[1],0.5},{(r[2]+r[3])/2,r[1]+1,0.45},{r[3],r[1]+2,0.15}}, 8, 1.6, mix, {speed=4000})
end
wait(8); print(balance().dry)

math.randomseed(1401)
local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
local grass={["sap-green"]=0.05, ["burnt-umber"]=0.06, ["french-ultramarine"]=0.04, ["quinacridone-rose"]=0.01}
local prof={{-15,497},{40,493},{95,499},{150,495},{205,490},{262,496},{318,494},{372,501},{430,499},{490,505},{545,512}}
local function profy(x) for i=1,#prof-1 do local a,c=prof[i],prof[i+1]; if x>=a[1] and x<=c[1] then return a[2]+(c[2]-a[2])*(x-a[1])/(c[1]-a[1]) end end return 512 end
local b=brush{name="grassT", width=3}
local x=2
while x<90 do
  local y=profy(x)+2
  local h=4+math.random()*9
  local lean=(math.random()-0.4)*4
  topup(b, 0.5, grass)
  b:stroke({{x,y+3,0.5},{x+lean,y-h,0.05}}, {duration=0.02})
  x=x+1.5+math.random()*3
end
wait(5)

math.randomseed(1402)
local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
local grass={["sap-green"]=0.15, ["burnt-umber"]=0.15, ["french-ultramarine"]=0.10, ["quinacridone-rose"]=0.02}
local prof={{-15,497},{40,493},{95,499},{150,495},{205,490},{262,496},{318,494},{372,501},{430,499},{490,505},{545,512}}
local function profy(x) for i=1,#prof-1 do local a,c=prof[i],prof[i+1]; if x>=a[1] and x<=c[1] then return a[2]+(c[2]-a[2])*(x-a[1])/(c[1]-a[1]) end end return 512 end
local b=brush{name="grassT2", width=4}
local x=95
while x<200 do
  local y=profy(x)+2
  local h=5+math.random()*12
  local lean=(math.random()-0.4)*5
  topup(b, 1.0, grass)
  b:stroke({{x,y+4,0.6},{x+lean*0.5,y-h*0.5,0.4},{x+lean,y-h,0.05}}, {duration=0.03})
  x=x+1.5+math.random()*3
end
wait(5)

math.randomseed(1403)
local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
local grass={["sap-green"]=0.18, ["burnt-umber"]=0.2, ["french-ultramarine"]=0.12, ["quinacridone-rose"]=0.03}
local lprof={{-15,497},{40,493},{95,499},{150,495},{205,490},{262,496},{318,494},{372,501},{430,499},{490,505},{545,512}}
local rprof={{700,500},{745,497},{800,492},{860,484},{915,486},{965,478},{1020,481},{1071,476}}
local function py(prof,x) for i=1,#prof-1 do local a,c=prof[i],prof[i+1]; if x>=a[1] and x<=c[1] then return a[2]+(c[2]-a[2])*(x-a[1])/(c[1]-a[1]) end end return nil end
local b=brush{name="grassT3", width=4}
local function clump(prof, cx, span, n, hmax)
  for i=1,n do
    local x=cx+(math.random()-0.5)*span
    local y=py(prof,x); if y then
      y=y+2
      local h=(0.4+0.6*math.random())*hmax*(1-math.abs(x-cx)/span)
      local lean=(math.random()-0.45)*6
      topup(b, 1.0, grass)
      b:stroke({{x,y+4,0.6},{x+lean*0.5,y-h*0.5,0.4},{x+lean,y-h,0.05}}, {duration=0.03})
    end
  end
end
clump(lprof, 20, 50, 14, 12)
clump(lprof, 255, 70, 18, 16)
clump(lprof, 340, 40, 10, 11)
clump(lprof, 470, 50, 12, 10)
clump(rprof, 730, 40, 10, 10)
clump(rprof, 945, 90, 22, 18)
clump(rprof, 1040, 50, 14, 14)
wait(5)

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
local dark={["sepia"]=0.15, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02}
-- mooring rope from the bow (~750,514) sagging to a stake near the channel edge (~722,560)
local r=brush{name="rope", width=2}
steady(r, {{752,516,0.35},{745,530,0.35},{737,546,0.35},{728,556,0.3},{722,560,0.25}}, 4, 0.5, dark, {speed=2000})
-- stake
local s=brush{name="stake", width=4}
steady(s, {{721,566,0.6},{720,548,0.45}}, 4, 0.8, dark, {speed=2000})
steady(s, {{714,567,0.2},{722,568,0.5},{730,567,0.1}}, 4, 0.6, dark, {speed=2000})
wait(5)

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
local dark={["sepia"]=0.35, ["french-ultramarine"]=0.25, ["quinacridone-rose"]=0.04}
local r=brush{name="rope2", width=2}
steady(r, {{752,517,0.45},{745,531,0.45},{737,546,0.45},{728,556,0.4},{722,550,0.35}}, 3, 0.4, dark, {speed=2000})
local s=brush{name="stake2", width=5}
steady(s, {{721,567,0.6},{720,546,0.5}}, 3, 0.7, dark, {speed=2000})
wait(5)

local function topup(b, water, pigs)
  local s=b:status(); local p={}
  for k,v in pairs(pigs) do p[k]=math.max(0, v-((s.pigments or {})[k] or 0)) end
  b:load{water=math.max(0, water-s.water), pigments=p}
end
local dark={["sepia"]=0.25, ["french-ultramarine"]=0.2, ["quinacridone-rose"]=0.04}
local b=brush{name="gull", width=2}
local function gull(x,y,s,tilt)
  topup(b, 0.4, dark)
  b:stroke({{x-s, y-s*0.25+tilt, 0.15},{x-s*0.5, y-s*0.45+tilt*0.5, 0.4},{x, y, 0.55},{x+s*0.45, y-s*0.5-tilt*0.5, 0.4},{x+s, y-s*0.2-tilt, 0.12}}, {duration=0.05})
end
gull(452, 238, 9, 1)
gull(481, 228, 7, -1)
gull(506, 247, 6, 0.5)
gull(395, 258, 5, -0.5)
wait(4)

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
local warm={["quinacridone-rose"]=0.06, ["pyrrol-scarlet"]=0.03, ["naples-yellow"]=0.08, ["burnt-sienna"]=0.02}
local b=brush{name="poolwarmT", width=12}
steady(b, {{-10,686,0.4},{90,687,0.2}}, 10, 2.2, warm, {speed=4000})
steady(b, {{-10,696,0.4},{90,697,0.2}}, 10, 2.2, warm, {speed=4000})
wait(6)

math.randomseed(1501)
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
local mix={["french-ultramarine"]=0.02, ["quinacridone-rose"]=0.018, ["naples-yellow"]=0.01}
local rows={{372,470},{382,420},{392,330},{401,250},{409,150}}
for i,r in ipairs(rows) do
  local b=brush{name="hlrefl"..i, width=12}
  local L=r[2]
  steady(b, {{-12,r[1],0.5},{L*0.7,r[1]+(math.random()-0.5)*2,0.45},{L,r[1]+1,0.1}}, 20, 3, mix, {speed=5000})
end
wait(6)

wait(3); local s=balance(); print(s.dry, clock())