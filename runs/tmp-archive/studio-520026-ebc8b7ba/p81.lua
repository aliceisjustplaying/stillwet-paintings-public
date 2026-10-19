-- smooth out the hard vertical boundary the light left in the upper wall
blend((wallfree * (ellipse(400, 180, 620, 380):blur(150))):grow(20):soften(40), {angle=0.35})
-- the cloth's far side must fall away, or the light has no direction
work(CLOTH * (ellipse(960, 680, 300, 210):blur(160)), {hand="body", tool="filbert 16", pile=g_cd,
     length={40, 110}, coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(CLOTH * (ellipse(820, 830, 330, 130):blur(120)), {hand="body", tool="filbert 16", pile=g_cd,
     length={40, 110}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(CLOTH * (ellipse(1000, 560, 220, 180):blur(120)), {hand="body", tool="filbert 14", pile=g_cd,
     length={35, 95}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
-- the table strip in shadow, tying the cloth's shadow to the wall's
work(tablevis * (ellipse(900, 440, 340, 130):blur(120)), {hand="glaze", pile=g_dk2, coverage=2.2})
