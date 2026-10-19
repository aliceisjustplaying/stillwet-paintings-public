-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
fg_warm = pile{{"raw umber", 3}, {"bone black", 0.5}, {"red earth", 0.5}, {"yellow ochre", 0.5}, name="fg_warm"}
fg_top = pile{{"raw umber", 2}, {"smalt", 1.3}, {"lead white", 0.6}, {"bone black", 0.45}, {"rose madder", 0.1}, name="fg_top"}
fg_deep = pile{{"raw umber", 2.5}, {"bone black", 1.4}, {"Prussian blue", 0.3}, {"red earth", 0.15}, name="fg_deep"}
heath = pile{{"raw umber", 2}, {"bone black", 0.8}, {"green earth", 1}, {"yellow ochre", 0.4}, {"rose madder", 0.15}, name="heath"}
heath_dk = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.2}, {"green earth", 0.4}, name="heath_dk"}
heath_lt = pile{{"raw umber", 1.6}, {"yellow ochre", 0.4}, {"green earth", 0.6}, {"lead white", 0.35}, {"smalt", 0.2}, {"rose madder", 0.15}, name="heath_lt"}
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
work(rect(0,0,1000,300), {hand="broad", pile=mist_bright, coverage=3, fill=true, clip=true, angle=0})
local m = rect(0, 300, 1000, 414)
local nb = noise{seed=277, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
local function depth(x, y) return clamp((y - 300) / 200, 0, 1) end
local function wtop(x, y) return clamp(0.45 + 1.0 * nb(x, y), 0, 1) * (1 - depth(x, y)) ^ 1.5 * 0.8 end
work(m, {hand="body", piles={{fg_top, wtop}, {fg_dark, function(x, y) return (1 - wtop(x, y)) * (1 - depth(x, y)) + 0.15 end}, {fg_deep, function(x, y) return depth(x, y) ^ 0.8 * 1.2 end}, {fg_warm, function(x, y) return 0.3 end}}, coverage=3, fill=true, clip=m, angle=0.04, angle_jitter=0.1, tool={kind="filbert", width=7}, length={30, 80}})
blend(m, {angle=0, tool={kind="badger", width=24}})
wait(10*24*60)
local nz = noise{seed=16, octaves=3, period=60}
local function pg(x, y) local d = math.max(4, y - 260); local Z = 4000 / d; return (x - 470) * Z / 100, Z * 3 end
local zone = mask(function(x, y) local X, Z = pg(x, y); return clamp(0.2 + 1.5 * nz(X, Z), 0, 1) end) * m
local function sc(x, y) return 0.3 + 1.3 * clamp((y - 300) / 300, 0, 1) end
work(zone, {hand="hatch", piles={{heath_dk, 1}, {heath, 0.7}, {fg_deep, 0.5}}, coverage=1.2, clip=zone, angle=-1.45, angle_jitter=0.35, length={4, 9}, scale_at=sc, tool={kind="round", width=1.3, point=0.7}, pressure={0.4, 0.7}})
wait(10*24*60)
print(drying(500, 500))

--@ chunk 3
stone_lit = pile{{"raw umber", 1.6}, {"smalt", 1.0}, {"lead white", 0.8}, {"bone black", 0.3}, {"rose madder", 0.12}, name="stone_lit"}
stone_body = pile{{"raw umber", 2}, {"bone black", 0.8}, {"red earth", 0.2}, {"lead white", 0.3}, {"smalt", 0.3}, name="stone_body"}
stone_sh = pile{{"raw umber", 2}, {"bone black", 1.6}, {"Prussian blue", 0.2}, name="stone_sh"}
-- stone as three touches: body (filbert dab), lit top (flat stroke), shadow beneath (flat stroke)
function stone(x, y, w, seed)
  math.randomseed(seed)
  local h = w * rand(0.28, 0.45)
  local fb = brush{kind="filbert", width=math.max(1.5, h * 0.9)}
  fb:load(stone_body, 0.7)
  fb:stroke({{x - w * 0.42, y + rand(-0.5, 0.5)}, {x + w * 0.42, y + rand(-0.5, 0.5)}}, {pressure={0.7, 0.6}})
  local ft = brush{kind="flat", width=math.max(1.0, h * 0.45)}
  ft:load(stone_lit, 0.6)
  local off = rand(-0.15, 0.1) * w
  ft:stroke({{x - w * 0.35 + off, y - h * 0.35}, {x + w * 0.25 + off, y - h * 0.42}}, {pressure={0.6, 0.3}})
  local fs = brush{kind="flat", width=math.max(1.0, h * 0.4)}
  fs:load(stone_sh, 0.7)
  fs:stroke({{x - w * 0.5, y + h * 0.42}, {x + w * 0.55, y + h * 0.38}}, {pressure={0.6, 0.6}})
end
stone(100, 340, 10, 1); stone(130, 345, 6, 2); stone(200, 380, 16, 3); stone(230, 386, 8, 4)
stone(320, 430, 26, 5); stone(360, 440, 12, 6); stone(150, 520, 40, 7); stone(260, 600, 60, 8)
print("ok")

--@ chunk 4
local m = rect(0, 450, 1000, 264)
work(m, {hand="body", piles={{fg_dark, 1}, {fg_deep, 0.8}}, coverage=3, fill=true, clip=m, angle=0.03, tool={kind="filbert", width=10}})
wait(10*24*60)
rock_face = pile{{"raw umber", 2}, {"bone black", 0.9}, {"red earth", 0.25}, {"yellow ochre", 0.2}, {"lead white", 0.15}, name="rock_face"}
rock_cool = pile{{"raw umber", 1.8}, {"bone black", 0.7}, {"smalt", 0.7}, {"lead white", 0.35}, {"rose madder", 0.08}, name="rock_cool"}
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
-- an outcrop: silhouette, then a soft top lightening driven by distance below the silhouette top (computed per column)
function outcrop(pts, seed, topdepth)
  local o = outline{pts=pts, char="broken", seed=seed, closed=true, amount=0.7}
  local B = o:mask()
  local tops = {}
  for x = 0, 1000, 2 do
    local ty = nil
    for y = 300, 714, 1 do if B:at(x, y) > 0.5 then ty = y; break end end
    tops[#tops+1] = ty or 9999
  end
  local function topy(x) local i = clamp(math.floor(x / 2) + 1, 1, #tops); return tops[i] end
  local nv = noise{seed=seed, octaves=3, period=25, stretch={1.4, 3}}
  local function wc(x, y) return clamp(1 - (y - topy(x)) / topdepth, 0, 1) * 0.85 end
  local function wf(x, y) return (1 - wc(x, y)) * clamp(0.5 + 0.8 * nv(x, y), 0.1, 1) end
  local function wd(x, y) return (1 - wc(x, y)) * clamp(0.5 - 0.8 * nv(x, y), 0, 1) end
  work(B, {hand="body", piles={{rock_cool, wc}, {rock_face, wf}, {fg_deep, wd}}, coverage=3, fill=true, clip=B, angle=1.35, angle_jitter=0.35, tool={kind="filbert", width=4}, length={10, 30}})
  blend(B:shrink(1), {angle=1.2, tool={kind="badger", width=10}})
  return B
end
outcrop({{20, 714, "c"}, {28, 640}, {50, 600, "c"}, {95, 590}, {130, 594, "c"}, {150, 610}, {175, 604, "c"}, {225, 612}, {250, 640, "c"}, {262, 714, "c"}}, 1, 14)
outcrop({{400, 700, "c"}, {410, 676}, {432, 666, "c"}, {470, 662}, {500, 672, "c"}, {512, 700, "c"}}, 2, 8)
print("ok")
