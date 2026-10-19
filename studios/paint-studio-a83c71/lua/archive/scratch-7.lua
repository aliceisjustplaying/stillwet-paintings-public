-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
under_fg = pile{{"raw umber", 3}, {"red earth", 0.6}, {"bone black", 0.4}, turps=0.6, name="under_fg"}
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
fg_warm = pile{{"raw umber", 3}, {"bone black", 0.5}, {"red earth", 0.5}, {"yellow ochre", 0.5}, name="fg_warm"}
local m = rect(0, 300, 1000, 414)
work(m, {hand="body", pile=under_fg, coverage=2, angle=0.1, clip=m})
rag{width=40}:wipe(m:shrink(6), {pressure=0.45, angle=0.1, refold=0.6})
work(m, {hand="body", piles={{fg_dark, 1}, {fg_warm, 0.6}}, coverage=3, fill=true, clip=m, angle=0.05, tool={kind="filbert", width=10}})
wait(10*24*60)
print(drying(500, 500))

--@ chunk 3
rock_lit = pile{{"lead white", 1.5}, {"raw umber", 1.5}, {"smalt", 1}, {"bone black", 0.2}, {"rose madder", 0.1}, name="rock_lit"}
rock_lit_b = pile{{"lead white", 1.5}, {"raw umber", 1.5}, {"smalt", 1}, {"bone black", 0.2}, {"rose madder", 0.1}, blot=0.25, name="rock_lit_b"}
rock_warm = pile{{"lead white", 1}, {"raw umber", 1.5}, {"yellow ochre", 0.6}, {"red earth", 0.3}, {"bone black", 0.2}, name="rock_warm"}
-- A: knife slabs
local k = knife{width=30}
k:load(rock_lit_b, 0.8)
k:lay({{60, 340}, {180, 345}}, {pressure={0.6, 0.5}, angle=1.57})
k:load(rock_lit_b, 0.8)
k:lay({{70, 380}, {220, 392}}, {pressure={0.7, 0.6}, angle=1.57})
k:load(rock_lit_b, 0.6)
k:lay({{90, 420}, {200, 425}}, {pressure={0.8, 0.8}, angle=1.47})
-- B: brushed planes with a stiff filbert, lightly loaded
local b = brush{kind="flat", width=8, stiffness=0.8}
b:load(rock_lit, 0.5)
for i = 0, 5 do b:stroke({{300, 340 + i * 7}, {420, 343 + i * 7}}, {pressure={0.5, 0.25}}) end
b:load(rock_lit, 0.3)
for i = 0, 4 do b:stroke({{310, 395 + i * 7}, {400, 398 + i * 7}}, {pressure={0.4, 0.15}}) end
-- C: thinner scumble
local rs = pile{{"lead white", 1.5}, {"raw umber", 1.5}, {"smalt", 1}, {"bone black", 0.2}, {"rose madder", 0.1}, thinner=0.4, name="rs"}
local mC = poly({{500, 335}, {640, 330}, {660, 360}, {620, 380}, {510, 375}})
work(mC, {hand="body", pile=rs, coverage=2, angle=0.05, clip=mC, tool={kind="filbert", width=8}, load=0.6})
print("ok")

