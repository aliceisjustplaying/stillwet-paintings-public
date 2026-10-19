-- a still-life red is a deep crimson, not vermilion poster colour
g_rb = pile{{"vermilion", 2.2}, {"raw umber", 2}, {"red earth", 2}, {"bone black", 0.5}}
g_rm = pile{{"vermilion", 1.8}, {"red earth", 2.2}, {"yellow ochre", 0.7}, {"raw umber", 0.6}}
g_rl = pile{{"vermilion", 1.2}, {"red earth", 1.4}, {"yellow ochre", 1.2}, {"lead white", 0.7}, {"raw umber", 0.3}}
-- a warm cream with a little red in it: a cream highlight on a red apple reads as a pink blob
g_hl = pile{{"lead white", 4}, {"red earth", 0.7}, {"yellow ochre", 0.5}, {"raw umber", 0.3}}

function fruit(a, lay, mid, lit, hi, core, sd)
  local S = ashape(a)
  local tool = "filbert " .. math.max(7, math.floor(a.r / 6))
  work(S, {hand="body", tool=tool, pile=lay, length={30, 80}, coverage=3.4, pressure=1,
           fill=true, dips={1, 1.0, 0.0}, edge={found=0.3, soft=0.7, period=95, seed=sd}})
  work(S * litf(a, -0.05, 0.65), {hand="body", tool=tool, pile=mid, length={30, 80}, coverage=3,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.35, 0.92), {hand="body", tool=tool, pile=lit, length={30, 80}, coverage=2.8,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend((S:shrink(3)):soften(3), {angle=0.3})
  work(S * litf(a, -1.0, -0.18), {hand="body", tool=tool, pile=core, length={30, 80}, coverage=2.6,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S:rim(a.r * 0.15, 9) * litf(a, -0.8, -0.02) * ellipse(a.cx, a.cy + a.r * 0.72, a.r * 0.95, a.r * 0.55),
       {hand="glaze", pile=g_cm, coverage=1.8})
  work(hoff(a, 0.5):blur(a.r * 0.16), {hand="body", tool="filbert 5", pile=hi,
       length={10, 24}, coverage=1.8, pressure=1, fill=true, edge="soft"})
end
fruit(AP[2], g_rb, g_rm, g_rl, g_hl, g_rc, 3)
fruit(AP[3], g_rb, g_rm, g_rl, g_hl, g_rc, 8)
