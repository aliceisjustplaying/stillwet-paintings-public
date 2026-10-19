-- sitting 2. The darks of the distance first: the far range as one hazed mass, lighter and warmer toward
-- its misty foot, and its reflection pulled down under it, a little darker. The sky comes to it next, wet.
rangecol = function(x, y)
  local t = smoothstep(crest(x) + 4, HZ, y)
  local c = mix("#5d6072", "#7d7a80", t)                      -- blue-violet top, grayer and lighter at the foot
  return mix(c, "#8a7f7c", 0.25*G(x, SUNX, 200))              -- warmer where it stands in the glow
end
rangereflcol = function(x, y)
  local d = y - HZ
  return shift(rangecol(x, HZ - d/0.7), -0.03, 0, -0.01)
end
work(rangeM, {hand="body", tool="filbert 6", color=rangecol, angle=0.04, angle_jitter=0.12, length={24, 80},
  coverage=3.0, medium=0.3, load=0.8, clip=rangeM, pal=skypal})
work(rangeRefl, {hand="body", tool="filbert 6", color=rangereflcol, angle=math.pi/2, angle_jitter=0.06, length={8, 24},
  coverage=2.8, medium=0.3, load=0.8, pal=skypal, clip=rangeRefl:grow(1)})
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))
