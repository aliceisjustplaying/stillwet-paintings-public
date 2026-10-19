--@ watercolor-engine 2

paper{width=1100, height=660, kind="cold-press", seed=2023}
print("ok paper")


function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function inside(poly, x, y)
  for _,sp in ipairs(spans(poly,y)) do if x>=sp[1] and x<=sp[2] then return true end end
  return false
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + dy*0.5
  while y < ymax do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1], sp[2]
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end

local sky = P{{-20,-20},{1412,-20},{1412,470},{1330,450},{1250,480},{1200,470},{1180,380},{1060,325},{940,350},{880,370},{820,350},{680,355},{515,375},{450,420},{430,560},{420,560},{425,330},{0,40},{-20,40}}
-- pre-wet, keeping away from edges
for y=40,280,85 do for x=20,760,95 do
  local ok = inside(sky,x,y) and inside(sky,x+70,y) and inside(sky,x-70,y) and inside(sky,x,y+60)
  if ok then drop{x=x,y=y,water=8,radius=55} end
end end
local b = brush{name="sky", width=50}
fill(b, sky, 28, 70, function(y,x)
  local t = math.max(0, math.min(1, y/300))
  local k = (1-t)
  return 5, {["french-ultramarine"]=0.06+0.17*k, ["cobalt-blue"]=0.05+0.08*k, ["cerulean-blue"]=0.03+0.03*k}
end)
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function inside(poly, x, y)
  for _,sp in ipairs(spans(poly,y)) do if x>=sp[1] and x<=sp[2] then return true end end
  return false
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + dy*0.5
  while y < ymax do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1], sp[2]
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function prewet(poly, step, water, radius, margin)
  local ymin, ymax, xmin, xmax = 1e9, -1e9, 1e9, -1e9
  for _,p in ipairs(poly) do ymin=math.min(ymin,p[2]); ymax=math.max(ymax,p[2]); xmin=math.min(xmin,p[1]); xmax=math.max(xmax,p[1]) end
  for y=ymin+margin, ymax-margin, step do for x=xmin+margin, xmax-margin, step do
    if inside(poly,x,y) and inside(poly,x+margin,y) and inside(poly,x-margin,y) and inside(poly,x,y+margin) and inside(poly,x,y-margin) then
      drop{x=x,y=y,water=water,radius=radius} end
  end end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end

-- right building cream
local rb = P{{1422,-20},{2020,-20},{2020,720},{1422,730}}
prewet(rb, 90, 7, 50, 60)
local b = brush{name="cream", width=44}
fill(b, rb, 26, 70, function(y,x)
  local t = y/400
  return 5, {["yellow-ochre"]=0.035, ["raw-umber"]=0.035+0.02*t, ["paynes-gray"]=0.008+0.01*t}
end)
-- left wall beige
local lw = P{{-20,50},{0,45},{432,338},{428,705},{-20,775}}
prewet(lw, 90, 7, 50, 60)
local c = brush{name="beigeL", width=40}
fill(c, lw, 24, 70, function(y,x)
  return 5, {["yellow-ochre"]=0.09, ["raw-umber"]=0.13, ["paynes-gray"]=0.02}
end)
-- pillar
local pl = P{{488,678},{684,658},{688,1060},{570,1215},{488,1215}}
local d = brush{name="pillar", width=30}
fill(d, pl, 18, 60, function(y,x)
  return 4, {["yellow-ochre"]=0.07, ["raw-umber"]=0.05}
end)
print(clock())
wait(10)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function inside(poly, x, y)
  for _,sp in ipairs(spans(poly,y)) do if x>=sp[1] and x<=sp[2] then return true end end
  return false
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function prewet(poly, step, water, radius, margin)
  local ymin, ymax, xmin, xmax = 1e9, -1e9, 1e9, -1e9
  for _,p in ipairs(poly) do ymin=math.min(ymin,p[2]); ymax=math.max(ymax,p[2]); xmin=math.min(xmin,p[1]); xmax=math.max(xmax,p[1]) end
  for y=ymin+margin, ymax-margin, step do for x=xmin+margin, xmax-margin, step do
    if inside(poly,x,y) and inside(poly,x+margin,y) and inside(poly,x-margin,y) and inside(poly,x,y+margin) and inside(poly,x,y-margin) then
      drop{x=x,y=y,water=water,radius=radius} end
  end end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end

local road = P{{822,738},{1190,738},{1215,655},{1335,655},{1365,740},{1352,872},{1725,1215},{535,1215},{700,1062},{832,948},{832,780}}
prewet(road, 80, 7, 45, 50)
local b = brush{name="road", width=34}
fill(b, road, 20, 50, function(y,x)
  local t = math.max(0, math.min(1, (y-400)/260))
  return 5, {["paynes-gray"]=0.25+0.2*t, ["raw-umber"]=0.15+0.1*t, ["french-ultramarine"]=0.06}
end, {inset=12})
print(clock())
wait(8)
local cw = P{{1362,778},{2020,872},{2020,1215},{1735,1215},{1360,878}}
prewet(cw, 80, 6, 45, 50)
local c = brush{name="concrete", width=34}
fill(c, cw, 20, 50, function(y,x)
  return 5, {["paynes-gray"]=0.1, ["raw-umber"]=0.12, ["yellow-ochre"]=0.03}
end, {inset=12})
local lw = P{{690,790},{830,775},{832,945},{700,1060},{688,1060}}
local d = brush{name="lowwall", width=24}
fill(d, lw, 14, 50, function(y,x)
  return 4, {["paynes-gray"]=0.1, ["raw-umber"]=0.12, ["yellow-ochre"]=0.04}
end, {inset=8})
print(clock())
wait(10)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function inside(poly, x, y)
  for _,sp in ipairs(spans(poly,y)) do if x>=sp[1] and x<=sp[2] then return true end end
  return false
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function prewet(poly, step, water, radius, margin)
  local ymin, ymax, xmin, xmax = 1e9, -1e9, 1e9, -1e9
  for _,p in ipairs(poly) do ymin=math.min(ymin,p[2]); ymax=math.max(ymax,p[2]); xmin=math.min(xmin,p[1]); xmax=math.max(xmax,p[1]) end
  for y=ymin+margin, ymax-margin, step do for x=xmin+margin, xmax-margin, step do
    if inside(poly,x,y) and inside(poly,x+margin,y) and inside(poly,x-margin,y) and inside(poly,x,y+margin) and inside(poly,x,y-margin) then
      drop{x=x,y=y,water=water,radius=radius} end
  end end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end

-- gate
local gate = P{{-20,772},{456,702},{462,1095},{-20,1215}}
prewet(gate, 80, 6, 45, 50)
local g = brush{name="gate", width=30}
fill(g, gate, 18, 50, function(y,x)
  return 5, {["sepia"]=0.35, ["french-ultramarine"]=0.18, ["paynes-gray"]=0.08}
end, {inset=10})
-- net (big piece)
local net = P{{1592,432},{2020,408},{2020,895},{1800,842},{1640,770},{1590,720}}
prewet(net, 80, 6, 45, 50)
local n = brush{name="net", width=30}
fill(n, net, 18, 50, function(y,x)
  return 5, {["lamp-black"]=0.4, ["paynes-gray"]=0.2, ["french-ultramarine"]=0.08}
end, {inset=10})
local net2 = P{{1442,528},{1556,520},{1545,705},{1432,692}}
local n2 = brush{name="net2", width=20}
fill(n2, net2, 12, 40, function(y,x)
  return 3, {["lamp-black"]=0.3, ["paynes-gray"]=0.15, ["french-ultramarine"]=0.06}
end, {inset=7})
print(clock())
wait(10)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end
local nb = 0
function shape(poly, width, water, mix, dy)
  nb = nb + 1
  local b = brush{name="sh_c5_"..nb, width=width}
  fill(b, P(poly), dy or width*0.55, 40, function() return water, mix end, {inset=width*0.35})
