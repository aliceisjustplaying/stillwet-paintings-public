frontzone = ellipse(390, 690, 238, 142)
-- clean the cloth under the two front apples, then put its light and folds back
for _, ang in ipairs{0.2, -0.8} do
  work(frontzone, {hand="body", tool="filbert 15", pile=g_cm, length={40, 110}, coverage=5,
       pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
end
work(frontzone * clpool, {hand="body", tool="filbert 15", pile=g_cl, length={40, 110}, coverage=3,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.2, edge="soft"})
work(frontzone * btr, {hand="body", tool="filbert 14", pile=g_cd, length={35, 95}, coverage=2.6,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.0, edge="soft"})
work(frontzone * brg, {hand="body", tool="filbert 13", pile=g_cl, length={30, 85}, coverage=2.2,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=1.0, edge="soft"})
blend((frontzone:shrink(5)):soften(6), {angle=0.2})
-- and their shadows again, on clean cloth
allap = BOWL:grow(2)
for _, a in ipairs(AP) do allap = allap + ashape(a):grow(2) end
free2 = CLOTH - allap
for _, a in ipairs{AP[4], AP[5]} do
  work(free2 * (ellipse(a.cx + a.r*0.70, a.cy + a.r*0.46, a.r*1.30, a.r*0.58):blur(a.r*0.50)),
       {hand="body", tool="filbert 14", pile=g_cd, length={35, 95}, coverage=3.8, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(free2 * (ellipse(a.cx + a.r*0.30, a.cy + a.r*0.78, a.r*0.78, a.r*0.24):blur(a.r*0.15)),
       {hand="body", tool="filbert 11", pile=g_cd, length={25, 70}, coverage=4.5, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
end
