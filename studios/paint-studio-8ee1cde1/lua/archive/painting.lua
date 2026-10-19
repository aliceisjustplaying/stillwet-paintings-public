--@ watercolor-engine 2

paper{width=1100, height=650, kind="cold-press", seed=4127}
print(table.concat(palette(), ", "))


for y=25,300,80 do for x=30,1100,105 do drop{x=x,y=y,water=13,radius=72} end end
local b = brush{name="sky", width=60}
b:load{water=6, pigments={["cobalt-blue"]=0.065, ["french-ultramarine"]=0.02, ["paynes-gray"]=0.055, ["burnt-sienna"]=0.01}}
b:wash{x=-20,y=-10,width=640,height=250, grade=0.45, pressure=0.5}
local b2 = brush{name="sky2", width=60}
b2:load{water=6, pigments={["cobalt-blue"]=0.035, ["french-ultramarine"]=0.01, ["paynes-gray"]=0.035, ["burnt-sienna"]=0.008}}
b2:wash{x=600,y=-10,width=520,height=250, grade=0.6, pressure=0.5}
local d = brush{name="streak", width=60}
local function streak(pts, amt)
  d:load{water=4, pigments={["cobalt-blue"]=0.05*amt, ["french-ultramarine"]=0.02*amt, ["paynes-gray"]=0.07*amt}}
  d:stroke(pts, {pressure=0.5, duration=0.2})
