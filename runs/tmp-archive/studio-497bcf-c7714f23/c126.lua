print(drying(681,600), drying(697,590), drying(280,550))
bonnet = pile{{"raw umber", 1.5}, {"bone black", 0.6}, {"smalt", 0.3}, {"lead white", 0.35}, medium=0.08}
local wx = 681
local bm = ellipse(wx, 576.8, 3.1, 3.2) + ellipse(wx, 579.6, 2.4, 1.2)
work(bm, {hand="detail", pile=bonnet, coverage=3, length={1,3}, fill=true, clip=true, edge="found"})
-- red shawl across the shoulders and down the back as a triangle
local sh = poly({{wx-4.6,581.8},{wx+4.6,581.8},{wx+3.9,584.5},{wx+0.3,591.5},{wx-3.9,584.5}}, true)
work(sh, {hand="detail", pile=shawl, angle=math.pi/2, coverage=3, length={1,3}, fill=true, clip=true, edge="found"})
-- a light edge on the bonnet brim and the shawl's lit left side
local r = brush{kind="round", width=0.8, point=1}
r:load(pile{{"vermilion", 1}, {"lead white", 1}, {"yellow ochre", 0.3}}, 0.35)
r:stroke({{wx-4.4,582.3},{wx-3.6,585},{wx-1.5,588.5}}, {pressure={0.4,0.2}})
-- cast shadows of the pair falling right along the crest
local cs = ellipse(708, 612.6, 14, 1.6) + ellipse(690, 612.8, 12, 1.5)
work(cs - figs, {hand="detail", pile=sD, angle=0, coverage=2.2, length={2,6}, fill=true, clip=true, edge="soft", load=0.6})
-- a few grass blades in front of their feet
local g = brush{kind="rigger", width=1.0, point=1}
for k = 1, 16 do
  g:load((k % 3 == 0) and grM or grD, 0.5)
  local x = rand(670, 706)
  g:stroke({{x, 615}, {x + rand(-1, 1), 612 - rand(0, 2)}, {x + rand(-1.5, 1.5), 608 - rand(0, 3)}}, {pressure={0.6, 0.05}, ramps={0.05,0.7}})
end
print(wait(0))
