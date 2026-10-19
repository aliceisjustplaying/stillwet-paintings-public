local trees = {{crownA, 52, 425, 48, 40}, {crownB, 115, 415, 42, 48}, {crownC, 166, 442, 28, 24}}
local holes = ellipse(24,423,4,3) + ellipse(88,402,3.5,3) + ellipse(145,398,3,4) + ellipse(62,392,3,2.5) + ellipse(178,436,3,2.5) + ellipse(122,432,3,2.5)
local crownsF = (crownA + crownB + crownC) * above({{0,478},{1000,478}})
-- fill the punched holes back in with the mid tone
stipple(holes:grow(1.5) * crownsF, {pile=tM, width=2.5, coverage=4, pressure={0.4,0.7}, clip=crownsF})
for i, t in ipairs(trees) do
  local m, cx, cy, rx, ry = t[1] * crownsF, t[2], t[3], t[4], t[5]
  local midm = m * mask(function(x,y) local u = (x-cx)/rx*0.7 + (y-cy)/ry*0.75 return u < 0.35 and 1 or 0 end):blur(4)
  stipple(midm, {pile=tM, width=2.8, coverage=3.0, pressure={0.4,0.7}, clip=m, cluster=0.4, feather=0.4})
end
print(wait(0))