end
local shadow = {["paynes-gray"]=0.05, ["french-ultramarine"]=0.035, ["raw-umber"]=0.01}
local shadow2 = {["paynes-gray"]=0.1, ["french-ultramarine"]=0.06, ["raw-umber"]=0.03}
local roofd = {["paynes-gray"]=0.35, ["french-ultramarine"]=0.12, ["burnt-umber"]=0.1}
-- left house roof
shape({{510,388},{600,360},{690,352},{700,368},{690,395},{515,400}}, 12, 2.5, roofd)
-- left house shutters panel
shape({{545,415},{690,413},{690,478},{545,478}}, 14, 3, {["burnt-sienna"]=0.08,["paynes-gray"]=0.08,["quinacridone-rose"]=0.02})
-- left house: shadowed right part and under roof
shape({{515,400},{690,398},{690,412},{515,414}}, 10, 2, shadow2)
shape({{700,380},{820,380},{830,620},{700,620}}, 20, 4, shadow)
-- second gable darker
shape({{822,365},{850,345},{880,370},{882,560},{822,560}}, 14, 3, shadow2)
-- canopy roof left
shape({{640,540},{700,518},{770,522},{770,556},{640,560}}, 12, 2.5, {["burnt-umber"]=0.12,["paynes-gray"]=0.15})
-- main house: right side shadow
shape({{1145,385},{1180,378},{1180,735},{1145,735}}, 14, 3, shadow2)
-- main house: eave shadow band
shape({{895,412},{1175,405},{1175,428},{895,432}}, 10, 2, shadow2)
-- floor band
shape({{895,545},{1175,545},{1175,585},{895,585}}, 14, 3, shadow)
-- ground floor wall
shape({{1028,585},{1150,585},{1150,728},{1028,728}}, 18, 3.5, shadow)
-- fence
shape({{848,620},{1028,615},{1028,728},{848,728}}, 18, 4, {["paynes-gray"]=0.15,["raw-umber"]=0.08,["french-ultramarine"]=0.04})
-- distant houses right
shape({{1205,440},{1300,420},{1330,440},{1410,430},{1410,700},{1300,690},{1215,650}}, 20, 4, {["raw-umber"]=0.08,["paynes-gray"]=0.06,["yellow-ochre"]=0.03})
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function inside(poly, x, y)
  for _,sp in ipairs(spans(poly,y)) do if x>=sp[1] and x<=sp[2] then return true end end
  return false
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end
function bbox(poly) local a,b,c,d=1e9,1e9,-1e9,-1e9 for _,p in ipairs(poly) do a=math.min(a,p[1]);b=math.min(b,p[2]);c=math.max(c,p[1]);d=math.max(d,p[2]) end return a,b,c,d end
-- dabs: short curved strokes inside poly
function dabs(b, poly, n, size, water, mix, yfilter)
  local x0,y0,x1,y1 = bbox(poly)
  local k = 0; local tries=0
  while k < n and tries < n*20 do
    tries = tries + 1
    local x = x0 + math.random()*(x1-x0); local y = y0 + math.random()*(y1-y0)
    if inside(poly,x,y) and (not yfilter or yfilter(x,y)) then
      k = k + 1
      topup(b, water, mix)
      local a = math.random()*6.28
      local L = size*(0.5+math.random())
      b:stroke({{x,y},{x+math.cos(a)*L*0.5, y+math.sin(a)*L*0.3+L*0.2},{x+math.cos(a)*L, y+math.sin(a)*L*0.5}}, {pressure=0.4+math.random()*0.3, duration=0.03})
    end
  end
end
math.randomseed(11)
local hedge = P{{420,585},{445,560},{500,553},{540,545},{600,538},{660,540},{720,548},{780,565},{820,590},{836,640},{836,740},{830,785},{760,792},{690,800},{688,700},{686,662},{560,672},{488,682},{470,700},{440,702},{425,650}}
local base = brush{name="hedgebase", width=22}
fill(base, hedge, 13, 40, function(y,x) return 4, {["sap-green"]=0.15, ["hookers-green"]=0.12, ["paynes-gray"]=0.08, ["burnt-umber"]=0.05} end, {inset=6})
-- dark dabs wet into wet, mostly lower and inner
local dk = brush{name="hedgedark", width=12}
dabs(dk, hedge, 70, 14, 1.5, {["hookers-green"]=0.25, ["paynes-gray"]=0.2, ["sepia"]=0.12}, function(x,y) return y > 310 or math.random()<0.4 end)
-- lighter sunny dabs on top
local lt = brush{name="hedgelight", width=9}
dabs(lt, hedge, 45, 10, 1.2, {["sap-green"]=0.2, ["yellow-ochre"]=0.1, ["green-gold"]=0.05}, function(x,y) return y < 330 end)
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function inside(poly, x, y)
  for _,sp in ipairs(spans(poly,y)) do if x>=sp[1] and x<=sp[2] then return true end end
  return false
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end
function bbox(poly) local a,b,c,d=1e9,1e9,-1e9,-1e9 for _,p in ipairs(poly) do a=math.min(a,p[1]);b=math.min(b,p[2]);c=math.max(c,p[1]);d=math.max(d,p[2]) end return a,b,c,d end
function dabs(b, poly, n, size, water, mix, yfilter, pr)
  local x0,y0,x1,y1 = bbox(poly)
  local k = 0; local tries=0
  while k < n and tries < n*20 do
    tries = tries + 1
    local x = x0 + math.random()*(x1-x0); local y = y0 + math.random()*(y1-y0)
    if inside(poly,x,y) and (not yfilter or yfilter(x,y)) then
      k = k + 1
      topup(b, water, mix)
      local a = math.random()*6.28
      local L = size*(0.5+math.random())
      b:stroke({{x,y},{x+math.cos(a)*L*0.5, y+math.sin(a)*L*0.3+L*0.2},{x+math.cos(a)*L, y+math.sin(a)*L*0.5}}, {pressure=(pr or 0.4)+math.random()*0.3, duration=0.03})
    end
  end
end
math.randomseed(23)
-- glaze dark over most of hedge, irregular silhouette (slightly bigger poly on top)
local hedge2 = P{{418,600},{430,570},{470,552},{520,540},{560,532},{610,528},{650,535},{700,540},{750,550},{800,570},{830,600},{840,650},{838,760},{690,790},{690,700},{686,668},{560,675},{488,684},{470,700},{430,700}}
local dk = brush{name="hedgedark2", width=14}
dabs(dk, hedge2, 160, 16, 1.6, {["hookers-green"]=0.22, ["paynes-gray"]=0.18, ["sepia"]=0.1, ["french-ultramarine"]=0.04})
print(clock())
wait(6)
-- deeper accents
local dd = brush{name="hedgedeep", width=8}
dabs(dd, hedge2, 60, 10, 0.8, {["hookers-green"]=0.25, ["paynes-gray"]=0.3, ["sepia"]=0.2}, function(x,y) return y>315 end, 0.3)
wait(6)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function inside(poly, x, y)
  for _,sp in ipairs(spans(poly,y)) do if x>=sp[1] and x<=sp[2] then return true end end
  return false
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function prewet(poly, step, water, radius, margin)
  local ymin, ymax, xmin, xmax = 1e9, -1e9, 1e9, -1e9
  for _,p in ipairs(poly) do ymin=math.min(ymin,p[2]); ymax=math.max(ymax,p[2]); xmin=math.min(xmin,p[1]); xmax=math.max(xmax,p[1]) end
  for y=ymin+margin, ymax-margin, step do for x=xmin+margin, xmax-margin, step do
    if inside(poly,x,y) and inside(poly,x+margin,y) and inside(poly,x-margin,y) and inside(poly,x,y+margin) and inside(poly,x,y-margin) then
      drop{x=x,y=y,water=water,radius=radius} end
  end end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end

