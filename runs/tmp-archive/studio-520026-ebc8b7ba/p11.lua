-- one soft light, up and to the left, built from stacked soft pools (no spots)
pool1 = ellipse(190, 150, 470, 330):blur(200)
pool2 = ellipse(115, 95, 285, 195):blur(135)
work(wall * pool1, {hand="broad", tool="filbert 22", pile=g_wm, length={120, 260},
                    coverage=2.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.4})
work(wall * pool2, {hand="broad", tool="filbert 20", pile=g_wt, length={110, 240},
                    coverage=2.0, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.5})
-- deepen the far side and the lower corner, so the light has somewhere to fall from
work(wall * (ellipse(900, 420, 460, 330):blur(220)), {hand="glaze", pile=g_dk, coverage=1.6})
work(wall * (ellipse(620, 430, 330, 200):blur(150)), {hand="glaze", pile=g_dk, coverage=1.2})
-- the table
work(table_, {hand="broad", tool="filbert 24", pile=g_tb, length={110, 250},
              coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.1, edge="soft"})
work(table_ * (ellipse(120, 455, 300, 100):blur(110)), {hand="body", pile=g_wl,
              coverage=1.6, pressure=0.9, fill=true, dips={2, 1.0, 0.2}})
work(table_ * (ellipse(880, 700, 420, 300):blur(200)), {hand="glaze", pile=g_dk, coverage=1.4})
print(drying(500, 300))
