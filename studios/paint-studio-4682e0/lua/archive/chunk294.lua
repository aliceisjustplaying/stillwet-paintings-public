print(drying(610, 350), drying(600, 300), drying(620, 430), drying(585, 350))
local nz = noise{seed=71, period=40, octaves=3, kind="billow"}
local cx, cy, a = 596, 352, -0.55
smokeDoor = function(x, y)
  local u, v = x - cx, y - cy
  local along = u * math.cos(a) + v * math.sin(a)
  local across = -u * math.sin(a) + v * math.cos(a)
  local e = math.exp(-((along / 85)^2 + (across / 55)^2) * 1.6)
  return e * (0.55 + 0.6 * nz:at01(x, y))
end
local figure = (headF + zombieM + newArms + flaps):grow(1)
doorHaze = (rect(588, 270, 110, 200) * doorM) - figure - leafSliver
stipple(doorHaze, {pile=veilA, width=10, coverage=function(x, y) return 2.6 * smokeDoor(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}, clip=doorHaze})
local bl = doorHaze:shrink(1.5)
blend(bl, {angle=-0.55}); blend(bl, {angle=1.0})
