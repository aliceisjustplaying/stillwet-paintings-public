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
local piles = {}
for i = 1, #SKYSTOPS do piles[#piles+1] = {SKYSTOPS[i][2], sky_hat(i)} end
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

--@ chunk 3
moonC = {604, 298}; moonR = 12.5
local c = moonC
local function gl(rx, ry, a) return function(x, y) local dx, dy = (x - c[1]) / rx, (y - c[2]) / ry; return a * math.exp(-(dx*dx + dy*dy)) end end
local excl = ellipse(c[1], c[2], moonR + 1.0, moonR + 1.0)
local top0, top1 = 226, 258
HALOBAND = mask(function(x, y) return smoothstep(top0, top1, y) * ((y < 380) and 1 or 0) end):soften(0.6)
local m = HALOBAND - excl
local g = gl(60, 45, 1)
local piles = {}
for i = 4, 8 do local h = sky_hat(i); piles[#piles+1] = {SKYSTOPS[i][2], function(x, y) return h(x, y) * (1 - 0.7 * g(x, y)) end} end
piles[#piles+1] = {glow, function(x, y) local dx, dy = (x - c[1]) / 85, (y - c[2]) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}
piles[#piles+1] = {halo, gl(48, 38, 1.9)}
work(m, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=m, angle_jitter=0.04, length={30, 90}, tool={kind="filbert", width=22, lay=1.6},
  load_at=function(x, y) return clamp((y - top0) / 40, 0.1, 1) end})
blend(m, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do local t = wait(24*60); if drying(500, 300) == "dry" and drying(604, 260) == "dry" then print("dry", t) break end end

--@ chunk 4
local a = mask(function(x, y) return smoothstep(226, 258, y) end)
local b = a:soften(0.6)
local c = a:blur(0.6)
local out = {}
for _, y in ipairs({228, 234, 238, 241, 242, 243, 246, 250, 256}) do out[#out+1] = string.format("%d: %.2f %.2f %.2f", y, a:at(300, y), b:at(300, y), c:at(300, y)) end
print(table.concat(out, " | "))

--@ chunk 5
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
local excl = ellipse(c[1], c[2], moonR + 1.0, moonR + 1.0)
-- L: soft band re-lay, function mask (no soften), strokes slightly oblique
local fL = function(x, y) return smoothstep(200, 238, y) * (1 - smoothstep(262, 300, y)) end
local L = mask(fL) * rect(0, 0, 480, 400)
work(L, {hand="broad", piles=halo_piles(), angle=0, coverage=3.5, load=1.0, fill=true, clip=L, angle_jitter=0.15, length={30, 90}, tool={kind="filbert", width=22, lay=1.6},
  load_at=function(x, y) return clamp(fL(x, y) * 1.1, 0.05, 1) end})
blend(L, {angle=0, tool={kind="badger", width=60}})
-- R: knife along the line first, then the same soft band
local knm = mix{{sky_lilac, 0.5}, {belt, 0.5}, name="knm"}
local k = knife{width=14}
for _, yy in ipairs({240, 244}) do
  k:load(knm, 0.6)
  k:lay({{525, yy}, {700, yy + 0.5}, {870, yy - 0.3}, {1000, yy}}, {pressure={0.95, 0.95}})
  k:wipe()
end
local R = mask(fL) * rect(520, 0, 480, 400) - excl
work(R, {hand="broad", piles=halo_piles(), angle=0, coverage=3.5, load=1.0, fill=true, clip=R, angle_jitter=0.15, length={30, 90}, tool={kind="filbert", width=22, lay=1.6},
  load_at=function(x, y) return clamp(fL(x, y) * 1.1, 0.05, 1) end})
blend(R, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do local t = wait(24*60); if drying(300, 260) == "dry" and drying(700, 260) == "dry" and drying(700, 242) == "dry" then print("dry", t) break end end
