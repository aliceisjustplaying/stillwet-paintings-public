-- lose the grey smear in the middle distance under a scumble of snow
local sm = poly({{490, 462}, {560, 458}, {640, 466}, {668, 484}, {650, 494}, {560, 488}, {495, 478}}, true):roughen(2, 10, 911):soften(3)
work(sm, {hand="scumble", pile=snowMid, load=0.4, pressure={0.3, 0.5}, coverage=1.5, angle=0.03, clip=true})
blend(sm:grow(3), {angle=0})
-- a far ditch with pollard willows across the middle distance
pollP = pile{{"lead white",2.5},{"smalt",1},{"red earth",0.25},{"bone black",0.35},{"raw umber",0.2}, medium=0.2}
local trunk = brush{kind="round", width=1.3, point=0.5}
local whip = brush{kind="rigger", width=0.45, point=1}
trunk:load(pollP, 0.9); whip:load(pollP, 0.7)
local xs = uneven(11, 500, 790, 0.6, 0.4, 913)
for i, x in ipairs(xs) do
  local y = lerp(484, 477, (x - 500) / 290) + randn(0, 0.5)
  local h = rand(4.5, 7.5)
  local lean = randn(0, 0.08)
  local tx, ty = x + lean * h, y - h
  trunk:stroke({{x, y}, {tx, ty}}, {pressure={0.8, 0.65}})
  trunk:touch(tx, ty, {pressure=0.8})
  for k = 1, math.random(7, 12) do
    local a = -math.pi / 2 + randn(0, 0.55)
    local L = rand(3, 7)
    whip:stroke({{tx, ty}, {tx + math.cos(a) * L * 0.5, ty + math.sin(a) * L * 0.55}, {tx + math.cos(a) * L, ty + math.sin(a) * L}}, {pressure={0.4, 0.02}})
    if k % 5 == 0 then whip:load(pollP, 0.7) end
  end
  trunk:load(pollP, 0.5)
end
-- the ditch: a faint cool line with snow on its lip
local d = brush{kind="round", width=1.2, point=0.5}
d:load(pile{{"lead white",2},{"smalt",1.2},{"bone black",0.2}, medium=0.4}, 0.4)
d:stroke({{495, 486}, {580, 484}, {690, 481}, {800, 478}}, {pressure={0.25, 0.35}, ramps={0.2, 0.3}, shake=0.4})
