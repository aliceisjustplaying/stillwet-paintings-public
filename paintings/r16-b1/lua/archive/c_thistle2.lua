thStemD = pile{{"raw umber", 1.6}, {"green earth", 1.2}, {"bone black", 0.6}, medium=0.05}
thLeafD = pile{{"green earth", 1.6}, {"raw umber", 1.6}, {"bone black", 0.55}, {"Prussian blue", 0.1}, medium=0.05}
thLeafEdge = pile{{"green earth", 1.6}, {"raw umber", 1}, {"yellow ochre", 0.5}, {"lead white", 0.35}, medium=0.05}
thBractD = pile{{"raw umber", 1.5}, {"green earth", 1}, {"bone black", 0.35}, {"lead white", 0.1}, medium=0.05}
thFlower = pile{{"lead white", 1}, {"red earth", 0.35}, {"smalt", 0.8}, {"vermilion", 0.15}, {"raw umber", 0.1}, medium=0.05}
local stb = brush{kind="round", width=2, point=1}
local tb = brush{kind="round", width=0.8, point=1}
function jaggedLeaf(x, y, a, L, w, droop)
  local up, lo = {}, {}
  local n = 8
  for i = 0, n do
    local t = i / n
    local cx = x + L*t*math.cos(a)
    local cy = y + L*t*math.sin(a) + droop * L * t * t
    local nx, ny = -math.sin(a), math.cos(a)
    local lobe = (i % 2 == 1) and 1.0 or 0.45
    local ww = w * math.sin(math.pi * math.min(t * 1.15, 1)) * lobe
    up[#up+1] = {cx + nx*ww, cy + ny*ww}
    lo[#lo+1] = {cx - nx*ww*0.8, cy - ny*ww*0.8}
  end
  local pts = {}
  for i = 1, #up do pts[#pts+1] = up[i] end
  for i = #lo, 1, -1 do pts[#pts+1] = lo[i] end
  return poly(pts, false)
end
function thistle2(base, head, sideHeads, leafs, seed)
  math.randomseed(seed)
  local pts = {}
  for i = 0, 8 do local t = i/8; pts[#pts+1] = {lerp(base[1], head[1], t) + math.sin(t*3) * 1.5, lerp(base[2], head[2], t)} end
  stb:load(thStemD, 0.9)
  stb:stroke(pts, {pressure={stb:pressure_for(2.0), stb:pressure_for(1.1)}})
  local lm = nil
  for _, l in ipairs(leafs) do
    local t = l[1]; local px, py = lerp(base[1], head[1], t) + math.sin(t*3) * 1.5, lerp(base[2], head[2], t)
    local m = jaggedLeaf(px, py, l[2], l[3], l[4], l[5] or 0.15)
    lm = lm and (lm + m) or m
  end
  if lm then
    work(lm, {hand="detail", pile=thLeafD, coverage=4, fill=true, clip=true, length={2,5}})
    -- spines at lobe tips: tiny pale strokes
  end
  local heads = {head}
  for _, s in ipairs(sideHeads) do
    local t = s[1]; local px, py = lerp(base[1], head[1], t), lerp(base[2], head[2], t)
    stb:load(thStemD, 0.7)
    stb:stroke({{px, py}, {(px + s[2])/2 + randn(0, 0.6), (py + s[3])/2}, {s[2], s[3]}}, {pressure={stb:pressure_for(1.0), stb:pressure_for(0.8)}})
    heads[#heads+1] = {s[2], s[3], s[4]}
  end
  for _, h in ipairs(heads) do
    local r = h[3] or 3.2
    work(ellipse(h[1], h[2] + r*0.35, r*0.9, r), {hand="detail", pile=thBractD, coverage=4, fill=true, clip=true, length={1,2}})
    for k = 1, 11 do
      tb:load(thFlower, 0.85)
      local ang = -math.pi/2 + (k - 6) * 0.13 + randn(0, 0.08)
      local L = r * rand(0.9, 1.3)
      local sx, sy = h[1] + (k - 6) * r * 0.1, h[2] - r * 0.35
      tb:stroke({{sx, sy}, {sx + L*math.cos(ang), sy + L*math.sin(ang)}}, {pressure={tb:pressure_for(0.8), tb:pressure_for(0.45)}})
    end
  end
end
-- A: tall one, head over the ghost
thistle2({72, 708}, {82, 527}, {{0.72, 70, 538, 2.8}, {0.78, 95, 537, 2.6}},
  {{0.12, -2.6, 22, 5, 0.25}, {0.2, -0.5, 24, 5, 0.25}, {0.33, -2.7, 20, 4.5, 0.2}, {0.45, -0.35, 19, 4, 0.2}, {0.56, -2.8, 16, 3.6, 0.2}, {0.66, -0.3, 15, 3.4, 0.15}, {0.76, -2.9, 12, 3, 0.1}, {0.85, -0.25, 10, 2.5, 0.1}}, 8101)
-- B: shorter, head at the pink tuft
thistle2({46, 708}, {52, 546}, {{0.8, 42, 556, 2.5}},
  {{0.15, -2.8, 18, 4.5, 0.25}, {0.3, -0.4, 17, 4, 0.2}, {0.47, -2.6, 14, 3.5, 0.2}, {0.62, -0.5, 12, 3, 0.15}, {0.78, -2.8, 9, 2.4, 0.1}}, 8102)
-- C: small one right
thistle2({128, 708}, {134, 612}, {},
  {{0.2, -0.4, 14, 3.5, 0.2}, {0.4, -2.7, 12, 3, 0.2}, {0.6, -0.3, 10, 2.6, 0.15}}, 8103)
