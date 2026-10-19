function horse(x, y, L, facing, coat, lit, dark, mane, seed)
  local f = facing  -- -1 faces left, 1 faces right
  local function P(u, v) return {x + f*u*L, y + v*L} end
  local body = poly({P(0.52,-0.52), P(0.3,-0.6), P(0.0,-0.58), P(-0.28,-0.62), P(-0.42,-0.58), P(-0.58,-0.36), P(-0.72,-0.1), P(-0.78,0.0), P(-0.7,0.02), P(-0.62,-0.12), P(-0.46,-0.3), P(-0.34,-0.32), P(0.0,-0.33), P(0.36,-0.33), P(0.5,-0.38)}, true)
  local bw = brush{kind="round", width=math.max(1.0, 0.07*L), point=0.3}
  work(body, {hand="detail", pile=coat, tool={kind="round", width=math.max(1,0.08*L), point=0.3}, angle=0.05, coverage=3.5, fill=true, clip=true, seed=seed})
  -- legs
  local lb = brush{kind="round", width=math.max(0.8, 0.055*L), point=0.2}
  for i,u in ipairs({-0.34, -0.26, 0.36, 0.45}) do
    lb:reload((i%2==0) and dark or coat, 0.6)
    local du = (i==1 or i==3) and -0.02 or 0.03
    lb:stroke({P(u, -0.36), P(u+du*0.5, -0.18), P(u+du, 0.0)}, {pressure={0.9,0.7}})
  end
  -- belly and shadow side, then the lit back
  local shade = body * mask(function(px,py) return smoothstep(y-0.44*L, y-0.34*L, py) end)
  work(shade, {hand="detail", pile=dark, tool={kind="round", width=math.max(0.9,0.06*L), point=0.3}, angle=0.05, coverage=2.2, clip=true, seed=seed+1})
  local back = body * mask(function(px,py) return smoothstep(y-0.5*L, y-0.58*L, py) end)
  work(back, {hand="detail", pile=lit, tool={kind="round", width=math.max(0.8,0.05*L), point=0.3}, angle=0.05, coverage=1.8, clip=true, seed=seed+2})
  -- mane and tail
  lb:reload(mane, 0.6)
  lb:stroke({P(-0.3,-0.63), P(-0.45,-0.56), P(-0.58,-0.38)}, {pressure={0.8,0.5}})
  lb:stroke({P(0.52,-0.52), P(0.58,-0.35), P(0.57,-0.15)}, {pressure={0.8,0.3}})
  -- a soft shadow on the grass
  return body
end
local bay = pile{{"red earth",1.5},{"raw umber",1.2},{"yellow ochre",0.3},{"lead white",0.3}, medium=0.05}
local bayL = pile{{"red earth",1},{"yellow ochre",1},{"lead white",1.2},{"raw umber",0.3}, medium=0.05}
local bayD = pile{{"raw umber",1.5},{"bone black",0.5},{"red earth",0.4}, medium=0.05}
local blk = pile{{"bone black",1},{"raw umber",1}, medium=0.05}
local wht = pile{{"lead white",3},{"yellow ochre",0.2},{"raw umber",0.15},{"pale smalt",0.15}, medium=0.05}
local whtL = pile{{"lead white",4},{"yellow ochre",0.25}, medium=0.05}
local whtD = pile{{"lead white",1.5},{"raw umber",0.5},{"pale smalt",0.5},{"bone black",0.1}, medium=0.05}
local sh = pile{{"green earth",1.5},{"raw umber",0.8},{"Prussian blue",0.3},{"yellow ochre",0.6},{"lead white",0.3}, medium=0.08}
-- shadows on the grass first, to the right of each horse
work(ellipse(452, 552, 11, 1.8), {hand="detail", pile=sh, tool={kind="round", width=1.5, point=0.3}, angle=0.05, coverage=2.5, fill=true, seed=601})
work(ellipse(528, 566, 12, 2), {hand="detail", pile=sh, tool={kind="round", width=1.5, point=0.3}, angle=0.05, coverage=2.5, fill=true, seed=602})
horse(440, 552, 17, -1, bay, bayL, bayD, blk, 610)
horse(515, 566, 18, 1, wht, whtL, whtD, whtD, 620)
