-- the near bank: snow in the evening's shadow (the light is behind it), catching the sky along its crest
drn = noise{seed=71, octaves=4, period=120, stretch={0.1, 3}}
NEAR = below(bank):roughen(1.2, 14, 7, 0.5)
function snowcol(x, y)
  local d = y - bank(x)
  local c = gradient({{0, "#c6c2c2"}, {10, "#b3b3ba"}, {40, "#a2a6b2"}, {110, "#959ba8"}, {170, "#878c99"}}, d)
  local drift = drn(x, y)
  c = shift(c, 0.03*drift, 0, -0.004*drift)
  local edge = math.max(math.abs(x - 500)/500, 0)
  return shift(c, -0.05*smoothstep(0.55, 1, edge)*smoothstep(560, 714, y), 0, -0.004)
end
work(NEAR, {hand="body", length={20, 60}, coverage=3.6, medium=0.14, color=snowcol,
  angle=function(x, y) local dx = (bank(x+6) - bank(x-6))/12; return math.atan(dx) + 0.12*drn(x*2, y) end})
