-- sitting 3: the promontory over the dry sky. 1. the wood as one dark hatched mass, near-black green, a little
-- air toward its top edge; strokes turn slowly (a wood, not rows), the edge is the strokes' own fringe
local turn = noise{seed=12, period=40}
woodCol = function(x, y)
  local top = promSky(x)
  local air = 1 - smoothstep(top, top + 70, y)
  return mix(mix("#1c211d", "#262d27", smoothstep(PWL(x) - 120, PWL(x), y)), "#4a4f55", 0.28*air)
end
local spit = mask(function(x, y) return x > 330 and 1 or 0 end):blur(6)
wood = woodM - spit
work(wood, {hand="hatch", tool="round 1.8", length={3, 8}, coverage=2.8, clip=wood:grow(1.5), hug=false,
  angle=function(x, y) return 1.57 + 0.45*turn(x, y) end, angle_jitter=0.35, color=woodCol, medium=0.2})
-- 2. the spires: needles dark, a rigger for the stem and boughs, then the few shoots that catch the sky light
for i, f in ipairs(FIRS) do
  local nd = f:needles()
  local ax = f.foot[1]
  work(nd, {hand="hatch", tool="round 1.6", length={3, 7}, coverage=2.6, clip=nd,
    angle=function(x, y) return 1.57 + 0.5*clamp((ax - x)/12, -1, 1) end, color="#1b201c", medium=0.2})
end
local rb = brush("rigger", 1.0)
for i, f in ipairs(FIRS) do
  for j, b in ipairs(f.boughs) do
    if j % 6 == 1 or b.dead then rb:reload(b.dead and "#4a4a47" or "#1a1d1a", 0.8) end
    rb:stroke(b.pts, {pressure={0.7, 0.05}, ramps={0.05, 0.6}})
  end
end
for i, f in ipairs(FIRS) do
  local hb = brush("round", math.max(0.9, f.hatch))
  f:paint(hb, {color="#161b18", lit={0, 0.6}})
  f:paint(brush("round", math.max(0.8, f.hatch*0.8)), {color="#282e2d", lit={0.75, 1}, every=8})
end
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))
