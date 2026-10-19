stoneGl = pile{{"raw umber", 1.5}, {"bone black", 0.8}, {"green earth", 0.3}, medium=0.6}
local face = boulderM * mask(function(x, y) return (y > 638 + math.abs(x - 815) * 0.08) and 1 or 0 end)
work(face, {hand="detail", pile=stoneGl, angle=-0.2, coverage=2.5, fill=true, clip=true, length={4,12}, pressure={0.4, 0.8}})
local deep = boulderM * mask(function(x, y) return (y > 655) and 1 or 0 end)
work(deep, {hand="detail", pile=stoneD, angle=0, coverage=2.5, fill=true, clip=true, length={4,12}})
-- cracks
local cb = brush{kind="round", width=0.9, point=1}
cb:load(stoneD, 0.8); cb:stroke({{800, 634}, {803, 645}, {799, 656}, {802, 667}}, {pressure={cb:pressure_for(0.6), cb:pressure_for(0.3)}})
cb:load(stoneD, 0.8); cb:stroke({{832, 638}, {838, 648}, {836, 660}}, {pressure={cb:pressure_for(0.5), cb:pressure_for(0.25)}})
-- lichen spots on the upper surface
stipple(boulderM * rect(780, 628, 70, 14), {pile=lichenP, width=1.3, coverage=0.25, cluster={0.7, 3}, pressure={0.2, 0.5}, seed=981})
-- grass across the base
local k = 0
for x = 764, 868, rand(1.2, 2.4) do
  local y = 668 + randn(0, 1.5) + ((x > 850) and -3 or 0)
  for j = 1, math.random(2, 4) do
    local kk = (rand(0,1) < 0.7) and 1 or 2
    blade(kk, x + randn(0, 1), y + rand(0, 3), rand(6, 16), -math.pi/2 + randn(0, 0.3), rand(0.7, 1.1))
  end
end
