local bp = pile{{"raw umber", 0.8}, {"bone black", 0.4}, {"pale smalt", 0.5}, {"lead white", 0.4}, medium=0.1}
local b = brush{kind="round", width=0.7, point=1, stiffness=0.4}
local birds = {{452, 262, 4.2, 0.1}, {466, 256, 3.6, -0.2}, {478, 266, 3.2, 0.3}, {491, 259, 3.4, 0}, {437, 271, 2.8, 0.2}, {503, 268, 2.6, -0.1}, {515, 253, 2.2, 0.15}}
for i,bd in ipairs(birds) do
  local x, y, s, tilt = bd[1], bd[2], bd[3], bd[4]
  b:load(bp, 0.35)
  local up = (i % 2 == 0) and -0.55 or 0.15
  b:stroke({{x - s, y + s*up + tilt*s}, {x - s*0.45, y - s*0.25}, {x, y}}, {pressure={0.05, 0.45}, ramps={0.5, 0.1}})
  b:stroke({{x, y}, {x + s*0.45, y - s*0.25}, {x + s, y + s*up - tilt*s}}, {pressure={0.45, 0.05}, ramps={0.1, 0.5}})
end
