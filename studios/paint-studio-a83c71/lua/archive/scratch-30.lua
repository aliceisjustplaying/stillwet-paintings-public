-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
sky_lilac = pile{{"lead white", 6}, {"rose madder", 0.4}, {"smalt", 0.8}, {"Naples yellow", 0.2}, name="sky_lilac"}
belt = pile{{"lead white", 8}, {"rose madder", 0.7}, {"Naples yellow", 0.8}, {"vermilion", 0.1}, name="belt"}
eshadow = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.3}, {"raw umber", 0.2}, name="eshadow"}
mist_low = pile{{"lead white", 4}, {"smalt", 1.5}, {"raw umber", 0.3}, {"rose madder", 0.2}, name="mist_low"}
spruce_dark = pile{{"Prussian blue", 1}, {"raw umber", 2.5}, {"bone black", 1}, {"yellow ochre", 0.4}, name="spruce_dark"}
sp_near = mix{{spruce_dark, 0.8}, {mist_low, 0.2}, name="sp_near"}
local m = rect(820, 150, 180, 200)
work(m, {hand="broad", piles={{sky_lilac, function(x, y) return clamp((260 - y) / 60, 0, 1) end}, {belt, function(x, y) return clamp(1 - math.abs(y - 258) / 50, 0, 1) end}, {eshadow, function(x, y) return clamp((y - 270) / 50, 0, 1) end}}, angle=0, coverage=3.5, load=1, fill=true, clip=m, tool={kind="filbert", width=22, lay=1.6}})
blend(m, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(900, 250) == "dry" and drying(900, 200) == "dry" then print("dry", t) break end
end

--@ chunk 3
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
local s = {x=948, tip=228, base=760, w=98}
BIGSP = spruce2(s, 224) * rect(800, 150, 200, 200)
print(BIGSP:at(948, 233), BIGSP:at(948, 238), BIGSP:at(948, 244))
work(BIGSP, {hand="body", pile=sp_near, angle=1.3, coverage=2.5, fill=true, clip=BIGSP, tool={kind="filbert", width=7}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(948, 280) == "dry" and drying(948, 245) == "dry" then print("dry", t) break end
end

--@ chunk 4
local b = brush{kind="round", width=1.2, point=0.9}
print(b:mark_width(0.25), b:mark_width(0.4), b:mark_width(0.55), b:mark_width(0.7))
local b2 = brush{kind="round", width=1.6, point=0.9}
print(b2:mark_width(0.25), b2:mark_width(0.4), b2:mark_width(0.55), b2:mark_width(0.7))

--@ chunk 5
local b = brush{kind="round", width=1.6, point=0.9}
b:load(sp_near, 0.7)
b:gesture({{948, 249, 0.7}, {948, 241, 0.55}, {948.1, 235, 0.42}, {948.2, 230, 0.3}, {948.3, 225.5, 0.0}})
local t = brush{kind="round", width=1.2, point=0.95}
t:load(sp_near, 0.6)
t:gesture({{948, 239, 0.5}, {946.2, 239.8, 0.3}, {944.6, 240.8, 0.0}})
t:gesture({{948.2, 238.2, 0.5}, {950, 239, 0.3}, {951.8, 240.3, 0.0}})
print("ok")

--@ chunk 6
sky_deep = pile{{"smalt", 3}, {"cobalt blue", 1}, {"lead white", 0.8}, {"bone black", 0.25}, {"rose madder", 0.15}, name="sky_deep"}
sky_blue = pile{{"smalt", 2.5}, {"cobalt blue", 0.7}, {"lead white", 2.5}, {"rose madder", 0.12}, name="sky_blue"}
sky_night = pile{{"smalt", 3}, {"cobalt blue", 1.2}, {"lead white", 0.5}, {"bone black", 0.4}, {"rose madder", 0.2}, name="sky_night"}
local m = rect(820, 0, 180, 130)
work(m, {hand="broad", piles={{sky_deep, function(x, y) return clamp(1 - y / 95, 0, 1) end}, {sky_blue, function(x, y) return clamp(y / 95, 0, 1) end}}, angle=0, coverage=3.5, load=1, fill=true, clip=m, tool={kind="filbert", width=22, lay=1.6}})
blend(m, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(900, 50) == "dry" and drying(900, 110) == "dry" then print("dry", t) break end
end
local function hat(c, w) return function(x, y) return math.max(0, 1 - math.abs(y - c) / w) end end
local m2 = rect(820, 0, 180, 125) * mask(function(x, y) return clamp((120 - y) / 40, 0, 1) end)
work(m2, {hand="broad", piles={{sky_night, function(x,y) return clamp(1 - y/75, 0, 1) end}, {sky_deep, hat(70, 60)}, {sky_blue, hat(125, 55)}}, angle=0, coverage=3.5, load=1, fill=true, clip=m2, tool={kind="filbert", width=22, lay=1.6}, load_at=function(x, y) return clamp((118 - y) / 50, 0.1, 1) end})
blend(rect(820, 0, 180, 122), {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(900, 50) == "dry" and drying(900, 100) == "dry" then print("dry2", t) break end
end

--@ chunk 7
local fl = pile{{"lead white", 6}, {"yellow ochre", 0.2}, {"smalt", 0.3}, name="fleck"}
local b = brush{kind="round", width=1.2, point=0.9}
b:load(fl, 0.6)
b:gesture({{883, 56, 0.2}, {885, 55.2, 0.5}, {887.5, 54.8, 0.0}})
b:gesture({{933, 56, 0.2}, {935, 55.2, 0.5}, {937.5, 54.8, 0.0}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(885, 55) == "dry" then print("dry", t) break end
end

--@ chunk 8
skycov = mix{{sky_night, 0.27}, {sky_deep, 0.73}, name="skycov"}
local b = brush{kind="filbert", width=3, lay=1.2}
b:load(skycov, 0.6)
b:stroke({{932, 55.6}, {938.5, 54.9}}, {pressure={0.6, 0.5}})
b:stroke({{938.5, 55.2}, {932.5, 56}}, {pressure={0.55, 0.45}})
-- left: a light single-layer cover with a softer brush and lower pressure
local c = brush{kind="filbert", width=4, lay=1.0}
c:load(skycov, 0.45)
c:stroke({{880, 55.8}, {889.5, 54.8}}, {pressure={0.4, 0.3}})
for i = 1, 20 do
  local t = wait(24*60)
  if drying(935, 55) == "dry" and drying(885, 55) == "dry" then print("dry", t) break end
end
