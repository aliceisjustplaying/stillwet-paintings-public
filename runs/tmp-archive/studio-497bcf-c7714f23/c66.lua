tS = pile{{"green earth", 2.5}, {"raw umber", 0.9}, {"lead white", 1.4}, {"pale smalt", 0.9}, {"Prussian blue", 0.1}, {"yellow ochre", 0.4}, medium=0.1}
local sh
for i, c in ipairs(clumps) do
  local t = lime_trees[c.t]
  local u = (c.x-t.cx)/t.rx*0.75 + (c.y-t.cy)/t.ry*0.7
  if u < 0.3 then
    local e = ellipse(c.x + c.r*0.3, c.y + c.r*0.55, c.r*1.1, c.r*0.55)
    sh = sh and (sh + e) or e
  end
end
sh = sh:roughen(1.6, 4, 84) * lime_sil2
stipple(sh, {pile=tS, width=2.0, coverage=2.2, pressure={0.35,0.65}, clip=lime_sil2, cluster={0.5, 5}, feather=0.5})
-- break the long diagonal between light and shadow sides with a scatter of mid touches across it
for ti, t in ipairs(lime_trees) do
  local band = lime_sil2 * mask(function(x,y) local u = (x-t.cx)/t.rx*0.75 + (y-t.cy)/t.ry*0.7 local d = ((x-t.cx)/t.rx)^2 + ((y-t.cy)/t.ry)^2 return (math.abs(u - 0.15) < 0.18 and d < 1.8) and 1 or 0 end)
  stipple(band, {pile=tS, width=2.2, coverage=1.0, pressure={0.35,0.6}, clip=lime_sil2, cluster={0.7, 6}, feather=0.7})
end
print(wait(0))
