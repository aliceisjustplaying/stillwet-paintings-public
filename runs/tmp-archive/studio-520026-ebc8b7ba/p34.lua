-- the bowl's shadow on the cloth: a pool thrown away from the light, plus a contact,
-- never a ring round the base
free = CLOTH - BOWL:grow(2)
work(free * (ellipse(735, 628, 215, 64):blur(56)), {hand="body", tool="filbert 15", pile=g_cm,
      length={40, 110}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.2, edge="soft"})
work(free * (ellipse(648, 604, 110, 27):blur(20)), {hand="body", tool="filbert 12", pile=g_cd,
      length={30, 80}, coverage=2.6, pressure=1, fill=true, dips={1, 1.0, 0.0}, angle=0.15, edge="soft"})
-- helpers for painting a sphere: a lighting mask from the one light, and its silhouette
function ashape(a) return ellipse(a.cx, a.cy, a.r, a.r * 0.96):soften(1.2) end
function litf(a, t0, t1)
  return mask(function(x, y)
    local u = (x - a.cx) / a.r
    local v = (y - a.cy) / (a.r * 0.96)
    local r = math.sqrt(u*u + v*v)
    if r < 1e-6 then return 1 end
    return smoothstep(t0, t1, (u * LX + v * LY) / r)
  end)
end
function hoff(a, f) return ellipse(a.cx + LX*a.r*f, a.cy + LY*a.r*f, a.r*0.34, a.r*0.27) end
