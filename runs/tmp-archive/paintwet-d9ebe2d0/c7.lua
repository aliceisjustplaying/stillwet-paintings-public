-- the cloud bank into the open sky: one long low bank above the glow that thins and parts over it,
-- and one thin high wisp; unclipped, few long strokes; then warm lights on the bank's underside
-- toward the glow, and its top lost into the sky.
bn = noise{seed=9, octaves=5, period=240, stretch={0, 5}}
bn2 = noise{seed=23, octaves=4, period=120, stretch={0, 4}}
band = function(y, c, th) return 1 - smoothstep(0.5*th, th, math.abs(y - c)) end
c_low = function(x) return 300 + 12*bn(x, 90) - 0.05*(x - 600) end
c_high = function(x) return 196 + 16*bn(x*0.6, 0) + 0.03*(x - 600) end
bankLow = mask(function(x, y)
  local th = (26 + 14*bn2(x, 300)) * (1 - 0.8*G(x, SUNX + 30, 70)) * smoothstep(320, 440, x)
  return band(y, c_low(x) + 6*bn2(x, y*0.5), th) * (0.55 + 0.45*smoothstep(-0.5, 0.1, bn2(x*1.3, 500)))
end):blur(1.5) - promM
bankHigh = mask(function(x, y)
  local th = 9 * smoothstep(-0.1, 0.4, bn2(x, 40)) * smoothstep(440, 560, x)
  return band(y, c_high(x), th)
end):blur(1.5)
cloudcol = function(x, y)
  local high = y < 250
  local body = high and "#6a6c80" or "#6f6a7a"
  local under = high and "#a58f92" or "#cdb096"
  local c = high and c_high(x) or c_low(x)
  local lit = smoothstep(c - 4, c + 16, y) * (0.3 + 0.7*G(x, SUNX, 300))
  return mix(body, under, lit)
end
cm = (bankLow + bankHigh):blur(3)
work(cm, {hand="broad", color=cloudcol, hug=false, angle=-0.03, angle_jitter=0.02, curve={0, 0}, length={90, 260},
  coverage=2.2, medium=0.32, load=0.9, pressure={0.45, 0.7}, ramps={0.25, 0.35}, pal=skypal})
local pn = noise{seed=44, octaves=2, period=150, stretch={0, 3}}
local low = bankLow:blur(3)
lightm = ((low:grow(4) - low:shrink(10)) * mask(function(x, y)
  return smoothstep(c_low(x) - 2, c_low(x) + 8, y) * G(x, SUNX, 360) * smoothstep(-0.2, 0.2, pn(x, 0))
end)):blur(2)
work(lightm, {hand="broad", color=function(x, y) return mix("#bfa99c", "#e2c9a0", G(x, SUNX, 200)) end,
  hug=false, angle=-0.03, length={60, 170}, coverage=1.2, medium=0.3, load=0.9, pressure={0.35, 0.5}, ramps={0.35, 0.4}, pal=skypal})
topsm = (cm:grow(6) * mask(function(x, y)
  local c = y > 250 and c_low(x) or c_high(x)
  return 1 - smoothstep(c - 2, c + 8, y) end)):blur(5)
blend(topsm, {angle=0, coverage=2.4, length={60, 200}, hug=false})
local t = timesheet() print(string.format("%.0f min this sitting; bank %.0f lights %.0f", t.sitting, cm:area(), lightm:area()))
