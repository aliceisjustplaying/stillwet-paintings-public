-- the old fruit lay nearly twenty deep; twenty-four goes over the top of it
for _, ang in ipairs{0.2, -0.8, 0.5, -0.3} do
  work(frontzone, {hand="body", tool="filbert 16", pile=g_cm, length={40, 110}, coverage=6,
       pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
end
work(frontzone * clpool, {hand="body", tool="filbert 15", pile=g_cl, length={40, 110}, coverage=3.4,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.2, edge="soft"})
work(frontzone * btr, {hand="body", tool="filbert 14", pile=g_cd, length={35, 95}, coverage=2.8,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.0, edge="soft"})
work(frontzone * brg, {hand="body", tool="filbert 13", pile=g_cl, length={30, 85}, coverage=2.4,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.0, edge="soft"})
work(frontzone * (ellipse(760, 845, 340, 120):blur(110)), {hand="body", tool="filbert 14", pile=g_cd,
     length={35, 95}, coverage=2.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
