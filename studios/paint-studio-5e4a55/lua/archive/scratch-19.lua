-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
glowrefl = pile{{"lead white",3},{"yellow ochre",1.4},{"chrome yellow",0.4},{"red earth",0.25},{"raw umber",0.15}, name="glowrefl"}
waterdark = pile{{"raw umber",2},{"Prussian blue",0.5},{"red earth",0.7},{"green earth",0.4}, name="waterdark"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
reflrust = pile{{"red earth",0.345},{"raw umber",0.378},{"vermilion",0.056},{"chrome yellow",0.105},{"yellow ochre",0.053},{"Prussian blue",0.035},{"green earth",0.028}, name="reflrust"}
local f1 = rect(100, 100, 800, 200)
work(f1, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {haze, 0.3}}})
blend(f1:shrink(3), {angle=math.pi/2})
local f2 = rect(100, 400, 800, 200)
work(f2, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {reflrust, function(x,y) return clamp((x - 650)/100, 0, 1) end}, {haze, 0.3}}})
blend(f2:shrink(3), {angle=math.pi/2})
wait(60*24*60)
print(drying(500, 200), drying(200, 500))

--@ chunk 3
gA = pile{{"raw umber",1},{"smalt",0.5},{"red earth",0.15}, medium=0.6, name="gA"}
gB = pile{{"raw umber",1},{"cobalt blue",0.4},{"lead white",0.6}, medium=0.6, name="gB"}
gC = pile{{"raw umber",1},{"smalt",0.6},{"lead white",0.5},{"red earth",0.1}, medium=0.7, name="gC"}
-- three vertical bands across f1: gA, gB, gC
work(rect(120, 110, 240, 180), {hand="glaze", pile=gA, coverage=1, angle=math.pi/2, seed=1})
work(rect(380, 110, 240, 180), {hand="glaze", pile=gB, coverage=1, angle=math.pi/2, seed=2})
work(rect(640, 110, 240, 180), {hand="glaze", pile=gC, coverage=1, angle=math.pi/2, seed=3})
-- ripple trials on f2
local rr = brush{kind="round", width=1.8, point=0.7}
local y = 410
local k = 0
while y < 590 do
  k = k + 1
  local gap = lerp(3, 14, (y - 410)/180)
  local n = math.random(1, 3)
  for j = 1, n do
    local x0 = rand(120, 860)
    local L = lerp(12, 70, (y - 410)/180) * rand(0.6, 1.3)
    local xm = x0 + L/2
    local dark = math.abs(xm - 500) < 200
    rr:reload(dark and waterdark or haze, 0.35)
    rr:stroke({{x0, y}, {x0 + L*0.5, y + rand(-0.3, 0.3)}, {x0 + L, y + rand(-0.3, 0.3)}}, {pressure={0.25, 0.1}, ramps={0.35, 0.45}})
  end
  y = y + gap * rand(0.7, 1.3)
end

--@ chunk 4
local f3 = rect(100, 700, 800, 260)
work(f3, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {reflrust, function(x,y) return clamp((x - 650)/100, 0, 1) end}, {haze, 0.3}}})
blend(f3:shrink(3), {angle=math.pi/2})
wait(60*24*60)
rippleD = mix{{glowrefl, 1}, {waterdark, 0.5}, name="rippleD"}
rippleL = mix{{haze, 1}, {waterdark, 0.35}, name="rippleL"}
local fb = brush{kind="flat", width=4, stiffness=0.5}
local y = 712
while y < 950 do
  local t = (y - 712)/240
  local gap = lerp(4, 18, t)
  local n = math.random(1, 2)
  for j = 1, n do
    local x0 = rand(110, 840)
    local L = lerp(15, 90, t) * rand(0.6, 1.3)
    local xm = x0 + L/2
    local onLight = math.abs(xm - 500) < 200
    fb:reload(onLight and rippleD or rippleL, 0.3)
    local w = lerp(0.12, 0.3, t)
    fb:stroke({{x0, y}, {x0 + L*0.33, y + rand(-0.6, 0.6)}, {x0 + L*0.66, y + rand(-0.6, 0.6)}, {x0 + L, y + rand(-0.6, 0.6)}}, {pressure={w, w*0.6}, orient="across", ramps={0.35, 0.45}})
  end
  y = y + gap * rand(0.7, 1.3)
