local sil
for i, c in ipairs(clumps) do
  local e = ellipse(c.x, c.y, c.r * 1.55, c.r * 1.2)
  sil = sil and (sil + e) or e
end
lime_sil2 = (sil:roughen(2.4, 5, 82) + lime_sil) * above({{0,472},{1000,472}})
-- trunks and limbs first, dark grey-brown, visible later in the gaps
local rb = brush{kind="round", width=3.2, point=0.6}
for ti, t in ipairs(lime_trees) do
  rb:load(brD, 0.7)
  rb:stroke({{t.bx, t.by}, {t.bx + 0.5, (t.by + t.fy)/2}, {t.fx, t.fy}}, {pressure={0.95, 0.8}})
  for li, l in ipairs(t.limbpts) do
    if li % 3 == 0 then rb:load(brD, 0.6) end
    rb:stroke(l, {pressure={0.55, 0.05}, ramps={0.02, 0.5}})
  end
end
-- dark foliage mass
stipple(lime_sil2, {pile=tD, width=2.6, coverage=3.2, pressure={0.4,0.7}, clip=lime_sil2, cluster=0.3})
print(lime_sil2:area(), wait(0))