-- road lit glaze: lighter in far cross street, less at near
local roadlit = P{{835,728},{1190,728},{1215,650},{1340,650},{1372,742},{1355,872},{1730,1215},{760,1215},{900,1000},{905,820},{850,790}}
prewet(roadlit, 80, 6, 45, 50)
local g = brush{name="roadglaze", width=34}
fill(g, roadlit, 20, 50, function(y,x)
  local t = math.max(0, math.min(1, (y-400)/260))
  return 4, {["buff-titanium"]=0.42-0.15*t, ["cobalt-violet"]=0.07}
end, {inset=10})
print(clock())
wait(8)
-- concrete wall neutralize
local cw = P{{1362,778},{2020,872},{2020,1215},{1735,1215},{1360,878}}
prewet(cw, 80, 6, 45, 50)
local c = brush{name="concglaze", width=34}
fill(c, cw, 20, 50, function(y,x) return 4, {["buff-titanium"]=0.35, ["cobalt-violet"]=0.09} end, {inset=8})
-- low wall left
local lw = P{{690,790},{830,775},{832,945},{700,1060},{688,1060}}
local d = brush{name="lowglaze", width=22}
fill(d, lw, 13, 40, function(y,x) return 3, {["buff-titanium"]=0.2, ["cobalt-violet"]=0.08} end, {inset=6})
print(clock())
wait(10)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end
local nb = 0
function shape(poly, width, water, mix, dy, seg)
  nb = nb + 1
  local b = brush{name="s7_"..nb, width=width}
  fill(b, P(poly), dy or width*0.55, seg or 40, function() return water, mix end, {inset=width*0.35})
end
-- line strokes along a path in display coords, topping up every seg
function line(name, pts, width, water, mix, pr)
  local b = brush{name=name, width=width}
  local q = P(pts)
  for i=1,#q-1 do
    local a, c = q[i], q[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/40))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
local dark = {["paynes-gray"]=0.35, ["sepia"]=0.15, ["french-ultramarine"]=0.08}
-- left upper roof: dark triangle in corner + eave band along diagonal
shape({{-20,-20},{60,-20},{460,320},{450,350},{-20,90}}, 18, 3, {["paynes-gray"]=0.3, ["sepia"]=0.12, ["french-ultramarine"]=0.06})
-- eave underside shadow (lighter band beneath)
line("eave1", {{-10,95},{455,355}}, 14, 2.5, {["paynes-gray"]=0.12, ["raw-umber"]=0.08}, 0.5)
-- second eave diagonal
line("eave2", {{-10,290},{485,420}}, 16, 3, {["paynes-gray"]=0.3, ["sepia"]=0.12, ["french-ultramarine"]=0.05}, 0.5)
line("eave2s", {{-10,320},{485,440}}, 14, 2.5, {["paynes-gray"]=0.12, ["raw-umber"]=0.08}, 0.5)
-- right building: brown tile strip at its left edge, and pipe
shape({{1400,-20},{1468,-20},{1468,700},{1405,700}}, 16, 3, {["burnt-sienna"]=0.12, ["raw-umber"]=0.12, ["paynes-gray"]=0.05})
line("pipe", {{1418,60},{1418,760}}, 7, 1.5, {["paynes-gray"]=0.12, ["raw-umber"]=0.05}, 0.5)
-- distant roofs between house and right building
shape({{1180,470},{1250,440},{1320,445},{1400,425},{1400,500},{1180,520}}, 14, 2.5, {["paynes-gray"]=0.2, ["viridian"]=0.05, ["raw-umber"]=0.08})
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function inside(poly, x, y)
  for _,sp in ipairs(spans(poly,y)) do if x>=sp[1] and x<=sp[2] then return true end end
  return false
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function prewet(poly, step, water, radius, margin)
  local ymin, ymax, xmin, xmax = 1e9, -1e9, 1e9, -1e9
  for _,p in ipairs(poly) do ymin=math.min(ymin,p[2]); ymax=math.max(ymax,p[2]); xmin=math.min(xmin,p[1]); xmax=math.max(xmax,p[1]) end
  for y=ymin+margin, ymax-margin, step do for x=xmin+margin, xmax-margin, step do
    if inside(poly,x,y) and inside(poly,x+margin,y) and inside(poly,x-margin,y) and inside(poly,x,y+margin) and inside(poly,x,y-margin) then
      drop{x=x,y=y,water=water,radius=radius} end
  end end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end
-- left wall shade glaze (below eave2)
local lw = P{{-20,330},{470,440},{470,705},{-20,775}}
prewet(lw, 80, 5, 45, 50)
local b = brush{name="lwglaze", width=34}
fill(b, lw, 20, 50, function(y,x) return 4, {["ultramarine-violet"]=0.07, ["burnt-sienna"]=0.025, ["raw-umber"]=0.03} end, {inset=10})
-- upper left gable: lighter glaze
local ul = P{{-20,110},{430,345},{470,420},{-20,300}}
local c = brush{name="ulglaze", width=26}
fill(c, ul, 15, 50, function(y,x) return 3, {["ultramarine-violet"]=0.03, ["raw-umber"]=0.02} end, {inset=8})
print(clock())
wait(10)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S = 0.55
function seglines(b, pts, water, mix, pr, step)
  for i=1,#pts-1 do
    local a, c = pts[i], pts[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/(step or 40)))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
-- pole: tapered, drawn as vertical strokes in cells
local pole = brush{name="pole", width=10}
local pm = {["buff-titanium"]=1.2, ["paynes-gray"]=0.05}
for y=0,400,30 do
  local x = (1186 + (y/404)*6)*S
  topup(pole, 1.6, pm)
  pole:stroke({{x,y},{x,y+32}},{pressure=0.55,duration=0.05})
end
-- shaded left edge of pole
local ps = brush{name="poleshade", width=3}
for y=0,400,40 do
  local x = (1180 + (y/404)*6)*S
  topup(ps, 0.5, {["paynes-gray"]=0.25, ["raw-umber"]=0.08})
  ps:stroke({{x,y},{x,y+40}},{pressure=0.5,duration=0.05})
end
-- transformer
local tr = brush{name="transf", width=12}
for y=150,225,12 do
  topup(tr, 1.5, {["buff-titanium"]=1.0, ["paynes-gray"]=0.12})
  tr:stroke({{1148*S, y*S},{1168*S,y*S}},{pressure=0.5,duration=0.04})
end
-- far pole
local fp = brush{name="farpole", width=5}
for y=340,690,40 do
  topup(fp, 0.8, {["buff-titanium"]=0.9, ["paynes-gray"]=0.08})
  fp:stroke({{1300*S,y*S},{1300*S,(y+40)*S}},{pressure=0.5,duration=0.04})
