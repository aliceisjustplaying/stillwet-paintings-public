work(everywhere(), {hand="broad", tool="filbert 26", pile=g_dk, length={90,220},
                    coverage=5, pressure=1, fill=true, dips={1, 1.0, 0.0},
                    angle=0.15, edge="found"})
blend((everywhere():shrink(6)):soften(6), {angle=0.2})
print(drying(500, 500))
