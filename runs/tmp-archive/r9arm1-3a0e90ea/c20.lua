-- dry grass and reeds, upturning flicks laid last over the snow
local GR = {"#5a4e40", "#463c32", "#6e604c", "#7a6a52", "#52483d"}
function tuft(x, y, hm, n, reed)
  local s = per_m(y)
  local h = hm * s
  local g = brush{kind="rigger", width=math.max(0.45, 0.012 * s), point=1}
  for i = 1, n do
    if i % 3 == 1 then g:reload(GR[math.random(1, #GR)], 0.7, {at={x, y - 0.1 * s}, coats=0.9}) end
    local bx = x + randn(0, 0.06 * s)
    local lean = randn(0.12, 0.35)
    local hh = h * rand(0.35, 1.0)
    local p = {{bx, y + rand(0, 0.02 * s)}, {bx + lean * hh * 0.25, y - hh * 0.5}, {bx + lean * hh * 0.7 + randn(0, 0.05 * hh), y - hh}}
    g:stroke(p, {pressure={0.8, 0.0}, ramps={0.03, 0.8}, shake=0.4})
    if reed and i % 4 == 0 then           -- a seed head, a dark little plume at the tip
      local tb = brush{kind="round", width=math.max(0.5, 0.025 * s), point=1}
      tb:load("#3e342c", 0.7, {at={x, y - 0.3 * s}, coats=0.9})
      local tx, ty = p[3][1], p[3][2]
      tb:stroke({{tx - lean * 0.03 * s, ty + 0.08 * s}, {tx + lean * 0.06 * s, ty - 0.02 * s}}, {pressure={0.7, 0.0}})
    end
  end
end
STREAMG = STREAMM:grow(5)
-- along both banks of the brook, nearer = more
for i = 1, #STREAM - 1 do
  local a, b = STREAM[i], STREAM[i + 1]
  local nseg = math.max(1, math.floor((b[2] > 560 and 5 or 2) * math.min(1, (a[2] - HZ) / 120)))
  for k = 1, nseg do
    local t = rand(0, 1)
    local x, y = a[1] + (b[1] - a[1]) * t, a[2] + (b[2] - a[2]) * t
    local w = stream_w(y) / 2
    local sd = (math.random() < 0.5) and -1 or 1
    local yy = y + sd * (w + rand(0.5, 3) * per_m(y) * 0.1)
    if per_m(yy) > 8 and STREAMG:at(x, yy) < 0.2 then tuft(x + randn(0, 4), yy, rand(0.25, 0.6), math.floor(rand(5, 12)), math.random() < 0.4) end
  end
end
-- a patch of reeds in the left foreground, and a few stalks at the lower right
for i = 1, 7 do tuft(rand(25, 120), rand(655, 708), rand(0.35, 0.7), math.floor(rand(8, 16)), true) end
for i = 1, 4 do tuft(rand(900, 985), rand(672, 706), rand(0.2, 0.45), math.floor(rand(4, 9)), false) end