end
print(clock())
wait(5)
-- wires
local wires = {
 {440,105, 1180,22, 18}, {420,195, 1180,85, 22}, {430,222, 1180,118, 20},
 {600,250, 1180,140, 14}, {380,300, 1410,195, 30}, {400,318, 1410,232, 25},
 {530,335, 1300,300, 12}, {560,360, 1180,330, 8},
 {870,0, 980,230, 6}, {960,0, 1050,150, 6}, {1000,0, 1180,95, 5},
 {590,40, 1180,55, 26}, {700,0, 1050,130, 14},
 {1195,70, 1410,40, 6}, {1195,95, 1410,110, 8}, {1195,130, 1410,160, 8},
 {1195,250, 1410,330, 10}, {1200,330, 1410,380, 6}, {1200,380, 1300,410, 4},
 {1300,360, 1410,420, 4}, {1220,180, 1410,260, 8},
 {1270,0, 1200,60, 3}, {1290,0, 1350,190, 10},
}
local wb = brush{name="wire", width=3}
local wm = {["lamp-black"]=0.8, ["paynes-gray"]=0.4}
for _,w in ipairs(wires) do
  local pts = {}
  for k=0,6 do
    local t = k/6
    local x = w[1] + (w[3]-w[1])*t
    local y = w[2] + (w[4]-w[2])*t + w[5]*4*t*(1-t)
    pts[#pts+1] = {x*S, y*S}
  end
  seglines(wb, pts, 0.4, wm, 0.4, 50)
end
print(clock())
wait(5)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S = 0.55
function seglines(b, pts, water, mix, pr, step)
  for i=1,#pts-1 do
    local a, c = pts[i], pts[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/(step or 40)))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
function D(pts) local o={} for i,p in ipairs(pts) do o[i]={p[1]*S,p[2]*S} end return o end
function circ(cx,cy,r,n) local o={} for k=0,n do local a=k/n*2*math.pi o[#o+1]={cx+r*math.cos(a), cy+r*math.sin(a)} end return o end
-- sign pole (light grey-white) 
local pb = brush{name="signpole", width=6}
seglines(pb, D{{790,540},{791,940}}, 1.2, {["buff-titanium"]=1.0, ["paynes-gray"]=0.05}, 0.5, 40)
local ps = brush{name="signpoleS", width=2.5}
seglines(ps, D{{786,560},{787,940}}, 0.4, {["paynes-gray"]=0.3,["raw-umber"]=0.1}, 0.5, 50)
-- blue round sign: fill disc with cobalt/ultramarine
local bs = brush{name="bluesign", width=10}
local cx, cy = 788*S, 458*S
for r=4,16,6 do seglines(bs, circ(cx,cy,r,14), 1.5, {["french-ultramarine"]=0.5,["cobalt-blue"]=0.3}, 0.5, 30) end
-- red ring speed sign
local rr = brush{name="redring", width=5}
seglines(rr, circ(715*S, 377*S, 15, 18), 0.8, {["pyrrol-scarlet"]=0.6,["cadmium-red"]=0.3}, 0.5, 20)
-- red triangle (stop)
local tri = brush{name="redtri", width=7}
local T = D{{752,352},{826,352},{789,418}}
for k=1,3 do
  local a = T[k]; local c = T[k%3+1]
  -- fill triangle via horizontal strokes
end
for yy=352,410,7 do
  local t = (yy-352)/66
  local xl = 752 + 37*t + 4; local xr = 826 - 37*t - 4
  if xr > xl then topup(tri,1.2,{["pyrrol-scarlet"]=0.6,["cadmium-red"]=0.4}); tri:stroke({{xl*S,yy*S},{xr*S,yy*S}},{pressure=0.5,duration=0.03}) end
end
-- no parking small sign: blue disc with red ring
local np = brush{name="npark", width=7}
seglines(np, circ(715*S,317*S,7,10), 1.0, {["french-ultramarine"]=0.4,["cobalt-blue"]=0.2}, 0.5, 20)
local npr = brush{name="nparkr", width=3}
seglines(npr, circ(715*S,317*S,12,14), 0.4, {["pyrrol-scarlet"]=0.5}, 0.4, 20)
-- small placard outline
local pl = brush{name="placard", width=2}
seglines(pl, D{{756,498},{822,498},{822,545},{756,545},{756,498}}, 0.3, {["paynes-gray"]=0.3}, 0.4, 30)
seglines(pl, D{{762,512},{815,512}}, 0.3, {["paynes-gray"]=0.3}, 0.3, 30)
seglines(pl, D{{762,528},{815,528}}, 0.3, {["paynes-gray"]=0.3}, 0.3, 30)
print(clock())
wait(6)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S = 0.55
function seglines(b, pts, water, mix, pr, step)
  for i=1,#pts-1 do
    local a, c = pts[i], pts[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/(step or 40)))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
function D(pts) local o={} for i,p in ipairs(pts) do o[i]={p[1]*S,p[2]*S} end return o end
function rectfill(name, x0,y0,x1,y1, width, water, mix)
  local b = brush{name=name, width=width}
  x0,y0,x1,y1 = x0*S,y0*S,x1*S,y1*S
  local ins = width*0.4
  local y = y0+ins
  while y <= y1-ins+0.01 do
    local x = x0+ins
    while x < x1-ins do
      topup(b, water, mix)
      local xe = math.min(x1-ins, x+40)
      b:stroke({{x,y},{xe,y}},{pressure=0.5,duration=0.02})
      x = xe
    end
    y = y + width*0.5
  end
end
local glass = {["paynes-gray"]=0.18, ["french-ultramarine"]=0.06, ["raw-umber"]=0.04}
local dk = {["paynes-gray"]=0.4, ["sepia"]=0.2, ["french-ultramarine"]=0.08}
local line = {["paynes-gray"]=0.35, ["sepia"]=0.15}
-- main house big window: panes
for i=0,3 do
  local x0 = 905 + i*37
  rectfill("mw"..i, x0, 440, x0+30, 492, 8, 1.2, glass)
end
-- balcony rail
local rl = brush{name="rail", width=2.5}
seglines(rl, D{{898,497},{1055,497}}, 0.4, {["burnt-sienna"]=0.3,["paynes-gray"]=0.15}, 0.4, 40)
for x=905,1050,12 do seglines(rl, D{{x,497},{x,518}}, 0.3, {["burnt-sienna"]=0.25,["paynes-gray"]=0.15}, 0.3, 40) end
seglines(rl, D{{898,518},{1055,518}}, 0.4, {["burnt-sienna"]=0.3,["paynes-gray"]=0.15}, 0.4, 40)
-- main house gable roof line
local rf = brush{name="roofline", width=4}
seglines(rf, D{{880,412},{960,370},{1030,330},{1110,360},{1180,385}}, 0.8, dk, 0.5, 40)
-- small dark upper window of mid house
rectfill("uw", 828, 392, 842, 425, 5, 0.8, dk)
-- left house window
rectfill("lhw", 598, 425, 622, 470, 7, 1.0, glass)
-- door outline and frame
local dl = brush{name="doorline", width=2.5}
seglines(dl, D{{1062,598},{1142,598},{1142,722},{1062,722},{1062,598}}, 0.4, line, 0.4, 40)
seglines(dl, D{{1068,605},{1068,718}}, 0.3, {["paynes-gray"]=0.15}, 0.3, 40)
-- lower floor window behind fence
rectfill("lfw", 905, 598, 1000, 618, 6, 1.0, glass)
-- fence slat lines
for y=630,720,9 do seglines(dl, D{{900,y},{1022,y}}, 0.3, {["paynes-gray"]=0.18,["raw-umber"]=0.05}, 0.3, 50) end
-- canopy over door (reddish)
local cp = brush{name="canopy", width=5}
seglines(cp, D{{1055,575},{1180,575}}, 1.0, {["burnt-sienna"]=0.25,["paynes-gray"]=0.15}, 0.5, 40)
-- round mirror
local mr = brush{name="mirror", width=6}
seglines(mr, D{{1145,520},{1170,515},{1172,545},{1150,550},{1145,520}}, 1, {["burnt-sienna"]=0.3,["sepia"]=0.2}, 0.5, 20)
-- right building upper window
rectfill("rbw", 1472, -10, 1585, 190, 14, 2.5, {["paynes-gray"]=0.35, ["french-ultramarine"]=0.1, ["sepia"]=0.12})
rectfill("rbwi", 1485, 10, 1565, 170, 10, 2, {["paynes-gray"]=0.15, ["cerulean-blue"]=0.05})
-- right building ledges (shadow lines)
seglines(dl, D{{1470,230},{1640,90}}, 0.5, {["paynes-gray"]=0.15,["raw-umber"]=0.08}, 0.6, 40)
seglines(dl, D{{1440,420},{2000,170}}, 0.5, {["paynes-gray"]=0.12,["raw-umber"]=0.06}, 0.6, 40)
seglines(dl, D{{1440,500},{1650,445}}, 0.5, {["paynes-gray"]=0.18,["raw-umber"]=0.08}, 0.7, 40)
print(clock())
wait(6)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S = 0.55
function seglines(b, pts, water, mix, pr, step)
  for i=1,#pts-1 do
    local a, c = pts[i], pts[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/(step or 40)))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
