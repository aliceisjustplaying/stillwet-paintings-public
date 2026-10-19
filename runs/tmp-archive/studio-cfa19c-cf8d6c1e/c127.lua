local keep = oakSil:shrink(1) + (cloud2M + townM4):grow(2)
local wisps = {
  {215,112,165,15,-0.03},{150,153,120,12,0.02},{105,204,95,12,0.0},{395,188,95,13,-0.02},
  {95,234,80,10,0.02},{440,250,85,14,0.01},{75,284,70,10,0.0},{455,304,95,16,0.0},
  {640,118,150,9,-0.02},{820,158,170,10,0.01},{600,205,110,8,0.0},{900,92,110,7,-0.02},{520,72,120,7,0.01}}
local function wm(w, k)
  local cx,cy,rx,ry,t = w[1],w[2],w[3]*k,w[4]*k,w[5]
  return mask(function(x,y)
    local u = (x-cx)/rx; local v = (y-cy - t*(x-cx))/ry
    local r = u*u + v*v*(1 + 0.6*u*u)
    return smoothstep(1.0, 0.3, r)
  end)
end
local function bp(y)
  if y < 140 then return pile{{"lead white",3},{"cobalt blue",1.6},{"smalt",1.3},{"pale smalt",0.4},{"raw umber",0.06}, medium=0.2}
  elseif y < 220 then return pile{{"lead white",4},{"cobalt blue",1.3},{"smalt",1.0},{"pale smalt",0.6},{"raw umber",0.06}, medium=0.2}
  elseif y < 270 then return pile{{"lead white",5},{"pale smalt",1.2},{"cobalt blue",0.7},{"smalt",0.4},{"yellow ochre",0.1}, medium=0.2}
  else return pile{{"lead white",7},{"pale smalt",0.8},{"cobalt blue",0.2},{"yellow ochre",0.35},{"vermilion",0.03}, medium=0.2} end
end
for i,w in ipairs(wisps) do
  work(wm(w,1.05) - keep, {hand="scumble", pile=bp(w[2]), tool={kind="filbert", width=8}, angle=w[5], coverage=1.6, load=0.6, edge="lost", pressure={0.35,0.6}, seed=1360+i})
end
for i,w in ipairs(wisps) do
  blend(wm(w,1.3) - keep, {tool={kind="badger", width=16}, angle=w[5], coverage=2.0, pressure={0.25,0.45}, seed=1380+i})
end
