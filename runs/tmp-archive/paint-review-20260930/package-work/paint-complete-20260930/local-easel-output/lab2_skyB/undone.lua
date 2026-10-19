--@ undone 1 · was chunk 3 · undone · 380 bytes

-- B2: same sitting, no wait: the two banks as masses laid INTO the open sky, no clip,
-- edges left to thin out (hug=false); the body color only (lights come next, few)
cm = clouds:blur(3)
work(cm, {hand="broad", color=cloudcol, hug=false, angle=0, angle_jitter=0.03, length={50, 180}, coverage=3.0, medium=0.35, load=0.75, pal=skypal})
print(drying(300, 205), drying(400, 455))

--@ undone 2 · was chunk 4 · undone · 175 bytes

-- B3: still open: fuse the banks into the sky with a light level blend, wider than the banks
blend(cm:grow(10):blur(8), {angle=0, coverage=1.6, length={80, 260}, hug=false})

--@ undone 3 · was chunk 3 · undone · 1164 bytes
-- B2: same sitting, no wait: each bank said in a few long level strokes of a filbert,
-- laid into the open sky (they pick it up at their edges), soft attack and release
bankc = {
  function(x) return 196 + 22*bn(x*0.6, 0) + 0.035*(x - 500) end,
  function(x) return 452 + 14*bn(x, 90) - 0.03*(x - 500) end }
local function rows(m, cfun, offs, bw, kind)
  local b = brush{kind="filbert", width=bw}
  local n = 0
  for _, off in ipairs(offs) do
    local seg = nil
    for x = -20, 1020, 6 do
      local y = cfun(x) + off
      local on = m:at(clamp(x, 0, 999), clamp(y, 0, H - 1)) > 0.35
      if on then seg = seg or {}; seg[#seg + 1] = {x + randn(0, 0.8), y + randn(0, 0.6)} end
      if (not on or x >= 1020) and seg then
        if #seg >= 4 then
          local mx = seg[#seg // 2 + 1]
          b:reload(cloudcol(mx[1], mx[2]), 0.55)
          b:stroke(seg, {pressure={0.25, 0.6, 0.55, 0.15}, ramps={0.2, 0.35}, shake=0.6})
          n = n + 1
        end
        seg = nil
      end
    end
  end
  return n
end
local n1 = rows(bank1, bankc[1], {-9, -3, 3, 9}, 6)
local n2 = rows(bank2, bankc[2], {-22, -14, -6, 2, 10, 18, 26}, 9)
print("strokes", n1, n2)

--@ undone 4 · was chunk 4 · undone · 1077 bytes

-- B3: still open: a few unequal lights laid into the wet undersides near the glow (not a layer:
-- coverage 1.1, patchy by a noise), then the bank tops lost into the sky with a light blend
local c2 = function(x) return 452 + 14*bn(x, 90) - 0.03*(x - 500) end
local c1 = function(x) return 196 + 22*bn(x*0.6, 0) + 0.035*(x - 500) end
local pn = noise{seed=41, octaves=2, period=90}
lightm = (cm * mask(function(x, y)
  local lo = y > 320 and smoothstep(c2(x) + 4, c2(x) + 14, y) or 0.6*smoothstep(c1(x) + 3, c1(x) + 10, y)
  return lo * math.exp(-((x - SUNX)/260)^2) * smoothstep(-0.1, 0.3, pn(x, y))
end)):blur(2)
work(lightm, {hand="broad", color=function(x, y) return y > 320 and "#e6bd8c" or "#c7a294" end, hug=false, angle=0,
  length={30, 90}, coverage=1.1, medium=0.35, load=0.8, pressure={0.4, 0.6}, ramps={0.3, 0.4}, pal=skypal})
topsm = (cm:grow(6) * mask(function(x, y)
  local c = y > 320 and c2(x) or c1(x)
  return 1 - smoothstep(c - 4, c + 6, y) end)):blur(5)
blend(topsm, {angle=0, coverage=1.4, length={60, 200}, hug=false})
print(lightm:area(), topsm:area())

--@ undone 5 · was chunk 4 · undone · 1062 bytes

-- B3: still open: a few unequal lights laid into the wet bottom contour of the low bank near
-- the glow (straddling its edge, patchy by a noise); the high band keeps no lights.
-- Then the bank tops lost into the sky with a light blend.
local c2 = function(x) return 452 + 14*bn(x, 90) - 0.03*(x - 500) end
local c1 = function(x) return 196 + 22*bn(x*0.6, 0) + 0.035*(x - 500) end
local pn = noise{seed=41, octaves=2, period=70}
local low = bank2:blur(3)
lightm = ((low:grow(3) - low:shrink(9)) * mask(function(x, y)
  return smoothstep(c2(x) + 2, c2(x) + 10, y) * math.exp(-((x - SUNX)/240)^2) * smoothstep(-0.05, 0.35, pn(x, y))
end)):blur(1.5)
work(lightm, {hand="broad", color="#e8c08e", hug=false, angle=0, length={25, 80}, coverage=1.6, medium=0.3,
  load=0.85, pressure={0.45, 0.65}, ramps={0.3, 0.4}, pal=skypal})
topsm = (cm:grow(6) * mask(function(x, y)
  local c = y > 320 and c2(x) or c1(x)
  return 1 - smoothstep(c - 2, c + 8, y) end)):blur(5)
blend(topsm, {angle=0, coverage=2.4, length={60, 200}, hug=false})
print(lightm:area(), topsm:area())

--@ undone 6 · was chunk 5 · undone · 791 bytes

-- B4: same sitting: the strip as one dark mass, long level strokes of thin paint, a touch of air
-- at its crest; clipped, so the crest is found against the glow
print(drying(500, 560), drying(500, 540))
stripB = function(x, y)
  local c = stripcol(x, y)
  local air = (1 - smoothstep(crest(x) + 2, crest(x) + 22, y)) * 0.22
  return mix(c, "#6e6a70", air)
end
work(land, {hand="body", color=stripB, angle=0.02, length={60, 180}, coverage=3.0, medium=0.3, load=0.8, clip=land})
-- lose the crest where it runs away from the glow: a level blend over a band across it
crestband = mask(function(x, y)
  local d = math.abs(y - crest(x))
  return (1 - smoothstep(2, 6, d)) * (1 - math.exp(-((x - SUNX)/260)^2))
end):blur(1)
blend(crestband, {angle=0, coverage=1.6, length={40, 140}, hug=false})

