rutD = pile{{"raw umber", 1.5}, {"yellow ochre", 1.0}, {"lead white", 0.6}, {"red earth", 0.15}, {"green earth", 0.4}, medium=0.1}
trackL = pile{{"yellow ochre", 2}, {"lead white", 2.2}, {"raw umber", 0.5}, {"red earth", 0.12}, medium=0.1}
-- ruts: two lines following the track, converging with distance
local function side(k)
  local pts = {}
  for i, p in ipairs(path_c) do pts[i] = {p[1] + k * path_w[i] * 0.28 * (-0.45), p[2] + k * path_w[i] * 0.28} end
  return pts
end
local r = brush{kind="round", width=3.5, point=0.6}
for _, k in ipairs({-1, 1}) do
  local pts = side(k)
  r:load(rutD, 0.7)
  r:stroke({table.unpack(pts, 1, 4)}, {pressure={0.75,0.5}, ramps={0.02,0.05}, shake=0.6, clip=path_m})
  r:load(rutD, 0.5)
  r:stroke({table.unpack(pts, 4, 8)}, {pressure={0.45,0.15}, ramps={0.02,0.3}, shake=0.5, clip=path_m})
end
-- grassy crown down the middle
local mid = {}
for i, p in ipairs(path_c) do mid[i] = {p[1], p[2]} end
local crown = ribbon(mid, {12,9,7,5,4,3,2,1.5}):roughen(1, 4, 131) * path_m
work(crown, {hand="hatch", pile=grM, tool={kind="round", width=1.5, point=1}, angle=-math.pi/2, length={3,8}, coverage=1.2, pressure={0.45,0.75}, ramps={0.05,0.7}, clip=crown:grow(1)})
-- light on the track's sunny far edge? it's in shade: just a few paler pebbles and a dry crust near the viewer
stipple(path_m * mask(function(x,y) return y > 660 and 1 or 0 end) - crown, {pile=trackL, width=1.4, coverage=0.25, pressure={0.3,0.6}, cluster=0.5})
-- grass encroaching over the track edges
local edges = path_m:rim(4, 1) 
work(edges * path_m, {hand="hatch", pile=grD, tool={kind="round", width=1.6, point=1}, angle=-math.pi/2, length={4,10}, coverage=0.8, pressure={0.45,0.75}, ramps={0.05,0.7}})
print(wait(0))
