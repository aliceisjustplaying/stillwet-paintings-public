local avoid = (MAN + WOMAN):grow(2) + BOULD:grow(1)
local stalk = pile{{"green earth", 1.4}, {"yellow ochre", 0.7}, {"raw umber", 0.4}, medium=0.1}
local wh = pile{{"lead white", 2.2}, {"yellow ochre", 0.12}, medium=0.08}
local ye = pile{{"chrome yellow", 1}, {"yellow ochre", 0.4}, {"lead white", 0.4}, medium=0.08}
local bl = pile{{"cobalt blue", 1}, {"smalt", 0.5}, {"lead white", 0.4}, medium=0.08}
local rd = pile{{"vermilion", 0.5}, {"red earth", 0.3}, {"lead white", 1}, medium=0.08}
local st = brush{kind="round", width=0.6, point=1}
local tip = brush{kind="round", width=1.2, point=0.5}
local function flower(x, y, h, p, r, n)
  if avoid:at(x, y) > 0.2 then return end
  st:load(stalk, 0.4)
  local tx, ty = x + rand(-1, 1)*h*0.15, y - h
  st:stroke({{x, y}, {(x + tx)/2 + rand(-0.4, 0.4), (y + ty)/2}, {tx, ty}}, {pressure={0.35, 0.15}})
  tip:load(p, 0.5)
  for k=1,n do tip:touch(tx + randn(0, r*0.5), ty + randn(0, r*0.3), {pressure=clamp(r*0.35, 0.15, 0.7)}) end
end
for i=1,70 do local x = rand(0, 1000); local y = rand(fg(x) + 50, 645); local d = clamp((y - 560)/90, 0.2, 1); flower(x, y, 6*d*rand(0.7, 1.4), wh, 1.2*d + 0.4, 3) end
for i=1,55 do local x = rand(0, 1000); local y = rand(fg(x) + 45, 645); local d = clamp((y - 560)/90, 0.2, 1); flower(x, y, 4*d*rand(0.7, 1.4), ye, 0.9*d + 0.3, 1) end
for i=1,14 do local x = rand(0, 700); local y = rand(590, 645); local d = clamp((y - 560)/90, 0.2, 1); flower(x, y, 7*d*rand(0.8, 1.3), bl, 1*d + 0.4, 2) end
for i=1,22 do local x = rand(0, 1000); local y = rand(fg(x) + 50, 645); local d = clamp((y - 560)/90, 0.2, 1); flower(x, y, 4*d*rand(0.7, 1.3), rd, 1*d + 0.3, 2) end
-- seed-headed grass stalks, taller, near the bottom and around the stone
local seedp = pile{{"yellow ochre", 1}, {"raw umber", 0.4}, {"lead white", 0.3}, medium=0.08}
for i=1,40 do
  local x = (i <= 12) and rand(720, 990) or rand(0, 700)
  local y = (i <= 12) and rand(618, 645) or rand(605, 648)
  if avoid:at(x, y) < 0.2 then
    local h = rand(14, 30)
    local lean = rand(-0.25, 0.25)
    local tx, ty = x + h*math.sin(lean), y - h*math.cos(lean)
    st:load(stalk, 0.45)
    st:stroke({{x, y}, {(x + tx)/2 + lean*3, (y + ty)/2}, {tx, ty}}, {pressure={0.4, 0.1}})
    tip:load(seedp, 0.4)
    tip:stroke({{tx - 0.2*math.sin(lean)*3, ty + 3}, {tx, ty}, {tx + math.sin(lean)*2, ty - 2.5}}, {pressure={0.45, 0.05}})
  end
end
