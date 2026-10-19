function cow(x, y, L, f, coat, lit, dark, seed, grazing)
  local function P(u, v) return {x + f*u*L, y + v*L} end
  -- boxy body, straight back, hip bone and a deep chest; head at the u>0 end
  local body = poly({P(-0.55,-0.52), P(-0.5,-0.58), P(-0.2,-0.57), P(0.2,-0.58), P(0.4,-0.56), P(0.46,-0.45), P(0.46,-0.3), P(0.3,-0.24), P(-0.1,-0.25), P(-0.45,-0.26), P(-0.56,-0.33)})
  local head
  if grazing then
    head = poly({P(0.4,-0.56), P(0.56,-0.5), P(0.66,-0.22), P(0.7,-0.08), P(0.62,-0.06), P(0.52,-0.2), P(0.44,-0.34)})
  else
    head = poly({P(0.4,-0.56), P(0.55,-0.64), P(0.68,-0.6), P(0.72,-0.47), P(0.64,-0.44), P(0.52,-0.44), P(0.44,-0.36)})
  end
  local sh = pile{{"green earth",1.5},{"raw umber",0.9},{"Prussian blue",0.3},{"yellow ochre",0.6},{"lead white",0.3}, medium=0.08}
  work(ellipse(x + f*0.18*L, y + 0.01*L, 0.6*L, 0.08*L), {hand="detail", pile=sh, tool={kind="round", width=1.4, point=0.3}, angle=0.05, coverage=2.2, fill=true, clip=true, seed=seed})
  work(body + head, {hand="detail", pile=coat, tool={kind="round", width=math.max(1,0.07*L), point=0.3}, angle=0.05, coverage=3.5, fill=true, clip=true, seed=seed+1})
  local lb = brush{kind="round", width=math.max(0.9, 0.06*L), point=0.2}
  for i,u in ipairs({-0.47, -0.38, 0.3, 0.38}) do
    lb:reload((i%2==0) and dark or coat, 0.6)
    lb:stroke({P(u, -0.3), P(u, 0.0)}, {pressure={0.9,0.75}})
  end
  -- tail
  local tb = brush{kind="rigger", width=0.6, point=1}
  tb:reload(dark, 0.5)
  tb:stroke({P(-0.55,-0.52), P(-0.6,-0.35), P(-0.59,-0.12)}, {pressure={0.4,0.3}})
  return body, head
end
local red = pile{{"red earth",1.6},{"raw umber",0.7},{"yellow ochre",0.5},{"lead white",0.35}, medium=0.05}
local redL = pile{{"red earth",0.8},{"yellow ochre",1},{"lead white",1.5}, medium=0.05}
local redD = pile{{"raw umber",1.5},{"red earth",0.7},{"bone black",0.3}, medium=0.05}
local blk = pile{{"bone black",1},{"raw umber",0.9},{"lead white",0.25}, medium=0.05}
local blkD = pile{{"bone black",1},{"raw umber",0.6}, medium=0.05}
local wh = pile{{"lead white",3},{"yellow ochre",0.2},{"raw umber",0.12}, medium=0.05}
cowA = {cow(650, 612, 20, -1, red, redL, redD, 3101, true)}
cowB = {cow(700, 612, 21, 1, blk, wh, blkD, 3111, false)}
cowC = {cow(860, 640, 23, -1, red, redL, redD, 3121, false)}
