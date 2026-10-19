-- the wall and table are finished, so those piles become deep cores of each fruit's own hue
g_rc = pile{{"vermilion", 1.0}, {"raw umber", 2.2}, {"red earth", 1.6}, {"bone black", 0.7}}
g_gc = pile{{"green earth", 1.6}, {"Prussian blue", 0.5}, {"raw umber", 2.2}, {"bone black", 0.6}}

function fruit(a, lay, mid, lit, hi, core)
  local S = ashape(a)
  local tool = "filbert " .. math.max(7, math.floor(a.r / 6))
  work(S, {hand="body", tool=tool, pile=lay, length={30, 80}, coverage=3.4,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, -0.05, 0.65), {hand="body", tool=tool, pile=mid, length={30, 80}, coverage=3,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.35, 0.92), {hand="body", tool=tool, pile=lit, length={30, 80}, coverage=2.8,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend((S:shrink(3)):soften(3), {angle=0.3})
  -- core shadow: broad and soft, in the fruit's own deep hue, never neutral black
  work(S * litf(a, -1.0, -0.18), {hand="body", tool=tool, pile=core, length={30, 80}, coverage=2.6,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  -- the white cloth throws a cool light back along the shadow-side edge
  work(S:rim(a.r * 0.15, 9) * litf(a, -0.8, -0.02) * ellipse(a.cx, a.cy + a.r * 0.72, a.r * 0.95, a.r * 0.55),
       {hand="glaze", pile=g_cm, coverage=1.8})
  -- a small warm light where the light strikes
  work(hoff(a, 0.46):blur(a.r * 0.14), {hand="body", tool="filbert 6", pile=hi,
       length={12, 30}, coverage=2.0, pressure=1, fill=true, edge="soft"})
end
-- put the green apple's core back in as a deep olive
local a = AP[1]
local S = ashape(a)
work(S * litf(a, -1.0, -0.18), {hand="body", tool="filbert 15", pile=g_gc, length={30, 80},
     coverage=2.8, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
blend((S:shrink(3)):soften(3), {angle=0.3})
