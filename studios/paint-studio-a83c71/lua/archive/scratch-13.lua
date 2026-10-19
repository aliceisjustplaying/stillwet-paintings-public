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
heath = pile{{"raw umber", 2}, {"bone black", 0.8}, {"green earth", 1}, {"yellow ochre", 0.4}, {"rose madder", 0.15}, name="heath"}
heath_dk = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.2}, {"green earth", 0.4}, name="heath_dk"}
heath_lt = pile{{"raw umber", 1.6}, {"yellow ochre", 0.4}, {"green earth", 0.6}, {"lead white", 0.35}, {"smalt", 0.2}, {"rose madder", 0.15}, name="heath_lt"}
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
local nz = noise{seed=5, octaves=3, period=70}
-- grass-and-heath zones (patchy), as fine vertical marks, scaled by depth
local zone = mask(function(x, y) return clamp(0.3 + 1.4 * nz(x, y), 0, 1) end) * rect(0, 305, 500, 409)
local function sc(x, y) return 0.35 + 1.1 * clamp((y - 300) / 400, 0, 1) end
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.7}, {fg_deep, 0.5}}, coverage=1.2, clip=zone, angle=-1.45, angle_jitter=0.35, length={4, 9}, scale_at=sc, tool={kind="round", width=1.3, point=0.7}, pressure={0.4, 0.7}})
local tops = zone * mask(function(x, y) return clamp(nz(x + 40, y - 30) * 2, 0, 1) end)
work(tops, {hand="hatch", piles={{heath_lt, 1}, {fg_top, 0.6}}, coverage=0.35, clip=tops, angle=-1.45, angle_jitter=0.35, length={3, 7}, scale_at=sc, tool={kind="round", width=1.0, point=0.8}, pressure={0.3, 0.5}})
print("ok")

--@ chunk 4
local nz = noise{seed=6, octaves=3, period=60}
local yh = 250
local function ground(x, y)
  local d = math.max(8, y - yh)
  local Z = 4000 / d
  return (x - 750) * Z / 100, Z * 3
end
local zone = mask(function(x, y) local X, Z = ground(x, y); return clamp(0.25 + 1.5 * nz(X, Z), 0, 1) end) * rect(500, 305, 500, 409)
local function sc(x, y) return 0.3 + 1.2 * clamp((y - 300) / 400, 0, 1) end
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.7}, {fg_deep, 0.5}}, coverage=1.2, clip=zone, angle=-1.45, angle_jitter=0.35, length={4, 9}, scale_at=sc, tool={kind="round", width=1.3, point=0.7}, pressure={0.4, 0.7}})
local tops = zone * mask(function(x, y) local X, Z = ground(x, y); return clamp(nz(X + 40, Z - 30) * 2, 0, 1) end)
work(tops, {hand="hatch", piles={{heath_lt, 1}, {fg_top, 0.6}}, coverage=0.35, clip=tops, angle=-1.45, angle_jitter=0.35, length={3, 7}, scale_at=sc, tool={kind="round", width=1.0, point=0.8}, pressure={0.3, 0.5}})
print("ok")

--@ chunk 5
wait(12*24*60)
print(drying(200, 500), drying(700, 500))
fg_glaze = pile{{"raw umber", 1.5}, {"bone black", 0.8}, {"Prussian blue", 0.15}, medium=0.75, name="fg_glaze"}
fg_glaze2 = pile{{"raw umber", 1.5}, {"bone black", 0.8}, {"Prussian blue", 0.15}, medium=0.5, name="fg_glaze2"}
local A = rect(0, 450, 500, 264)
local B = rect(500, 450, 500, 264)
work(A, {hand="glaze", pile=fg_glaze, coverage=2, clip=A, angle=0.05, load_at=function(x, y) return clamp((y - 450) / 200, 0.05, 1) end})
work(B, {hand="body", pile=fg_glaze2, coverage=2.5, fill=true, clip=B, angle=0.05, tool={kind="filbert", width=12}, load_at=function(x, y) return clamp((y - 450) / 200, 0.05, 1) end})
print("ok")
