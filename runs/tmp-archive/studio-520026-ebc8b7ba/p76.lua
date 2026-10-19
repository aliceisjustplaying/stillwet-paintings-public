-- the visible table is only the strip above the cloth; table_ itself runs under everything
tablevis = table_ - CLOTH
print(string.format("visible table %.0f, cloth %.0f", tablevis:area(), CLOTH:area()))
-- the cloth, laid again
for _, ang in ipairs{0.2, -0.8, 0.5} do
  work(CLOTH, {hand="body", tool="filbert 16", pile=g_cm, length={40, 110}, coverage=6, pressure=1,
       fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
end
work(CLOTH * clpool, {hand="body", tool="filbert 15", pile=g_cl, length={40, 110}, coverage=3.4,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.2, edge="soft"})
work(CLOTH * btr, {hand="body", tool="filbert 14", pile=g_cd, length={35, 95}, coverage=2.8,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.0, edge="soft"})
work(CLOTH * brg, {hand="body", tool="filbert 13", pile=g_cl, length={30, 85}, coverage=2.4,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.0, edge="soft"})
work(CLOTH * (ellipse(930, 690, 300, 190):blur(170)), {hand="body", tool="filbert 15", pile=g_cd,
     length={40, 110}, coverage=2.8, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(CLOTH * (ellipse(760, 845, 340, 120):blur(110)), {hand="body", tool="filbert 15", pile=g_cd,
     length={40, 110}, coverage=2.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((CLOTH:shrink(6)):soften(6), {angle=0.2})
