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
rustc = pile{{"red earth",2},{"yellow ochre",1.3},{"vermilion",0.3},{"raw umber",0.35}, name="rustc"}
birch = pile{{"lead white",8},{"yellow ochre",0.25},{"chrome yellow",0.05}, name="birch"}
birch_mid = pile{{"lead white",5},{"raw umber",0.4},{"yellow ochre",0.3},{"smalt",0.4}, name="birch_mid"}
lent = pile{{"bone black",1},{"raw umber",1.2}, name="lent"}
work(rect(0, 0, 1000, 620), {hand="broad", pile=rustc, coverage=3, fill=true})
for i, x in ipairs({150, 350, 550, 750}) do
  local m = poly({{x-13, 20}, {x+13, 20}, {x+14, 590}, {x-14, 590}}):roughen(1.5, 12, i)
  work(m, {hand="body", tool={kind="flat", width=7}, length={20, 50}, angle=-math.pi/2, coverage=3, fill=true, clip=true,
    piles={{birch, function(xx, y) return clamp(1 - (xx - x + 13)/26, 0.15, 1) end}, {birch_mid, function(xx, y) return clamp((xx - x + 13)/26, 0, 0.85) end}}})
  local r = brush{kind="round", width=4, point=0.6}
  for j = 1, 14 do
    local y = 40 + j * 38 + rand(-8, 8)
    local x0 = x - 13 + rand(0, 10)
    r:reload(lent, 0.6)
    r:gesture({{x0, y, 0.2}, {x0 + rand(5, 10), y - 1, 0.7}, {x0 + rand(12, 18), y, 0.1}})
  end
end
print(wait(60 * 24 * 60))

--@ chunk 3
barkglaze = pile{{"raw umber",1},{"smalt",0.6}, medium=0.6, name="barkglaze"}
barkwarm = pile{{"raw umber",1},{"smalt",0.5},{"red earth",0.25}, medium=0.6, name="barkwarm"}
bark7 = pile{{"raw umber",1},{"smalt",0.6}, medium=0.7, name="bark7"}
local tool = {kind="filbert", width=12, stiffness=0.3}
for i, spec in ipairs({{150, barkglaze}, {350, barkwarm}, {550, bark7}}) do
  local x, p = spec[1], spec[2]
  for _, yb in ipairs({590, 400, 200}) do
    local m = rect(x - 13, 15, 26, yb - 15)
    work(m, {hand="glaze", pile=p, coverage=1, angle=-math.pi/2, tool=tool, clip=true})
  end
end
print(wait(60))

--@ chunk 4
bark75 = pile{{"raw umber",1},{"smalt",0.6}, medium=0.75, name="bark75"}
local tool = {kind="filbert", width=12, stiffness=0.3}
for _, yb in ipairs({590, 480, 370, 260, 150}) do
  work(rect(737, 15, 26, yb - 15), {hand="glaze", pile=bark75, coverage=1, angle=-math.pi/2, tool=tool, clip=true})
end
print(wait(60))

--@ chunk 5
trunks2 = {}
for i, x in ipairs({250, 450, 650}) do
  local m = poly({{x-13, 20}, {x+13, 20}, {x+14, 590}, {x-14, 590}}):roughen(1.5, 12, i + 10)
  trunks2[i] = m
  work(m, {hand="body", tool={kind="flat", width=7}, length={20, 50}, angle=-math.pi/2, coverage=3, fill=true, clip=true,
    piles={{birch, function(xx, y) return clamp(1 - (xx - x + 13)/26, 0.15, 1) end}, {birch_mid, function(xx, y) return clamp((xx - x + 13)/26, 0, 0.85) end}}})
  local r = brush{kind="round", width=4, point=0.6}
  for j = 1, 14 do
    local y = 40 + j * 38 + rand(-8, 8)
    local x0 = x - 13 + rand(0, 10)
    r:reload(lent, 0.6)
    r:gesture({{x0, y, 0.2}, {x0 + rand(5, 10), y - 1, 0.7}, {x0 + rand(12, 18), y, 0.1}})
  end
