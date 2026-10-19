function leafSet(base, head, leafs)
  local lm = nil
  for _, l in ipairs(leafs) do
    local t = l[1]; local px, py = lerp(base[1], head[1], t) + math.sin(t*3) * 1.5, lerp(base[2], head[2], t)
    local m = jaggedLeaf(px, py, l[2], l[3], l[4], l[5] or 0.15)
    lm = lm and (lm + m) or m
  end
  return lm
end
local LA = leafSet({72, 708}, {82, 527}, {{0.12, -2.6, 22, 5, 0.25}, {0.2, -0.5, 24, 5, 0.25}, {0.33, -2.7, 20, 4.5, 0.2}, {0.45, -0.35, 19, 4, 0.2}, {0.56, -2.8, 16, 3.6, 0.2}, {0.66, -0.3, 15, 3.4, 0.15}, {0.76, -2.9, 12, 3, 0.1}, {0.85, -0.25, 10, 2.5, 0.1}})
local LB = leafSet({46, 708}, {52, 546}, {{0.15, -2.8, 18, 4.5, 0.25}, {0.3, -0.4, 17, 4, 0.2}, {0.47, -2.6, 14, 3.5, 0.2}, {0.62, -0.5, 12, 3, 0.15}, {0.78, -2.8, 9, 2.4, 0.1}})
local LC = leafSet({128, 708}, {134, 612}, {{0.2, -0.4, 14, 3.5, 0.2}, {0.4, -2.7, 12, 3, 0.2}, {0.6, -0.3, 10, 2.6, 0.15}})
local L = LA + LB + LC
local rim = (L - L:shrink(0.9)) * mask(function(x, y) return 1 end)
work(rim, {hand="detail", pile=thLeafEdge, coverage=1.6, clip=true, length={2,5}, pressure={0.3,0.6}})
-- mute the flowers slightly: a few darker purple strokes at their bases
thFlowerD = pile{{"lead white", 0.6}, {"red earth", 0.35}, {"smalt", 1}, {"raw umber", 0.35}, medium=0.05}
local tb = brush{kind="round", width=0.8, point=1}
for _, h in ipairs({{82, 527, 3.2}, {70, 538, 2.8}, {95, 537, 2.6}, {52, 546, 3.2}, {42, 556, 2.5}, {134, 612, 3.2}}) do
  for k = 1, 5 do
    tb:load(thFlowerD, 0.8)
    local ang = -math.pi/2 + (k - 3) * 0.25
    local sx, sy = h[1] + (k - 3) * h[3] * 0.15, h[2] - h[3] * 0.3
    tb:stroke({{sx, sy}, {sx + h[3]*0.6*math.cos(ang), sy + h[3]*0.6*math.sin(ang)}}, {pressure={tb:pressure_for(0.8), tb:pressure_for(0.5)}})
  end
end
-- tall grasses with drooping seed heads against the meadow
panP = pile{{"raw umber", 1.5}, {"yellow ochre", 1}, {"green earth", 0.6}, {"bone black", 0.3}, medium=0.05}
panL = pile{{"yellow ochre", 1.5}, {"lead white", 0.8}, {"raw umber", 0.6}, medium=0.05}
local gs = brush{kind="round", width=0.9, point=1}
local grs = {{62, 575, 66, 512, -1}, {90, 578, 97, 516, 1}, {100, 580, 106, 524, 1}, {76, 572, 71, 518, -1}, {110, 582, 113, 530, 1}, {58, 580, 57, 526, -1}, {24, 585, 28, 530, 1}}
for _, g in ipairs(grs) do
  local x0, y0, x1, y1, d = g[1], g[2], g[3], g[4], g[5]
  gs:load(thStemD, 0.8)
  gs:stroke({{x0, y0}, {lerp(x0, x1, 0.5) + d*1.5, lerp(y0, y1, 0.5)}, {x1, y1}, {x1 + d*3, y1 + 2}}, {pressure={gs:pressure_for(0.9), gs:pressure_for(0.6), gs:pressure_for(0.5), gs:pressure_for(0.3)}})
  for k = 1, 9 do
    local t = k / 9
    local px, py = x1 + d*3*t, y1 + 2*t
    local sp = (k % 2 == 0) and 1 or -1
    gs:load((k % 3 == 0) and panL or panP, 0.7)
    gs:stroke({{px, py}, {px + sp*1.6 + d*0.8, py + 3.2}}, {pressure={gs:pressure_for(0.7), gs:pressure_for(0.4)}})
  end
end
