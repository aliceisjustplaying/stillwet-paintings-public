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
sky_night = pile{{"smalt", 3}, {"cobalt blue", 1.2}, {"lead white", 0.5}, {"bone black", 0.4}, {"rose madder", 0.2}, name="sky_night"}
halo = pile{{"lead white", 7}, {"Naples yellow", 1.0}, {"smalt", 0.25}, {"rose madder", 0.1}, name="halo"}
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
moonC = {604, 298}; moonR = 12.5
local piles = {}
for i = 1, #SKYSTOPS do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
piles[#piles+1] = {glow, function(x, y) local dx, dy = (x - moonC[1]) / 85, (y - moonC[2]) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}
local m = rect(0, 0, 1000, 420)
work(m, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=m, angle_jitter=0.04, tool={kind="filbert", width=22, lay=1.6}})
blend(m, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do local t = wait(24*60); if drying(500, 50) == "dry" and drying(500, 300) == "dry" then print("dry", t) break end end
local function hat(c, w) return function(x, y) return math.max(0, 1 - math.abs(y - c) / w) end end
local mt = rect(0, 0, 1000, 215) * mask(function(x, y) return clamp((210 - y) / 60, 0, 1) end)
work(mt, {hand="broad", piles={{sky_night, function(x,y) return clamp(1 - y/75, 0, 1) end}, {sky_deep, hat(70, 60)}, {sky_blue, hat(125, 55)}, {sky_mid, function(x,y) return clamp((y - 125)/50, 0, 1) end}}, angle=0, coverage=3.5, load=1, fill=true, clip=mt, tool={kind="filbert", width=22, lay=1.6}, load_at=function(x, y) return clamp((205 - y) / 70, 0.1, 1) end})
blend(rect(0, 0, 1000, 212), {angle=0, tool={kind="badger", width=60}})
local ms = mask(function(x, y) return smoothstep(118, 150, y) * (1 - smoothstep(232, 256, y)) end)
work(ms, {hand="broad", piles={{sky_blue, hat(115, 45)}, {sky_mid, hat(160, 50)}, {sky_lilac, hat(212, 40)}, {belt, function(x, y) return clamp((y - 222) / 30, 0, 1) end}}, angle=0, coverage=3.5, load=1, fill=true, clip=ms, tool={kind="filbert", width=22, lay=1.6}, load_at=function(x, y) return clamp((258 - y) / 50, 0.1, 1) end})
blend(mask(function(x, y) return smoothstep(95, 135, y) * (1 - smoothstep(240, 262, y)) end), {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do local t = wait(24*60); if drying(500, 50) == "dry" and drying(500, 240) == "dry" and drying(500, 150) == "dry" then print("dry2", t) break end end
local c = moonC
local function gl(rx, ry, a) return function(x, y) local dx, dy = (x - c[1]) / rx, (y - c[2]) / ry; return a * math.exp(-(dx*dx + dy*dy)) end end
local g = gl(60, 45, 1)
function halo_piles()
  local piles = {}
  for i = 4, 8 do local h = sky_hat(i); piles[#piles+1] = {SKYSTOPS[i][2], function(x, y) return h(x, y) * (1 - 0.7 * g(x, y)) end} end
  piles[#piles+1] = {glow, function(x, y) local dx, dy = (x - c[1]) / 85, (y - c[2]) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}
  piles[#piles+1] = {halo, gl(48, 38, 1.9)}
  return piles
end
moon = pile{{"lead white", 6}, {"Naples yellow", 1.2}, {"vermilion", 0.03}, name="moon"}
local mm = ellipse(c[1], c[2], moonR, moonR)
work(mm, {hand="detail", pile=moon, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=20}, tool={kind="round", width=3.5}})
for i = 1, 20 do local t = wait(24*60); if drying(604, 298) == "dry" then print("moon", t) break end end
local excl = ellipse(c[1], c[2], moonR + 1.0, moonR + 1.0)
HALOBAND = mask(function(x, y) return smoothstep(226, 258, y) * ((y < 380) and 1 or 0) end):soften(0.6)
local hm = HALOBAND - excl
work(hm, {hand="broad", piles=halo_piles(), angle=0, coverage=3.5, load=1.0, fill=true, clip=hm, angle_jitter=0.04, length={30, 90}, tool={kind="filbert", width=22, lay=1.6},
  load_at=function(x, y) return clamp((y - 226) / 40, 0.1, 1) end})
blend(hm, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do local t = wait(24*60); if drying(500, 300) == "dry" and drying(604, 260) == "dry" then print("dry3", t) break end end

--@ chunk 3
-- A: wedge fill (x 0-320)
local fA = function(x, y) return smoothstep(212, 238, y) * (1 - smoothstep(246, 262, y)) end
local A = mask(fA) * rect(0, 0, 320, 400)
work(A, {hand="body", piles=halo_piles(), angle=0, coverage=2.5, fill=true, clip=A, angle_jitter=0.2, length={25, 70}, tool={kind="filbert", width=14, lay=1.6},
  load_at=function(x, y) return clamp(fA(x, y) * 0.7, 0.03, 0.7) end})
blend(A, {angle=0, tool={kind="badger", width=40}})
-- B: knife only (x 340-560)
knm = mix{{sky_lilac, 0.4}, {belt, 0.6}, name="knm"}
local k = knife{width=10}
k:load(knm, 0.5)
k:lay({{340, 242}, {450, 242.3}, {560, 241.8}}, {pressure={0.95, 0.95}})
k:wipe()
-- C: short oblique crossing strokes, then badger (x 660-1000)
local b = brush{kind="filbert", width=8, lay=1.2}
local hp = halo_piles()
math.randomseed(77)
for i = 1, 70 do
  local x0 = rand(665, 995)
  local a = rand(-0.5, 0.5) + ((i % 2 == 0) and 0.2 or -0.2)
  local L = rand(14, 26)
  local y0 = 242 + rand(-4, 4)
  if i % 5 == 1 then
    local tmp = mix{{sky_lilac, 0.4}, {belt, 0.6}}
    b:reload(tmp, 0.45)
  end
  b:stroke({{x0 - math.cos(a) * L / 2, y0 - math.sin(a) * L / 2}, {x0 + math.cos(a) * L / 2, y0 + math.sin(a) * L / 2}}, {pressure={0.35, 0.15}})
end
local fC = function(x, y) return smoothstep(220, 236, y) * (1 - smoothstep(248, 264, y)) end
blend(mask(fC) * rect(655, 0, 345, 400), {angle=0, tool={kind="badger", width=30}})
for i = 1, 20 do local t = wait(24*60); if drying(150, 242) == "dry" and drying(450, 242) == "dry" and drying(800, 242) == "dry" then print("dry", t) break end end

--@ chunk 4
local c = moonC
local excl = ellipse(c[1], c[2], moonR + 1.5, moonR + 1.5)
local fW = function(x, y) return smoothstep(231, 239, y) * (1 - smoothstep(245, 253, y)) end
local Wm = mask(fW) * rect(545, 0, 120, 400)
local guard = mask(function(x, y) return smoothstep(212, 222, y) * (1 - smoothstep(264, 274, y)) end) - excl
work(Wm, {hand="body", piles=halo_piles(), angle=0, angle_jitter=0.5, coverage=1.6, fill=false, clip=guard, length={14, 26},
  tool={kind="filbert", width=8, lay=1.2}, load=0.45, pressure={0.25, 0.4}, ramps={0.3, 0.4}, seed=901})
blend(mask(function(x, y) return smoothstep(220, 234, y) * (1 - smoothstep(250, 264, y)) end) * rect(540, 0, 130, 400) - excl, {angle=0, tool={kind="badger", width=30}})
for i = 1, 20 do local t = wait(24*60); if drying(600, 242) == "dry" then print("dry", t) break end end

--@ chunk 5
function line_mend(x0, x1, n, load, seed, piles_at)
  local b = brush{kind="filbert", width=8, lay=1.2}
  math.randomseed(seed)
  for i = 1, n do
    local x = rand(x0, x1)
    local a = rand(-0.5, 0.5) + ((i % 2 == 0) and 0.2 or -0.2)
    local L = rand(14, 26)
    local y0 = 242.5 + rand(-4, 4)
    if i % 5 == 1 then b:reload(piles_at(x), load) end
    b:stroke({{x - math.cos(a) * L / 2, y0 - math.sin(a) * L / 2}, {x + math.cos(a) * L / 2, y0 + math.sin(a) * L / 2}}, {pressure={0.35, 0.15}})
  end
  local f = function(x, y) return smoothstep(220, 236, y) * (1 - smoothstep(248, 264, y)) * smoothstep(x0 - 15, x0 + 5, x) * (1 - smoothstep(x1 - 5, x1 + 15, x)) end
  blend(mask(f), {angle=0, tool={kind="badger", width=30}})
end
local function knm_at(x) return knm end
line_mend(665, 995, 70, 0.45, 78, knm_at)
line_mend(5, 315, 100, 0.55, 79, knm_at)
for i = 1, 20 do local t = wait(24*60); if drying(150, 242) == "dry" and drying(800, 242) == "dry" then print("dry", t) break end end

--@ chunk 6
star = pile{{"lead white", 6}, {"Naples yellow", 0.6}, name="star"}
local spots = {{520, 150, 1.4, 0.5}, {668, 128, 1.6, 0.55}, {300, 100, 1.2, 0.45}}
for _, s in ipairs(spots) do
  local b = brush{kind="round", width=s[3], point=0.6}
  b:load(star, 0.6)
  b:touch(s[1], s[2], {pressure=s[4]})
  b:touch(s[1] + 0.2, s[2] + 0.1, {pressure=s[4] * 0.8})
end
print("ok")

--@ chunk 7
local spots = {{430, 85, 2.4, 0.6}, {760, 110, 2.0, 0.6}, {250, 140, 2.8, 0.55}}
for _, s in ipairs(spots) do
  local b = brush{kind="round", width=s[3], point=0.6}
  b:load(star, 0.7)
  b:touch(s[1], s[2], {pressure=s[4]})
  b:touch(s[1] + 0.3, s[2] + 0.2, {pressure=s[4] * 0.7})
end
print("ok")
