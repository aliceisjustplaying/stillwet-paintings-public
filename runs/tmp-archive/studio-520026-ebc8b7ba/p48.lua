-- a fruit over the white cloth needs far more paint than one over a dark ground:
-- at coverage 3.4 the films are only half hiding and the cloth reads straight through
function fruit(a, lay, mid, lit, hi, core, sd, k)
  k = k or 1
  local S = ellipse(a.cx, a.cy, a.r, a.r * 0.95):roughen(2.5, 70, sd):soften(2.5)
  local tool = "filbert " .. math.max(9, math.floor(a.r / 5))
  work(S, {hand="body", tool=tool, pile=lay, length={30, 80}, coverage=3.4*k, pressure=1,
           fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.0, 0.55), {hand="body", tool=tool, pile=mid, length={30, 80}, coverage=3.2*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.48, 0.95), {hand="body", tool=tool, pile=lit, length={30, 80}, coverage=3.0*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend(S:rim(20, 11), {angle=0.3})
  work(S * litf(a, -1.0, -0.06), {hand="body", tool=tool, pile=core, length={30, 80}, coverage=3.0*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend(S:rim(16, 9), {angle=0.3})
  work(S:rim(a.r * 0.10, 7) * litf(a, -0.7, 0.12) * ellipse(a.cx, a.cy + a.r * 0.85, a.r * 0.8, a.r * 0.5),
       {hand="glaze", pile=g_cm, coverage=0.9})
  stipple(hoff(a, 0.5):blur(a.r * 0.18), {pile=hi, width=4, coverage=2.4,
         pressure={0.5, 0.8}, cluster=0.3, dips={5, 1.0, 0.3}})
end
fruit(AP[4], g_rb, g_rm, g_rl, g_hl, g_rc, 12, 2.1)
fruit(AP[5], g_gb, g_gm, g_gl, g_hg, g_gc, 17, 2.1)
