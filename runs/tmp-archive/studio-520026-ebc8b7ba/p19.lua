-- bury the hard-edged light, back to a solid mid tone
work(CLOTH, {hand="body", tool="filbert 15", pile=g_cm, length={50, 130},
             coverage=4, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=-0.3, edge="soft"})
blend((CLOTH:shrink(6)):soften(6), {angle=0.15})
