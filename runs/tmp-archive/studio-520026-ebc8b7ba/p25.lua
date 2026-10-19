BANDS = {
  {pts = {{-30, 592}, {-5, 682}, {15, 800}}, w = {70, 100, 130}},
  {pts = {{40, 570}, {140, 660}, {260, 800}},   w = {90, 120, 150}},
  {pts = {{235, 545}, {330, 665}, {430, 800}},  w = {80, 110, 140}},
  {pts = {{700, 545}, {655, 670}, {610, 800}},  w = {90, 120, 150}},
  {pts = {{800, 550}, {778, 665}, {750, 800}},  w = {75, 105, 135}},
  {pts = {{930, 565}, {890, 678}, {858, 800}},  w = {80, 110, 140}},
}
btr, brg = zero, zero
for _, b in ipairs(BANDS) do
  btr = btr + ribbon(b.pts, b.w):blur(48)
  brg = brg + ribbon(off(b.pts, -95, -28), {70, 95, 120}):blur(56)
end
work(CLOTH * btr, {hand="body", tool="filbert 18", pile=g_cd, length={45, 120},
                   coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.1, edge="soft"})
work(CLOTH * brg, {hand="body", tool="filbert 16", pile=g_cl, length={40, 110},
                   coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.1, edge="soft"})
blend((CLOTH:shrink(6)):soften(6), {angle=1.0})
