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
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
waterdark = pile{{"raw umber",2},{"Prussian blue",0.5},{"red earth",0.7},{"green earth",0.4}, name="waterdark"}
glowrefl = pile{{"lead white",3},{"yellow ochre",1.4},{"chrome yellow",0.4},{"red earth",0.25},{"raw umber",0.15}, name="glowrefl"}
foamsh = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.35},{"yellow ochre",0.1}, name="foamsh"}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
-- gray-tan pool, values ~120-150
local pool = rect(100, 300, 800, 300)
work(pool, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{waterdark, 0.6}, {haze, 0.7}, {glowrefl, function(x,y) return 0.3*clamp((y - 400)/150, 0, 1) end}}})
blend(pool:shrink(3), {angle=math.pi/2})
-- foam plate above with a scalloped bottom
local fo = outline{{150,250},{850,250},{850,330},{820,338},{790,332},{760,340},{730,334},{700,342},{670,336},{640,343},{610,336},{580,342},{550,335},{520,343},{490,336},{460,342},{430,335},{400,343},{370,336},{340,342},{310,335},{280,342},{250,336},{220,341},{190,334},{150,330}, char="soft", seed=5, amount=0.4, lobe=6}:mask()
work(fo, {hand="body", tool={kind="round", width=5}, length={5,12}, coverage=4, fill=true, clip=true, angle=0, piles={{foamsh, 1}, {fallwhite, 0.7}}})
blend(fo:shrink(2), {angle=0})
wait(60*24*60)
print(drying(500, 300), drying(500, 450))

--@ chunk 3
gD2 = pile{{"raw umber",1},{"smalt",0.8},{"lead white",0.3},{"red earth",0.2}, medium=0.82, name="gD2"}
foamG = pile{{"lead white",4},{"yellow ochre",0.2},{"cobalt blue",0.1}, medium=0.7, name="foamG"}
function wb2(x0, x1, y0, y1, gap0, gap1, L0, L1, w0, w1, seed)
  math.randomseed(seed)
  local bands = nil
  local y = y0
  local i = 0
  while y < y1 do
    i = i + 1
    local t = (y - y0)/(y1 - y0)
    local L = lerp(L0, L1, t) * rand(0.6, 1.2)
    local xs = rand(x0 - L*0.3, x1 - L*0.7)
    local w = lerp(w0, w1, t) * rand(0.7, 1.3)
    local pts, ws = {}, {}
    for k = 0, 10 do
      local u = k/10
      pts[#pts+1] = {xs + L*u, y + 0.8*math.sin(u*4 + i)}
      ws[#ws+1] = w * math.sin(math.pi * u)^0.5 * (0.7 + 0.3*math.sin(u*7 + i*2))
    end
    local r = ribbon(pts, ws)
    bands = bands and (bands + r) or r
    y = y + lerp(gap0, gap1, t) * rand(0.6, 1.4)
  end
  return bands
end
-- left half: dark ribbons across the foam's bottom 20 units, one film; right half: two films
local dL = wb2(150, 500, 318, 345, 3, 5, 60, 140, 2, 3.5, 101) * rect(140, 310, 360, 45)
local dR = wb2(500, 850, 318, 345, 3, 5, 60, 140, 2, 3.5, 102) * rect(500, 310, 360, 45)
work(dL, {hand="glaze", pile=gD2, coverage=1, angle=0.0, tool={kind="filbert", width=5, stiffness=0.3}, clip=true, seed=1})
work(dR, {hand="glaze", pile=gD2, coverage=1, angle=0.0, tool={kind="filbert", width=5, stiffness=0.3}, clip=true, seed=2})
work(dR, {hand="glaze", pile=gD2, coverage=1, angle=0.0, tool={kind="filbert", width=5, stiffness=0.3}, clip=true, seed=3})
-- pale trailing ribbons below
local pL = wb2(200, 800, 345, 420, 5, 16, 50, 160, 2.5, 3.5, 103) * rect(140, 340, 720, 90)
work(pL, {hand="glaze", pile=foamG, coverage=1, angle=0.0, tool={kind="filbert", width=5, stiffness=0.3}, clip=true, seed=4})
print(dL:area(), dR:area(), pL:area())

--@ chunk 4
local pool = rect(100, 750, 800, 300)
work(pool, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{waterdark, 0.6}, {haze, 0.7}, {glowrefl, function(x,y) return 0.3*clamp((y - 850)/150, 0, 1) end}}})
blend(pool:shrink(3), {angle=math.pi/2})
local fo = outline{{150,700},{850,700},{850,780},{820,788},{790,782},{760,790},{730,784},{700,792},{670,786},{640,793},{610,786},{580,792},{550,785},{520,793},{490,786},{460,792},{430,785},{400,793},{370,786},{340,792},{310,785},{280,792},{250,786},{220,791},{190,784},{150,780}, char="soft", seed=5, amount=0.4, lobe=6}:mask()
work(fo, {hand="body", tool={kind="round", width=5}, length={5,12}, coverage=4, fill=true, clip=true, angle=0, piles={{foamsh, 1}, {fallwhite, 0.7}}})
blend(fo:shrink(2), {angle=0})
wait(60*24*60)
gapP = mix{{waterdark, 0.45}, {haze, 0.55}, name="gapP"}
foamP = mix{{foamsh, 0.7}, {haze, 0.3}, name="foamP"}
-- dark water gaps cutting into the foam's lower band
local gaps = wb2(150, 850, 762, 792, 4, 6, 40, 110, 2.5, 4, 201) * rect(140, 755, 720, 45)
-- foam patches drifting on the water below, thinning and graying downward
local drift = wb2(150, 850, 794, 880, 4, 14, 90, 40, 4, 1.5, 202) * rect(140, 790, 720, 100)
print(gaps:area(), drift:area())
work(gaps, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,16}, coverage=3, fill=true, clip=true, load=0.9, angle=0, pile=gapP})
work(drift, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,16}, coverage=3, fill=true, clip=true, load=0.9, angle=0,
  piles={{foamP, function(x,y) return clamp(1 - (y - 794)/80, 0.1, 1) end}, {gapP, function(x,y) return clamp((y - 800)/80, 0, 1) end}}})