end
print(wait(60 * 24 * 60))

--@ chunk 6
local tool = {kind="filbert", width=18, stiffness=0.3}
-- T250: barkglaze, 3 nested films, bottoms fading (clip to the trunk, work mask above the step)
for _, yb in ipairs({400, 260, 130}) do
  work(trunks2[1] * rect(0, 0, 1000, yb), {hand="glaze", pile=barkglaze, coverage=1, angle=-math.pi/2, tool=tool, clip=trunks2[1]})
end
-- T450: bark75, 4 nested films, fading bottoms
for _, yb in ipairs({400, 300, 200, 110}) do
  work(trunks2[2] * rect(0, 0, 1000, yb), {hand="glaze", pile=bark75, coverage=1, angle=-math.pi/2, tool=tool, clip=trunks2[2]})
end
print(wait(60))

--@ chunk 7
work(rect(0, 640, 1000, 610), {hand="broad", pile=rustc, coverage=3, fill=true})
trunks3 = {}
for i, x in ipairs({100, 250, 400, 550, 700, 850}) do
  local m = poly({{x-13, 660}, {x+13, 660}, {x+14, 1230}, {x-14, 1230}}):roughen(1.5, 12, i + 20)
  trunks3[i] = m
  work(m, {hand="body", tool={kind="flat", width=7}, length={20, 50}, angle=-math.pi/2, coverage=3, fill=true, clip=true,
    piles={{birch, function(xx, y) return clamp(1 - (xx - x + 13)/26, 0.15, 1) end}, {birch_mid, function(xx, y) return clamp((xx - x + 13)/26, 0, 0.85) end}}})
  local r = brush{kind="round", width=4, point=0.6}
  for j = 1, 14 do
    local y = 680 + j * 38 + rand(-8, 8)
    local x0 = x - 13 + rand(0, 10)
    r:reload(lent, 0.6)
    r:gesture({{x0, y, 0.2}, {x0 + rand(5, 10), y - 1, 0.7}, {x0 + rand(12, 18), y, 0.1}})
  end
end
print(wait(60 * 24 * 60))

--@ chunk 8
bark5 = pile{{"raw umber",1},{"smalt",0.6}, medium=0.5, name="bark5"}
bt = pile({{"raw umber",1},{"smalt",0.6}, turps=0.6, name="bt"})
bt2 = pile({{"raw umber",1},{"smalt",0.6},{"lead white",0.4}, turps=0.5, name="bt2"})
birch_shade = pile{{"lead white",3},{"raw umber",0.55},{"smalt",0.5},{"red earth",0.12},{"yellow ochre",0.1}, name="birch_shade"}
local tool = {kind="filbert", width=18, stiffness=0.3}
for i, p in ipairs({bark5, bt, bt2}) do
  local m = trunks3[i]
  work(m, {hand="glaze", pile=p, coverage=1, angle=-math.pi/2, tool=tool, clip=m})
  work(m * rect(0, 0, 1000, 900), {hand="glaze", pile=p, coverage=1, angle=-math.pi/2, tool=tool, clip=m})
end
work(trunks3[4] * rect(0, 0, 1000, 900), {hand="body", pile=birch_shade, tool={kind="flat", width=7}, length={20, 50}, angle=-math.pi/2, coverage=2, fill=true, clip=trunks3[4]})
work(trunks3[5] * rect(0, 0, 1000, 900), {hand="scumble", pile=birch_shade, coverage=1, angle=-math.pi/2, clip=trunks3[5]})
print(wait(60))

--@ chunk 9
local m = trunks3[6]
local tool = {kind="filbert", width=12, stiffness=0.3}
for k, yb in ipairs({1000, 900, 800, 720}) do
  local n = noise{seed=40 + k, period=30, octaves=2}
  local cut = above(function(x) return yb + 5 * n(x, yb) + 0.25 * (x - 850) end)
  local wm = m * cut
  print(k, wm:area())
  work(wm, {hand="glaze", pile=bark75, coverage=1, angle=-math.pi/2, tool=tool, clip=m})
end
print(wait(60))