--@ chunk 4
rock_top = pile{{"raw umber", 1.5}, {"smalt", 1.2}, {"lead white", 0.9}, {"bone black", 0.2}, {"rose madder", 0.12}, name="rock_top"}
rock_shadow = pile{{"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.25}, name="rock_shadow"}
local slabA = poly({{60, 470}, {200, 462}, {230, 480}, {215, 500}, {70, 505}}, true)
local slabB = poly({{300, 470}, {440, 462}, {470, 480}, {455, 500}, {310, 505}}, true)
local slabC = poly({{540, 470}, {680, 462}, {710, 480}, {695, 500}, {550, 505}}, true)
local slabD = poly({{780, 470}, {920, 462}, {950, 480}, {935, 500}, {790, 505}}, true)
-- A: stipple, graded: denser at the top edge
stipple(slabA, {pile=rock_top, width=2.5, coverage=function(x, y) return clamp(2.2 - (y - 462) / 25, 0.3, 2.2) end, feather=0.6, clip=slabA})
-- B: body hand light load, graded via load_at, then a light blend
work(slabB, {hand="body", pile=rock_top, coverage=2, fill=true, clip=slabB, angle=0.03, tool={kind="filbert", width=6}, load_at=function(x, y) return clamp(1 - (y - 462) / 45, 0.15, 0.9) end})
blend(slabB, {angle=0, tool={kind="badger", width=16}})
-- C: semi-glaze with medium
local rg = pile{{"raw umber", 1.5}, {"smalt", 1.2}, {"lead white", 0.9}, {"bone black", 0.2}, {"rose madder", 0.12}, medium=0.4, name="rg"}
work(slabC, {hand="body", pile=rg, coverage=2.5, fill=true, clip=slabC, angle=0.03, tool={kind="filbert", width=6}})
-- D: mixture of two piles graded top light → lower rock_shadow, body, then blend
work(slabD, {hand="body", piles={{rock_top, function(x,y) return clamp(1 - (y-462)/30, 0, 1) end}, {fg_dark, function(x,y) return clamp((y-470)/30, 0, 1) end}}, coverage=3, fill=true, clip=slabD, angle=0.03, tool={kind="filbert", width=6}})
blend(slabD, {angle=0, tool={kind="badger", width=16}})
print("ok")

--@ chunk 5
function lip_line(x0, x1, y0, seed, seg, jump, slope)
  math.randomseed(seed)
  local pts = {}
  local x, y = x0, y0
  local n = noise{seed=seed, octaves=3, period=40}
  pts[#pts+1] = {x, y}
  while x < x1 do
    local L = rand(seg[1], seg[2])
    local xe = math.min(x1, x + L)
    local steps = math.max(2, math.floor((xe - x) / 5))
    for s = 1, steps do
      local xx = x + (xe - x) * s / steps
      pts[#pts+1] = {xx, y + (xx - x0) * (slope or 0) + 1.5 * n(xx, y0)}
    end
    x = xe
    if x < x1 then
      local dy = rand(-jump, jump)
      y = y + dy
      x = x + rand(0.5, 2)
      pts[#pts+1] = {x, y + (x - x0) * (slope or 0) + 1.5 * n(x, y0)}
    end
  end
  return pts
end
function between(upper, lower)
  local q = {}
  for _, p in ipairs(upper) do q[#q+1] = p end
  for i = #lower, 1, -1 do q[#q+1] = lower[i] end
  return poly(q)
end
function shifted(line, dy)
  local q = {}
  for _, p in ipairs(line) do q[#q+1] = {p[1], p[2] + dy} end
  return q
end
rock_top2 = pile{{"raw umber", 2}, {"smalt", 1.2}, {"lead white", 0.7}, {"bone black", 0.35}, {"rose madder", 0.1}, name="rock_top2"}
rock_front = pile{{"raw umber", 2.2}, {"bone black", 0.8}, {"red earth", 0.3}, {"yellow ochre", 0.2}, name="rock_front"}
local Ls = {
  lip_line(-5, 1005, 545, 11, {40, 140}, 3),
  lip_line(-5, 1005, 575, 12, {50, 160}, 4),
  lip_line(-5, 1005, 615, 13, {60, 200}, 5),
  lip_line(-5, 1005, 665, 14, {80, 250}, 6),
}
local risers = {4, 7, 11, 15}
local prev = shifted(Ls[1], -25)
for i, L in ipairs(Ls) do
  local top = between(prev, L)
  local cf = crest_fn and crest_fn(L) or nil
  -- graded: light near the front lip (y close to L), darker toward the back
  local Ly = {}
  local function lipy(x) local best, by = 1e9, L[1][2]; for _, p in ipairs(L) do local d = math.abs(p[1]-x); if d < best then best, by = d, p[2] end end; return by end
  work(top, {hand="body", piles={{rock_top2, function(x, y) return clamp(1 - (lipy(x) - y) / 18, 0.05, 1) end}, {fg_dark, function(x, y) return clamp((lipy(x) - y) / 22, 0, 1) end}}, coverage=3, fill=true, clip=top, angle=0.02, tool={kind="filbert", width=5}})
  blend(top, {angle=0, tool={kind="badger", width=14}})
  local riser = between(L, shifted(L, risers[i]))
  work(riser, {hand="detail", pile=rock_front, coverage=3, fill=true, clip=riser, angle=1.5, tool={kind="round", width=2}})
  prev = shifted(L, risers[i])
end
print("ok")

--@ chunk 6
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
rock_front2 = pile{{"raw umber", 2}, {"bone black", 1.2}, {"Prussian blue", 0.15}, {"red earth", 0.2}, name="rock_front2"}
local m = rect(0, 520, 1000, 194)
work(m, {hand="body", pile=fg_dark, coverage=2.5, fill=true, clip=m, angle=0.05, tool={kind="filbert", width=10}})
wait(10*24*60)
local o = outline{{120, 690, "c"}, {110, 640}, {130, 600, "c"}, {180, 585}, {240, 580, "c"}, {300, 592}, {330, 610, "c"}, {345, 650}, {350, 690, "c"}, char="broken", seed=7, closed=true, amount=0.9}
local B = o:mask()
local topline = lineF({{100, 615}, {150, 605}, {230, 600}, {300, 612}, {360, 625}}, 5, 2, 9)
local topm = B * above(topline)
local frontm = B * below(topline)
work(frontm, {hand="body", piles={{rock_front2, 1}, {fg_warm, function(x,y) return 0.3 end}}, coverage=3, fill=true, clip=frontm, angle=1.4, angle_jitter=0.3, tool={kind="filbert", width=6}})
work(topm, {hand="body", piles={{rock_top2, function(x,y) return 1 end}, {fg_dark, function(x,y) return clamp((y - 585) / 25, 0, 0.8) end}}, coverage=3, fill=true, clip=topm, angle=0.1, angle_jitter=0.2, tool={kind="filbert", width=5}})
blend(topm:shrink(1), {angle=0.1, tool={kind="badger", width=12}})
local r = brush{kind="round", width=1.4, point=0.9}
r:load(rock_front2, 0.7)
r:gesture({{215, 601, 0.2}, {218, 625, 0.6}, {212, 660, 0.5}, {216, 690, 0.1}})
r:gesture({{120, 688, 0.6}, {240, 692, 0.9}, {350, 690, 0.6}})
print("ok")
