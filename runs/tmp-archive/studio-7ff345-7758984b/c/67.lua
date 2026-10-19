-- crows: three flying in toward the oak, two sitting on its limbs
crowP = pile{{"bone black",1.5},{"raw umber",0.5},{"smalt",0.3}, medium=0.1}
local function flying(x, y, s, up, dir)
  -- body
  local b = ellipse(x, y, 2.4 * s, 0.9 * s) + ellipse(x + dir * 2.4 * s, y - 0.2 * s, 0.8 * s, 0.75 * s)
  local tail = poly({{x - dir * 1.8 * s, y - 0.5 * s}, {x - dir * 4.2 * s, y - 0.9 * s}, {x - dir * 4.4 * s, y + 0.8 * s}, {x - dir * 1.8 * s, y + 0.5 * s}})
  -- wings: bent at the wrist, fingered tips
  local wy = up and -1 or 0.6
  local w1 = poly({{x - 1.2 * s, y - 0.3 * s}, {x - 0.5 * s + dir * 1.0 * s, y + wy * 2.5 * s}, {x - dir * 1.5 * s, y + wy * 5.5 * s}, {x - dir * 2.8 * s, y + wy * 5.0 * s}, {x - dir * 1.2 * s, y + wy * 2.2 * s}, {x - dir * 1.6 * s, y + 0.3 * s}}, true)
  local w2 = poly({{x + 0.6 * s, y - 0.2 * s}, {x + dir * 2.0 * s, y + wy * 1.6 * s}, {x + dir * 1.4 * s, y + wy * 4.0 * s}, {x + dir * 0.2 * s, y + wy * 3.6 * s}, {x - dir * 0.2 * s, y + 0.2 * s}}, true)
  return b + tail + w1 + w2
end
local function perched(x, y, s, dir)
  local b = ellipse(x, y - 2.2 * s, 1.5 * s, 2.3 * s)
  local h = ellipse(x + dir * 0.9 * s, y - 4.8 * s, 1.0 * s, 0.95 * s)
  local beak = poly({{x + dir * 1.7 * s, y - 5.1 * s}, {x + dir * 3.0 * s, y - 4.8 * s}, {x + dir * 1.7 * s, y - 4.5 * s}})
  local tail = poly({{x - dir * 0.6 * s, y - 1.0 * s}, {x - dir * 2.0 * s, y + 2.4 * s}, {x - dir * 0.9 * s, y + 2.6 * s}, {x + dir * 0.4 * s, y - 0.6 * s}})
  return b + h + beak + tail
end
crowM = flying(566, 214, 1.25, true, -1) + flying(602, 236, 1.05, false, -1) + flying(528, 190, 0.9, true, -1)
      + perched(392, 296, 1.1, 1) + perched(318, 128, 1.0, -1) + perched(104, 252, 1.0, -1)
work(crowM, {hand="detail", tool={kind="round", width=1, point=0.8}, pile=crowP, load=1, pressure={0.6, 0.9}, coverage=4, fill=true, clip=true, angle=0})
-- the evening star, restated
local r = brush{kind="round", width=1.5, point=0.6}
r:load(moonP, 1)
r:touch(662, 292, {pressure=0.7})
