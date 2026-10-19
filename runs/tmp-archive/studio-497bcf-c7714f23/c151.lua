-- one continuous hedge line along the rye's lower edge, from the farmyard to the elder, a bit fuller
local pts = {}
local n = noise{seed=211, period=14, octaves=3}
for x = 120, 1010, 2.5 do
  local base = 474.8 - (x - 175) * 0.0015
  local h = 3.4 + 1.6 * n(x, 3)
  pts[#pts+1] = {x, base - h}
end
local poly_pts = {{120, 477}}
for i, p in ipairs(pts) do poly_pts[#poly_pts+1] = p end
poly_pts[#poly_pts+1] = {1010, 477}
hedge2 = poly(poly_pts):roughen(0.8, 3, 212) - willow_heads - elder2:grow(1)
stipple(hedge2, {pile=hedgeD, width=1.7, coverage=4.5, pressure={0.4,0.7}, clip=hedge2, cluster=0.25})
stipple(hedge2 - hedge2:offset(-1.4), {pile=hedgeFL, width=1.2, coverage=0.9, pressure={0.3,0.5}, clip=hedge2, cluster={0.6, 5}, feather=0.6})
-- the left end: carry the farmyard shrubs into the rye's edge, hiding the cut at x~186
local joint = poly({{150,474},{152,462},{160,456},{172,452},{186,451},{198,455},{206,462},{210,474}}, true):roughen(1.5, 4, 213) - lime_sil2:shrink(1)
stipple(joint, {pile=hedgeD, width=2.2, coverage=4, pressure={0.4,0.7}, clip=joint, cluster=0.3})
stipple(joint - joint:offset(-2), {pile=tM2, width=1.6, coverage=1.0, pressure={0.35,0.55}, clip=joint, cluster={0.6,4}, feather=0.6})
print(wait(0))
