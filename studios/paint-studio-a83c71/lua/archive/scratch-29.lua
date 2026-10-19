-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
function lineF(knots, step, amp, nseed)
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
FG = lineF({{-5,474},{30,466},{75,458},{110,466},{160,486},{230,494},{310,497},{390,498},{450,497},{500,496},{535,499},{555,508},{570,530},{582,570},{595,630},{606,720}}, 5, 2.5, 24)
local q = {}
for _, p in ipairs(FG) do q[#q+1] = p end
q[#q+1] = {-5, 720}
FGmask = poly(q)
moonC = {604, 298}; moonR = 12.5
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
function crest_fn(line)
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
function band_below(line, depth_fn)
  local q = {}
  for _, p in ipairs(line) do q[#q+1] = {p[1], p[2]} end
  for i = #line, 1, -1 do local p = line[i]; q[#q+1] = {p[1], p[2] + depth_fn(p[1])} end
  return poly(q)
end
function ridge_piles(rp, cf, d0, fade)
  local wr = function(x, y) return clamp(1 - (y - cf(x) - d0) / fade, 0, 1) end
  local list = {{rp, wr}}
  for i = 6, #SKYSTOPS do
    local h = sky_hat(i)
    list[#list+1] = {SKYSTOPS[i][2], function(x, y) return (1 - wr(x, y)) * h(x, y) end}
  end
  return list
end
ridge_near = pile{{"lead white", 1.0}, {"smalt", 2}, {"raw umber", 1.3}, {"Prussian blue", 0.25}, {"rose madder", 0.25}, {"yellow ochre", 0.2}, name="ridge_near"}
R3 = lineF({{520,470},{560,452},{600,441},{650,428},{720,412},{790,398},{860,391},{930,379},{1005,373}}, 5, 3, 23)
cR3 = crest_fn(R3)
-- sky + mist first pass
local piles = {}
for i = 1, #SKYSTOPS do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
piles[#piles+1] = {glow, function(x, y) local dx, dy = (x - moonC[1]) / 85, (y - moonC[2]) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}
local A = -FGmask
work(A, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=A, angle_jitter=0.04, tool={kind="filbert", width=22, lay=1.6}})
blend(A, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(500, 50) == "dry" and drying(700, 450) == "dry" and drying(800, 650) == "dry" then print("dry", t) break end
end

--@ chunk 3
local m = band_below(R3, function(x) return 150 end) - FGmask:grow(3)
R3mask = m
local piles = ridge_piles(ridge_near, cR3, 18, 85)
work(m, {hand="body", piles=piles, angle=function(x, y) return -0.12 + 0.05 * math.sin(x / 60) end, coverage=3, fill=true, clip=m, angle_jitter=0.06})
blend(m, {angle=0, tool={kind="badger", width=40}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(800, 420) == "dry" and drying(700, 500) == "dry" then print("dry", t) break end
end
BANK = lineF({{470,456},{520,447},{560,444},{600,450},{640,461},{690,471},{745,481},{790,486}}, 5, 4, 41)
local cB = crest_fn(BANK)
local ramp = mask(function(x, y) return clamp((y - cB(x)) / 16, 0, 1) end)
local m2 = (band_below(BANK, function(x) return 70 end) * ramp) - FGmask:grow(2)
m2 = m2 * mask(function(x, y) return clamp((800 - x) / 40, 0, 1) end)
local piles2 = {}
for i = 7, 10 do piles2[#piles2+1] = {SKYSTOPS[i][2], sky_hat(i)} end
work(m2, {hand="body", piles=piles2, angle=function(x, y) return 0.15 * math.sin(x / 40) end, coverage=3, fill=true, clip=m2, tool={kind="filbert", width=12},
  load_at=function(x, y) return clamp((y - cB(x)) / 22, 0.15, 1) end})
blend(m2, {angle=0, tool={kind="badger", width=30}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(600, 470) == "dry" and drying(700, 500) == "dry" then print("dry2", t) break end
end

--@ chunk 4
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
spruce_dark = pile{{"Prussian blue", 1}, {"raw umber", 2.5}, {"bone black", 1}, {"yellow ochre", 0.4}, name="spruce_dark"}
sp_crest = mix{{ridge_near, 0.7}, {spruce_dark, 0.3}, name="sp_crest"}
sp_crest2 = mix{{ridge_near, 0.85}, {spruce_dark, 0.15}, name="sp_crest2"}
local xs = uneven(46, 585, 1000, 0.6, 0.5, 71)
local m = nil
for i, x in ipairs(xs) do
  local cy = cR3(x)
  local hh = rand(7, 17) * (0.7 + 0.5 * (x - 585) / 415)
  local s = {x=x, tip=cy - hh, base=cy + 6, w=hh * rand(0.32, 0.42)}
  local sm = spruce2(s, 100 + i)
  m = m and (m + sm) or sm
end
work(m, {hand="detail", pile=sp_crest, angle=1.4, coverage=3, fill=true, clip=m, tool={kind="round", width=1.6}})
local xs2 = uneven(120, 560, 1000, 0.5, 0.6, 72)
local m2 = nil
for i, x in ipairs(xs2) do
  local cy = cR3(x)
  local hh = rand(5, 14) * (0.7 + 0.5 * (x - 560) / 440)
  local s = {x=x, tip=cy - hh + 1, base=cy + 8, w=hh * rand(0.45, 0.65)}
  local sm = spruce2(s, 300 + i)
  m2 = m2 and (m2 + sm) or sm
end
local q = {}
for _, p in ipairs(R3) do q[#q+1] = {p[1], p[2] - 3} end
local belt_m = band_below(q, function(x) return 12 end)
m2 = (m2 + belt_m) * rect(560, 0, 445, 714)
work(m2, {hand="detail", pile=sp_crest2, angle=1.4, coverage=2.5, fill=true, clip=m2, tool={kind="round", width=1.8}})
local q2 = {}
for _, p in ipairs(R3) do q2[#q2+1] = {p[1], p[2] + 3} end
local mb = band_below(q2, function(x) return 26 end):soften(5) * rect(560, 0, 445, 714)
blend(mb, {angle=-0.17, tool={kind="badger", width=16}})
blend(mb, {angle=0.6, tool={kind="badger", width=16}})
MISTTOP = lineF({{430,455},{500,450},{560,448},{620,458},{690,468},{760,474},{830,472},{900,468},{1005,463}}, 5, 5, 81)
local cT = crest_fn(MISTTOP)
local mv = mask(function(x, y)
  local v = smoothstep(cT(x) - 6, cT(x) + 22, y)
  local nose = clamp((610 - x) / 50, 0, 1) * smoothstep(cR3(x) - 8, cR3(x) + 6, y)
  return math.max(v, nose) * (x > 440 and 1 or 0)
end) - FGmask:grow(2)
local piles = {}
for i = 7, #SKYSTOPS do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
work(mv, {hand="broad", piles=piles, angle=function(x, y) return 0.05 * math.sin(x / 90 + y / 50) end, coverage=3.5, load=1.0, fill=true, clip=mv, angle_jitter=0.05, tool={kind="filbert", width=22, lay=1.6}})
blend(mv, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(700, 600) == "dry" and drying(800, 420) == "dry" and drying(620, 450) == "dry" then print("dry", t) break end
end

--@ chunk 5
-- trial A: a slanted mist lap over the ridge foot, replacing the vertical step at x≈610
local LW = lineF({{572, 447}, {600, 450}, {630, 455}, {665, 462}, {700, 467}, {740, 472}}, 4, 1.8, 611)
local cW = crest_fn(LW)
local function topw(x, y) return smoothstep(cW(x) - 3, cW(x) + 12, y) end
local function rightw(x) return 1 - smoothstep(690, 745, x) end
local function leftw(x) return smoothstep(562, 575, x) end
local W = mask(function(x, y) if x < 560 or x > 750 or y > 500 then return 0 end return topw(x, y) * rightw(x) * leftw(x) end)
LAPMASK = W
local piles = {}
for i = 7, 9 do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
work(W, {hand="body", piles=piles, angle=0.16, angle_jitter=0.08, coverage=3, fill=true, clip=W, tool={kind="filbert", width=10}, length={20, 50},
  load_at=function(x, y)
    local t = clamp((y - cW(x) + 2) / 16, 0, 1)
    local b = 1 - smoothstep(cW(x) + 22, cW(x) + 40, y)
    return clamp(t * b * rightw(x), 0.06, 1)
  end})
blend(W, {angle=0.16, tool={kind="badger", width=24}})
print(drying(620, 455))

--@ chunk 6
for i = 1, 20 do
  local t = wait(24*60)
  if drying(620, 455) == "dry" and drying(680, 465) == "dry" then print("dry", t) break end
end
local s = {}
for x = 590, 740, 10 do s[#s+1] = string.format("%d:%.1f", x, cR3(x)) end
print(table.concat(s, " "))

--@ chunk 7
-- trial B: the lap set higher, over the lower part of the ridge body
local LW = lineF({{586, 443}, {600, 444}, {615, 446}, {635, 449.5}, {660, 454}, {690, 458}, {715, 461}}, 4, 1.5, 612)
local cW = crest_fn(LW)
local function rightw(x) return 1 - smoothstep(665, 712, x) end
local function leftw(x) return smoothstep(576, 590, x) end
local W = mask(function(x, y) if x < 570 or x > 720 or y > 495 then return 0 end return smoothstep(cW(x) - 3, cW(x) + 10, y) * rightw(x) * leftw(x) end)
local piles = {}
for i = 7, 9 do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
work(W, {hand="body", piles=piles, angle=0.15, angle_jitter=0.08, coverage=3, fill=true, clip=W, tool={kind="filbert", width=9}, length={18, 45},
  load_at=function(x, y)
    local t = clamp((y - cW(x) + 2) / 14, 0, 1)
    local b = 1 - smoothstep(cW(x) + 22, cW(x) + 40, y)
    return clamp(t * b * rightw(x) * leftw(x), 0.06, 1)
  end})
blend(W, {angle=0.15, tool={kind="badger", width=22}})
print(drying(620, 450))

--@ chunk 8
for i = 1, 20 do
  local t = wait(24*60)
  if drying(620, 450) == "dry" and drying(660, 470) == "dry" then print("dry", t) break end
end