--@ chunk 5
local pool = rect(100, 1100, 800, 150)
work(pool, {hand="body", tool={kind="flat", width=10}, length={30,80}, coverage=4, fill=true, clip=true, angle=math.pi/2,
  piles={{waterdark, 0.6}, {haze, 0.7}}})
blend(pool:shrink(3), {angle=math.pi/2})
local fo = outline{{150,1060},{850,1060},{850,1130},{820,1138},{790,1132},{760,1140},{730,1134},{700,1142},{670,1136},{640,1143},{610,1136},{580,1142},{550,1135},{520,1143},{490,1136},{460,1142},{430,1135},{400,1143},{370,1136},{340,1142},{310,1135},{280,1142},{250,1136},{220,1141},{190,1134},{150,1130}, char="soft", seed=5, amount=0.4, lobe=6}:mask()
work(fo, {hand="body", tool={kind="round", width=5}, length={5,12}, coverage=4, fill=true, clip=true, angle=0, piles={{foamsh, 1}, {fallwhite, 0.7}}})
blend(fo:shrink(2), {angle=0})
wait(60*24*60)
-- tongues and bites across the edge (edge ~ y 1138)
function edgeBands(x0, x1, yE, n, seed, kind)
  math.randomseed(seed)
  local m = nil
  for i = 1, n do
    local L = rand(30, 90)
    local xs = rand(x0, x1 - L)
    local y = yE + ((kind == "bite") and rand(-8, 2) or rand(-2, 8))
    local w = rand(3.5, 6.5)
    local slope = rand(-0.03, 0.06)
    local pts, ws = {}, {}
    for k = 0, 10 do
      local u = k/10
      pts[#pts+1] = {xs + L*u, y + slope*L*u + 0.8*math.sin(u*4 + i)}
      ws[#ws+1] = w * math.sin(math.pi * u)^0.5
    end
    local r = ribbon(pts, ws)
    m = m and (m + r) or r
  end
  return m
end
local bites = edgeBands(150, 850, 1137, 16, 301, "bite")
local tongues = edgeBands(150, 850, 1140, 14, 302, "tongue") - bites
local drift = wb2(150, 850, 1150, 1235, 3, 10, 80, 35, 4.5, 1.5, 303) * rect(140, 1145, 720, 100)
work(bites, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,16}, coverage=3, fill=true, clip=true, load=0.9, angle=0, pile=gapP})
work(tongues, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,16}, coverage=3, fill=true, clip=true, load=0.9, angle=0, piles={{foamsh, 1}, {fallwhite, 0.5}}})
work(drift, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,16}, coverage=3, fill=true, clip=true, load=0.9, angle=0,
  piles={{foamP, function(x,y) return clamp(1 - (y - 1150)/80, 0.1, 1) end}, {gapP, function(x,y) return clamp((y - 1155)/80, 0, 1) end}}})

--@ chunk 6
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
palette{scrape={glowrefl, gD2, foamG}}
w1 = mix{{haze, 0.62}, {waterdark, 0.28}, {amber, 0.10}, name="w1"}
w2 = mix{{haze, 0.70}, {waterdark, 0.22}, {amber, 0.08}, name="w2"}
fp = mix{{foamsh, 0.75}, {haze, 0.25}, name="fp"}
work(rect(110, 20, 60, 20), {hand="body", tool={kind="flat", width=8}, length={20,40}, coverage=4, fill=true, clip=true, pile=w1})
work(rect(190, 20, 60, 20), {hand="body", tool={kind="flat", width=8}, length={20,40}, coverage=4, fill=true, clip=true, pile=w2})
work(rect(270, 20, 60, 20), {hand="body", tool={kind="flat", width=8}, length={20,40}, coverage=4, fill=true, clip=true, pile=fp})

--@ chunk 7
palette{scrape={w2, fp, gapP}}
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
local bg = rect(100, 612, 800, 76)
work(bg, {hand="body", tool={kind="flat", width=8}, length={20,50}, coverage=4, fill=true, clip=true, angle=-math.pi/2, piles={{haze, 1}, {amber, 0.8}, {deeprust, 0.16}}})
local st = ellipse(500, 670, 260, 30) * rect(100, 612, 800, 76)
work(st, {hand="body", tool={kind="flat", width=4}, length={10,30}, coverage=4, fill=true, clip=true, angle=0, piles={{haze, 0.8}, {glow, 0.6}, {fallwhite, 0.2}, {foamsh, 0.3}}})
blend(st:shrink(1), {angle=0})
wait(60*24*60)
tanG = pile{{"yellow ochre",1},{"red earth",0.35},{"raw umber",0.3}, medium=0.8, name="tanG"}
local nr = noise{seed=5, period=12, octaves=2}
-- left half: one film; right half: two films; covering from the top down to a level ragged line y ~ 662
local g1 = mask(function(x, y) if x < 100 or x > 900 or y < 612 or y > 688 then return 0 end; local b = 662 + 2.5*nr(x, 0); return (y < b) and 1 or 0 end)
work(g1, {hand="glaze", pile=tanG, coverage=1, angle=0, tool={kind="filbert", width=8, stiffness=0.3}, seed=1})
work(g1 * rect(500, 600, 400, 100), {hand="glaze", pile=tanG, coverage=1, angle=0, tool={kind="filbert", width=8, stiffness=0.3}, seed=2})
