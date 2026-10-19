-- a small flock grazing in the left meadow, with the shepherd and his dog
sheep = {}
local pos = {{66,499},{74,502.5},{83,498.5},{90,503},{97,500},{104,505},{112,501},{121,506.5},{128,502},{140,504.5},{86,508},{151,507},{160,503.5}}
local shM, bodyM, headM = nil, nil, nil
for i, p in ipairs(pos) do
  local x, y = p[1] + rand(-1,1), p[2] + rand(-0.6,0.6)
  local dir = (rand(0,1) < 0.5) and -1 or 1
  local sc = 0.85 + (y - 495) * 0.02
  local b = ellipse(x, y, 1.9*sc, 1.05*sc)
  local h = ellipse(x + dir*2.1*sc, y + 0.5*sc, 0.65*sc, 0.55*sc)
  local s = ellipse(x + 1.3*sc, y + 1.0*sc, 2.4*sc, 0.55*sc)
  sheep[#sheep+1] = {x, y, dir, sc}
  bodyM = bodyM and (bodyM + b) or b
  headM = headM and (headM + h) or h
  shM = shM and (shM + s) or s
end
sheepBody, sheepHead, sheepShadow = bodyM, headM, shM
local gsh = pile{{"Prussian blue",0.5},{"raw umber",1},{"green earth",0.8},{"yellow ochre",0.6},{"lead white",0.4}, medium=0.15}
work(shM - bodyM - headM, {hand="detail", pile=gsh, tool={kind="round", width=0.8, point=0.4}, angle=0, coverage=2, fill=true, clip=true, pressure={0.35,0.6}, seed=3801})
local wool = pile{{"lead white",4},{"yellow ochre",0.5},{"raw umber",0.15},{"pale smalt",0.1}, medium=0.05}
work(bodyM, {hand="detail", pile=wool, tool={kind="round", width=0.9, point=0.4}, angle=0, coverage=3.5, fill=true, clip=true, pressure={0.45,0.7}, seed=3802})
local hd = pile{{"raw umber",1},{"bone black",0.4},{"lead white",0.4}, medium=0.05}
work(headM, {hand="detail", pile=hd, tool={kind="round", width=0.7, point=0.4}, angle=0, coverage=3, fill=true, clip=true, pressure={0.4,0.6}, seed=3803})