end

--@ chunk 5
local f4 = rect(100, 1000, 800, 220)
work(f4, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {reflrust, function(x,y) return clamp((x - 650)/100, 0, 1) end}, {haze, 0.3}}})
blend(f4:shrink(3), {angle=math.pi/2})
wait(60*24*60)
-- bands: soft ribbons, wavy
local bands = nil
local y = 1010
local i = 0
while y < 1210 do
  i = i + 1
  local t = (y - 1010)/200
  local x0 = rand(100, 500)
  local L = lerp(120, 400, t) * rand(0.6, 1.2)
  local w = lerp(2, 6, t)
  local pts = {}
  for k = 0, 6 do pts[#pts+1] = {x0 + L*k/6, y + 1.2*math.sin(k*1.7 + i)} end
  local r = ribbon(pts, w):soften(1.5)
  bands = bands and (bands + r) or r
  y = y + lerp(6, 26, t) * rand(0.7, 1.3)
end
print(bands:area())
work(bands * rect(100, 1000, 800, 220), {hand="glaze", pile=gB, coverage=1, angle=0.0, tool={kind="filbert", width=6, stiffness=0.3}, clip=true, seed=7})

--@ chunk 6
local f5 = rect(100, 1240, 800, 0)
-- reuse the first field (f1 bottom part is glazed); paint a new field below on the scratch: canvas H = 1250, so use f2's top band region? use x 100..900, y 300..390 (blank) no: make a new field at y 620..690
local f5 = rect(100, 615, 800, 80)
work(f5, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {reflrust, function(x,y) return clamp((x - 650)/100, 0, 1) end}, {haze, 0.3}}})
blend(f5:shrink(3), {angle=math.pi/2})
local f6 = rect(100, 310, 800, 80)
work(f6, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {reflrust, function(x,y) return clamp((x - 650)/100, 0, 1) end}, {haze, 0.3}}})
blend(f6:shrink(3), {angle=math.pi/2})
wait(60*24*60)
function tbands(x0, x1, y0, y1, gap0, gap1, L0, L1, w0, w1, seed)
  math.randomseed(seed)
  local bands = nil
  local y = y0
  local i = 0
  while y < y1 do
    i = i + 1
    local t = (y - y0)/(y1 - y0)
    local nseg = math.random(1, 3)
    local xs = rand(x0 - 50, x1 - 100)
    for s = 1, nseg do
      local L = lerp(L0, L1, t) * rand(0.4, 1.0)
      local w = lerp(w0, w1, t) * rand(0.7, 1.2)
      local pts, ws = {}, {}
      for k = 0, 8 do
        local u = k/8
        pts[#pts+1] = {xs + L*u, y + 0.9*math.sin(u*5 + i + s)}
        ws[#ws+1] = w * math.sin(math.pi * u)^0.7 * (0.6 + 0.4*math.sin(u*9 + i))
      end
      local r = ribbon(pts, ws)
      bands = bands and (bands + r) or r
      xs = xs + L + rand(8, 40)
    end
    y = y + lerp(gap0, gap1, t) * rand(0.6, 1.4)
  end
  return bands
end
local b1 = tbands(100, 900, 312, 388, 4, 12, 40, 160, 1.5, 3.5, 21) * rect(100, 310, 800, 80)
local b2 = tbands(100, 900, 617, 693, 8, 22, 120, 380, 2.5, 6, 22) * rect(100, 615, 800, 80)
print(b1:area(), b2:area())
work(b1, {hand="glaze", pile=gB, coverage=1, angle=0.0, tool={kind="filbert", width=5, stiffness=0.3}, clip=true, seed=8})
work(b2, {hand="glaze", pile=gB, coverage=1, angle=0.0, tool={kind="filbert", width=6, stiffness=0.3}, clip=true, seed=9})

--@ chunk 7
local f7 = rect(100, 20, 800, 70)
work(f7, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, 1.5}, {haze, 0.3}}})
blend(f7:shrink(3), {angle=math.pi/2})
wait(60*24*60)
gA2 = pile{{"raw umber",1},{"smalt",0.5},{"red earth",0.15}, medium=0.8, name="gA2"}
gD = pile{{"raw umber",1},{"smalt",0.8},{"lead white",0.3},{"red earth",0.2}, medium=0.75, name="gD"}
work(rect(120, 25, 180, 60), {hand="glaze", pile=gA, coverage=1, angle=math.pi/2, seed=11})
work(rect(320, 25, 180, 60), {hand="glaze", pile=gA2, coverage=1, angle=math.pi/2, seed=12})
work(rect(520, 25, 180, 60), {hand="glaze", pile=gD, coverage=1, angle=math.pi/2, seed=13})

