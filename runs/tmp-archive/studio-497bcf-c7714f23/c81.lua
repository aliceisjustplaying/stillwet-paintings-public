cowR = pile{{"red earth", 1.5}, {"raw umber", 1.2}, {"lead white", 0.6}, {"yellow ochre", 0.3}, medium=0.08}
cowW = pile{{"lead white", 5}, {"yellow ochre", 0.3}, {"pale smalt", 0.3}, medium=0.08}
cowB = pile{{"bone black", 1}, {"raw umber", 1}, {"lead white", 0.4}, medium=0.08}
cowSh = pile{{"green earth", 2}, {"raw umber", 1.2}, {"lead white", 0.6}, {"Prussian blue", 0.1}, medium=0.1}
function cow(x, yb, s, d, pile_, grazing, patch)
  local L = 1.7 * s
  local bt, bb = yb - 1.3*s, yb - 0.62*s
  local x0, x1 = x, x + L*d
  local function X(u) return x + u*L*d end
  local body = poly({{X(0.02), bb}, {X(0), bt + 0.12*s}, {X(0.08), bt}, {X(0.45), bt + 0.06*s}, {X(0.85), bt - 0.03*s}, {X(1.0), bt + 0.1*s}, {X(1.02), bb - 0.05*s}, {X(0.7), bb + 0.08*s}, {X(0.3), bb + 0.06*s}})
  local lw = math.max(0.9, 0.16*s)
  local legs = rect(math.min(X(0.08), X(0.08)+lw*d), bb - 1, lw, yb - bb + 1) + rect(math.min(X(0.2), X(0.2)+lw*d), bb - 1, lw, yb - bb + 0.6)
             + rect(math.min(X(0.8), X(0.8)+lw*d), bb - 1, lw, yb - bb + 1) + rect(math.min(X(0.92), X(0.92)+lw*d), bb - 1, lw, yb - bb + 0.6)
  local head
  if grazing then
    head = poly({{X(0.95), bt + 0.1*s}, {X(1.12), bt + 0.35*s}, {X(1.28), yb - 0.15*s}, {X(1.2), yb}, {X(1.08), yb - 0.25*s}, {X(0.97), bb - 0.2*s}})
  else
    head = poly({{X(0.95), bt + 0.05*s}, {X(1.12), bt - 0.25*s}, {X(1.3), bt - 0.05*s}, {X(1.33), bt + 0.35*s}, {X(1.2), bt + 0.4*s}, {X(1.0), bb - 0.15*s}})
  end
  local tail = ribbon({{X(0.0), bt + 0.1*s}, {X(-0.05), bb}, {X(-0.04), yb - 0.3*s}}, {0.5, 0.4, 0.5})
  local shadowm = ellipse(X(0.55), yb + 0.2, L*0.65, math.max(0.8, 0.14*s))
  work(shadowm, {hand="detail", pile=cowSh, angle=0, coverage=2, length={2,5}, fill=true, clip=true, edge="soft", load=0.5})
  work(body + head + legs + tail, {hand="detail", pile=pile_, angle=0, coverage=3, length={1.5,5}, fill=true, clip=true, edge="found"})
  if patch then
    local pm = (ellipse(X(0.35), bt + 0.35*s, 0.25*L, 0.28*s) + ellipse(X(0.8), bt + 0.25*s, 0.12*L, 0.22*s)):roughen(0.5, 2, 5) * body
    work(pm, {hand="detail", pile=patch, coverage=3, length={1,3}, fill=true, clip=true, edge="firm"})
  end
end
cow(292, 497, 6.2, 1, cowR, true)
cow(338, 493, 5.8, -1, cowB, true, cowW)
cow(372, 501, 6.6, 1, cowR, false)
cow(262, 505, 6.8, -1, cowW, true, cowR)
print(wait(0))
