-- break the scalloped lip: irregular tongues of snow lower in places, stone restated in others
local tongues = nil
local xs = uneven(9, 282, 428, 0.8, 0.5, 151)
for i, x in ipairs(xs) do
  local base = 366 + (math.abs(x - 350) / 80)^2 * 10
  local w = rand(5, 14); local d = rand(2.5, 7)
  local p = poly({{x - w/2, base - 3}, {x - w*0.3, base + d*0.7}, {x + randn(0,1.5), base + d}, {x + w*0.35, base + d*0.6}, {x + w/2, base - 3}}, true)
  tongues = tongues and (tongues + p) or p
end
tongues = tongues:roughen(0.6, 2.5, 152)
work(tongues * cap2:mask(), {hand="detail", pile=snowSide2, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=0, tool={kind="round", width=1.4}})
-- the stone restated along some stretches just under the lip, to break the line
local r = brush{kind="round", width=2.2, point=1}
r:load(stoneDark, 0.7)
for i = 1, 7 do
  local x = rand(290, 420)
  local base = 368 + (math.abs(x - 350) / 80)^2 * 10
  r:stroke({{x, base + 2.5}, {x + rand(4, 9), base + 2.2 + randn(0, 0.8)}}, {pressure={0.55, 0.4}})
end
-- a few grains of granite catching light on the front face of the slab
stipple(cap2:mask() * below({{260,378},{440,378}}) * above({{260,392},{440,392}}), {pile=stoneMid, width=1.4, coverage=0.35, pressure={0.3,0.5}, cluster=0.5})
