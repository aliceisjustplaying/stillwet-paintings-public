wMid3 = pile{{"lead white", 1.2}, {"green earth", 2.2}, {"yellow ochre", 0.7}, {"raw umber", 0.6}, {"pale smalt", 0.5}, medium=0.08}
for i, w in ipairs(willows) do
  if i > 1 then
    local hm = w.head
    local kx, ky, H, Wd = w.kx, w.ky, w.H, w.Wd
    local band = hm * mask(function(px, py) local u = (px - kx)/Wd*0.8 + (py - (ky - H*0.5))/H*1.1 return math.abs(u - 0.05) < 0.22 and 1 or 0 end)
    stipple(band, {pile=wMid3, width=2.2, coverage=1.6, pressure={0.45,0.7}, clip=hm, cluster={0.7, 4}, feather=0.4, dips={8, 0.7, 0.5}})
    -- a few dark sprays poking into the light side and light sprays into the shadow
    local sp = brush{kind="round", width=1.3, point=0.9}
    for k = 1, 5 do
      local a = -math.pi/2 + rand(-0.8, 0.2)
      local L = H * rand(0.35, 0.7)
      sp:load(wSh3, 0.5)
      sp:stroke({{kx + L*0.45*math.cos(a), ky + L*0.45*math.sin(a)}, {kx + L*math.cos(a), ky + L*math.sin(a)}}, {pressure={0.6, 0.1}, clip=hm})
    end
  end
end
print(wait(0))