function D(pts) local o={} for i,p in ipairs(pts) do o[i]={p[1]*S,p[2]*S} end return o end
-- window on left wall: dark glass panel, then bars
local wg = brush{name="lwin", width=12}
for y=440,630,14 do seglines(wg, D{{5,y-(y-440)*0.0},{235,y+ (0)}}, 1.4, {["paynes-gray"]=0.22,["sepia"]=0.1,["french-ultramarine"]=0.05}, 0.5, 40) end
wait(4)
local bar = brush{name="lbar", width=4}
for x=10,235,26 do seglines(bar, D{{x,432},{x,635}}, 0.5, {["sepia"]=0.35,["paynes-gray"]=0.3}, 0.5, 40) end
seglines(bar, D{{0,432},{240,428}}, 0.6, {["sepia"]=0.35,["paynes-gray"]=0.3}, 0.6, 40)
seglines(bar, D{{0,635},{240,628}}, 0.6, {["sepia"]=0.35,["paynes-gray"]=0.3}, 0.6, 40)
-- gate slats: dark vertical lines across the gate, perspective
local gs = brush{name="gslat", width=3}
for i=0,15 do
  local x = 15 + i*28
  local ytop = 770 - (x/456)*68 + 8
  local ybot = 1215
  seglines(gs, D{{x,ytop},{x+1,ybot}}, 0.5, {["sepia"]=0.4,["paynes-gray"]=0.25}, 0.5, 40)
end
seglines(gs, D{{0,778},{456,712}}, 0.6, {["sepia"]=0.45,["paynes-gray"]=0.3}, 0.8, 40)
-- latch
seglines(gs, D{{185,868},{300,832}}, 0.6, {["paynes-gray"]=0.45,["sepia"]=0.2}, 0.9, 30)
-- gate post right edge dark
local gp = brush{name="gpost", width=8}
seglines(gp, D{{455,700},{460,1090}}, 1.2, {["sepia"]=0.4,["paynes-gray"]=0.3}, 0.5, 40)
print(clock())
wait(6)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function inside(poly, x, y)
  for _,sp in ipairs(spans(poly,y)) do if x>=sp[1] and x<=sp[2] then return true end end
  return false
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function prewet(poly, step, water, radius, margin)
  local ymin, ymax, xmin, xmax = 1e9, -1e9, 1e9, -1e9
  for _,p in ipairs(poly) do ymin=math.min(ymin,p[2]); ymax=math.max(ymax,p[2]); xmin=math.min(xmin,p[1]); xmax=math.max(xmax,p[1]) end
  for y=ymin+margin, ymax-margin, step do for x=xmin+margin, xmax-margin, step do
    if inside(poly,x,y) and inside(poly,x+margin,y) and inside(poly,x-margin,y) and inside(poly,x,y+margin) and inside(poly,x,y-margin) then
      drop{x=x,y=y,water=water,radius=radius} end
  end end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end
-- gate dark glaze, vertical strokes so it reads as slatted wood
local gate = P{{-20,785},{452,716},{452,1100},{-20,1215}}
local g = brush{name="gate2", width=20}
for x=-5,245,10 do
  local ytop = (785 - ((x/0.55)+20)/472*69)*0.55 + 8
  local y = ytop
  while y < 668 do
    topup(g, 3.2, {["sepia"]=0.3, ["burnt-umber"]=0.1, ["french-ultramarine"]=0.08})
    g:stroke({{x,y},{x,y+45}},{pressure=0.45,duration=0.02})
    y = y + 45
  end
end
print(clock())
wait(8)
-- left wall neutralizing glaze: above eave2 region and below, avoid window
local wallA = P{{-20,110},{430,345},{470,420},{470,700},{-20,770}}
local wb = brush{name="wallneut", width=30}
fill(wb, wallA, 18, 50, function(y,x)
  local inwin = x < 135 and y > 232 and y < 352
  if inwin then return 3.5, {["cobalt-violet"]=0.02} end
  return 3.5, {["cobalt-violet"]=0.07, ["raw-umber"]=0.02}
end, {inset=8})
-- pillar right face shade
local pr = P{{560,690},{684,660},{688,1060},{570,1215},{560,1215}}
local pb = brush{name="pillarshade", width=22}
fill(pb, pr, 12, 40, function() return 3, {["cobalt-violet"]=0.06, ["paynes-gray"]=0.03, ["raw-umber"]=0.02} end, {inset=6})
local pl = P{{488,690},{560,690},{560,1215},{488,1215}}
local pc = brush{name="pillarleft", width=22}
fill(pc, pl, 12, 40, function() return 3, {["cobalt-violet"]=0.035} end, {inset=6})
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end
local wallA = P{{-20,110},{430,345},{470,420},{470,705},{-20,778}}
local wb = brush{name="wallkhaki", width=30}
fill(wb, wallA, 18, 60, function(y,x)
  local inwin = x < 135 and y > 236 and y < 350
  if inwin then return 3.5, {["paynes-gray"]=0.04} end
  return 3.5, {["terre-verte"]=0.15, ["paynes-gray"]=0.08, ["yellow-ochre"]=0.03}
end, {inset=8})
-- pillar left face (also went pinkish) : lighter dose
local pl = P{{488,690},{684,660},{688,1060},{570,1215},{488,1215}}
local pc = brush{name="pillarkhaki", width=22}
fill(pc, pl, 12, 50, function(y,x) return 3, {["terre-verte"]=0.06, ["paynes-gray"]=0.02, ["yellow-ochre"]=0.01} end, {inset=6})
-- gate cooling glaze
local gate = P{{-20,785},{452,716},{452,1100},{-20,1215}}
local g = brush{name="gatecool", width=30}
fill(g, gate, 18, 60, function() return 3.5, {["paynes-gray"]=0.15, ["terre-verte"]=0.05} end, {inset=8})
print(clock())
wait(10)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S=0.55
function seglines(b, pts, water, mix, pr, step)
  for i=1,#pts-1 do
    local a, c = pts[i], pts[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/(step or 40)))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
function D(pts) local o={} for i,p in ipairs(pts) do o[i]={p[1]*S,p[2]*S} end return o end
local lt = brush{name="gslatL", width=3}
local dk = brush{name="gslatD", width=3}
for i=0,15 do
  local x = 20 + i*27
  local ytop = 785 - ((x+20)/472)*69 + 12
  seglines(lt, D{{x,ytop},{x+1,1215}}, 0.5, {["buff-titanium"]=0.6,["raw-umber"]=0.1}, 0.45, 60)
  seglines(dk, D{{x+11,ytop},{x+12,1215}}, 0.5, {["sepia"]=0.5,["paynes-gray"]=0.4}, 0.45, 60)