--@ chunk 8
local f8 = rect(100, 1225, 800, 22)
local f9 = rect(100, 400, 800, 0)
-- glaze over the unglazed right part of f7 then blend
local zone = rect(720, 22, 175, 66)
work(zone, {hand="glaze", pile=gD, coverage=1, angle=math.pi/2, seed=14})
blend(zone:shrink(3), {angle=math.pi/2})

--@ chunk 9
gD2 = pile{{"raw umber",1},{"smalt",0.8},{"lead white",0.3},{"red earth",0.2}, medium=0.82, name="gD2"}
-- streaked yellow field on clean ground, x 100..500, y 1230..? canvas is 1250 tall: use the f3 field's right half? It has ripples. Use a new field at x 100..900, y 395..? occupied? 300-390 is f6. Use the lower part: f4 is 1000-1220. Paint a new field over the old f1 (dry): y 100..300
local f = rect(100, 100, 800, 200)
work(f, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {haze, 0.3}}})
blend(f:shrink(3), {angle=math.pi/2})
wait(60*24*60)
local nt = noise{seed=31, period=10, octaves=2}
local top = mask(function(x, y)
  if x < 340 or x > 660 or y > 296 then return 0 end
  local t = 160 + 25*nt(x*0.6, 0) + 15*math.sin(x/7)
  return (y > t) and 1 or 0
end)
local deeper = mask(function(x, y)
  if x < 380 or x > 620 or y > 296 then return 0 end
  local t = 210 + 25*nt(x*0.6, 9) + 12*math.sin(x/5)
  return (y > t) and 1 or 0
end)
work(top, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=8, stiffness=0.3}, seed=21})
work(deeper, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=8, stiffness=0.3}, seed=22})

