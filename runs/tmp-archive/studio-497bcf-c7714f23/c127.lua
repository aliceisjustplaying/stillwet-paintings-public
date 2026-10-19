cowShade = pile{{"red earth", 0.8}, {"raw umber", 1.4}, {"green earth", 0.4}, {"bone black", 0.15}, {"lead white", 0.3}, medium=0.08}
local c1 = cows[1] * mask(function(x,y) return (y > 562 - 18*0.95 or x > 262 + 18*1.7) and 1 or 0 end)
local c3 = cows[3] * mask(function(x,y) return (y > 533 - 14*0.95 or x > 52 + 14*1.7) and 1 or 0 end)
stipple(c1, {pile=cowShade, width=1.6, coverage=2.5, pressure={0.4,0.65}, clip=cows[1], cluster=0.3})
stipple(c3, {pile=cowShade, width=1.4, coverage=2.5, pressure={0.4,0.65}, clip=cows[3], cluster=0.3})
local c2 = cows[2] * mask(function(x,y) return (y > 549 - 16.6*0.9 or x < 342 - 16.6*1.9) and 1 or 0 end)
stipple(c2, {pile=cowWhD, width=1.4, coverage=1.8, pressure={0.35,0.6}, clip=cows[2], cluster=0.3})
-- grass over the hooves
local g = brush{kind="rigger", width=0.9, point=1}
for _, c in ipairs({{262,562,18,1},{342,549,16.6,-1},{52,533,14,1}}) do
  for k = 1, 12 do
    g:load((k % 2 == 0) and gG or grM, 0.45)
    local x = c[1] + c[4] * rand(-0.1, 1.9) * c[3]
    g:stroke({{x, c[2] + 1.2}, {x + rand(-0.6, 0.6), c[2] - rand(1.2, 2.6)}}, {pressure={0.5, 0.05}})
  end
end
print(wait(0))
