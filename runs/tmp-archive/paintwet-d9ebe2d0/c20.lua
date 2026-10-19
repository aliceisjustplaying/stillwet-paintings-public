-- Friedrich's advice to Carus: a dark glaze over the whole picture except the moon, growing darker toward the
-- edges. A smooth elliptical falloff centered on the glow's reflection, transparent, light.
rest(16)
local vig = mask(function(x, y)
  local dx, dy = (x - 610)/640, (y - 440)/470
  return smoothstep(0.45, 1.25, math.sqrt(dx*dx + dy*dy)) end) * (-moonM)
glaze(vig, {color="#22232b", coats=0.32, pigment="transparent"})