--@ chunk 10
local f = rect(100, 700, 800, 260)
work(f, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {haze, 0.3}}})
blend(f:shrink(3), {angle=math.pi/2})
wait(60*24*60)
function wbands(x0, x1, y0, y1, gap0, gap1, L0, L1, w0, w1, seed)
  math.randomseed(seed)
  local bands = nil
  local y = y0
  local i = 0
  while y < y1 do
    i = i + 1
    local t = (y - y0)/(y1 - y0)
    local L = lerp(L0, L1, t) * rand(0.7, 1.2)
    local xs = rand(x0, x1 - L*0.6)
    local w = lerp(w0, w1, t) * rand(0.6, 1.3)
    local pts, ws = {}, {}
    for k = 0, 10 do
      local u = k/10
      pts[#pts+1] = {xs + L*u, y + 1.5*math.sin(u*4 + i)}
      ws[#ws+1] = w * math.sin(math.pi * u)^0.5 * (0.7 + 0.3*math.sin(u*7 + i*2))
    end
    local r = ribbon(pts, ws)
    bands = bands and (bands + r) or r
    y = y + lerp(gap0, gap1, t) * rand(0.6, 1.4)
  end
  return bands
end
local b = wbands(300, 700, 710, 955, 10, 26, 160, 320, 3, 11, 41) * rect(100, 700, 800, 260)
print(b:area())
work(b, {hand="glaze", pile=gD2, coverage=1, angle=0.0, tool={kind="filbert", width=8, stiffness=0.3}, clip=true, seed=23})
work(b:shrink(1.5), {hand="glaze", pile=gD2, coverage=1, angle=0.0, tool={kind="filbert", width=6, stiffness=0.3}, clip=true, seed=24})

--@ chunk 11
lightG = pile{{"lead white",3},{"yellow ochre",0.5},{"smalt",0.4},{"red earth",0.1}, medium=0.7, name="lightG"}
local b = wbands(110, 330, 710, 955, 5, 16, 30, 110, 1.5, 4, 51) * rect(100, 700, 800, 260)
local b2 = wbands(720, 900, 710, 955, 5, 16, 30, 110, 1.5, 4, 52) * rect(100, 700, 800, 260)
print(b:area(), b2:area())
work(b + b2, {hand="glaze", pile=lightG, coverage=1, angle=0.0, tool={kind="filbert", width=5, stiffness=0.3}, clip=true, seed=25})

--@ chunk 12
lightG2 = pile{{"lead white",3},{"yellow ochre",0.5},{"smalt",0.4},{"red earth",0.1}, medium=0.85, name="lightG2"}
local f = rect(100, 400, 800, 200)
work(f, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {haze, 0.3}}})
blend(f:shrink(3), {angle=math.pi/2})
wait(60*24*60)
local b = wbands(110, 330, 410, 595, 6, 14, 40, 120, 1.2, 3, 61) * rect(100, 400, 800, 200)
work(b, {hand="glaze", pile=lightG2, coverage=1, angle=0.0, tool={kind="filbert", width=5, stiffness=0.3}, clip=true, seed=26})
-- streaky graying glaze over the gold
local ns = noise{seed=71, period=9, octaves=2, stretch={math.pi/2, 8}}
local sm = mask(function(x, y)
  if x < 360 or x > 640 or y < 405 or y > 595 then return 0 end
  return clamp((ns:at01(x, y) - 0.42) * 6, 0, 1)
end)
print(sm:area())
work(sm, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=6, stiffness=0.3}, seed=27})

--@ chunk 13
local f = rect(100, 1000, 800, 220)
work(f, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{glowrefl, function(x,y) return clamp(1 - math.abs(x - 500)/250, 0, 1)*1.5 end}, {waterdark, function(x,y) return clamp((math.abs(x - 500) - 150)/150, 0, 1) end}, {haze, 0.3}}})
blend(f:shrink(3), {angle=math.pi/2})
wait(60*24*60)
local ns = noise{seed=81, period=10, octaves=3, stretch={math.pi/2, 10}}
local gm = mask(function(x, y)
  if y < 1004 or y > 1216 then return 0 end
  local half = 170 + 30*ns(x, y)
  local top = 1030 + 20*ns(x*1.3, 50)
  return ((math.abs(x - 500) < half) and (y > top)) and 1 or 0
end)
print(gm:area())
work(gm, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=8, stiffness=0.3}, seed=28})

--@ chunk 14
palette{scrape={gA, gB, gC, rippleD, rippleL, gA2, gD, lightG}}
mA_ = mix{{waterdark, 0.4}, {haze, 0.6}, name="mA_"}
mB_ = mix{{glowrefl, 0.75}, {waterdark, 0.12}, {haze, 0.13}, name="mB_"}
mC_ = mix{{waterdark, 0.5}, {haze, 0.5}, name="mC_"}
work(rect(110, 1225, 60, 20), {hand="body", tool={kind="flat", width=8}, length={20,40}, coverage=4, fill=true, clip=true, pile=mA_})
work(rect(190, 1225, 60, 20), {hand="body", tool={kind="flat", width=8}, length={20,40}, coverage=4, fill=true, clip=true, pile=mB_})
work(rect(270, 1225, 60, 20), {hand="body", tool={kind="flat", width=8}, length={20,40}, coverage=4, fill=true, clip=true, pile=mC_})
