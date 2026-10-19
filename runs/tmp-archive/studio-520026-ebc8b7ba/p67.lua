function corem(a, t0, t1) return litf(a, t0, t1):map(function(v) return 1 - v end) end
function fruit(a, lay, mid, lit, hi, core, sd, k, ct)
  k = k or 1
  local S = ellipse(a.cx, a.cy, a.r, a.r * 0.95):roughen(2.5, 70, sd):soften(2.5)
  local tool = "filbert " .. math.max(9, math.floor(a.r / 5))
  work(S, {hand="body", tool=tool, pile=lay, length={30, 80}, coverage=4.5, pressure=1,
           fill=true, dips={1, 1.0, 0.0}, edge="found"})
  work(S * litf(a, 0.0, 0.55), {hand="body", tool=tool, pile=mid, length={30, 80}, coverage=3.2*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(S * litf(a, 0.45, 0.95), {hand="body", tool=tool, pile=lit, length={30, 80}, coverage=3.0*k,
           pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend(S:rim(24, 17), {angle=0.3})
  work(S * corem(a, -1.0, ct or 0.05), {hand="body", tool=tool, pile=core, length={30, 80},
           coverage=3.4*k, pressure=1, fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  blend(S:rim(20, 14), {angle=0.3})
  work(S:rim(a.r * 0.08, 5) * corem(a, -0.6, 0.2) * ellipse(a.cx, a.cy + a.r * 0.9, a.r * 0.7, a.r * 0.42),
       {hand="glaze", pile=g_cm, coverage=0.6})
  stipple(hoff(a, 0.52):blur(a.r * 0.15), {pile=hi, width=4, coverage=2.6,
         pressure={0.5, 0.8}, cluster=0.3, dips={5, 1.0, 0.3}})
end
-- shadows on the cleaned cloth, then the fruit over them
allap = BOWL:grow(2)
for _, a in ipairs(AP) do allap = allap + ashape(a):grow(2) end
free2 = CLOTH - allap
for _, a in ipairs{AP[4], AP[5]} do
  work(free2 * (ellipse(a.cx + a.r*0.70, a.cy + a.r*0.46, a.r*1.30, a.r*0.58):blur(a.r*0.50)),
       {hand="body", tool="filbert 14", pile=g_cd, length={35, 95}, coverage=3.8, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(free2 * (ellipse(a.cx + a.r*0.30, a.cy + a.r*0.78, a.r*0.78, a.r*0.24):blur(a.r*0.15)),
       {hand="body", tool="filbert 11", pile=g_cd, length={25, 70}, coverage=4.5, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
end
fruit(AP[4], g_rb, g_rm, g_rl, g_hl, g_rc, 12, 1.4, -0.25)
fruit(AP[5], g_gb, g_gm, g_gl, g_hg, g_gc, 17, 1.4, -0.25)
