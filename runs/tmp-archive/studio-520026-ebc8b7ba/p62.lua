-- the fruit was laid twelve deep; it needs more than ten to go
for _, ang in ipairs{0.9, 0.1, -0.4} do
  work(bowlzone * (CLOTH - BOWL:grow(2)), {hand="body", tool="filbert 16", pile=g_cm,
       length={40, 110}, coverage=5, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
  work(bowlzone * BOWL, {hand="body", tool="filbert 15", pile=g_bw, length={35, 95},
       coverage=5, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
end
-- rebuild the bowl on a clean ground
work(BOWL_IN, {hand="body", tool="filbert 12", pile=g_dk, length={30, 80}, coverage=6,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM, {hand="body", tool="filbert 9", pile=g_bw, length={22, 55}, coverage=4,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY, {hand="body", tool="filbert 12", pile=g_bw, length={30, 80}, coverage=4,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((BOWL:shrink(3)):soften(3), {angle=0.4})
work(BOWL_IN * (ellipse(452, 464, 124, 48):blur(44)), {hand="body", tool="filbert 10", pile=g_bw,
     length={25, 60}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(452, 458, 142, 64):blur(55)), {hand="body", tool="filbert 9", pile=g_bl,
     length={22, 55}, coverage=3.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(742, 514, 118, 64):blur(60)), {hand="body", tool="filbert 9", pile=g_dk,
     length={22, 55}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(462, 548, 155, 88):blur(72)), {hand="body", tool="filbert 12", pile=g_bl,
     length={30, 80}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(745, 574, 124, 94):blur(80)), {hand="body", tool="filbert 12", pile=g_dk,
     length={30, 80}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((BOWL:grow(2)):soften(4), {angle=0.4})
