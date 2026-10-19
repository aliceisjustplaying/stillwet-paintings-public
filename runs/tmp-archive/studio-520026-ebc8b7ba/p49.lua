-- Prussian blue in the core reads teal over white cloth; take it out
g_gc = pile{{"green earth", 1.4}, {"Prussian blue", 0.15}, {"raw umber", 3}, {"bone black", 1.2}}
g_gb = pile{{"green earth", 2.0}, {"Prussian blue", 0.2}, {"raw umber", 2.8}, {"bone black", 1.0}}

function fruit(a, lay, mid, lit, hi, core, sd, k)
  k = k or 1
  local S = ellipse(a.cx, a.cy, a.r, a.r * 0.95):roughen(2.5, 70, sd):soften(2.5)
  local tool = "filbert " .. math.max(9, math.floor(a.r / 5))
  -- lay-in clipped so the silhouette is clean; the rim blend below softens it again
  work(S, {hand="body", tool=tool, pile=lay, length={30, 80}, coverage=5, pressure=1,
           fill=true, dips={1, 1.0, 0.0}, edge="found", clip=true})
  work(S * litf(a, 0.0, 0.55), {hand="body", tool=tool, pile=mid, length={30, 80}, coverage=3.2*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.48, 0.95), {hand="body", tool=tool, pile=lit, length={30, 80}, coverage=3.0*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend(S:rim(22, 13), {angle=0.3})
  work(S * litf(a, -1.0, -0.06), {hand="body", tool=tool, pile=core, length={30, 80}, coverage=3.0*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend(S:rim(18, 10), {angle=0.3})
  -- a NARROW band of bounced light, low down. Wide and strong, it reads as frost.
  work(S:rim(a.r * 0.07, 5) * litf(a, -0.6, 0.15) * ellipse(a.cx, a.cy + a.r * 0.9, a.r * 0.7, a.r * 0.42),
       {hand="glaze", pile=g_cm, coverage=0.5})
  stipple(hoff(a, 0.52):blur(a.r * 0.15), {pile=hi, width=4, coverage=2.6,
         pressure={0.5, 0.8}, cluster=0.3, dips={5, 1.0, 0.3}})
end
fruit(AP[4], g_rb, g_rm, g_rl, g_hl, g_rc, 12, 1.3)
fruit(AP[5], g_gb, g_gm, g_gl, g_hg, g_gc, 17, 1.3)
