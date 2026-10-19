-- a real value ladder for the reds: dark lay-in, medium, and a clearly lighter light
g_rb = pile{{"vermilion", 1.6}, {"raw umber", 3}, {"red earth", 2.4}, {"bone black", 1.2}}
g_rm = pile{{"vermilion", 2.0}, {"red earth", 2.2}, {"raw umber", 1.0}}
g_rl = pile{{"vermilion", 1.4}, {"red earth", 1.2}, {"yellow ochre", 1.6}, {"lead white", 1.2}, {"raw umber", 0.3}}
g_rc = pile{{"vermilion", 0.8}, {"raw umber", 3}, {"red earth", 1.6}, {"bone black", 1.4}}
-- and a deeper ladder for the green
g_gb = pile{{"green earth", 2.0}, {"Prussian blue", 0.5}, {"raw umber", 2.8}, {"bone black", 1.0}}
g_gc = pile{{"green earth", 1.2}, {"Prussian blue", 0.4}, {"raw umber", 3}, {"bone black", 1.4}}

function fruit(a, lay, mid, lit, hi, core, sd)
  local S = ellipse(a.cx, a.cy, a.r, a.r * 0.95):roughen(2.5, 70, sd):soften(1.5)
  local tool = "filbert " .. math.max(9, math.floor(a.r / 5))
  -- lay-in with a clean drawn edge, then soften it back: crisp AND lost, not scalloped
  work(S, {hand="body", tool=tool, pile=lay, length={30, 80}, coverage=3.4, pressure=1,
           fill=true, dips={1, 1.0, 0.0}, edge="found", clip=true})
  work(S * litf(a, 0.0, 0.55), {hand="body", tool=tool, pile=mid, length={30, 80}, coverage=3.2,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.45, 0.95), {hand="body", tool=tool, pile=lit, length={30, 80}, coverage=3,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend((S:grow(4)):soften(5), {angle=0.3})
  work(S * litf(a, -1.0, -0.15), {hand="body", tool=tool, pile=core, length={30, 80}, coverage=2.8,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend((S:grow(3)):soften(4), {angle=0.3})
  -- the white cloth throws a cool light back along the shadow-side edge
  work(S:rim(a.r * 0.16, 10) * litf(a, -0.75, 0.0) * ellipse(a.cx, a.cy + a.r * 0.7, a.r, a.r * 0.6),
       {hand="glaze", pile=g_cm, coverage=2.0})
  -- the light itself: one clean touch. fill=true over a small mask beads into cottage cheese.
  local b = brush{kind="filbert", width=math.max(6, math.floor(a.r / 8)), point=0.6}
  b:load(hi, 0.75)
  local hx, hy = a.cx + LX*a.r*0.5, a.cy + LY*a.r*0.5
  b:touch(hx, hy, {pressure=0.5, clip=S:grow(3)})
  b:touch(hx + 4, hy + 5, {pressure=0.3, clip=S:grow(3)})
end
fruit(AP[2], g_rb, g_rm, g_rl, g_hl, g_rc, 3)
fruit(AP[3], g_rb, g_rm, g_rl, g_hl, g_rc, 8)
