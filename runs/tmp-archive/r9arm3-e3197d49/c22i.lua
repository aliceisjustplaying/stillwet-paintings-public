dry()
-- the drift round the oak's foot carried on to the right, where it turns from the glow and goes cool;
-- it climbs the bole unevenly, so the trunk goes into the snow, not onto it
local base = sample(372, 560, 3)
local b = brush{kind="filbert", width=6, stiffness=0.35}
for k = 0, 5 do
  local y = 557 - k * 1.3 + rand(-0.5, 0.5)
  b:reload(shift(base, 0.012 - 0.006 * k, 0.001, -0.004 * k), 0.95)
  b:stroke({{312 + rand(-4, 4) + 2 * k, y - 1.5 + 0.3 * k}, {332, y - 2.2 - 0.4 * k}, {348 + rand(-2, 2), y - 1 - 0.3 * k}, {368 - 3 * k, y + 1.5}},
    {pressure={0.65, 0.3}, ramps={0.1, 0.55}, shake=0.8})
end
local sm = brush{kind="filbert", width=3, stiffness=0.35}
sm:load(shift(base, -0.035, 0.002, -0.018), 0.8)
sm:stroke({{351, 555.5}, {358, 556.8}, {368, 559.5}}, {pressure={0.5, 0.15}, ramps={0.1, 0.6}, shake=0.8})
sm:stroke({{338, 552.5}, {346, 553.2}, {352, 555}}, {pressure={0.45, 0.15}, ramps={0.1, 0.6}, shake=0.8})
-- tiny bare trees rising out of a few far copses under the glow
local tb = brush{kind="rigger", width=0.55, point=1}
for i, x in ipairs({22, 48, 60, 168, 214, 236, 292, 402, 470}) do
  tb:reload(mix("#948d9a", "#b2a9b0", x / 520), 0.7)
  local h = rand(4, 9)
  tb:stroke({{x, 466}, {x + rand(-0.4, 0.4), 466 - h * 0.6}, {x + rand(-0.8, 0.8), 466 - h}}, {pressure={0.6, 0.0}, ramps={0, 0.8}})
end
