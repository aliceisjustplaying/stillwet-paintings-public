-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
mist_bright = pile{{"lead white", 8}, {"smalt", 0.8}, {"rose madder", 0.2}, {"Naples yellow", 0.3}, name="mist_bright"}
ridge_mid = pile{{"lead white", 2.6}, {"smalt", 2.5}, {"cobalt blue", 0.4}, {"rose madder", 0.45}, {"raw umber", 0.55}, name="ridge_mid"}
fg_dark = pile{{"raw umber", 3}, {"bone black", 1}, {"Prussian blue", 0.3}, {"yellow ochre", 0.3}, name="fg_dark"}
work(rect(0,0,1000,714), {hand="broad", piles={{ridge_mid, function(x,y) return clamp(1 - y/300, 0, 1) end}, {mist_bright, function(x,y) return clamp(y/300, 0, 1) end}}, coverage=3, fill=true, clip=true, angle=0})
blend(rect(0,0,1000,714), {angle=0, tool={kind="badger", width=60}})
work(rect(0, 500, 1000, 214), {hand="body", pile=fg_dark, coverage=3, fill=true, clip=rect(0,500,1000,214), angle=0})
wait(16*24*60)
print(drying(500, 300), drying(500, 600))

--@ chunk 3
pine_dark = pile{{"raw umber", 2}, {"bone black", 1}, {"Prussian blue", 0.5}, {"yellow ochre", 0.4}, name="pine_dark"}
pine_bark = pile{{"raw umber", 2}, {"bone black", 0.7}, {"red earth", 0.4}, {"lead white", 0.3}, name="pine_bark"}
function pine(base, seed, sc)
  math.randomseed(seed)
  local bx, by = base[1], base[2]
  local function P(dx, dy) return {bx + dx * sc, by + dy * sc} end
  -- trunk: leans right, bends back
  local trunk = {P(0, 0), P(3, -30), P(10, -62), P(12, -95), P(8, -122), P(11, -140)}
  local tm = ribbon(trunk, {7*sc, 5.6*sc, 4.6*sc, 3.6*sc, 2.6*sc, 1.4*sc})
  local limbs = {
    {P(10, -62), P(-8, -70), P(-26, -72), P(-38, -78)},
    {P(12, -88), P(28, -96), P(44, -98)},
    {P(11, -105), P(-4, -114), P(-18, -118)},
    {P(9, -122), P(22, -130), P(30, -133)},
    {P(4, -40), P(-10, -46)},
  }
  local lw = {{2.6, 2, 1.4, 0.8}, {2.4, 1.6, 0.7}, {2, 1.4, 0.6}, {1.6, 1.0, 0.5}, {1.8, 0.6}}
  local wood = tm
  for i, l in ipairs(limbs) do
    local ws = {}
    for k, w in ipairs(lw[i]) do ws[k] = w * sc end
    wood = wood + ribbon(l, ws)
  end
  -- foliage pads: flat, ragged clouds at limb ends and along their tops
  local pads = {
    {P(-34, -82), 20, 6.5}, {P(-20, -77), 13, 5}, {P(40, -102), 19, 6}, {P(26, -100), 12, 5},
    {P(-14, -122), 15, 5.5}, {P(-2, -118), 10, 4.5}, {P(26, -137), 13, 5}, {P(12, -146), 10, 5},
    {P(-8, -50), 9, 3.5},
  }
  local fm = nil
  for _, p in ipairs(pads) do
    local e = ellipse(p[1][1], p[1][2], p[2] * sc, p[3] * sc)
    for k = 1, 4 do
      e = e + ellipse(p[1][1] + rand(-0.7, 0.7) * p[2] * sc, p[1][2] + rand(-0.6, 0.3) * p[3] * sc, p[2] * sc * rand(0.3, 0.55), p[3] * sc * rand(0.6, 1.0))
    end
    fm = fm and (fm + e) or e
  end
  fm = fm:roughen(1.6 * sc, 5 * sc, seed)
  return wood, fm
end
local wood, fol = pine({300, 560}, 5, 1.2)
work(wood, {hand="detail", pile=pine_bark, coverage=3, fill=true, clip=wood, angle=1.4, tool={kind="round", width=1.6}})
work(fol, {hand="detail", pile=pine_dark, coverage=3, fill=true, clip=fol, angle=0.1, tool={kind="round", width=2}})
print("ok")

