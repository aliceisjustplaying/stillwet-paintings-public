-- clean the whole bowl region back to cloth and bowl, so the fruit can be laid in
-- on a clean ground and every trace of the earlier halos goes with it
bowlzone = ellipse(575, 462, 248, 208)
work(bowlzone * (CLOTH - BOWL:grow(2)), {hand="body", tool="filbert 15", pile=g_cm,
     length={40, 110}, coverage=4, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.2, edge="soft"})
work(bowlzone * BOWL, {hand="body", tool="filbert 14", pile=g_bw, length={35, 95},
     coverage=4, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.4, edge="soft"})
blend((bowlzone:shrink(4)):soften(5), {angle=0.35})
-- and model the bowl again from clean paint
work(BOWL_IN, {hand="body", tool="filbert 12", pile=g_dk, length={30, 80}, coverage=3.2,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_IN * (ellipse(452, 466, 122, 48):blur(46)), {hand="body", tool="filbert 10", pile=g_bw,
     length={25, 60}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(452, 458, 142, 64):blur(55)), {hand="body", tool="filbert 9", pile=g_bl,
     length={22, 55}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(742, 514, 118, 64):blur(60)), {hand="body", tool="filbert 9", pile=g_dk,
     length={22, 55}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(462, 548, 155, 88):blur(72)), {hand="body", tool="filbert 12", pile=g_bl,
     length={30, 80}, coverage=2.8, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(745, 574, 124, 94):blur(80)), {hand="body", tool="filbert 12", pile=g_dk,
     length={30, 80}, coverage=2.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(600, 654, 200, 62):blur(52)), {hand="glaze", pile=g_cm, coverage=1.6})
blend((BOWL:shrink(3)):soften(3), {angle=0.4})
