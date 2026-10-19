local sl = (oakM2:grow(1.6) - oakM2:shrink(1)) * rect(314, 432, 20, 45) - foliM
work(sl, {hand="detail", pile=barkD, angle=-1.5708, coverage=3.5, fill=true, clip=true, length={3,8}})
-- boulder facets
local facet = poly({{826, 630}, {848, 636}, {860, 654}, {862, 670}, {835, 670}, {828, 652}}, false) * boulderM
work(facet, {hand="detail", pile=stoneD, angle=-1.2, coverage=3, fill=true, clip=true, length={3,8}})
local facet2 = poly({{772, 668}, {776, 650}, {790, 640}, {800, 648}, {796, 670}}, false) * boulderM
work(facet2, {hand="detail", pile=stoneMid, angle=-1.0, coverage=1.5, clip=true, length={3,8}, pressure={0.3,0.6}})
local cb = brush{kind="round", width=0.9, point=1}
cb:load(stoneD, 0.8); cb:stroke({{826, 631}, {828, 645}, {826, 657}, {829, 668}}, {pressure={cb:pressure_for(0.7), cb:pressure_for(0.3)}})
cb:load(stoneLit, 0.5); cb:stroke({{825, 632}, {812, 631}, {798, 634}}, {pressure={cb:pressure_for(0.5), cb:pressure_for(0.3)}})
for i = 1, 4 do gb[i]:reload(gpiles[i], 0.8) end
for x = 766, 868, 1.6 do
  if rand(0,1) < 0.7 then
    local k = (rand(0,1) < 0.6) and 1 or 2
    blade(k, x + randn(0, 1), 672 + rand(0, 4), rand(10, 22), -math.pi/2 + randn(0, 0.3), rand(0.7, 1.1))
  end
end
