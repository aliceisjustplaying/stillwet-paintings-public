print(drying(628,490), drying(628,510))
wSh2 = pile{{"green earth", 2.4}, {"raw umber", 1.0}, {"lead white", 1.1}, {"pale smalt", 0.7}, {"Prussian blue", 0.08}, {"yellow ochre", 0.3}, medium=0.1}
wMid2 = pile{{"lead white", 1.8}, {"green earth", 2.2}, {"yellow ochre", 0.9}, {"raw umber", 0.4}, {"pale smalt", 0.4}, medium=0.1}
trunkG = pile{{"lead white", 1.6}, {"raw umber", 1.2}, {"pale smalt", 0.8}, {"green earth", 0.4}, medium=0.1}
for i, w in ipairs(willows) do
  if i > 1 then
    local hm = w.head
    local kx, ky, H, Wd = w.kx, w.ky, w.H, w.Wd
    -- the lower, inner part of the head in shade; right side too
    local sh = hm * mask(function(px, py) local u = (px - kx)/Wd*0.8 + (py - (ky - H*0.5))/H*1.1 return u > 0.0 and 1 or 0 end)
    stipple(sh, {pile=wSh2, width=2.0, coverage=2.2, pressure={0.4,0.65}, clip=hm, cluster={0.5, 5}, feather=0.4})
    -- mid tone clumps across the lit side so it isn't cotton
    local md = hm * mask(function(px, py) local u = (px - kx)/Wd*0.8 + (py - (ky - H*0.5))/H*1.1 return (u > -0.35 and u <= 0.1) and 1 or 0 end)
    stipple(md, {pile=wMid2, width=1.8, coverage=1.4, pressure={0.35,0.6}, clip=hm, cluster={0.6, 5}, feather=0.5})
    -- trunk re-greyed
    local tw = 0.45 * w.s
    local tb = brush{kind="round", width=math.max(1.4, tw*0.45), point=0.3}
    tb:load(trunkG, 0.6)
    tb:stroke({{w.x - tw*0.2, w.yb - 0.5}, {w.x - tw*0.15 + w.lean, w.top + 2}}, {pressure={0.6, 0.5}})
  end
end
print(wait(0))
