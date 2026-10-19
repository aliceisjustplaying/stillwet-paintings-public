-- the two apples' shadows on the cloth, thrown away from the light and joined to
-- the bowl's own shadow so the light reads as one family
for _, a in ipairs{AP[4], AP[5]} do
  work(CLOTH * (ellipse(a.cx + a.r*0.62, a.cy + a.r*0.42, a.r*1.25, a.r*0.55):blur(a.r*0.5)),
       {hand="body", tool="filbert 15", pile=g_cm, length={40, 110}, coverage=2.4, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
  work(CLOTH * (ellipse(a.cx + a.r*0.34, a.cy + a.r*0.72, a.r*0.8, a.r*0.26):blur(a.r*0.16)),
       {hand="body", tool="filbert 12", pile=g_cd, length={30, 80}, coverage=2.6, pressure=1,
        fill=true, dips={1, 1.0, 0.0}, edge="soft"})
end
fruit(AP[4], g_rb, g_rm, g_rl, g_hl, g_rc, 12)
fruit(AP[5], g_gb, g_gm, g_gl, g_hg, g_gc, 17)
