function off(pts, dx, dy)
  local r = {}
  for i, p in ipairs(pts) do r[i] = {p[1]+dx, p[2]+dy} end
  return r
end
cpool1 = ellipse(210, 615, 430, 200):blur(175)
cpool2 = ellipse(115, 600, 255, 120):blur(110)
cpool3 = ellipse(450, 605, 250, 125):blur(120)
-- the light on the cloth: soft glazes, so no dabs and no thin film over a dark ground
work(CLOTH * cpool1, {hand="glaze", tool="filbert 26", pile=g_cl, length={130, 300}, coverage=2.2, pressure={0.6, 0.35}, angle=0.2})
work(CLOTH * cpool2, {hand="glaze", tool="filbert 24", pile=g_cl, length={120, 280}, coverage=2.0, pressure={0.6, 0.35}, angle=0.25})
work(CLOTH * cpool3, {hand="glaze", tool="filbert 24", pile=g_cl, length={120, 280}, coverage=1.8, pressure={0.6, 0.35}, angle=0.3})
-- the far side of the cloth falls away into the dark
work(CLOTH * (ellipse(905, 690, 400, 250):blur(190)), {hand="glaze", pile=g_cd, coverage=2.4, pressure={0.6, 0.35}, angle=0.3})
work(CLOTH * (ellipse(420, 815, 620, 120):blur(90)), {hand="glaze", pile=g_cd, coverage=1.8, pressure={0.6, 0.35}, angle=0.1})
