treeFar = pile{{"lead white", 2}, {"smalt", 1.5}, {"green earth", 1}, {"raw umber", 1}, {"vermilion", 0.1}, medium=0.1}
townP = pile{{"lead white", 3}, {"smalt", 2}, {"vermilion", 0.3}, {"raw umber", 0.9}, medium=0.1}
-- tree lines on the far flat: bumpy crowns
local tl = nil
local function treeline(x0, x1, base, hmin, hmax, seed)
  local xs = uneven(math.floor((x1-x0)/5), x0, x1, 0.6, 0.4, seed)
  for _, x in ipairs(xs) do
    local h = rand(hmin, hmax); local r = h * rand(0.45, 0.7)
    local e = ellipse(x, base - h + r, r, h - r*0.3)
    tl = tl and (tl + e) or e
  end
  tl = tl + rect(x0, base - 3, x1 - x0, 5)
end
treeline(20, 150, 444, 5, 10, 1)
treeline(420, 600, 444, 6, 12, 2)
treeline(740, 830, 445, 5, 11, 3)
treeline(900, 990, 444, 4, 9, 4)
treeline(560, 740, 446, 4, 8, 5)
farTrees = tl:roughen(1, 3, 6)
work(farTrees, {hand="detail", pile=treeFar, coverage=3, fill=true, angle=-1.5, length={3,8}, clip=true})
-- town: church with a tall spire, a second tower, roofs
local town = poly({{612,446},{612,436},{622,430},{632,436},{640,436},{640,431},{650,425},{656,431},{661,431},{661,414},{664,412},{666,396},{668,381},{670,396},{672,412},{675,414},{675,431},{690,431},{690,428},{700,420},{700,408},{703,404},{706,408},{706,420},{716,428},{716,434},{726,434},{732,429},{738,434},{742,446}})
townM = town
work(townM, {hand="detail", pile=townP, coverage=3, fill=true, angle=-1.57, length={3,8}, clip=true})
-- poplars
local pop = nil
for _, p in ipairs({{600,446,30},{606,446,24},{748,446,26},{756,446,20},{540,446,22}}) do
  local e = poly({{p[1]-3, p[2]}, {p[1]-3.5, p[2]-p[3]*0.4}, {p[1], p[2]-p[3]}, {p[1]+3.5, p[2]-p[3]*0.4}, {p[1]+3, p[2]}}, true)
  pop = pop and (pop + e) or e
end
work(pop:roughen(0.8, 3, 9), {hand="detail", pile=treeFar, coverage=3, fill=true, angle=-1.57, length={3,8}, clip=true})
