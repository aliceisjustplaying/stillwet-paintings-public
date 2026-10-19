wSh3 = pile{{"green earth", 2.4}, {"raw umber", 1.3}, {"lead white", 0.6}, {"pale smalt", 0.6}, {"Prussian blue", 0.15}, {"yellow ochre", 0.3}, medium=0.08}
for i, w in ipairs(willows) do
  if i > 1 then
    local hm = w.head
    local kx, ky, H, Wd = w.kx, w.ky, w.H, w.Wd
    local sh = hm * mask(function(px, py) local u = (px - kx)/Wd*0.8 + (py - (ky - H*0.5))/H*1.1 return u > 0.05 and 1 or 0 end)
    stipple(sh, {pile=wSh3, width=2.6, coverage=3.0, pressure={0.55,0.8}, clip=hm, cluster={0.4, 4}, feather=0.3, dips={8, 0.8, 0.5}})
  end
end
print(wait(0))
