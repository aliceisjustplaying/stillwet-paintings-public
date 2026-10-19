-- the table still held a strip of the stipple, and the band left a hard rectangle
for _, ang in ipairs{0.1, -0.9, 0.6} do
  work(table_, {hand="body", tool="filbert 18", pile=g_tb, length={50, 130}, coverage=6, pressure=1,
       fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
end
work(table_ * (ellipse(130, 452, 300, 100):blur(110)), {hand="body", tool="filbert 15", pile=g_wl,
     length={40, 110}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(table_ * (ellipse(880, 700, 420, 300):blur(200)), {hand="glaze", pile=g_dk2, coverage=2})
-- blend the whole cloth so the band's rectangle dissolves into it
blend((CLOTH:shrink(6)):soften(6), {angle=0.2})
-- and put the front apple back, its top had cloth painted over it
fruit(AP[4], g_rb, g_rm, g_rl, g_hl, g_rc, 12, 2.2, 0.3)
