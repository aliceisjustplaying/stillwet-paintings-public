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
glow = pile{{"lead white", 7}, {"Naples yellow", 0.8}, {"smalt", 0.7}, {"rose madder", 0.2}, name="glow"}
moon = pile{{"lead white", 6}, {"Naples yellow", 1.2}, {"vermilion", 0.03}, name="moon"}
halo = pile{{"lead white", 8}, {"Naples yellow", 0.9}, {"smalt", 0.35}, {"rose madder", 0.12}, name="halo"}
ridge_far = pile{{"lead white", 3.5}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.45}, {"raw umber", 0.3}, name="ridge_far"}
local function hat(c, w) return function(x, y) return math.max(0, 1 - math.abs(y - c) / w) end end
local function skyp(cx) return {{sky_lilac, hat(218, 40)}, {belt, hat(258, 45)}, {eshadow, function(x, y) return clamp((y - 258) / 47, 0, 1) end}, {glow, function(x, y) local dx, dy = (x - cx) / 85, (y - 298) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}} end
work(rect(0, 150, 1000, 300), {hand="broad", piles=skyp(300), angle=0, coverage=3.5, load=1, fill=true, clip=true, tool={kind="filbert", width=22, lay=1.6}})
blend(rect(0, 150, 1000, 300), {angle=0, tool={kind="badger", width=60}})
wait(14*24*60)
-- a ridge below the moon as on the painting (R1 at ~350)
work(rect(0, 345, 1000, 60), {hand="body", pile=ridge_far, coverage=3, fill=true, clip=rect(0,345,1000,60), angle=0})
for _, cx in ipairs({300, 700}) do
  local m = ellipse(cx, 298, 12.5, 12.5)
  work(m, {hand="detail", pile=moon, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=20}, tool={kind="round", width=3.5}})
end
wait(14*24*60)
print(drying(300, 298), drying(500, 360))

--@ chunk 3
local function hat(c, w) return function(x, y) return math.max(0, 1 - math.abs(y - c) / w) end end
function moon_halo(cx, cy, R, rin, strength)
  local function r(x, y) local dx, dy = x - cx, (y - cy) * 1.1; return math.sqrt(dx*dx + dy*dy) end
  local m = mask(function(x, y) local rr = r(x, y); return (rr > rin and y < 344) and clamp(1 - (rr - R * 0.5) / (R * 0.5), 0, 1) or 0 end)
  local wh = function(x, y) return strength * math.exp(-((r(x, y) - rin) / (R * 0.35)) ^ 2) end
  local ws = function(x, y) return 1 - wh(x, y) end
  local piles = {{halo, wh}, {sky_lilac, function(x, y) return ws(x, y) * hat(218, 40)(x, y) end}, {belt, function(x, y) return ws(x, y) * hat(258, 45)(x, y) end}, {eshadow, function(x, y) return ws(x, y) * clamp((y - 258) / 47, 0, 1) end}, {glow, function(x, y) return ws(x, y) * 0.7 * math.exp(-(((x - cx) / 85) ^ 2 + ((y - cy) / 55) ^ 2)) end}}
  work(m, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1, fill=true, clip=m, tool={kind="filbert", width=14, lay=1.6}, load_at=function(x, y) return clamp(1.2 - r(x, y) / R, 0.1, 1) end})
  blend(m, {angle=0, tool={kind="badger", width=40}})
  return m
end
moon_halo(300, 298, 90, 13.2, 0.75)
moon_halo(700, 298, 60, 13.2, 0.5)
print("ok")
