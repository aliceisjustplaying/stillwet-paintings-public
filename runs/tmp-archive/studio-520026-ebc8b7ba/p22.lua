-- pull the streaks back to the cloth's own tone, then restore the light
work(CLOTH * (fsh + fli), {hand="glaze", tool="filbert 22", pile=g_cm, length={100, 240},
                           coverage=3.2, pressure={0.8, 0.55}, angle=0.25, edge="soft"})
work(CLOTH * clpool, {hand="glaze", tool="filbert 24", pile=g_cl, length={120, 280},
                      coverage=2.4, pressure={0.75, 0.5}, angle=0.2, edge="soft"})
blend((CLOTH:shrink(6)):soften(6), {angle=0.18})
