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