end
seglines(dk, D{{0,790},{452,722}}, 0.7, {["sepia"]=0.5,["paynes-gray"]=0.4}, 0.9, 40)
-- latch handle
local lh = brush{name="latch2", width=5}
seglines(lh, D{{185,868},{300,830}}, 0.7, {["paynes-gray"]=0.5,["lamp-black"]=0.2}, 0.6, 30)
print(clock())
wait(6)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
local S=0.55
function seglines(b, pts, water, mix, pr, step)
  for i=1,#pts-1 do
    local a, c = pts[i], pts[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/(step or 40)))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
function D(pts) local o={} for i,p in ipairs(pts) do o[i]={p[1]*S,p[2]*S} end return o end
-- shadow on near-left of road and over the green-grey scallops
local sh = D{{560,1215},{690,1075},{840,955},{905,1000},{860,1215}}
local b = brush{name="roadshadow", width=26}
fill(b, sh, 15, 50, function(y,x) return 3.5, {["paynes-gray"]=0.1, ["french-ultramarine"]=0.05, ["burnt-sienna"]=0.03} end, {inset=6})
print(clock())
wait(8)
-- road markings: white edge line right, stop line across cross street
local wl = brush{name="whiteline", width=7}
seglines(wl, D{{1360,880},{1560,1060},{1735,1215}}, 1.3, {["buff-titanium"]=1.4,["naples-yellow"]=0.1}, 0.5, 30)
local st = brush{name="stopline", width=9}
seglines(st, D{{905,800},{1150,792},{1350,790}}, 1.5, {["buff-titanium"]=1.5,["naples-yellow"]=0.1}, 0.5, 30)
-- far cross-street lines
local fl = brush{name="farline", width=4}
seglines(fl, D{{1000,742},{1195,738}}, 0.7, {["buff-titanium"]=1.0}, 0.5, 30)
-- 'tomare' hint: a few short white bars
for i=0,2 do
  local x = 1040 + i*70
  seglines(fl, D{{x,830},{x+45,830},{x+30,850}}, 0.7, {["buff-titanium"]=1.2}, 0.6, 20)
end
print(clock())
wait(6)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
-- cast shadow wedge (cell coords), straight diagonal top edge
local sh = {{300,668},{300,600},{385,470},{420,455},{470,500},{520,668}}
local b = brush{name="castshadow", width=24}
fill(b, sh, 13, 50, function(y,x) return 3.5, {["paynes-gray"]=0.16, ["french-ultramarine"]=0.07, ["burnt-sienna"]=0.04} end, {inset=5})
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
local sh = {{292,668},{292,600},{360,505},{420,455},{470,470},{600,560},{780,668}}
for _,d in ipairs({{350,600},{430,560},{520,610},{620,640},{400,630}}) do drop{x=d[1],y=d[2],water=4,radius=40} end
local b = brush{name="castshadow2", width=24}
fill(b, sh, 13, 50, function(y,x) return 3.5, {["paynes-gray"]=0.1, ["french-ultramarine"]=0.05, ["burnt-sienna"]=0.03} end, {inset=4})
-- soften upper-right diagonal edge with water strokes
local w = brush{name="softwater1", width=14}
local edge = {{420,455},{470,470},{600,560},{780,668}}
for i=1,#edge-1 do
  w:load{water=2}
  w:stroke({{edge[i][1]+4,edge[i][2]-6},{edge[i+1][1]+4,edge[i+1][2]-6}},{pressure=0.5,duration=0.05})
end
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S=0.55
math.randomseed(5)
-- fold lines: gently curving down-left strokes, grey sheen
local fb = brush{name="netfold", width=8}
local folds = {
 {1700,470, 1690,600, 1660,760}, {1780,450, 1770,600, 1750,820}, {1870,440, 1880,600, 1860,850},
 {1950,430, 1960,560, 1940,880}, {1620,520, 1630,620, 1610,720}, {1840,600, 1900,640, 1980,640},
 {1660,560, 1760,540, 1830,560},
}
for _,f in ipairs(folds) do
  local pts = {}
  for k=0,6 do
    local t=k/6
    local x = (1-t)^2*f[1] + 2*t*(1-t)*f[3] + t^2*f[5]
    local y = (1-t)^2*f[2] + 2*t*(1-t)*f[4] + t^2*f[6]
    pts[#pts+1] = {x*S + (math.random()-0.5)*3, y*S}
  end
  for i=1,#pts-1 do
    topup(fb, 1.0, {["buff-titanium"]=0.55, ["paynes-gray"]=0.15, ["cerulean-blue"]=0.05})
    fb:stroke({pts[i],pts[i+1]},{pressure=0.3+0.25*math.sin(i/6*math.pi),duration=0.04})
  end
end
-- dry-brush sheen patches (where the light hits the net)
local db = brush{name="netsheen", width=16}
local patches = {{1750,520,1900,500},{1660,640,1760,610},{1880,700,1990,690},{1800,780,1900,800},{1460,560,1530,580}}
for _,p in ipairs(patches) do
  db:load{water=1, pigments={["buff-titanium"]=1.0, ["paynes-gray"]=0.15}}
  db:stroke({{p[1]*S,p[2]*S},{p[3]*S,p[4]*S}},{pressure=0.5, dry=true})
end
print(clock())
wait(6)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end
local net = P{{1600,440},{2020,415},{2020,890},{1800,840},{1640,765},{1598,715}}
local b = brush{name="netglaze", width=30}
fill(b, net, 16, 50, function(y,x) return 4, {["lamp-black"]=0.24, ["paynes-gray"]=0.09} end, {inset=10})
local net2 = P{{1446,535},{1552,527},{1541,700},{1436,688}}
local c = brush{name="net2glaze", width=20}
fill(c, net2, 11, 40, function(y,x) return 3, {["lamp-black"]=0.2, ["paynes-gray"]=0.08} end, {inset=7})
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S=0.55
function seglines(b, pts, water, mix, pr, step)
  for i=1,#pts-1 do
    local a, c = pts[i], pts[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/(step or 40)))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
function D(pts) local o={} for i,p in ipairs(pts) do o[i]={p[1]*S,p[2]*S} end return o end
local blk = {["lamp-black"]=0.8, ["paynes-gray"]=0.4}
local function top(x) return 676 + (x-1365)*0.32 end
local function bot(x) return 770 + (x-1365)*0.44 end
-- vertical bars (thin, slightly lighter so they read as mesh)
local vb = brush{name="railbar", width=1.6}
local x = 1380
while x < 2010 do
  seglines(vb, D{{x,top(x)},{x,bot(x)}}, 0.25, {["lamp-black"]=0.5, ["paynes-gray"]=0.3}, 0.4, 60)
  x = x + 9 + (x-1365)*0.02
end
-- rails
local rb = brush{name="rail2", width=4}
seglines(rb, D{{1362,top(1362)},{2010,top(2010)}}, 0.6, blk, 0.6, 35)
seglines(rb, D{{1362,top(1362)+10},{2010,top(2010)+14}}, 0.5, blk, 0.35, 35)
local rb2 = brush{name="rail3", width=3}
seglines(rb2, D{{1362,bot(1362)},{2010,bot(2010)}}, 0.5, blk, 0.6, 35)
-- posts
local pb = brush{name="post", width=6}
seglines(pb, D{{1372,660},{1372,800}}, 0.8, blk, 0.6, 40)
seglines(pb, D{{1500,700},{1500,840}}, 0.8, blk, 0.6, 40)
local pb2 = brush{name="post2", width=9}
seglines(pb2, D{{1808,800},{1810,1025}}, 1.2, blk, 0.6, 40)
print(clock())
wait(6)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S=0.55
function seglines(b, pts, water, mix, pr, step)
  for i=1,#pts-1 do
    local a, c = pts[i], pts[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/(step or 40)))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
