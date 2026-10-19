-- a matte earthenware in a dim room is a grey-brown; cool and dark it so that thin
-- passages grey down instead of glowing orange over the white cloth
g_bw = pile{{"raw umber", 3}, {"bone black", 1.3}, {"red earth", 0.8}, {"pale smalt", 0.45}}
work(BOWL_BODY, {hand="body", tool="filbert 13", pile=g_bw, length={35, 90},
                 coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.4, edge="soft"})
work(BOWL_RIM, {hand="body", tool="filbert 9", pile=g_bw, length={22, 55},
                coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_IN, {hand="body", tool="filbert 10", pile=g_dk, length={25, 60},
               coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((BOWL:shrink(3)):soften(3), {angle=0.4})
