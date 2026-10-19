-- the group's shadows on the clean cloth
free2 = CLOTH - BOWL:grow(2)
for _, a in ipairs(AP) do free2 = free2 - ashape(a):grow(2) end
work(free2 * (ellipse(775, 622, 265, 72):blur(62)), {hand="body", tool="filbert 15", pile=g_cd,
     length={40, 110}, coverage=4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(free2 * (ellipse(655, 601, 125, 30):blur(22)), {hand="body", tool="filbert 12", pile=g_cd,
     length={30, 80}, coverage=4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
for _, a in ipairs{AP[4], AP[5]} do
  work(free2 * (ellipse(a.cx + a.r*0.70, a.cy + a.r*0.46, a.r*1.30, a.r*0.58):blur(a.r*0.50)),
       {hand="body", tool="filbert 14", pile=g_cd, length={35, 95}, coverage=3.8, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(free2 * (ellipse(a.cx + a.r*0.34, a.cy + a.r*0.80, a.r*0.85, a.r*0.30):blur(a.r*0.28)),
       {hand="body", tool="filbert 12", pile=g_cd, length={30, 80}, coverage=3.4, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
end
-- the bowl again
for _, ang in ipairs{0.3, -0.6} do
  work(BOWL, {hand="body", tool="filbert 14", pile=g_bw, length={35, 95}, coverage=5, pressure=1,
       fill=true, dips={1, 1.0, 0.0}, angle=ang, edge="soft"})
end
blend((BOWL:shrink(2)):soften(2), {angle=0.4})
work(BOWL_IN, {hand="body", tool="filbert 13", pile=g_dk2, length={30, 80}, coverage=4.5,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_IN * (ellipse(455, 462, 118, 44):blur(40)), {hand="body", tool="filbert 10", pile=g_bw,
     length={25, 60}, coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(468, 546, 150, 86):blur(68)), {hand="body", tool="filbert 12", pile=g_bl,
     length={30, 80}, coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(748, 576, 122, 92):blur(76)), {hand="body", tool="filbert 12", pile=g_dk2,
     length={30, 80}, coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM, {hand="body", tool="filbert 9", pile=g_bw, length={22, 55}, coverage=3,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(452, 458, 142, 64):blur(55)), {hand="body", tool="filbert 9", pile=g_bl,
     length={22, 55}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM * (ellipse(742, 514, 118, 64):blur(60)), {hand="body", tool="filbert 9", pile=g_dk2,
     length={22, 55}, coverage=3, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((BOWL:shrink(2)):soften(2), {angle=0.4})
local rb = brush{kind="filbert", width=5, point=0.7}
rb:load(g_bl, 0.95)
rb:stroke(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, 3.34, 5.62, 26),
  {pressure={0.95, 0.15}, ramps={0.06, 0.3}, orient="across", swell={1, 1.15, 0.7}, clip=BOWL:grow(3)})
rb:wipe(0.9); rb:load(g_dk2, 0.9)
rb:stroke(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, 5.30, 6.35, 16),
  {pressure={0.25, 0.8}, ramps={0.05, 0.3}, orient="across", clip=BOWL:grow(3)})
