-- the far shore mirrored in the still water: the wood's height turned down, darker than the water, lost below
local sn = noise{seed=81, period=40, stretch={0, 6}}
reflM = mask(function(x, y)
  if y < HZ + 2 then return 0 end
  -- the height of the far land at x, found on its mask
  local top = HZ + 3
  for yy = 420, HZ + 3, 1 do if farM:at(x, yy) > 0.5 then top = yy; break end end
  local depth = (HZ + 3 - top) * 0.9 + 2.5
  return 1 - smoothstep(HZ + 2 + depth * 0.6, HZ + 2 + depth * (1.1 + 0.3 * sn(x, y)), y)
end)
glaze(reflM:blur(1.2), {color="#4a4552", coats=0.55, pigment="transparent"})
