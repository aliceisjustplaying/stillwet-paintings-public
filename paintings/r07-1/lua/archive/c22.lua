-- bosses on the head's crown, where the rods spring: lumps pushed up over the contour
local kb = brush{kind="round", width=4.5, stiffness=0.6}
local sb = brush{kind="round", width=2.6, stiffness=0.6}
for k = 9, 20 do
  local a, b = TRUNK[k], TRUNK[k + 1]
  for j = 1, math.random(1, 3) do
    local t = rand()
    local x, y = a[1] + (b[1] - a[1]) * t, a[2] + (b[2] - a[2]) * t
    -- outward is away from the head's middle
    local ox, oy = x - 500, y - 485
    local L = math.sqrt(ox * ox + oy * oy)
    local off = rand(0.5, 3)
    local br = rand() < 0.5 and kb or sb
    br:reload(mix(BARK.body, BARK.dark, rand(0.2, 0.8)), 0.7)
    br:touch(x + ox / L * off, y + oy / L * off, {pressure=rand(0.5, 0.85), drag={ox / L * rand(0.3, 1), oy / L * rand(0.3, 1)}, twist=rand(-0.4, 0.4)})
  end
end