end
streak({{-10,25},{150,15},{350,28},{480,12}},1.0)
streak({{-10,105},{120,95},{260,100},{360,90}},0.9)
local h = brush{name="haze", width=60}
h:load{water=6, pigments={["cobalt-blue"]=0.02, ["paynes-gray"]=0.02, ["raw-umber"]=0.012}}
h:wash{x=-20,y=235,width=1140,height=80, pressure=0.5}
local L = brush{name="lift", width=40}
L:load{water=3}
L:lift({{450,120},{560,104},{680,90},{800,78},{940,66}}, {pressure=0.3, duration=0.25})
local C = brush{name="cum", width=16}
local function blob(cx,cy,r,w)
  local pts={}
  for i=0,12 do local a=i/12*2*math.pi*1.3 local rr=r*(0.3+0.7*(i/12)) pts[#pts+1]={cx+rr*math.cos(a), cy+rr*0.7*math.sin(a)} end
  C:load{water=w} C:lift(pts,{duration=0.08})
end
for _,p in ipairs({{625,238,5},{648,232,6},{705,252,7},{725,246,5},{915,286,9},{960,280,11},{1010,292,10},{1060,302,13},{1095,318,12},{985,300,8}}) do blob(p[1],p[2],p[3],1.0) end
for _,p in ipairs({{120,232,10},{165,228,13},{215,226,9},{262,224,15},{318,222,12},{372,224,16},{430,226,10},{478,228,12},{528,234,7}}) do blob(p[1],p[2],p[3],1.0) end
for _,p in ipairs({{148,214,8},{196,206,11},{240,210,7},{290,200,12},{338,190,9},{362,182,13},{400,198,8},{455,210,9},{505,214,6}}) do blob(p[1],p[2],p[3],0.8) end
wait(25) print(balance().dry)



local function ridgefill(br, ridge, bottom, step, mix, fac, dur)
  local miny=1e9 for _,p in ipairs(ridge) do miny=math.min(miny,p[2]) end
  local n = math.ceil((bottom - miny) / step)
  for k=0,n do
    local pts={}
    for _,p in ipairs(ridge) do
      local y=p[2]+k*step
      if y<=bottom then pts[#pts+1]={p[1], y} end
    end
    if #pts>=2 then
      if k%2==1 then local r={} for i=#pts,1,-1 do r[#r+1]=pts[i] end pts=r end
      local f = fac * (1 - 0.6*k/math.max(n,1))
      local pig={} for kk,v in pairs(mix) do pig[kk]=v*f end
      br:load{water=2.0, pigments=pig}
      br:stroke(pts,{pressure=0.5, duration=dur or 0.2})
    end
  end
end
local mix={["paynes-gray"]=0.05, ["french-ultramarine"]=0.03, ["cobalt-blue"]=0.02, ["burnt-sienna"]=0.008}
local m = brush{name="mtn", width=20}
ridgefill(m, {{-10,284},{60,277},{130,271},{200,267},{260,269},{320,275},{380,283}}, 300, 7, mix, 0.45)
ridgefill(m, {{360,284},{400,279},{430,273},{455,267},{480,262},{510,257},{535,261},{560,265},{580,258},{605,251},{625,256},{650,263},{680,272},{710,282},{740,290}}, 306, 7, mix, 0.9)
ridgefill(m, {{720,288},{770,282},{820,279},{870,283},{900,286}}, 300, 7, mix, 0.45)
wait(10)
print(balance().dry)



for x=40,1100,100 do drop{x=x,y=275,water=4,radius=50} drop{x=x,y=325,water=4,radius=50} end
local v = brush{name="veil", width=40}
v:load{water=4, pigments={["buff-titanium"]=0.12, ["cobalt-blue"]=0.006, ["paynes-gray"]=0.004}}
v:wash{x=-20,y=250,width=1140,height=40, pressure=0.5}
local v2 = brush{name="veil2", width=40}
v2:load{water=4, pigments={["buff-titanium"]=0.3, ["cobalt-blue"]=0.012, ["paynes-gray"]=0.008}}
v2:wash{x=-20,y=285,width=1140,height=55, pressure=0.5}
wait(12) print(balance().dry)



for y=320,530,70 do for x=30,1100,105 do drop{x=x,y=y,water=10,radius=70} end end
local a = brush{name="land1", width=50}
a:load{water=5, pigments={["sap-green"]=0.035, ["yellow-ochre"]=0.03, ["cobalt-blue"]=0.02, ["buff-titanium"]=0.05}}
a:wash{x=-20,y=305,width=1140,height=55, pressure=0.5}
local g = brush{name="land2", width=50}
g:load{water=5, pigments={["sap-green"]=0.09, ["hansa-yellow"]=0.05, ["cobalt-blue"]=0.012}}
g:wash{x=-20,y=355,width=1140,height=125, pressure=0.5, grade=1}
-- right lower grass extension
local function row(y, x0, x1) g:load{water=4, pigments={["sap-green"]=0.08, ["hansa-yellow"]=0.06}} g:stroke({{x0,y},{x1,y}},{pressure=0.5,duration=0.25}) end
row(490, 440, 1120)
row(515, 620, 1120)
row(538, 800, 1120)
row(560, 960, 1120)
wait(15) print(balance().dry)



-- 1. soften the dark mountain's ends and base with an opaque gray veil
local v = brush{name="mveil", width=36}
local vm = {["buff-titanium"]=1.2, ["paynes-gray"]=0.05, ["french-ultramarine"]=0.05, ["quinacridone-rose"]=0.02}
v:load{water=4, pigments=vm}
v:stroke({{345,300},{360,290},{372,282}},{pressure=0.55,duration=0.15})
v:load{water=4, pigments=vm}
v:stroke({{860,300},{880,292},{905,286},{930,290}},{pressure=0.6,duration=0.15})
v:load{water=4, pigments=vm}
v:stroke({{350,306},{500,308},{650,306},{800,305},{920,304}},{pressure=0.45,duration=0.25})
wait(8)
-- 2. cool haze glaze over lower sky + far land, soft top
for x=30,1100,90 do drop{x=x,y=225,water=4,radius=32} end
local h = brush{name="haze2", width=50}
local function row(y, f)
  h:load{water=4, pigments={["paynes-gray"]=0.025*f, ["french-ultramarine"]=0.02*f, ["quinacridone-rose"]=0.01*f, ["cobalt-blue"]=0.01*f}}
  h:wash{x=-20,y=y,width=1140,height=30, pressure=0.5}
end
row(225,0.5) row(250,0.8) 
-- skip over mountains region with weaker load
row(275,0.6) row(300,0.9) row(325,1.0) row(345,0.9)
wait(15) print(balance().dry)



for x=40,1100,80 do drop{x=x,y=215,water=3,radius=28} drop{x=x,y=270,water=3,radius=30} drop{x=x,y=320,water=3,radius=30} end
local v1 = brush{name="veilA", width=40}
v1:load{water=4, pigments={["buff-titanium"]=1.0, ["cerulean-blue"]=0.05, ["french-ultramarine"]=0.06, ["quinacridone-rose"]=0.012, ["paynes-gray"]=0.01}}
v1:wash{x=-20,y=200,width=1140,height=55, pressure=0.5}
local v2 = brush{name="veilB", width=40}
v2:load{water=4, pigments={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}}
v2:wash{x=-20,y=250,width=1140,height=85, pressure=0.5}
wait(15) print(balance().dry)



local function ridgefill(br, ridge, depth, step, mix, fac, decay, water)
  local n = math.ceil(depth/step)
  for k=0,n do
    local pts={}
    for _,p in ipairs(ridge) do pts[#pts+1]={p[1], p[2]+k*step} end
    if k%2==1 then local r={} for i=#pts,1,-1 do r[#r+1]=pts[i] end pts=r end
    local f = fac * (1 - decay*k/math.max(n,1))
    local pig={} for kk,v in pairs(mix) do pig[kk]=v*f end
    br:load{water=water or 1.8, pigments=pig}
    br:stroke(pts,{pressure=0.5, duration=0.12})
  end
end
local mix={["paynes-gray"]=0.08, ["french-ultramarine"]=0.03, ["burnt-sienna"]=0.01, ["quinacridone-rose"]=0.008}
local far={{-10,124},{60,118},{130,113},{200,119},{260,125},{330,121},{400,115},{450,111},{500,117},{560,123},{620,119},{680,115},{740,121},{800,127},{860,123},{920,117},{980,114},{1040,100},{1110,92}}
local w=brush{name="wat", width=24}
ridgefill(w, far, 45, 12, {}, 0, 0, 3)
local m=brush{name="rf", width=18}
ridgefill(m, far, 40, 8, mix, 0.6, 0.9)
wait(12)
local cen={{290,180},{350,162},{400,146},{440,133},{470,127},{500,131},{530,124},{560,133},{600,148},{650,165},{700,180},{740,190}}
local rgt={{760,175},{800,160},{840,153},{880,160},{930,174},{980,184},{1020,190}}
ridgefill(w, cen, 70, 12, {}, 0, 0, 3)
ridgefill(m, cen, 60, 8, mix, 1.1, 0.95)
ridgefill(w, rgt, 40, 12, {}, 0, 0, 3)
ridgefill(m, rgt, 32, 8, mix, 0.8, 0.95)
wait(12) print(balance().dry)



local base={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}
local w=brush{name="wat2", width=26}
local b=brush{name="mist", width=22}
local function wavy(x0,x1,y,amp,seed)
  local pts={} local n=10
  for i=0,n do local x=x0+(x1-x0)*i/n pts[#pts+1]={x, y+amp*math.sin(i*1.7+seed)} end
  return pts
end
local rows={}
for y=192,270,9 do rows[#rows+1]=y end
for i,y in ipairs(rows) do w:load{water=2.5} w:stroke(wavy(270,1050,y,4,i),{pressure=0.5,duration=0.1}) end
for i,y in ipairs(rows) do
  local f = 0.1 + 0.8*(i-1)/(#rows-1)
  local pig={} for k,v in pairs(base) do pig[k]=v*f end
  b:load{water=2.2, pigments=pig}
  b:stroke(wavy(270,1050,y,4,i*2),{pressure=0.5,duration=0.12})
end
wait(15) print(balance().dry)



local function mtn(br, ridge, bottom, step, mix, fac, decay)
  local miny=1e9 for _,p in ipairs(ridge) do miny=math.min(miny,p[2]) end
  local n = math.ceil((bottom-miny)/step)
  for k=0,n do
    local pts={}
    for _,p in ipairs(ridge) do local y=p[2]+k*step if y<=bottom then pts[#pts+1]={p[1], y} end end
    if #pts>=2 then
      if k%2==1 then local r={} for i=#pts,1,-1 do r[#r+1]=pts[i] end pts=r end
      local f = fac * (1 - decay*k/math.max(n,1))
      local pig={} for kk,v in pairs(mix) do pig[kk]=v*f end
      br:load{water=2.2, pigments=pig}
      br:stroke(pts,{pressure=0.5, duration=0.1})
    end
  end
end
local light={["paynes-gray"]=0.3, ["french-ultramarine"]=0.12, ["quinacridone-rose"]=0.03, ["buff-titanium"]=0.4}
local dark={["paynes-gray"]=0.35, ["french-ultramarine"]=0.15, ["burnt-sienna"]=0.04, ["buff-titanium"]=0.3}
local b=brush{name="mtnA", width=20}
-- left low hills, lighter
mtn(b, {{-15,150},{40,146},{100,141},{160,145},{220,152},{280,160},{330,168}}, 240, 7, light, 0.55, 0.6)
-- main massif
local b2=brush{name="mtnB", width=20}
mtn(b2, {{240,180},{300,166},{350,154},{400,140},{440,128},{470,120},{495,124},{520,130},{545,124},{565,119},{590,128},{620,141},{660,152},{700,160},{740,166},{770,168}}, 268, 7, dark, 1.0, 0.55)
-- right group
mtn(b2, {{760,170},{800,160},{840,151},{870,146},{900,150},{940,157},{980,165},{1020,174},{1060,180},{1115,186}}, 262, 7, light, 0.85, 0.55)
wait(15) print(balance().dry)



local base={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}
local w=brush{name="wat3", width=26}
local b=brush{name="mist2", width=22}
local function wavy(x0,x1,y,amp,seed)
  local pts={} local n=16
  for i=0,n do local x=x0+(x1-x0)*i/n pts[#pts+1]={x, y+amp*math.sin(i*1.3+seed)} end
  return pts
end
local rows={}
for y=196,290,8 do rows[#rows+1]=y end
-- two halves to keep strokes short in time
for _,seg in ipairs({{-15,560},{540,1115}}) do
  for i,y in ipairs(rows) do w:load{water=2.0} w:stroke(wavy(seg[1],seg[2],y,5,i),{pressure=0.5,duration=0.1}) end
  for i,y in ipairs(rows) do
    local f = 0.08 + 0.95*((i-1)/(#rows-1))^0.8
    local pig={} for k,v in pairs(base) do pig[k]=v*f end
    b:load{water=2.2, pigments=pig}
    b:stroke(wavy(seg[1],seg[2],y,5,i*2.3),{pressure=0.5,duration=0.12})
  end
end
wait(15) print(balance().dry)



local base={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}
local function wavy(x0,x1,y,amp,seed)
  local pts={} local n=8
  for i=0,n do local x=x0+(x1-x0)*i/n pts[#pts+1]={x, y+amp*math.sin(i*1.3+seed)} end
  return pts
end
local rows={}
for y=200,282,8 do rows[#rows+1]=y end
for i,y in ipairs(rows) do
  local b=brush{name="fix"..i, width=22}
  local f = 0.5 + 0.7*((i-1)/(#rows-1))
  local pig={} for k,v in pairs(base) do pig[k]=v*f end
  b:load{water=2.2, pigments=pig}
  b:stroke(wavy(215,560,y,4,i*1.9),{pressure=0.5,duration=0.1})
end
wait(15) print(balance().dry)



math.randomseed(11)
local haze={["hookers-green"]=0.15, ["sap-green"]=0.15, ["buff-titanium"]=0.6, ["cerulean-blue"]=0.05}
local dark={["hookers-green"]=0.5, ["sap-green"]=0.4, ["burnt-sienna"]=0.08, ["hansa-yellow"]=0.08}
local mid={["sap-green"]=0.4, ["hansa-yellow"]=0.1, ["paynes-gray"]=0.05}
local function lerp(a,b,t) local r={} for k,v in pairs(a) do r[k]=(r[k] or 0)+v*(1-t) end for k,v in pairs(b) do r[k]=(r[k] or 0)+v*t end return r end
local bpts={{-20,540},{200,520},{380,482},{450,455},{520,432},{580,425},{650,428},{720,438},{800,445},{900,450},{1000,452},{1120,455}}
local function bottom(x)
  for i=1,#bpts-1 do local a,b=bpts[i],bpts[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end
  return 455
end
local function topup(b, water, pig)
  local s=b:status() local need={} 
  for k,v in pairs(pig) do local have=s.pigments[k] or 0 if v>have then need[k]=v-have end end
  b:load{water=math.max(0,water-s.water), pigments=need}
end
local br=brush{name="forest1", width=16}
local n=0
for y=292,540,8 do
  local x=-20+math.random()*40
  while x<1110 do
    local len=50+math.random()*90
    local bt=bottom(x+len/2)
    if y < bt-4 then
      local t=math.min(1,math.max(0,(y-292)/(bt-292)))
      local c=lerp(haze,dark,t^0.6)
      if math.random()<0.3 then c=lerp(c,mid,0.5) end
      local s=0.85+math.random()*0.3
      for k,v in pairs(c) do c[k]=v*s end
      local yb = math.min(y, bt-6)
      if not (y<310 and math.random()<0.35) then
        -- clear the brush residue so colors don't accumulate
        topup(br, 2.0, c)
        local pts={{x,yb+math.random()*4-2},{x+len*0.5,yb+math.random()*5-2.5},{x+len,yb+math.random()*4-2}}
        br:stroke(pts,{pressure=0.45+math.random()*0.15,duration=0.08})
        n=n+1
      end
    end
    x=x+len*(0.85+math.random()*0.3)
  end
end
print(n)
wait(15) print(balance().dry)



math.randomseed(23)
local base={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}
local function wavy(x0,x1,y,amp,seed,n)
  local pts={} n=n or 10
  for i=0,n do local x=x0+(x1-x0)*i/n pts[#pts+1]={x, y+amp*math.sin(i*1.3+seed)+math.random()*3} end
  return pts
end
local function sc(m,f) local r={} for k,v in pairs(m) do r[k]=v*f end return r end
-- 1. mist over forest top, graded downwards (strong at top)
local ys={} for y=280,330,8 do ys[#ys+1]=y end
for _,seg in ipairs({{-15,560},{540,1115}}) do
  for i,y in ipairs(ys) do local w=brush{name="mw"..seg[1].."_"..i, width=24} w:load{water=2.0} w:stroke(wavy(seg[1],seg[2],y,4,i),{pressure=0.5,duration=0.1}) end
  for i,y in ipairs(ys) do
    local f = 0.75*(1-(i-1)/(#ys))^1.3 + 0.05
    local b=brush{name="mf"..seg[1].."_"..i, width=22}
    b:load{water=2.2, pigments=sc(base,f)}
    b:stroke(wavy(seg[1],seg[2],y,4,i*2.1),{pressure=0.5,duration=0.12})
  end
end
wait(15)
print(balance().dry)



math.randomseed(31)
local function sc(m,f) local r={} for k,v in pairs(m) do r[k]=v*f end return r end
local function fill(name, rows, width, water, mix, dur)
  for i,pts in ipairs(rows) do local b=brush{name=name..i, width=width} b:load{water=water, pigments=mix} b:stroke(pts,{pressure=0.5,duration=dur or 0.1}) end
end
-- 3. lower blue hills in front of the massif (left-centre)
local hill={["paynes-gray"]=0.18, ["french-ultramarine"]=0.08, ["quinacridone-rose"]=0.02, ["buff-titanium"]=0.9, ["cerulean-blue"]=0.05}
local ridge={{330,262},{370,250},{410,240},{440,236},{470,242},{500,250},{530,246},{560,252},{600,262},{640,270}}
local rows={}
for k=0,5 do local pts={} for _,p in ipairs(ridge) do local y=p[2]+k*7 if y<285 then pts[#pts+1]={p[1],y} else pts[#pts+1]={p[1],285} end end rows[#rows+1]=pts end
fill("hill", rows, 18, 2.0, hill)
wait(4)
-- 1. lake on the right
local lake={["buff-titanium"]=1.0, ["cerulean-blue"]=0.15, ["paynes-gray"]=0.06, ["french-ultramarine"]=0.04}
local lrows={}
local lk={{690,284,830},{680,291,845},{676,298,850},{686,305,838},{710,311,815}}
for _,r in ipairs(lk) do lrows[#lrows+1]={{r[1],r[2]},{(r[1]+r[3])/2,r[2]+1},{r[3],r[2]}} end
fill("lake", lrows, 9, 1.2, lake)
-- shore darker line under lake
fill("shore", {{{680,316},{760,318},{850,313},{900,310}}}, 6, 0.8, {["paynes-gray"]=0.1,["sap-green"]=0.08,["buff-titanium"]=0.3})
wait(4)
-- 2. meadow: bright pale green band across centre
local mead={["buff-titanium"]=0.8, ["sap-green"]=0.15, ["hansa-yellow"]=0.1, ["cerulean-blue"]=0.03}
local mrows={}
local m = {{380,318,560},{360,326,700},{400,334,860},{480,341,1000},{600,348,1040},{760,354,1060}}
for _,r in ipairs(m) do
  local pts={} for i=0,6 do local x=r[1]+(r[3]-r[1])*i/6 pts[#pts+1]={x, r[2]+math.sin(i*1.7+r[1])*2} end
  mrows[#mrows+1]=pts
end
fill("mead", mrows, 12, 1.6, mead, 0.12)
wait(15) print(balance().dry)



math.randomseed(77)
local tb={{-20,458},{60,462},{130,466},{200,472},{260,478},{330,486},{400,494},{460,498},{520,502},{600,508},{680,514},{740,520},{800,530},{880,545},{960,562},{1030,580},{1120,596}}
local function topB(x) for i=1,#tb-1 do local a,b=tb[i],tb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 600 end
local mA={["indian-red"]=1.1, ["burnt-umber"]=0.55, ["buff-titanium"]=0.4, ["paynes-gray"]=0.03}
local mB={["indian-red"]=0.4, ["raw-umber"]=0.3, ["burnt-sienna"]=0.15, ["buff-titanium"]=0.7}
local mC={["indian-red"]=0.6, ["burnt-umber"]=0.5, ["paynes-gray"]=0.08}
local mixes={mA,mB,mC,mA}
local n=0
for y=462,665,15 do
  local x=-20-math.random()*60
  local depth=(y-460)/190
  while x<1110 and n<220 do
    local len=100+math.random()*120
    local x1=math.min(x+len,1125)
    local pts={}
    for i=0,6 do local xx=x+(x1-x)*i/6 local yy=y+math.random()*6-3+(xx-500)*0.03 local t=topB(xx) if yy<t+3 then yy=t+3+math.random()*4 end pts[#pts+1]={xx,yy} end
    local b=brush{name="sc"..n, width=28}
    local m
    if depth<0.25 then m = (math.random()<0.6) and mB or mA else m=mixes[math.random(1,4)] end
    local f=(0.75+math.random()*0.4)*(0.85+0.3*depth)
    local pig={} for k,v in pairs(m) do pig[k]=v*f end
    b:load{water=3, pigments=pig}
    b:stroke(pts,{pressure=0.5,duration=0.08})
    n=n+1
    if x1>=1120 then break end
    x=x1-10
  end
end
print(n, clock())
wait(15) print(balance().dry)



math.randomseed(91)
local tb={{-20,458},{60,462},{130,466},{200,472},{260,478},{330,486},{400,494},{460,498},{520,502},{600,508},{680,514},{740,520},{800,530},{880,545},{960,562},{1030,580},{1120,596}}
local function topB(x) for i=1,#tb-1 do local a,b=tb[i],tb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 600 end
-- forest lower edge approx
local fb={{340,470},{470,462},{480,440},{700,432},{800,440},{1120,448}}
local function topF(x) for i=1,#fb-1 do local a,b=fb[i],fb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 450 end
local mid={["sap-green"]=0.35, ["hansa-yellow"]=0.1, ["paynes-gray"]=0.04}
local sun={["sap-green"]=0.2, ["hansa-yellow"]=0.12, ["yellow-ochre"]=0.04}
local olive={["sap-green"]=0.3, ["yellow-ochre"]=0.12, ["burnt-umber"]=0.03}
local n=0
for y=434,600,9 do
  local x=330+math.random()*30
  while x<1115 and n<260 do
    local len=50+math.random()*90
    local x1=math.min(x+len,1125)
    local top=topF((x+x1)/2)
    local bot=topB((x+x1)/2)
    if y>top-2 and y<bot-4 then
      local pts={}
      for i=0,4 do local xx=x+(x1-x)*i/4 local yy=y+math.random()*4-2+(xx-x)*0.06
        yy=math.max(math.min(yy, topB(xx)-4), topF(xx)-2) pts[#pts+1]={xx,yy} end
      local r=math.random()
      local m = (r<0.5) and mid or ((r<0.8) and olive or sun)
      -- right lower area: more sunlit
      local f=0.7+math.random()*0.5
      if y<top+20 then m=mid f=f*1.3 end
      local pig={} for k,v in pairs(m) do pig[k]=v*f end
      local b=brush{name="rg"..n, width=14+math.random()*6}
      b:load{water=2.0, pigments=pig}
      b:stroke(pts,{pressure=0.5,duration=0.07})
      n=n+1
    end
    if x1>=1120 then break end
    x=x1+math.random()*25-5
  end
end
print(n)
wait(15) print(balance().dry)



math.randomseed(13)
local base={["buff-titanium"]=1.5, ["cerulean-blue"]=0.1, ["french-ultramarine"]=0.1, ["quinacridone-rose"]=0.02, ["paynes-gray"]=0.02}
local function sc(m,f) local r={} for k,v in pairs(m) do r[k]=v*f end return r end
local n=0
local function st(pts, width, water, mix, dur)
  n=n+1 local b=brush{name="mv"..n, width=width} b:load{water=water, pigments=mix} b:stroke(pts,{pressure=0.5,duration=dur or 0.08})
end
-- hill ends: fade into mist
st({{300,262},{330,250},{360,248}},26,2.2,sc(base,0.9))
st({{300,282},{340,272},{380,270}},26,2.2,sc(base,1.0))
st({{600,262},{630,262},{660,268}},24,2.2,sc(base,0.9))
st({{560,284},{610,282},{660,284}},24,2.2,sc(base,1.0))
-- hill bottom mist
st({{330,292},{420,290},{520,292},{640,290}},22,2.4,sc(base,0.8),0.12)
-- lake: silvery
local silver={["buff-titanium"]=2.0, ["cerulean-blue"]=0.08, ["paynes-gray"]=0.025, ["french-ultramarine"]=0.02}
st({{690,288},{760,287},{835,288}},10,1.2,silver)
st({{684,298},{760,298},{845,298}},10,1.2,silver)
st({{690,308},{760,309},{835,307}},10,1.2,silver)
wait(12) print(balance().dry)



local silver={["buff-titanium"]=1.6, ["cerulean-blue"]=0.07, ["paynes-gray"]=0.025, ["french-ultramarine"]=0.02}
local n=0
local function st(pts, width, water, mix)
  n=n+1 local b=brush{name="lk2_"..n, width=width} b:load{water=water, pigments=mix} b:stroke(pts,{pressure=0.5,duration=0.06})
end
st({{684,293},{760,292},{842,293}},10,1.2,silver)
st({{684,303},{760,303},{845,303}},10,1.2,silver)
st({{700,283},{760,282},{825,284}},8,1.0,silver)
st({{705,314},{760,315},{825,313}},8,1.0,silver)
wait(10) print(balance().dry)



math.randomseed(41)
local shadow={["hookers-green"]=0.45, ["paynes-gray"]=0.15, ["burnt-sienna"]=0.04}
local lit={["sap-green"]=0.35, ["hansa-yellow"]=0.15, ["buff-titanium"]=0.3}
local n=0
local function st(pts, width, water, mix, dur)
  n=n+1 local b=brush{name="fr"..n, width=width} b:load{water=water, pigments=mix} b:stroke(pts,{pressure=0.5,duration=dur or 0.08})
end
local function curve(x0,y0,x1,y1,bulge)
  local pts={} for i=0,8 do local t=i/8 pts[#pts+1]={x0+(x1-x0)*t, y0+(y1-y0)*t - bulge*math.sin(math.pi*t) + math.random()*3} end return pts
end
-- ridge lines across forest, sloping
local ridges={{-10,372,260,360,8},{180,392,520,378,10},{420,368,760,360,6},{620,396,980,385,9},{850,370,1110,362,6},{40,410,330,400,6},{700,415,1000,410,5}}
for _,r in ipairs(ridges) do
  st(curve(r[1],r[2]-8,r[3],r[4]-8,r[5]),10,1.5,lit)
  st(curve(r[1],r[2]+2,r[3],r[4]+2,r[5]),12,1.8,shadow)
end
wait(12) print(balance().dry)



math.randomseed(57)
local mixes={
 {["hookers-green"]=0.3, ["sap-green"]=0.2, ["paynes-gray"]=0.05},
 {["hookers-green"]=0.2, ["sap-green"]=0.25, ["burnt-sienna"]=0.03},
 {["sap-green"]=0.3, ["paynes-gray"]=0.1},
 {["sap-green"]=0.3, ["hansa-yellow"]=0.12, ["buff-titanium"]=0.35},
 {["sap-green"]=0.25, ["yellow-ochre"]=0.1, ["buff-titanium"]=0.3},
}
local fb={{-20,452},{340,470},{470,462},{480,440},{700,432},{800,440},{1120,448}}
local function botF(x) for i=1,#fb-1 do local a,b=fb[i],fb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 450 end
local n=0
for i=1,420 do
  local x=math.random()*1120-10
  local y=338+math.random()*125
  if y < botF(x)-4 then
    local depth=(y-338)/120
    local r=math.random()
    local m = (r<0.62) and mixes[math.random(1,3)] or mixes[math.random(4,5)]
    local f=(0.5+math.random()*0.5)*(0.7+0.5*depth)
    local pig={} for k,v in pairs(m) do pig[k]=v*f end
    local sz=(5+math.random()*7)*(0.7+0.6*depth)
    local len=sz*(1+math.random()*1.5)
    n=n+1 local br=brush{name="fd"..n, width=sz}
    br:load{water=0.4+sz*0.07, pigments=pig}
    br:stroke({{x,y},{x+len*0.5,y-2+math.random()*4},{x+len,y+math.random()*3-1.5}},{pressure=0.5,duration=0.04})
  end
end
print(n)
wait(12) print(balance().dry)


print(clock()) local s=balance() print(s.dry)


local fb={{-20,452},{340,470},{470,462},{480,440},{700,432},{800,440},{1120,448}}
local function botF(x) for i=1,#fb-1 do local a,b=fb[i],fb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 450 end
local gl={["hookers-green"]=0.18, ["sap-green"]=0.18, ["paynes-gray"]=0.03, ["burnt-sienna"]=0.015}
local function row(x0,x1,y,amp,seed)
  local pts={} local n=10
  for i=0,n do local x=x0+(x1-x0)*i/n local yy=y+amp*math.sin(i*1.1+seed) yy=math.min(yy, botF(x)-6) pts[#pts+1]={x,yy} end
  return pts
end
local t0=clock()
local ys={} for y=334,466,8 do ys[#ys+1]=y end
for i,y in ipairs(ys) do local w=brush{name="gwA"..i, width=18} w:load{water=1.6} w:stroke(row(-15,560,y,3,i),{pressure=0.5,duration=0.08}) end
for i,y in ipairs(ys) do
  local b=brush{name="ggA"..i, width=16}
  local f=0.6+0.5*(i/#ys)
  local pig={} for k,v in pairs(gl) do pig[k]=v*f end
  b:load{water=2.0, pigments=pig}
  b:stroke(row(-15,560,y,3,i*1.7),{pressure=0.5,duration=0.1})
end
print(clock()-t0)
wait(12) print(balance().dry)



local fb={{-20,452},{340,470},{470,462},{480,440},{700,432},{800,440},{1120,448}}
local function botF(x) for i=1,#fb-1 do local a,b=fb[i],fb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 450 end
local gl={["hookers-green"]=0.18, ["sap-green"]=0.18, ["paynes-gray"]=0.03, ["burnt-sienna"]=0.015}
local function row(x0,x1,y,amp,seed)
  local pts={} local n=10
  for i=0,n do local x=x0+(x1-x0)*i/n local yy=y+amp*math.sin(i*1.1+seed) yy=math.min(yy, botF(x)-6) pts[#pts+1]={x,yy} end
  return pts
end
local ys={} for y=342,460,8 do ys[#ys+1]=y end
for i,y in ipairs(ys) do local w=brush{name="gwB"..i, width=18} w:load{water=1.6} w:stroke(row(530,1115,y,3,i),{pressure=0.5,duration=0.08}) end
for i,y in ipairs(ys) do
  local b=brush{name="ggB"..i, width=16}
  local f=0.8+0.5*(i/#ys)
  local pig={} for k,v in pairs(gl) do pig[k]=v*f end
  b:load{water=2.0, pigments=pig}
  b:stroke(row(530,1115,y,3,i*1.7),{pressure=0.5,duration=0.1})
end
wait(12) print(balance().dry)



math.randomseed(101)
local mixes={
 {["hookers-green"]=0.35, ["sap-green"]=0.25, ["paynes-gray"]=0.06, ["burnt-sienna"]=0.02},
 {["hookers-green"]=0.3, ["sap-green"]=0.3, ["burnt-sienna"]=0.04},
}
local n=0
local function dab(x,y,sz,m,f)
  local pig={} for k,v in pairs(m) do pig[k]=v*f end
  local len=sz*(1+math.random()*1.2)
  n=n+1 local br=brush{name="ed"..n, width=sz}
  br:load{water=0.4+sz*0.07, pigments=pig}
  br:stroke({{x,y},{x+len*0.5,y-2+math.random()*4},{x+len,y+math.random()*3-1.5}},{pressure=0.5,duration=0.04})
end
-- vertical edge x~525, y 338-440: gradient of dabs leftward
for i=1,170 do
  local y=338+math.random()*104
  local dx=-(math.random()^1.6)*120
  local x=522+dx-6
  dab(x,y,7+math.random()*7,mixes[math.random(1,2)],0.7+0.5*(1+dx/120))
end
-- top edge of right glaze y~338 from x 525-1100: ragged tree tops
for i=1,110 do
  local x=520+math.random()*590
  local y=336+math.random()*12 - math.random()*6
  dab(x,y,5+math.random()*6,mixes[math.random(1,2)],0.5+math.random()*0.4)
end
print(n)
wait(12) print(balance().dry)



math.randomseed(202)
local mixes={
 {["hookers-green"]=0.35, ["sap-green"]=0.25, ["paynes-gray"]=0.06, ["burnt-sienna"]=0.02},
 {["hookers-green"]=0.3, ["sap-green"]=0.3, ["burnt-sienna"]=0.04},
}
local fb={{-20,452},{340,470},{470,462},{480,440},{700,432},{800,440},{1120,448}}
local function botF(x) for i=1,#fb-1 do local a,b=fb[i],fb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 450 end
local n=0
local function dab(x,y,sz,m,f)
  if y>botF(x)-5 or y<338 then return end
  local pig={} for k,v in pairs(m) do pig[k]=v*f end
  local len=sz*(1+math.random()*1.2)
  n=n+1 local br=brush{name="cl"..n, width=sz}
  br:load{water=0.4+sz*0.07, pigments=pig}
  br:stroke({{x,y},{x+len*0.5,y-2+math.random()*4},{x+len,y+math.random()*3-1.5}},{pressure=0.5,duration=0.04})
end
-- clumps: centre, length along diagonal, slope, count
local clumps={{60,360,180,0.12,70},{230,400,200,0.15,80},{640,395,220,0.12,80},{860,365,200,0.1,60},{960,410,180,0.12,60},{580,425,120,0.1,40},{150,440,160,0.08,50},{350,370,90,0.1,30}}
for _,c in ipairs(clumps) do
  for i=1,c[5] do
    local t=(math.random()-0.5)
    local x=c[1]+t*c[3]
    local y=c[2]+t*c[3]*c[4]+(math.random()-0.5)*22*(1-2*math.abs(t))
    dab(x,y,6+math.random()*7,mixes[math.random(1,2)],0.6+math.random()*0.5)
  end
end
print(n)
wait(12) print(balance().dry)



math.randomseed(303)
local dirt={["indian-red"]=0.35, ["raw-umber"]=0.3, ["burnt-sienna"]=0.1, ["buff-titanium"]=0.5}
local n=0
local function st(pts,w,water,m,dur) n=n+1 local b=brush{name="rd"..n, width=w} b:load{water=water,pigments=m} b:stroke(pts,{pressure=0.5,duration=dur or 0.08}) end
-- path strip on right green: top edge from (700,452) to (1110,478); bottom edge from (700,458) to (1110,520)
for k=0,6 do
  local t=k/6
  local pts={}
  for i=0,8 do local s=i/8 local x=700+410*s local top=452+26*s local bot=458+62*s pts[#pts+1]={x, top+(bot-top)*t+math.random()*3-1.5} end
  st(pts, 6+6*t+4, 1.2+0.8*t, dirt, 0.1)
end
wait(12) print(balance().dry)



math.randomseed(404)
local tb={{-20,458},{60,462},{130,466},{200,472},{260,478},{330,486},{400,494},{460,498},{520,502},{600,508},{680,514},{740,520},{800,530},{880,545},{960,562},{1030,580},{1120,596}}
local function topB(x) for i=1,#tb-1 do local a,b=tb[i],tb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 600 end
local gA={["sap-green"]=0.35, ["hansa-yellow"]=0.08, ["paynes-gray"]=0.06}
local gB={["sap-green"]=0.3, ["yellow-ochre"]=0.12, ["burnt-umber"]=0.04}
local gC={["hookers-green"]=0.25, ["sap-green"]=0.2, ["burnt-sienna"]=0.03}
local ms={gA,gB,gC}
local n=0
local function dab(x,y,sz,m,f)
  local pig={} for k,v in pairs(m) do pig[k]=v*f end
  local len=sz*(1+math.random()*1.5)
  n=n+1 local br=brush{name="gd"..n, width=sz}
  br:load{water=0.4+sz*0.07, pigments=pig}
  br:stroke({{x,y},{x+len*0.5,y-2+math.random()*4},{x+len,y+math.random()*3-1.5}},{pressure=0.5,duration=0.04})
end
-- 1) blunt start of path: green dabs
for i=1,25 do dab(690+math.random()*40, 448+math.random()*16, 6+math.random()*5, ms[math.random(1,3)], 0.7+math.random()*0.4) end
-- 2) path edges broken
for i=1,60 do local s=math.random() local x=700+410*s local top=452+26*s local bot=458+62*s
  local y = (math.random()<0.5) and (top+math.random()*5-3) or (bot+math.random()*6-2)
  dab(x,y,4+math.random()*5, ms[math.random(1,3)], 0.6+math.random()*0.5) end
-- 3) texture over bright green zone
for i=1,220 do
  local x=360+math.random()*760
  local y=436+math.random()*150
  if y < topB(x)-2 then dab(x,y,5+math.random()*8, ms[math.random(1,3)], 0.45+math.random()*0.5) end
end
-- 4) grass fringes over scree top edge
for i=1,140 do
  local x=-10+math.random()*1120
  local y=topB(x)+math.random()*18-4
  dab(x,y,4+math.random()*6, ms[math.random(1,3)], 0.6+math.random()*0.5)
end
print(n)
wait(12) print(balance().dry)



math.randomseed(505)
local tb={{-20,458},{60,462},{130,466},{200,472},{260,478},{330,486},{400,494},{460,498},{520,502},{600,508},{680,514},{740,520},{800,530},{880,545},{960,562},{1030,580},{1120,596}}
local function topB(x) for i=1,#tb-1 do local a,b=tb[i],tb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 600 end
local g1={["paynes-gray"]=0.08, ["burnt-umber"]=0.08}
local g2={["sepia"]=0.12, ["paynes-gray"]=0.04}
local g3={["raw-umber"]=0.12, ["paynes-gray"]=0.05, ["buff-titanium"]=0.3}
local ms={g1,g2,g3}
local n=0
for i=1,130 do
  local x=-20+math.random()*1140
  local y=topB(x)+12+math.random()*(660-topB(x))
  local w=14+math.random()*26
  local len=w*(1.5+math.random()*2.5)
  local f=0.5+math.random()*0.8
  local m=ms[math.random(1,3)]
  local pig={} for k,v in pairs(m) do pig[k]=v*f end
  n=n+1 local b=brush{name="sg"..n, width=w}
  b:load{water=0.8+w*0.06, pigments=pig}
  local sl=0.05+math.random()*0.08
  b:stroke({{x,y},{x+len*0.4,y+len*0.4*sl+math.random()*4-2},{x+len,y+len*sl+math.random()*4-2}},{pressure=0.5,duration=0.05})
end
print(n)
wait(12) print(balance().dry)



math.randomseed(505)
local tb={{-20,458},{60,462},{130,466},{200,472},{260,478},{330,486},{400,494},{460,498},{520,502},{600,508},{680,514},{740,520},{800,530},{880,545},{960,562},{1030,580},{1120,596}}
local function topB(x) for i=1,#tb-1 do local a,b=tb[i],tb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 600 end
local covA={["indian-red"]=1.1, ["burnt-umber"]=0.55, ["buff-titanium"]=0.2}
local covB={["burnt-sienna"]=0.5, ["burnt-umber"]=0.4, ["indian-red"]=0.5}
local n=0 local c=0
for i=1,130 do
  local x=-20+math.random()*1140
  local y=topB(x)+12+math.random()*(660-topB(x))
  local w=14+math.random()*26
  local len=w*(1.5+math.random()*2.5)
  local f=0.5+math.random()*0.8
  local mi=math.random(1,3)
  local sl=0.05+math.random()*0.08
  local r1,r2=math.random()*4-2, math.random()*4-2
  if mi==3 then
    c=c+1
    local b=brush{name="cv"..c, width=w+6}
    local m=(c%2==0) and covA or covB
    b:load{water=1.0+w*0.07, pigments=m}
    b:stroke({{x-2,y},{x+len*0.4,y+len*0.4*sl+r1},{x+len+2,y+len*sl+r2}},{pressure=0.5,duration=0.05})
  end
end
print(c)
wait(12) print(balance().dry)



math.randomseed(606)
local tb={{-20,458},{60,462},{130,466},{200,472},{260,478},{330,486},{400,494},{460,498},{520,502},{600,508},{680,514},{740,520},{800,530},{880,545},{960,562},{1030,580},{1120,596}}
local function topB(x) for i=1,#tb-1 do local a,b=tb[i],tb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 600 end
local dk={["sepia"]=0.35, ["paynes-gray"]=0.25}
local rd={["indian-red"]=0.6, ["burnt-sienna"]=0.3, ["quinacridone-burnt-orange"]=0.05}
local lt={["buff-titanium"]=2.0, ["paynes-gray"]=0.1, ["raw-umber"]=0.05}
local n=0
local function sp(x,y,s,m,water)
  n=n+1 local b=brush{name="sp"..n, width=s} b:load{water=water,pigments=m}
  local a=math.random()*0.6-0.3
  b:stroke({{x,y},{x+s*0.9,y+s*a}},{pressure=0.5,duration=0.03})
end
for i=1,520 do
  local x=-10+math.random()*1120
  local t=topB(x)
  local u=math.random()^0.8
  local y=t+6+u*(655-t)
  local scale=0.6+0.9*(y-460)/190
  local r=math.random()
  if r<0.5 then sp(x,y,(1.5+math.random()*3)*scale,dk,0.25)
  elseif r<0.75 then sp(x,y,(2+math.random()*4)*scale,rd,0.35)
  else sp(x,y,(1.5+math.random()*3)*scale,lt,0.3) end
end
print(n)
wait(10) print(balance().dry)



math.randomseed(707)
local tb={{-20,458},{60,462},{130,466},{200,472},{260,478},{330,486},{400,494},{460,498},{520,502},{600,508},{680,514},{740,520},{800,530},{880,545},{960,562},{1030,580},{1120,596}}
local function topB(x) for i=1,#tb-1 do local a,b=tb[i],tb[i+1] if x>=a[1] and x<=b[1] then return a[2]+(b[2]-a[2])*(x-a[1])/(b[1]-a[1]) end end return 600 end
local dk={["sepia"]=1.0, ["paynes-gray"]=0.6}
local gp={["paynes-gray"]=0.5, ["indian-red"]=0.3,["buff-titanium"]=0.5}
local gl={["buff-titanium"]=0.8, ["paynes-gray"]=0.15, ["raw-umber"]=0.1}
local n=0
local function sp(x,y,s,m,water)
  n=n+1 local b=brush{name="s2_"..n, width=s} b:load{water=water,pigments=m}
  local a=math.random()*0.6-0.3
  b:stroke({{x,y},{x+s*(0.6+math.random()*0.8),y+s*a}},{pressure=0.5,duration=0.03})
end
for i=1,620 do
  local x=-10+math.random()*1120
  local t=topB(x)
  local y=t+5+math.random()*(655-t)
  local scale=0.5+1.0*(y-460)/190
  local r=math.random()
  if r<0.55 then sp(x,y,(2+math.random()*4)*scale,dk,0.15+0.08*scale*3)
  elseif r<0.85 then sp(x,y,(2.5+math.random()*5)*scale,gp,0.2+0.1*scale*3)
  else sp(x,y,(2+math.random()*4)*scale,gl,0.2+0.08*scale*3) end
end
print(n)
wait(10) print(balance().dry)
