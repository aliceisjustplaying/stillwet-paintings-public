-- drapery: broad soft troughs with a broad soft ridge on the light side of each
BANDS = {
  {pts = {{40, 570}, {140, 660}, {260, 800}}, w = {90, 120, 150}},
  {pts = {{235, 545}, {330, 665}, {430, 800}}, w = {80, 110, 140}},
  {pts = {{700, 545}, {655, 670}, {610, 800}}, w = {90, 120, 150}},
  {pts = {{905, 560}, {870, 675}, {840, 800}}, w = {80, 110, 140}},
}
btr, brg = zero, zero
for _, b in ipairs(BANDS) do
  btr = btr + ribbon(b.pts, b.w):blur(52)
  brg = brg + ribbon(off(b.pts, -95, -28), {70, 95, 120}):blur(58)
end
work(CLOTH * btr, {hand="glaze", tool="filbert 24", pile=g_cd, length={110, 260},
                   coverage=2.4, pressure={0.7, 0.45}, angle=1.1, edge="soft"})
work(CLOTH * brg, {hand="glaze", tool="filbert 22", pile=g_cl, length={100, 240},
                   coverage=1.9, pressure={0.7, 0.45}, angle=1.1, edge="soft"})
