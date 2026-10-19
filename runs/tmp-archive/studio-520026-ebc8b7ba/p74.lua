-- bury the stipple: the wall back to its dark, and the cloth's upper band back to cloth
for _, ang in ipairs{0.3, -0.7, 0.9} do
  work(wall, {hand="body", tool="filbert 18", pile=g_wl, length={50, 130}, coverage=6, pressure=1,
       fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
end
blend((wall:shrink(6)):soften(6), {angle=0.3})
band = CLOTH * rect(-6, 470, 610, 200)
for _, ang in ipairs{0.2, -0.8, 0.5} do
  work(band, {hand="body", tool="filbert 16", pile=g_cm, length={40, 110}, coverage=6, pressure=1,
       fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
end
work(band * clpool, {hand="body", tool="filbert 15", pile=g_cl, length={40, 110}, coverage=3.4,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.2, edge="soft"})
work(band * btr, {hand="body", tool="filbert 14", pile=g_cd, length={35, 95}, coverage=2.8,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.0, edge="soft"})
work(band * brg, {hand="body", tool="filbert 13", pile=g_cl, length={30, 85}, coverage=2.4,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.0, edge="soft"})
blend((band:grow(8)):soften(10), {angle=0.2})
