local L1, L2 = lemon1:grow(1), lemon2:grow(1) - lemon1
local function P(cx, cy, rx, ry, rot, u, v)
  local c, s = math.cos(rot), math.sin(rot)
  local x, y = u*rx, v*ry + 0.12*ry*(1-u*u)
  return {cx + c*x - s*y, cy + s*x + c*y}
end
-- olive shadow of the front lemon on the back one
local g = pile{{"raw umber",1},{"green earth",0.6},{"yellow ochre",0.8}, medium=0.8}
local b = brush("filbert", 8)
b:reload(g, 0.5)
b:stroke({{676,578},{690,586},{705,590}}, {pressure={0.5,0.3}, ramps={0.1,0.4}, clip=L2})
-- contact shadows
local cs = brush("filbert", 5)
cs:reload(kShadow, 0.7)
cs:stroke({P(610,592,78,47,-0.08,-0.55,1.0), P(610,592,78,47,-0.08,0,1.08), P(610,592,78,47,-0.08,0.6,0.98)}, {pressure={0.3,0.6}, ramps={0.3,0.2}, clip=table_top - (lemons:grow(0))})
cs:reload(kShadow, 0.7)
cs:stroke({P(722,553,68,38,0.05,-0.2,1.08), P(722,553,68,38,0.05,0.3,1.08), P(722,553,68,38,0.05,0.75,0.9)}, {pressure={0.3,0.6}, ramps={0.3,0.2}, clip=table_top - (lemons:grow(0))})
-- pores
stipple(L1, {pile=lp[3], width=2, coverage=0.12})
stipple(L2, {pile=lp[3], width=2, coverage=0.12})
-- highlights
local h = brush{kind="round", width=5, point=0.3}
local hp = pile{{"lead white",3},{"chrome yellow",0.4}}
h:reload(hp, 0.8)
h:stroke({P(610,592,78,47,-0.08,-0.45,-0.55), P(610,592,78,47,-0.08,-0.2,-0.68)}, {pressure={0.5,0.2}, ramps={0.3,0.5}, clip=L1})
h:reload(hp, 0.7)
h:stroke({P(722,553,68,38,0.05,-0.4,-0.55), P(722,553,68,38,0.05,-0.15,-0.68)}, {pressure={0.4,0.15}, ramps={0.3,0.5}, clip=L2})
local d = brush{kind="round", width=2.5, point=0.3}
d:reload(pile{{"lead white",3}}, 0.8)
d:touch(P(610,592,78,47,-0.08,-0.4,-0.58)[1], P(610,592,78,47,-0.08,-0.4,-0.58)[2], {pressure=0.6})
-- nibs: tip accents
local n = brush{kind="round", width=4, point=0.4}
n:reload(lp[2], 0.7)
n:stroke({P(610,592,78,47,-0.08,-1.0,0.02), P(610,592,78,47,-0.08,-1.07,0.05)}, {pressure={0.5,0.3}})
n:reload(lp[1], 0.7)
n:stroke({P(722,553,68,38,0.05,1.0,0.0), P(722,553,68,38,0.05,1.08,0.02)}, {pressure={0.5,0.3}})
