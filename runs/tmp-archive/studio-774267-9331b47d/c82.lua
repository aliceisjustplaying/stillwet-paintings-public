print(drying(150, 490), drying(100, 460), drying(200, 470))
-- the ditch: a cool transparent glaze, a little heavier toward the near left, so it sits in the meadow
local g = pile{{"pale smalt", 1}, {"smalt", 0.6}, {"raw umber", 0.35}, {"green earth", 0.3}, medium=0.6}
work(LWATER:grow(0.3), {hand="detail", tool={kind="round", width=2, point=0.3}, pile=g, angle=-0.1, coverage=1.4, load_at=function(x, y) return lerp(0.7, 0.35, clamp(x/330, 0, 1)) end, seed=8201})
-- a few bright sky glints on the water's far side
local gl = pile{{"lead white", 3}, {"yellow ochre", 0.12}, {"pale smalt", 0.2}, medium=0.1}
local b = brush{kind="round", width=0.8, point=1}
b:load(gl, 0.4)
for i=1,9 do
  local x = rand(10, 320)
  local sy, sw = STREAMY(x)
  local y = sy - sw*0.25 + rand(-0.5, 0.5)
  b:stroke({{x, y}, {x + rand(4, 12), y - 0.3}}, {pressure={0.35, 0.05}, clip=LWATER})
end
