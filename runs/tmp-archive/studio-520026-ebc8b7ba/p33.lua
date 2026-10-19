-- the wall light is finished with, so that pile becomes the bowl's lit earthenware
g_bl = pile{{"raw umber", 2.4}, {"red earth", 0.7}, {"lead white", 1.0},
            {"bone black", 0.4}, {"pale smalt", 0.3}}
-- the rim: its top surface faces the light, and it falls away to the right
work(BOWL_RIM * (ellipse(450, 460, 140, 62):blur(55)), {hand="body", tool="filbert 9", pile=g_bl,
      length={22, 55}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(600, 540, 150, 34):blur(30)), {hand="body", tool="filbert 9", pile=g_bl,
      length={22, 55}, coverage=2.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(735, 512, 115, 62):blur(58)), {hand="body", tool="filbert 9", pile=g_dk,
      length={22, 55}, coverage=2.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
-- the outer wall
work(BOWL_BODY * (ellipse(462, 550, 152, 86):blur(72)), {hand="body", tool="filbert 12", pile=g_bl,
      length={30, 80}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(742, 572, 122, 92):blur(78)), {hand="body", tool="filbert 12", pile=g_dk,
      length={30, 80}, coverage=2.0, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(600, 652, 200, 65):blur(55)), {hand="glaze", pile=g_cm, coverage=1.8})
-- the far inner wall catches a little
work(BOWL_IN * (ellipse(450, 468, 120, 46):blur(45)), {hand="body", tool="filbert 10", pile=g_bw,
      length={25, 60}, coverage=2.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((BOWL:shrink(3)):soften(3), {angle=0.4})
