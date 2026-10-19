-- the bowl has to READ: deepen the inside, strengthen the wall, and put a crisp light
-- on the rim's upper-left arc. That one thin line is what describes the ellipse.
work(BOWL_IN, {hand="body", tool="filbert 13", pile=g_dk2, length={30, 80}, coverage=4.5,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_IN * (ellipse(455, 462, 118, 44):blur(40)), {hand="body", tool="filbert 10", pile=g_bw,
     length={25, 60}, coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
-- the wall: a definite light on the left, deep on the right
work(BOWL_BODY, {hand="body", tool="filbert 12", pile=g_bw, length={30, 80}, coverage=3,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(468, 546, 150, 86):blur(68)), {hand="body", tool="filbert 12", pile=g_bl,
     length={30, 80}, coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_BODY * (ellipse(748, 576, 122, 92):blur(76)), {hand="body", tool="filbert 12", pile=g_dk2,
     length={30, 80}, coverage=3.4, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
work(BOWL_RIM, {hand="body", tool="filbert 9", pile=g_bw, length={22, 55}, coverage=3,
     pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((BOWL:shrink(2)):soften(2), {angle=0.4})
-- a crisp light along the rim, strong at the left and dying away to the right
local rb = brush{kind="filbert", width=5, point=0.7}
rb:load(g_bl, 0.95)
rb:stroke(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, 3.34, 5.62, 26),
  {pressure={0.95, 0.15}, ramps={0.06, 0.3}, orient="across", swell={1, 1.15, 0.7}, clip=BOWL:grow(3)})
-- and a thin dark along the rim where it turns away
rb:wipe(0.9); rb:load(g_dk2, 0.9)
rb:stroke(arc(BOWLX, BOWLY, BOWLRX, BOWLRY, 5.30, 6.35, 16),
  {pressure={0.25, 0.8}, ramps={0.05, 0.3}, orient="across", clip=BOWL:grow(3)})
