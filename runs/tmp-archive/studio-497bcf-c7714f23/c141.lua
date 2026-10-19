acc = pile{{"lead white", 2}, {"pale smalt", 1.6}, {"smalt", 0.5}, {"raw umber", 0.6}, medium=0.1}
local r = brush{kind="round", width=0.9, point=0.8}
r:load(acc, 0.4)
-- belfry openings of the tall tower (x 322-331), the square tower (420-446) and the left spire's tower (262-272)
for _, s in ipairs({{324.5,381,385},{328,381,385},{264.5,393,397},{269,393,397},{424,376,382},{429,376,382},{437,376,382},{442,376,382}, {424,386,390},{429,386,390}}) do
  r:stroke({{s[1], s[2]}, {s[1], s[3]}}, {pressure={0.45,0.4}})
end
-- tall nave windows of the big church
for x = 340, 414, 9 do r:stroke({{x, 405}, {x, 412}}, {pressure={0.35,0.3}}) end
for x = 454, 500, 9 do r:stroke({{x, 408}, {x, 414}}, {pressure={0.35,0.3}}) end
-- a thin shadow line under the eaves
r:load(acc, 0.3)
r:stroke({{331,400},{420,400}}, {pressure={0.3,0.3}})
r:stroke({{446,404},{505,404}}, {pressure={0.3,0.3}})
-- mill: a door and a gallery
r:stroke({{737,430},{737,434}}, {pressure={0.4,0.4}})
r:stroke({{730,420},{744,420}}, {pressure={0.3,0.3}})
print(wait(0))
