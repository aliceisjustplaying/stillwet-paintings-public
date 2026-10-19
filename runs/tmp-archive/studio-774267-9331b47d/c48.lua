local ang = function(x, y) return lerp(0.45, 1.1, clamp((600-y)/90, 0, 1)) end
blend(NARROW:grow(0.5), {angle=ang, length={15,40}, coverage=1.5, seed=4801})
local edge = PATHM:grow(8) - NARROW:grow(0.3)
local cuts = {0, 12, 35, 70, 400}
for i=1,4 do
  local a, b = cuts[i], cuts[i+1]
  local m = edge * mask(function(x, y) local d = y - fg(x); return (d >= a and d < b) and 1 or 0 end)
  work(m, {hand="detail", tool={kind="round", width=3.2, point=0.3}, pile=FGP[i], angle=ang, angle_jitter=0.5, coverage=3.5, fill=true, seed=4810+i})
end
