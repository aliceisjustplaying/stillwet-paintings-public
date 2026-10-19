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
local m = rect(0, 100, 1000, 300)
work(m, {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=m, angle_jitter=0.04, tool={kind="filbert", width=22, lay=1.6}})
blend(m, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do local t = wait(24*60); if drying(500, 200) == "dry" and drying(500, 300) == "dry" then print("dry", t) break end end
-- the faulty band (as on the painting): clip and blend on the same soft mask, in x 0-480
local function bandpiles()
  local l = {}
  for i = 4, 8 do l[#l+1] = {SKYSTOPS[i][2], sky_hat(i)} end
  return l
end
local top0, top1 = 226, 258
local A = mask(function(x, y) return smoothstep(top0, top1, y) end) * rect(0, 0, 480, 380)
work(A, {hand="broad", piles=bandpiles(), angle=0, coverage=3.5, load=1.0, fill=true, clip=A, angle_jitter=0.04, length={30, 90}, tool={kind="filbert", width=22, lay=1.6}, load_at=function(x, y) return clamp((y - top0) / 40, 0.1, 1) end})
blend(A, {angle=0, tool={kind="badger", width=60}})
-- hypothesis: the same, but blended over a mask reaching ~20 units past the clip line, x 520-1000
local B = mask(function(x, y) return smoothstep(top0, top1, y) end) * rect(520, 0, 480, 380)
local Bw = mask(function(x, y) return smoothstep(top0 - 30, top1 - 30, y) end) * rect(520, 0, 480, 380)
work(B, {hand="broad", piles=bandpiles(), angle=0, coverage=3.5, load=1.0, fill=true, clip=B, angle_jitter=0.04, length={30, 90}, tool={kind="filbert", width=22, lay=1.6}, load_at=function(x, y) return clamp((y - top0) / 40, 0.1, 1) end})
blend(Bw, {angle=0, tool={kind="badger", width=60}})
for i = 1, 20 do local t = wait(24*60); if drying(300, 300) == "dry" and drying(700, 300) == "dry" then print("dry2", t) break end end
