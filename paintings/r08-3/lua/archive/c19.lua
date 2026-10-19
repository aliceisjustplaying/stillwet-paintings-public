-- the snow's own relief: soft drifts running across the slope, their lee sides in blue shade
local dn = noise{seed=151, period=150, octaves=4, stretch={-0.12, 3.5}, warp={120, 20}}
local lee = mask(function(x, y)
  local by = bankY(x)
  if y < by + 8 then return 0 end
  local v = dn(x, y)
  return smoothstep(0.05, 0.4, v) * smoothstep(by + 8, by + 40, y)
end)
glaze(lee:blur(3), {color="#8288a6", coats=0.2})
