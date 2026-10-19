-- deeper greens, and no Prussian blue in the core: over white it goes blue-grey
g_gb = pile{{"bone black", 2.0}, {"green earth", 2.2}, {"raw umber", 1.8}}
g_gm = pile{{"green earth", 2.4}, {"yellow ochre", 1.2}, {"raw umber", 1.0}, {"bone black", 0.6}}
g_gl = pile{{"lead white", 2.2}, {"yellow ochre", 2.0}, {"green earth", 1.0}, {"raw umber", 0.3}}
g_gc = pile{{"bone black", 2.6}, {"green earth", 1.4}, {"raw umber", 1.8}}
-- a core with no flat top: darkest only at the silhouette, rising smoothly to the terminator
function fruit(a, lay, mid, lit, hi, core, sd, k, ct)
  k = k or 1
  local S = ellipse(a.cx, a.cy, a.r, a.r * 0.95):roughen(2.5, 70, sd):soften(2.5)
  local tool = "filbert " .. math.max(9, math.floor(a.r / 5))
  work(S, {hand="body", tool=tool, pile=lay, length={30, 80}, coverage=4.5*k, pressure=1,
           fill=true, dips={1, 1.0, 0.0}, edge="found"})
  work(S * litf(a, 0.0, 0.55), {hand="body", tool=tool, pile=mid, length={30, 80}, coverage=3.2*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.45, 0.95), {hand="body", tool=tool, pile=lit, length={30, 80}, coverage=3.0*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend(S:rim(20, 14), {angle=0.3})
  work(S * corem(a, -0.9, ct or 0.3), {hand="body", tool=tool, pile=core, length={30, 80},
           coverage=4.0*k, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend(S:rim(15, 10), {angle=0.3})
  work(S:rim(a.r * 0.08, 5) * corem(a, -0.6, 0.2) * ellipse(a.cx, a.cy + a.r * 0.9, a.r * 0.7, a.r * 0.42),
       {hand="glaze", pile=g_cm, coverage=0.6})
  stipple(hoff(a, 0.52):blur(a.r * 0.15), {pile=hi, width=4, coverage=2.6,
         pressure={0.5, 0.8}, cluster=0.3, dips={5, 1.0, 0.3}})
end
fruit(AP[5], g_gb, g_gm, g_gl, g_hg, g_gc, 17, 2.2, 0.3)
