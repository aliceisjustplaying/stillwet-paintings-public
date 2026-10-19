function corem(a, t0, t1) return litf(a, t0, t1):map(function(v) return 1 - v end) end
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
fruit(AP[1], g_gb, g_gm, g_gl, g_hg, g_gc, 5, 1.3, 0.3)
fruit(AP[2], g_rb, g_rm, g_rl, g_hl, g_rc, 3, 1.3, 0.3)
fruit(AP[3], g_rb, g_rm, g_rl, g_hl, g_rc, 8, 1.3, 0.3)
fruit(AP[4], g_rb, g_rm, g_rl, g_hl, g_rc, 12, 2.2, 0.3)
fruit(AP[5], g_gb, g_gm, g_gl, g_hg, g_gc, 17, 2.2, 0.3)
