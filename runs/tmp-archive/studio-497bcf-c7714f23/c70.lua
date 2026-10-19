wBody = pile{{"lead white", 4}, {"pale smalt", 1.6}, {"cobalt blue", 0.3}, {"raw umber", 0.25}, {"green earth", 0.3}, medium=0.1}
wRefl = pile{{"green earth", 2}, {"raw umber", 1}, {"lead white", 1.2}, {"pale smalt", 0.6}, medium=0.1}
wGlint = pile{{"lead white", 8}, {"pale smalt", 0.6}, {"yellow ochre", 0.12}, medium=0.1}
local rv = river2:shrink(0.4)
work(rv, {hand="detail", pile=wBody, angle=0, coverage=2.4, length={5,14}, fill=true, clip=true, edge="found"})
-- reflection of the far bank at the upper edge of each reach
local top = {} local tw = {}
for i,p in ipairs(near_pts) do top[i] = {p[1], p[2] - near_w[i]*0.36}; tw[i] = near_w[i]*0.28 end
local refl = ribbon(top, tw) * rv
work(refl, {hand="detail", pile=wRefl, angle=0, coverage=1.8, length={3,9}, fill=true, clip=true, edge="soft", load=0.5})
-- a few pale glints across the broad near reach
local g = brush{kind="round", width=1.6, point=0.6}
g:load(wGlint, 0.5)
for k, s in ipairs({{12,578,40},{70,573,25},{120,568,30},{175,561,20},{212,552,14}}) do
  g:stroke({{s[1], s[2]}, {s[1] + s[3], s[2] - s[3]*0.08}}, {pressure={0.35,0.1}, ramps={0.2,0.5}, clip=rv})
end
print(wait(0))
