wait(60*24*4)
local keep = oakSil:shrink(1) + (cloud2M + townM4):grow(2)
-- long horizontal wisps: {cx, cy, rx, ry, tilt}
local wisps = {
  {215,112,165,15,-0.03},{150,153,120,12,0.02},{105,204,95,12,0.0},{395,188,95,13,-0.02},
  {95,234,80,10,0.02},{440,250,85,14,0.01},{75,284,70,10,0.0},{455,304,95,16,0.0},
  {640,118,150,9,-0.02},{820,158,170,10,0.01},{600,205,110,8,0.0},{900,92,110,7,-0.02},{520,72,120,7,0.01}}
local function wm(w)
  local cx,cy,rx,ry,t = w[1],w[2],w[3],w[4],w[5]
  return mask(function(x,y)
    local u = (x-cx)/rx; local v = (y-cy - t*(x-cx))/ry
    local r = u*u + v*v*(1 + 0.6*u*u)
    return smoothstep(1.0, 0.45, r)
  end)
end
local function wp(y)
  if y < 140 then return pile{{"lead white",9},{"pale smalt",1.4},{"cobalt blue",0.35},{"yellow ochre",0.08}, medium=0.1}
  elseif y < 220 then return pile{{"lead white",10},{"pale smalt",1.1},{"cobalt blue",0.2},{"yellow ochre",0.12}, medium=0.1}
  elseif y < 270 then return pile{{"lead white",10},{"pale smalt",0.8},{"yellow ochre",0.2},{"vermilion",0.02}, medium=0.1}
  else return pile{{"lead white",11},{"pale smalt",0.4},{"yellow ochre",0.35},{"vermilion",0.04}, medium=0.1} end
end
for i,w in ipairs(wisps) do
  local m = wm(w) - keep
  work(m, {hand="body", pile=wp(w[2]), tool={kind="filbert", width=6}, angle=w[5], coverage=2.0, fill=true, edge="lost", pressure={0.4,0.65}, length={30,90}, seed=1320+i})
end
for i,w in ipairs(wisps) do
  local m = (wm({w[1],w[2],w[3]*1.15,w[4]*1.5,w[5]})) - keep
  blend(m, {tool={kind="badger", width=12}, angle=w[5], coverage=1.4, pressure={0.2,0.4}, seed=1340+i})
end
