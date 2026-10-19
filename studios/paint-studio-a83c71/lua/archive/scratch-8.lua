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
under_fg = pile{{"raw umber", 3}, {"red earth", 0.6}, {"bone black", 0.4}, turps=0.6, name="under_fg"}
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
fg_warm = pile{{"raw umber", 3}, {"bone black", 0.5}, {"red earth", 0.5}, {"yellow ochre", 0.5}, name="fg_warm"}
fg_moss = pile{{"raw umber", 2.5}, {"bone black", 0.4}, {"yellow ochre", 0.8}, {"green earth", 1.2}, {"Prussian blue", 0.1}, name="fg_moss"}
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
work(rect(0,0,1000,300), {hand="broad", pile=mist_bright, coverage=3, fill=true, clip=true, angle=0})
local m = rect(0, 300, 1000, 414)
work(m, {hand="body", pile=under_fg, coverage=2, angle=0.1, clip=m})
rag{width=40}:wipe(m:shrink(6), {pressure=0.45, angle=0.1, refold=0.6})
local nzm = noise{seed=51, octaves=3, period=90}
work(m, {hand="body", piles={{fg_dark, function(x,y) return clamp((y - 400) / 120, 0, 1) + 0.25 end}, {fg_warm, function(x,y) return clamp(1 - math.abs(y - 400) / 90, 0, 1) * 0.8 end}, {fg_moss, function(x, y) return clamp(nzm(x, y) * 1.5, 0, 1) * 0.5 end}}, coverage=3, fill=true, clip=m, angle=0.05, angle_jitter=0.12, tool={kind="filbert", width=10}})
wait(12*24*60)
print(drying(500, 500), drying(500, 100))

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
fg_top = pile{{"raw umber", 2}, {"smalt", 1.3}, {"lead white", 0.6}, {"bone black", 0.45}, {"rose madder", 0.1}, name="fg_top"}
rock_front2 = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.15}, {"red earth", 0.2}, name="rock_front2"}
-- plates: irregular soft-edged blobs, each graded lighter toward its far (upper) edge where the rounded rim catches the sky
local plates = {
  {{60,330},{230,322},{300,340},{280,365},{120,372},{50,355}},
  {{330,335},{520,330},{560,350},{500,372},{350,368}},
  {{40,395},{260,385},{330,410},{300,440},{90,445},{30,425}},
  {{360,395},{600,392},{640,420},{560,452},{380,445}},
  {{20,480},{300,470},{380,505},{330,560},{60,565}},
}
for i, pl in ipairs(plates) do
  local m = poly(pl, true):roughen(3, 25, i)
  local ys = {}
  local miny, maxy = 1e9, -1e9
  for _, p in ipairs(pl) do miny = math.min(miny, p[2]); maxy = math.max(maxy, p[2]) end
  local wtop = function(x, y) return clamp(1 - (y - miny) / ((maxy - miny) * 0.9), 0, 1) * 0.85 + 0.1 end
  work(m, {hand="body", piles={{fg_top, wtop}, {fg_dark, function(x, y) return 1 - wtop(x, y) end}}, coverage=3, fill=true, clip=m, angle=0.03, angle_jitter=0.1, tool={kind="filbert", width=6}})
  blend(m:shrink(1), {angle=0, tool={kind="badger", width=16}})
end
-- crack lines: dark, with a rigger
local rg = brush{kind="rigger", width=1.6, point=0.9}
rg:load(rock_front2, 0.8)
rg:gesture({{40, 376, 0.3}, {150, 380, 0.8}, {290, 372, 0.6}, {340, 375, 0.2}})
rg:gesture({{320, 345, 0.2}, {330, 380, 0.7}, {345, 400, 0.4}})
rg:load(rock_front2, 0.8)
rg:gesture({{30, 452, 0.3}, {200, 456, 0.9}, {320, 448, 0.6}, {600, 460, 0.3}})
print("ok")

--@ chunk 4
local m = rect(520, 300, 480, 414)
local nb = noise{seed=77, octaves=4, period=120, stretch={0, 4}, warp={80, 25}}
local wtop = function(x, y) return clamp(0.5 + 1.2 * nb(x, y), 0, 1) * clamp(1 - (y - 330) / 500, 0.3, 1) end
work(m, {hand="body", piles={{fg_top, wtop}, {fg_dark, function(x, y) return 1 - wtop(x, y) + 0.1 end}, {fg_warm, function(x, y) return 0.15 end}}, coverage=3, fill=true, clip=m, angle=function(x, y) return 0.04 + 0.04 * math.sin(x / 80) end, angle_jitter=0.1, tool={kind="filbert", width=7}, length={30, 80}})
blend(m, {angle=0, tool={kind="badger", width=24}})
print("ok")

