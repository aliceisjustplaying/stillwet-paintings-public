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
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
fg_warm = pile{{"raw umber", 3}, {"bone black", 0.5}, {"red earth", 0.5}, {"yellow ochre", 0.5}, name="fg_warm"}
fg_top = pile{{"raw umber", 2}, {"smalt", 1.3}, {"lead white", 0.6}, {"bone black", 0.45}, {"rose madder", 0.1}, name="fg_top"}
fg_deep = pile{{"raw umber", 2.5}, {"bone black", 1.4}, {"Prussian blue", 0.3}, {"red earth", 0.15}, name="fg_deep"}
crack_dark = pile{{"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.2}, name="crack_dark"}
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
work(rect(0,0,1000,300), {hand="broad", pile=mist_bright, coverage=3, fill=true, clip=true, angle=0})
local m = rect(0, 300, 1000, 414)
local nb = noise{seed=277, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
local function depth(x, y) return clamp((y - 300) / 200, 0, 1) end
local function wtop(x, y) return clamp(0.45 + 1.0 * nb(x, y), 0, 1) * (1 - depth(x, y)) ^ 1.5 * 0.8 end
work(m, {hand="body", piles={{fg_top, wtop}, {fg_dark, function(x, y) return (1 - wtop(x, y)) * (1 - depth(x, y)) + 0.15 end}, {fg_deep, function(x, y) return depth(x, y) ^ 0.8 * 1.2 end}, {fg_warm, function(x, y) return 0.3 end}}, coverage=3, fill=true, clip=m, angle=0.04, angle_jitter=0.1, tool={kind="filbert", width=7}, length={30, 80}, scale_at=function(x, y) return 0.6 + 0.9 * depth(x, y) end})
blend(m, {angle=0, tool={kind="badger", width=24}})
wait(14*24*60)
print(drying(500, 500))

--@ chunk 3
function crest_fn(line)
  local pts = {}
  for _, p in ipairs(line) do pts[#pts+1] = p end
  table.sort(pts, function(a, b) return a[1] < b[1] end)
  return function(x)
    if x <= pts[1][1] then return pts[1][2] end
    if x >= pts[#pts][1] then return pts[#pts][2] end
    local lo, hi = 1, #pts
    while hi - lo > 1 do local mid = (lo + hi) // 2; if pts[mid][1] <= x then lo = mid else hi = mid end end
    local a, b = pts[lo], pts[hi]
    local t = (x - a[1]) / math.max(1e-6, b[1] - a[1])
    return a[2] + (b[2] - a[2]) * t
  end
end
-- a step: lip line; above it a soft lit band; below it a dark riser of varying height; ends fade
function step(knots, seed, riser, litw, clipm)
  local L = lineF(knots, 4, 1.6, seed)
  local cf = crest_fn(L)
  local x0, x1 = knots[1][1], knots[#knots][1]
  local nr = noise{seed=seed + 5, octaves=3, period=30}
  local function endfade(x) return clamp(math.min(x - x0, x1 - x) / 25, 0, 1) end
  local lit = mask(function(x, y)
    if x < x0 or x > x1 then return 0 end
    local d = cf(x) - y
    if d < 0 or d > litw then return 0 end
    return (1 - d / litw) * endfade(x)
  end)
  local ris = mask(function(x, y)
    if x < x0 or x > x1 then return 0 end
    local h = riser * (0.5 + 0.5 * nr(x, 0)) * endfade(x)
    local d = y - cf(x)
    return (d >= 0 and d <= h) and 1 or 0
  end)
  if clipm then lit = lit * clipm; ris = ris * clipm end
  work(lit, {hand="body", pile=fg_top, coverage=2, fill=true, clip=lit, angle=0, load=0.5, tool={kind="filbert", width=3}, length={10, 30}})
  work(ris, {hand="detail", piles={{fg_deep, 1}, {crack_dark, 0.6}}, coverage=3, fill=true, clip=ris, angle=0, tool={kind="round", width=1.5}})
  blend(lit:grow(2):soften(2), {angle=0, tool={kind="badger", width=8}})
end
step({{40, 360}, {140, 357}, {260, 362}, {330, 359}}, 1, 4, 10)
step({{180, 420}, {300, 424}, {420, 419}, {520, 425}}, 2, 6, 14)
step({{20, 520}, {160, 528}, {300, 522}, {380, 530}}, 3, 9, 20)
print("ok")

--@ chunk 4
fg_mid = mix{{fg_top, 0.35}, {fg_dark, 0.45}, {fg_warm, 0.2}, name="fg_mid"}
function step2(knots, seed, riser, litw, clipm)
  local L = lineF(knots, 4, 1.6, seed)
  local cf = crest_fn(L)
  local x0, x1 = knots[1][1], knots[#knots][1]
  local nr = noise{seed=seed + 5, octaves=3, period=30}
  local function endfade(x) return clamp(math.min(x - x0, x1 - x) / 30, 0, 1) end
  local lit = mask(function(x, y)
    if x < x0 or x > x1 then return 0 end
    local d = cf(x) - y
    if d < 0 or d > litw then return 0 end
    return 1
  end)
  local ris = mask(function(x, y)
    if x < x0 or x > x1 then return 0 end
    local h = riser * (0.4 + 0.6 * nr(x, 0)) * endfade(x)
    local d = y - cf(x)
    return (d >= 0 and d <= h) and 1 or 0
  end)
  if clipm then lit = lit * clipm; ris = ris * clipm end
  work(lit, {hand="body", pile=fg_mid, coverage=1.5, fill=false, clip=lit, angle=0, tool={kind="filbert", width=3}, length={10, 30}, load_at=function(x, y) return clamp((litw - (cf(x) - y)) / litw, 0.05, 0.6) * endfade(x) end})
  work(ris, {hand="detail", piles={{fg_deep, 1}, {crack_dark, 0.6}}, coverage=3, fill=true, clip=ris, angle=0, tool={kind="round", width=1.5}})
  blend(lit:grow(3), {angle=0, tool={kind="badger", width=10}})
end
local m = rect(500, 300, 500, 414)
step2({{540, 360}, {640, 357}, {760, 362}, {830, 359}}, 1, 4, 10)
step2({{680, 420}, {800, 424}, {920, 419}, {1000, 425}}, 2, 6, 14)
step2({{520, 520}, {660, 528}, {800, 522}, {880, 530}}, 3, 9, 20)
print("ok")

--@ chunk 5
heath = pile{{"raw umber", 2}, {"bone black", 0.8}, {"green earth", 1}, {"yellow ochre", 0.4}, {"rose madder", 0.15}, name="heath"}
heath_lt = pile{{"raw umber", 1.5}, {"yellow ochre", 0.7}, {"green earth", 0.8}, {"lead white", 0.35}, {"rose madder", 0.25}, name="heath_lt"}
heath_dk = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.2}, {"green earth", 0.4}, name="heath_dk"}
function heather2(cx, cy, r, seed)
  math.randomseed(seed)
  -- shadow underneath
  local sh = ellipse(cx + r * 0.1, cy + r * 0.25, r * 1.05, r * 0.28):roughen(r * 0.15, r * 0.4, seed + 1)
  work(sh, {hand="detail", pile=heath_dk, coverage=2.5, fill=true, clip=sh, angle=0, tool={kind="round", width=1.5}})
  -- the mound: many short upward strokes from the base
  local b = brush{kind="round", width=math.max(0.9, r * 0.09), point=0.9}
  local n = math.floor(r * 4)
  b:load(heath, 0.8)
  for i = 1, n do
    if i % 10 == 0 then b:load(heath, 0.7) end
    local u = rand(-1, 1)
    local x0 = cx + u * r * 0.95
    local hmax = r * 0.55 * math.sqrt(math.max(0, 1 - u * u)) + 1
    local L = hmax * rand(0.5, 1.1)
    local a = -math.pi / 2 + u * 0.5 + randn(0, 0.25)
    local y0 = cy + rand(-0.05, 0.2) * r
    b:gesture({{x0, y0, 0.7}, {x0 + math.cos(a) * L * 0.6, y0 + math.sin(a) * L * 0.6, 0.45}, {x0 + math.cos(a) * L, y0 + math.sin(a) * L, 0.0}})
  end
  -- a few lit tips, upper left
  b:load(heath_lt, 0.6)
  for i = 1, math.floor(r * 1.2) do
    local u = rand(-0.8, 0.5)
    local x0 = cx + u * r
    local top = cy - r * 0.5 * math.sqrt(math.max(0, 1 - u * u))
    local a = -math.pi / 2 + randn(0, 0.3)
    local L = rand(1.5, 3.5) * r / 10
    b:gesture({{x0, top + L * 0.8, 0.5}, {x0 + math.cos(a) * L, top + L * 0.8 + math.sin(a) * L, 0.0}})
  end
end
heather2(120, 640, 14, 1)
heather2(150, 646, 8, 2)
heather2(300, 660, 20, 3)
heather2(380, 600, 9, 4)
heather2(420, 602, 5, 5)
print("ok")

--@ chunk 6
heath_lt2 = pile{{"raw umber", 1.6}, {"yellow ochre", 0.4}, {"green earth", 0.6}, {"lead white", 0.35}, {"smalt", 0.2}, {"rose madder", 0.15}, name="heath_lt2"}
heath_lt = heath_lt2
function fissure_broken(pts, wmax, seed, clipm)
  math.randomseed(seed)
  local total = #pts
  local i = 1
  while i < total do
    local j = math.min(total, i + math.random(2, 5))
    local seg, ws = {}, {}
    for k = i, j do seg[#seg+1] = pts[k]; ws[#ws+1] = wmax * (0.3 + 0.7 * math.sin(math.pi * (k - i) / math.max(1, j - i))) + 0.25 end
    local fm = ribbon(seg, ws):roughen(0.6, 5, seed + i)
    if clipm then fm = fm * clipm end
    work(fm, {hand="detail", piles={{crack_dark, 1}, {fg_deep, 0.8}}, coverage=3, fill=true, clip=fm, angle=0, tool={kind="round", width=1.2}})
    i = j + math.random(1, 2)
  end
end
local function pl(x0, x1, y, amp, seed, step)
  local n = noise{seed=seed, octaves=3, period=40}
  local out = {}
  for x = x0, x1, step or 7 do out[#out+1] = {x, y + amp * n(x, y)} end
  return out
end
fissure_broken(pl(520, 990, 585, 2.5, 21, 7), 1.6, 21)
fissure_broken(pl(540, 990, 625, 3.5, 22, 9), 2.4, 22)
fissure_broken(pl(520, 990, 680, 5, 23, 11), 3.4, 23)
heather2(620, 618, 9, 31)
heather2(760, 676, 16, 32)
heather2(800, 680, 9, 33)
heather2(900, 583, 6, 34)
print("ok")
