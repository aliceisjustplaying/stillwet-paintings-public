-- a shadow on a white cloth has to be genuinely dark or it does not read at all
g_sh = pile{{"bone black", 1.3}, {"raw umber", 2}, {"pale smalt", 1}, {"lead white", 0.7}}
free2 = CLOTH - BOWL:grow(2)
for _, a in ipairs(AP) do free2 = free2 - ashape(a):grow(2) end
work(free2 * (ellipse(790, 626, 270, 76):blur(60)), {hand="body", tool="filbert 15", pile=g_sh,
     length={40, 110}, coverage=4.5, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(free2 * (ellipse(662, 602, 128, 30):blur(22)), {hand="body", tool="filbert 12", pile=g_sh,
     length={30, 80}, coverage=5, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
for _, a in ipairs{AP[4], AP[5]} do
  work(free2 * (ellipse(a.cx + a.r*0.70, a.cy + a.r*0.46, a.r*1.30, a.r*0.58):blur(a.r*0.50)),
       {hand="body", tool="filbert 14", pile=g_sh, length={35, 95}, coverage=4, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(free2 * (ellipse(a.cx + a.r*0.34, a.cy + a.r*0.80, a.r*0.85, a.r*0.30):blur(a.r*0.28)),
       {hand="body", tool="filbert 12", pile=g_sh, length={30, 80}, coverage=4.5, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
end
-- the bowl with a firm edge, then its light back on top
work(BOWL, {hand="body", tool="filbert 14", pile=g_bw, length={35, 95}, coverage=5, pressure=1,
     fill=true, dips={1, 1.0, 0.0}, edge="found"})
blend((BOWL:shrink(2)):soften(2), {angle=0.4})
work(BOWL_IN, {hand="body", tool="filbert 13", pile=g_dk2, length={30, 80}, coverage=4.5,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_IN * (ellipse(450, 460, 122, 44):blur(38)), {hand="body", tool="filbert 10", pile=g_bw,
     length={25, 60}, coverage=3.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(448, 456, 148, 68):blur(52)), {hand="body", tool="filbert 9", pile=g_bl,
     length={22, 55}, coverage=3.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(748, 518, 116, 64):blur(58)), {hand="body", tool="filbert 9", pile=g_dk2,
     length={22, 55}, coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(464, 544, 155, 88):blur(64)), {hand="body", tool="filbert 12", pile=g_bl,
     length={30, 80}, coverage=3.8, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(752, 578, 120, 92):blur(72)), {hand="body", tool="filbert 12", pile=g_dk2,
     length={30, 80}, coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