function D(pts) local o={} for i,p in ipairs(pts) do o[i]={p[1]*S,p[2]*S} end return o end
local wh = {["buff-titanium"]=1.6, ["naples-yellow"]=0.05}
-- road crossing bar & dashes
local bar = brush{name="crossbar", width=8}
seglines(bar, D{{880,882},{1112,886}}, 1.4, wh, 0.55, 30)
local ds = brush{name="dash", width=7}
seglines(ds, D{{968,932},{955,1000}}, 1.1, wh, 0.55, 30)
seglines(ds, D{{925,965},{905,1010}}, 1.1, wh, 0.5, 30)
seglines(ds, D{{890,1020},{1005,1022}}, 1.1, wh, 0.6, 30)
-- curved lane edge left of cross street
seglines(ds, D{{838,792},{870,800},{885,818}}, 0.9, wh, 0.4, 20)
seglines(ds, D{{1330,795},{1275,805},{1258,825}}, 0.9, wh, 0.4, 20)
-- arrow on blue sign (cells): center ~ (433,252)
local ar = brush{name="arrow", width=3}
local cx, cy = 788*S, 458*S
seglines(ar, {{cx+3,cy+12},{cx+3,cy-9}}, 0.4, wh, 0.5, 20)
seglines(ar, {{cx-2,cy-5},{cx+3,cy-11},{cx+8,cy-5}}, 0.4, wh, 0.45, 10)
seglines(ar, {{cx+3,cy+3},{cx-4,cy+1},{cx-9,cy+2}}, 0.4, wh, 0.45, 10)
seglines(ar, {{cx-6,cy-2},{cx-11,cy+2},{cx-6,cy+6}}, 0.4, wh, 0.4, 10)
-- "20" in speed sign: two tiny marks in blue
local nb = brush{name="twenty", width=1.8}
local sx, sy = 715*S, 377*S
seglines(nb, {{sx-7,sy-3},{sx-4,sy-5},{sx-2,sy-2},{sx-7,sy+4},{sx-2,sy+4}}, 0.25, {["french-ultramarine"]=0.5}, 0.4, 6)
seglines(nb, {{sx+4,sy-5},{sx+1,sy-1},{sx+4,sy+4},{sx+7,sy-1},{sx+4,sy-5}}, 0.25, {["french-ultramarine"]=0.5}, 0.4, 6)
print(clock())
wait(5)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
function P(t) local o={} for i,p in ipairs(t) do o[i]={p[1]*0.55,p[2]*0.55} end return o end
local nb=0
function shape(poly, width, water, mix)
  nb=nb+1
  local b = brush{name="ws_"..nb, width=width}
  fill(b, P(poly), width*0.55, 40, function() return water, mix end, {inset=width*0.35})
end
local warm = {["raw-umber"]=0.03, ["yellow-ochre"]=0.01, ["paynes-gray"]=0.01}
shape({{700,380},{820,380},{830,620},{700,620}}, 18, 3, warm)
shape({{1145,385},{1180,378},{1180,735},{1145,735}}, 12, 3, warm)
shape({{1028,585},{1150,585},{1150,728},{1028,728}}, 16, 3, warm)
shape({{895,545},{1175,545},{1175,585},{895,585}}, 12, 3, warm)
-- deeper shade under main house eave & under the canopy
local sd = {["paynes-gray"]=0.1, ["raw-umber"]=0.05, ["french-ultramarine"]=0.02}
shape({{895,428},{1140,425},{1140,440},{895,442}}, 8, 1.5, sd)
shape({{1060,582},{1180,582},{1180,598},{1060,598}}, 8, 1.5, sd)
-- left house: pinkish-brown shutters band (from photo) darker frame, house wall right part shade
shape({{835,390},{885,380},{885,600},{835,600}}, 14, 3, {["paynes-gray"]=0.06, ["raw-umber"]=0.03})
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S=0.55
-- tile strip: vertical strokes glaze to brown it down
local b = brush{name="stripglaze", width=14}
for _,x in ipairs({776, 786, 796}) do
  local y = 0
  while y < 390 do
    topup(b, 2.2, {["paynes-gray"]=0.08, ["burnt-umber"]=0.06, ["alizarin-crimson"]=0.01})
    b:stroke({{x,y},{x,y+45}},{pressure=0.45,duration=0.02})
    y = y + 45
  end
end
print(clock())
wait(6)
-- tile courses: faint horizontal ticks
local t = brush{name="tiles", width=1.5}
for y=10,380,9 do
  topup(t, 0.2, {["burnt-umber"]=0.2, ["paynes-gray"]=0.1})
  t:stroke({{772,y},{802,y+1}},{pressure=0.4,duration=0.03})
end
wait(4)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S=0.55
function seglines(b, pts, water, mix, pr, step)
  for i=1,#pts-1 do
    local a, c = pts[i], pts[i+1]
    local L = math.sqrt((c[1]-a[1])^2+(c[2]-a[2])^2)
    local n = math.max(1, math.floor(L/(step or 40)))
    for k=0,n-1 do
      topup(b, water, mix)
      local t0, t1 = k/n, (k+1)/n
      b:stroke({{a[1]+(c[1]-a[1])*t0, a[2]+(c[2]-a[2])*t0},{a[1]+(c[1]-a[1])*t1, a[2]+(c[2]-a[2])*t1}}, {pressure=pr or 0.5, duration=0.03})
    end
  end
end
function D(pts) local o={} for i,p in ipairs(pts) do o[i]={p[1]*S,p[2]*S} end return o end
local sh = {["paynes-gray"]=0.07, ["raw-umber"]=0.05, ["french-ultramarine"]=0.015}
local b = brush{name="ledge1", width=9}
seglines(b, D{{1470,240},{1640,105}}, 1.3, sh, 0.5, 40)
local c = brush{name="ledge2", width=12}
seglines(c, D{{1440,440},{2010,190}}, 1.6, sh, 0.5, 40)
local d = brush{name="ledge3", width=8}
seglines(d, D{{1440,515},{1650,460}}, 1.2, sh, 0.5, 40)
-- window frame sill under teal window
local f = brush{name="sill", width=6}
seglines(f, D{{1470,200},{1590,180}}, 0.9, {["paynes-gray"]=0.15, ["raw-umber"]=0.06}, 0.5, 40)
print(clock())
wait(6)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S=0.55
math.randomseed(77)
-- camellia flowers
local fl = brush{name="camellia", width=4}
local spots = {{505,618},{520,640},{560,600},{612,595},{640,610},{655,640},{690,600},{700,640},{735,610},{760,650},{575,630},{545,585},{790,620},{620,570},{720,575}}
for _,s in ipairs(spots) do
  topup(fl, 0.4, {["quinacridone-rose"]=0.35, ["pyrrol-scarlet"]=0.15})
  local x,y = s[1]*S + (math.random()-0.5)*4, s[2]*S
  fl:stroke({{x,y},{x+1.5,y+1}},{pressure=0.5,duration=0.03})
end
-- bare tree twigs behind left house, above hedge
local tw = brush{name="twig", width=1.4}
local function branch(x,y,a,len,depth)
  if depth==0 or len<6 then return end
  local x2 = x + math.cos(a)*len; local y2 = y + math.sin(a)*len
  topup(tw, 0.15, {["sepia"]=0.2, ["paynes-gray"]=0.15})
  tw:stroke({{x,y},{(x+x2)/2+(math.random()-0.5)*2,(y+y2)/2},{x2,y2}},{pressure=0.35,duration=0.03})
  branch(x2,y2,a-0.35-math.random()*0.3,len*0.7,depth-1)
  branch(x2,y2,a+0.3+math.random()*0.3,len*0.65,depth-1)
