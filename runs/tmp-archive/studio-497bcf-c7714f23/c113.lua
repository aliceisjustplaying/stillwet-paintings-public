cowRed = pile{{"red earth", 1.6}, {"raw umber", 0.8}, {"yellow ochre", 0.4}, {"lead white", 0.5}, medium=0.08}
cowRedD = pile{{"red earth", 1}, {"raw umber", 1.4}, {"bone black", 0.2}, {"lead white", 0.2}, medium=0.08}
cowRedL = pile{{"red earth", 1}, {"yellow ochre", 1}, {"lead white", 1.4}, medium=0.08}
cowWh = pile{{"lead white", 5}, {"yellow ochre", 0.35}, {"pale smalt", 0.3}, medium=0.08}
cowWhD = pile{{"lead white", 2}, {"pale smalt", 0.8}, {"raw umber", 0.5}, medium=0.08}
grassSh = pile{{"green earth", 2.5}, {"raw umber", 0.9}, {"yellow ochre", 0.6}, {"lead white", 0.8}, {"Prussian blue", 0.08}, medium=0.1}
function cow2(x0, y0, s, d, grazing, cols)
  local function P(u, v) return {x0 + d * u * s, y0 - v * s} end
  local head
  local body = {P(-0.02,1.36), P(0.5,1.33), P(1.1,1.33), P(1.62,1.4), P(1.78,1.36)}
  if grazing then
    for _, q in ipairs({P(2.0,1.05), P(2.22,0.6), P(2.38,0.28), P(2.47,0.12), P(2.40,0.05), P(2.28,0.12), P(2.12,0.35), P(1.95,0.6), P(1.78,0.66)}) do body[#body+1] = q end
  else
    for _, q in ipairs({P(1.98,1.4), P(2.18,1.5), P(2.42,1.34), P(2.48,1.2), P(2.35,1.12), P(2.12,1.0), P(1.9,0.78), P(1.78,0.66)}) do body[#body+1] = q end
  end
  for _, q in ipairs({P(1.5,0.62), P(0.9,0.6), P(0.42,0.62), P(0.2,0.7), P(0.02,0.82), P(-0.1,1.05), P(-0.08,1.25)}) do body[#body+1] = q end
  local bm = poly(body, true)
  local lw = 0.14 * s
  local legs = ribbon({P(0.08,0.9), P(0.12,0.45), P(0.1,0.02)}, {lw*1.4, lw*0.8, lw*0.7})
             + ribbon({P(0.26,0.8), P(0.3,0.4), P(0.33,0.03)}, {lw*1.2, lw*0.8, lw*0.7})
             + ribbon({P(1.52,0.7), P(1.52,0.35), P(1.5,0.02)}, {lw*1.1, lw*0.8, lw*0.7})
             + ribbon({P(1.66,0.7), P(1.68,0.35), P(1.7,0.04)}, {lw*1.1, lw*0.8, lw*0.7})
  local tail = ribbon({P(-0.05,1.32), P(-0.12,0.95), P(-0.12,0.45)}, {0.07*s, 0.05*s, 0.05*s}) + ellipse(P(-0.12,0.38)[1], P(-0.12,0.38)[2], 0.06*s, 0.12*s)
  local ear
  if grazing then ear = ellipse(P(2.1,0.72)[1], P(2.1,0.72)[2], 0.1*s, 0.05*s) else ear = ellipse(P(2.12,1.42)[1], P(2.12,1.42)[2], 0.12*s, 0.05*s) end
  local all = bm + legs + tail + ear
  -- shadow on the grass, falling right (sun from the left)
  local sh = ellipse(P(1.1,0)[1] + 0.35*s, y0 + 0.05*s, 1.45*s, 0.13*s)
  work(sh - all, {hand="detail", pile=grassSh, angle=0, coverage=2.2, length={2,6}, fill=true, clip=true, edge="soft", load=0.55})
  work(all, {hand="detail", pile=cols[1], angle=0, coverage=3, length={2,5}, fill=true, clip=true, edge="found"})
  -- patches
  if cols.patch then
    local pm = (ellipse(P(0.7,1.0)[1], P(0.7,1.0)[2], 0.35*s, 0.28*s) + ellipse(P(1.35,1.1)[1], P(1.35,1.1)[2], 0.2*s, 0.2*s)):roughen(0.08*s, 0.2*s, math.floor(x0)) * bm
    work(pm, {hand="detail", pile=cols.patch, coverage=3, length={1,3}, fill=true, clip=true, edge="firm"})
  end
  -- belly and far legs shadow
  local low = all * mask(function(px, py) return (py > y0 - 0.78*s) and 1 or 0 end)
  work(low, {hand="detail", pile=cols[2], angle=0, coverage=2, length={1.5,4}, fill=true, clip=all, edge="soft", load=0.6})
  -- light along the back and rump
  local r = brush{kind="round", width=math.max(0.9, 0.08*s), point=0.8}
  r:load(cols[3], 0.5)
  r:stroke({P(-0.04,1.2), P(0.02,1.32), P(0.5,1.31), P(1.1,1.31), P(1.6,1.36)}, {pressure={0.5,0.3}, ramps={0.1,0.3}})
  -- horn
  local hb = brush{kind="round", width=0.8, point=1}
  hb:load(cowWh, 0.4)
  if grazing then hb:stroke({P(2.2,0.62), P(2.3,0.7)}, {pressure={0.5,0.1}}) else hb:stroke({P(2.22,1.5), P(2.28,1.62)}, {pressure={0.5,0.1}}) end
  return all
end
cows = {}
cows[1] = cow2(262, 562, 18.0, 1, true, {cowRed, cowRedD, cowRedL})
cows[2] = cow2(342, 549, 16.6, -1, false, {cowWh, cowWhD, cowWh, patch=cowRedD})
cows[3] = cow2(52, 533, 14.0, 1, true, {cowRedD, cowRedD, cowRed})
print(wait(0))
