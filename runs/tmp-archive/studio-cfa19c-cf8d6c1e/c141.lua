wait(60*24*2)
local rng = rng_seed and rng_seed(9) 
local bY = pile{{"chrome yellow",2},{"lead white",1},{"yellow ochre",0.3}, medium=0.05}
local dW = pile{{"lead white",6},{"yellow ochre",0.1}, medium=0.05}
local cR = pile{{"vermilion",1},{"lead white",1.5},{"red earth",0.5}, medium=0.05}
local keep = trunkM:grow(2) + oakM:grow(1) + stoneM:grow(1) + figM:grow(2)
local function scatter(p, n, seed, sz)
  local b = brush{kind="round", width=3, point=0.8}
  b:load(p, 0.9)
  local cnt = 0
  math.randomseed(seed)
  for i=1,n*3 do
    local x = math.random()*1000
    local ytop = riseY(x) + 6
    local y = ytop + math.random()^0.8 * (714 - ytop)
    if y < 712 and not (keep:at(x,y) > 0.5) then
      local s = sz * (0.5 + 1.2*(y - 560)/150)
      b:touch(x, y, {pressure=clamp(0.25*s,0.1,0.8), twist=math.random(), drag={math.random()-0.5, 0}})
      cnt = cnt + 1
      if cnt % 25 == 0 then b:load(p, 0.9) end
      if cnt >= n then break end
    end
  end
end
scatter(bY, 220, 11, 1.0)
scatter(dW, 120, 12, 0.9)
scatter(cR, 45, 13, 0.9)
