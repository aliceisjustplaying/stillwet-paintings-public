print(wait(60*24*3))
local cys = {626, 618, 645, 652}
local cx = {80, 470, 318, 525}
local rx = {58, 44, 30, 26}
local gl = pile{{"lead white",6},{"smalt",0.7},{"red earth",0.3},{"yellow ochre",0.3},{"raw umber",0.25}}
local b = brush{kind="round", width=1.6, point=0.7}
for i = 1, 4 do
  b:reload(gl, 0.45)
  local x0 = cx[i] - rx[i] * rand(0.5, 0.7)
  local x1 = cx[i] + rx[i] * rand(0.2, 0.55)
  local y = cys[i] - 0.8
  b:stroke({{x0, y + rand(-0.3,0.3)}, {(x0+x1)/2, y + rand(-0.4,0.4)}, {x1, y}}, {pressure={0.5, 0.15}, ramps={0.15, 0.5}, clip=puddles[i]:shrink(0.5), shake=0.6})
end
