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
fg_top = pile{{"raw umber", 2}, {"smalt", 1.3}, {"lead white", 0.6}, {"bone black", 0.45}, {"rose madder", 0.1}, name="fg_top"}
fg_deep = pile{{"raw umber", 2.5}, {"bone black", 1.4}, {"Prussian blue", 0.3}, {"red earth", 0.15}, name="fg_deep"}
crack_dark = pile{{"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.2}, name="crack_dark"}
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
work(rect(0,0,1000,300), {hand="broad", pile=mist_bright, coverage=3, fill=true, clip=true, angle=0})
local m = rect(0, 300, 1000, 414)
work(m, {hand="body", pile=under_fg, coverage=2, angle=0.1, clip=m})
work(m, {hand="body", piles={{fg_dark, function(x,y) return clamp((y - 360) / 120, 0, 1) + 0.25 end}, {fg_warm, function(x,y) return 0.5 end}}, coverage=3, fill=true, clip=m, angle=0.05, angle_jitter=0.12, tool={kind="filbert", width=10}})
wait(12*24*60)
print(drying(500, 500))

--@ chunk 3
local m = rect(0, 300, 1000, 414)
local nb = noise{seed=177, octaves=4, period=110, stretch={0, 4}, warp={80, 25}}
local function depth(x, y) return clamp((y - 300) / 300, 0, 1) end
local function wtop(x, y) return clamp(0.5 + 1.2 * nb(x, y), 0, 1) * (1 - depth(x, y)) ^ 1.3 end
local function wdark(x, y) return (1 - wtop(x, y)) * (1 - depth(x, y)) + 0.1 end
local function wdeep(x, y) return depth(x, y) ^ 0.8 * 1.3 end
local function wwarm(x, y) return 0.15 + 0.25 * clamp(nb(x + 300, y), 0, 1) end
work(m, {hand="body", piles={{fg_top, wtop}, {fg_dark, wdark}, {fg_deep, wdeep}, {fg_warm, wwarm}}, coverage=3, fill=true, clip=m, angle=0.04, angle_jitter=0.1, tool={kind="filbert", width=7}, length={30, 80}, scale_at=function(x, y) return 0.6 + 0.9 * depth(x, y) end})
blend(m, {angle=0, tool={kind="badger", width=24}})
-- fissures into the wet surface; left half: detail round; right half: wait until setting first
FIS = {
  {pts={{20, 330}, {120, 334}, {230, 331}, {330, 336}, {460, 333}}, w={0.4, 1.4, 1.8, 1.2, 0.3}},
  {pts={{0, 372}, {90, 377}, {200, 371}, {300, 379}, {420, 375}, {500, 378}}, w={0.6, 2, 2.6, 1.8, 2.2, 0.4}},
  {pts={{0, 450}, {120, 456}, {260, 447}, {380, 458}, {500, 452}}, w={1, 3, 3.5, 2.5, 0.6}},
  {pts={{160, 380}, {150, 410}, {132, 452}}, w={1.5, 2, 1}},
  {pts={{330, 452}, {345, 500}, {372, 580}, {390, 650}}, w={1.5, 3, 4, 2}},
  {pts={{0, 560}, {150, 568}, {300, 560}, {500, 574}}, w={2, 4.5, 5, 1}},
}
for i, f in ipairs(FIS) do
  local fm = ribbon(f.pts, f.w):roughen(0.9, 7, i)
  work(fm, {hand="detail", pile=crack_dark, coverage=3, fill=true, clip=fm, angle=0, tool={kind="round", width=1.5}})
end
print(drying(300, 400))

--@ chunk 4
wait(10*24*60)
print(drying(700, 400))
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
-- soft lobes: each a rounded shape; its upper part (far, catching the sky) a touch lighter, lower part darker; edges soft
function lobe(cx, cy, rx, ry, seed, light)
  local m = ellipse(cx, cy, rx, ry):roughen(math.max(2, ry * 0.15), math.max(10, rx * 0.4), seed)
  local top = cy - ry
  local wl = function(x, y) return clamp(1 - (y - top) / (ry * 1.4), 0, 1) * (light or 0.6) end
  work(m, {hand="body", piles={{fg_top, wl}, {fg_dark, function(x, y) return 1 - wl(x, y) end}, {fg_deep, function(x, y) return clamp((y - cy) / ry, 0, 1) * 0.8 end}}, coverage=3, fill=true, clip=m, angle=0.03, angle_jitter=0.15, tool={kind="filbert", width=6}, length={20, 50}})
  return m
end
local all = lobe(640, 340, 110, 26, 1, 0.7)
all = all + lobe(800, 350, 120, 22, 2, 0.6)
all = all + lobe(700, 400, 150, 34, 3, 0.55)
all = all + lobe(900, 410, 110, 30, 4, 0.5)
all = all + lobe(620, 480, 120, 44, 5, 0.45)
all = all + lobe(820, 500, 160, 50, 6, 0.4)
all = all + lobe(700, 610, 190, 70, 7, 0.3)
blend(all:soften(4), {angle=0, tool={kind="badger", width=20}})
print("ok")

--@ chunk 5
coat = pile{{"bone black", 1.2}, {"Prussian blue", 0.35}, {"raw umber", 1.2}, {"green earth", 0.4}, name="coat"}
hair = pile{{"raw umber", 2}, {"bone black", 0.8}, {"red earth", 0.3}, name="hair"}
cap_p = pile{{"bone black", 1.5}, {"raw umber", 1}, {"rose madder", 0.15}, name="cap_p"}
function figure_masks(fx, fy, s)
  local function P(dx, dy) return {fx + dx * s, fy + dy * s} end
  local M = {}
  M.legL = ribbon({P(-4.2, -19), P(-4.4, -8), P(-4.6, -1)}, {4.8*s, 4.2*s, 3.8*s})
  M.legR = ribbon({P(4.0, -19), P(4.3, -8), P(4.8, -1)}, {4.8*s, 4.2*s, 3.8*s})
  M.feet = ribbon({P(-7.0, -0.6), P(-2.8, -0.6)}, 2.2*s) + ribbon({P(2.4, -0.6), P(6.8, -0.6)}, 2.2*s)
  M.coat = poly({P(-6.3, -66), P(-8.8, -64.5), P(-10.0, -61), P(-10.4, -50), P(-11.2, -36), P(-12.4, -22), P(-11.8, -19.5),
                 P(-3, -18.2), P(0, -19.5), P(3, -18.2), P(12.0, -19.5), P(12.6, -22), P(11.2, -36), P(10.4, -50), P(10.0, -61), P(8.8, -64.5), P(6.3, -66)})
  M.armL = ribbon({P(-9.4, -61), P(-11.0, -50), P(-11.8, -40), P(-11.4, -33)}, {4.6*s, 4.4*s, 4.0*s, 3.4*s})
  M.armR = ribbon({P(9.4, -61), P(11.2, -51), P(12.4, -42), P(13.2, -35)}, {4.6*s, 4.4*s, 4.0*s, 3.4*s})
  M.collar = poly({P(-6.6, -67.5), P(-3.8, -70), P(3.8, -70), P(6.6, -67.5), P(6.3, -64), P(-6.3, -64)}, true)
  M.head = ellipse(fx + 0.3 * s, fy - 74.0 * s, 3.8 * s, 4.8 * s)
  M.cap = poly({P(-4.6, -76.2), P(-4.0, -79.0), P(-1, -80.2), P(3.5, -80.0), P(5.6, -78.4), P(5.0, -76.0), P(0.5, -76.8)}, true)
  M.stick = ribbon({P(13.6, -37), P(15.8, -18), P(18.4, 0)}, {1.3*s, 1.15*s, 1.0*s})
  M.body = M.legL + M.legR + M.feet + M.coat + M.armL + M.armR + M.collar
  M.all = M.body + M.head + M.cap + M.stick
  return M
end
local function paint_fig(F)
  work(F.body, {hand="detail", pile=coat, coverage=3, fill=true, clip=F.body, angle=1.5, tool={kind="round", width=1.3}})
  work(F.head - F.cap, {hand="detail", pile=hair, coverage=3, fill=true, clip=F.head - F.cap, angle=1.2, tool={kind="round", width=1.0}})
  work(F.cap, {hand="detail", pile=cap_p, coverage=3, fill=true, clip=F.cap, angle=0, tool={kind="round", width=1.0}})
  work(F.stick, {hand="detail", pile=hair, coverage=3, fill=true, clip=F.stick, angle=1.4, tool={kind="round", width=0.9}})
end
paint_fig(figure_masks(560, 220, 0.85))
paint_fig(figure_masks(640, 220, 0.85))
print("ok")
