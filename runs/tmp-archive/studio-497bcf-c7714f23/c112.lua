trous = pile{{"raw umber", 1.5}, {"bone black", 0.4}, {"smalt", 0.4}, {"lead white", 0.4}, medium=0.08}
hatp = pile{{"yellow ochre", 1.5}, {"lead white", 1.5}, {"raw umber", 0.4}, medium=0.08}
local function worker(x, yb, s, lean)
  local h = 1.75 * s
  local function P(u, v) return {x + u * s + lean * v * s, yb - v * s} end
  local legs = poly({P(-0.2,0), P(-0.17,0.85), P(0.17,0.85), P(0.2,0), P(0.06,0), P(0.01,0.6), P(-0.05,0)})
  local torso = poly({P(-0.2,0.85), P(-0.21,1.3), P(-0.12,1.45), P(0.12,1.45), P(0.21,1.3), P(0.2,0.85)}, true)
  local hc = P(0, 1.6)
  local head = ellipse(hc[1], hc[2], 0.1*s, 0.12*s)
  local hat = ellipse(hc[1], hc[2] - 0.08*s, 0.2*s, 0.06*s) + ellipse(hc[1], hc[2] - 0.12*s, 0.1*s, 0.06*s)
  work(legs, {hand="detail", pile=trous, angle=math.pi/2, coverage=3, length={1,3}, fill=true, clip=true, edge="found"})
  work(torso, {hand="detail", pile=shirt, angle=math.pi/2, coverage=3, length={1,3}, fill=true, clip=true, edge="found"})
  work(head, {hand="detail", pile=skin, coverage=3, length={1,2}, fill=true, clip=true, edge="found"})
  work(hat, {hand="detail", pile=hatp, coverage=3, length={1,2}, fill=true, clip=true, edge="found"})
  return P
end
-- man pitching from the ground, left of the wagon
local P = worker(504, 533, 11.5, 0.12)
local r = brush{kind="round", width=0.9, point=0.8}
r:load(shirt, 0.5)
r:stroke({P(0.15,1.35), P(0.35,1.5), P(0.45,1.75)}, {pressure={0.55,0.5}})
r:load(wood, 0.5)
r:stroke({P(0.1,1.0), P(0.6,2.1), P(0.9,2.8)}, {pressure={0.35,0.3}})
local ft = P(0.9,2.8)
r:stroke({ft, {ft[1] + 1.8, ft[2] - 2.5}}, {pressure={0.25,0.1}})
r:stroke({ft, {ft[1] + 0.2, ft[2] - 3.0}}, {pressure={0.25,0.1}})
-- a forkful of hay on the tines
local hayf = ellipse(ft[1] + 1.2, ft[2] - 3.5, 3.2, 2)
work(hayf:roughen(0.5, 2, 171), {hand="detail", pile=hcL, coverage=3, length={1,3}, fill=true, clip=true, edge="soft"})
-- man on top of the load, receiving
local Q = worker(538, 494.5, 11.0, -0.05)
r:load(shirt, 0.5)
r:stroke({Q(-0.15,1.35), Q(-0.35,1.45), Q(-0.5,1.3)}, {pressure={0.55,0.5}})
print(wait(0))
