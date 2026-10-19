function fruit(a, lay, mid, lit, hi, core, sd)
  local S = ellipse(a.cx, a.cy, a.r, a.r * 0.95):roughen(2.5, 70, sd):soften(2.5)
  local tool = "filbert " .. math.max(9, math.floor(a.r / 5))
  work(S, {hand="body", tool=tool, pile=lay, length={30, 80}, coverage=3.4, pressure=1,
           fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.0, 0.55), {hand="body", tool=tool, pile=mid, length={30, 80}, coverage=3.2,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.48, 0.95), {hand="body", tool=tool, pile=lit, length={30, 80}, coverage=3,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  -- blend the CONTOUR only. A blend over the whole fruit averages the modelling away.
  blend(S:rim(16, 9), {angle=0.3})
  work(S * litf(a, -1.0, -0.06), {hand="body", tool=tool, pile=core, length={30, 80}, coverage=3,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend(S:rim(14, 8), {angle=0.3})
  work(S:rim(a.r * 0.10, 7) * litf(a, -0.7, 0.12) * ellipse(a.cx, a.cy + a.r * 0.85, a.r * 0.8, a.r * 0.5),
       {hand="glaze", pile=g_cm, coverage=1.1})
  stipple(hoff(a, 0.5):blur(a.r * 0.18), {pile=hi, width=4, coverage=3,
         pressure={0.5, 0.8}, cluster=0.3, dips={5, 1.0, 0.3}})
end
fruit(AP[1], g_gb, g_gm, g_gl, g_hg, g_gc, 5)