end
branch(258, 300, -1.75, 35, 4)
branch(270, 305, -1.25, 30, 4)
print(clock())
wait(5)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
local S=0.55
math.randomseed(91)
local fl = brush{name="camellia2", width=5}
local spots = {{505,618},{520,640},{560,600},{612,595},{640,610},{655,640},{690,600},{700,640},{735,610},{760,650},{575,630},{545,585},{790,620},{620,570},{720,575},{670,585},{595,650}}
for _,s in ipairs(spots) do
  topup(fl, 0.5, {["pyrrol-scarlet"]=0.5, ["cadmium-red"]=0.4, ["quinacridone-rose"]=0.15})
  local x,y = s[1]*S + (math.random()-0.5)*4, s[2]*S
  fl:stroke({{x,y},{x+1.5,y+1}},{pressure=0.5,duration=0.03})
end
local tw = brush{name="twig2", width=1.6}
local function branch(x,y,a,len,depth)
  if depth==0 or len<5 then return end
  local x2 = x + math.cos(a)*len; local y2 = y + math.sin(a)*len
  topup(tw, 0.18, {["sepia"]=0.3, ["paynes-gray"]=0.2})
  tw:stroke({{x,y},{(x+x2)/2+(math.random()-0.5)*3,(y+y2)/2},{x2,y2}},{pressure=0.35,duration=0.03})
  branch(x2,y2,a-0.3-math.random()*0.35,len*0.72,depth-1)
  branch(x2,y2,a+0.25+math.random()*0.35,len*0.68,depth-1)
end
branch(262, 300, -1.7, 40, 5)
branch(250, 302, -2.1, 30, 4)
branch(275, 298, -1.2, 28, 4)
print(clock())
wait(5)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
function fill(b, poly, dy, seg, mixf, opt)
  opt = opt or {}
  local ins = opt.inset or 0
  local ymin, ymax = 1e9, -1e9
  for _,p in ipairs(poly) do ymin = math.min(ymin,p[2]); ymax = math.max(ymax,p[2]) end
  local y = ymin + math.max(dy*0.5, ins)
  while y < ymax - ins*0.5 do
    for _,sp in ipairs(spans(poly, y)) do
      local x0, x1 = sp[1]+ins, sp[2]-ins
      local x = x0
      while x < x1 do
        local xe = math.min(x1, x + seg)
        local w, pig = mixf(y, x)
        topup(b, w, pig)
        b:stroke({{x, y},{xe, y}}, {pressure=opt.pressure or 0.5, duration=opt.dur or 0.02})
        x = xe
      end
    end
    y = y + dy
  end
end
-- concrete wall below the fence (cells). top edge follows bot(x) of fence
local function bot(xd) return (770 + (xd-1365)*0.44)*0.55 end
local poly = {}
for xd=1365,2020,80 do poly[#poly+1] = {xd*0.55, bot(xd)+3} end
poly[#poly+1] = {1112, 668}
poly[#poly+1] = {960, 668}
poly[#poly+1] = {752, 485}
local b = brush{name="concgrey", width=28}
fill(b, poly, 16, 50, function(y,x)
  local t = math.max(0, math.min(1, (x-750)/350))
  return 3.5, {["terre-verte"]=0.06+0.03*t, ["paynes-gray"]=0.04+0.03*t, ["raw-umber"]=0.02}
end, {inset=6})
print(clock())
wait(8)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
function spans(poly, y)
  local xs = {}
  local n = #poly
  for i=1,n do
    local a = poly[i]; local c = poly[i % n + 1]
    if (a[2] <= y and c[2] > y) or (c[2] <= y and a[2] > y) then
      xs[#xs+1] = a[1] + (y - a[2]) / (c[2]-a[2]) * (c[1]-a[1])
    end
  end
  table.sort(xs)
  local out = {}
  for i=1,#xs-1,2 do out[#out+1] = {xs[i], xs[i+1]} end
  return out
end
-- gate darkening glaze in vertical strokes
local g = brush{name="gatedark", width=22}
for x=6,248,13 do
  local ytop = (785 - ((x/0.55)+20)/472*69)*0.55 + 6
  local y = ytop
  while y < 668 do
    topup(g, 3.2, {["paynes-gray"]=0.18, ["sepia"]=0.08, ["french-ultramarine"]=0.04})
    g:stroke({{x,y},{x,y+50}},{pressure=0.45,duration=0.02})
    y = y + 50
  end
end
print(clock())
-- foreground road unifying glaze: soft top edge
local fr = {{300,560},{520,545},{700,580},{860,668},{300,668}}
for _,d in ipairs({{380,620},{470,610},{560,625},{650,640},{750,650}}) do drop{x=d[1],y=d[2],water=5,radius=45} end
local b = brush{name="fgroad", width=26}
local y = 560
while y < 668 do
  for _,sp in ipairs(spans(fr, y)) do
    local x = sp[1]+6
    while x < sp[2]-6 do
      topup(b, 3.5, {["paynes-gray"]=0.07, ["french-ultramarine"]=0.03, ["burnt-sienna"]=0.02})
      b:stroke({{x,y},{math.min(sp[2]-6,x+50),y}},{pressure=0.5,duration=0.02})
      x = x + 50
    end
  end
  y = y + 14
end
print(clock())
wait(10)
print(balance().dry)



function topup(b, water, pig)
  local s = b:status()
  local w = math.max(0, water - s.water)
  local p = {}
  for k,v in pairs(pig) do
    local have = s.pigments[k] or 0
    local d = math.max(0, v - have)
    if d > 0 then p[k]=math.min(10,d) end
  end
  b:load{water=math.min(100,w), pigments=p}
end
-- latch handle, lighter metal on dark gate
local l = brush{name="latch3", width=4}
topup(l, 0.6, {["buff-titanium"]=0.7, ["paynes-gray"]=0.15})
l:stroke({{102,478},{165,458}},{pressure=0.55,duration=0.1})
local l2 = brush{name="latch4", width=2}
topup(l2, 0.3, {["lamp-black"]=0.5,["paynes-gray"]=0.3})
l2:stroke({{102,481},{165,461}},{pressure=0.5,duration=0.1})
-- signature: "C" + "26" small, lower right on concrete
local s = brush{name="sig", width=1.6}
local m = {["sepia"]=0.35, ["paynes-gray"]=0.2}
local function arc(cx,cy,r,a0,a1,n)
  local p={} for k=0,n do local a=a0+(a1-a0)*k/n p[#p+1]={cx+r*math.cos(a), cy+r*math.sin(a)} end return p end
topup(s,0.3,m); s:stroke(arc(1050,645,5,-0.7*math.pi*-1+0.0, 1.75*math.pi,10),{pressure=0.4,duration=0.1})
topup(s,0.3,m); s:stroke({{1062,640},{1065,638},{1067,641},{1061,650},{1068,650}},{pressure=0.4,duration=0.1})
topup(s,0.3,m); s:stroke({{1077,638},{1072,644},{1072,649},{1076,650},{1078,646},{1073,645}},{pressure=0.4,duration=0.1})
wait(6)
print(balance().dry)



local s = brush{name="sig2", width=2.2}
local function ld() local st=s:status(); s:load{water=math.max(0,0.6-st.water), pigments={["sepia"]=0.5, ["lamp-black"]=0.3}} end
ld(); s:stroke({{1056,640},{1051,639},{1047,643},{1047,649},{1051,652},{1056,651}},{pressure=0.5,duration=0.15})
ld(); s:stroke({{1061,642},{1064,639},{1068,641},{1062,651},{1069,651}},{pressure=0.5,duration=0.15})
ld(); s:stroke({{1078,639},{1073,645},{1073,650},{1077,652},{1079,648},{1074,646}},{pressure=0.5,duration=0.15})
wait(5)
print(balance().dry)
