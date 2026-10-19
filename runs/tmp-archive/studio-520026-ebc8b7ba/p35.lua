-- muted olive greens; yellow ochre and green earth alone go lime
g_gm = pile{{"yellow ochre", 2.6}, {"green earth", 2.2}, {"raw umber", 1.0}, {"lead white", 0.2}}
g_gl = pile{{"yellow ochre", 2}, {"green earth", 1.6}, {"lead white", 1.2}, {"raw umber", 0.5}}

-- one fruit, as a value ladder: every step opaque OVER the one under it, so nothing
-- thin ever sits on the dark and nothing blooms
function fruit(a, lay, mid, lit, hi)
  local S = ashape(a)
  local tool = "filbert " .. math.max(7, math.floor(a.r / 6))
  work(S, {hand="body", tool=tool, pile=lay, length={30, 80}, coverage=3.4,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, -0.05, 0.65), {hand="body", tool=tool, pile=mid, length={30, 80}, coverage=3,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.35, 0.92), {hand="body", tool=tool, pile=lit, length={30, 80}, coverage=2.8,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend((S:shrink(3)):soften(3), {angle=0.3})
  -- core shadow at the far side from the light
  work(S * litf(a, -0.95, -0.28), {hand="body", tool=tool, pile=g_dk, length={30, 80}, coverage=1.5,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  -- the white cloth throws a cool light back along the shadow-side edge
  work(S:rim(a.r * 0.15, 9) * litf(a, -0.8, -0.02) * ellipse(a.cx, a.cy + a.r * 0.72, a.r * 0.95, a.r * 0.55),
       {hand="glaze", pile=g_cm, coverage=1.8})
  -- a small warm light where the light strikes
  work(hoff(a, 0.46):blur(a.r * 0.13), {hand="body", tool="filbert 6", pile=hi,
       length={12, 30}, coverage=2.2, pressure=1, fill=true, edge="soft"})
end
fruit(AP[1], g_gb, g_gm, g_gl, g_cl)
