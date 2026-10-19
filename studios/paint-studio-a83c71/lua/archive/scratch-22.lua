-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
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
moonC = {604, 298}; moonR = 12.5
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
local piles = {}
for i = 1, #SKYSTOPS do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
piles[#piles+1] = {glow, function(x, y) local dx, dy = (x - moonC[1]) / 85, (y - moonC[2]) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}
local m = rect(0, 60, 1000, 440)
work(m, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=m, angle_jitter=0.04, tool={kind="filbert", width=22, lay=1.6}})
blend(m, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(500, 200) == "dry" and drying(600, 300) == "dry" and drying(800, 450) == "dry" then print("dry", t) break end
end
R1 = lineF({{-5,352},{120,346},{260,356},{380,349},{470,358},{560,352},{690,343},{800,350},{900,341},{1005,348}}, 6, 2.5, 21)
cR1 = crest_fn(R1)
ridge_far = pile{{"lead white", 3.5}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.45}, {"raw umber", 0.3}, name="ridge_far"}
local rm = band_below(R1, function(x) return 55 end)
work(rm, {hand="body", piles=ridge_piles(ridge_far, cR1, 6, 34), angle=0, coverage=3, fill=true, clip=rm, angle_jitter=0.05})
blend(rm, {angle=0, tool={kind="badger", width=40}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(700, 352) == "dry" and drying(900, 345) == "dry" then print("dry", t) break end
end
moon = pile{{"lead white", 6}, {"Naples yellow", 1.2}, {"vermilion", 0.03}, name="moon"}
local mm = ellipse(moonC[1], moonC[2], moonR, moonR)
work(mm, {hand="detail", pile=moon, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=20}, tool={kind="round", width=3.5}})
local ring = mm - ellipse(moonC[1], moonC[2], moonR - 4, moonR - 4)
work(ring, {hand="detail", pile=moon, coverage=2.5, fill=true, clip=mm:soften(0.8), tool={kind="round", width=2.2}})
local k = knife{width=4}
local pts = {}
for i = 0, 48 do local a = i / 48 * 2 * math.pi; pts[#pts+1] = {moonC[1] + 15 * math.cos(a), moonC[2] + 15 * math.sin(a)} end
k:scrape(pts, {pressure=1})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(604, 298) == "dry" then print("moon dry", t) break end
end

--@ chunk 3
halo = pile{{"lead white", 7}, {"Naples yellow", 1.0}, {"smalt", 0.25}, {"rose madder", 0.1}, name="halo"}
local function gl(rx, ry, a) return function(x, y) local dx, dy = (x - moonC[1]) / rx, (y - moonC[2]) / ry; return a * math.exp(-(dx*dx + dy*dy)) end end
local excl = ellipse(moonC[1], moonC[2], moonR + 1.0, moonR + 1.0)
local top0, top1 = 160, 222
local band = mask(function(x, y) return smoothstep(top0, top1, y) end) * above(R1)
local m = band - excl
local g = gl(70, 50, 1)
local piles = {}
for i = 3, 8 do local h = sky_hat(i); piles[#piles+1] = {SKYSTOPS[i][2], function(x, y) return h(x, y) * (1 - 0.75 * g(x, y)) end} end
piles[#piles+1] = {glow, function(x, y) local dx, dy = (x - moonC[1]) / 85, (y - moonC[2]) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}
piles[#piles+1] = {halo, gl(60, 45, 2.2)}
work(m, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=m, angle_jitter=0.04, tool={kind="filbert", width=22, lay=1.6},
  load_at=function(x, y) return clamp((y - top0) / 70, 0.1, 1) end})
blend(band:soften(2) - excl, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(604, 330) == "dry" and drying(604, 270) == "dry" and drying(400, 230) == "dry" then print("dry", t) break end
end

--@ chunk 4
MOONS = {{250, 300}, {850, 295}}
for _, c in ipairs(MOONS) do
  local mm = ellipse(c[1], c[2], moonR, moonR)
  work(mm, {hand="detail", pile=moon, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=20}, tool={kind="round", width=3.5}})
  local ring = mm - ellipse(c[1], c[2], moonR - 4, moonR - 4)
  work(ring, {hand="detail", pile=moon, coverage=2.5, fill=true, clip=mm:soften(0.8), tool={kind="round", width=2.2}})
  local k = knife{width=4}
  local pts = {}
  for i = 0, 48 do local a = i / 48 * 2 * math.pi; pts[#pts+1] = {c[1] + 15 * math.cos(a), c[2] + 15 * math.sin(a)} end
  k:scrape(pts, {pressure=1})
end
for i = 1, 20 do
  local t = wait(24*60)
  if drying(250, 300) == "dry" and drying(850, 295) == "dry" then print("moon dry", t) break end
end

--@ chunk 5
halo_v = pile{{"lead white", 7}, {"Naples yellow", 1.0}, {"smalt", 0.25}, {"rose madder", 0.1}, thinner=0.7, name="halo_v"}
-- B: thinner veils, soft filbert, three passes of shrinking radius, radial-ish short strokes
local c = MOONS[1]
local excl = ellipse(c[1], c[2], moonR + 0.8, moonR + 0.8)
for k, r in ipairs({65, 45, 30}) do
  local m = ellipse(c[1], c[2], r, r * 0.8):soften(r * 0.35) - excl
  work(m, {hand="glaze", pile=halo_v, coverage=1.2, length={20, 45}, tool={kind="filbert", width=14, stiffness=0.2}, angle=0, angle_jitter=0.3, pressure={0.2, 0.4}, seed=500 + k})
end
print(drying(c[1] + 30, c[2]))

--@ chunk 6
local c = MOONS[1]
local excl = ellipse(c[1], c[2], moonR + 0.8, moonR + 0.8)
local m = ellipse(c[1], c[2], 75, 62):soften(20) - excl
blend(m, {angle=0, tool={kind="badger", width=30}})
print(drying(c[1] + 30, c[2]))

--@ chunk 7
for i = 1, 20 do
  local t = wait(24*60)
  if drying(280, 300) == "dry" then print("dry", t) break end
end
local c = MOONS[2]
local function gl(rx, ry, a) return function(x, y) local dx, dy = (x - c[1]) / rx, (y - c[2]) / ry; return a * math.exp(-(dx*dx + dy*dy)) end end
local excl = ellipse(c[1], c[2], moonR + 1.0, moonR + 1.0) + ellipse(MOONS[1][1], MOONS[1][2], moonR + 1.0, moonR + 1.0)
local top0, top1 = 226, 258
local bot0, bot1 = 322, 340
local band = mask(function(x, y) return smoothstep(top0, top1, y) * (1 - smoothstep(bot0, bot1, y)) end)
local m = band - excl
local g = gl(60, 45, 1)
local piles = {}
for i = 4, 8 do local h = sky_hat(i); piles[#piles+1] = {SKYSTOPS[i][2], function(x, y) return h(x, y) * (1 - 0.7 * g(x, y)) end} end
piles[#piles+1] = {glow, function(x, y) local dx, dy = (x - c[1]) / 85, (y - c[2]) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}
piles[#piles+1] = {halo, gl(48, 38, 1.9)}
work(m, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=m, angle_jitter=0.04, tool={kind="filbert", width=22, lay=1.6},
  load_at=function(x, y) return clamp(math.min((y - top0) / 40, (bot1 + 5 - y) / 25), 0.1, 1) end})
blend(band - excl, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(850, 330) == "dry" and drying(850, 260) == "dry" and drying(400, 240) == "dry" then print("dry", t) break end
end

--@ chunk 8
local c = MOONS[1]
local function gl(rx, ry, a) return function(x, y) local dx, dy = (x - c[1]) / rx, (y - c[2]) / ry; return a * math.exp(-(dx*dx + dy*dy)) end end
local excl = ellipse(c[1], c[2], moonR + 1.0, moonR + 1.0)
local top0, top1 = 226, 258
local q = {}
for _, p in ipairs(R1) do q[#q+1] = {p[1], p[2] - 0.6} end
local band = (mask(function(x, y) return smoothstep(top0, top1, y) end) * above(q)) * rect(0, 0, 520, 714)
local m = band - excl
local g = gl(60, 45, 1)
local piles = {}
for i = 4, 8 do local h = sky_hat(i); piles[#piles+1] = {SKYSTOPS[i][2], function(x, y) return h(x, y) * (1 - 0.7 * g(x, y)) end} end
piles[#piles+1] = {glow, function(x, y) local dx, dy = (x - c[1]) / 85, (y - c[2]) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}
piles[#piles+1] = {halo, gl(48, 38, 1.9)}
work(m, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=m, angle_jitter=0.04, length={30, 90}, tool={kind="filbert", width=22, lay=1.6},
  load_at=function(x, y) return clamp((y - top0) / 40, 0.1, 1) end})
blend(band - excl, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(250, 330) == "dry" and drying(250, 260) == "dry" then print("dry", t) break end
end
