-- paint out the colour test
work(rect(850, 108, 150, 226), {hand="body", tool="filbert 16", pile=g_dk, length={40, 100},
     coverage=5, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(rect(838, 96, 165, 240), {hand="glaze", pile=g_wl, coverage=2.2, pressure={0.7, 0.45}})
work(ellipse(930, 430, 420, 300):blur(200), {hand="glaze", pile=g_dk, coverage=1.8})

-- shadows only where cloth is actually seen
allap = BOWL:grow(2)
for _, a in ipairs(AP) do allap = allap + ashape(a):grow(2) end
free2 = CLOTH - allap
-- one shadow family thrown down and to the right, away from the upper-left light
work(free2 * (ellipse(775, 622, 265, 72):blur(62)), {hand="body", tool="filbert 15", pile=g_cd,
     length={40, 110}, coverage=4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(free2 * (ellipse(655, 601, 125, 30):blur(20)), {hand="body", tool="filbert 12", pile=g_cd,
     length={30, 80}, coverage=4.5, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
for _, a in ipairs{AP[4], AP[5]} do
  work(free2 * (ellipse(a.cx + a.r*0.70, a.cy + a.r*0.46, a.r*1.30, a.r*0.58):blur(a.r*0.50)),
       {hand="body", tool="filbert 14", pile=g_cd, length={35, 95}, coverage=3.8, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(free2 * (ellipse(a.cx + a.r*0.30, a.cy + a.r*0.78, a.r*0.78, a.r*0.24):blur(a.r*0.15)),
       {hand="body", tool="filbert 11", pile=g_cd, length={25, 70}, coverage=4.5, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
end
