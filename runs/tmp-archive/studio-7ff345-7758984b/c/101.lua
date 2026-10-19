-- a limb fallen from the oak, lying in the snow downhill of it; stones by the path; a hare's track across the field
stoneP = pile{{"bone black",0.6},{"raw umber",0.8},{"smalt",0.8},{"lead white",1.2}, medium=0.15}
local b = {}
-- the fallen limb: a crooked main piece with two stubs
local lm = ribbon({{300, 474}, {318, 471}, {334, 473}, {352, 469}}, {2.0, 1.8, 1.5, 1.0})
         + ribbon({{318, 471}, {322, 464}, {327, 460}}, {1.0, 0.7, 0.3})
         + ribbon({{338, 472}, {344, 476}, {350, 478}}, {0.8, 0.6, 0.3})
fallenM = lm:roughen(0.3, 2, 1011)
work(fallenM, {hand="detail", tool={kind="round", width=1, point=0.6}, pile=barkDark, load=1, pressure={0.6, 0.9}, coverage=4, fill=true, clip=true, angle=0})
-- stones by the path, half sunk
local sm = nil
for _, s in ipairs({{384, 662, 5, 2.6}, {394, 667, 3, 1.7}, {286, 702, 7, 3.2}, {372, 690, 3.5, 1.8}, {420, 606, 2.4, 1.2}}) do
  local e = ellipse(s[1], s[2], s[3], s[4]) * above(function(x) return s[2] + s[4] * 0.45 end)
  sm = sm and (sm + e) or e
end
stoneM = sm:roughen(0.4, 2, 1013)
work(stoneM, {hand="detail", tool={kind="round", width=1.2, point=0.6}, pile=stoneP, load=1, pressure={0.6, 0.9}, coverage=4, fill=true, clip=true, angle=0.4, angle_jitter=0.6})
-- hare track: pairs of long hind prints ahead of two small fore prints, bounding from the knoll toward the spruces
local tm = nil
local x, y = 520, 505
for i = 1, 16 do
  local s = 0.45 + (y - 490) / 90
  local f = {ellipse(x, y, 0.5 * s, 0.35 * s), ellipse(x + 1.5 * s, y + 0.8 * s, 0.5 * s, 0.35 * s),
             ellipse(x + 4 * s, y - 0.5 * s, 0.9 * s, 0.4 * s), ellipse(x + 4 * s, y + 1.1 * s, 0.9 * s, 0.4 * s)}
  for _, e in ipairs(f) do tm = tm and (tm + e) or e end
  x, y = x + rand(14, 20), y + rand(-0.6, 1.4)
end
hareM = tm
work(hareM, {hand="detail", tool={kind="round", width=0.8, point=0.6}, pile=fpP, load=0.6, pressure={0.4, 0.6}, coverage=2.5, fill=true, clip=true, angle=0})
