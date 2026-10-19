-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{size=700, aspect=1.4, linen={15, 13}, seed=1774,
  ground={
    {pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, um=60, apply="knife", texture=0.3},
    {pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45, apply="brush"},
  }}
print(W, H)

--@ chunk 2
-- geometry, saved as globals for every later campaign
local nz = noise{seed=11, octaves=4, period=60}
local function line(knots, step, amp, nseed)
  local n = noise{seed=nseed, octaves=4, period=45}
  local out = {}
  for i = 1, #knots - 1 do
    local a, b = knots[i], knots[i+1]
    local steps = math.max(1, math.floor((b[1]-a[1]) / step))
    for s = 0, steps - 1 do
      local t = s / steps
      local u = t*t*(3-2*t)
      local x = a[1] + (b[1]-a[1]) * t
      local y = a[2] + (b[2]-a[2]) * u + amp * n(x, a[2])
      out[#out+1] = {x, y}
    end
  end
  out[#out+1] = {knots[#knots][1], knots[#knots][2]}
  return out
end
-- far ridge R1: long, low, palest
R1 = line({{-5,352},{120,346},{260,356},{380,349},{470,358},{560,352},{690,343},{800,350},{900,341},{1005,348}}, 6, 2.5, 21)
-- R2: big rounded mass from the left, falling right into the gap
R2 = line({{-5,292},{70,276},{170,266},{240,272},{310,293},{360,302},{430,330},{500,357},{560,378},{610,392}}, 5, 3, 22)
-- R3: nearer ridge from the right, crest later serrated with spruce, falling left
R3 = line({{1005,372},{930,377},{860,390},{790,396},{720,410},{650,423},{580,438},{520,450},{470,458}}, 5, 3, 23)
-- foreground promontory top, left to right; then the drop
FG = line({{-5,452},{40,446},{95,462},{150,486},{220,498},{300,503},{380,506},{450,508},{520,512},{560,520},{590,548},{612,600},{630,660},{640,720}}, 5, 2.5, 24)
moonC = {604, 300}; moonR = 15
figure = {x=405, foot=507, h=78}
print(#R1, #R2, #R3, #FG)

--@ chunk 3
local function line(knots, step, amp, nseed)
  local n = noise{seed=nseed, octaves=4, period=45}
  local out = {}
  for i = 1, #knots - 1 do
    local a, b = knots[i], knots[i+1]
    local steps = math.max(1, math.floor(math.abs(b[1]-a[1]) / step))
    for s = 0, steps - 1 do
      local t = s / steps
      local u = t*t*(3-2*t)
      local x = a[1] + (b[1]-a[1]) * t
      local y = a[2] + (b[2]-a[2]) * u + amp * n(x, a[2])
      out[#out+1] = {x, y}
    end
  end
  out[#out+1] = {knots[#knots][1], knots[#knots][2]}
  return out
end
R3 = line({{470,458},{520,450},{580,438},{650,423},{720,410},{790,396},{860,390},{930,377},{1005,372}}, 5, 3, 23)
lineF = line
print(#R3)

--@ chunk 4
local h = pencil("2H")
h:sketch(R1, {pressure=0.25, passes=2})
h:sketch(R2, {pressure=0.3, passes=2})
h:sketch(R3, {pressure=0.3, passes=2})
local b = pencil("HB")
b:line(FG, {pressure=0.45})
-- moon
local mc = {}
for i = 0, 36 do local a = i/36*2*math.pi; mc[#mc+1] = {moonC[1] + moonR*math.cos(a), moonC[2] + moonR*math.sin(a)} end
h:line(mc, {pressure=0.3})
-- figure: simple outline
local fx, fy = figure.x, figure.foot
b:line({{fx-3,fy-77},{fx+3,fy-78},{fx+5,fy-72},{fx+3,fy-66},{fx+9,fy-62},{fx+11,fy-50},{fx+13,fy-30},{fx+14,fy-15},{fx+7,fy-15},{fx+7,fy},{fx+2,fy},{fx+1,fy-14},{fx-2,fy-14},{fx-3,fy},{fx-8,fy},{fx-8,fy-15},{fx-13,fy-15},{fx-11,fy-32},{fx-11,fy-50},{fx-9,fy-62},{fx-4,fy-66},{fx-5,fy-72},{fx-3,fy-77}}, {pressure=0.4, smooth=false})
print("drawn")

--@ chunk 5
-- erase the first FG drop and the first figure; redraw with the revised plan
local oldFG = FG
local seg = {}
for _, p in ipairs(oldFG) do if p[1] > 545 then seg[#seg+1] = p end end
erase(seg, {strength=0.9, width=8})
erase(ellipse(405, 468, 22, 46), {strength=0.9})
R3 = lineF({{540,456},{580,446},{650,428},{720,412},{790,398},{860,391},{930,379},{1005,373}}, 5, 3, 23)
FG = lineF({{-5,474},{30,466},{75,458},{110,466},{160,486},{230,494},{310,497},{390,498},{450,497},{500,496},{535,499},{555,508},{570,530},{582,570},{595,630},{606,720}}, 5, 2.5, 24)
figure = {x=478, foot=497, h=78}
SP = {
 {x=948, tip=318, base=720, w=72},
 {x=876, tip=408, base=720, w=50},
 {x=820, tip=468, base=640, w=30},
 {x=772, tip=490, base=630, w=24},
 {x=737, tip=478, base=630, w=27},
 {x=692, tip=503, base=620, w=21},
 {x=657, tip=522, base=620, w=19},
 {x=628, tip=556, base=720, w=28},
}
local h = pencil("2H")
h:sketch(R3, {pressure=0.3, passes=2})
local b = pencil("HB")
b:line(FG, {pressure=0.45})
for _, s in ipairs(SP) do
  h:line({{s.x, s.tip}, {s.x + rand(-2,2), s.base}}, {pressure=0.3})
  h:line({{s.x - s.w/2, s.base - 10}, {s.x, s.tip}, {s.x + s.w/2, s.base - 10}}, {pressure=0.22})
end
local fx, fy = figure.x, figure.foot
b:line({{fx-3,fy-77},{fx+3,fy-78},{fx+5,fy-72},{fx+3,fy-66},{fx+9,fy-62},{fx+11,fy-50},{fx+13,fy-30},{fx+14,fy-15},{fx+7,fy-15},{fx+7,fy},{fx+2,fy},{fx+1,fy-14},{fx-2,fy-14},{fx-3,fy},{fx-8,fy},{fx-8,fy-15},{fx-13,fy-15},{fx-11,fy-32},{fx-11,fy-50},{fx-9,fy-62},{fx-4,fy-66},{fx-5,fy-72},{fx-3,fy-77}}, {pressure=0.4, smooth=false})
print("ok")

--@ chunk 6
local q = {}
for _, p in ipairs(FG) do q[#q+1] = p end
q[#q+1] = {-5, 720}
FGmask = poly(q)
under_fg = pile{{"raw umber", 3}, {"red earth", 0.6}, {"bone black", 0.4}, turps=0.6, name="under_fg"}
work(FGmask, {hand="body", pile=under_fg, coverage=2, angle=function(x, y) return 0.15 + 0.3*math.sin(x/90) end, edge="firm", clip=FGmask:grow(2)})
print(drying(300,600))

--@ chunk 7
local r = rag{width=40}
r:wipe(FGmask:shrink(6), {pressure=0.45, angle=0.1, passes=1, refold=0.6})
print(r)

--@ chunk 8
sky_deep = pile{{"smalt", 3}, {"cobalt blue", 1}, {"lead white", 0.8}, {"bone black", 0.25}, {"rose madder", 0.15}, name="sky_deep"}
sky_blue = pile{{"smalt", 2.5}, {"cobalt blue", 0.7}, {"lead white", 2.5}, {"rose madder", 0.12}, name="sky_blue"}
sky_mid = pile{{"smalt", 1.5}, {"cobalt blue", 0.3}, {"lead white", 4}, {"rose madder", 0.2}, name="sky_mid"}
sky_lilac = pile{{"lead white", 6}, {"rose madder", 0.4}, {"smalt", 0.8}, {"Naples yellow", 0.2}, name="sky_lilac"}
belt = pile{{"lead white", 8}, {"rose madder", 0.7}, {"Naples yellow", 0.8}, {"vermilion", 0.1}, name="belt"}
eshadow = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.3}, {"raw umber", 0.2}, name="eshadow"}
glow = pile{{"lead white", 7}, {"Naples yellow", 0.8}, {"smalt", 0.7}, {"rose madder", 0.2}, name="glow"}
mist_far = pile{{"lead white", 6}, {"smalt", 1.2}, {"rose madder", 0.25}, {"raw umber", 0.1}, name="mist_far"}
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
mist_low = pile{{"lead white", 4}, {"smalt", 1.5}, {"raw umber", 0.3}, {"rose madder", 0.2}, name="mist_low"}

--@ chunk 9
local stops = {{0, sky_deep}, {95, sky_blue}, {170, sky_mid}, {218, sky_lilac}, {258, belt}, {305, eshadow}, {345, eshadow}, {400, mist_far}, {478, mist_bright}, {545, mist_bright}, {700, mist_low}}
local function hat(i)
  return function(x, y)
    local c = stops[i][1]
    local lo = stops[i-1] and stops[i-1][1] or -1e9
    local hi = stops[i+1] and stops[i+1][1] or 1e9
    if y <= c then
      if i == 1 then return 1 end
      return math.max(0, (y - lo) / (c - lo))
    else
      if i == #stops then return 1 end
      return math.max(0, (hi - y) / (hi - c))
    end
  end
end
local piles = {}
for i = 1, #stops do piles[#piles+1] = {stops[i][2], hat(i)} end
piles[#piles+1] = {glow, function(x, y) local dx, dy = (x - moonC[1]) / 85, (y - moonC[2]) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}
ATM = -FGmask
work(ATM, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=ATM, angle_jitter=0.04, tool={kind="filbert", width=22, lay=1.6}})
print(drying(500, 100))

--@ chunk 10
blend(ATM, {angle=0, tool={kind="badger", width=60}})
print(drying(500, 100), drying(500, 600))

--@ chunk 11
for i = 1, 16 do
  local t = wait(24*60)
  local a, b, c, d = drying(500, 50), drying(500, 260), drying(500, 400), drying(800, 650)
  print(t, a, b, c, d, drying(200, 600))
  if a == "dry" and b == "dry" and c == "dry" and d == "dry" then break end
end

--@ chunk 12
function crest_fn(line)
  -- piecewise-linear y at x along a line sorted by x
  local pts = {}
  for _, p in ipairs(line) do pts[#pts+1] = p end
  table.sort(pts, function(a, b) return a[1] < b[1] end)
  return function(x)
    if x <= pts[1][1] then return pts[1][2] end
    if x >= pts[#pts][1] then return pts[#pts][2] end
    local lo, hi = 1, #pts
    while hi - lo > 1 do
      local mid = (lo + hi) // 2
      if pts[mid][1] <= x then lo = mid else hi = mid end
    end
    local a, b = pts[lo], pts[hi]
    local t = (x - a[1]) / math.max(1e-6, b[1] - a[1])
    return a[2] + (b[2] - a[2]) * t
  end
end
-- region below a line down to depth (a function of x), as a polygon
function band_below(line, depth_fn)
  local q = {}
  for _, p in ipairs(line) do q[#q+1] = {p[1], p[2]} end
  for i = #line, 1, -1 do local p = line[i]; q[#q+1] = {p[1], p[2] + depth_fn(p[1])} end
  return poly(q)
end
-- the underlayer's mist piles by y (the same stops as the sky campaign)
SKYSTOPS = {{0, sky_deep}, {95, sky_blue}, {170, sky_mid}, {218, sky_lilac}, {258, belt}, {305, eshadow}, {345, eshadow}, {400, mist_far}, {478, mist_bright}, {545, mist_bright}, {700, mist_low}}
function sky_hat(i)
  local stops = SKYSTOPS
  return function(x, y)
    local c = stops[i][1]
    local lo = stops[i-1] and stops[i-1][1] or -1e9
    local hi = stops[i+1] and stops[i+1][1] or 1e9
    if y <= c then
      if i == 1 then return 1 end
      return math.max(0, (y - lo) / (c - lo))
    else
      if i == #stops then return 1 end
      return math.max(0, (hi - y) / (hi - c))
    end
  end
end
-- graded piles: ridge pile near the crest fading to the underlayer's own colors below
function ridge_piles(rp, cf, d0, fade, extra)
  local wr = function(x, y) return clamp(1 - (y - cf(x) - d0) / fade, 0, 1) end
  local list = {{rp, wr}}
  for i = 6, #SKYSTOPS do
    local h = sky_hat(i)
    list[#list+1] = {SKYSTOPS[i][2], function(x, y) return (1 - wr(x, y)) * h(x, y) end}
  end
  return list
end
cR1 = crest_fn(R1); cR2 = crest_fn(R2); cR3 = crest_fn(R3)
print(cR1(300), cR2(300), cR3(700))

--@ chunk 13
ridge_far = pile{{"lead white", 3.5}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.45}, {"raw umber", 0.3}, name="ridge_far"}
ridge_mid = pile{{"lead white", 2.6}, {"smalt", 2.5}, {"cobalt blue", 0.4}, {"rose madder", 0.45}, {"raw umber", 0.55}, name="ridge_mid"}
ridge_left = pile{{"lead white", 1.8}, {"smalt", 2.5}, {"cobalt blue", 0.4}, {"rose madder", 0.35}, {"raw umber", 0.9}, {"Prussian blue", 0.1}, name="ridge_left"}
ridge_near = pile{{"lead white", 1.0}, {"smalt", 2}, {"raw umber", 1.3}, {"Prussian blue", 0.25}, {"rose madder", 0.25}, {"yellow ochre", 0.2}, name="ridge_near"}

--@ chunk 14
-- far ridge R1, right of R2's slope; fades into the mist below
local m = band_below(R1, function(x) return 55 end) * rect(440, 0, 600, 714)
R1mask = m
local piles = ridge_piles(ridge_far, cR1, 6, 34)
work(m, {hand="body", piles=piles, angle=0, coverage=3, fill=true, clip=m, angle_jitter=0.05})
blend(m, {angle=0, tool={kind="badger", width=40}})
print(drying(700, 352))

--@ chunk 15
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c = drying(700, 352), drying(900, 345), drying(470, 380)
  if a == "dry" and b == "dry" and c == "dry" then print("dry", t) break end
end

--@ chunk 16
local m = band_below(R2, function(x) return 140 end) - FGmask:grow(3)
R2mask = m
local piles = ridge_piles(ridge_mid, cR2, 22, 70)
work(m, {hand="body", piles=piles, angle=function(x, y) return 0.06 * math.sin(x / 70) end, coverage=3, fill=true, clip=m, angle_jitter=0.05})
blend(m, {angle=0, tool={kind="badger", width=40}})
print(drying(200, 300))

--@ chunk 17
R2ext = lineF({{596,389},{630,401},{670,418},{715,436},{760,452}}, 5, 2, 31)
local cE = crest_fn(R2ext)
local m = band_below(R2ext, function(x) return 80 end)
local piles = ridge_piles(ridge_mid, cE, 4, 45)
work(m, {hand="body", piles=piles, angle=0.25, coverage=2, fill=true, clip=m, load_at=function(x, y) return clamp(1 - (x - 600) / 140, 0.1, 0.8) end})
-- soften the end of R2 and the old cut into the mist
local soft = (rect(545, 375, 210, 120) * band_below(lineF({{545,385},{600,388},{760,452}}, 5, 0, 32), function(x) return 120 end)):soften(12)
blend(soft, {angle=0.12, tool={kind="badger", width=36}})
print(drying(620, 420))

--@ chunk 18
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c = drying(200, 300), drying(620, 420), drying(400, 380)
  if a == "dry" and b == "dry" and c == "dry" then print("dry", t) break end
end

--@ chunk 19
-- R3: the nearer wooded ridge from the right; extend its left end down into the valley mist
R3 = lineF({{520,470},{560,452},{600,441},{650,428},{720,412},{790,398},{860,391},{930,379},{1005,373}}, 5, 3, 23)
cR3 = crest_fn(R3)
local m = band_below(R3, function(x) return 150 end) - FGmask:grow(3)
R3mask = m
local piles = ridge_piles(ridge_near, cR3, 18, 85)
work(m, {hand="body", piles=piles, angle=function(x, y) return -0.12 + 0.05 * math.sin(x / 60) end, coverage=3, fill=true, clip=m, angle_jitter=0.06})
blend(m, {angle=0, tool={kind="badger", width=40}})
print(drying(800, 420))

--@ chunk 20
local m = (ellipse(528, 478, 30, 22):soften(10)) - FGmask:grow(2)
blend(m, {angle=-0.3, tool={kind="badger", width=20}})
blend(m, {angle=0.2, tool={kind="badger", width=20}})

--@ chunk 21
local r = rag{width=24}
r:dip(0.7)
local nose = (rect(500, 440, 75, 70) * R3mask):soften(6) - FGmask:grow(2)
r:wipe(nose, {pressure=0.6, angle=0.2, passes=2})
local piles = {}
for i = 7, 10 do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
local m = (mask(function(x, y) return clamp((590 - x) / 50, 0, 1) end) * band_below(R3, function(x) return 70 end):grow(6) * rect(495, 430, 100, 90)):soften(4) - FGmask:grow(2)
work(m, {hand="body", piles=piles, angle=-0.15, coverage=2.5, fill=true, clip=m, tool={kind="filbert", width=10}})
blend(m:soften(8) - FGmask:grow(2), {angle=0, tool={kind="badger", width=24}})
print(r)

--@ chunk 22
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c = drying(800, 420), drying(540, 470), drying(700, 500)
  if a == "dry" and b == "dry" and c == "dry" then print("dry", t) break end
end

--@ chunk 23
BANK = lineF({{470,456},{520,447},{560,444},{600,450},{640,461},{690,471},{745,481},{790,486}}, 5, 4, 41)
local cB = crest_fn(BANK)
local ramp = mask(function(x, y) return clamp((y - cB(x)) / 16, 0, 1) end)
local m = (band_below(BANK, function(x) return 70 end) * ramp) - FGmask:grow(2)
m = m * mask(function(x, y) return clamp((800 - x) / 40, 0, 1) end)
BANKmask = m
local piles = {}
for i = 7, 10 do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
work(m, {hand="body", piles=piles, angle=function(x, y) return 0.15 * math.sin(x / 40) end, coverage=3, fill=true, clip=m, tool={kind="filbert", width=12},
  load_at=function(x, y) return clamp((y - cB(x)) / 22, 0.15, 1) end})
blend(m, {angle=0, tool={kind="badger", width=30}})
print(drying(560, 470))

--@ chunk 24
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
fg_warm = pile{{"raw umber", 3}, {"bone black", 0.5}, {"red earth", 0.5}, {"yellow ochre", 0.5}, name="fg_warm"}
fg_top = pile{{"raw umber", 2}, {"smalt", 1.5}, {"lead white", 1}, {"rose madder", 0.2}, {"bone black", 0.3}, name="fg_top"}
fg_moss = pile{{"raw umber", 2.5}, {"bone black", 0.4}, {"yellow ochre", 0.8}, {"green earth", 1.2}, {"Prussian blue", 0.1}, name="fg_moss"}

--@ chunk 25
local nzm = noise{seed=51, octaves=3, period=90}
local function wdark(x, y) return clamp((y - 560) / 120, 0, 1) + 0.25 end
local function wwarm(x, y) return clamp(1 - math.abs(y - 560) / 90, 0, 1) * 0.8 end
local function wmoss(x, y) return clamp(nzm(x, y) * 1.5, 0, 1) * clamp(1 - math.abs(y - 540) / 80, 0, 1) end
local function wtop(x, y) return 0 end
local piles = {{fg_dark, wdark}, {fg_warm, wwarm}, {fg_moss, wmoss}}
work(FGmask, {hand="body", piles=piles, angle=function(x, y) return 0.04 + 0.08 * math.sin(x / 120) end, coverage=3, fill=true, clip=FGmask, angle_jitter=0.12, tool={kind="filbert", width=10}})
print(drying(300, 600))

--@ chunk 26
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c, d = drying(300, 600), drying(100, 700), drying(560, 470), drying(500, 520)
  print(t, a, b, c, d)
  if a == "dry" and b == "dry" and c == "dry" and d == "dry" then break end
end

--@ chunk 27
function spruce2(s, seed)
  math.randomseed(seed)
  local h = s.base - s.tip
  local parts = {}
  local tw = math.max(0.8, s.w * 0.03)
  parts[#parts+1] = ribbon({{s.x, s.tip}, {s.x + rand(-0.6,0.6), s.tip + h * 0.15}}, {0.5, tw})
  parts[#parts+1] = ribbon({{s.x, s.tip + h*0.14}, {s.x, s.base}}, {tw, math.max(1.6, s.w * 0.07)})
  local y = s.tip + h * 0.03
  while y < s.base - 4 do
    local t = (y - s.tip) / h
    local env = s.w / 2 * math.min(1, (t ^ 0.85) * 1.05)
    local spBase = clamp(h / 32, 2, 14)
    local sp = spBase * (0.35 + 0.65 * t) * (0.6 + 0.8 * math.random())
    sp = math.max(sp, 1.6)
    for _, side in ipairs({-1, 1}) do
      if math.random() > 0.1 + 0.1 * t then
        local L = env * (0.45 + 0.7 * math.random())
        local droop = L * (0.2 + 0.35 * math.random())
        local y0 = y + rand(-sp*0.3, sp*0.3)
        local th = clamp(spBase * (0.25 + 0.6 * t) * (0.7 + 0.5 * math.random()), 0.8, 13)
        local pts = {{s.x, y0}, {s.x + side * L * 0.45, y0 + droop * 0.55}, {s.x + side * L * 0.85, y0 + droop}, {s.x + side * L, y0 + droop * 0.8}}
        parts[#parts+1] = ribbon(pts, {th, th * 0.8, th * 0.5, th * 0.2})
        if t > 0.18 then
          local nc = math.floor(L / math.max(3, th * 1.4))
          for k = 1, nc do
            local u = math.random() * 0.85 + 0.15
            local cx = s.x + side * L * u
            local cy = y0 + droop * u + th * (0.3 + 0.3 * math.random())
            parts[#parts+1] = ellipse(cx, cy, th * (0.15 + 0.2 * math.random()), th * (0.3 + 0.45 * math.random()))
          end
        end
      end
    end
    y = y + sp
  end
  local m = parts[1]
  for i = 2, #parts do m = m + parts[i] end
  m = m:roughen(math.max(0.6, s.w * 0.015), math.max(3, s.w * 0.08), seed)
  return m
end
-- mist piles of the underlayer, for fading a form's foot into it
function mist_list()
  local l = {}
  for i = 6, #SKYSTOPS do l[#l+1] = {SKYSTOPS[i][2], sky_hat(i)} end
  return l
end
function paint_spruce3(s, top_pile, seed, fadeY, fadeLen, clipm)
  local m = spruce2(s, seed)
  if clipm then m = m * clipm end
  local wt = function(x, y) return clamp((fadeY - y) / fadeLen, 0, 1) end
  local piles = {{top_pile, wt}}
  for _, mp in ipairs(mist_list()) do
    piles[#piles+1] = {mp[1], function(x, y) return (1 - wt(x, y)) * mp[2](x, y) end}
  end
  work(m, {hand="body", piles=piles, angle=1.3, coverage=2.5, fill=true, clip=m, tool={kind="filbert", width=clamp(s.w / 12, 1.5, 7)}})
  return m
end
spruce_dark = pile{{"Prussian blue", 1}, {"raw umber", 2.5}, {"bone black", 1}, {"yellow ochre", 0.4}, name="spruce_dark"}
sp_crest = mix{{ridge_near, 0.7}, {spruce_dark, 0.3}, name="sp_crest"}
print(sp_crest)

--@ chunk 28
local xs = uneven(46, 585, 1000, 0.6, 0.5, 71)
local m = nil
CREST_SP = {}
for i, x in ipairs(xs) do
  local cy = cR3(x)
  local hh = rand(7, 17) * (0.7 + 0.5 * (x - 585) / 415)
  local s = {x=x, tip=cy - hh, base=cy + 6, w=hh * rand(0.32, 0.42)}
  CREST_SP[#CREST_SP+1] = s
  local sm = spruce2(s, 100 + i)
  m = m and (m + sm) or sm
end
CRESTmask = m
work(m, {hand="detail", pile=sp_crest, angle=1.4, coverage=3, fill=true, clip=m, tool={kind="round", width=1.6}})
print(#xs)

--@ chunk 29
sp_crest2 = mix{{ridge_near, 0.85}, {spruce_dark, 0.15}, name="sp_crest2"}
local xs = uneven(120, 560, 1000, 0.5, 0.6, 72)
local m = nil
for i, x in ipairs(xs) do
  local cy = cR3(x)
  local hh = rand(5, 14) * (0.7 + 0.5 * (x - 560) / 440)
  local s = {x=x, tip=cy - hh + 1, base=cy + 8, w=hh * rand(0.45, 0.65)}
  local sm = spruce2(s, 300 + i)
  m = m and (m + sm) or sm
end
-- the forest's body along the crest: a thin band hugging the crest line
local band = band_below(lineF({{560,452},{600,441},{650,428},{720,412},{790,398},{860,391},{930,379},{1005,373}}, 5, 3, 23), function(x) return 10 end)
local q = {}
for _, p in ipairs(R3) do q[#q+1] = {p[1], p[2] - 3} end
local belt_m = band_below(q, function(x) return 12 end)
m = (m + belt_m) * rect(560, 0, 445, 714)
CRESTmask = CRESTmask + m
work(m, {hand="detail", pile=sp_crest2, angle=1.4, coverage=2.5, fill=true, clip=m, tool={kind="round", width=1.8}})
print(#xs)

--@ chunk 30
local q = {}
for _, p in ipairs(R3) do q[#q+1] = {p[1], p[2] + 3} end
local m = band_below(q, function(x) return 26 end):soften(5) * rect(560, 0, 445, 714)
blend(m, {angle=-0.17, tool={kind="badger", width=16}})
blend(m, {angle=0.6, tool={kind="badger", width=16}})

--@ chunk 31
MISTTOP = lineF({{430,455},{500,450},{560,448},{620,458},{690,468},{760,474},{830,472},{900,468},{1005,463}}, 5, 5, 81)
local cT = crest_fn(MISTTOP)
local m = mask(function(x, y)
  local v = smoothstep(cT(x) - 6, cT(x) + 22, y)
  local nose = clamp((610 - x) / 50, 0, 1) * smoothstep(cR3(x) - 8, cR3(x) + 6, y)
  return math.max(v, nose) * (x > 440 and 1 or 0)
end) - FGmask:grow(2)
VALLEYmask = m
local piles = {}
for i = 7, #SKYSTOPS do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
work(m, {hand="broad", piles=piles, angle=function(x, y) return 0.05 * math.sin(x / 90 + y / 50) end, coverage=3.5, load=1.0, fill=true, clip=m, angle_jitter=0.05, tool={kind="filbert", width=22, lay=1.6}})
blend(m, {angle=0, tool={kind="badger", width=60}})
print(drying(700, 600))

--@ chunk 32
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c = drying(700, 600), drying(800, 420), drying(900, 650)
  if a == "dry" and b == "dry" and c == "dry" then print("dry", t) break end
end

--@ chunk 33
moon = pile{{"lead white", 6}, {"Naples yellow", 1.2}, {"vermilion", 0.03}, name="moon"}
moonC = {604, 298}; moonR = 12.5
local m = ellipse(moonC[1], moonC[2], moonR, moonR)
work(m, {hand="detail", pile=moon, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=20}, tool={kind="round", width=3.5}})
print(drying(604, 298))

--@ chunk 34
local m = ellipse(moonC[1], moonC[2], moonR, moonR)
local ring = m - ellipse(moonC[1], moonC[2], moonR - 4, moonR - 4)
work(ring, {hand="detail", pile=moon, coverage=2.5, fill=true, clip=m:soften(0.8), tool={kind="round", width=2.2}})

--@ chunk 35
local r = rag{width=5}
r:dip(0.6)
local pts = {}
for i = 0, 40 do local a = i / 40 * 2 * math.pi; pts[#pts+1] = {moonC[1] + 16.2 * math.cos(a), moonC[2] + 16.2 * math.sin(a)} end
r:wipe(pts, {pressure=0.6})
r:refold(); r:dip(0.6)
r:wipe(pts, {pressure=0.6})
print(r)

--@ chunk 36
local k = knife{width=4}
local pts = {}
for i = 0, 48 do local a = i / 48 * 2 * math.pi; pts[#pts+1] = {moonC[1] + 15 * math.cos(a), moonC[2] + 15 * math.sin(a)} end
k:scrape(pts, {pressure=1})
k:wipe()
print(drying(moonC[1] + 15, moonC[2]), drying(moonC[1], moonC[2]))

--@ chunk 37
tower_a = pile{{"lead white", 2}, {"raw umber", 1.3}, {"smalt", 1}, {"red earth", 0.15}, {"rose madder", 0.12}, name="tower_a"}
local oA = outline{{797, 700, "c"}, {800, 600}, {803, 545}, {808, 520}, {814, 509, "c"}, {828, 503}, {846, 500}, {860, 504, "c"}, {868, 516}, {872, 548}, {876, 610}, {881, 700, "c"}, char="broken", seed=91, closed=true, amount=0.8}
TOWER_A = oA:mask()
local oB = outline{{714, 700, "c"}, {716, 580}, {718, 525}, {722, 503, "c"}, {732, 495}, {743, 498, "c"}, {748, 514}, {750, 560}, {753, 700, "c"}, char="broken", seed=92, closed=true, amount=0.7}
TOWER_B = oB:mask()
print(TOWER_A:at(840, 550), TOWER_A:at(840, 495), TOWER_B:at(735, 550))

--@ chunk 38
tower_b = mix{{tower_a, 0.5}, {mist_far, 0.5}, name="tower_b"}
local function tower_piles(tp, topY, d0, fade)
  local wr = function(x, y) return clamp(1 - (y - topY - d0) / fade, 0, 1) end
  local list = {{tp, wr}}
  for i = 7, #SKYSTOPS do
    local h = sky_hat(i)
    list[#list+1] = {SKYSTOPS[i][2], function(x, y) return (1 - wr(x, y)) * h(x, y) end}
  end
  return list
end
work(TOWER_B, {hand="body", piles=tower_piles(tower_b, 495, 12, 45), angle=1.5, angle_jitter=0.1, coverage=3, fill=true, clip=TOWER_B, tool={kind="filbert", width=6}})
blend(TOWER_B * rect(700, 525, 80, 200), {angle=1.5, tool={kind="badger", width=20}})
work(TOWER_A, {hand="body", piles=tower_piles(tower_a, 500, 25, 70), angle=1.5, angle_jitter=0.1, coverage=3, fill=true, clip=TOWER_A, tool={kind="filbert", width=7}})
blend(TOWER_A * rect(780, 545, 120, 200), {angle=1.5, tool={kind="badger", width=24}})
print(drying(840, 520))

--@ chunk 39
local r = rag{width=30}
local both = (TOWER_A + TOWER_B):grow(3)
for i = 1, 3 do
  r:dip(0.9)
  r:wipe(both, {pressure=0.75, angle=1.5, passes=1, refold=0.4})
  r:refold()
end
r = rag{width=30}
r:dip(0.9)
r:wipe(both, {pressure=0.75, angle=0, passes=1, refold=0.4})
print(r, drying(840, 520))

--@ chunk 40
local both = (TOWER_A + TOWER_B):grow(6)
for i = 1, 4 do
  local r = rag{width=26}
  r:dip(0.95)
  r:wipe(both, {pressure=0.9, angle=(i % 2 == 0) and 0 or 1.5, passes=1, refold=0.25})
end
print(drying(840, 520))

--@ chunk 41
local m = ((TOWER_A + TOWER_B):grow(14)):soften(10) * rect(680, 480, 230, 240)
local piles = {}
for i = 8, #SKYSTOPS do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
work(m, {hand="body", piles=piles, angle=0, coverage=3, fill=true, clip=m, tool={kind="filbert", width=14}})
blend(m:grow(6):soften(8), {angle=0, tool={kind="badger", width=40}})

--@ chunk 42
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c = drying(800, 600), drying(720, 520), drying(880, 680)
  if a == "dry" and b == "dry" and c == "dry" then print("dry", t) break end
end
print(drying(604, 298))

--@ chunk 43
sp_far = mix{{spruce_dark, 0.3}, {mist_low, 0.7}, name="sp_far"}
sp_midd = mix{{spruce_dark, 0.5}, {mist_low, 0.5}, name="sp_midd"}
sp_near = mix{{spruce_dark, 0.8}, {mist_low, 0.2}, name="sp_near"}
FARSP = {
  {x=642, tip=528, base=600, w=14, p=sp_far, fy=560, fl=35},
  {x=661, tip=541, base=600, w=11, p=sp_far, fy=565, fl=30},
  {x=700, tip=517, base=610, w=17, p=sp_far, fy=565, fl=40},
  {x=718, tip=534, base=610, w=13, p=sp_far, fy=570, fl=35},
  {x=752, tip=497, base=640, w=22, p=sp_midd, fy=585, fl=55},
  {x=771, tip=520, base=640, w=16, p=sp_far, fy=585, fl=45},
}
for i, s in ipairs(FARSP) do paint_spruce3(s, s.p, 200 + i, s.fy, s.fl) end
print(drying(700, 530))

--@ chunk 44
sp_b = mix{{spruce_dark, 0.65}, {mist_low, 0.35}, name="sp_b"}
RIGHTSP = {
  {x=812, tip=428, base=760, w=44, p=sp_midd, fy=560, fl=80, seed=221},
  {x=1012, tip=372, base=760, w=80, p=sp_b, fy=590, fl=100, seed=222},
  {x=873, tip=322, base=760, w=70, p=sp_b, fy=590, fl=110, seed=223},
  {x=948, tip=228, base=760, w=98, p=sp_near, fy=610, fl=120, seed=224},
}
for _, s in ipairs(RIGHTSP) do paint_spruce3(s, s.p, s.seed, s.fy, s.fl) end
print(drying(948, 400))

--@ chunk 45
-- the brink: a slab block rising above the plateau line just right of the figure, and a step down at its end
local o = outline{{492, 500, "c"}, {496, 489}, {503, 483, "c"}, {528, 480}, {548, 482, "c"}, {553, 488}, {556, 500, "c"}, {560, 512}, {540, 515}, {500, 512}, char="broken", seed=301, closed=true, amount=0.6}
BRINK = o:mask()
-- a lower slab at the knoll's foot on the left, overlapping the skyline
local o2 = outline{{150, 492, "c"}, {162, 482}, {190, 479, "c"}, {214, 484}, {226, 494, "c"}, {220, 505}, {160, 505}, char="broken", seed=302, closed=true, amount=0.6}
SLAB2 = o2:mask()
FGmask = FGmask + BRINK + SLAB2
local piles = {{fg_dark, 0.6}, {fg_warm, 0.5}, {fg_moss, 0.25}}
work(BRINK + SLAB2, {hand="body", piles=piles, angle=0.05, coverage=3, fill=true, clip=BRINK + SLAB2, tool={kind="filbert", width=6}})
print(BRINK:at(525, 490), SLAB2:at(190, 490))

--@ chunk 46
rock_top = pile{{"raw umber", 1.5}, {"smalt", 1.2}, {"lead white", 0.9}, {"bone black", 0.2}, {"rose madder", 0.12}, name="rock_top"}
rock_shadow = pile{{"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.25}, name="rock_shadow"}
local b = brush{kind="flat", width=5, stiffness=0.7}
-- tops of the two blocks: short strokes following the top edge
b:load(rock_top, 0.6)
b:stroke({{504, 485}, {528, 482.5}, {546, 484}}, {pressure={0.55, 0.35}})
b:stroke({{499, 490}, {522, 487}, {548, 488.5}}, {pressure={0.4, 0.2}})
b:load(rock_top, 0.5)
b:stroke({{165, 484}, {190, 481.5}, {212, 486}}, {pressure={0.5, 0.3}})
b:stroke({{158, 489}, {186, 486.5}, {218, 490.5}}, {pressure={0.35, 0.15}})
-- shadowed fronts and the joint below each block
local r = brush{kind="round", width=1.6, point=0.8}
r:load(rock_shadow, 0.7)
r:gesture({{497, 497, 0.5}, {520, 500, 0.8}, {545, 499, 0.7}, {557, 503, 0.3}})
r:gesture({{553, 489, 0.3}, {556, 497, 0.6}, {559, 508, 0.4}})
r:load(rock_shadow, 0.6)
r:gesture({{155, 497, 0.4}, {190, 499, 0.8}, {224, 497, 0.4}})
print("ok")

--@ chunk 47
local m1 = BRINK:shrink(1.5)
local m2 = SLAB2:shrink(1.5)
blend(m1 + m2, {angle=0, tool={kind="badger", width=12}})
print(drying(525, 490))

--@ chunk 48
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c, d = drying(525, 490), drying(948, 400), drying(752, 520), drying(190, 490)
  if a == "dry" and b == "dry" and c == "dry" and d == "dry" then print("dry", t) break end
end

--@ chunk 49
rock_top2 = pile{{"raw umber", 2}, {"smalt", 1.2}, {"lead white", 0.7}, {"bone black", 0.35}, {"rose madder", 0.1}, name="rock_top2"}
rock_front2 = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.15}, {"red earth", 0.2}, name="rock_front2"}
-- one ledge: a lip from xa to xb whose ends curl back up; plane above it graded light at the lip, riser below
function ledge(xa, xb, y, sag, seed, depth, riser, clipm)
  local n = noise{seed=seed, octaves=3, period=35}
  local lip = {}
  local steps = math.floor((xb - xa) / 4)
  for i = 0, steps do
    local t = i / steps
    local x = xa + (xb - xa) * t
    local curl = (1 - math.sin(math.pi * t) ^ 0.35) * depth * 0.9
    lip[#lip+1] = {x, y + sag * math.sin(math.pi * t) - curl + 2.2 * n(x, y)}
  end
  local back = {}
  for i = 0, steps do
    local t = i / steps
    local x = xa + (xb - xa) * t
    back[#back+1] = {x, y - depth + 1.5 * n(x, y + 50)}
  end
  local plane = between(back, lip)
  local rs = {}
  for i = 1, #lip do local t = (i-1) / steps; rs[#rs+1] = {lip[i][1], lip[i][2] + riser * math.sin(math.pi * t) ^ 0.5} end
  local face = between(lip, rs)
  if clipm then plane = plane * clipm; face = face * clipm end
  local cf = crest_fn(lip)
  local wl = function(x, yy) return clamp(1 - (cf(x) - yy) / (depth * 0.8), 0.0, 1) end
  work(plane, {hand="body", piles={{rock_top2, wl}, {fg_dark, function(x, yy) return 1 - wl(x, yy) + 0.05 end}}, coverage=3, fill=true, clip=plane, angle=0.02, angle_jitter=0.08, tool={kind="filbert", width=5}})
  blend(plane:shrink(1), {angle=0, tool={kind="badger", width=14}})
  work(face, {hand="detail", piles={{rock_front2, 1}, {fg_warm, 0.25}}, coverage=3, fill=true, clip=face, angle=1.45, angle_jitter=0.2, tool={kind="round", width=2}})
  return lip
end
function between(upper, lower)
  local q = {}
  for _, p in ipairs(upper) do q[#q+1] = p end
  for i = #lower, 1, -1 do q[#q+1] = lower[i] end
  return poly(q)
end
LEDGES = {}
local inside = FGmask:shrink(4)
LEDGES[#LEDGES+1] = ledge(250, 470, 520, 2, 401, 16, 4, inside)
print("ok")

--@ chunk 50
local m = rect(240, 495, 240, 40) * FGmask:shrink(3)
for i = 1, 3 do
  local r = rag{width=20}
  r:dip(0.9)
  r:wipe(m, {pressure=0.8, angle=(i == 2) and 1.5 or 0, passes=1, refold=0.3})
end
print(drying(360, 515))

--@ chunk 51
cFG = crest_fn(FG)
for pass = 1, 3 do
  local r = rag{width=5}
  r:dip(0.9)
  local pts = {}
  for x = 300, 480, 4 do pts[#pts+1] = {x, cFG(x) - 3.5 - (pass - 1) * 1.5} end
  r:wipe(pts, {pressure=0.7})
end
print(drying(400, cFG(400) - 3))

--@ chunk 52
local strip = mask(function(x, y) local c = cFG(x); return (y < c - 0.8 and y > c - 14) and 1 or 0 end) * rect(285, 470, 205, 40)
work(strip, {hand="detail", pile=mist_bright, coverage=3, fill=true, clip=strip, angle=0, tool={kind="round", width=3}})
blend(strip:soften(2) * mask(function(x, y) return y < cFG(x) - 0.8 and 1 or 0 end), {angle=0, tool={kind="badger", width=10}})

--@ chunk 53
for i = 1, 20 do
  local t = wait(24*60)
  local a, b = drying(360, 515), drying(400, cFG(400) - 5)
  if a == "dry" and b == "dry" then print("dry", t) break end
end

--@ chunk 54
fg_top = pile{{"raw umber", 2}, {"smalt", 1.3}, {"lead white", 0.6}, {"bone black", 0.45}, {"rose madder", 0.1}, name="fg_top"}
fg_deep = pile{{"raw umber", 2.5}, {"bone black", 1.4}, {"Prussian blue", 0.3}, {"red earth", 0.15}, name="fg_deep"}
local nb = noise{seed=177, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
local function depth(x, y) return clamp((y - cFG(x)) / 190, 0, 1) end
local function wtop(x, y) return clamp(0.5 + 1.2 * nb(x, y), 0, 1) * (1 - depth(x, y)) ^ 1.3 end
local function wdark(x, y) return (1 - wtop(x, y)) * (1 - depth(x, y)) + 0.1 end
local function wdeep(x, y) return depth(x, y) ^ 0.8 * 1.3 end
local function wwarm(x, y) return 0.15 + 0.25 * clamp(nb(x + 300, y) , 0, 1) end
local m = FGmask:shrink(1.5)
work(m, {hand="body", piles={{fg_top, wtop}, {fg_dark, wdark}, {fg_deep, wdeep}, {fg_warm, wwarm}}, coverage=3, fill=true, clip=m,
  angle=function(x, y) return 0.03 + 0.05 * math.sin(x / 80) + 0.25 * depth(x, y) * math.sin(x / 140) end, angle_jitter=0.1,
  tool={kind="filbert", width=7}, length={30, 80},
  scale_at=function(x, y) return 0.6 + 0.9 * depth(x, y) end})
blend(m, {angle=0, tool={kind="badger", width=24}})
print(drying(300, 600))

--@ chunk 55
local o = outline{{556, 497, "c"}, {563, 511}, {561, 522, "c"}, {572, 527, "c"}, {579, 538}, {575, 547, "c"}, {588, 553, "c"}, {594, 566}, {590, 579, "c"}, {603, 586, "c"}, {609, 600}, {605, 612, "c"}, {618, 622, "c"}, {623, 645}, {617, 662, "c"}, {630, 676, "c"}, {637, 716, "c"}, {588, 716, "c"}, {580, 640}, {570, 580}, {558, 530}, {548, 506, "c"}, char="broken", seed=501, closed=true, amount=0.7}
EDGE = o:mask()
FGmask = FGmask + EDGE
work(EDGE, {hand="body", piles={{fg_dark, 0.6}, {fg_deep, 0.6}, {fg_warm, 0.2}}, coverage=3, fill=true, clip=EDGE, angle=1.35, angle_jitter=0.25, tool={kind="filbert", width=5}})
local b = brush{kind="flat", width=3.5}
local tops = {{{570, 528}, {579, 530}}, {{586, 554}, {594, 556}}, {{601, 587}, {609, 590}}, {{616, 623}, {623, 626}}, {{628, 677}, {635, 680}}}
for _, t in ipairs(tops) do
  b:load(fg_top, 0.5)
  b:stroke(t, {pressure={0.5, 0.2}, clip=EDGE})
end
print(EDGE:at(600, 600), EDGE:at(630, 700))

--@ chunk 56
-- a young spruce clinging to the cliff ledge
local s1 = {x=604, tip=528, base=592, w=19}
local m1 = spruce2(s1, 611)
work(m1, {hand="detail", pile=spruce_dark, coverage=3, fill=true, clip=m1, angle=1.4, tool={kind="round", width=1.6}})
-- a dead snag leaning out over the void from the lower ledge
local snag = ribbon({{619, 628}, {624, 605}, {632, 580}, {641, 556}, {646, 541}}, {4.2, 3.4, 2.6, 1.6, 0.6})
local br = {
  ribbon({{627, 597}, {637, 590}, {648, 589}}, {1.8, 1.2, 0.4}),
  ribbon({{630, 585}, {622, 572}, {620, 563}}, {1.5, 1.0, 0.4}),
  ribbon({{636, 571}, {648, 567}, {655, 570}}, {1.4, 0.9, 0.3}),
  ribbon({{639, 562}, {633, 553}}, {1.1, 0.4}),
  ribbon({{643, 553}, {651, 547}}, {0.9, 0.3}),
  ribbon({{624, 610}, {614, 603}}, {1.6, 0.5}),
}
local sm = snag
for _, b in ipairs(br) do sm = sm + b end
sm = sm:roughen(0.4, 4, 612)
SNAG = sm
snag_p = pile{{"raw umber", 2}, {"bone black", 0.8}, {"lead white", 0.5}, {"smalt", 0.3}, name="snag_p"}
work(sm, {hand="detail", pile=snag_p, coverage=3, fill=true, clip=sm, angle=-1.2, tool={kind="round", width=1.4}})
print("ok")

--@ chunk 57
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c, d = drying(300, 600), drying(100, 520), drying(600, 600), drying(630, 580)
  if a == "dry" and b == "dry" and c == "dry" and d == "dry" then print("dry", t) break end
end

--@ chunk 58
crack_dark = pile{{"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.2}, name="crack_dark"}
lip_warm = pile{{"raw umber", 1.6}, {"lead white", 0.7}, {"red earth", 0.25}, {"yellow ochre", 0.25}, {"smalt", 0.4}, {"bone black", 0.25}, name="lip_warm"}
function fissure(pts, widths, seed, clipm)
  local m = ribbon(pts, widths):roughen(0.8, 6, seed)
  if clipm then m = m * clipm end
  work(m, {hand="detail", pile=crack_dark, coverage=3, fill=true, clip=m, angle=0, tool={kind="round", width=1.5}})
  return m
end
function lip(pts, w, load)
  local b = brush{kind="filbert", width=w, stiffness=0.4}
  b:load(lip_warm, load or 0.35)
  local up = {}
  for _, p in ipairs(pts) do up[#up+1] = {p[1], p[2] - w * 0.55, p[3] or 0.35} end
  b:gesture(up, {clip=FGmask:shrink(2)})
end
local inside = FGmask:shrink(3)
local f1 = {{230, 548}, {290, 551}, {350, 549}, {420, 553}, {470, 552}}
fissure(f1, {0.4, 2.2, 2.8, 2.0, 0.3}, 701, inside)
lip({{235, 548, 0.2}, {300, 551, 0.45}, {380, 550, 0.4}, {460, 552, 0.1}}, 4, 0.35)
print("ok")

--@ chunk 59
local band = ribbon({{230, 546}, {300, 548}, {380, 547}, {470, 549}}, 9):soften(3) * FGmask:shrink(2)
blend(band, {angle=0, tool={kind="badger", width=10}})

--@ chunk 60
for i = 1, 3 do
  local r = rag{width=12}
  r:dip(0.9)
  r:wipe({{225, 548 + (i-2) * 2}, {300, 550 + (i-2)*2}, {380, 549 + (i-2)*2}, {475, 551 + (i-2)*2}}, {pressure=0.8})
  r = rag{width=12}
  r:dip(0.9)
  r:wipe({{475, 549 - (i-2)*2}, {380, 547 - (i-2)*2}, {300, 548 - (i-2)*2}, {225, 546 - (i-2)*2}}, {pressure=0.8})
end

--@ chunk 61
rock_top2 = pile{{"raw umber", 2}, {"smalt", 1.2}, {"lead white", 0.7}, {"bone black", 0.35}, {"rose madder", 0.1}, name="rock_top2"}
rock_front2 = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.15}, {"red earth", 0.2}, name="rock_front2"}
function boulder(outline_pts, top_knots, seed, opts)
  opts = opts or {}
  local o = outline{pts=outline_pts, char="broken", seed=seed, closed=true, amount=opts.amount or 0.8}
  local B = o:mask()
  local topline = lineF(top_knots, 5, opts.amp or 2, seed + 1)
  local topm = B * above(topline)
  local frontm = B * below(topline)
  local miny = 1e9
  for _, p in ipairs(outline_pts) do miny = math.min(miny, p[2]) end
  local tl = crest_fn(topline)
  work(frontm, {hand="body", piles={{rock_front2, 1}, {fg_warm, 0.35}}, coverage=3, fill=true, clip=frontm, angle=1.4, angle_jitter=0.3, tool={kind="filbert", width=opts.fw or 5}})
  work(topm, {hand="body", piles={{rock_top2, function(x, y) return clamp(1 - (y - miny) / ((tl(x) - miny) * 1.3 + 1), 0.15, 1) end}, {fg_dark, function(x, y) return clamp((y - miny) / ((tl(x) - miny) * 1.3 + 1), 0, 0.85) end}}, coverage=3, fill=true, clip=topm, angle=0.08, angle_jitter=0.2, tool={kind="filbert", width=opts.tw or 4}})
  blend(topm:shrink(1), {angle=0.08, tool={kind="badger", width=12}})
  return B, topm, frontm
end
BOULDER1 = boulder({{40, 716, "c"}, {44, 668}, {62, 628, "c"}, {110, 610}, {176, 603, "c"}, {232, 611}, {268, 631, "c"}, {287, 667}, {292, 716, "c"}},
  {{30, 640}, {80, 632}, {150, 629}, {220, 636}, {300, 652}}, 801, {fw=6, tw=5})
print("ok")

--@ chunk 62
local m = BOULDER1:grow(3)
for i = 1, 3 do
  local r = rag{width=30}
  r:dip(0.95)
  r:wipe(m, {pressure=0.85, angle=(i == 2) and 1.5 or 0.1, passes=1, refold=0.25})
end
print(drying(160, 660))

--@ chunk 63
local m = BOULDER1:grow(10)
for i = 1, 5 do
  local r = rag{width=24}
  r:dip(0.95)
  r:wipe(m, {pressure=0.95, angle=({0.1, 1.5, 0.8, -0.7, 0})[i], passes=1, refold=0.2})
end
print(drying(160, 660), drying(150, 600))

--@ chunk 64
rim_p = mix{{rock_top2, 0.55}, {fg_dark, 0.45}, name="rim_p"}
function dark_rock(pts, top_pts, seed, rimw, bw)
  local o = outline{pts=pts, char="broken", seed=seed, closed=true, amount=0.8}
  local B = o:mask()
  work(B, {hand="body", piles={{fg_deep, 1}, {fg_dark, 0.35}}, coverage=3, fill=true, clip=B, angle=1.4, angle_jitter=0.4, tool={kind="filbert", width=bw or 4}})
  blend(B:shrink(1.5), {angle=1.4, tool={kind="badger", width=12}})
  local rim = ribbon(top_pts, rimw) * B:shrink(0.8)
  work(rim, {hand="detail", pile=rim_p, coverage=2.5, fill=true, clip=rim, angle=0, tool={kind="round", width=2}})
  blend(rim:grow(2) * B:shrink(0.8), {angle=0, tool={kind="badger", width=6}})
  return B
end
ROCK1 = dark_rock({{-5, 716, "c"}, {0, 655}, {28, 622, "c"}, {85, 604}, {150, 597, "c"}, {205, 606}, {244, 632, "c"}, {262, 680}, {268, 716, "c"}},
  {{8, 640}, {30, 621}, {85, 605}, {150, 598}, {204, 607}, {242, 632}}, 811, 8, 5)
print("ok")

--@ chunk 65
-- soften the rim's lower edge downward into the body
local soft = (ribbon({{8, 645}, {30, 626}, {85, 611}, {150, 604}, {204, 613}, {242, 638}}, 16) * ROCK1:shrink(1))
blend(soft, {angle=1.45, tool={kind="badger", width=8}})
-- break the rim with dark touches
local b = brush{kind="filbert", width=5}
local breaks = {{{58, 616}, {70, 612}}, {{118, 603}, {128, 601.5}}, {{206, 608}, {214, 612}}, {{176, 600}, {181, 601}}}
for _, s in ipairs(breaks) do
  b:load(fg_deep, 0.6)
  b:stroke(s, {pressure={0.6, 0.4}, clip=ROCK1:shrink(0.5)})
end
-- cover the lifted stains above the rock with the plateau's mixture
local st = (rect(85, 588, 160, 14) - ROCK1:grow(1))
work(st, {hand="detail", piles={{fg_dark, 1}, {fg_top, 0.35}}, coverage=3, fill=true, clip=st, angle=0, tool={kind="round", width=3}})
blend(st:soften(2) - ROCK1:grow(1), {angle=0, tool={kind="badger", width=10}})
print("ok")

--@ chunk 66
local m = (ROCK1:grow(8) + rect(80, 584, 170, 22)) * FGmask:shrink(2)
for i = 1, 5 do
  local r = rag{width=24}
  r:dip(0.95)
  r:wipe(m, {pressure=0.95, angle=({0.1, 1.5, 0.8, -0.7, 0})[i], passes=1, refold=0.2})
end
print(drying(130, 660), drying(150, 600), drying(150, 590))

--@ chunk 67
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c, d = drying(130, 660), drying(150, 600), drying(300, 548), drying(600, 600)
  if a == "dry" and b == "dry" and c == "dry" and d == "dry" then print("dry", t) break end
end

--@ chunk 68
fg_glow = pile{{"raw umber", 2}, {"red earth", 0.5}, {"lead white", 0.5}, {"rose madder", 0.2}, {"bone black", 0.4}, name="fg_glow"}
-- base pass over the whole plateau (covers the ghosts of lifted passages)
local nb = noise{seed=277, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
local function depth(x, y) return clamp((y - cFG(x)) / 200, 0, 1) end
local function wtop(x, y) return clamp(0.45 + 1.0 * nb(x, y), 0, 1) * (1 - depth(x, y)) ^ 1.5 * 0.8 end
local function wdark(x, y) return (1 - wtop(x, y)) * (1 - depth(x, y)) + 0.15 end
local function wdeep(x, y) return depth(x, y) ^ 0.8 * 1.2 end
local function wwarm(x, y) return 0.2 + 0.3 * clamp(nb(x + 300, y), 0, 1) end
PLAT = FGmask:shrink(1.5) * rect(-10, 440, 572, 290)
work(PLAT, {hand="body", piles={{fg_top, wtop}, {fg_dark, wdark}, {fg_deep, wdeep}, {fg_warm, wwarm}}, coverage=3, fill=true, clip=PLAT,
  angle=function(x, y) return 0.03 + 0.05 * math.sin(x / 80) end, angle_jitter=0.1,
  tool={kind="filbert", width=7}, length={30, 80},
  scale_at=function(x, y) return 0.6 + 0.9 * depth(x, y) end})
print(drying(300, 600))

--@ chunk 69
-- soft mounds of rock in perspective, worked into the wet base
function plat_lobe(cx, cy, rx, ry, seed, light)
  local m = ellipse(cx, cy, rx, ry):roughen(math.max(1.5, ry * 0.18), math.max(8, rx * 0.35), seed) * PLAT
  local top = cy - ry
  local wl = function(x, y) return clamp(1 - (y - top) / (ry * 1.2), 0, 1) * light end
  local wg = function(x, y) local t = (y - top) / (2 * ry); return clamp(1 - math.abs(t - 0.62) / 0.3, 0, 1) * 0.35 end
  local wd = function(x, y) return clamp((y - cy) / ry, 0, 1) * 0.9 end
  work(m, {hand="body", piles={{fg_top, wl}, {fg_glow, wg}, {fg_dark, function(x, y) return 0.5 end}, {fg_deep, wd}}, coverage=2.5, fill=true, clip=m, angle=0.02, angle_jitter=0.15, tool={kind="filbert", width=clamp(ry * 0.4, 3, 8)}, length={15, 45}})
  return m
end
LOBES = {
  {120, 512, 80, 9, 0.55}, {260, 512, 70, 7, 0.5}, {400, 515, 75, 8, 0.55},
  {60, 536, 70, 11, 0.5}, {200, 540, 95, 12, 0.45}, {350, 543, 80, 11, 0.5}, {480, 540, 60, 10, 0.45},
  {120, 578, 120, 18, 0.4}, {300, 584, 100, 17, 0.42}, {470, 580, 80, 16, 0.35},
  {40, 635, 110, 26, 0.32}, {230, 640, 130, 28, 0.35}, {420, 645, 110, 26, 0.3},
  {130, 712, 170, 40, 0.22}, {380, 718, 160, 38, 0.2},
}
local all = nil
for i, L in ipairs(LOBES) do
  local m = plat_lobe(L[1], L[2], L[3], L[4], 900 + i, L[5])
  all = all and (all + m) or m
end
blend(PLAT, {angle=0, tool={kind="badger", width=24}})
print(drying(300, 600))

--@ chunk 70
local face = (EDGE + (FGmask * rect(545, 495, 40, 230))):shrink(1) - PLAT:shrink(6)
local nb = noise{seed=377, octaves=3, period=40, stretch={1.4, 3}}
work(face, {hand="body", piles={{fg_deep, 1}, {fg_dark, function(x, y) return 0.5 + 0.5 * nb(x, y) end}, {fg_glow, function(x, y) return clamp(nb(x + 100, y), 0, 1) * 0.3 end}}, coverage=3, fill=true, clip=face, angle=1.3, angle_jitter=0.3, tool={kind="filbert", width=4}, length={10, 30}})
blend(face:shrink(1) + (PLAT * rect(530, 495, 40, 230)), {angle=1.3, tool={kind="badger", width=12}})
-- step tops catching the sky
local b = brush{kind="flat", width=3}
local tops = {{{566, 527}, {576, 530}}, {{582, 553}, {591, 556}}, {{598, 587}, {607, 590}}, {{613, 623}, {621, 626}}, {{625, 677}, {633, 680}}}
for _, t in ipairs(tops) do
  b:load(fg_top, 0.45)
  b:stroke(t, {pressure={0.45, 0.2}, clip=EDGE:shrink(0.5)})
end
print(drying(600, 640))

--@ chunk 71
local o = outline{{594, 586, "c"}, {603, 589}, {613, 591, "c"}, {616, 596}, {611, 601, "c"}, {600, 603}, {592, 601, "c"}, char="broken", seed=520, closed=true, amount=0.5}
local L = o:mask()
EDGE = EDGE + L
FGmask = FGmask + L
work(L, {hand="detail", piles={{fg_deep, 1}, {fg_dark, 0.5}}, coverage=3, fill=true, clip=L, angle=0, tool={kind="round", width=1.6}})
local b = brush{kind="flat", width=2.5}
b:load(fg_top, 0.4)
b:stroke({{597, 588}, {611, 591.5}}, {pressure={0.4, 0.2}, clip=L})
print("ok")

--@ chunk 72
for i = 1, 20 do
  local t = wait(24*60)
  local a, b, c, d = drying(300, 600), drying(100, 520), drying(600, 640), drying(604, 595)
  if a == "dry" and b == "dry" and c == "dry" and d == "dry" then print("dry", t) break end
end

--@ chunk 73
coat = pile{{"bone black", 1.2}, {"Prussian blue", 0.35}, {"raw umber", 1.2}, {"green earth", 0.4}, name="coat"}
hair = pile{{"raw umber", 2}, {"bone black", 0.8}, {"red earth", 0.3}, name="hair"}
cap_p = pile{{"bone black", 1.5}, {"raw umber", 1}, {"rose madder", 0.15}, name="cap_p"}
function figure_masks(fx, fy, s)
  local function P(dx, dy) return {fx + dx * s, fy + dy * s} end
  local M = {}
  M.legL = ribbon({P(-4.2, -19), P(-4.4, -8), P(-4.6, -1)}, {4.8*s, 4.2*s, 3.8*s})
  M.legR = ribbon({P(4.0, -19), P(4.3, -8), P(4.8, -1)}, {4.8*s, 4.2*s, 3.8*s})
  M.feet = ribbon({P(-7.0, -0.6), P(-2.8, -0.6)}, 2.2*s) + ribbon({P(2.4, -0.6), P(6.8, -0.6)}, 2.2*s)
  M.coat = poly({P(-6.3, -66), P(-8.8, -64.5), P(-10.0, -61), P(-10.4, -50), P(-11.2, -36), P(-12.4, -22), P(-11.8, -19.5),
                 P(-3, -18.2), P(0, -19.5), P(3, -18.2), P(12.0, -19.5), P(12.6, -22), P(11.2, -36), P(10.4, -50), P(10.0, -61), P(8.8, -64.5), P(6.3, -66)})
  M.armL = ribbon({P(-9.4, -61), P(-11.0, -50), P(-11.8, -40), P(-11.4, -33)}, {4.6*s, 4.4*s, 4.0*s, 3.4*s})
  M.armR = ribbon({P(9.4, -61), P(11.2, -51), P(12.4, -42), P(13.2, -35)}, {4.6*s, 4.4*s, 4.0*s, 3.4*s})
  M.collar = poly({P(-6.6, -67.5), P(-3.8, -70), P(3.8, -70), P(6.6, -67.5), P(6.3, -64), P(-6.3, -64)}, true)
  M.head = ellipse(fx + 0.3 * s, fy - 74.0 * s, 3.8 * s, 4.8 * s)
  M.cap = poly({P(-4.6, -76.2), P(-4.0, -79.0), P(-1, -80.2), P(3.5, -80.0), P(5.6, -78.4), P(5.0, -76.0), P(0.5, -76.8)}, true)
  M.stick = ribbon({P(13.6, -37), P(15.8, -18), P(18.4, 0)}, {1.3*s, 1.15*s, 1.0*s})
  M.body = M.legL + M.legR + M.feet + M.coat + M.armL + M.armR + M.collar
  M.all = M.body + M.head + M.cap + M.stick
  return M
end
figure = {x=470, foot=cFG(470) + 1.5, s=0.9}
FIG = figure_masks(figure.x, figure.foot, figure.s)
print(figure.foot, figure.foot - 80 * figure.s)

--@ chunk 74
local F = FIG
work(F.body, {hand="detail", pile=coat, coverage=3, fill=true, clip=F.body, angle=1.5, tool={kind="round", width=1.3}})
work(F.head - F.cap, {hand="detail", pile=hair, coverage=3, fill=true, clip=F.head - F.cap, angle=1.2, tool={kind="round", width=1.0}})
work(F.cap, {hand="detail", pile=cap_p, coverage=3, fill=true, clip=F.cap, angle=0, tool={kind="round", width=1.0}})
work(F.stick, {hand="detail", pile=hair, coverage=3, fill=true, clip=F.stick, angle=1.4, tool={kind="round", width=0.9}})
print("ok")