--@ chunk 10
print(wait(60*24*60))

--@ chunk 11
-- right edge of trunks2[2] (x 450) and the bark75x5 bar (737..763)
local function redge(m, y) local xr; for x = 400, 800 do if m:at(x, y) > 0.5 and x < (m == trunks2[2] and 500 or 800) then xr = x end end; return xr end
local xr = {}
for y = 40, 460, 20 do local v; for x = 430, 480 do if trunks2[2]:at(x, y) > 0.5 then v = x end end; xr[y] = v end
print(xr[60], xr[160], xr[300])
-- tapered ribbons: pointed both ends, centre on the edge, wobble low-freq
function edgeRibbon(xEdge, y0, y1, reachIn, reachOut, seed)
  local n = noise{seed=seed, period=40, octaves=2}
  local L, R = {}, {}
  local steps = 12
  for i = 0, steps do
    local t = i / steps
    local y = lerp(y0, y1, t)
    local w = math.sin(math.pi * t) ^ 0.6
    local xe = xEdge(y) + 1.5 * n(y, seed)
    L[#L+1] = {xe - reachIn * w, y}
    R[#R+1] = {xe + reachOut * w, y}
  end
  local pts = {}
  for i = 1, #L do pts[#pts+1] = L[i] end
  for i = #R, 1, -1 do pts[#pts+1] = R[i] end
  return poly(pts, true)
end
local function xe450(y) local v; for x = 430, 480 do if trunks2[2]:at(x, y) > 0.5 then v = x end end; return v or 463 end
local r1 = edgeRibbon(xe450, 60, 110, 9, 5, 1) + edgeRibbon(xe450, 150, 195, 7, 4, 2) + edgeRibbon(xe450, 240, 300, 8, 5, 3)
print(r1:area())
work(r1, {hand="body", pile=rustc, tool={kind="round", width=3}, coverage=3, fill=true, clip=true, angle=math.pi/2})
-- lose() on the bark75 bar's right edge, only y 60..300
local bar = rect(737, 15, 26, 575)
lose(bar, {pile=rustc, where=function(x, y) return (x > 750 and y > 60 and y < 300) and 1 or 0 end, tool="filbert 4", reach={6, 8}, load=0.25})
print(wait(60))

--@ chunk 12
rdark = pile{{"red earth",1},{"yellow ochre",0.6},{"raw umber",0.5}, name="rdark"}
local function xe450(y) local v; for x = 430, 480 do if trunks2[2]:at(x, y) > 0.5 then v = x end end; return v or 463 end
local function xe750(y) return 763 end
-- lobed ribbon: outline char soft through points along both sides
function lobeRibbon(xEdge, y0, y1, reachIn, reachOut, seed, lobe)
  local n = noise{seed=seed, period=36, octaves=2}
  local pts = {}
  local steps = 8
  for i = 0, steps do
    local t = i / steps; local y = lerp(y0, y1, t)
    local w = math.sin(math.pi * t) ^ 0.7
    pts[#pts+1] = {xEdge(y) - reachIn * w * (0.75 + 0.5 * n:at01(y, 1)), y}
  end
  for i = steps - 1, 1, -1 do
    local t = i / steps; local y = lerp(y0, y1, t)
    local w = math.sin(math.pi * t) ^ 0.7
    pts[#pts+1] = {xEdge(y) + reachOut * w, y}
  end
  local o = outline{pts=pts, char="soft", seed=seed, lobe=lobe or 5, amount=1.0, edge=1}
  return o:mask()
end
local rA = lobeRibbon(xe450, 340, 395, 9, 6, 11) + lobeRibbon(xe450, 430, 470, 6, 5, 12) + lobeRibbon(xe450, 510, 570, 8, 6, 13)
local rB = lobeRibbon(xe750, 340, 395, 9, 6, 21, 4) + lobeRibbon(xe750, 430, 470, 6, 5, 22, 4) + lobeRibbon(xe750, 510, 570, 8, 6, 23, 4)
print(rA:area(), rB:area())
for _, m in ipairs({rA, rB}) do
  work(m, {hand="body", tool={kind="round", width=3}, length={4, 12}, angle=math.pi/2, angle_jitter=0.8, coverage=3, fill=true, clip=true,
    piles={{rustc, 1}, {rdark, function(x, y) return 0.4 + 0.4 * math.sin(y / 9) end}}})
end
print(wait(60))

--@ chunk 13
palette{scrape={barkglaze, barkwarm, bark7, bark5, bt, bt2, birch_shade, rdark}}
deeprust = pile{{"red earth",0.5},{"raw umber",0.33},{"yellow ochre",0.17}, name="deeprust"}
amber = pile{{"yellow ochre",0.6},{"red earth",0.2},{"lead white",0.2}, name="amber"}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
leafrust = pile{{"red earth",2},{"vermilion",0.6},{"yellow ochre",1.2}, name="leafrust"}
local combos = {
  {{deeprust, .5}, {leafrust, .5}},
  {{deeprust, .35}, {leafrust, .4}, {amber, .25}},
  {{deeprust, .6}, {leafrust, .3}, {amber, .1}},
  {{deeprust, .7}, {leafrust, .2}, {amber, .1}},
  {{deeprust, .25}, {orangeleaf, .35}, {amber, .4}},
  {{deeprust, .2}, {leafrust, .4}, {amber, .4}},
}
mixT = {}
for i, c in ipairs(combos) do
  local p = mix(c)
  mixT[i] = p
  local x = 60 + (i - 1) * 150
  work(rect(x, 1180, 110, 50), {hand="body", pile=p, coverage=3, fill=true, clip=true, tool={kind="flat", width=10}})
end
print(wait(10))

--@ chunk 14
for i = 1, 6 do print(i, mixT[i]) end

--@ chunk 15
palette{scrape={mixT[1], mixT[2], bark75, birch, birch_mid}}
mixT[8] = mix{{deeprust, .7}, {leafrust, .15}, {orangeleaf, .15}}
work(rect(210, 1110, 110, 50), {hand="body", pile=mixT[8], coverage=3, fill=true, clip=true, tool={kind="flat", width=10}})
print(wait(20 * 24 * 60))

--@ chunk 16
palette{scrape={mixT[3], mixT[4], mixT[5], mixT[6], mixT[8]}}
work(rect(360, 1110, 110, 50), {hand="body", pile=deeprust, coverage=3, fill=true, clip=true, tool={kind="flat", width=10}})
work(rect(510, 1110, 110, 50), {hand="body", piles={{deeprust, .85}, {leafrust, .15}}, coverage=3, fill=true, clip=true, tool={kind="flat", width=10}})
work(rect(660, 1110, 110, 50), {hand="body", piles={{deeprust, .55}, {leafrust, .25}, {orangeleaf, .1}, {amber, .1}}, coverage=3, fill=true, clip=true, tool={kind="flat", width=10}})
work(rect(810, 1110, 110, 50), {hand="body", piles={{deeprust, .3}, {orangeleaf, .3}, {leafrust, .1}, {amber, .3}}, coverage=3, fill=true, clip=true, tool={kind="flat", width=10}})
print(wait(10))

--@ chunk 17
waterdark = pile{{"raw umber",0.56},{"Prussian blue",0.14},{"red earth",0.19},{"green earth",0.11}, name="waterdark"}
haze = pile{{"lead white",0.68},{"yellow ochre",0.17},{"red earth",0.05},{"smalt",0.10}, name="haze"}
local specs = {
  {{waterdark, .8}, {haze, .14}, {amber, .06}},
  {{waterdark, .7}, {deeprust, .12}, {haze, .1}, {amber, .08}},
  {{waterdark, .58}, {deeprust, .2}, {amber, .14}, {haze, .08}},
  {{waterdark, .5}, {deeprust, .22}, {amber, .18}, {haze, .1}},
}
for i, s in ipairs(specs) do
  work(rect(60 + (i - 1) * 150, 1050, 110, 45), {hand="body", piles=s, coverage=3, fill=true, clip=true, tool={kind="flat", width=10}})
end
print(wait(30 * 24 * 60))
