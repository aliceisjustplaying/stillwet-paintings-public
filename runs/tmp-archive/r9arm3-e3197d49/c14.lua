dry()
-- bury the post's foot: a heap of snow over the bottom, its lee side a little cooler
local base = sample(586, 618, 3)
local b = brush{kind="filbert", width=4, stiffness=0.35}
for k = 0, 4 do
  b:reload(shift(base, 0.006 * (2 - k), 0, -0.002 * k), 0.9)
  local y = 614 - k * 1.9 + rand(-0.5, 0.5)
  b:stroke({{586 + 1.5 * k + rand(-1, 1), y + 1.2}, {594, y - 1.2}, {601, y - 1.6}, {611 - 1.5 * k, y + 0.8}}, {pressure={0.6, 0.2}, ramps={0.12, 0.55}, shake=0.7})
end
-- fresh snow back on the crossbar and roof, broken, not a clean line
local sn = brush{kind="round", width=1.2, point=0.5}
sn:load("#dcd6cf", 0.8, {medium=0.1})
sn:stroke({{581, 529.0}, {587, 528.6}, {592, 528.4}}, {pressure={0.55, 0.25}, ramps={0.1, 0.5}, shake=0.7})
sn:stroke({{595.5, 528.3}, {601.5, 527.8}}, {pressure={0.5, 0.2}, ramps={0.1, 0.5}, shake=0.7})
sn:stroke({{610, 528.5}, {618, 529.0}, {626, 530.0}}, {pressure={0.5, 0.2}, ramps={0.1, 0.5}, shake=0.7})
sn:stroke({{598.5, 509.2}, {603, 504.6}, {606.2, 501.5}}, {pressure={0.55, 0.2}, ramps={0.1, 0.5}})
sn:stroke({{607.2, 501.8}, {611, 505.6}}, {pressure={0.45, 0.15}, ramps={0.1, 0.5}})
