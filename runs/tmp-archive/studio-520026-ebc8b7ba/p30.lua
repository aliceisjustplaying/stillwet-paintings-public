-- the inside of the bowl is in shadow; the far inner wall catches a little light
work(BOWL_IN, {hand="body", tool="filbert 12", pile=g_dk, length={30, 80},
               coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_IN * (ellipse(455, 468, 115, 48):blur(50)), {hand="body", tool="filbert 12", pile=g_bd,
      length={30, 80}, coverage=2.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
-- the outer wall: light from the upper left, deep shadow at the right
work(BOWL_BODY * (ellipse(468, 552, 145, 85):blur(75)), {hand="body", tool="filbert 13", pile=g_bw,
      length={35, 90}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(735, 570, 125, 95):blur(80)), {hand="body", tool="filbert 13", pile=g_dk,
      length={35, 90}, coverage=2.2, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
-- the white cloth throws a soft cool light back up under the bowl
work(BOWL_BODY * (ellipse(600, 648, 205, 72):blur(58)), {hand="glaze", pile=g_cm, coverage=2.0})
