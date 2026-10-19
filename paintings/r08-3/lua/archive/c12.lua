dry()
-- the foot of each tree: the trunk carried down into the snow, then a few short strokes of snow across it
local tb = brush{kind="round", width=1.4, point=0.4}
for _, f in ipairs(firs) do
  tb:reload("#26221f", 0.8)
  tb:stroke({{f.foot[1] + rand(-0.3, 0.3), f.crown_base - 4}, {f.foot[1], f.foot[2] + 2}}, {pressure={0.7, 0.8}})
end
local sb = brush{kind="filbert", width=3}
local feet = {{176, 444, 30}}
for _, f in ipairs(firs) do feet[#feet+1] = {f.foot[1], f.foot[2], 12} end
for i, ft in ipairs(feet) do
  local x, y, r = ft[1], ft[2], ft[3]
  for k = 1, (i == 1 and 14 or 3) do
    local yy = y - 4 + k * 1.6 + rand(-0.8, 0.8)
    local x0 = x - r * rand(0.5, 0.9); local x1 = x + r * rand(0.5, 0.9)
    local c = sample(x0 - 6, yy + 2, 2):mix(sample(x1 + 6, yy + 2, 2), 0.5)
    sb:reload(c, 0.75)
    local sl = (bankY(x1) - bankY(x0)) / (x1 - x0)
    local ym = yy + sl * (0.5 * (x0 + x1) - x)
    sb:stroke({{x0, yy + sl * (x0 - x)}, {0.5 * (x0 + x1), ym - rand(0.5, 1.5)}, {x1, yy + sl * (x1 - x)}},
      {pressure={0.4, 0.7}, ramps={0.25, 0.35}, shake=0.4})
  end
end
for k = 1, 6 do
  local yy = 452 + k * 2.2 + rand(-0.6, 0.6)
  local x0, x1 = 146 + rand(-3, 3), 196 + rand(-3, 3)
  sb:reload(sample(x0 - 5, yy, 2):mix(sample(x1 + 5, yy, 2), 0.5), 0.8)
  sb:stroke({{x0, yy - 3}, {0.5 * (x0 + x1), yy + 0.3}, {x1, yy + 4}}, {pressure={0.5, 0.7}, ramps={0.25, 0.35}, shake=0.4})
end
