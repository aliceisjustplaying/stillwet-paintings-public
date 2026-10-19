-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
s_mid = pile{{"smalt",1.5},{"cobalt blue",0.3},{"lead white",4},{"rose madder",0.2}, name="s_mid"}
s_lilac = pile{{"lead white",6},{"rose madder",0.4},{"smalt",0.8},{"Naples yellow",0.2}, name="s_lilac"}
s_belt = pile{{"lead white",8},{"rose madder",0.7},{"Naples yellow",0.8},{"vermilion",0.1}, name="s_belt"}
s_blue = pile{{"smalt",2.5},{"cobalt blue",0.7},{"lead white",2.5},{"rose madder",0.12}, name="s_blue"}
local function hat(y, a, c, b)
  if y <= a or y >= b then return 0 end
  if y < c then return (y - a) / (c - a) else return (b - y) / (b - c) end
end
local stops = {{95, s_blue}, {170, s_mid}, {218, s_lilac}, {258, s_belt}}
local piles = {}
for i, s in ipairs(stops) do
  local a = (stops[i-1] or {s[1]-80})[1]
  local b = (stops[i+1] or {s[1]+80})[1]
  local c = s[1]
  piles[#piles+1] = {s[2], function(x, y) local yy = clamp(y, 95, 258) return hat(yy, a, c, b) + 1e-4 end}
end
local m = rect(0, 120, 400, 180)
work(m, {hand="broad", piles=piles, tool={kind="filbert", width=22, lay=1.6}, coverage=3.5, load=1, fill=true, clip=true})
blend(m, {tool={kind="badger", width=60}})
print(drying(200, 200))

--@ chunk 3
for i = 1, 30 do
  local t = wait(24*60)
  if drying(200, 200) == "dry" and drying(100, 150) == "dry" and drying(300, 250) == "dry" then print("dry", t) break end
end

--@ chunk 4
mlow = pile{{"lead white",4},{"smalt",1.5},{"raw umber",0.3},{"rose madder",0.2}, name="mlow"}
local b = brush{kind="filbert", width=6}
for _, x0 in ipairs({150, 250, 330}) do
  b:reload(mlow, 0.3)
  b:stroke({{x0, 196}, {x0+1, 210}, {x0, 224}}, {pressure={0.35, 0.2}})
  b:stroke({{x0+4, 199}, {x0+5, 212}, {x0+4, 222}}, {pressure={0.3, 0.15}})
end
local m = rect(140, 190, 210, 40)
blend(m, {tool={kind="badger", width=12}, angle=1.57})
print(drying(152, 210))

--@ chunk 5
for i = 1, 30 do
  local t = wait(24*60)
  if drying(152, 210) == "dry" and drying(254, 210) == "dry" and drying(334, 210) == "dry" then print("dry", t) break end
end

--@ chunk 6
cov_up = mix{{s_mid, 0.4}, {s_lilac, 0.6}, name="cov_up"}
cov_lo = mix{{s_mid, 0.1}, {s_lilac, 0.85}, {s_belt, 0.05}, name="cov_lo"}
-- A: crossing short strokes, filbert 4, lay 1.2, at x~152 and x~254
local b = brush{kind="filbert", width=4, lay=1.2}
for _, x0 in ipairs({152, 254}) do
  for y = 194, 226, 3.5 do
    local p = y < 210 and cov_up or cov_lo
    b:reload(p, 0.6)
    b:stroke({{x0 - 7, y + 1.2}, {x0 + 9, y - 0.8}}, {pressure={0.6, 0.45}})
    b:stroke({{x0 + 9, y + 0.6}, {x0 - 7, y + 2.0}}, {pressure={0.55, 0.4}})
  end
end
print(drying(152, 210))

--@ chunk 7
for i = 1, 30 do
  local t = wait(24*60)
  if drying(152, 210) == "dry" and drying(254, 210) == "dry" then print("dry", t) break end
end

--@ chunk 8
local b = brush{kind="filbert", width=6}
for _, x0 in ipairs({40, 90}) do
  b:reload(mlow, 0.3)
  b:stroke({{x0, 196}, {x0+1, 210}, {x0, 224}}, {pressure={0.35, 0.2}})
  b:stroke({{x0+4, 199}, {x0+5, 212}, {x0+4, 222}}, {pressure={0.3, 0.15}})
end
blend(rect(30, 190, 75, 40), {tool={kind="badger", width=12}, angle=1.57})
for i = 1, 30 do
  local t = wait(24*60)
  if drying(42, 210) == "dry" and drying(92, 210) == "dry" then print("dry", t) break end
end

--@ chunk 9
cov_up2 = mix{{s_blue, 0.12}, {s_mid, 0.48}, {s_lilac, 0.40}, name="cov_up2"}
cov_lo2 = mix{{s_mid, 0.3}, {s_lilac, 0.65}, {s_belt, 0.05}, name="cov_lo2"}
local function feather(x0, up, lo, load, seed)
  local b = brush{kind="filbert", width=4, lay=1.0}
  local k = 0
  for y = 193, 228, 2.6 do
    k = k + 1
    local p = y < 210 and up or lo
    b:reload(p, load)
    local L1, L2 = rand(8, 13), rand(9, 14)
    local s = (k % 2 == 0) and 1 or -1
    local d = s * rand(1.5, 2.5)
    b:gesture({{x0 - L1, y + d, 0.08}, {x0 - L1*0.3, y + d*0.3, 0.45}, {x0 + L2*0.4, y - d*0.4, 0.45}, {x0 + L2, y - d, 0.06}})
  end
end
feather(42, cov_up2, cov_lo2, 0.6)
feather(92, cov_up, cov_lo, 0.35)
feather(336, cov_up2, cov_lo2, 0.35)
for i = 1, 30 do
  local t = wait(24*60)
  if drying(42, 210) == "dry" and drying(92, 210) == "dry" and drying(336, 210) == "dry" then print("dry", t) break end
end
