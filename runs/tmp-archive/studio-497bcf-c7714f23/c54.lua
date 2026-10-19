wMid = pile{{"lead white", 2.2}, {"green earth", 2.2}, {"yellow ochre", 0.6}, {"raw umber", 0.5}, {"pale smalt", 0.6}, {"Prussian blue", 0.05}, medium=0.1}
wSh  = pile{{"green earth", 2.2}, {"raw umber", 1.2}, {"lead white", 0.9}, {"pale smalt", 0.6}, {"Prussian blue", 0.1}, medium=0.1}
wHi  = pile{{"lead white", 3}, {"green earth", 1.4}, {"yellow ochre", 0.7}, {"pale smalt", 0.5}, medium=0.1}
for i, w in ipairs(willows) do
  local kx, ky = w.x + w.lean, w.top + 1
  local H = w.s * (3.0 + 0.6 * ((i * 13) % 5) / 4)
  local Wd = H * (1.05 + 0.2 * ((i * 7) % 3) / 2)
  local pts = {{kx - 1.5, ky + 1}, {kx - Wd*0.30, ky - H*0.35}, {kx - Wd*0.5, ky - H*0.62}, {kx - Wd*0.42, ky - H*0.85},
               {kx - Wd*0.2, ky - H*0.98}, {kx, ky - H}, {kx + Wd*0.22, ky - H*0.96}, {kx + Wd*0.44, ky - H*0.82},
               {kx + Wd*0.5, ky - H*0.6}, {kx + Wd*0.3, ky - H*0.33}, {kx + 1.5, ky + 1}}
  local hm = poly(pts, true):roughen(w.s*0.25, w.s*0.8, w.seed)
  w.head = hm; w.kx = kx; w.ky = ky; w.H = H; w.Wd = Wd
  stipple(hm, {pile=wMid, width=2.4, coverage=3.5, pressure={0.4,0.7}, clip=hm, cluster=0.25})
  local sh = hm * mask(function(px, py) local u = (px - kx)/Wd*0.9 + (py - (ky - H*0.55))/H*0.8 return u > 0.12 and 1 or 0 end)
  stipple(sh, {pile=wSh, width=2.2, coverage=2.5, pressure={0.4,0.7}, clip=hm, cluster=0.35, feather=0.3})
  local hi = hm * mask(function(px, py) local u = (px - kx)/Wd*0.9 + (py - (ky - H*0.55))/H*0.8 return u < -0.22 and 1 or 0 end)
  stipple(hi, {pile=wHi, width=1.8, coverage=1.6, pressure={0.35,0.6}, clip=hm, cluster=0.5, feather=0.6})
end
print(wait(0))