--@ chunk 5
wait(8*24*60)
print(drying(700, 400))
crack_dark = pile{{"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.2}, name="crack_dark"}
wall_lit = pile{{"raw umber", 1.5}, {"lead white", 0.8}, {"red earth", 0.3}, {"yellow ochre", 0.3}, {"rose madder", 0.1}, {"bone black", 0.2}, name="wall_lit"}
local function crack(pts, w)
  local rg = brush{kind="rigger", width=w or 1.6, point=0.9}
  rg:load(crack_dark, 0.8)
  rg:gesture(pts)
  local up = {}
  for _, p in ipairs(pts) do up[#up+1] = {p[1], p[2] - (w or 1.6) * 0.9, (p[3] or 0.5) * 0.6} end
  local lb = brush{kind="rigger", width=(w or 1.6) * 0.8, point=0.9}
  lb:load(wall_lit, 0.6)
  lb:gesture(up)
end
crack({{540, 360, 0.2}, {600, 362, 0.6}, {680, 358, 0.8}, {760, 365, 0.5}, {800, 364, 0.1}}, 1.4)
crack({{560, 430, 0.3}, {650, 436, 0.9}, {760, 428, 0.7}, {900, 440, 0.6}, {990, 437, 0.2}}, 2)
crack({{700, 436, 0.2}, {690, 470, 0.7}, {672, 520, 0.5}, {660, 560, 0.1}}, 1.6)
crack({{530, 560, 0.3}, {620, 568, 0.9}, {800, 575, 1.0}, {990, 570, 0.4}}, 2.6)
-- heather tufts along cracks
heath = pile{{"raw umber", 2}, {"bone black", 0.8}, {"green earth", 1}, {"yellow ochre", 0.4}, {"rose madder", 0.15}, name="heath"}
heath_lt = pile{{"raw umber", 1.5}, {"yellow ochre", 1}, {"green earth", 0.8}, {"lead white", 0.3}, {"rose madder", 0.15}, name="heath_lt"}
local function tuft(x, y, s, seed)
  math.randomseed(seed)
  local b = brush{kind="round", width=1.0 * s, point=0.9}
  b:load(heath, 0.7)
  for i = 1, math.floor(9 * s) do
    local a = -math.pi / 2 + rand(-0.9, 0.9)
    local L = rand(4, 10) * s
    local x0 = x + rand(-5, 5) * s
    b:gesture({{x0, y, 0.6}, {x0 + math.cos(a) * L * 0.5, y + math.sin(a) * L * 0.5, 0.4}, {x0 + math.cos(a) * L, y + math.sin(a) * L, 0.0}})
  end
  b:load(heath_lt, 0.5)
  for i = 1, math.floor(3 * s) do
    local a = -math.pi / 2 + rand(-0.6, 0.6)
    local L = rand(3, 7) * s
    local x0 = x + rand(-4, 4) * s
    b:gesture({{x0, y - 1, 0.4}, {x0 + math.cos(a) * L, y - 1 + math.sin(a) * L, 0.0}})
  end
end
tuft(640, 434, 1, 1); tuft(905, 438, 1.2, 2); tuft(820, 573, 1.6, 3); tuft(600, 565, 1.4, 4)
print("ok")

--@ chunk 6
local function fissure(pts, widths, seed)
  local m = ribbon(pts, widths):roughen(0.8, 6, seed)
  work(m, {hand="detail", pile=crack_dark, coverage=3, fill=true, clip=m, angle=0, tool={kind="round", width=1.5}})
  return m
end
fissure({{560, 610}, {600, 612}, {640, 609}, {700, 614}, {740, 613}}, {0.5, 2.5, 3.5, 2, 0.5}, 1)
fissure({{760, 618}, {800, 620}, {860, 617}, {930, 622}}, {0.5, 3, 2, 0.3}, 2)
fissure({{690, 615}, {684, 640}, {676, 668}, {672, 690}}, {2, 2.5, 1.5, 0.4}, 3)
-- silhouette grasses against the mist on the edge at y=300
local function grass_edge(x0, x1, y, seed, dens)
  math.randomseed(seed)
  local b = brush{kind="round", width=1.1, point=1}
  b:load(heath, 0.8)
  local n = 0
  for x = x0, x1, 1 / dens do
    if math.random() < 0.7 then
      local a = -math.pi / 2 + randn(0, 0.35)
      local L = math.abs(randn(7, 3))
      local bend = randn(0, 0.15)
      local p1 = {x + math.cos(a) * L * 0.5, y + math.sin(a) * L * 0.5, 0.35}
      local a2 = a + bend
      local p2 = {p1[1] + math.cos(a2) * L * 0.5, p1[2] + math.sin(a2) * L * 0.5, 0.0}
      b:gesture({{x, y + 2, 0.55}, p1, p2})
      n = n + 1
      if n % 12 == 0 then b:load(heath, 0.8) end
    end
  end
end
grass_edge(560, 700, 301, 5, 0.35)
grass_edge(760, 820, 301, 6, 0.6)
print("ok")

--@ chunk 7
coat = pile{{"bone black", 1.2}, {"Prussian blue", 0.35}, {"raw umber", 1.2}, {"green earth", 0.4}, name="coat"}
coat_lit = pile{{"bone black", 0.8}, {"raw umber", 1.2}, {"red earth", 0.2}, {"lead white", 0.5}, {"rose madder", 0.1}, name="coat_lit"}
hair = pile{{"raw umber", 2}, {"bone black", 0.8}, {"red earth", 0.3}, name="hair"}
function figure_masks(fx, fy, s)
  s = s or 1
  local function P(dx, dy) return {fx + dx * s, fy + dy * s} end
  local M = {}
  M.legL = ribbon({P(-4.6, -19), P(-4.8, -8), P(-5.0, -1)}, {5.0*s, 4.4*s, 4.0*s})
  M.legR = ribbon({P(4.4, -19), P(4.6, -8), P(5.0, -1)}, {5.0*s, 4.4*s, 4.0*s})
  M.feet = ribbon({P(-7.5, -0.6), P(-3.2, -0.6)}, 2.2*s) + ribbon({P(2.6, -0.6), P(7.2, -0.6)}, 2.2*s)
  M.coat = poly({P(-6.5, -66), P(-9.0, -64.5), P(-10.2, -61), P(-10.6, -50), P(-11.4, -36), P(-12.6, -22), P(-12.0, -19.5),
                 P(0, -18.5), P(12.2, -19.5), P(12.8, -22), P(11.4, -36), P(10.6, -50), P(10.2, -61), P(9.0, -64.5), P(6.5, -66)})
  M.armL = ribbon({P(-9.6, -61), P(-11.2, -50), P(-12.0, -40), P(-11.6, -33)}, {4.6*s, 4.4*s, 4.0*s, 3.4*s})
  M.armR = ribbon({P(9.6, -61), P(11.4, -51), P(12.6, -42), P(13.4, -35)}, {4.6*s, 4.4*s, 4.0*s, 3.4*s})
  M.collar = poly({P(-6.8, -67.5), P(-4, -70), P(4, -70), P(6.8, -67.5), P(6.5, -64), P(-6.5, -64)}, true)
  M.head = ellipse(fx + 0.3 * s, fy - 74.5 * s, 3.9 * s, 5.0 * s)
  M.stick = ribbon({P(13.8, -37), P(16.0, -18), P(18.6, 0)}, {1.3*s, 1.15*s, 1.0*s})
  M.body = M.legL + M.legR + M.feet + M.coat + M.armL + M.armR + M.collar
  M.all = M.body + M.head + M.stick
  return M
end
local F = figure_masks(300, 280, 1)
work(F.body, {hand="detail", pile=coat, coverage=3, fill=true, clip=F.body, angle=1.5, tool={kind="round", width=1.5}})
work(F.head, {hand="detail", pile=hair, coverage=3, fill=true, clip=F.head, angle=1.2, tool={kind="round", width=1.2}})
work(F.stick, {hand="detail", pile=hair, coverage=3, fill=true, clip=F.stick, angle=1.4, tool={kind="round", width=1.0}})
-- faint warm light on the back from the western afterglow: upper back and shoulders
local litm = F.coat * mask(function(x, y) return clamp(1 - (y - 216) / 30, 0, 1) * clamp(1 - math.abs(x - 300) / 9, 0, 1) end)
work(litm, {hand="detail", pile=coat_lit, coverage=1.5, clip=litm, angle=1.5, load=0.4, tool={kind="round", width=1.5}})
F2 = figure_masks(400, 280, 1)
work(F2.body, {hand="detail", pile=coat, coverage=3, fill=true, clip=F2.body, angle=1.5, tool={kind="round", width=1.5}})
work(F2.head, {hand="detail", pile=hair, coverage=3, fill=true, clip=F2.head, angle=1.2, tool={kind="round", width=1.2}})
print("ok")

--@ chunk 8
rock_top2 = pile{{"raw umber", 2}, {"smalt", 1.2}, {"lead white", 0.7}, {"bone black", 0.35}, {"rose madder", 0.1}, name="rock_top2"}
fg_deep = pile{{"raw umber", 2.5}, {"bone black", 1.4}, {"Prussian blue", 0.3}, {"red earth", 0.15}, name="fg_deep"}
rock_mid = mix{{rock_top2, 0.45}, {fg_warm, 0.55}, name="rock_mid"}
function facet_rock(cx, by, w, h, seed)
  math.randomseed(seed)
  -- silhouette: a low irregular mound
  local L, R = cx - w/2, cx + w/2
  local apx = cx + rand(-0.2, 0.2) * w
  local pts = {{L, by, "c"}, {L + w*0.05, by - h*0.55}, {L + w*0.2, by - h*0.9, "c"}, {apx, by - h}, {R - w*0.2, by - h*0.85, "c"}, {R - w*0.04, by - h*0.45}, {R, by, "c"}}
  local o = outline{pts=pts, char="broken", seed=seed, closed=true, amount=0.9}
  local B = o:mask()
  -- facets: top region (above a curve at ~45% height), left front, right side split at a ridge from apex down
  local topY = by - h * 0.5
  local ridgeX = apx + w * 0.12
  local top = B * above(lineF({{L-5, topY + h*0.08}, {cx, topY - h*0.05}, {R+5, topY + h*0.12}}, 5, h*0.06, seed+1))
  local side = (B - top) * mask(function(x, y) return x > ridgeX + (y - topY) * 0.25 and 1 or 0 end)
  local front = B - top - side
  work(front, {hand="body", piles={{rock_mid, 1}, {fg_dark, 0.6}}, coverage=3, fill=true, clip=front, angle=1.3, angle_jitter=0.3, tool={kind="filbert", width=4}})
  work(side, {hand="body", piles={{fg_deep, 1}, {fg_dark, 0.4}}, coverage=3, fill=true, clip=side, angle=1.5, angle_jitter=0.3, tool={kind="filbert", width=4}})
  work(top, {hand="body", piles={{rock_top2, 1}, {fg_dark, 0.5}}, coverage=3, fill=true, clip=top, angle=0.1, angle_jitter=0.3, tool={kind="filbert", width=4}})
  blend(B:shrink(1), {angle=0.3, tool={kind="badger", width=10}})
  -- contact shadow at the base
  local cs = ribbon({{L - 4, by + 1}, {cx, by + 2}, {R + 6, by + 1}}, {2, 4, 2})
  work(cs, {hand="detail", pile=fg_deep, coverage=3, fill=true, clip=cs, angle=0, tool={kind="round", width=1.5}})
  return B
end
local m = rect(0, 500, 1000, 214)
work(m, {hand="body", pile=fg_dark, coverage=2.5, fill=true, clip=m, angle=0.05, tool={kind="filbert", width=10}})
wait(10*24*60)
facet_rock(160, 700, 220, 85, 31)
facet_rock(420, 640, 90, 40, 32)
facet_rock(600, 600, 40, 18, 33)
facet_rock(700, 620, 60, 22, 34)
print("ok")

--@ chunk 9
rim_p = mix{{rock_top2, 0.55}, {fg_dark, 0.45}, name="rim_p"}
function dark_rock(pts, seed, rimw)
  local o = outline{pts=pts, char="broken", seed=seed, closed=true, amount=0.8}
  local B = o:mask()
  work(B, {hand="body", piles={{fg_deep, 1}, {fg_dark, 0.35}}, coverage=3, fill=true, clip=B, angle=1.4, angle_jitter=0.4, tool={kind="filbert", width=4}})
  -- top rim: band inside the top edge only
  local rim = B - B:offset(0, rimw) 
  return B, rim
end
print(type(rect(0,0,1,1).offset))

--@ chunk 10
function dark_rock(pts, top_pts, seed, rimw)
  local o = outline{pts=pts, char="broken", seed=seed, closed=true, amount=0.8}
  local B = o:mask()
  work(B, {hand="body", piles={{fg_deep, 1}, {fg_dark, 0.35}}, coverage=3, fill=true, clip=B, angle=1.4, angle_jitter=0.4, tool={kind="filbert", width=4}})
  local rim = ribbon(top_pts, rimw) * B:shrink(0.8)
  work(rim, {hand="detail", pile=rim_p, coverage=2.5, fill=true, clip=rim, angle=0, tool={kind="round", width=2}})
  blend(rim:grow(2) * B:shrink(0.8), {angle=0, tool={kind="badger", width=6}})
  return B
end
dark_rock({{40, 714, "c"}, {48, 660}, {75, 625, "c"}, {130, 608}, {190, 602, "c"}, {240, 612}, {275, 640, "c"}, {290, 714, "c"}},
  {{60, 636}, {80, 624}, {130, 609}, {190, 603}, {238, 613}, {270, 638}}, 41, 7)
dark_rock({{560, 714, "c"}, {566, 680}, {590, 662, "c"}, {650, 655}, {690, 668, "c"}, {700, 714, "c"}},
  {{572, 676}, {592, 663}, {650, 656}, {688, 668}}, 42, 5)
print("ok")
