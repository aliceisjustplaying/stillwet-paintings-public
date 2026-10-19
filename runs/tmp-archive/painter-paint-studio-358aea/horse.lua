function horseMask(x0, y0, s, dir, grazing)
  local function P(u, v) return {x0 + dir*u*s, y0 - v*s} end
  local body = poly({P(-0.85,1.05),P(-0.8,1.35),P(-0.5,1.48),P(0.2,1.42),P(0.6,1.48),P(0.85,1.3),P(0.8,0.95),P(0.4,0.88),P(-0.3,0.9),P(-0.75,0.92)}, true)
  local neck, head
  if grazing then
    neck = poly({P(0.55,1.45),P(0.85,1.35),P(1.1,0.9),P(1.2,0.45),P(1.05,0.4),P(0.85,0.95),P(0.6,1.05)}, true)
    head = poly({P(1.02,0.55),P(1.22,0.52),P(1.3,0.12),P(1.2,0.04),P(1.1,0.1),P(1.0,0.4)}, true)
  else
    neck = poly({P(0.5,1.4),P(0.72,1.5),P(0.95,1.85),P(1.05,2.0),P(1.15,1.9),P(0.95,1.4),P(0.85,1.1),P(0.6,1.1)}, true)
    head = poly({P(0.98,2.02),P(1.1,2.08),P(1.45,1.7),P(1.42,1.6),P(1.3,1.62),P(1.0,1.8)}, true)
  end
  local legs = ribbon({P(-0.62,1.0),P(-0.7,0.5),P(-0.66,0.05)}, 0.11*s) + ribbon({P(-0.5,1.0),P(-0.48,0.5),P(-0.52,0.05)}, 0.1*s)
             + ribbon({P(0.6,1.0),P(0.62,0.5),P(0.64,0.05)}, 0.1*s) + ribbon({P(0.48,1.0),P(0.44,0.5),P(0.4,0.05)}, 0.1*s)
  local tail = ribbon({P(-0.82,1.3),P(-0.92,0.95),P(-0.9,0.6)}, {0.14*s, 0.12*s, 0.06*s})
  return body + neck + head + legs + tail
end
HORSES = {}
local bay = pile{{"red earth",1.2},{"raw umber",1.0},{"bone black",0.25},{"lead white",0.3}, medium=0.08}
local bayL = pile{{"red earth",1},{"yellow ochre",0.6},{"raw umber",0.4},{"lead white",0.6}, medium=0.08}
local grey = pile{{"lead white",4},{"raw umber",0.3},{"pale smalt",0.3},{"yellow ochre",0.1}, medium=0.08}
local greyS = pile{{"lead white",2},{"raw umber",0.5},{"pale smalt",0.6},{"bone black",0.05}, medium=0.08}
local s = 13
local h1 = horseMask(688, 534, s, 1, true)
local h2 = horseMask(742, 531, 12.5, -1, false)
HORSES = h1 + h2
local t = {kind="round", width=1.2, point=0.5}
work(h1, {hand="detail", pile=bay, tool=t, angle=0, length={2,6}, coverage=3, clip=true, fill=true, edge="found"})
work(h1 * mask(function(x,y) return y < 534 - 1.3*s and 1 or 0 end), {hand="detail", pile=bayL, tool={kind="round", width=1.0, point=0.5}, angle=0, length={2,5}, coverage=1.2, clip=true})
work(h2, {hand="detail", pile=greyS, tool=t, angle=0, length={2,6}, coverage=3, clip=true, fill=true, edge="found"})
work(h2 * mask(function(x,y) return y < 531 - 1.12*12.5 and 1 or 0 end), {hand="detail", pile=grey, tool={kind="round", width=1.0, point=0.5}, angle=0, length={2,6}, coverage=2, clip=true, fill=true})
print(wait(0))
