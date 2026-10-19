-- the evening comes down: a cool glaze over the near snow, deeper toward the bottom, and a dark veil
-- growing toward the picture's edges (Friedrich to Carus: darker toward the edges)
local vn = noise{seed=191, octaves=3, period=300}
NEARDARK = mask(function(x, y) return smoothstep(bank(x) + 10, 714, y) * (0.75 + 0.25*vn:at01(x, y)) end)
glaze(NEARDARK, {color="#56607c", coats=0.5})
VIG = mask(function(x, y) local dx, dy = (x - 520)/560, (y - 430)/430
  return smoothstep(0.6, 1.3, math.sqrt(dx*dx + dy*dy)) * (0.8 + 0.2*vn:at01(y, x)) end)
glaze(VIG, {color="#3b4055", coats=0.4})
