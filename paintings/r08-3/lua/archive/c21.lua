-- deepen the oak against the dawn: a dark umber glaze over its wood, heavier low and on the left
local wd = oak:wood(1.0):grow(0.4) * above(function(x) return 431 + (x - 158) * 0.5 end)
glaze(wd * mask(function(x, y) return 0.6 + 0.4 * smoothstep(100, 440, y) end), {color="#2a2320", coats=0.35})
-- bark: furrows down the trunk, broken, with a few pale lichen touches on the shaded side
local tr = oak:wood(7)
local fb = brush{kind="round", width=0.9, point=0.8}
for i = 1, 70 do
  local x = rand(150, 196); local y = rand(338, 446)
  if tr:at(x, y) > 0.8 and tr:at(x, y - 8) > 0.8 then
    if i % 6 == 1 then fb:reload(mix("#1c1917", "#2a2522", rand()), 0.8) end
    local l = rand(5, 14)
    fb:stroke({{x, y}, {x + rand(-0.8, 0.8), y - l * 0.5}, {x + rand(-1.2, 1.2), y - l}}, {pressure={0.5, 0.1}, ramps={0.2, 0.5}, shake=0.5, clip=tr})
  end
end
-- bury the foot properly: short opaque snow touches along a lumpy drift line against the trunk
local sb = brush{kind="filbert", width=2.4}
for i = 1, 40 do
  local x = rand(150, 200)
  local top = 432.5 + (x - 158) * 0.5 + 2 * math.sin(x / 4) + rand(-1, 1)
  sb:reload(mix("#cfcfd1", "#c3c4cb", rand()), 1.0)
  local y = top + rand(-1, 7)
  sb:stroke({{x - rand(3, 6), y + 1}, {x, y - 0.5}, {x + rand(3, 6), y + 2.5}}, {pressure={0.8, 0.6}, ramps={0.2, 0.3}, shake=0.3})
end
