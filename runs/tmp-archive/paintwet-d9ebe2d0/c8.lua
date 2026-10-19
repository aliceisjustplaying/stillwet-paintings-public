-- the firs of the promontory (geometry only): spires standing along the wooded skyline, poking above it by
-- varying amounts, smaller toward the spit; a lopsided few, one tall one, one broken top
local xs = uneven(15, 4, 344, 0.6, 0.5, 11)
FIRS = {}
for i, x in ipairs(xs) do
  local sky = promSky(x)
  local slope = smoothstep(0, 344, x)
  local h = lerp(150, 58, slope) * rand(0.75, 1.2)
  if i == 5 then h = h * 1.35 end
  local poke = rand(14, 48) * lerp(1, 0.55, slope)
  local top = sky - poke
  local habit = (i == 9 or i == 3) and "old" or "spire"
  local foot = math.min(top + h, PWL(x) - 6); h = foot - top
  local f = fir{x=x + rand(-4, 4), y=foot, height=h, width=h * rand(0.2, 0.3), habit=habit, seed=100 + i}
  FIRS[#FIRS + 1] = f
end
firM = FIRS[1]:mask()
for i = 2, #FIRS do firM = firM + FIRS[i]:mask() end
woodTop = outline{pts=PROM, open=true, char="soft", lobe=12, amount=0.8, seed=31}
woodM = woodTop:below(H) * mask(function(x, y) return y < PWL(x) + 1 and 1 or 0 end)
landM = woodM + firM                                         -- everything of the promontory above the water
-- its mirror in the lake about the waterline, shortened (we look down a little)
reflM = mask(function(x, y)
  if x > 460 then return 0 end
  local wl = PWL(x); if y <= wl then return 0 end
  return landM:at(x, wl - (y - wl)/0.78) end):soften(1)
print(#FIRS, firM:area(), woodM:area(), reflM:area())

-- the lake, same sitting (the promontory's firs grown first as geometry, for their reflection). 1. the promontory's reflection as one dark mass pulled DOWN (the wood mirrored:
-- darkest at the waterline, a little cooler and lighter toward its far end)
promReflCol = function(x, y)
  local d = (y - PWL(x)) / 230
  return mix("#22251f", "#343a3c", smoothstep(0.1, 1, d))
end
work(reflM, {hand="body", tool="filbert 6", color=promReflCol, angle=math.pi/2, angle_jitter=0.05, length={12, 40},
  coverage=2.8, medium=0.3, load=0.85, clip=reflM:grow(2)})
-- 2. the open water around the reflections: the sky mirrored (the bank too), darker toward me, in long level
-- strokes, fenced softly by its own region grown a few units
wn = noise{seed=41, octaves=3, period=200, stretch={0, 8}}
waterCol = function(x, y)
  local d = y - HZ
  local ym = HZ - 1.05*d - 3
  local c = skyB(x, math.max(ym, 5))
  local k = cm:at(x, clamp(ym, 1, H - 1))
  if k > 0.02 then c = mix(c, cloudcol(x, ym), 0.7*k) end
  c = mix(c, "#434856", 0.5*smoothstep(HZ + 20, 660, y))
  local v = wn(x, y)
  return shift(c, 0.012*v, 0, 0.004*v)
end
openW = waterM - reflM - rangeRefl
work(openW, {hand="broad", color=waterCol, angle=0, angle_jitter=0.004, curve={0, 0}, length={120, 320},
  coverage=3.8, medium=0.3, load=0.75, pal=skypal, clip=openW:grow(3):blur(2)})
-- 3. fuse the reflections level, fenced to the water so the promontory stays
blend((reflM:grow(8) + rangeRefl:grow(4)) * waterM, {angle=0, angle_jitter=0.004, length={40, 160}, coverage=2.4, clip=waterM})
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))
