-- bury the test swatches properly this time
work(rect(832, 100, 175, 215), {hand="body", tool="filbert 16", pile=g_dk, length={40, 100},
     coverage=7, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.3, edge="soft"})
work(rect(832, 100, 175, 215), {hand="body", tool="filbert 16", pile=g_dk, length={40, 100},
     coverage=5, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=-0.6, edge="soft"})
work(rect(818, 86, 195, 240), {hand="glaze", pile=g_wl, coverage=2.6, pressure={0.75, 0.5}})
work(ellipse(940, 420, 430, 300):blur(200), {hand="glaze", pile=g_dk, coverage=2.2})
