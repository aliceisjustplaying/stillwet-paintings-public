-- dry grass and a few weed stalks through the snow: large clumps near, smaller ones on the slope
local gb = brush{kind="rigger", width=1.0, point=1}
local gb2 = brush{kind="rigger", width=0.6, point=1}
CLUMPS = {
  {60, 700, 60, 1.6}, {128, 688, 40, 1.3}, {205, 704, 34, 1.4}, {30, 652, 22, 1.1}, {268, 672, 18, 1.0},
  {170, 640, 14, 0.9}, {92, 612, 12, 0.8}, {360, 640, 10, 0.75}, {470, 690, 16, 1.0},
  {810, 690, 22, 1.1}, {905, 705, 36, 1.4}, {968, 668, 18, 1.0}, {760, 640, 9, 0.7}, {880, 618, 8, 0.6},
  {232, 520, 7, 0.45}, {292, 530, 6, 0.4}, {382, 545, 6, 0.4}, {205, 505, 5, 0.4}, {430, 560, 5, 0.45},
}
-- a hollow of shadowed snow and bare earth at each clump's foot, glazed
local hol = nil
for _, c in ipairs(CLUMPS) do
  local m = ellipse(c[1] + 1.5 * c[4], c[2] + 0.8 * c[4], 5 * c[4] + c[3] * 0.12, 1.8 * c[4])
  hol = hol and (hol + m) or m
end
glaze(hol:roughen(1, 4, 7, 0.8):blur(1.2), {color="#77788f", coats=0.25})
for ci, c in ipairs(CLUMPS) do
  local cx, cy, n, s = c[1], c[2], c[3], c[4]
  for k = 1, n do
    local b = (s > 0.9 and k % 3 ~= 0) and gb or gb2
    if k % 5 == 1 then b:reload(mix("#4a3f33", "#9a8663", rand() ^ 1.4), 0.75) end
    local fx = cx + randn(0, 3.2 * s); local fy = cy + rand(-1, 1.2) * s
    local h = (rand(6, 16) + (rand() < 0.12 and 14 or 0)) * s
    local lean = randn(0.12, 0.38) + (fx - cx) / (14 * s)
    local mid = {fx + lean * h * 0.3, fy - h * 0.5}
    local tip = {fx + lean * h, fy - h}
    if rand() < 0.18 then tip = {fx + lean * h + 0.45 * h * (lean > 0 and 1 or -1), fy - h * 0.7} end
    b:stroke({{fx, fy}, mid, tip}, {pressure={clamp(0.35 + 0.3 * s, 0.3, 0.9), 0}, ramps={0.03, 0.7}, shake=0.3})
  end
  -- the few blades catching the glow on their right side
  if s > 0.9 then
    gb2:reload("#c8b48c", 0.6)
    for k = 1, math.floor(n / 6) do
      local fx = cx + randn(0.8, 2.5 * s); local h = rand(6, 14) * s
      gb2:stroke({{fx, cy - 1}, {fx + 0.2 * h, cy - h * 0.6}, {fx + 0.35 * h, cy - h}}, {pressure={0.35, 0}, ramps={0.05, 0.7}})
    end
  end
end
-- two dead weed stalks with seed heads in the near left
local wb = brush{kind="rigger", width=0.8, point=1}
wb:load("#3e352c", 0.8)
for _, w in ipairs({{88, 696, 58, 0.12}, {100, 694, 44, -0.08}, {222, 702, 38, 0.2}}) do
  local x, y, h, l = w[1], w[2], w[3], w[4]
  local top = {x + l * h, y - h}
  wb:stroke({{x, y}, {x + l * h * 0.4 + 1, y - h * 0.5}, top}, {pressure={0.7, 0.3}, ramps={0.02, 0.3}})
  for k = 1, 5 do
    local a = -1.57 + randn(0, 0.8)
    wb:stroke({top, {top[1] + math.cos(a) * rand(2, 5), top[2] + math.sin(a) * rand(2, 5)}}, {pressure={0.45, 0}, ramps={0.05, 0.8}})
  end
end
