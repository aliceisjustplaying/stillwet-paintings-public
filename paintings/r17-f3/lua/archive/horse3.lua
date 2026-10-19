local bay = pile{{"red earth",1.2},{"raw umber",1.0},{"bone black",0.3},{"lead white",0.3}, medium=0.08}
local bayL = pile{{"red earth",1},{"yellow ochre",0.7},{"raw umber",0.4},{"lead white",0.7}, medium=0.08}
local blk = pile{{"bone black",1},{"raw umber",0.6},{"lead white",0.25},{"pale smalt",0.2}, medium=0.08}
local blkL = pile{{"bone black",0.5},{"raw umber",0.5},{"lead white",0.9},{"pale smalt",0.4}, medium=0.08}
local function P2(x0,y0,s,dir) return function(u,v) return {x0 + dir*u*s, y0 - v*s} end end
function horse2(x0, y0, s, dir, grazing)
  local P = P2(x0,y0,s,dir)
  local body = poly({P(-0.85,1.02),P(-0.84,1.3),P(-0.55,1.45),P(0.1,1.38),P(0.55,1.47),P(0.85,1.3),P(0.83,0.98),P(0.45,0.84),P(-0.3,0.86),P(-0.75,0.9)}, true)
  local neck, head
  if grazing then
    neck = poly({P(0.5,1.45),P(0.82,1.4),P(1.05,1.0),P(1.18,0.5),P(1.02,0.45),P(0.85,0.92),P(0.62,1.0)}, true)
    head = poly({P(1.0,0.58),P(1.2,0.55),P(1.3,0.14),P(1.2,0.06),P(1.08,0.12),P(0.98,0.42)}, true)
  else
    neck = poly({P(0.45,1.42),P(0.72,1.62),P(0.92,1.92),P(1.1,2.0),P(1.1,1.62),P(0.95,1.2),P(0.8,0.98),P(0.5,0.95)}, true)
    head = poly({P(0.98,1.98),P(1.12,2.06),P(1.47,1.68),P(1.43,1.56),P(1.28,1.58),P(1.0,1.74)}, true)
  end
  local legs = ribbon({P(-0.64,1.0),P(-0.72,0.5),P(-0.68,0.04)}, 0.1*s) + ribbon({P(-0.48,0.95),P(-0.45,0.5),P(-0.5,0.04)}, 0.09*s)
             + ribbon({P(0.6,0.95),P(0.62,0.5),P(0.64,0.04)}, 0.09*s) + ribbon({P(0.46,0.95),P(0.42,0.5),P(0.38,0.04)}, 0.09*s)
  local tail = ribbon({P(-0.83,1.28),P(-0.93,0.95),P(-0.9,0.55)}, {0.12*s, 0.11*s, 0.05*s})
  return body + neck + head + legs + tail, P
end
local h1, P1 = horse2(772, 503, 19, 1, true)
local h2, P2b = horse2(838, 501.5, 17.5, -1, false)
HORSES2 = h1 + h2
local t = {kind="round", width=1.4, point=0.5}
work(h1, {hand="detail", pile=bay, tool=t, angle=0, length={3,8}, coverage=3, clip=true, fill=true, edge="found"})
work(h1 * mask(function(x,y) return y < 503 - 1.2*19 and 1 or 0 end), {hand="detail", pile=bayL, tool={kind="round", width=1.1, point=0.5}, angle=0, length={3,7}, coverage=1.3, clip=true})
work(h2, {hand="detail", pile=blk, tool=t, angle=0, length={3,8}, coverage=3, clip=true, fill=true, edge="found"})
work(h2 * mask(function(x,y) return y < 501.5 - 1.25*17.5 and 1 or 0 end), {hand="detail", pile=blkL, tool={kind="round", width=1.0, point=0.5}, angle=0, length={3,7}, coverage=1.0, clip=true})
-- manes, tails, hooves
local dark = pile{{"bone black",1},{"raw umber",0.5},{"lead white",0.15}, medium=0.08}
local r = brush{kind="rigger", width=1.0, point=1}
r:load(dark, 0.6)
r:stroke({P1(0.55,1.47),P1(0.83,1.4),P1(1.05,1.0),P1(1.16,0.55)}, {pressure={0.7,0.3}})
r:stroke({P1(-0.84,1.3),P1(-0.95,0.95),P1(-0.9,0.5)}, {pressure={0.8,0.2}})
r:reload(dark, 0.6)
r:stroke({P2b(0.72,1.62),P2b(0.92,1.92),P2b(1.08,2.02)}, {pressure={0.7,0.4}})
-- blaze on the bay's face
local w = brush{kind="round", width=0.8, point=0.6}
w:load(pile{{"lead white",3},{"yellow ochre",0.2}}, 0.4)
w:stroke({P1(1.15,0.5),P1(1.22,0.2)}, {pressure={0.5,0.3}})
print(wait(0))
