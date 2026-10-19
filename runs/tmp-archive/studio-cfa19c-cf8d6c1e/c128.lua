local keep = oakSil:shrink(1) + (cloud2M + townM4):grow(2)
local wisps = {
  {215,112,165,15,-0.03},{150,153,120,12,0.02},{105,204,95,12,0.0},{395,188,95,13,-0.02},
  {95,234,80,10,0.02},{440,250,85,14,0.01},{75,284,70,10,0.0},{455,304,95,16,0.0},
  {640,118,150,9,-0.02},{820,158,170,10,0.01},{600,205,110,8,0.0},{900,92,110,7,-0.02},{520,72,120,7,0.01}}
local Z = nil
for i,w in ipairs(wisps) do
  local cx,cy,rx,ry,t = w[1],w[2],w[3]*1.2,w[4]*2.0,w[5]
  local m = ellipse(cx, cy, rx, ry):soften(6)
  Z = Z and (Z + m) or m
end
Z = Z - keep
blend(Z, {tool={kind="badger", width=20}, angle=0.0, coverage=2.2, pressure={0.3,0.5}, seed=1401})
blend(Z, {tool={kind="badger", width=14}, angle=0.25, coverage=1.2, pressure={0.2,0.4}, seed=1402})
