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
lent = pile{{"bone black",1},{"raw umber",1.2}}
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}}
foamsh = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.35},{"yellow ochre",0.1}}
thinwhite = pile{{"lead white",8},{"yellow ochre",0.2},{"cobalt blue",0.1}, thinner=0.5}
local R = rect(80, 80, 500, 520)
work(R, {hand="body", piles={{rock,1},{lent,0.5}}, coverage=3, fill=true})
curtain = poly({{262,100},{460,100},{470,560},{252,560}})
work(curtain, {hand="body", pile=thinwhite, tool="flat 8", angle=math.pi/2, coverage=3, clip=true, length={60,140}})
work(curtain, {hand="body", piles={{fallwhite,1},{foamsh,0.5}}, tool="flat 7", angle=math.pi/2, coverage=2, clip=true, length={40,110}, load=0.5})
blend(curtain:shrink(3), {angle=math.pi/2})
work(curtain, {hand="body", pile=fallwhite, tool="flat 5", angle=math.pi/2, coverage=0.8, clip=true, length={30,90}, load=0.4, pressure={0.2,0.5}})
print(wait(60*24*60))

--@ chunk 3
function xe(y) return 262 - (y-100)/46 end
-- tapered wavy ribbon: from (x0 offset d0 at y0) down to y1; width grows from 0 to w (pointed top), last 15% narrows a bit
function biteRibbon(d0, d1, y0, y1, w, wave, ph, edgefn)
  local pts, ws = {}, {}
  local n = 14
  for i = 0, n do
    local t = i / n
    local y = lerp(y0, y1, t)
    local x = edgefn(y) + lerp(d0, d1, t) + wave * math.sin(t * 5.0 + ph)
    pts[#pts+1] = {x, y}
    local wt = w * (t ^ 0.75)
    if t > 0.85 then wt = wt * (1 - (t - 0.85) / 0.15 * 0.5) end
    ws[#ws+1] = math.max(wt, 0.15)
  end
  return ribbon(pts, ws)
end
local bites = {
  {6, 8, 330, 470, 4.5, 0.8, 0.3},
  {14, 17, 380, 470, 3.5, 0.6, 1.7},
  {2, 4, 300, 400, 3.0, 0.7, 2.4},
  {9, 13, 410, 470, 2.6, 0.5, 0.9},
  {22, 24, 425, 470, 2.2, 0.4, 2.0},
}
bm = nil
for _, b in ipairs(bites) do
  local r = biteRibbon(b[1], b[2], b[3], b[4], b[5], b[6], b[7], xe)
  bm = bm and (bm + r) or r
end
print("bites area", bm:area())
work(bm, {hand="body", tool="round 3", piles={{lent,1},{rock,1}}, coverage=3, clip=true, fill=true, angle=math.pi/2, length={10,30}})

--@ chunk 4
-- dry-brush dark drags over the white edge, y 120..290 section (top of band ~140)
local b = brush{kind="flat", width=4, stiffness=0.6}
local n = noise{seed=11, period=60, octaves=2}
for i = 1, 22 do
  local d = math.abs(randn(0, 6)) - 1.5       -- offset inside the edge, clustered near it
  local y0 = rand(140, 250)
  local len = rand(25, 70) * (0.6 + 0.6 * (y0 - 140) / 110)
  local y1 = math.min(y0 + len, 290)
  b:reload(i % 2 == 0 and lent or rock, rand(0.10, 0.22))
  local pts = {}
  for k = 0, 6 do
    local t = k / 6
    local y = lerp(y0, y1, t)
    pts[#pts+1] = {xe(y) + d + t * rand(0.5, 2.0) + 0.6 * math.sin(t * 4 + i), y}
  end
  b:stroke(pts, {pressure={rand(0.05, 0.15), rand(0.25, 0.45)}, ramps={0.3, 0.15}, orient="along"})
end

--@ chunk 5
function xr(y) return 460 + (y-100)/46 end
-- wedge bite: pointed top inside the sheet at depth d0 (units from edge, inward), runs down and outward, exits past the edge
-- side = +1 for a right edge (inward is -x), -1 for a left edge
function wedge(edgefn, side, d0, y0, y1, d1, wmax, bow, seed)
  local pts, ws = {}, {}
  local n = 16
  for i = 0, n do
    local t = i / n
    local y = lerp(y0, y1, t)
    local d = lerp(d0, d1, t ^ 1.3) + bow * math.sin(math.pi * t)
    pts[#pts+1] = {edgefn(y) - side * d, y}
    ws[#ws+1] = math.max(wmax * (t ^ 0.8), 0.2)
  end
  return ribbon(pts, ws)
end
local W = {
  {9, 380, 470, -4, 7, 1.0},
  {16, 410, 470, 4, 5, -0.8},
  {4, 330, 400, -5, 5, 0.6},
  {12, 440, 470, 8, 4, 0.5},
}
wm = nil
for i, w in ipairs(W) do
  local r = wedge(xr, 1, w[1], w[2], w[3], w[4], w[5], w[6])
  wm = wm and (wm + r) or r
end
wm = wm:roughen(1.0, 18, 5)
print("area", wm:area())
work(wm, {hand="body", tool="round 3", piles={{lent,1},{rock,1}}, coverage=3, clip=true, fill=true, angle=math.pi/2, length={10,30}})

--@ chunk 6
local R = rect(80, 620, 840, 560)
work(R, {hand="body", piles={{rock,1},{lent,0.5}}, coverage=3, fill=true})
c2 = poly({{252,640},{420,640},{428,1160},{246,1160}})
c3 = poly({{602,640},{760,640},{768,1160},{596,1160}})
for _, c in ipairs({c2, c3}) do
  work(c, {hand="body", pile=thinwhite, tool="flat 8", angle=math.pi/2, coverage=3, clip=true, length={60,140}})
  work(c, {hand="body", piles={{fallwhite,1},{foamsh,0.5}}, tool="flat 7", angle=math.pi/2, coverage=2, clip=true, length={40,110}, load=0.5, curve={0.02, 0.0}})
  blend(c:shrink(3), {angle=math.pi/2})
  work(c, {hand="body", pile=fallwhite, tool="flat 5", angle=math.pi/2, coverage=0.8, clip=true, length={30,90}, load=0.4, pressure={0.2,0.5}})
end
print(wait(60*24*60))

--@ chunk 7
function xe2(y) return 252 - (y-640)/86.7 end
local b = brush{kind="fan", width=12}
for i = 1, 9 do
  local y0 = rand(700, 830)
  local len = rand(40, 90)
  local y1 = math.min(y0 + len, 900)
  local f = (y0 - 700) / 130
  local inside = rand(1, 7)
  local out = 3 + 12 * f + rand(0, 5)
  b:reload(fallwhite, rand(0.08, 0.16))
  local pts = {}
  for k = 0, 6 do
    local t = k / 6
    local y = lerp(y0, y1, t)
    pts[#pts+1] = {xe2(y) + inside - (inside + out) * (t ^ 1.2), y}
  end
  b:stroke(pts, {pressure={rand(0.25, 0.4), 0.03}, ramps={0.05, 0.5}, orient="across"})
end

--@ chunk 8
function xr2(y) return 420 + (y-640)/65 end
local W = {
  {10, 730, 830, -3, 7, 1.5},
  {18, 790, 880, 2, 6, -1.0},
  {6, 700, 760, -4, 5, 0.8},
}
local wm2 = nil
for i, w in ipairs(W) do
  local r = wedge(xr2, 1, w[1], w[2], w[3], w[4], w[5], w[6])
  wm2 = wm2 and (wm2 + r) or r
end
wm2 = wm2:roughen(1.2, 22, 8)
work(wm2, {hand="body", tool="round 3", piles={{lent,1},{rock,1}}, coverage=3, clip=true, fill=true, angle=math.pi/2, length={10,30}})
local b = brush{kind="fan", width=12}
for i = 1, 8 do
  local y0 = rand(710, 840)
  local y1 = math.min(y0 + rand(40, 90), 910)
  local f = (y0 - 710) / 130
  local inside = rand(1, 6)
  local out = 3 + 12 * f + rand(0, 5)
  b:reload(fallwhite, rand(0.08, 0.15))
  local pts = {}
  for k = 0, 6 do
    local t = k / 6
    local y = lerp(y0, y1, t)
    pts[#pts+1] = {xr2(y) - inside + (inside + out) * (t ^ 1.2), y}
  end
  b:stroke(pts, {pressure={rand(0.25, 0.4), 0.03}, ramps={0.05, 0.5}, orient="across"})
end

--@ chunk 9
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}}
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}}
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}}
local combos = {
  {{glow,1},{haze,1}},
  {{glow,1},{haze,1},{amber,0.25}},
  {{glow,1},{haze,0.6},{amber,0.2}},
  {{glow,0.6},{haze,1},{amber,0.3}},
}
for i, c in ipairs(combos) do
  work(rect(80 + (i-1)*110, 1180, 90, 50), {hand="body", piles=c, coverage=3, fill=true})
end

--@ chunk 10
fartrunk = pile{{"lead white",2},{"raw umber",1},{"red earth",0.4},{"smalt",0.8}}
work(rect(620, 80, 360, 480), {hand="body", piles={{glow,0.6},{haze,1.1},{amber,0.25}}, coverage=3, fill=true})
blend(rect(630, 90, 340, 460), {angle=math.pi/2})
for i, x in ipairs({680, 760, 840, 920}) do
  local tm = ribbon({{x, 100}, {x + 3, 330}, {x + 6, 540}}, {7, 9, 10}):roughen(1, 14, i)
  work(tm, {hand="body", pile=fartrunk, tool="flat 7", angle=-math.pi/2, coverage=3, fill=true, clip=true, length={30,80}})
end
print(wait(60*24*60))

--@ chunk 11
bgmix = mix{{glow,0.6},{haze,1.1},{amber,0.25}, name="bgmix"}
local function tz(x, y0, y1) return ribbon({{x, y0}, {x + 3*(1), (y0+y1)/2}, {x + 6*(y1-100)/440, y1}}, 16):roughen(1.5, 30, 9):soften(3) end
-- A: scumble nested
for i, z in ipairs({{220, 545, 0.5}, {320, 545, 0.6}, {420, 545, 0.7}}) do
  local m = ribbon({{680 + 3*(z[1]-100)/230, z[1]}, {686, 545}}, 18):soften(4)
  work(m, {hand="scumble", pile=bgmix, coverage=z[3], angle=math.pi/2})
end
-- B: body flat 4, vertical, load graded
local mB = ribbon({{760 + 3*(220-100)/230, 220}, {766, 545}}, 18):soften(4)
work(mB, {hand="body", pile=bgmix, tool="flat 4", angle=-math.pi/2, coverage=2.5, clip=true, length={30,80},
  load_at=function(x, y) return clamp((y - 220) / 220, 0.05, 0.9) end, pressure={0.2,0.45}})
-- C: glaze of bgmix + medium nested
bgglz = pile{{"lead white",5},{"yellow ochre",1.4},{"red earth",0.3},{"smalt",0.5},{"chrome yellow",0.6}, medium=0.6, name="bgglz"}
for i, z in ipairs({220, 320, 420}) do
  local m = ribbon({{840 + 3*(z-100)/230, z}, {846, 545}}, 18):soften(4)
  work(m, {hand="glaze", pile=bgglz, coverage=1, angle=math.pi/2})
end

--@ chunk 12
palette{scrape={bgglz, fartrunk, thinwhite, glow}}
waterdark = pile{{"raw umber",3},{"Prussian blue",0.75},{"red earth",1},{"green earth",0.6}, name="waterdark"}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
local C = {
  {{waterdark,0.66},{amber,0.15},{haze,0.15},{deeprust,0.06}},
  {{waterdark,0.55},{amber,0.15},{haze,0.25},{deeprust,0.05}},
  {{waterdark,0.5},{amber,0.15},{haze,0.32},{deeprust,0.03}},
  {{waterdark,0.45},{amber,0.12},{haze,0.4},{deeprust,0.03}},
}
for i, c in ipairs(C) do
  work(rect(80 + (i-1)*110, 1100, 90, 50), {hand="body", piles=c, coverage=3, fill=true})
end

--@ chunk 13
local C = {
  {{waterdark,0.72},{haze,0.2},{amber,0.05},{rock,0.03}},
  {{waterdark,0.7},{haze,0.22},{amber,0.03},{rock,0.05}},
  {{waterdark,0.75},{haze,0.2},{amber,0.05}},
  {{waterdark,0.68},{haze,0.24},{amber,0.04},{rock,0.04}},
}
for i, c in ipairs(C) do
  work(rect(80 + (i-1)*110, 1180, 90, 40), {hand="body", piles=c, coverage=3, fill=true})
end

--@ chunk 14
local C = {
  {{waterdark,0.78},{haze,0.15},{amber,0.07}},
  {{waterdark,0.76},{haze,0.16},{amber,0.06},{deeprust,0.02}},
}
for i, c in ipairs(C) do
  work(rect(80 + (i-1)*110, 1225, 90, 20), {hand="body", piles=c, coverage=3, fill=true})
end

--@ chunk 15
print(wait(30*24*60))

--@ chunk 16
local o = outline{{620,880},{700,880},{900,880},{900,1175},{700,1175},{650,1100},{630,1000}, char="firm", seed=4, amount=0.2}
waterT = o:mask()
work(waterT, {hand="body", piles={{waterdark,0.62},{haze,0.28},{amber,0.1}}, coverage=3, fill=true, clip=true, angle=1.5, tool="flat 9", length={30,80}})
print(wait(40*24*60))
