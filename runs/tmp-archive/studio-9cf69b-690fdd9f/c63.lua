straw = pile{{"yellow ochre",1.5},{"lead white",1.1},{"raw umber",0.45},{"red earth",0.1}, medium=0.12}
local piles = {grassP, grassD, straw}
local centers = {{40,680},{120,660},{175,640},{250,690},{95,612},{230,612},{330,700},{400,655},{470,610},{860,690},{930,650},{985,700},{780,640},{700,600},{900,590},{620,660},{520,700},{300,590},{40,560},{820,540},{960,540},{430,560},{650,530}}
local n = 0
for ci, c in ipairs(centers) do
  local k = math.random(2, 6)
  for j = 1, k do
    local y = c[2] + randn(0, 6)
    local sc = (y - 470) / 3.4
    local x = c[1] + randn(0, sc*0.9)
    -- keep off the footpath
    local h = 0.42 * sc * rand(0.6, 1.3)
    local stalks = math.floor(5 + h * 0.5 + math.random(0, 4))
    grassClump(x, y, h, stalks, piles[math.random(1, 3)], math.random() < 0.5)
    n = n + 1
  end
end
print(n)
