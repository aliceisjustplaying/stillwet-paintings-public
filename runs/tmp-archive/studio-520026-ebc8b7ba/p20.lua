clpool = ellipse(250, 650, 470, 215):blur(240)
work(CLOTH * clpool, {hand="body", tool="filbert 15", pile=g_cl, length={50, 130},
                      coverage=3.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.2, edge="soft"})
-- the far side of the cloth, and the front fall, go into shadow: soft pools, no booleans
work(CLOTH * (ellipse(930, 690, 330, 210):blur(200)), {hand="body", tool="filbert 15", pile=g_cd,
      length={50, 130}, coverage=2.8, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.3, edge="soft"})
work(CLOTH * (ellipse(430, 845, 560, 105):blur(95)), {hand="body", tool="filbert 15", pile=g_cd,
      length={50, 130}, coverage=2.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.1, edge="soft"})
blend((CLOTH:shrink(6)):soften(6), {angle=0.2})