--@ chunk 4
wait(1)
local m = rect(150, 330, 330, 260)
work(m, {hand="body", pile=fg_dark, coverage=3, fill=true, clip=m, angle=0})
local m2 = rect(150, 330, 330, 170)
work(m2, {hand="body", piles={{mist_bright, function(x,y) return clamp(y/300,0,1) end}, {ridge_mid, function(x,y) return clamp(1-y/300,0,1) end}}, coverage=3, fill=true, clip=m2, angle=0})
wait(16*24*60)
crack_dark = pile{{"raw umber", 2}, {"bone black", 1.5}, {"Prussian blue", 0.2}, name="crack_dark"}
heath = pile{{"raw umber", 2}, {"bone black", 0.8}, {"green earth", 1}, {"yellow ochre", 0.4}, {"rose madder", 0.15}, name="heath"}
heath_lt = pile{{"raw umber", 1.5}, {"yellow ochre", 0.8}, {"green earth", 0.8}, {"lead white", 0.45}, {"rose madder", 0.2}, name="heath_lt"}
heath_sil = pile{{"raw umber", 2}, {"bone black", 1}, {"green earth", 0.6}, {"Prussian blue", 0.2}, name="heath_sil"}
-- fissures broken into segments
function fissure_broken(pts, wmax, seed, clipm)
  math.randomseed(seed)
  local total = #pts
  local i = 1
  while i < total do
    local j = math.min(total, i + math.random(2, 5))
    local seg, ws = {}, {}
    for k = i, j do seg[#seg+1] = pts[k]; ws[#ws+1] = wmax * (0.4 + 0.6 * math.sin(math.pi * (k - i) / math.max(1, j - i))) + 0.3 end
    local fm = ribbon(seg, ws):roughen(0.7, 5, seed + i)
    if clipm then fm = fm * clipm end
    work(fm, {hand="detail", pile=crack_dark, coverage=3, fill=true, clip=fm, angle=0, tool={kind="round", width=1.2}})
    i = j + math.random(1, 2)
  end
end
local function pl(x0, x1, y, amp, seed)
  local n = noise{seed=seed, octaves=3, period=30}
  local out = {}
  for x = x0, x1, 6 do out[#out+1] = {x, y + amp * n(x, y)} end
  return out
end
fissure_broken(pl(520, 980, 540, 2, 1), 1.0, 1)
fissure_broken(pl(520, 980, 575, 3, 2), 1.8, 2)
fissure_broken(pl(520, 980, 630, 4, 3), 2.8, 3)
-- joint lines converging up toward a vanishing point
local vp = {700, 420}
for _, x0 in ipairs({560, 820}) do
  local pts = {}
  for t = 0, 1, 0.08 do
    local y = 714 - t * (714 - 545)
    local x = x0 + (vp[1] - x0) * (714 - y) / (714 - vp[2])
    pts[#pts+1] = {x + rand(-1.5, 1.5), y}
  end
  fissure_broken(pts, 2.2, x0)
end
-- heather clumps: stippled dark mounds with a few lighter touches on top
function heather(cx, cy, r, seed)
  local m = ellipse(cx, cy, r, r * 0.55):roughen(r * 0.25, r * 0.5, seed)
  stipple(m, {pile=heath, width=math.max(1.6, r * 0.3), coverage=4, clip=m, cluster=0.3})
  local top = m * mask(function(x, y) return clamp(1 - (y - (cy - r * 0.55)) / (r * 0.6), 0, 1) end)
  stipple(top, {pile=heath_lt, width=math.max(1.2, r * 0.2), coverage=1.2, clip=top, cluster=0.5, feather=0.5})
end
heather(600, 572, 9, 1); heather(640, 574, 6, 2); heather(860, 628, 14, 3); heather(905, 632, 9, 4); heather(720, 540, 5, 5)
-- skyline bushes
function bush_sil(cx, cy, r, seed)
  local m = ellipse(cx, cy, r, r * 0.6):roughen(r * 0.3, r * 0.45, seed) * mask(function(x, y) return y < cy + r * 0.2 and 1 or 0 end)
  stipple(m, {pile=heath_sil, width=math.max(1.4, r * 0.25), coverage=5, clip=m:grow(0.5), cluster=0.4})
end
bush_sil(180, 502, 12, 11); bush_sil(205, 503, 7, 12); bush_sil(300, 502, 5, 13); bush_sil(420, 503, 9, 14)
print("ok")
