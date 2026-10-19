-- mending: a stray curl of the hill paint at the far right (fill the hollow, cut the hook back to sky)
local fill = poly({{898, 447}, {912, 442}, {930, 441}, {940, 446}, {936, 450}, {904, 451}}, true)
work(fill, {hand="detail", tool="round 1.5", length={4, 10}, coverage=3.4, medium=0.25, angle=0, color=sample(918, 453, 2), edge="soft"})
local hook = poly({{897, 437}, {905, 434}, {920, 434}, {938, 439}, {944, 444}, {930, 441}, {910, 440}, {899, 441}}, true)
work(hook, {hand="detail", tool="round 1.5", length={4, 10}, coverage=3.4, medium=0.25, angle=0.05, color=sample(920, 428, 3), edge="soft"})
-- the far wood's skyline: bare crowns against the glow, a fringe of fine upright twig strokes
local tw = brush{kind="rigger", width=0.45, point=1}
for i = 1, 260 do
  local x = rand(0, 440)
  local top = nil
  for y = HZ - 32, HZ + 4 do if WOOD:at(x, y) > 0.5 then top = y break end end
  if top then
    if i % 8 == 1 then tw:reload(mix("#8d8790", "#a9a1a0", rand(0, 0.4)), 0.7) end
    local h = rand(2, 7)
    tw:stroke({{x, top + 2}, {x + randn(0, 0.8), top - h*0.5}, {x + randn(0, 1.4), top - h}}, {pressure={0.4, 0}, ramps={0.05, 0.7}})
  end
end
-- the willow trunks: a dark glaze to pull their speckle together
local wt = nil
for _, w in ipairs(WILLOWS) do local fy = farbank(w[1]) + 3; local m = ellipse(w[1] + w[3]*15*w[2], fy - 20*w[2], 7*w[2], 22*w[2])
  wt = wt and (wt + m) or m end
glaze(wt * mask(function(x, y) local c = sample(x, y); return (c.L < 0.5) and 1 or 0 end), {color="#2c2729", coats=0.35})
