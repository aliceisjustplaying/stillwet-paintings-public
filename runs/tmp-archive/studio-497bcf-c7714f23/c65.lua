print(wait(8*60))
tM2 = pile{{"green earth", 2.5}, {"yellow ochre", 1.2}, {"raw umber", 0.4}, {"lead white", 2.0}, {"pale smalt", 0.5}, {"chrome yellow", 0.1}, medium=0.1}
tL2 = pile{{"lead white", 3}, {"green earth", 1.5}, {"yellow ochre", 1.3}, {"chrome yellow", 0.2}, {"pale smalt", 0.3}, medium=0.1}
for ti, t in ipairs(lime_trees) do
  local lit = lime_sil2 * mask(function(x,y) local u = (x-t.cx)/t.rx*0.75 + (y-t.cy)/t.ry*0.7 local d = ((x-t.cx)/t.rx)^2 + ((y-t.cy)/t.ry)^2 return (u < 0.15 and d < 1.8) and 1 or 0 end):blur(3)
  stipple(lit, {pile=tM2, width=2.4, coverage=2.4, pressure={0.4,0.7}, clip=lime_sil2, cluster={0.5, 7}, feather=0.5})
end
-- the brightest leaf clusters: upper-left side of clumps on the lit side of each crown
local hl
for i, c in ipairs(clumps) do
  local t = lime_trees[c.t]
  local u = (c.x-t.cx)/t.rx*0.75 + (c.y-t.cy)/t.ry*0.7
  if u < -0.05 then
    local e = ellipse(c.x - c.r*0.35, c.y - c.r*0.35, c.r*0.9, c.r*0.6)
    hl = hl and (hl + e) or e
  end
end
hl = hl:roughen(1.5, 4, 83) * lime_sil2
stipple(hl, {pile=tL2, width=1.9, coverage=1.6, pressure={0.35,0.6}, clip=lime_sil2, cluster={0.5, 4}, feather=0.6})
print(wait(0))
